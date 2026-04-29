---
source: https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/collateral/loan-liquidation
crawled_at: 2026-04-29T10:51:39.142769
---

The liquidation mechanism is applied to ensure that Lista -> Lista lisBNB -> slisBNB lisUSD -> lisUSD in pools remains fully backed by BNB collateral.

Liquidation of borrowed lisUSD may happen when the current worth of collateral with safety margin is lower than the borrowed amount of lisUSD and the borrowed lisUSD is sold in a Dutch auction (liquidated) to have the debt paid.

The liquidator receives gas compensation as a reward for starting the liquidation. It is an opportunity arising in the liquidation process, and any Lista user can do it, including the borrower themselves. Besides this opportunity, anybody who restarts the Dutch auction receives the same reward for doing it.

The debt is absorbed by Lista and the sold collateral is distributed among liquidators who participate in the auction.

If any remainder is left after the auction ends and the debt is paid, it is sent to the borrower's wallet.

For a detailed description of the liquidation process, do have a look at the liquidation model below, or refer to our detailed liquidation mechanics [here](https://docs.bsc.lista.org/for-developer/collateral-debt-position/mechanics).

We have a new liquidation model which we call the Lista liquidation zone, do find out more about it [here](https://docs.bsc.lista.org/introduction/lista-lending/liquidation/liquidation-zone).

## [hashtag](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/collateral/loan-liquidation\#liquidation-model)    Liquidation model[​arrow-up-right](https://helio.money/docs/mechanics/\#liquidation-model)

Variable/Step

Value/Formula

Price of 1 unit of collateral

$2

Collateral ratio

66%

Collateral price based on collateral ratio

$1.32

Assume User deposit 10 units collateral

10 \* 2 = $20

Borrow limit

user\_deposit \* collateral\_ratio = 20 \* 0.66 = $13.2

Assume User borrows $13.2 of lisUSD

13.2 lisUSD

Assume Price of 1 unit of collateral decreases to

$1.8

Collateral unit price with safety margin

current\_collateral\_unit\_price \* collateral\_ratio = 1.8 \* 0.66 = $1.188

Current worth of collateral with safety margin

price\_of\_colatteral \* amount\_of\_collateral= 1.188 \* 10 = $11.88

Positive diff puts user under liquidation line

borrowed\_amount - current\_total\_colateral\_borrow\_limit = 13.2 - 11.88 = $1.32

Amount of collateral that goes to Dutch auction

10

Liquidation penalty (fixed by Lista governance)

10 % of the debt

Debt to cover in the auction

borrowed\_amount \* liquidation\_penalty = 13.2 \* 1.10 = $14.52

buf (percentage similar to liquidation penalty, fixed by Lista governance)

2%

Starting auction price (top)

current\_collaterral\_unit\_price \* buf = 1.8 \* 1.02 = $1.836

Somebody triggers auction and gets tip + chip as a reward for doing it (described later)

Auction starts and the price gradually decreases. Liquidator can participate to buy customized amount of liquidated collateral

tau (time until price is 0; fixed by Lista governance)

e.g. 3600

dur (fixed by Lista governance)

time in seconds elapsed since the auction start, e.g. 600

Linear decrease of price (subject to be disrupted at the below event)

top \* ((tau - dur) / tau) = 1.836 \* ((3600 - 600) / 3600) = $1.53

Pause auction because of one of two conditions: — tail (specific amount of time elapsed; fixed by Lista governance) OR — cusp (% of price drop; 40% start auction price; fixed by Lista governance)

either requirement is met, the auction will be restarted

Wait till someone restarts auction

tip (flat fee; fixed by Lista governance)

5 lisUSD

chip (dynamic fee; fixed by Lista governance)

0

Restarter gets tip + chip as a reward

[PreviousLista Innovation Zonechevron-left](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/collateral/lista-innovation-zone) [NextlisUSDchevron-right](https://docs.bsc.lista.org/introduction/collateral-debt-position-lisusd/lisusd)

Last updated 1 month ago

Was this helpful?