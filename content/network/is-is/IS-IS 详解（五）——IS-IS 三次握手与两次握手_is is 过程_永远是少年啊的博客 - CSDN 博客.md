> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/119997450)

今天继续给大家介绍 IS-IS 相关内容。本文主要内容是 IS-IS 的邻居建立过程。  
推荐阅读：  
[IS-IS 详解（一）——IS-IS 基础](https://blog.csdn.net/weixin_40228200/article/details/119927300)  
[IS-IS 详解（二）——IS-IS 邻居建立](https://blog.csdn.net/weixin_40228200/article/details/119954928)  
[IS-IS 详解（三）——IS-IS 报文结构与功能](https://blog.csdn.net/weixin_40228200/article/details/119974141)  
[IS-IS 详解（四）——IS-IS Hello 报文详解](https://blog.csdn.net/weixin_40228200/article/details/119974828)

一、[三次握手](https://so.csdn.net/so/search?q=%E4%B8%89%E6%AC%A1%E6%8F%A1%E6%89%8B&spm=1001.2101.3001.7020)建立邻居
----------------------------------------------------------------------------------------------------------

在之前的文章中，我们介绍过，IS-IS 有两种类型的链路类型，一种是广播型链路，另一种是 P2P 链路，在这两种链路上 IS-IS 邻居的建立略有不同。IS-IS 建立邻居的方式可以分为两种，一种是三次握手建立邻居，另一种是两次握手建立邻居。在广播型链路上，只能采用三次握手的方式建立邻居，而在 P2P 链路上，既可以采取三次握手的方式建立邻居，也可以采用两次握手的方式建立邻居。在默认情况下是三次握手，但是可以修改为两次握手方式。在广播型链路上，IS-IS 协议的目的 MAC 地址 L1 级别的为 0180-C200-0014，L2 级别的为 0180-C200-0015，而如果将以太网链路修改为 P2P 类型，则目的 MAC 地址为 0900-2B00-0005。

二、两次握手建立邻居
----------

P2P 链路上，当采用两次握手建立邻接关系时，只要路由器收到对方的 Hello 包状态就处于 UP 状态。邻居建立更快，但是可靠性较差。  
在接口模式上执行命令：

```
isis ppp-negotiation 2-way
```

可以将链路的接口邻接关系建立方式改为两次握手。

在接口模式上执行命令：

```
isis ppp-negotiation 3-way
```

可以将链路上的接口邻接关系建立方式设置为三次握手，事实上，这也是 IS-IS 路由器上的默认配置。此时链路与对端路由器建立邻接关系使用三次握手，但是当对端路由器使用两次握手时，本端也会兼容对端路由器的两次握手机制。

在接口模式上执行命令：

```
isis ppp-negotiation 3-way only
```

可以使得本端链路采用三次握手机制与对端建立邻接关系，但是不兼容对端两次握手建立邻接关系方式。

三、建立邻居方式判定
----------

那么运行 IS-IS 协议的路由器是如何判定对端如何与自己建立邻居呢？  
如果采用两次握手建立邻接关系，则 Hello 报文的 TLV 字段不会出现 P2P Adjacent State 字段，而当采用三次握手建立邻接关系时，Hello 报文的 TLV 字段会出现 P2P Adjacent State 字段。凭借 P2P Adjacent State 字段，就可以通过对端发送的 Hello 包从而判定对端建立邻居的方式了。  
当采用三次握手方式建立邻居时发送的 Hello 数据包：  
![](https://img-blog.csdnimg.cn/337fb72daf8a4a65a117e7cd1aa6cb7f.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
当采用两次握手方式建立邻居时发送的 Hello 数据包：  
![](https://img-blog.csdnimg.cn/03eb83f0983d4e09a6c24c2190927f3c.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/119997450