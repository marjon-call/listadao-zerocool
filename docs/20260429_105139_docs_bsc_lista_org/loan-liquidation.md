---
source: https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/collateral/loan-liquidation
crawled_at: 2026-04-29T10:51:39.121038
---

清算机制的应用是为了确保池中的 Lista -> Lista lisBNB -> slisBNB lisUSD -> lisUSD 完全由BNB抵押品支持。

当抵押品的当前价值（包括安全边际）低于借入的lisUSD金额时，可能会发生lisUSD的清算，借入的lisUSD将在荷兰式拍卖中被出售（清算）以偿还债务。

清算者因启动清算过程而获得气体补偿作为奖励。这是清算过程中出现的机会，任何Lista用户都可以执行此操作，包括借款人本人。除此机会外，任何重新启动荷兰式拍卖的人都会获得同样的奖励。

债务由Lista吸收，而出售的抵押品则分配给参与拍卖的清算者。

如果拍卖结束后还有剩余并且债务已经偿还，剩余部分将发送到借款人的钱包中。

有关清算过程的详细描述，请查看下面的清算模型，或参考我们的详细清算机制[这里](https://docs.bsc.lista.org/zh-cn/kai-fa-zhe-zhuan-qu/collateral-debt-position/mechanics)。

我们有一个新的清算模型，我们称之为Lista清算区，更多信息请查看[这里](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation/liquidation-zone)。

## [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/collateral/loan-liquidation\#liquidation-model)    清算模型[​arrow-up-right](https://helio.money/docs/mechanics/\#liquidation-model)

变量/步骤

值/公式

1单位抵押品的价格

$2

抵押比率

66%

基于抵押比率的抵押品价格

$1.32

假设用户存入10单位抵押品

10 \* 2 = $20

借款限额

user\_deposit \* collateral\_ratio = 20 \* 0.66 = $13.2

假设用户借入$13.2的lisUSD

13.2 lisUSD

假设1单位抵押品的价格下降到

$1.8

带安全边际的抵押品单位价格

current\_collateral\_unit\_price \* collateral\_ratio = 1.8 \* 0.66 = $1.188

带安全边际的抵押品当前价值

price\_of\_colatteral \* amount\_of\_collateral= 1.188 \* 10 = $11.88

正差值使用户处于清算线下

borrowed\_amount - current\_total\_colateral\_borrow\_limit = 13.2 - 11.88 = $1.32

进入荷兰式拍卖的抵押品数量

10

清算罚款（由Lista治理固定）

债务的10%

拍卖中需覆盖的债务

borrowed\_amount \* liquidation\_penalty = 13.2 \* 1.10 = $14.52

buf（与清算罚款类似的百分比，由Lista治理固定）

2%

拍卖起始价格（顶部）

current\_collaterral\_unit\_price \* buf = 1.8 \* 1.02 = $1.836

有人触发拍卖并获得tip + chip作为奖励（稍后描述）

拍卖开始，价格逐渐下降。清算者可以参与购买定制数量的清算抵押品

tau（价格为0的时间；由Lista治理固定）

例如 3600

dur（由Lista治理固定）

自拍卖开始以来经过的时间，例如 600

价格线性下降（可能因下列事件中断）

top \* ((tau - dur) / tau) = 1.836 \* ((3600 - 600) / 3600) = $1.53

因为两个条件之一暂停拍卖：— tail（经过特定时间量；由Lista治理固定）或 — cusp（价格下降百分比；起拍价的40%；由Lista治理固定）

满足任一要求，拍卖将被重新启动

等待有人重新启动拍卖

tip（固定费用；由Lista治理固定）

5 lisUSD

chip（动态费用；由Lista治理固定）

0

重新启动者获得tip + chip作为奖励

[PreviousLista 创新区chevron-left](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/collateral/lista-innovation-zone) [NextlisUSDchevron-right](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/lisusd)

Last updated 10 months ago

Was this helpful?