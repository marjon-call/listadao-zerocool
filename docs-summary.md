# Lista DAO — Documentation Summary

Single-file synthesis of the 101 pages crawled from
[`docs.bsc.lista.org`](https://docs.bsc.lista.org/) (snapshot under
`docs/20260429_105139_docs_bsc_lista_org/`). Focus is on what an auditor needs
to navigate the 132-contract scope; user-flow tutorials and marketing pages
are summarized only where they reveal protocol invariants.

---

## 1. Protocol overview

Lista DAO is a BNB-Chain-native DeFi suite with **four product lines** that
share one governance and admin layer:

| Product | What it does | Key contracts (this repo) |
|---|---|---|
| **Liquid staking** | User stakes BNB → mints `slisBNB`; rewards accrue into the LST exchange rate. | `ListaStakeManager_1adb`, `SLisBNB_b0b8`, `MasterVault_986b`, `*Strategy_*`, `Ceros*` |
| **CDP (lisUSD)** | MakerDAO fork — lock collateral (BNB / LSTs / LRTs / BTC / ETH / etc.), mint `lisUSD` stablecoin. | `Vat_33a3`, `Interaction_b684`, `Spotter_49bc`, `Jug_787b`, `Dog_d57e`, `HayJoin_4c79`, `LisUSD_0782`, `Clipper_*`, `GemJoin_*` |
| **Lista Lending ("Moolah")** | Permissionless P2P lending markets, vault-curated. Each market is `(collateral, loan, LLTV, oracle, IRM)`. | `BNBProvider_*`, `SlisBNBProvider_*`, `mBTCProvider_*`, `LendingRewardsDistributor_6654`, the `*Lending*` libraries inside the providers |
| **Smart Lending + Smart Swap** | Collateral is deposited into a Lista DEX LP (`slisBNB/BNB`, etc.); the LP token is the collateral and earns trading fees. | (Same Moolah core, with LP-token-aware oracle) |
| **Cross-chain** | LayerZero V2 OFT moving slisBNB between BSC and Ethereum. | `ListaOFTAdapter_837c` (BSC, lock-release), `ListaOFT_f9b2` (Ethereum, mint-burn) |

There are also peripheral systems that interact with all of the above:

- **PSM + AMO + LSR** (peg stability, algorithmic market ops, lisUSD savings rate) — `PSM_aa57`, `VaultManager_5763`, `VenusAdapter_f76d`, `LisUSDPoolSet_37db`, `EarnPool_66de`.
- **Distributors / governance** — `EmissionVoting_fc13`, `VotingIncentive_05ac`, `VeListaAutoCompounder_9a05`, `VeListaInterestRebater_da1e`, `VeListaRevenueDistributor_e415`, plus 9 `ERC20LpListaDistributor_*`, 5 `CollateralListaDistributor_*`, 5 `BorrowListaDistributor_*`, `StakeLisUSDListaDistributor_f2fa`.
- **Oracles** — `ResilientOracle_f3af` (aggregator), then 18 per-asset oracles (`BnbOracle`, `EthOracle`, `BtcOracle`, `SolvBtcOracle`, `xSolvBTCOracle`, `EzEthOracle`, `WeEthOracle`, `StoneOracle`, `SnBNBOracle`, `SlisBnbOracle`, `BBtcOracle`, `mBTCOracle`, `mCAKEOracle`, `mwBETHOracle`, `UsdtOracle`, `UsdfOracle`, `AsUsdfOracle`, `Usd1Oracle`).

---

## 2. Tokens

| Token | Contract | Decimals | Type | Notes |
|---|---|---|---|---|
| **lisUSD** | `0x0782b6d8…41E5` (BSC) | 18 | OZ ERC20Upgradeable | CDP-minted stablecoin pegged to USD. Min loan = 15 lisUSD. |
| **slisBNB** | `0xB0b84D29…4A1B` (BSC) | 18 | Reward-bearing ERC20 | LST for BNB; rewards accrue in the exchange rate, not via rebasing. ER ≥ 1 BNB / slisBNB always. |
| **LISTA** | `0xfceb31A7…dC46` (BSC) | 18 | ERC20 + permit | Governance token. Total supply reduced from 1 B → 800 M (LIP-021). veLISTA staking was sunset under LIP-024 — all stakes can be unlocked penalty-free; protocol revenue now funds LISTA buybacks. |
| **slisBNBx** | `0x4b30fcAA…6F6` (BSC) | 18 | Non-transferable | Granted to slisBNB depositors / Smart Lending / Thena LP'ers; entitles holder to Binance Launchpool airdrops. |
| **clisBNB** | (same as `slisBNBx_4b30` directory) | 18 | Non-transferable | CDP receipt for BNB collateral, used for Binance Launchpool. |
| **ceABNBc / ceTokens** | `CeToken_*` | 18 | Wrapper | Vault share-tokens for the Ceros stack; native-BNB MasterVault uses `ceABNBc` as `vaultToken()`. |

External tokens accepted as collateral or in scope: WBNB, USDT, USDC, BTCB, ETH, FDUSD, USDF, asUSDF, USD1, sUSDX, ezETH, weETH, wBETH, STONE, SolvBTC, SolvBTC.BBN, BBTC, mBTC, mCAKE, mwBETH.

---

## 3. CDP / lisUSD (Hay-Maker fork)

The CDP is a near-direct fork of MakerDAO. Familiar names, slightly renamed:

| Maker name | Lista name | Repo file | Role |
|---|---|---|---|
| `Vat` | `Vat` | `Vat_33a3` | Central RAY-scaled accounting (`Art`, `rate`, `spot`, `line`, `dust` per ilk; `urns` per (ilk, user)). |
| `Spotter` | `Spotter` | `Spotter_49bc` | Reads the per-ilk oracle and writes `spot = price * par / mat` to Vat. |
| `Jug` | `Jug` | `Jug_787b` | Stability-fee accumulator. `drip(ilk)` advances `rate`; `duty` is the per-second multiplier (RAY). |
| `Dog` | `Dog` | `Dog_d57e` | Liquidation initiator; per-ilk `chop` (penalty), `hole` (max), `dirt` (in-progress). |
| `Clip` | `Clipper` | `Clipper_*` (16 instances, one per collateral) | Dutch-auction liquidator. Implementation uses linear price-decrease (`abaci.sol` / `LinearDecrease_c135`). |
| `Join` | `GemJoin` / `HayJoin` | `GemJoin_*` (18 instances), `HayJoin_4c79` | Adapters between ERC20 and Vat internal accounting. `HayJoin` = lisUSD adapter. |
| `Vow` | `Vow` | `Vow_2078` | Surplus / debt buffer. |
| `Jar` | `Jar` | `Jar_0a1f` | Cumulative-fee distributor. |

**Top-level user entrypoint** is `Interaction_b684`. Researchers use it via:

- `deposit(user, token, dink)` — pull collateral, route through GemJoin into Vat
- `borrow(token, amount)` — mint lisUSD against locked collateral
- `payback(token, amount)` — burn lisUSD, restore CDP health
- `withdraw(user, token, dink)` — release collateral

The collateral registry is exposed via `interaction.collaterals(token)` which returns `(address gem, bytes32 ilk, uint32 live, address clip)` — a 4-field struct (NOT the 6-field Maker shape).

### lisUSD-specific extensions

Beyond the bare Maker fork, lisUSD adds:

1. **AMO (Algorithmic Market Operations)** — dynamic borrow rate adjusts based on lisUSD price to defend the peg. Formula: `r = r0 * exp((1 - price(lisUSD)) / Beta)`. Cap: 20% APY at any time. Per-collateral `r0` and `Beta`.
2. **D3M (Direct Deposit Module)** — directly mints lisUSD into Aave/Venus pools (no collateral) to grow lisUSD utility on third-party protocols. Phase-1 cap: 2.5 M lisUSD on Venus.
3. **PSM (Peg Stability Module)** — `PSM_aa57` is the USDT PSM. Lets users swap 1:1 between lisUSD and USDT (via `VenusAdapter_f76d` to Venus). `VaultManager_5763` allocates idle USDT into yield strategies.
4. **LSR (lisUSD Saving Rate)** — savings rate paid to lisUSD depositors in `LisUSDPoolSet_37db` / `EarnPool_66de`.
5. **Current vs Expected borrow rate** — current rate updates every 5 min (only when lisUSD price moves >$0.002); expected rate updates every 15 min as a forward-looking signal. Users always pay current rate.

### Risks the docs flag for lisUSD CDP

- Liquidation triggered when LTV exceeds the per-ilk threshold (`mat`).
- Min loan size = 15 lisUSD.
- Max global lisUSD borrow = 69 M (set in Vat `Line` and per-ilk `line`).
- Max `r0` is 200% per collateral (cap on AMO over-correction).
- Innovation Zone collaterals can be **removed without governance vote** if deemed risky — distinguishes "classic" vs "innovation" collateral.

---

## 4. Liquid staking (slisBNB)

User flow: deposit BNB into `ListaStakeManager_1adb` → receive slisBNB at the current exchange rate.

- Exchange rate is monotone non-decreasing (rewards accrue).
- `convertSnBnbToBnb(slisAmt)` returns BNB owed.
- `convertBnbToSnBnb(bnbAmt)` returns slisBNB minted.
- `getSlisBnbWithdrawLimit()` caps queued unstakes per epoch.
- Withdrawals enter a queue (`nextUndelegateUUID`) and complete after the BSC unbonding period.
- `feeBps` charged on rewards.

`ListaStakeManager` delegates to BNB Chain validators. Strategy contracts route capital across liquid-staking partners:

- `SnBnbYieldConverterStrategy_6f28` — main slisBNB strategy
- `BnbxYieldConverterStrategy_6ae7` — Stader bnbX
- `StkBnbStrategy_98cb` — pStake stkBNB
- `CerosYieldConverterStrategy_00d8` — Ceros (Ankr)

`MasterVault_986b` is a custom (non-ERC4626) vault. Its `asset()` returns `address(0)` for the native-BNB vault; the share token is exposed via `vaultToken()` (= `CeToken_5632` = `ceABNBc`). Manager-only entrypoints (`depositToStrategy`, `withdrawFromStrategy`, `allocate`) gate strategy capital.

The Ceros stack (`CerosRouter`, `CerosETHRouter`, `CeVaultV2`, `CeETHVault`, `HelioProviderV2`, `HelioETHProvider`, `CeToken_*`) is the older Ankr-derived path that wraps aBNBc → ceABNBc → into the CDP system.

---

## 5. Lista Lending ("Moolah")

Permissionless market-based lending built on Lista's "Moolah" core (the
`BNBProvider_*` / `SlisBNBProvider_*` directories all import `lib/openzeppelin-foundry-upgrades`-style Moolah contracts; the actual lending logic lives in `src/<Provider>_<addr4>/src/moolah/...`).

### Key concepts

- **Market** = `(collateral asset, loan asset, LLTV, oracle, IRM)`. Immutable post-deployment. Permissionless to create.
- **Vault** = single-loan-asset router that allocates user deposits across one or more markets per the curator's strategy. Fees up to 50% of interest.
- **LLTV** (Liquidation LTV) = per-market threshold, set at creation. Common ranges 50-90%+.
- **Curator** = vault owner; allocates capital + manages risk.
- **Allocator** = optional role for liquidity routing.
- **Bad debt** = when a position can't be liquidated. Two handling modes: **amortize** (gradual loss to suppliers) or **manual**.

### IRM (Interest Rate Model)

Adaptive curve targeting **90% utilization**:
- At u=90% → borrow rate = `r_90`
- At u=100% → borrow rate = `4 * r_90`
- At u=0% → borrow rate = `0.25 * r_90`
- The whole curve drifts: when u > 90% the curve shifts up (max: doubles `r_90` over 5 days at 100%); when u < 90% it shifts down (max: halves `r_90` over 5 days at 0%).

Borrow APY = `e^(borrowRate * 31_536_000) - 1` (continuous compounding).
Supply APY = vault-weighted average across all market APYs minus vault fees.

### Liquidation

- Triggered when position LTV > market LLTV.
- `LIF` (Liquidation Incentive Factor) = `min(1.15, 1 / (β * LLTV + (1 - β)))` with `β = 0.3`. Floor LIF = 1.048 (4.8%).
- For LLTV=80% → LIF ≈ 1.06 (6%). For LLTV=91.5% → computed LIF would be 1.026 but floored to 1.048.
- Liquidator repays debt, gets `OutstandingLoanValue * LIF` of collateral.
- Lista doesn't take a fee — full LIF goes to liquidator.
- **Liquidation Zone**: when the auto-liquidation bot can't process (too large, exotic asset, network congestion, etc.), the position is opened to community liquidators at a discount; manual activation by Lista team.

### Flash loans

`Moolah.flashLoan(token, amount, data)` — uncollateralized, single-tx repayment.

Callback flow:
1. User calls `moolah.flashLoan(token, amount, data)`
2. Moolah transfers `amount` to caller
3. Moolah calls `caller.onMoolahFlashLoan(amount, data)`
4. Callback executes user logic
5. Callback must approve Moolah to pull `amount` back
6. Moolah pulls funds; tx reverts if any step fails

There's also `IMoolahLiquidateCallback` for liquidation flows.

### Fees

- Vault fees up to 50% of interest (set per vault by curator).
- Protocol fee: 10% of borrower interest currently, adjustable 0-25% by Lista DAO.

### Fixed-term loans

Optional path: borrower picks a fixed APR for 7/14/30 days. Early repayment penalty = 50% of remaining interest. After expiry, loan reverts to flexible-rate.

### Oracles

All market oracles implement `IOracle.peek(address asset) -> uint256` (USD price scaled). `ResilientOracle_f3af` is Lista's aggregator (Chainlink primary + Binance Oracle check + Redstone backup). Per-asset oracles are independent contracts (`BnbOracle`, `BtcOracle`, etc., 18 total).

> **Note for auditors:** The lending docs say `IOracle.peek` returns USD scaled to 18 decimals BUT the Lista implementations (`ResilientOracle.peek`) actually return **8-decimal** Chainlink-style prices. Validated on-chain. This decimal mismatch is suspicious — worth investigating whether market math handles either case.

Markets are immutable post-deployment, so a misconfigured oracle is permanent for that market. Each market is risk-isolated (no cross-market contagion) but if the oracle is wrong the market can be drained.

### Vault security model

- Vault deposits are entrusted to the curator. Lista DAO **does not** review or endorse third-party vaults.
- Curator can change risk allocation, vault fees, and add/remove markets.
- Optional **timelock** can be set on critical parameter changes.
- Account ops can be triggered via direct call OR EIP-712 signed messages.

---

## 6. Smart Lending + Smart Swap

User deposits `slisBNB+BNB` LP into Smart Lending → LP becomes collateral; trading fees from Smart Swap (the Lista DEX) accrue to the deposit.

- Two deposit modes: **fixed ratio** (matches pool composition) or **custom ratio** (Lista swaps the excess to balance).
- Withdrawal is symmetric. "Pro mode" lets you withdraw the LP token directly so it can be re-deposited in a different Smart Lending market with the same collateral.
- Liquidation works the same as Moolah, but the liquidator gets the LP token (which Lista swaps back to one side of the pool).
- Edge case: dust amounts (<$0.01) might be left in pool when withdrawing custom-ratio; switch to fixed ratio to drain.

---

## 7. Cross-chain (LayerZero V2 OFT for slisBNB)

| Side | Address | Pattern | Pairing |
|---|---|---|---|
| BSC | `ListaOFTAdapter_837c` (`0x837CB07f…E7B3`) | **Lock-release** (wraps existing slisBNB at `0xB0b84…4A1B`) | EID 30102 |
| Ethereum | `ListaOFT_f9b2` (`0xf9B24C9…eBAa`) | **Mint-burn** | EID 30101 |

LayerZero V2 endpoint: `0x1a44076050125825900e736c501f859c50fE728c` on both chains.

**Key invariant:** `IERC20(slisBNB_BSC).balanceOf(adapter_BSC) >= ListaOFT_ETH.totalSupply()`. Verified live in the PoC validation suite.

**Trust model:** Owner of both bridge contracts is a 3-of-6 Gnosis Safe (`0x8d388…B0c6`). Pause-only multisig is a 1-of-10 Safe (`0xEEfeb…5Bd8`). LZ delegate (controls `setSendLibrary`, `setReceiveLibrary`, `setConfig`, DVN config) is the same 3-of-6 owner Safe.

**OFT-specific config:**
- `sharedDecimals = 6` (LZ default), local decimals = 18 → dust truncation at 1e12 wei on cross-chain transfers.
- TransferLimits per destination EID (rate limits): max-daily, single-upper, single-lower, daily-per-address, daily-attempt-per-address.
- `pause()` is multisig-gated, `unpause()` is owner-gated. Inbound `_credit` reverts when paused.

---

## 8. Governance (LISTA)

- **Voting platform:** Snapshot at https://snapshot.org/#/listavote.eth
- **Voting period:** 3 days
- **Quorum / pass threshold:** >50% of votes cast in favor
- **Proposal submission:** core team only (community can post on forums; team curates into Snapshot proposals)
- **Implementation lag:** 1-2 weeks after pass
- **Eligibility:** any LISTA holder (no minimum); voting power proportional to holdings
- **Veto / emergency powers:** Lista core team can pause contracts and remove gauges without a vote, citing "fixing critical bugs" or "blocking malicious tokens"
- **Borrow rate adjustments:** core team may adjust without governance proposal during volatile market conditions (per protocol docs)

In-scope governance topics (per docs):
1. Modify fees (withdrawal fee, LISTA early-unlock fee)
2. Add new collateral types
3. Adjust collateral ratios and debt ceilings
4. Allocate protocol fees among LISTA holders
5. Vote on LISTA emission share to liquidity pools

Innovation Zone collaterals are **exempt** from governance vote and can be removed unilaterally.

### Tokenomics evolution

- LIP-016: permanent locking of LISTA (lock or burn)
- LIP-021: total supply reduced 1B → 800M ("deflationary initiative")
- LIP-024: veLISTA sunset; staked LISTA unlockable penalty-free; protocol revenue → LISTA buybacks; LP-pool voting removed; all holders can vote on LIPs

---

## 9. Specific risks and patterns flagged in the docs

These are explicit per-product invariants worth checking in the code:

### CDP (lisUSD)

- Min loan = 15 lisUSD; positions cannot be repaid below this.
- AMO borrow rate capped at 20% APY, per-collateral `r0` capped at 200%.
- Liquidation auctions use linear price decrease (`LinearDecrease_c135`) — `tip + chip` rewards keepers.
- Collateral price fed through `Spotter` reading per-ilk oracle; `mat` (RAY) defines the safety margin.
- "Innovation Zone" assets bypass governance for removal.
- AMO operates against the Binance oracle, not the same oracle used by Spotter — verify this divergence doesn't enable manipulation.
- `permit` (EIP-2612) supported on lisUSD.

### Lista Lending

- Markets are **immutable** — oracle/IRM/LLTV cannot change post-deployment.
- Vault `withdraw` blocked when utilization ≥ 99.99%.
- Fee on interest capped at 50% (vault) + 25% (protocol).
- Bad debt amortization spreads loss over time across remaining suppliers.
- Flash loans are atomic: failed approval reverts entire tx.
- Reentrancy must be considered across `onMoolahFlashLoan` and `onMoolahLiquidate` callbacks.

### Liquid staking

- slisBNB withdrawals queue for the BSC unbonding period (~7 days).
- `getSlisBnbWithdrawLimit()` caps per-epoch withdrawals.
- Strategy `withdrawFromActiveStrategies` loops bounded by the strategy count.
- MasterVault `availableToWithdraw` is the buffer — exceeding it triggers strategy unwinds.

### Cross-chain

- Adapter must lock ≥ what the OFT mints (lock-release invariant).
- DVN compromise = forge inbound = mint slisBNB on Ethereum from nothing. (LZ-stack risk, out of scope per Immunefi default exclusions.)
- Setting a malicious peer (`setPeer`) by the 3-of-6 owner Safe = same impact. Reports requiring owner-key compromise are out of scope.

### Oracles

- 18 separate per-asset oracle contracts; each is independent.
- ResilientOracle aggregates 3 sources (Chainlink primary, Binance check, Redstone backup) but **the docs claim 18-decimal output while on-chain reads are 8-decimal** — flag as inconsistency.
- Markets in Lista Lending pick their own oracle at deployment; some may use a single feed (less safe), some the resilient aggregator.

### Governance / admin

- Core team retains pause + gauge-veto power without on-chain vote.
- Borrow rate can be changed without governance during "volatile" conditions.
- Innovation Zone collaterals removable without vote.

---

## 10. Reference: in-scope contract addresses (132)

Full address ↔ path mapping is in commit `c7ec6e3`'s scope work; see
`nexus.scope.md` for the file list and `.tools/fetch_report.json` for
per-contract proxy/implementation/compiler metadata. Quick stack-by-stack
reference:

- **CDP core:** `LisUSD_0782`, `Vat_33a3`, `Spotter_49bc`, `Jug_787b`, `Dog_d57e`, `HayJoin_4c79`, `Interaction_b684`, `AuctionProxy_272d`, `Vow_2078`, `Jar_0a1f`, `LinearDecrease_c135`, `FlashBuy_9ba8`
- **CDP per-collateral:** 18× `GemJoin_*`, 16× `Clipper_*`, 18 oracle dirs
- **CDP peg / yield:** `PSM_aa57`, `VaultManager_5763`, `VenusAdapter_f76d`, `LisUSDPoolSet_37db`, `EarnPool_66de`, `StakeLisUSDListaDistributor_f2fa`
- **Liquid staking:** `SLisBNB_b0b8`, `slisBNBx_4b30`, `ClisToken_88a5`, `ListaStakeManager_1adb`, `MasterVault_986b`, 4× strategies (`SnBnb`, `Bnbx`, `Ceros`, `StkBnb`), `CeVaultV2_25b2`, `CerosRouter_a186`, `HelioProviderV2_a835`, `CeETHVault_a230`, `CerosETHRouter_a0cd`, `HelioETHProvider_0326`, 4× `CeToken_*`
- **Bridge:** `ListaOFTAdapter_837c` (BSC), `ListaOFT_f9b2` (Ethereum)
- **Lending (Moolah):** `BNBProvider_3673`, `BNBProvider_501b`, `SlisBNBProvider_33f7`, `SlisBNBProvider_fd31`, `LendingRewardsDistributor_6654`, `mBTCProvider_8a01`
- **DEX-related:** `PancakeStaking_e31f`, `ThenaStaking_fa5b`, `StakingVault_62df`, `StakingVault_f40d`, `LpProxy_5a0e`, `ERC20LpTokenProvider_2725`, `ThenaERC20LpProvidableListaDistributor_ff5e`, 9× `ERC20LpListaDistributor_*`
- **Governance / veLISTA:** `EmissionVoting_fc13`, `VotingIncentive_05ac`, `VeListaAutoCompounder_9a05`, `VeListaInterestRebater_da1e`, `VeListaRevenueDistributor_e415`, 5× `CollateralListaDistributor_*`, 5× `BorrowListaDistributor_*`
- **Oracles:** `ResilientOracle_f3af` + 18 per-asset oracles

---

## 11. What's NOT in the docs

Things you'd want to cross-check on-chain rather than trust the docs:

- Exact LLTV values per market (docs say "50-90%+" without a list).
- Exact `mat` per CDP collateral.
- The current `r0` and `Beta` for each AMO collateral.
- DVN set selected by the LZ delegate.
- Active strategy allocations in MasterVault.
- Gauge weights (`EmissionVoting`) — change weekly.
- Curators on each Lista Lending vault.
- Innovation-zone vs classic collateral lists (changes over time).

For numbers an audit needs, query the proxy address directly.

---

*Sources: 101 markdown pages crawled `2026-04-29` from `docs.bsc.lista.org`. The crawl picked up the Chinese-localized version for some pages (URL paths with `/zh-cn/`); content is otherwise identical to English. Re-crawl with `python3 docsGetter.py https://docs.bsc.lista.org/` to refresh.*
