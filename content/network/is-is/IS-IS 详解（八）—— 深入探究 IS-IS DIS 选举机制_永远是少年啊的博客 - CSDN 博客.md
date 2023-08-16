> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/120026382)

今天继续给大家介绍 IS-IS 相关内容。本文主要内容是深入探究 IS-IS 协议中 DIS 选举机制。  
阅读本文，您需要有一定的 IS-IS 基础，如果您对此存在困惑，欢迎查阅我博客的其他内容，相信您一定会有所收获。  
推荐阅读：  
[IS-IS 详解（一）——IS-IS 基础](https://blog.csdn.net/weixin_40228200/article/details/119927300)  
[IS-IS 详解（二）——IS-IS 邻居建立](https://blog.csdn.net/weixin_40228200/article/details/119954928)  
[IS-IS 详解（三）——IS-IS 报文结构与功能](https://blog.csdn.net/weixin_40228200/article/details/119974141)  
[IS-IS 详解（四）——IS-IS Hello 报文详解](https://blog.csdn.net/weixin_40228200/article/details/119974828)  
[IS-IS 详解（五）——IS-IS 三次握手与两次握手](https://blog.csdn.net/weixin_40228200/article/details/119997450)  
[IS-IS 详解（六）——IS-IS LSP 机制详解](https://blog.csdn.net/weixin_40228200/article/details/120004588)  
[IS-IS 详解（七）——IS-IS LSP 报文详解](https://blog.csdn.net/weixin_40228200/article/details/120018001)

一、IS-IS IDS 选举机制
----------------

在 IS-IS 协议中，与 OSPF 协议类似，在广播型链路上，需要选举 DIS 来替代广播型链路伪节点发布伪节点的 LSP 信息。IDS 选举规则如下：  
1、接口优先级越大越优先。IS-IS 接口优先级默认为 64，取值范围是 0-127，执行命令：

```
isis dis-priority 120
```

可以修改当前接口的 DIS 优先级。  
2、当借口优先级相同时，则比较 IS-IS 路由器的 MAC 地址，MAC 地址越大越优先。

二、IS-IS 注意事项
------------

除了上述选举规则外，IS-IS 的 DIS 选举还有以下需要注意的点：  
1、与 OSPF 的 DR 不同，IS-IS 的 DIS 可以抢占。  
2、IS-IS 的 DIS 是分级别的，如果在一条广播型链路上既有 L1 级别的 IS-IS 邻居，也有 L2 级别的 IS-IS 邻居，则不同的邻居之间需要选举 L1 级别的 DIS 和 L2 级别的 DIS，并且这两个级别的 DIS 可以为不同的 IS-IS 路由器，在配置 IS-IS 路由器接口优先级时，也可以对分别针对 L1 和 L2 级别的 DIS 级别进行分别配置。  
3、与 OSPF 规定不同，DIS 为 0 的 IS-IS 路由器也可以进行 DIS 选举。  
4、在 IS-IS 协议中，没有 BDIS 的概念。  
5、IS-IS 伪节点 LSP 只有拓扑信息，不携带路由信息，IS-IS 协议通过与伪节点相连的实结点 LSP 描述链路上的路由信息。

三、IS-IS 中 DIS 与 OSPF 中 DR 对比
----------------------------

在学习各网络协议时，对网络协议中的具体规定进行分析，站在协议开发者的角度上考虑协议规定的科学性，是学习计算机网络及相关网络协议的一个好方法，那么具体到 IS-IS 协议，为什么 IS-IS 协议规定 DIS 可以抢占，而与 IS-IS 协议类似的 OSPF 协议规定 DR 不能抢占呢？  
针对 OSPF 来说，在广播型链路 Dother 路由器之间的邻接关系停留在 2-way 阶段，并没有形成 full 的邻接关系，如果 OSPF 路由协议允许 DR 的抢占，当一个 Dother 路由器抢占成为 DR 的过程中，会引起广播型链路上邻居关系的不断震荡，发生大面积变化，影响的设备很多。而 IS-IS 协议并没有规定 LSDB 同步过程中的邻接关系建立状态，因此在广播型链路上所有的 IS-IS 都建立起 Up 状态的邻接关系。因此，在这种情况下，DIS 不会引起邻居关系的震荡。虽然 DIS 的抢占会引起伪节点 LSP 的变化，但是考虑到目前网络设备性能上非常稳定，发生该现象的可能性比较低，再加上影响比较少，因此在稳定网络中可以忽略 DIS 抢占带来的问题，因此，IS-IS 协议规定 DIS 是可以抢战的。  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/120026382