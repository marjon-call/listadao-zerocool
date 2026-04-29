# PoC Guide — Lista DAO

## Scope

This repo contains **132 unique in-scope contracts** for the
[Lista DAO Immunefi bounty](https://immunefi.com/bug-bounty/listadao/scope/),
covering 131 BSC contracts + 1 Ethereum contract.

Source for every contract was pulled directly from BscScan/Etherscan via the
verified-contract API (the Immunefi Instascope feature was broken at the time
of this prep). Each verified-source bundle lives at
`src/<ContractName>_<addr4>/`, where `<addr4>` is the first 4 hex chars of the
deployment address. The full address ↔ path mapping is in
`.tools/fetch_report.json`.

> **Important:** Many in-scope addresses are `TransparentUpgradeableProxy` /
> upgradeable proxies. The source we audit is the **implementation** for the
> address listed on the bounty page; the audit target (state holder) is the
> proxy address itself. Use `FOUNDRY_PROFILE=contract_<Name>_<addr4>` to
> compile a single contract — the directory name encodes the proxy address.

## Layout & build

Each contract has its own Foundry profile with the exact compiler version,
optimizer settings, evm version, viaIR flag, and remappings that were used at
verification time. Profiles are **per contract** because the scope mixes 5
distinct solc versions (0.8.4, 0.8.10, 0.8.20, 0.8.24, 0.8.28).

```bash
# Build a single in-scope contract
FOUNDRY_PROFILE=contract_ListaOFT_f9b2 forge build

# Build everything
./build.sh

# Build via the Nexus harness
make -f nexus.makefile build
```

## Writing a PoC

The fork test harness is `test/PoC.t.sol`. It is intentionally **independent
of the in-scope sources** (cross-profile imports break across the 5 distinct
solc versions in scope), so it uses inline minimal interfaces for everything
it touches.

The harness is **dual-fork**: BSC by default (where 131 of 132 in-scope
contracts live) plus a lazy Ethereum fork for the cross-chain `ListaOFT`.
Switch with `_useBscFork()` / `_useEthereumFork()` inside a test.

```bash
export BSC_RPC_URL=<bsc-rpc>
export MAINNET_RPC_URL=<eth-rpc>
forge test --match-contract PoCTest -vvv
```

### Already-defined casts

| Cast | Address | Notes |
|---|---|---|
| `stakeManager` | `LISTA_STAKE_MANAGER` | slisBNB stake/unstake orchestrator |
| `vat` | `VAT` | CDP central accounting |
| `interaction` | `INTERACTION` | top-level user entrypoint |
| `oftAdapter` | `LISTA_OFT_ADAPTER_BSC` | bridge BSC side (lock-release) |
| `oftEth` | `LISTA_OFT_ETH` | bridge ETH side (mint/burn) |
| `lzBsc`, `lzEth` | LZ V2 endpoint | `0x1a44…728c` on both chains |

Plus 60+ `address constant`s for proxy targets across the CDP, liquid-staking,
lending, OFT, distributor, and oracle stacks. Add new constants and inline
interfaces as needed — researchers can grep for the contract they want under
`src/<Name>_<addr4>/` and copy out the function signatures.

### Gotchas discovered during validation

These were caught while validating the template — useful when adding more
interfaces later:

- **`Interaction.collaterals(token)`** returns `(address gem, bytes32 ilk, uint32 live, address clip)` — a 4-field struct, not the 6-field Maker shape. `live == 1` means the collateral is enabled.
- **`ResilientOracle`** uses `peek(address asset)` not `getPrice(address)`. It returns USD prices in **8 decimals** (Chainlink default), not 18.
- **`MasterVault`** is **not** ERC-4626. `asset()` returns `address(0)` for the native-BNB vault and `vaultToken()` returns the share-token (`ceABNBc`).
- **`ListaOFTAdapter` (BSC)** and **`ListaOFT` (ETH)** ARE on the same address pattern but `approvalRequired()` differs: adapter requires approval (lock-release), OFT does not (mint-burn).
- **Shared decimals = 6** on the OFT (LayerZero default); local decimals = 18, so any cross-chain amount loses precision below `1e12` wei.
- **String literals can't contain unicode arrows** in Solidity assert messages without a `unicode""` literal — keep ASCII.

## Reference contracts to start with

The 132 in-scope contracts cluster into a few protocol stacks. High-impact
starting points:

### Stablecoin / CDP (the "Hay" Maker fork)
- `src/LisUSD_0782/` — lisUSD ERC-20
- `src/Vat_33a3/` — central CDP accounting (Maker `vat`)
- `src/Spotter_49bc/` — collateral price spotter
- `src/Jug_787b/` — stability-fee accumulator
- `src/Dog_d57e/` — liquidation initiator
- `src/HayJoin_4c79/` — lisUSD adapter
- `src/Interaction_b684/` — top-level user/protocol entrypoint
- `src/AuctionProxy_272d/` — liquidation auction lib
- `src/PSM_aa57/`, `src/VaultManager_5763/`, `src/VenusAdapter_f76d/` — peg stability + Venus integration
- `src/EarnPool_66de/`, `src/LisUSDPoolSet_37db/` — yield routing

### Liquid staking (slisBNB / clisBNB)
- `src/SLisBNB_b0b8/` — slisBNB token
- `src/ListaStakeManager_1adb/` — main BNB staking orchestrator
- `src/MasterVault_986b/` — strategy router
- `src/SnBnbYieldConverterStrategy_6f28/`, `src/StkBnbStrategy_98cb/`,
  `src/CerosYieldConverterStrategy_00d8/`, `src/BnbxYieldConverterStrategy_6ae7/` — yield strategies
- `src/CeVaultV2_25b2/`, `src/CerosRouter_a186/`, `src/HelioProviderV2_a835/` — Ceros stack

### Cross-chain bridge (LayerZero V2 OFT)
- `src/ListaOFTAdapter_837c/` — BSC lock/release adapter (eid 30102)
- `src/ListaOFT_f9b2/` — Ethereum mint/burn OFT (eid 30101). Owner is a 3-of-6 Safe; pause-only multisig is 1-of-10.

### Lending stack ("Moolah")
- `src/BNBProvider_3673/`, `src/BNBProvider_501b/` — Moolah-vault BNB providers
- `src/SlisBNBProvider_33f7/`, `src/SlisBNBProvider_fd31/` — Moolah-vault slisBNB providers
- `src/LendingRewardsDistributor_6654/` — rewards
- `src/mBTCProvider_8a01/` — mBTC provider for Moolah

### Distributors / governance / staking
- `src/EmissionVoting_fc13/`, `src/VotingIncentive_05ac/` — gauge voting
- `src/VeListaAutoCompounder_9a05/`, `src/VeListaInterestRebater_da1e/`, `src/VeListaRevenueDistributor_e415/` — veLISTA
- `src/PancakeStaking_e31f/`, `src/ThenaStaking_fa5b/` — DEX staking
- `src/StakingVault_62df/`, `src/StakingVault_f40d/` — Pancake & Thena vaults
- `src/CollateralListaDistributor_*/`, `src/BorrowListaDistributor_*/`, `src/ERC20LpListaDistributor_*/`, `src/StakeLisUSDListaDistributor_f2fa/` — LISTA emission distributors

(Full list of 132 in `nexus.scope.md`. GemJoin/Clipper/Oracle contracts repeat
across collateral types — they share the same code but per-collateral state.)

## Bounty rules summary

- **PoC required for all severities** — no PoC, no payout.
- **All testing on local forks**; mainnet/testnet state-changing tests are
  prohibited.
- Findings already disclosed in audits at `lista-dao/lista-dao-contracts/audits`,
  `lista-dao/synclub-contracts/audit`, and the Certik / PeckShield / SlowMist /
  Veridise reviews are **out of scope**.
- Reports about admin centralization, leaked-key attacks, oracle data quality,
  51% attacks, sandwich/MEV, phishing, and DDoS are **not eligible**. See
  `nexus.oos.md` for the full list.
- Submit through Immunefi only:
  - Scope:       https://immunefi.com/bug-bounty/listadao/scope/
  - Information: https://immunefi.com/bug-bounty/listadao/information/

## Reference

- Crawled docs:    `docs/20260429_105139_docs_bsc_lista_org/` (101 pages)
- Per-contract metadata (compiler, proxy/impl, settings):  `.tools/fetch_report.json`
- Bulk-fetch tooling: `.tools/bulk_fetch.py`, `.tools/gen_foundry.py`
