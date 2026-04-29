---
source: https://docs.bsc.lista.org/introduction/lista-lending/oracle
crawled_at: 2026-04-29T10:51:39.137144
---

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/oracle\#what-is-an-oracle)    What is an Oracle?

An oracle is a smart contract that provides external data, particularly price information, to blockchain applications. For lending protocols like Lista Lending, most oracles are providing price data with 8 decimal places of precision. For example, if the price of 1 BTC is 80,000, it would return 80,000 \* 100,000,000 = 8,000,000,000,000.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/oracle\#oracles-in-lending-markets)    Oracles in Lending Markets

Lending markets rely on oracles to:

- Determine the value of collateral and loan assets

- Calculate borrowing capacity

- Trigger liquidations when positions become undercollateralized

- Enable accurate interest rate calculations


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/oracle\#oracles-at-lista-lending)    Oracles at Lista Lending

All oracles used in Lista Lending markets implement the IOracle interface, which has a single, standardized function:

`function peek(address asset) external view returns (uint256);`

This function returns the price of 1 collateral token quoted in usd.

There is a single function:

`function getPrice(MarketParams calldata marketParams) external view returns (uint256);`

This function returns the price of 1 unit of collateral token quoted in the loan token, with appropriate scaling to account for decimal differences between tokens.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/oracle\#types-of-oracles-compatible-with-lista-lending)    Types of Oracles Compatible with Lista Lending

Various oracle implementations can be used with Lista Lending markets:

1. Price Feed Oracles: Utilize external price feeds (like Chainlink, Redstone, API3, Pyth, Chronicle) to calculate asset exchange rates.

2. Exchange Rate Oracles: Specialized for wrapped tokens or rebasing tokens where the exchange rate is deterministic (like wstETH/stETH).

3. Fixed-Price Oracles: Used for assets with known or predefined exchange rates, such as stablecoins pegged to the same value.


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/oracle\#key-oracle-characteristics-in-lista-lending-markets)    Key Oracle Characteristics in Lista Lending Markets

- Immutable: Once a market is deployed, its oracle address cannot be modified

- Independent: Each oracle operates autonomously and can use different pricing sources

- Flexible Implementation: Curators can leverage various data sources while maintaining a consistent interface


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/oracle\#oracle-selection-by-market-curators)    Oracle Selection by Market Curators

Market curators (not Lista) are responsible for selecting and implementing appropriate oracles for their markets. Each Lista Lending market specifies its oracle in the market parameters:

CollateralAsset/LoanAsset (LLTV%, OracleAddress, IRMAddress)

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/oracle\#oracle-security-considerations)    Oracle Security Considerations

The security of an oracle is critical to the safety of a Lista Lending Market. Users should:

- Verify the oracle implementation for any market they interact with

- Understand the price sources being used

- Consider potential manipulation vectors or failure modes


The immutable nature of Lista Lending Markets means oracle selection is a permanent decision that defines the market's risk profile.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/oracle\#oracle-community-section)    Oracle community section

Some community members contributed to adapters that could be plugged into oracles.

- Lista nor author of the repository cannot be held responsible for any losses or damages that may result from the use of this information.

- Users are advised to conduct their own research and exercise caution when applying any strategies or methods described herein.


[PreviousLiquidation Zonechevron-left](https://docs.bsc.lista.org/introduction/lista-lending/liquidation/liquidation-zone) [NextFlash Loanchevron-right](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan)

Last updated 18 days ago

Was this helpful?