# PoC Guide — ListaOFT (slisBNB) Audit

## Target

| | |
|---|---|
| Contract | `ListaOFT` (slisBNB cross-chain mint/burn OFT) |
| Address | `0xf9B24C9364457Ea85792179D285855753549eBAa` |
| Chain | **Ethereum mainnet** (LayerZero V2 eid `30101`) |
| Deployed type | **Direct deployment** — not a proxy (ERC1967 impl slot is zero) |
| Counterparty | `ListaOFTAdapter` `0x837CB07f6B8a98731856092457524FF37b25E7B3` on BSC (eid `30102`), wraps slisBNB at `0xB0b84D294e0C75A6abe60171b70edEb2EFd14A1B` |
| LZ V2 endpoint | `0x1a44076050125825900e736c501f859c50fE728c` |
| Owner / LZ delegate | `0x8d388136d578dCD791D081c6042284CED6d9B0c6` |
| MultiSig (`pause()` only) | `0xEEfebb1546d88EA0909435DF6f615084DD3c5Bd8` |

> The original Instascope export listed this address on BSC. **It is on Ethereum mainnet.** `0xf9B24C9...eBAa` on BSC is a different, unrelated contract (`SnBnbYieldConverterStrategy`).

## Files in scope

See `nexus.scope.md`. The 4 files form a single deployment unit:

- `src/contracts/oft/ListaOFT.sol` — burn-mint OFT entrypoint, EIP-2612 permit, glues TransferLimiter into `_debit`/`_credit`
- `src/contracts/oft/TransferLimiter.sol` — per-EID daily/single/per-address transfer caps
- `src/contracts/oft/PausableAlt.sol` — multisig-only pause, owner-only unpause
- `src/contracts/interfaces/IERC2612.sol` — permit interface

Vendored deps under `lib/instascope-vendor/{@openzeppelin,@layerzerolabs}` are **frozen at the deployed-bytecode versions** — do not upgrade them; the audit target is the deployed contract.

## How to run a PoC

The fork test harness is `test/PoC.t.sol`. It already:

- Forks **Ethereum mainnet** via `MAINNET_RPC_URL` (no need to pass a URL; it's read from env)
- Declares all relevant addresses as constants (`LISTA_OFT`, `LZ_ENDPOINT_V2`, `LISTA_OWNER`, `LISTA_MULTISIG`, `LISTA_OFT_ADAPTER_BSC`, `SLIS_BNB_BSC`, `EID_ETHEREUM`, `EID_BSC`)
- Defines minimal interfaces (`IListaOFT`, `ILayerZeroEndpointV2`) — **do not import the project source**, contracts are compiled standalone and cross-imports break
- Exposes `oft` and `lzEndpoint` as ready-to-use casts

Write your exploit inside `test_PoC()`:

```bash
forge test --match-contract PoCTest -vvv
```

If you need to add helpers, add them as additional functions or contracts in `test/`. Keep `test_PoC()` as the canonical entry point.

## Audit focus areas (LayerZero V2 OFT bug classes)

Run `/scan-layer-zero` and `/scan-signature` for the structured detector pass. Hot zones for ListaOFT specifically:

1. **TransferLimiter `_debit` ordering** — limits are checked on `_amountLD` *after* dust removal but *before* `super._debit`. Verify reset-on-new-day logic, off-by-ones, and that the limiter cannot be bypassed by repeated dusty sends.
2. **`_credit` pause behavior** — `_credit` is `whenNotPaused`. If a peer sends a message while this OFT is paused, the cross-chain message will revert at `lzReceive` and could either (a) block the executor or (b) leave the BSC adapter holding locked tokens with no mint here. Check whether this is blocking-DoS behavior.
3. **EIP-2612 domain separator** — `DOMAIN_SEPARATOR` is set in constructor with `block.chainid` and `address(this)`. `updateDomainSeparator()` is **unauthenticated** and re-derives from the same fields; review whether it's a no-op or whether any field can drift (chain split, `name()` mutation).
4. **`pause()` access control split** — multisig can pause but cannot unpause; only owner can unpause. If the multisig is compromised, attacker can repeatedly pause but the owner can recover. If the owner is compromised, attacker can leave the OFT paused and DoS bridging until the multisig pauses (which doesn't help). Confirm both keys' threat models in the bounty docs.
5. **Peer trust on receive** — the BSC peer (`peers(30102)`) is set to the ListaOFTAdapter. If `setPeer` ever gets misconfigured (or `enforcedOptions` are weak), a malicious peer could mint slisBNB on Ethereum.
6. **Shared decimals dust** — `sharedDecimals = 6`, local decimals = 18, so `decimalConversionRate = 1e12`. Any `_amountLD` not divisible by 1e12 is silently truncated in the OFT base. The TransferLimiter operates on the post-dust value (see `_debit`). Worth checking whether dust accounting is consistent across both chains and whether the limiter can be bypassed via amounts that limit-pass before dust removal but truncate to zero.
7. **`updateDomainSeparator()` is permissionless** — anyone can call it, and it always recomputes from `name()` (unchanged) and `block.chainid`. Looks defensive against a chain split, but evaluate any side-effect race with in-flight permits.

## Bounty rules (Immunefi — Lista DAO)

- Findings already disclosed in audits at `lista-dao/lista-dao-contracts/audits` and `lista-dao/synclub-contracts/audit` are ineligible.
- Only on-chain bugs in scope contracts; UI / off-chain infra out of scope unless otherwise stated.
- BSC is the listed chain on Immunefi for the broader Lista scope; this OFT is on Ethereum but is a Lista-deployed bridge contract for slisBNB. Confirm with Immunefi mediation if doubt arises.

Always re-check the live bounty page before reporting:
- Scope: https://immunefi.com/bug-bounty/listadao/scope/
- Information: https://immunefi.com/bug-bounty/listadao/information/

## Reference

Crawled docs available under `docs/20260429_105139_docs_bsc_lista_org/` (101 pages from `docs.bsc.lista.org`); start with `about-slisbnb.md` and `liquid-staking-slisbnb.md` for protocol context.
