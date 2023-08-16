> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/120027596)

今天继续给大家介绍 IS-IS 相关内容。本文主要内容是深入探究 IS-IS 协议中骨干区域与非骨干区域访问的深层次内容。  
阅读本文，您需要有一定的 IS-IS 基础，如果您对此存在困惑，欢迎查阅我博客的其他内容，相信您一定会有所收获。  
推荐阅读：  
[IS-IS 详解（一）——IS-IS 基础](https://blog.csdn.net/weixin_40228200/article/details/119927300)  
[IS-IS 详解（二）——IS-IS 邻居建立](https://blog.csdn.net/weixin_40228200/article/details/119954928)  
[IS-IS 详解（三）——IS-IS 报文结构与功能](https://blog.csdn.net/weixin_40228200/article/details/119974141)  
[IS-IS 详解（四）——IS-IS Hello 报文详解](https://blog.csdn.net/weixin_40228200/article/details/119974828)  
[IS-IS 详解（五）——IS-IS 三次握手与两次握手](https://blog.csdn.net/weixin_40228200/article/details/119997450)  
[IS-IS 详解（六）——IS-IS LSP 机制详解](https://blog.csdn.net/weixin_40228200/article/details/120004588)  
[IS-IS 详解（七）——IS-IS LSP 报文详解](https://blog.csdn.net/weixin_40228200/article/details/120018001)  
[IS-IS 详解（八）—— 深入探究 IS-IS DIS 选举机制](https://blog.csdn.net/weixin_40228200/article/details/120026382)  
[IS-IS 详解（九）——IS-IS 骨干区域与非骨干区域访问基础](https://blog.csdn.net/weixin_40228200/article/details/120026758)

一、IS-IS 路由器 ATT 比特位控制位相关命令
--------------------------

在 [IS-IS 详解（九）——IS-IS 骨干区域与非骨干区域访问基础](https://blog.csdn.net/weixin_40228200/article/details/120026758)中我们提到过在默认情况下，IS-IS 的 L1/2 路由器会通过设置 ATT 位来表明自身身份，L1 的 IS-IS 路由器也会由此来计算默认路由。在华为 AR 系列路由器中，可以通过下列几个命令来对该机制进行控制，从而满足多样化拓扑组网需求。  
在 L1/2 路由器上，执行命令：

```
attached-bit advertise always
```

可以使得 L1/2 路由器在生成 L1 级别的 LSP 时，ATT 位总是置 1，而不管该路由器是否有 L2 的邻居。  
在 L1/2 路由器上，执行命令：

```
attached-bit advertise never
```

可以使得 L1/2 路由器在生成 L1 级别的 LSP 时，ATT 位总是置 0，而不管该路由器是否有 L2 的邻居。  
在 L1 路由器上，执行命令：

```
attached-bit avoid-learning
```

可以使得该 L1 级别的 IS-IS 路由器避免通过 ATT 学习到默认路由，这条命令本地有效。

二、IS-IS 区域间路由泄露
---------------

在配置 IS-IS 网络架构时，如果确实有需要，也可以使得 L1/2 路由器将 L2 区域内的明细路由作为 L1/2 路由器的叶子节点，放在 L1 的 LSP 中在 L1 区域中洪范出去，这种做法叫做 IS_SI 区域间路由泄漏。  
在 L1/2 路由器上，执行命令：

```
import-route  isis level-2 into  level-1
```

可以将 IS-IS 的 L2 路由引入 L1 区域。这样配置后非骨干区域路由器也可以知道骨干区域的路由信息。

三、IS-IS 路由泄露常见问题
----------------

如果 IS-IS 网络拓扑如下所示：  
![](https://img-blog.csdnimg.cn/92890b7911a145fd93e8c2c5d556fa35.PNG?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)  
假设 AR4 和 AR3 上配置了路由泄露相关操作，AR4 将 L2 区域的路由泄露到了 L1 区域，那么这些路由会通过 AR3 再次传递回 L1 的区域吗？  
答案是不会。对于 AR3 路由器而言，虽然会收到 AR1 路由器发送过来的 L1 区域的路由（实际上是 L2 级别的路由），但是由于 AR3 本来就域 L1 区域相连，因此，AR3 也会学习到 L1 级别的 L1 区域的相关路由。而 IS-IS 协议规定，在相同情况下，L1 级别的路由优于 L2 级别的路由，因此 AR3 不会将 AR1 传递来的 L1 区域的路由再次传递会 L1 的区域。这样可以避免路由环路。（关于 IS-IS 进行路由泄漏后的的路由防环问题是一个非常复杂非常重要的问题，我将会在后面的文章中加以详细阐述）  
但是，如果 AR3 的 G0/0/1 线路断掉，这是 AR3 就无法收到 L1 级别的 L1 区域的相关路由，这时它受到 AR1 传来的 L2 级别的 L1 区域的相关路由后，就会学习该路由。这样 AR3 通过 AR1，经 AR4 依然可以访问 AR5。同理，将上述情景拓展一下，很容易得出：当 IS-IS 的同一个非骨干区域分裂时，不会影响 IS-IS 相关路由的通信。  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/120027596