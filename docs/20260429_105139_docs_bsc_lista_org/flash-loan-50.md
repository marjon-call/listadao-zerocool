---
source: https://docs.bsc.lista.org/introduction/lista-lending/flash-loan
crawled_at: 2026-04-29T10:51:39.138035
---

Flash loans are a powerful DeFi primitive that allow users to borrow assets without collateral, as long as the borrowed amount is returned within the same transaction block.

#### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan\#what-are-flash-loans-in-lista-lending)    What Are Flash Loans in Lista Lending?

Lista Lending's flash loans are similar to other DeFi protocols where these:

- Allow borrowing without prior collateral

- Require repayment within the same transaction

- Execute in a single block

- Are primarily meant for developers and advanced users


#### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan\#how-lista-lending-flash-loans-work)    How Lista Lending Flash Loans Work

The core flash loan functionality is implemented through the flashLoan function in the Moolah contract with a corresponding callback mechanism.

#### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan\#the-flash-loan-flow-in-lista-lending)    The Flash Loan Flow in Lista Lending

1. Initiation: A user contract calls moolah.flashLoan(token, amount, data)

2. Asset Transfer: Moolah transfers the requested token amount to the calling contract

3. Callback Execution: Moolah calls onMoolahFlashLoan(amount, data) on the caller contract

4. Execution of Logic: The user's contract executes its intended operations

5. Repayment: The user's contract must approve Moolah to pull back the borrowed amount

6. Completion: Moolah pulls the funds back from the caller contract


If at any point the flow fails (especially if the repayment fails), the entire transaction reverts.

### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan\#implementing-a-flash-loan-in-lista-lending)    Implementing a Flash Loan in Lista Lending

To use a flash loan with Moolah, you need to:

1. Create a contract that implements the IMoolahFlashLoanCallback interface

2. Implement the onMoolahFlashLoan function that will handle your logic

3. Ensure your callback function approves the Moolah contract to jpull back the borrowed amount


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan\#flash-loan-use-cases-with-lista-lending)    Flash Loan Use Cases with Lista Lending

1. Arbitrage: Execute trades across different protocols to profit from price discrepancies

2. Collateral Swaps: Replace one collateral type with another in a single transaction

3. Self-Liquidation: Liquidate your own position to avoid liquidation penalties

4. Flash Actions: Combine multiple Moolah operations in a single transaction


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan\#security-considerations-for-lista-lending-flash-loans)    Security Considerations for Lista Lending Flash Loans

1. Transaction Atomicity: If your callback fails to approve the repayment, the entire transaction will revert

2. Contract Security: Never leave funds in your flash loan contract permanently

3. Reentrancy: Be careful about calling external contracts within your flash loan logic

4. Gas Management: Flash loans are complex operations that consume significant gas


### [hashtag](https://docs.bsc.lista.org/introduction/lista-lending/flash-loan\#lista-lending-specific-callbacks)    Lista Lending Specific Callbacks

Lista Lending implements a broader callback system:

- IMoolahLiquidateCallback: For liquidation operations

- IMoolahRepayCallback: For repayment operations

- IMoolahSupplyCallback: For supply operations

- IMoolahSupplyCollateralCallback: For supplying collateral


This comprehensive callback system allows for more complex transaction patterns beyond simple flash loans, such as the "Flash Actions" test which combines supply, borrow, repay, and withdraw operations in a single transaction flow.

[PreviousOraclechevron-left](https://docs.bsc.lista.org/introduction/lista-lending/oracle) [NextUser Flowchevron-right](https://docs.bsc.lista.org/introduction/lista-lending/user-flow)

Last updated 18 days ago

Was this helpful?