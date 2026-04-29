---
source: https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates
crawled_at: 2026-04-29T10:51:39.121943
---

![](https://docs.bsc.lista.org/~gitbook/image?url=https%3A%2F%2F1970575934-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252FqKEnrN8hBs4vtubIKxE5%252Fuploads%252Fgit-blob-b9fcc33d7f54422fa07fb7fb3725f366c8da0025%252Fimage%2520%2814%29.png%3Falt%3Dmedia&width=768&dpr=3&quality=100&sign=793c02d2&sv=2)

## [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates\#dang-qian-jie-kuan-li-l)    当前借款利率

当前借款利率是用户需要偿还贷款的利率。每当有人借款或偿还 lisUSD 时，当前借款利率都会波动并更新。

如果没有人与 lisUSD 的偿还/借款合约进行交互，那么当前借款利率将每隔几小时刷新并更新一次。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates\#xiang-xi-gui-ding)    详细规定：

1. 当前借款利率将四舍五入到8位小数。

2. 当前借款利率每5分钟更新一次。

3. 当前借款利率将根据 lisUSD 的价格变化，用户 **支付** 的借款利率将基于当前借款利率， **而不是** 预期借款利率。

4. 当用户借款或偿还 lisUSD 时，lisUSD 的需求和供应变化，因此，lisUSD 的价格变化，进而改变当前借款利率。然而，只有当 lisUSD 的价格变动超过 $0.002 时，当前借款利率才会变动。换句话说，如果 lisUSD 的价格变动等于或小于 $0.002，当前借款利率将不会改变。


## [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates\#yu-qi-jie-kuan-li-l)    预期借款利率

根据 lisUSD 的价格，lisUSD 的预期借款利率每15分钟更新一次。预期借款利率显示了你的下一笔贷款利率 **可能** 是多少，并不意味着它将成为借款利率。

如果这个预期借款利率下降，用户可能会考虑借款更多的 lisUSD，这可以降低其价格。如果它上升，用户可能会考虑提前偿还他们的贷款，以帮助提升 lisUSD 的价格。

设立预期借款利率的想法是为了间接影响 lisUSD 的需求和供应，帮助管理 lisUSD 的价格预期。这有助于保持 lisUSD 稳定在 $1。

### [hashtag](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo/current-vs-expected-borrow-rates\#xiang-xi-gui-ding-1)    详细规定：

1. 预期借款利率将四舍五入到8位小数。

2. 预期借款利率每15分钟更新一次。

3. 预期借款利率只是估计未来借款利率可能是多少，相对于 lisUSD 的价格。它并不保证预期借款利率将成为未来的当前借款利率。


[Previous算法市场操作 (AMO)chevron-left](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/lisusd/algorithmic-market-operations-amo) [NextlisUSD 的流动性chevron-right](https://docs.bsc.lista.org/zh-cn/jian-jie/collateral-debt-position-lisusd/lisusd/lisusds-liquidity)

Last updated 1 year ago

Was this helpful?