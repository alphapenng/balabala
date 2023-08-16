> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/120026758)

今天继续给大家介绍 IS-IS 相关内容。本文主要内容是深入探究 IS-IS 协议中骨干区域和非骨干区域的互访机制。  
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

一、默认情况下骨干区域和非骨干区域路由传递
---------------------

### （一）骨干区域访问非骨干区域

在默认情况下，IS-IS 的 L1/2 路由器会将 L1 级别的路由作为自身直连的叶子节点进行描述，并通过 L2 级别的 LSP 在 L2 区域进行泛洪。因此，在 IS-IS 骨干区域上，IS-IS 路由器可以知道非骨干区域的路由信息，并将该路由作为 L1/2 路由器的叶子节点。这样，骨干区域就可以访问非骨干区域了。

### （二）非骨干区域访问骨干区域

在默认情况下，L1/2 的路由器不会如上述骨干区域访问非骨干区域一样，将 L2 级别的路由信息转化成 L1 级别的 LSP 在非骨干区域进行泛洪。而是类似于 OSPF 的完全末梢区域，下发一条缺省路由访问骨干区域。  
但是，这条缺省路由并不是有 L1/2 路由器主动下发，而是借助 ATT 比特位，由非骨干区域 IS-IS 路由器主动计算得到的。

### （三）骨干区域和非骨干区域下 IS-IS 路由表查看

下面我以一个简单的 IS-IS 拓扑图向大家展示一下 IS-IS 的骨干区域和非骨干的路由表情况，实验拓扑如下：  
![](https://img-blog.csdnimg.cn/4575dd7dea304e40b74adc6c5475a25d.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
骨干区域 IS-IS 路由表如下：  
![](https://img-blog.csdnimg.cn/b569e63ab50e44faa96271233ac264e0.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
非骨干区域 IS-IS 路由表如下：  
![](https://img-blog.csdnimg.cn/30795a5d18cb4a4493054dc6a4cc7f74.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)

二、IS-IS 非骨干区域缺省路由计算
-------------------

ATT 比特为一个 IS-IS 报文中特殊的 TLV 字段，当 ATT 位为 1 时，表明 L1/2 路由器和骨干区域连接着。ATT 比特位置 1 还要求 L1/2 路由器至少存在一个不再共同区域的 L2 的邻居。ATT 比特位只会在 L1 的 LSP 中置 1。  
如果在路由器上查看 IS-IS 的 LSDB，就可以看出哪些 LSP 的 ATT 为置 1，如下所示。  
![](https://img-blog.csdnimg.cn/bd913df5704845c6a9cb47f58395035f.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
ATT 位置 1 的 LSP 如下所示：  
![](https://img-blog.csdnimg.cn/98b808a15357478295025fa0da047a0a.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
L1 区域的 IS-IS 路由器在收到 ATT 位置 1 的 LSP 报文后，就知道该 LSP 报文的发送方是 L1/2 路由器。由于 L1 路由器和 L1/2 路由器在同一个区域，所以 L1 的路由器将会自动在路由表中生成一条指向 L1/2 路由器的缺省路由，该路由的下一跳为 L1/2 路由器的下一跳，该路由的开销为到 L1/2 路由器的 SPF 树的开销。  
同时，如果在一个区域内存在多个 L1/2 路由器，则批次不进行缺省路由的计算，防止出现路由环路。

三、通过缺省路由访问骨干区域存在问题和优势
---------------------

### （一）通过缺省路由访问骨干区域存在问题

1、无法感知明细路由状态，失去了路由细度，当外部路由失效时，浪费带宽。  
2、明细路由缺失，导致可能出现次优路径。  
3、明细路由确实，导致 MPLS 网络中 LSP 无法正常建立。

### （二）通过缺省路由访问骨干区域优势

1、收敛更快，无法维护明细路由。  
2、节省设备资源。  
3、增强网络稳定性。  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/120026758