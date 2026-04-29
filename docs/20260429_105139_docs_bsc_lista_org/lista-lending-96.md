---
source: https://docs.bsc.lista.org/introduction/lista-lending
crawled_at: 2026-04-29T10:51:39.156044
---

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2F1802824789-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252F60fXF9rALi6luWHVkkGg%252Fuploads%252FjgZMcSOh00X6w6xpkqjM%252Fimage.png%3Falt%3Dmedia%26token%3D92d2afa2-a75b-4a85-89d8-48eb45e405af&width=768&dpr=3&quality=100&sign=bc6a545f&sv=2)

Lista Lending is a fully decentralized and permissionless P2P lending protocol crafted for BNB Chain, breaking free from the constraints of traditional large-pool lending to cultivate a more inclusive and resilient ecosystem.

Lista Lending’s core revolves around a vault-based system, pooling liquidity and dynamically allocating it across different lending & collateral pairs, which we call markets, based on supply and demand.

## [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#key-concepts)    Key Concepts

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#collateral)    Collateral

Borrowers must deposit supported crypto assets as collateral into a market of their choosing to unlock a borrowing capacity proportional to the collateral’s value from the market.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#borrowing)    Borrowing

The borrower specifies the amount of assets they wish to borrow from the market and provide the required collateral. The ratio between the values of their loan and collateral is represented in loan-to-value ratio (LTV). When this ratio is too high - typically due to price fluctuations and/or accruing interest, a liquidation will be triggered and the borrower may lose a portion or all their collateral.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#interest-rates)    Interest Rates

The borrower pays interest at an agreed-upon rate. Interest accumulates over time and should be paid at the time of repayment. Read more about our Interest Rate Model here: [https://docs.bsc.lista.org/introduction/lista-lending/interest-rate-model-irmarrow-up-right](https://docs.bsc.lista.org/introduction/lista-lending/interest-rate-model-irm)

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#repayment)    Repayment

The borrower can return the loan principal and interest at any time and retrieve the collateral after the transaction is confirmed.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#liquidation-loan-to-value-lltv)    Liquidation Loan-To-Value (LLTV)

The Liquidation Loan-To-Value ratio, or LLTV ratio, is a preset threshold that varies from market to market to protect the lenders. When a loan's LTV approaches its corresponding LLTV, the collateral is considered insufficient and the borrower is at risk of being liquidated. This is when a liquidation will be triggered.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#liquidation-mechanism)    Liquidation Mechanism

Whenever a liquidation is triggered, Lista’s smart contract will take over a portion of the position and try to swap it into the corresponding debt asset and cover the loan. When Lista’s smart contract can not complete the liquidation process and repay the loan, the position will be listed in Lista’s [Liquidation Zonearrow-up-right](https://lista.org/lending/liquidation), available for everyone to purchase. Positions listed in Lista's Liquidation Zone will be at a discounted price to encourage taking over. Read more about our liquidation mechanism here: [https://docs.bsc.lista.org/introduction/lista-lending/liquidationarrow-up-right](https://docs.bsc.lista.org/introduction/lista-lending/liquidation)

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#lending)    Lending

The Lender (supplier) deposits a certain amount of assets into Lista's vaults and the smart contract will pair these assets with the borrowers and receives a portion of their borrowing interest.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending\#withdrawal)    Withdrawal

The lender can withdraw their deposited assets and interest at any time (subject to market liquidity).

The borrower can withdraw their collateral in part or in full only when the proposed withdrawal will not push the LTV higher than the LLTV.

[PreviousLista Creditchevron-left](https://docs.bsc.lista.org/introduction/lista-credit) [NextVaultschevron-right](https://docs.bsc.lista.org/introduction/lista-lending/vaults)

Last updated 1 month ago

Was this helpful?