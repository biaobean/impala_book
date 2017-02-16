HUE连接Impala有很多喝想象中不一样的地方：
首先，HUE在执行完一个查询后，并不会执行close，而是不停的和Impala保持联系，因此该查询的执行状态一直为“执行中”，且所占用的资源并不会释放。具体占用的资源包括：

1. Coordinator节点上的资源；
1. 在Admission Controller中被计算的资源份额。

只有在：

1. 在页面发起下一个Impala查询；
1. 或显式关闭浏览器中的Hue页面时，浏览器会回调javascript去关闭查询。

之前的资源会被回收。也就是说如果不是显式地关闭，比如关闭电脑或浏览器崩溃，查询虽然最终会超时，但不会正确地清除资源。

在这种情况下，缓解这个问题的一种方法是使用Impalad的_--idle_session_timeout_参数，设置在一段时间后完全关闭会话和所有相关查询（但这不是在所有情况下都适用的解决方法）。

参见：https://issues.cloudera.org/browse/IMPALA-1575
