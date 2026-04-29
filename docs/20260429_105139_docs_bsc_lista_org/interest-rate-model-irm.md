---
source: https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/interest-rate-model-irm
crawled_at: 2026-04-29T10:51:39.125815
---

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/interest-rate-model-irm\#lilmo-xing)    利率模型

在Lista Lending，利率由我们的利率模型（IRM）根据贷款资产的供需决定。供需的关键指标是市场利用率——借入资产与供应资产的比率。Lista的IRM将根据市场利用率调整利率。当市场利用率过高时，Lista的IRM将大幅提高借款利率（APY），以激励还款，反之亦然。在一个足够活跃的市场中，最理想的市场利用率是90%，Lista的IRM将尝试将其保持在此水平。

与传统的贷款协议采用静态利率或单一资金池设计不同，Lista Lending在每个金库内的多个市场应用IRM，为策展人提供灵活性，同时确保借款人和贷款人的竞争利率。

Lista的IRM基于利用率逐步调整借款利率，而不是立即调整。这避免了利率的剧烈波动及其相关风险，同时保持对市场的影响力。在高利用率下，借款人将不得不支付更高的利息，但不足以因利率突然飙升而导致意外的清算。贷款人仍然能够随着时间的推移获得更高的利率，而不是偶尔的短暂上涨。

#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/interest-rate-model-irm\#gong-zuo-yuan-li)    工作原理

Lista的IRM通过基于利用率指定瞬时借款利率来驱动整个Lista Lending。它以90%的利用率为目标，以平衡效率和流动性。此IRM通过两种互补机制运作：

1. **曲线机制**
这根据实时利用率和目标利用率立即调整借款利率。目前，Lista针对所有贷款市场的目标利用率为90%。


- 关键参数：r90%r\_{90\\%}r90%​. 目标利用率下的借款利率：90%。


当利用率超过90%时，借款利率将线性上升至100%利用率时的4×r90%4 \\times r\_{90\\%}4×r90%​。

当利用率低于90%时，借款利率将线性下降至0%利用率时的0.25×r90%0.25 \\times r\_{90\\%}0.25×r90%​。

1. **自适应机制**
该机制通过根据当前利用率uuu调整r90%r\_{90\\%}r90%​来移动整个利息曲线：


u=TotalBorrowedAssetTotalSuppliedAsset×100%u = \\frac{Total Borrowed Asset}{Total Supplied Asset} \\times\ 100\\%u=TotalSuppliedAssetTotalBorrowedAsset​×100%

- 当u>90%u > 90\\%u>90%时：增加r90%r\_{90\\%}r90%​并向上移动曲线以鼓励还款。

- 当u<90%u < 90\\%u<90%时：减少r90%r\_{90\\%}r90%​并向下移动曲线以激励借款。


r90%r\_{90\\%}r90%​变化的速度e(u)e(u)e(u)，与当前利用率uuu与90%之间的差异线性相关：

e(u)={v×u−utarget1−utarget,whenu>utargetv×u−utargetutarget,whenu<utarget}e(u) = \\begin{Bmatrix}v\\times\\frac{u-u\_{target}}{1-u\_{target}}, when\ u>u\_{target}\\\v\\times\\frac{u-u\_{target}}{u\_{target}}, when\ u<u\_{target}\\end{Bmatrix}e(u)={v×1−utarget​u−utarget​​,whenu>utarget​v×utarget​u−utarget​​,whenu<utarget​​}

其中vvv是Lista智能合约中定义的任意数字。目前，utarget=90%u\_{target} = 90\\%utarget​=90%：

在100%利用率时r90%r\_{90\\%}r90%​增加的最大速度，将在5天内使r90%r\_{90\\%}r90%​翻倍。在0%利用率时r90%r\_{90\\%}r90%​减少的最大速度，将在5天内使r90%r\_{90\\%}r90%​减半。

当利用率u=90%u=90\\%u=90%时，r90%r\_{90\\%}r90%​将保持不变，直到uuu发生变化。

当一个市场的uuu长时间保持在45%时，其r90%r\_{90\\%}r90%​将以e(0%)e(0\\%)e(0%)的一半速度减少，10天后减半。

当一个市场的uuu长时间保持在95%时，其r90%r\_{90\\%}r90%​将以e(100%)e(100\\%)e(100%)的一半速度增加，10天后翻倍。

#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/interest-rate-model-irm\#jie-kuan-he-gong-ying-apy)    借款和供应APY

年化百分率收益（APY）将利率标准化为一年，考虑到复利，是Lista Lending的关键指标。两个关键的APY包括：

- 借款APY：借款人支付的年化成本，由我们的IRM的瞬时利率推导而来。它反映了从金库市场借款的年度费用。

- 供应APY：贷款人赚取的年化回报，计算为金库分配到所有市场的加权平均值，根据利用率和费用进行调整。


**借款APY**
借款APY将每秒借款利率复合为一年：

borrowAPY=eborrowRate×secondsPerYear−1borrow APY= e^{borrowRate \\times secondsPerYear} - 1borrowAPY=eborrowRate×secondsPerYear−1

其中：

- borrowRate: IRM为特定市场设定的利率。

- secondsPerYear: 31,536,000（一年中的秒数）。


**供应APY**
供应APY是金库级别的加权平均值，结合每个市场的APY及其分配比例：

1. 权重：从其提款队列中检索金库的流动性分配（例如，50% slisBNB/BNB，30% USD1/BNB）。

2. 计算每个市场的供应APY：
supplyAPY=borrowAPY×u×(1−fee)supplyAPY = borrowAPY \\times u \\times (1 - fee)supplyAPY=borrowAPY×u×(1−fee)

3. 加权平均：
vaultsupplyAPY=∑supplyAPY×marketWeightvaultsupplyAPY= \\sum supplyAPY \\times\ market WeightvaultsupplyAPY=∑supplyAPY×marketWeight


其中：

- uuu是当前利用率：u=TotalBorrowedAssetTotalSuppliedAsset×100%u = \\frac{Total Borrowed Asset}{Total Supplied Asset} \\times\ 100\\%u=TotalSuppliedAssetTotalBorrowedAsset​×100%

- Fee包括协议费用（0-25%，由Lista DAO设定）和金库费用（最高50%，由策展人设定）；当前默认为0%，除非另有说明。


**与金库的整合**

与独立市场应用不同，IRM在Lista Lending的金库内运作，其中流动性跨多个市场分配（例如，pt-clisBNB/lisUSD，BNB，BTCB）。策展人可以调整分配或升级金库参数，增强IRM的适应性，同时保留其核心逻辑。

[Previous借款人与供应商chevron-left](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/borrowers-and-suppliers) [Next固定利率与期限贷款chevron-right](https://docs.bsc.lista.org/zh-cn/jian-jie/lista-lending/fixed-rate-and-term-loans)

Last updated 1 month ago

Was this helpful?