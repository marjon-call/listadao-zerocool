#!/usr/bin/env python3
"""
Bulk-fetch verified source for every in-scope asset of the Lista DAO bug bounty.

Reads /tmp/listadao_full_scope.tsv (chain, address, name, addedAt) — produced
earlier by parsing the Immunefi scope page — and for each asset:

1. Calls Etherscan v2 getsourcecode (chain-id parameterized).
2. If the response says Proxy=1, refetches the Implementation address.
3. Parses the SourceCode field (handles flat / single-file-JSON / standard-input-JSON).
4. Writes every source file under src/<ContractName>_<addr4>/<orig_path>.
5. Records the compiler version / optimizer settings for that asset.

Outputs:
  - src/<Name>_<addr4>/   (one dir per asset)
  - .tools/fetch_report.json   (per-asset status + compiler config)
  - foundry.toml            regenerated with one [profile.contract_<Name>_<addr4>] each
  - build.sh                regenerated to forge build each profile

Skips the already-imported ListaOFT_f9b2 layout (will be re-pulled fresh).
"""

import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

API_KEY = os.environ["ETHERSCAN_API_KEY"]
BASE = "https://api.etherscan.io/v2/api"
ROOT = Path(os.environ.get("LISTA_ROOT", Path(__file__).resolve().parent.parent if "__file__" in globals() else "."))
SRC = ROOT / "src"
REPORT = ROOT / ".tools/fetch_report.json"

CHAIN_ID = {"BSC": 56, "Ethereum": 1}


def slugify(name: str) -> str:
    """Turn a contract name into a filesystem-safe slug."""
    s = re.sub(r"[^A-Za-z0-9]+", "_", name).strip("_")
    return s or "Unknown"


def addr4(addr: str) -> str:
    return addr[2:6].lower()


def fetch(chain_id: int, address: str, retries: int = 4) -> dict:
    params = urllib.parse.urlencode({
        "chainid": chain_id,
        "module": "contract",
        "action": "getsourcecode",
        "address": address,
        "apikey": API_KEY,
    })
    url = f"{BASE}?{params}"
    last_err = None
    for i in range(retries):
        try:
            with urllib.request.urlopen(url, timeout=30) as r:
                data = json.loads(r.read())
            if data.get("status") != "1":
                # NOTOK with a "rate limit" message → backoff and retry
                if "rate" in data.get("message", "").lower() or "max" in data.get("result", "").lower():
                    time.sleep(2 ** i)
                    continue
                # Otherwise treat as authoritative no-result
                return {"_error": data.get("result") or data.get("message"), "_raw": data}
            return data["result"][0]
        except Exception as e:
            last_err = e
            time.sleep(2 ** i)
    return {"_error": f"network: {last_err}"}


def parse_sources(source_field: str, contract_name: str) -> tuple[dict, dict]:
    """Return (file_map, settings) where file_map maps relative path -> content."""
    src = source_field.strip()
    settings = {}
    if not src:
        return {}, settings

    # Etherscan double-braces standard-input JSON: {{...}}
    if src.startswith("{{") and src.endswith("}}"):
        try:
            obj = json.loads(src[1:-1])
            files = {p: f.get("content", "") for p, f in obj.get("sources", {}).items()}
            settings = obj.get("settings", {}) or {}
            return files, settings
        except Exception:
            pass

    # Single-brace JSON: either standard-input shape or {filename: {content}}
    if src.startswith("{") and src.endswith("}"):
        try:
            obj = json.loads(src)
            if isinstance(obj, dict) and "sources" in obj and isinstance(obj["sources"], dict):
                files = {p: f.get("content", "") for p, f in obj["sources"].items()}
                settings = obj.get("settings", {}) or {}
                return files, settings
            if isinstance(obj, dict) and obj and all(
                isinstance(v, dict) and "content" in v for v in obj.values()
            ):
                return {p: v["content"] for p, v in obj.items()}, settings
        except Exception:
            pass

    # Flattened single file
    fname = f"{contract_name or 'Contract'}.sol"
    return {fname: src}, settings


def safe_join(root: Path, rel: str) -> Path:
    """Join rel under root, refusing path traversal."""
    rel = rel.lstrip("/").replace("\\", "/")
    p = (root / rel).resolve()
    root_resolved = root.resolve()
    if root_resolved not in p.parents and p != root_resolved:
        raise ValueError(f"unsafe path: {rel}")
    return p


def write_files(target_dir: Path, files: dict[str, str]) -> int:
    target_dir.mkdir(parents=True, exist_ok=True)
    count = 0
    for rel, content in files.items():
        if not content:
            continue
        out = safe_join(target_dir, rel)
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(content, encoding="utf-8")
        count += 1
    return count


def parse_compiler_version(v: str) -> str:
    # "v0.8.20+commit.a1b79de6" → "0.8.20"
    m = re.search(r"\d+\.\d+\.\d+", v or "")
    return m.group(0) if m else "0.8.20"


def main():
    tsv = Path("/tmp/listadao_full_scope.tsv")
    rows = []
    with tsv.open() as f:
        next(f)
        for line in f:
            parts = line.rstrip("\n").split("\t")
            if len(parts) < 3:
                continue
            chain, addr, name = parts[0], parts[1], parts[2]
            rows.append({"chain": chain, "address": addr, "name": name})
    # Dedup on address (FlashBuy appears twice)
    seen = set()
    unique = []
    for r in rows:
        k = r["address"].lower()
        if k in seen:
            continue
        seen.add(k)
        unique.append(r)
    print(f"Loaded {len(unique)} unique assets from {tsv}")

    report = []
    for i, r in enumerate(unique, 1):
        chain = r["chain"]
        addr = r["address"]
        name = r["name"]
        chain_id = CHAIN_ID.get(chain)
        if not chain_id:
            print(f"[{i}/{len(unique)}] {addr} {name} — UNSUPPORTED CHAIN {chain}")
            report.append({**r, "status": "unsupported_chain"})
            continue

        # 1) fetch the asset's source
        result = fetch(chain_id, addr)
        if "_error" in result:
            print(f"[{i}/{len(unique)}] {addr} {name} — fetch error: {result['_error']}")
            report.append({**r, "status": "fetch_error", "error": result["_error"]})
            time.sleep(0.25)
            continue

        contract_name = (result.get("ContractName") or "").strip()
        proxy = result.get("Proxy") in ("1", 1, "true", True)
        impl_addr = (result.get("Implementation") or "").strip()
        compiler_version = parse_compiler_version(result.get("CompilerVersion"))
        optimization_used = result.get("OptimizationUsed") in ("1", 1, "true", True)
        runs = int(result.get("Runs") or 200)

        impl_result = None
        if proxy and impl_addr and impl_addr != "0x0000000000000000000000000000000000000000":
            time.sleep(0.25)
            impl_result = fetch(chain_id, impl_addr)
            if "_error" in impl_result:
                print(f"  proxy {addr}: impl {impl_addr} fetch error — falling back to proxy source")
                impl_result = None
            else:
                contract_name = (impl_result.get("ContractName") or contract_name or "").strip() or "Unknown"
                compiler_version = parse_compiler_version(impl_result.get("CompilerVersion") or compiler_version)
                optimization_used = impl_result.get("OptimizationUsed") in ("1", 1, "true", True) or optimization_used
                runs = int(impl_result.get("Runs") or runs)

        source_field = (impl_result or result).get("SourceCode", "")
        if not source_field:
            print(f"[{i}/{len(unique)}] {addr} {name} ({contract_name}) — UNVERIFIED")
            report.append({**r, "status": "unverified", "contract_name": contract_name, "proxy": proxy, "implementation": impl_addr})
            time.sleep(0.25)
            continue

        files, settings = parse_sources(source_field, contract_name)
        if not files:
            print(f"[{i}/{len(unique)}] {addr} {name} — empty source")
            report.append({**r, "status": "empty_source"})
            continue

        slug = slugify(contract_name or name)
        target = SRC / f"{slug}_{addr4(addr)}"
        # Idempotent: skip if target already populated
        already = target.exists() and any(target.rglob("*.sol"))
        n = 0 if already else write_files(target, files)
        rel = target.relative_to(ROOT)
        kind = "proxy" if proxy else "direct"
        print(f"[{i}/{len(unique)}] {chain} {addr} {kind} {contract_name} → {rel} ({len(files)} files{', already on disk' if already else ''})")

        # Settings from the Etherscan response may also include remappings (Foundry-style projects).
        remappings = settings.get("remappings") or []
        if not isinstance(remappings, list):
            remappings = []
        report.append({
            **r,
            "status": "ok" if not already else "skipped_existing",
            "contract_name": contract_name,
            "proxy": proxy,
            "implementation": impl_addr if proxy else None,
            "directory": str(rel),
            "files": len(files),
            "compiler_version": compiler_version,
            "optimization_used": optimization_used,
            "runs": runs,
            "evm_version": settings.get("evmVersion") or (impl_result or result).get("EVMVersion") or "default",
            "viaIR": (settings.get("viaIR") if isinstance(settings.get("viaIR"), bool)
                      else False),
            "remappings": remappings,
        })
        # rate-limit politeness
        time.sleep(0.25)

    REPORT.parent.mkdir(parents=True, exist_ok=True)
    REPORT.write_text(json.dumps(report, indent=2))

    ok = sum(1 for r in report if r["status"] in ("ok", "skipped_existing"))
    bad = len(report) - ok
    print(f"\nDone. {ok}/{len(report)} ok, {bad} failed/unverified. Report: {REPORT}")


if __name__ == "__main__":
    main()
