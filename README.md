# Lista DAO Security Review

Full Immunefi-scope prep for the
[Lista DAO bug bounty](https://immunefi.com/bug-bounty/listadao/) — 132 unique
in-scope contracts (131 BSC + 1 Ethereum), pulled directly from BscScan and
Etherscan via their verified-source API. The Immunefi Instascope feature was
broken at the time of this prep, so source was fetched manually with proxy →
implementation auto-resolution.

## Layout

```
src/<Name>_<addr4>/    # one dir per in-scope contract; verified-source bytes preserved
   contracts/...       # protocol code
   @openzeppelin/...   # vendored deps as shipped by the verification submission
   @layerzerolabs/...
   ...                 # other deps (chainlink, pyth, solady, hardhat, etc.) vary per contract
test/PoC.t.sol         # fork test harness (default profile, solc 0.8.20)
lib/forge-std/         # test framework
foundry.toml           # one [profile.contract_<Name>_<addr4>] per in-scope contract
build.sh               # builds every profile
nexus.makefile         # Nexus harness entrypoint
nexus.scope.md         # 651 in-scope source paths (one per line, parser-safe)
nexus.oos.md           # out-of-scope rules (Immunefi default + program-specific)
poc.md                 # researcher guide
.tools/                # bulk_fetch.py, gen_foundry.py, fetch_report.json
docs/                  # crawled Lista DAO documentation (101 pages)
```

Each contract has its own Foundry profile because the scope mixes 5 distinct
solc versions (0.8.4, 0.8.10, 0.8.20, 0.8.24, 0.8.28) with different optimizer
runs, evm versions, viaIR flags, and remappings.

## Building & testing

```bash
# Build every in-scope contract
./build.sh

# Or via the Nexus harness (writes nexus_build_result.yaml)
make -f nexus.makefile build

# Build a single contract
FOUNDRY_PROFILE=contract_ListaOFT_f9b2 forge build

# Run the PoC test
export MAINNET_RPC_URL=<your-eth-mainnet-rpc>
forge test --match-contract PoCTest -vvv
```

## Notes

- **Proxy resolution.** When a scope address points to `TransparentUpgradeableProxy`
  (or other ERC1967 proxy), `.tools/bulk_fetch.py` reads the `Implementation`
  field from Etherscan and pulls *that* source. The directory keeps the proxy's
  `addr4` so the on-chain target is identifiable. Per-contract proxy/impl
  mappings live in `.tools/fetch_report.json`.
- **Re-pull.** To refresh sources from the explorers:
  ```bash
  ETHERSCAN_API_KEY=<your-key> python3 .tools/bulk_fetch.py
  python3 .tools/gen_foundry.py
  ./build.sh
  ```
- **Cross-chain bridge contracts** (`ListaOFT_f9b2/`, `ListaOFTAdapter_837c/`)
  are paired: `ListaOFTAdapter` on BSC locks slisBNB, `ListaOFT` on Ethereum
  mints/burns. Owner of both is a 3-of-6 Gnosis Safe; pause-only multisig is
  1-of-10. See `nexus.oos.md` for full admin role inventory.
