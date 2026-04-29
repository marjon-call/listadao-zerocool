# Out of Scope

## Out-of-Scope Source Files

The following files in this repo are NOT in scope for the bounty:

- `test/*` — PoC harness; researcher-authored, not deployed code
- `script/*` — Empty placeholder; no deployment scripts in scope
- `lib/instascope-vendor/@openzeppelin/*` — Vendored OpenZeppelin (frozen at deployed bytecode); third-party dependency
- `lib/instascope-vendor/@layerzerolabs/*` — Vendored LayerZero V2 OApp/Protocol contracts; third-party dependency
- `lib/forge-std/*` — Foundry test framework
- `docs/*` — Crawled protocol documentation (reference material only)
- `docsGetter.py` — Local docs-fetch utility (already gitignored)
- `.venv/`, `cache/`, `out/`, `broadcast/` — build / runtime artifacts

Only the four files listed in `nexus.scope.md` are in scope.

## Out-of-Scope Attack Vectors

### Privileged Access

- Attacks requiring **leaked private keys** of the owner Safe, multisig Safe, or LayerZero delegate.
- Reports about **centralization of admin power**. The protocol uses a 3-of-6 Gnosis Safe for owner/LZ delegate and a 1-of-10 Gnosis Safe for the pause-only multisig. Reports about these trust assumptions are not eligible. See **Admin Roles & Trust Levels** below for the full role inventory.

### Consensus & Network Attacks

- **51% attacks**, block reorganizations.
- Attacks requiring a **chain rollback** or reorg.

### External Protocol Bugs

- Vulnerabilities in **LayerZero V2** (Endpoint, Executors, DVNs, Message Libraries, ULN), **OpenZeppelin** libraries, or **EIP-712 / ECDSA** primitives themselves are out of scope.
- **DVN compromise / collusion** scenarios that require a malicious DVN signing arbitrary packets — these are LayerZero stack risks, not ListaOFT bugs.
- **Executor griefing or front-running** at the LayerZero level — out of scope unless caused by ListaOFT-specific code.
- **Pricing oracle attacks** — ListaOFT does not consume oracles; not applicable. Per Immunefi rules, "any testing with pricing oracles or third-party smart contracts" is prohibited.
- **External events** such as upstream LayerZero outages, BSC reorgs, or Lista protocol-level config errors not caused by the ListaOFT code itself.

### Known MEV

- **Sandwich attacks**, arbitrage, front-running of ordinary `transfer`/`permit` flows — unless the report demonstrates novel impact specific to the OFT bridge.
- **Note:** Novel variants involving cross-chain message ordering or `_credit`/`_debit` interleaving with verifiable financial impact MAY still be eligible.

### Social Engineering & Infrastructure

- **Phishing**, social manipulation of Lista DAO team members or Safe signers.
- **DDoS attacks**, physical access requirements.
- Attacks requiring access to project infrastructure, websites, browser extensions, SSO providers, or advertising networks.
- Any testing with third-party systems or applications outside the scoped contracts.

### Known Issues (Prior Audits)

Vulnerabilities identified in the **Certik**, **PeckShield**, **SlowMist**, and **Veridise** security reviews are ineligible for rewards, as are findings documented in:

- `lista-dao/lista-dao-contracts/audits/Veridise_270622.pdf`
- `lista-dao/lista-dao-contracts/tree/master/audits`
- `lista-dao/synclub-contracts/tree/master/audit`

Reviewers MUST cross-check these audit reports before submitting. Duplicates of any prior finding are out of scope.

### Known Design Decisions

The following are intentional design choices in `ListaOFT.sol`, not bugs:

- **Shared decimals = 6** (LayerZero default). Local decimals = 18, so amounts are silently truncated to multiples of `1e12` on cross-chain send. This is required for cross-chain compatibility and not a bug in itself.
- **`pause()` is multisig-gated; `unpause()` is owner-gated.** This split is intentional — a single signer (1-of-10) can halt bridging in an emergency, but recovery requires the higher-threshold owner Safe (3-of-6).
- **`updateDomainSeparator()` is permissionless.** It re-derives the EIP-712 separator from `name()`, `EIP712_VERSION`, `block.chainid`, and `address(this)` — all immutable inputs, so the function is effectively idempotent. Only flag if you can demonstrate a meaningful side effect.
- **Owner can call `setTransferLimitConfigs` at any time.** The TransferLimiter is operator-tunable by design.
- **`_credit` reverts when paused.** Inbound cross-chain messages will fail at `lzReceive` while paused. Treat this as documented behavior unless you can show it leads to permanent fund loss on the BSC adapter side.

## Admin Roles & Trust Levels

ListaOFT exposes three privileged roles. Findings that require any of these to act maliciously are out of scope unless the report demonstrates that the action enables harm beyond their documented authority.

### 1. Owner — `0x8d388136d578dCD791D081c6042284CED6d9B0c6`

- **Type:** Gnosis Safe v1.3.0
- **Threshold:** **3 of 6 signers**
- **Trust level:** **HIGH (privileged, but distributed)**
- **Powers granted by the contract:**
  - `setTransferLimitConfigs(TransferLimit[])` — change per-EID rate limits at any time
  - `setMultiSig(address)` — rotate the pause-only multisig
  - `unpause()` — re-enable bridging after a pause
  - `transferOwnership(address)` / `renounceOwnership()` — full ownership transfer
  - `setPeer(uint32, bytes32)` — wire/un-wire trusted peers on other chains (e.g. ListaOFTAdapter on BSC). **A malicious peer can mint slisBNB on Ethereum at will.**
  - `setDelegate(address)` — change the LayerZero delegate address
  - `setEnforcedOptions(EnforcedOptionParam[])` — set required executor options per EID/msgType
  - `setMsgInspector(address)` — install a custom inbound-message inspector hook
  - `setPreCrime(address)` — change the PreCrime simulator
- **Mitigations:** 3-of-6 Safe makes unilateral abuse infeasible without compromising 3 keys. Reports requiring owner key compromise are not eligible.

### 2. MultiSig (pause-only) — `0xEEfebb1546d88EA0909435DF6f615084DD3c5Bd8`

- **Type:** Gnosis Safe v1.3.0
- **Threshold:** **1 of 10 signers** ← any single signer can act
- **Trust level:** **LOW (single-key equivalent), but power is bounded**
- **Powers granted by the contract:**
  - `pause()` — set the OFT to paused, blocking inbound `_credit` and outbound `_debit`. **No other state-changing capability.**
- **Risk implications:**
  - Compromise of any one of 10 signers → pauseable by attacker, but **not** drainable.
  - `unpause()` cannot be called by this multisig — recovery requires the 3-of-6 owner Safe.
  - The pause-only role is intentionally a watchtower / fast-trigger circuit breaker, not a capital authority. Reports about the 1-of-10 threshold itself are out of scope.

### 3. LayerZero Delegate — `0x8d388136d578dCD791D081c6042284CED6d9B0c6` (same as owner)

- **Type:** Same Gnosis Safe v1.3.0 as the Owner role
- **Threshold:** **3 of 6 signers**
- **Trust level:** **HIGH (privileged, but distributed)**
- **Powers (granted by the LayerZero V2 endpoint, not by ListaOFT directly):**
  - `setSendLibrary(...)` — choose which message library is used to send packets
  - `setReceiveLibrary(...)` / `setReceiveLibraryTimeout(...)` — choose which library validates inbound packets
  - `setConfig(...)` — set DVN set, executor, ULN confirmations, etc.
  - `nilify(...)` / `burn(...)` — skip stuck inbound messages on the endpoint
- **Risk implications:**
  - Delegate compromise → attacker can swap the receive library or DVN set, opening a path to forge inbound messages and mint slisBNB.
  - Because the delegate Safe is the same key set as the owner Safe (3-of-6), the same 3-key threshold applies. Reports requiring delegate key compromise are out of scope.

> **In-scope admin findings:** functions that should be `onlyOwner` but aren't, missing zero-address checks on setters, missing event emission, ownership-transfer atomicity issues, or any function that lets a non-admin attain admin privilege are all in scope.

## General Exclusions

- Attacks the reporter has already **exploited on mainnet** causing damage.
- **Theoretical user interactions** that lack demonstration of regular occurrence.
- **Best practice recommendations** without demonstrated security impact.
- **Feature requests.**
- **AI-generated reports** without a runnable Foundry fork-test PoC are not accepted.
- **Proof of concept is required for all severities** — no PoC, no payout (per Lista DAO program rules).

## Testing Restrictions

- **Primary method:** Mainnet fork testing via Foundry (`forge test --fork-url $MAINNET_RPC_URL`) using `test/PoC.t.sol`.
- **Allowed:** Read-only calls to deployed contracts on Ethereum mainnet (view functions, state queries) for reconnaissance.
- **Prohibited:** Any testing on mainnet or public testnet deployed code that mutates state. All testing must be done on local forks.
- **Prohibited:** Any testing with pricing oracles or third-party smart contracts (the LayerZero stack itself is third-party).
- **Prohibited:** Automated vulnerability scanners that generate massive traffic against project assets.
- **Prohibited:** DoS/DDoS attacks against project infrastructure.
- **Prohibited:** Public disclosure of an unpatched vulnerability while the bounty embargo is in place.
- **Prohibited:** Any other actions prohibited by the standard Immunefi Rules.
- All communication must take place exclusively through the Immunefi platform.

## Feasibility Limitations

The following conditions may render a bug report ineligible (Immunefi standard feasibility criteria):

- The attack requires a **chain rollback** or reorg.
- The attack requires **pre-impact monitoring** infrastructure that an attacker would not realistically have.
- The attack requires an **investment amount** that makes the attack economically irrational.
- The attack carries **financial risk to the attacker** that exceeds potential gains.
- The attack qualifies as **griefing rather than a critical vulnerability** (no value extraction, only inconvenience).
- For chain-specific issues: only the vulnerability with the highest severity will be paid.

## Payouts

- Rewards are denominated in USD and distributed as **USDT, USDC, or lisUSD** at the team's discretion.
- **No KYC** is required for payouts.
- Reports must be submitted exclusively via the Immunefi bounty page:
  - Scope: https://immunefi.com/bug-bounty/listadao/scope/
  - Information: https://immunefi.com/bug-bounty/listadao/information/
