---
source: https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates
crawled_at: 2026-04-29T10:51:39.145210
---

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2F1802824789-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252F60fXF9rALi6luWHVkkGg%252Fuploads%252FpAUTJYFyCGx5DOMe4pz8%252Fimage.png%3Falt%3Dmedia%26token%3Ddec4616c-f862-4087-aecc-73fadaf71e45&width=768&dpr=3&quality=100&sign=2ef239a1&sv=2)

## [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates\#current-borrow-rates)    Current Borrow Rates

The current borrow rate is the borrow rate that users will pay their loan on. The current borrow rate will fluctuate and update any time someone borrows or repays lisUSD.

If nobody interacts with the repayment / borrowing contracts for lisUSD, the current borrow rate will refresh and update once every few hours.

### [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates\#specifications)    Specifications:

1. Current borrow rates will be rounded to 8 decimal places.

2. Current borrow rates will be updated every 5 minutes.

3. Current borrow rate will change based on the price of lisUSD, and borrow rates that users **pay** will be based on the current borrow rate, **not** the expected borrow rate.

4. When users borrow or repay lisUSD, demand and supply of lisUSD changes, and thus, price of lisUSD changes, which in turn, changes the current borrow rates. However, the current borrowing rates will change only if lisUSD's change in price is more than $0.002. In other words, if the change in lisUSD's price is equal or less than $0.002, current borrow rates will not change.


## [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates\#expected-borrow-rate)    Expected Borrow Rate

The expected borrowing rate for lisUSD is updated every 15 minutes based on lisUSD prices. The Expected Borrow Rate shows what your next loan rate **might** be, and it doest not mean it will become the borrow rate.

If this expected borrow rate goes down, users may consider borrowing more lisUSD, which can lower its price. If it goes up, users may consider repaying their loan sooner to help boost lisUSD’s price.

The idea of having an expected borrowing rate is to indirect affect the demand and supply of lisUSD, helping to manage lisUSD's price expectations. This helps to keep lisUSD stable at $1.

### [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates\#specifications-1)    Specifications:

1. Expected borrow rates will be rounded to 8 decimal places.

2. Expected borrow rates will be updated every 15 minutes.

3. Expected borrow rates simply estimates what the future borrowing rates may be, relative to the price of lisUSD. It does not guarantee that the expected borrow rates will become the future current borrowing rates.


[PreviousAlgorithmic Market Operations (AMO)chevron-left](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo) [NextlisUSD's liquiditychevron-right](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/lisusds-liquidity)

Last updated 1 year ago

Was this helpful?