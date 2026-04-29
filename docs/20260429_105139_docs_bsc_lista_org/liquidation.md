---
source: https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation
crawled_at: 2026-04-29T10:51:39.128465
---

Lista Lending的清算是一种重要的风险管理工具，通过确保借款人保持足够的抵押品来保护贷款人的资本。这种机制使得当借款人的贷款价值比（LTV）超过市场的清算贷款价值比（LLTV）阈值时，可以全面或部分清算借款人的头寸，确保市场稳定，同时支持其以金库为中心的无许可贷款模式。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation\#li-jie-dai-kuan-jia-zhi-bi-ltv-bi-l)    理解贷款价值比（LTV）比率

贷款价值比（LTV）是您的贷款价值与您的抵押品价值之间的比率。这是一个评估头寸风险的关键指标，通过比较债务与抵押品价值来进行评估。

**如何计算LTV**

LTV=LoanAssetAmountCollateralAssetAmount×OraclePriceOraclePriceScale×100%LTV = \\frac{Loan\ Asset\ Amount}{Collateral\ Asset\ Amount\\times \\frac{Oracle\ Price}{Oracle\ Price\ Scale}}\\times100\\%LTV=CollateralAssetAmount×OraclePriceScaleOraclePrice​LoanAssetAmount​×100%

其中：

Oracle Price 是抵押资产价格与贷款资产价格之间的比率。

Oracle Price Scale 是 103610^{36}1036，用于价格标准化。

示例：

在Lista的BNB/USDT市场，如果您存入1 BNB并借出500 USDT。

在某个时刻，Lista从预言机获取的BNB/USDT价格是8×10388\\times10^{38}8×1038。将这个数字除以103610^{36}1036，我们将得到BNB的标准化价格：800 USDT。

那么这笔贷款的LTV是500800×100%=62.5%\\frac{500}{800}\\times 100\\% = 62.5\\%800500​×100%=62.5%

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation\#biao-zhun-qing-suan)    标准清算

标准清算是Lista Lending防止借款人违约的主要防线，嵌入在协议的核心合约中。每个市场都有自己的清算贷款价值比（LLTV），这是用作触发清算的任意数字。

#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation\#he-shi-ke-yi-qing-suan-tou-cun)    **何时可以清算头寸？**

当头寸的LTV超过其相应市场的LLTV时，该头寸就可以被清算。

这可能是由于：

- 抵押品价值下降（例如，BTCB价格下跌）。

- 由于利息累积而债务增加。

- 两者的结合。


#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation\#qing-suan-ru-he-gong-zuo)    **清算如何工作**

当触发清算时，任何外部方可以偿还部分或全部借款人的债务，并成为清算人，获得等值的抵押品加上由清算激励因子（LIF）确定的奖励。

LIF因市场而异，由市场的LLTV决定：

LIF=min(M,1β×LLTV+(1−β))LIF=min(M,\ \\frac{1}{\\beta\\times LLTV+(1-\\beta)})LIF=min(M,β×LLTV+(1−β)1​)

其中：

- β\\betaβ 是一个常数，0.3。

- MMM 是最大激励因子，1.15。


当市场的LLTV为80%时，LIF ≈ 1.06（6%的奖励）。目前，Lista DAO设定的最低LIF为1.048。

为了激励及时清算，所有LIF奖励都归清算人所有；Lista不收取费用。

#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation\#zhu-bu-shi-li)    **逐步示例**

假设您存入100 USDT并借出91.5 USD1。这个市场的LLTV为91.5%。

您的LTV是91.5/100=91.5%91.5/100 = 91.5\\%91.5/100=91.5%，因此一旦开始计算利息，您的LTV将超过LLTV。将触发清算，清算人将介入偿还债务。（这也是为什么我们不建议借款接近LLTV）

现在，清算人可以部分或全部偿还这笔贷款，并获得一些抵押品加上由LIF确定的奖励。对于这个市场，LLTV为91.5%，LIF为：

LIF=min(M,1β×0.915+(1−β))=1.026LIF=min(M,\ \\frac{1}{\\beta\\times 0.915+(1-\\beta)})=1.026LIF=min(M,β×0.915+(1−β)1​)=1.026

这低于最低LIF，1.048，所以LIF=1.048LIF=1.048LIF=1.048。

这意味着将没收一定数量的抵押品：

SeizedCollateralValue=OutstandingLoanValue×LIFSeized\ Collateral\ Value = Outstanding\ Loan\ Value\\times LIFSeizedCollateralValue=OutstandingLoanValue×LIF

未偿还贷款为91.5 USD1（加上微不足道的利息）。如果预言机规定1 USD1 = 1 USDT，那么没收的抵押品数量将是：

91.5×LIF=91.5×1.048=95.892USDT91.5\\times LIF = 91.5\\times 1.048 = 95.892\ USDT91.5×LIF=91.5×1.048=95.892USDT

如果贷款全部偿还，这意味着清算人支付91.5 USD1加上微不足道的利息，他们将获得略多于95.892 USDT。他们的利润是：95.892USDT−91.5USD1≈$4.392 减去燃料费。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation\#yan-chi-qing-suan)    延迟清算

根据[LIP-024arrow-up-right](https://snapshot.org/#/s:listavote.eth/proposal/0x1a15347f6b452049212bdf51ff1a46c0a7edf7ca8efe1004b32c15c2965f0f3b)的批准，延迟清算已经为选定市场推出，这是LISTA持有者的第一个好处。

通常情况下，当某个头寸的LTV超过其LLTV时，在Lista上将触发清算。通过延迟清算，符合条件的借款人将获得一个缓冲期——一个更高的新LLTV阈值，为选定市场保护您的头寸24小时：

抵押品

贷款

原始LLTV

新LLTV

BTCB

U

86%

92%

BTCB

USD1

86%

92%

BTCB

USDT

80%

92%

slisBNB

BNB

96.5%

97%

slisBNB

lisUSD

85%

92%

slisBNB

USD1

86%

92%

slisBNB

U

86%

92%

slisBNB

BNB

96.5%

97%

USD1

BNB

80%

92%

USD1

U

96.5%

97%

USDT

BNB

85%

92%

ETH

lisUSD

80%

92%

wBETH

lisUSD

80%

92%

对于这些市场，受保护头寸的总规模取决于7天平均LISTA持有量：

等级

7天加权平均LISTA持有量

总受保护头寸规模

1

≥ 10,000 LISTA

≤ $10,000

2

≥ 50,000 LISTA

≤ $50,000

3

≥ 200,000 LISTA

≤ $200,000

4

≥ 1,000,000 LISTA

≤ $1,000,000

5

≥ 5,000,000 LISTA

≤ $10,000,000

6

≥ 15,000,000 LISTA

≤ $50,000,000

有了延迟清算，符合条件的借款人的头寸将处于以下状态之一：

- **受保护**：LTV低于原始LLTV。头寸健康并且在市场对您不利时预先符合保护条件。

- **受保护**：LTV在原始和新LLTV之间。开始24小时宽限期。考虑偿还您的贷款或增加抵押品以降低其LTV。

- **超出保护范围**：由于$LISTA持有量不足或在其LTV超过原始LLTV时剩余等级容量已耗尽，延迟清算未激活。将触发清算。


受保护的头寸将获得24小时时间来偿还或增加更多抵押品以降低其LTV。如果24小时后，LTV仍高于原始LLTV阈值，将像往常一样触发清算。

如果某个头寸的LTV超过了原始LLTV，但其规模超过了剩余等级容量，将仍然触发部分或全部清算。在1次或多次清算后，如果所有待清算头寸的总规模低于最大受保护规模，这些头寸将再次受到保护。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation\#zhi-neng-dai-kuan-qing-suan)    智能贷款清算

在Smart Lending上的清算工作方式类似，但计算抵押品价值的方式略有不同。有关更多详细信息，请参阅[此文章arrow-up-right](https://blog.lista.org/everything-you-need-to-know-about-liquidation-on-lista-smart-lending)。

[Previous费用chevron-left](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/fees) [Next清算区chevron-right](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/liquidation/liquidation-zone)

Last updated 4 hours ago

Was this helpful?