> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/120028239)

今天继续给大家介绍 IS-IS 相关内容。本文主要内容是深入探究 IS-IS 协议区域间路由环路的防止和次优路径的防止。  
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
[IS-IS 详解（十）——IS-IS 骨干区域与非骨干区域访问进阶](https://blog.csdn.net/weixin_40228200/article/details/120027596)

一、IS-IS 路由泄露后防路由环路
------------------

在 IS-IS 路由协议中，如果没有配置区域间路由泄露，则因为此时 L1/2 路由器只会把 L1 区域的明细路由下发到 L2 区域，而 L1 区域访问 L2 区域则是通过生成默认路由，因此只要规定 L1/2 路由器不会把其他 L1/2 路由器不会根据其他 L1/2 路由器下发的 ATT 比特位置 1 的 LSP 计算生成默认路由，就不会出现路由环路问题。  
而如果 IS-IS 协议的 L1/2 路由器如果做了区域间路由泄露，则虽然 L2 级别的明细路由能够传递到 L1 区域，但是也由此带来了 IS-IS 的区域间路由环路风险。  
在 [IS-IS 详解（十）——IS-IS 骨干区域与非骨干区域访问进阶](https://blog.csdn.net/weixin_40228200/article/details/120027596)中，我们介绍了由于 IS-IS 协议中 L1 路由优于 L2 路由，因此可以防止 L1 路由经过 L1/2 路由器传递到 L2 区域后又传递回 L1 区域。然而，要想避免区域间路由环路，还必须使得 L2 的路由在经过 L1/2 传递到 L1 区域后，不会再传递会 L2 区域。  
要想实现上一目的，就必须使 L1/2 路由器区分 L1 区域的路由和由 L1/2 路由器转化来的 L2 区域的路由。因此，IS-IS 的 L1/2 路由器在路由泄露中将 L2 区域的路由引入 L1 区域时，会将 L2 区域的明细路由使用 DU 比特位进行置位。  
DU 比特位全称为 Distribution，是 IP Internal Reachability TLV 中每个 IP 路由的一个比特为，当该比特为 0 时，为 Up 状态，当该比特位为 1 时，为 down 状态。L1/2 会把普通的 L1 路由的 DU 比特位置 0，而把由 L2 区域经过路由泄露泄露到 L1 区域的路由的 DU 为置 1，形成 L1 级别的 LSP 后下发。  
DU 置位的 LSP 报文如下：  
![](https://img-blog.csdnimg.cn/ccc39790bf174e7488575c2a9b877c84.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
在 L1 级别的路由器上，如果查看某一条 LSP 的详细信息，IP-Internal 后面有星号的就是 DU 比特位置位的路由，如下所示：  
![](https://img-blog.csdnimg.cn/39e541dd69c04e71abbecab6e9368a09.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
这样，我们只要规定，L1/2 路由器不会把 L1 区域中 DU 比特位为 1 的路由再次传递会 L2 区域，就解决了在引入 IS-IS 区域间路由泄露后的路由防环问题了。  
总的来说，在 IS-IS 协议中，如果进行了区域间路由泄露，可以通过 L1 路由优先于 L2 路由防止 L1 路由在传递到 L2 后传递回 L1；可以通过 L1/2 路由器不学习 DU 位为 1 的机制防止 L2 路由在泄露到 L1 后传递回 L2，以此避免了 IS-IS 区域间路由环路问题。

二、IS-IS 区域访问防次优路径
-----------------

解决了 IS-IS 区域间路由环路问题，IS-IS 区域间路由泄露后还存在次优路径的问题。

### （一）IS-IS 区域间次优路径产生原因

假设一个网络场景中拓扑图如下所示，并且在 R1 和 R3 路由器上配置了路由泄露，如下所示：  
![](https://img-blog.csdnimg.cn/16e30a4f8cf5470594a8b4f71fa9345e.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)  
上述路由拓扑中可能存在次优路径。假设 R4 上存在一条 4.4.4.4/32 的路由，则该路由的传递如图上红线所示，对于路由器 R3 而言，它会从 R2 和 R4 同时收到前往 4.4.4.4/32 的路由。但是，由于 R3 从 R2 收到的路由为 L1 级别的路由，从 R4 收到的路由为 L2 级别的路由。根据 IS-IS 协议选路规则，L1 级别的路由要优于 L2 级别的路由，因此 R3 会优先选择 R2 的 L1 的路由，由此形成了次优路径。

### （二）IS-IS 区域间次优路径避免

那么上述 IS-IS 区域间次优路径应该如何避免呢？  
其实，IS-IS 协议本身可以进行 IS-IS 区域键次优路径的避免，上述情况不会出现。这是因为 IS-IS 协议除了 L1 级别的路由优先与 L2 级别的路由外，还规定了 L2 级别的路由优先于 DU 置 1 的 L1 级别的路由。  
这样，考虑到上述场景，由于 R3 收到的 R2 传递来的路由是 DU 置 1 的路由，因此该路由的优先级要低于直接从 R4 学到的路由，从而避免了次优路径。  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/120028239