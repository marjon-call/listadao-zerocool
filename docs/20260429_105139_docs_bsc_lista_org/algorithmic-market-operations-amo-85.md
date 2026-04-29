---
source: https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo
crawled_at: 2026-04-29T10:51:39.144924
---

To maintain lisUSD’s price stability & peg at $1, it is crucial to balance lisUSD’s supply and demand in the circulating market and LPs. Previously, the borrow rate of lisUSD was regularly adjusted to indirectly affect the supply and demand of lisUSD. With the launch of our AMO, Lista DAO will implement a dynamic borrow rate, similar to Curve Finance’s [MonetaryPolicy contractsarrow-up-right](https://docs.curve.fi/crvUSD/monetarypolicy/) for crvUSD, to further strengthen price stability of lisUSD.

At the start, the Lista core team will decide the parameter based on market conditions. In the futures, parameter changes will require a proposal and community vote.

Additionally, to ensure the stability and responsiveness of our platform, the core team reserves the right to adjust the borrow rate flexibly in response to significant market fluctuations. This approach allows us to adapt to rapidly changing market conditions without requiring a snapshot proposal.

Users can rest assured that any adjustments will be made with careful consideration to maintain balance and align with market realities.

**The maximum borrow rate at any point in time will be capped at 20%.**

## [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo\#interest-rate-mechanics)    Interest Rate Mechanics

The interest rates in lisUSD markets are not static but fluctuate based on a set of factors, including:

1. The price of lisUSD, which is determined through Binance oracle.

2. The variables r0, and Beta.


### [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo\#the-formula-for-calculating-the-borrowing-interest-rate-r-is-as-follows)    The formula for calculating the Borrowing interest rate (r) is as follows:

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2Flh7-us.googleusercontent.com%2Fdocsz%2FAD_4nXfRbturnppWrw7w0t-PLXhA2vzUoiV-iNor96k0jyzwnkHgvWjGfpEo85koiXXrodJJdSlZKPgDfYANjMgBFRgzIrQuoNqbLL_m6Ku7XoCEPIUOFU2D6hvjwJTgzzcDyMAEoIlnBlIy4fW_S2m7_Dwghk5v%3Fkey%3Dqpnu5MtZ54GEwy9P7UA52A&width=768&dpr=3&quality=100&sign=fbf32915&sv=2)

### [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo\#key-variables-in-this-calculation-include)    Key variables in this calculation include:

**r:** Annual Percentage Yield (APY)

**r0**: Default annual rate, different for each collateral type, configured when launched on the smart contract

**exp(x)**: Exponential function of x (e\*e\*e\*...\*e)

**Price(lisUSD)**: Current price of lisUSD, obtained from an oracle

**Beta**: Adjustment parameter, configured when launched on the smart contract

_Note\* For each different Collateral, a different r0 is set. However, the maximum r0 will always be capped at 200% or less at any point in time._

_Note\* For each different Collateral, a different Beta will be set. As seen in r calculation, the Beta has a huge effect on x, and thus r._

### [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo\#example)    Example:

r0 = 8%, Price(lisUSD) = $0.98, Beta = 2%
r = 8% \* exp\[(1 - 0.98)/2%\] = 21.746%

This means if the price of lisUSD is $0.98, with r0 = 8% and Beta = 2% , the current borrowing rate will be 21.746%. Users will repay lisUSD, reducing the supply.

## [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo\#calculation-for-r)    Calculation for r

For accuracy and consistency, both r and r0 are expressed in terms of 10^27 to denote precision and are calculated per second.

### [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo\#here-are-the-steps-taken-when-calculating-for-r)    Here are the steps taken when calculating for r:

1. Retrieve the current price of lisUSD to get price(lisUSD). (r0, Beta is fixed for each collateral)

2. Update the current borrow rate every 15 minutes or when users interact with the contract (borrow, repay)

3. Calculate the borrow interest based on the current rate


The exact formula for calculating the interest rate (r) is as follows:

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2Flh7-us.googleusercontent.com%2Fdocsz%2FAD_4nXfgarTeoLR1RoaLXOnfPPHESQmX4s-A14bVKyUlWWtxtY6XIYSqS1Tz_jFC8Uc6CMPQ8Yopx9FZ8ltTyRyqy9bXRZTiFGrq7WEGitmIROHEHnA2LoLJUfy_sd6uaRRJlbbGuvyr0ER-YCKi1yZ9URa5dEtL%3Fkey%3Dqpnu5MtZ54GEwy9P7UA52A&width=768&dpr=3&quality=100&sign=70df1c34&sv=2)

**r**: Interest rate per second, in terms of 10^27, converted to APY, always be less than 200% at any point in time

**r0**: Default rate, different for each collateral type, configured when launched on the smart contract

**exp(x)**: Exponential function of x ((e\*e\*...\*e)

**Price(target)**: Target price ($1), calculated in terms of 10^8

**Price(lisUSD)**: Current price of lisUSD, obtained from Binance oracle, in terms of 10^8

**Beta**: Adjustment parameter, configured when launched on the smart contract, tentative rang: (3 \* 10^5, 10^8)

**APY(Default)**: Confirms r0

All smart contract details can be found [here](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo#source-code-parameters).

## [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo\#source-code-parameters)    Source code parameters:

r0:

Copy

```
DynamicDutyCalculator.ilks(address _collateral).rate0
```

exp(x):

Copy

```
  function exp(int256 delta, int256 beta) internal pure returns (uint256) {
        if (delta < 0) {
            int256 power = delta * FixedMath0x.FIXED_1 / beta;
            int256 _r = FixedMath0x._exp(power);
            return uint256(_r) * 1e18 / uint256(FixedMath0x.FIXED_1);
        } else if (delta > 0 ) {
            delta = -1 * delta;
            int256 power = delta * FixedMath0x.FIXED_1 / beta;
            int256 _r = FixedMath0x._exp(power);
            return uint256(FixedMath0x.FIXED_1) * 1e18 / uint256(_r);
        } else {
            return 1e18;
        }
    }
```

Price(target):

Copy

```
uint256 constant PEG = 1e8;
```

Price(lisUSD):

[Oracle addressarrow-up-right](https://bscscan.com/address/0xf3afD82A4071f272F403dC176916141f44E6c750#readProxyContract)

Copy

```
uint256 price = oracle.peek(address _lisUSD)
```

Beta:

Copy

```
DynamicDutyCalculator.ilks(address _collateral).beta
```

[PreviousD3M - Direct Deposit Modulechevron-left](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/d3m-direct-deposit-module) [NextCurrent vs Expected Borrow Rateschevron-right](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates)

Last updated 1 year ago

Was this helpful?