---
source: https://docs.bsc.lista.org/zh-cn/jian-jie/faq
crawled_at: 2026-04-29T10:51:39.140299
---

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#what-is-lista)    Lista DAO是什么？

Lista DAO是由LSDfi驱动的开源去中心化稳定币借贷协议。用户可以在Lista DAO上进行质押和流动性质押，以及借用lisUSD对抗各种去中心化抵押品。Lista DAO存在于BNB Chain和Ethereum上，旨在将lisUSD定位为加密空间中的头号稳定币，利用创新的流动性质押解决方案。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#is-lista-audited)    Lista DAO是否经过审计？

是的，Lista DAO已经多次由一些最佳的Web3安全审计公司如Peckshield、Veridise、Slowmist、Blocksec和Supremacy进行审计。您可以在[此处arrow-up-right](https://docs.bsc.lista.org/security)找到审计报告。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#what-is-lisusd)    什么是lisUSD？

lisUSD是Lista DAO的去中心化稳定币，锚定于美元，完全由诸如BNB、ETH、slisBNB和wBETH等加密资产超额抵押。在第一阶段，lisUSD利用BNB Chain上的MakerDAO模型，提供一个去中心化且无偏见的稳定币产品。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#what-is-slisbnb)    什么是slisBNB

slisBNB是由Lista DAO构建的BNB的本地收益型和流动性质押代币。slisBNB根据BNB的质押APR对BNB进行增值，允许用户在不同的DeFi平台上赚取额外的收益，同时被动地赚取质押奖励。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#what-is-collateral)    什么是抵押品？

抵押品是借款人必须提供以获得贷款的任何资产，作为债务的保障。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#what-does-collateral-ratio-mean)    抵押比率是什么意思？

这是借款人存入的抵押品的美元价值与借入的lisUSD债务金额之间的比率。

抵押比率会随着抵押品价格的变动而波动。借款人可以通过调整抵押品和/或债务来影响比率——即增加更多的抵押品或偿还一些lisUSD债务。

例如：假设BNB的当前价格是2000美元，您决定存入1个BNB作为抵押品。如果您借用400 lisUSD，那么您的债务位置的抵押比率将是2000:400 = 500%。如果您借用1000 lisUSD，那么您的债务位置的抵押比率将是2000:1000 = 200%。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#what-is-the-minimum-collateral-ratio-and-borrow-amount-to-borrow-lisusd)    借用lisUSD的最低抵押比率和借款金额是多少？

目前，Lista DAO在BNBchain上提供一系列资产作为抵押品，如下所示：

#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#id-1-bnb)    1) BNB

要求：

- 最低借款：15 lisUSD

- 最低抵押比率：120%

- 最低抵押存款：0.1 BNB

- 借款费用：（动态费率，由我们的AMO模块决定）

- 提款费用：0%

- 提款选项：BNB/slisBNB


#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#id-2-slisbnb-listadao)    2) slisBNB (Lista DAO)

要求：

- 最低借款：15 lisUSD

- 最低抵押比率：125%

- 最低抵押存款：0.1 slisBNB

- 借款费用：（动态费率，由我们的AMO模块决定）

- 提款费用：0%

- 提款选项：BNB/slisBNB


#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#id-3-eth)    3) ETH

要求：

- 最低借款：15 lisUSD

- 最低抵押比率：125%

- 最低抵押存款：0.1 ETH

- 借款费用：（动态费率，由我们的AMO模块决定）

- 提款费用：0.1%

- 提款选项：ETH/WBETH


#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#id-3-wbeth-binance)    4) WBETH (Binance)

要求：

- 最低借款：15 lisUSD

- 最低抵押比率：125%

- 最低抵押存款：0.1 WBETH

- 借款费用：（动态费率，由我们的AMO模块决定）

- 提款费用：0%

- 提款选项：WBETH


#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#id-4-btcb-binance)    5) BTCB (Binance)

要求：

- 最低借款：15 lisUSD

- 最低抵押比率：125%

- 最低抵押存款：0.001 BTCB

- 借款费用：（动态费率，由我们的AMO模块决定）

- 提款费用：0%

- 提款选项：BTCB


#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#id-7-stone-stakestone)    6) STONE (StakeStone)

要求：

- 最低借款：15 lisUSD

- 最低抵押比率：200%

- 最低抵押存款：0.1 STONE

- 借款费用：（动态费率，由我们的AMO模块决定）

- 提款费用：0%

- 提款选项：STONE


#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#id-8-solvbtc-solv-protocol)    7) SolvBTC (Solv Protocol)

要求：

- 最低借款：15 lisUSD

- 最低抵押比率：200%

- 最低抵押存款：0.001 SolvBTC

- 借款费用：（动态费率，由我们的AMO模块决定）

- 提款费用：0%

- 提款选项：SolvBTC


#### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#id-8-solvbtc-solv-protocol-1)    8) SolvBTC.BBN (Solv Protocol)

要求：

- 最低借款：15 lisUSD

- 最低抵押比率：200%

- 最低抵押存款：0.001 SolvBTC.BBN

- 借款费用：7.5%

- 提款费用：0%

- 提款选项：SolvBTC


### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#how-can-users-earn-on-lisusd)    用户如何在lisUSD上赚取收益？

用户可以通过多种方式在lisUSD上赚取收益。他们可以在ListaDAO上质押他们的lisUSD，从而获得lisUSD奖励。他们还可以在PancakeSwap、Wombat Exchange、ThenaFi、Curve和Uniswap等多个流动性池中为slisBNB和lisUSD提供流动性，进一步赚取交易和LP费用。

请注意，虽然我们努力维持价格稳定，但lisUSD可能并不总是完美地锚定于美元，在紧张的市场条件下可能会稍微偏离。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#why-cant-i-withdraw-my-assets-from-a-vault)    为什么我无法从金库中提取我的资产？

这很可能是由于其高利用率。存入金库的资产将被分配到几个市场作为借款人的借款资产。这是大多数金库的主要收入来源。当金库的利用率很高时，意味着大部分资产已被借出，金库中几乎没有剩余流动性。如果在此利用率下发起提款，并且请求的金额超过金库中剩余的金额，则会因缺乏流动性而被拒绝。

不需要担心，因为随着时间的推移，借款人将偿还他们的贷款，金库中将有更多的流动性。即使有人忘记偿还，当累积的利息将其LTV推过LLTV比率时，他们的贷款可能会被清算。被清算的资产将被返回到金库，将有更多的流动性可用。

如果金库的利用率不高（低于90%），但您在提款时仍遇到错误，请联系我们的支持团队，通过我们的[Telegramarrow-up-right](https://t.me/ListaDAO)或[Discordarrow-up-right](https://discord.gg/listadao)社区。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#will-my-position-be-liquidated-on-lista)    我在Lista DAO的位置会被清算吗？

是的，清算是像Lista DAO这样的借贷协议中的常见概念，因此，用户需要意译，如果他们的抵押品不再足以维持贷款的MCR，他们的贷款位置有被清算的风险。

例如，如果您是借款人，而您的抵押品价值下降至150%的MCR以下，将发生清算。您仍将保留您借用的lisUSD，但您的借用位置将被关闭，您的抵押品将被用来补偿清算人。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/faq\#are-users-at-risk-of-losing-their-funds)    用户有失去资金的风险吗？

作为一个非托管系统，所有发送到协议的代币将由智能合约持有和管理，不受任何个人或法律实体的干扰。这意味着您的资金只受智能合约代码设定的规则的约束。

尽管Lista DAO已经严格设计了我们的平台并审计了我们的代码，但可能还有其他未预见的风险，因此并非所有风险都可以完全排除。任何DeFi协议和投资都带有风险。Lista DAO已经在网上公开了我们的代码和审计报告，用户可以自行评估风险。

Lista DAO目前处于初始开发阶段，存在各种不可预见的风险。您承认并同意，参与获取LISTA、持有LISTA以及使用LISTA参与Lista DAO存在众多风险。在最坏的情况下，这可能导致持有的LISTA全部或部分损失。如果您决定获取LISTA或参与Lista DAO，您明确承认、接受并承担以下风险：

■ 不确定的法规和执法行动：Lista DAO、LISTA和分布式账本技术在许多司法管辖区的监管状态不明确或未定。数字资产的监管已成为全球所有主要国家监管的主要目标。无法预测监管机构何时、如何或是否会对此类技术及其应用（包括LISTA和/或Lista DAO）应用现有法规或制定新法规。监管行动可能以各种方式对LISTA和/或Lista DAO产生负面影响。如果监管行动或法律或法规的变更使得在某个司法管辖区的运营变得非法或商业上不可取，Lista DAO或其任何关联公司可能会停止在该司法管辖区的运营。在咨询了广泛的法律顾问以尽可能降低法律风险后，Lista DAO已与GS Legal LLC的专业区块链部门合作，获得了关于代币分发的法律意见，并将按照市场惯例开展业务。

■ 信息披露不充分：截至本文之日，Lista DAO仍在开发中，其设计概念、共识机制、算法、代码和其他技术细节及参数可能会不断且频繁地更新和变更。虽然本材料包含了与Lista DAO相关的最新信息，但它并不是绝对完整的，可能仍会不时由Lista DAO团队调整和更新。Lista DAO团队既没有能力也没有义务向LISTA持有者通报每一个细节（包括开发进展和预期里程碑），因此信息披露不充分是不可避免且合理的。

■ 开发失败：Lista DAO的开发可能无法按计划执行或实施，原因多种多样，包括但不限于任何数字资产、虚拟货币或LISTA价格的下降、未预见的技术困难以及活动资金不足。

■ 安全弱点：黑客或其他恶意团体或组织可能以各种方式干扰LISTA和/或Lista DAO，包括但不限于恶意软件攻击、拒绝服务攻击、基于共识的攻击、Sybil攻击、smurfing和spoofing。此外，第三方或Lista DAO或其关联公司的成员可能有意或无意地在LISTA和/或Lista DAO的核心基础设施中引入弱点，这可能对LISTA和/或Lista DAO产生负面影响。此外，密码学和安全创新的未来高度不可预测，密码学的进步或技术进步（包括但不限于量子计算的发展）可能通过使支持该区块链协议的密码学共识机制失效，给LISTA和/或Lista DAO带来未知风险。

■ 解散风险：像Lista DAO这样的早期项目涉及高度风险。面对初创公司的财务和运营风险是重大的，上述实体并不免疫这些风险。初创公司经常在产品开发、营销、融资和一般管理等领域遇到意外问题，这些问题往往无法解决。由于任何数量的原因，包括但不限于加密和法定货币价值的不利波动、由于Lista DAO的负面采用而导致LISTA的实用性下降、商业

[Previous路线图chevron-left](https://docs.bsc.lista.org/zh-cn/jian-jie/roadmap) [NextLISTAchevron-right](https://docs.bsc.lista.org/zh-cn/zhi-li/lista)

Last updated 1 day ago

Was this helpful?