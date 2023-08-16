> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/120004588)

今天继续给大家介绍 IS-IS 相关内容。本文主要内容是 IS-IS 的邻居建立过程。  
推荐阅读：  
[IS-IS 详解（一）——IS-IS 基础](https://blog.csdn.net/weixin_40228200/article/details/119927300)  
[IS-IS 详解（二）——IS-IS 邻居建立](https://blog.csdn.net/weixin_40228200/article/details/119954928)  
[IS-IS 详解（三）——IS-IS 报文结构与功能](https://blog.csdn.net/weixin_40228200/article/details/119974141)  
[IS-IS 详解（四）——IS-IS Hello 报文详解](https://blog.csdn.net/weixin_40228200/article/details/119974828)  
[IS-IS 详解（五）——IS-IS 三次握手与两次握手](https://blog.csdn.net/weixin_40228200/article/details/119997450)

一、IS-IS LSP 简介
--------------

从报文的角度看，IS-IS LSP 可以分为 **L1 级别的 LSP** 和 **L2 级别的 LSP**。L1 和 L2 LSP 的区别只存在于报文级别上，但是具体的内容没有差别。从用途角度看，IS-IS LSP 可以分为 **实节点 LSP** 和 **伪节点 LSP**。实结点 LSP 相当于 OSPF Type1 LSA，每台运行 IS-IS 协议的路由器都会产生，用于描述自身直连链路状态；伪节点 LSP 相当于 OSPF Type 2LSA，广播型链路上由 DIS 产生，用于描述广播型链路。  
IS-IS LSP 洪范范围是在整个区域内，执行命令：

```
dis isis lsdb
```

可以查看路由器的 IS-IS 的 LSDB，执行结果中带星号的表示自己产生的 LSP。  
执行命令：

```
dis isis lsdb  0000.0000.0001.00-00 verbose
```

可以查看某一条具体的 LSP 报文的详细信息。

二、IS-IS LSP 区分
--------------

IS-IS 协议通过 LSP ID 唯一区分一条 LSP。LSP ID 一共 8Byte，由三个部分 ——**system-id**、 **伪结点标识符**和**分片标识符**组成。  
system-id 用于标识 LSP 的产生路由器，类似于 OSPF 的 Advertised Router。伪节点标识符用于描述 IS-IS 路由器的真实链路信息，当伪节点标识符为 0 时，代表此 LSP 为实结点 LSP；当伪节点标识符不为 0 时，代表此 LSP 为伪结点 LSP，此时 system-id 为链路上 DIS 的 system-id。分片标识符用于描述同一态 IS-IS 路由器产生的不同 LSP。若需要描述的连路由信息很多，一条 LSP 无法承载时，就会使用此字段进行分片。  
LSP IDsystem-id 与伪节点标识符之间使用点号隔开，伪节点标识符和分片标识符之间使用短杠隔开。

三、IS-IS LSP 新旧判断
----------------

当一个 IS-IS 路由器收到一条本地已经存在的 LSP 时，就要进行 LSP 新旧判断机制，然后根据判断结果进行不同的处理。LSP 新旧判断采用如下机制：  
1、若收到的 LSP 序列号大于本地 LSP，就替换为新报文，并广播新 LSP 内容；若收到的 LSP 序列号小于本地的 LSP 序列号，则不接受该报文，同时向收到该报文的接口发送本地 LSP 报文。  
2、若收到的 LSP 和本地的 LSP 序列号相等，则判断剩余老化时间是否为 0，若为 0，则表示为最新的 LSP。剩余老化时间为 0 的 LSP 常常被产生该 LSP 的路由器用来删除一条 LSP。但是，不能使用这种方式修改一条 LSP。

*   PS：在默认情况下，IS-IS 路由器每个 15 分钟（即 900s），周期性的泛洪更新 LSP，同时序列号加 1。而 IS-IS 一条 LSP 的老化时间默认为 20 分钟（即 1200s）。

3、若收到报文序列号相同，且 Remaining Time 都不为 0，则比较 checksum，越大越优先。  
4、若 checksum 相同，则认为是相同的 LSP。  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/120004588