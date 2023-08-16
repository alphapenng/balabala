> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/119974828)

从今天开始，给大家介绍 IS-IS 协议相关内容。本文主要内容是 IS-IS Hello 报文的相关结构和作用。  
推荐阅读：  
[IS-IS 详解（一）——IS-IS 基础](https://blog.csdn.net/weixin_40228200/article/details/119927300)  
[IS-IS 详解（二）——IS-IS 邻居建立](https://blog.csdn.net/weixin_40228200/article/details/119954928)  
[IS-IS 详解（三）——IS-IS 报文结构与功能](https://blog.csdn.net/weixin_40228200/article/details/119974141)

一、Hello 包发送原则
-------------

可以通过在 IS-IS 视图中修改 IS-IS 的级别来控制 IS-IS [路由器](https://so.csdn.net/so/search?q=%E8%B7%AF%E7%94%B1%E5%99%A8&spm=1001.2101.3001.7020)发送的 Hello 包类型，同时，在运行 IS-IS 协议的接口上，也可以修改 IS-IS 的级别，而这也会对 Hello 包的发送造成影响，实际上，Hello 包的发送有一个较为复杂的原则，具体如下：  
L1 和 L2 路由器在广播型链路上，只发相应级别的 Hello 包，此时发送的 Hello 级别只与 IS-IS 视图下配置的路由器级别有关，而与接口上配置的 IS-IS 链路级别无关。  
默认情况下，L1/2 路由器在广播型链路上既发送 L1 的 Hello 包，也发送 L2 的 Hello 包。但是 L1/2 路由器发送 Hello 包的类型收到链路上配置的 IS-IS 级别的影响，当链路上配置 IS-IS 级别为 L1 时，则该路由器在该链路上只发 L1 的 Hello 包，当链路上配置 IS-IS 级别为 L2 时，则该路由器在该链路上只发 L2 的 Hello 包。

二、Hello 报文结构
------------

### （一）广播型链路上 Hello 包头

![](https://img-blog.csdnimg.cn/a9262c6b259143c5bc72e09bd2be7ef2.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

### （二）P2P 链路上 Hello 包头

![](https://img-blog.csdnimg.cn/ffd85f64a24a46a5896049a2a67bd465.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

三、Hello 报文各字段功能
---------------

### （一）Hello 包头字段详解

Hello 包头字段功能如下：  
**1、Reserved/Circuit Type。** 表示路由器级别，0x01 表示 L1 级别，0x02 表示 L2 级别，0x03 表示 L1/2 级别（注：此字段与链路上 IS-IS 级别也有关系，当必须路由器级别和接口级别均为 L1/2，此时此字段才为 L1/2，具体规则如本文第一章介绍相同）。  
**2、Source ID。** 发送报文的 IS-IS 路由器 SID，占 6Byte。  
**3、Holding Time。** 保持计时器，单位为秒，占用 2Byte，默认为 Hello-Interval 的三倍。本字段的含义是告诉邻居本端失效的时间。这里 IS-IS 协议与 OSPF 不同，IS-IS 允许建立邻居的相邻路由器之间 Hello-Interval 和 Holding Time 不一致。可以在路由器 IS-IS 视图下修改本字段时间，但是有一定的限制。  
**4、PDU Length。** 本字段表示整个 IS-IS 报文的长度，包括头部、Hello 报文以及后面的 TLV 字段的长度，占用 2Byte。  
**5、Priority。** 表示优先级，占用 1Byte，但是该字段值使用了 7 个 bit，因此该字段取值范围是 0-127。该字段主要用于 DIS 的选举，且该字段越大越优先。当该字段值相等时，则比较 MAC 地址，越大越优先。  
**6、R。** 预留字段，用 0 填充。  
**7、LAN ID。** 用于描述链路上的伪节点 DIS。  
**8、Local Circuit ID。** 表示本地链路 ID。  
实际上，在 Hello 报文头字段，广播型链路上的 Hello 包和 P2P 链路上 Hello 包的区别在于广播型有独有的 LAN ID 和 Priority 字段，而 P2P 链路上有独有的 Local Circuit ID 字段。

### （二）Hello 包常见 TLV 字段功能

TLV 机制即 Type（类型）、Length（长度）和 Value（值）的意思。  
TLV 机制允许路由协议只携带需要的属性，不需要的属性可以不携带，扩展性强，如果协议需要支持新的特性，则只需要开发新的 TVL 属性即可支持。在使用 wireshark 抓包时，如果字段的前面有一个 “>” 符号，则代表该字段为一个 TLV 字段。  
Hello 包常见的 TLV 字段如下：  
**1、Area Address。** 区域地址，考虑到 IS-IS 协议中可配置 3 个以内的区域地址，因此该字段长度并不固定，因此该字段放在了 TLV 字段中。  
**2、IS Neighbor。** 中间系统邻居，在广播型链路上，该字段使用邻居的 MAC 地址表示，但是在 P2P 链路上该字段使用路由器的 System ID 表示。  
**3、IP Interface Address。** 接口 IP 地址。如果一个接口配置了多个 IP 地址，IS-IS 协议默认携带所有的 IP 地址。  
**4、Protocol Supported。** 表示本路由器支持的协议。  
**5、Restart Signaling。** 主要用于重启动时使用。  
**6、Muti Topology。** 主要用于多拓扑时使用。  
**7、Padding 。** 填充字段，该字段全为 0。

四、Hello 抓包展示
------------

### （一）广播链路上 IS-IS Hello 包

![](https://img-blog.csdnimg.cn/99310124c62a4c0d99d132690eba4312.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)

### （二）P2P 链路上 Hello 包

![](https://img-blog.csdnimg.cn/ee0b05d4875b48b6b23c96be806f7659.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/119974828