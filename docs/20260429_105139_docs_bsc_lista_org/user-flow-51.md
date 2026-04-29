---
source: https://docs.bsc.lista.org/introduction/lista-lending/user-flow
crawled_at: 2026-04-29T10:51:39.138213
---

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/user-flow\#id-1.-deposit-assets-into-a-vault)    1\. Deposit Assets into a Vault

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2Flh7-rt.googleusercontent.com%2Fdocsz%2FAD_4nXd3By57F7kuKMNq2sTRK2GNs5FAdSg9DzG5RslMa8LKVU9LnkPFsUKn2gHpYtf9K2aiPrLBOKHLc6wOI3Odqt70mAepwWZAhVVvDIYbpNstZKCsf2BCe7ZJMI362nKUfXCf2YZ0%3Fkey%3DZbB0Bdp_i9xaaxZIxmtWD2y_&width=768&dpr=3&quality=100&sign=4d1308a9&sv=2)

Suppliers deposit a loan asset (e.g., USDT) into a vault of their choosing.

Each vault only has one loan asset (e.g., USDT) which can be deployed across multiple markets.

Once deposited, the vault allocates the loan asset across these markets to earn yield over time.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/user-flow\#id-2.-vault-matches-supplier-and-borrowers-p2p)    2\. Vault Matches Supplier and Borrowers (P2P)

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2Flh7-rt.googleusercontent.com%2Fdocsz%2FAD_4nXfbe12E5zx-0ekWuSFxeqm8uVARnYYLg3NqBnLS8Cq3V8SKzqH0-pIRkVXVyLmR651TtKyJOjcC10a3LUMBhvwj6SI_IL-7XayBgXCpOO8qArS5hHAd_T3HMVuEXK4qJfdZkjxi%3Fkey%3DZbB0Bdp_i9xaaxZIxmtWD2y_&width=768&dpr=3&quality=100&sign=d9ccebb1&sv=2)

The smart contract will actively match suppliers with borrowers within its associated markets, removing the intermediary needed for lending. The vault’s loan asset (e.g., USDT) is lent out via a specific market, earning interest from that specific Market. This P2P model results in higher interest for suppliers and lower borrowing costs for borrowers.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/user-flow\#id-3.-borrowing-with-collateral)    3\. Borrowing with Collateral

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2Flh7-rt.googleusercontent.com%2Fdocsz%2FAD_4nXddK9Nks8JeXyc2bRxQSnsygltWFyamhuUYlzAr25t40bIov8nOzJ-GXobvE0J1ujddsO76gjmODFA_B4YUtw-ROfKABFGkix49XYpXroUorx4ouEZ5OGyU6EIDqbkwumv8wys%3Fkey%3DZbB0Bdp_i9xaaxZIxmtWD2y_&width=768&dpr=3&quality=100&sign=987bfe27&sv=2)

1. Users who needs a specific asset should select a market to borrow from and deposit the required collateral. For example, in a USDT/BNB market, the borrower deposits BNB as collateral and borrows USDT.

2. The market locks the collateral and issues the borrowed asset, USDT

3. Each Market’s loan parameters (e.g., LLTV, collateral asset type, etc) are defined at deployment.


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/user-flow\#id-4.-auto-interest-rates-adjustments)    4\. Auto Interest Rates Adjustments

1. Interest rates in each market is automatically adjusted based on supply and demand (utilization rate).

2. The markets available on Lista Lending use a multi-oracle system to fetch accurate price feeds, protecting against price manipulation and ensures fair loan valuations.


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/user-flow\#id-5.-repay-or-get-liquidated)    5\. Repay or Get Liquidated

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2Flh7-rt.googleusercontent.com%2Fdocsz%2FAD_4nXcAPboGffxRDG0Dksf1hBFOR4gFLnOUXtqOc5ZH6quFlC1MQ0GrM-3TXEgXZXTCd1zNkYw1FdNMV2uGxU1yc9Vahl5kf2GcVey0TmHOt2WKQ93HLOr50H4Vzj8myxejYUvwqll3%3Fkey%3DZbB0Bdp_i9xaaxZIxmtWD2y_&width=768&dpr=3&quality=100&sign=8481e58a&sv=2)

1. Borrowers can repay loans anytime, plus the interest accrued.

2. Once repaid, collateral is partially or fully unlocked and available for withdrawal.

3. If the LTV ratio goes beyond the market's LLTV ratio, a liquidation will be triggered, selling the collateral to cover the loan, ensuring the vault remains solvent and suppliers are protected.


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/user-flow\#id-6.-withdraw-your-funds)    6\. Withdraw Your Funds

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2Flh7-rt.googleusercontent.com%2Fdocsz%2FAD_4nXeYJtL_bZPzZK8XsGtLkpt5dbN4VPm6hhsmgQNk0liLIqkDTl7hdr9BOxnqYLWU7vl2NETDWYK2zRQ8rVburvkbXROnn4BFZvEB9Dyoov9L01VRqk1OhpoKb4fsq6hmP-IRD0k%3Fkey%3DZbB0Bdp_i9xaaxZIxmtWD2y_&width=768&dpr=3&quality=100&sign=9dc078fd&sv=2)

1. Suppliers can withdraw their deposits and stop earnning interest at any time, provided the vault has sufficient liquidity available for withdrawal.

2. Borrowers can withdraw all their collateral after repaying the loan plus interest in full.


[PreviousFlash Loanchevron-left](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan) [NextThird-Party Vault Risk Managementchevron-right](https://docs.bsc.lista.org/introduction/lista-lending/third-party-vault-risk-management)

Last updated 18 days ago

Was this helpful?