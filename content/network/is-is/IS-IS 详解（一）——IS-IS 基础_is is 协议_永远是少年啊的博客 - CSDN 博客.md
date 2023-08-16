> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/119927300)

从今天开始，给大家介绍 IS-IS 协议相关内容。本文主要内容是 IS-IS 网络模型、历史、路由器级别、区域划分和 IS-IS 地址的相关内容。  
后续还将继续推出相关内容，欢迎您关注我的博客。

一、IS-IS 简介
----------

所谓 IS-IS，就是 Intermediate System-to-Intermediate System，中间系统到中间系统的意思。  
我们都知道，目前广泛存在的是 TCP/IP 网络模型和 [OSI 模型](https://so.csdn.net/so/search?q=OSI%E6%A8%A1%E5%9E%8B&spm=1001.2101.3001.7020)。计算机网络领域，大部分路由协议和功能的实现是基于 TCP/IP 网络模型的，但是 IS-IS 协议却是基于 OSI 网络模型的一种协议，因此在各项功能的实现上与其他的路由协议略有差别。  
在 TCP/IP 网络模型中，我们把实现网络层通信的路由设备叫做路由器，而 OSI 中则称为中间系统，这也就是 IS-IS 协议中中间系统的来历。  
与 OSPF 功能类似，IS-IS 也是一种动态路由协议，与 OSPF 有很多相像的地方，也有很多不同，在学习 IS-IS 协议前，建议先学习 OSPF 的相关内容，这样可以使得 IS-IS 的学习更加顺利。  
IS-IS 最开始是基于 OSI7 层网络模型，支持 CLNP（ConnectionLess Network Protocol 无连接网络协议，相当于 OSI 的网络层协议）的网络环境，但是由于 OSI7 层网络模型没有大规模采用，因此 IS-IS 协议也没有大规模使用。但是由于 IS-IS 是在数据链路层之上的类三层网络协议，并且 IS-IS 比较灵活，因此 IS-IS 工程小组对 IS-IS 进行了扩展，使其可以支持 IPv4 和 IPv6。因此这样集成了 IPv4 和 IPv6 网络功能的 IS-IS 协议又得到了现网的广泛使用。再加上 IS-IS 具有扩展性强、收敛速度快，工作机制简单的优点，因此被 ISP 大量部署。  
目前，在企业网网络环境下，使用 IS-IS 协议比较少，大都是部署的 OSPF 协议，但是在 ISP 运行商网络中，IS-IS 协议与 OSPF 协议则处于平分秋色的地位。

二、IS-IS 地址
----------

NSAP，Network Service Access Point，网络服务接入点，是 OSI 模型中规定的网络层地址，类似于 TCP/IP 模型中的 IP 地址。  
NSAP 地址结构如下图所示：  
![](https://img-blog.csdnimg.cn/1f96aa4a2cb94620b4587079c218b820.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_47,color_FFFFFF,t_70,g_se,x_16#pic_center)  
NSAP 由 IDP（Initial Domain Part，初始域部分）和 DSP（Damian Specific Part，域特定部分）。IDP 和 DSP 长度时可变的，NSAP 总厂最多是 20 个字节，最少是 8 个字节。实际上，NSAP 地址最长长度比 IPv6 地址长度要长，因此其所支持的地址数量比 IPv6 地址还要多。  
IDP 相当于 IP 地址中的主网络号，它由 ISO 规定，并由 AFI（Area and Format Identifier，地址格式标识符）和 IDI（Initial Domain Identifier，初始域标识符）组成，AFI 表示地址分配机构的地址格式，IDI 用来标识域。  
DSP 相当于 IP 地址中的子网好和主机地址，由 High Order DSP、System ID 和 SE 了三个部分组成。High Order DSP 用来区分区域，相当于 IP 地址中的子网络号，System ID 用来区分主机，相当于 IPv4 中的主机号，SEL 用来指示服务类型，类似于 IP 协议中的协议号，用于区分上层协议类型。  
IDP 的 AFI 和 ADI 字段，加上 DSP 的 High Order DSP 字段一起构成了 NSAP 的网络号字段，也被称为 IS-IS 的 Area ID。（注意，在 IS-IS 中有两个区域的概念，除了这里的 Area 以外，还有骨干区域和非骨干区域的概念，相关知识会在本文后面讲到）Area ID 的长度为 1-13B。  
事实上，由于 Sytem ID 和 SEL 长度为固定的 6B 和 1B。因此，在计算 Area ID 时，只需要倒数 7B，剩下的地址就是 Area ID。  
在配置 IS-IS 时，尽管不需要在路由器的每个接口上配置 NSAP 地址，但是需要给每个运行 IS-IS 协议的路由器配置一个特殊的 NSAP 地址 ——NET 地址。NET 地址称为网络实体标识符，是一类特殊的 NSAP 地址，它的 SEL 部分为全 0。

三、IS-IS 路由器级别与区域
----------------

运行 IS-IS 协议的路由器，有三种级别，分别是 Level 1、Level 2 和 Level 1/2。IS-IS 协议两个路由器之间可以建立 Level 1 级别的和 Level 2 级别的邻居。（在以后的描述中简写为 L1、L2 和 L1/2）  
IS-IS 协议规定：  
L1 路由器只能建立 L1 级别的邻居；  
L2 路由器只能建立 L2 级别的邻居；  
L1/2 路由器和同区域的 L1 路由器建立 L1 级别的邻居，和 L2 路由器（不论是不是同区域）建立 L2 级别的邻居。与同区域的 L1/2 路由器建立 L1 级别的邻居，与不用区域的 L1/2 路由器建立 L1 和 L2 级别的邻居。  
总结来看，相应级别的路由器可以建立相应级别的邻居，但是 L1 级别邻居的建立要求两个路由器之间处于同一区域，而 L2 级别邻居的建立不要求两个路由器处以同一区域。  
根据 IS-IS 路由器邻居关系，可以将 IS-IS 划分为两个区域 —— 骨干区域和非骨干区域。（注意，这里的区域不是上文中提到的 Area ID）由 L2 的 IS-IS 邻居构成的区域为骨干区域，由 L1 的 IS-IS 邻居构成的区域为非骨干区域。骨干区域和非骨干区域的边界在 Level 1-2 路由器上。由于 IS-IS 没有类似于 OSPF 的 Vlink 机制，因此 IS-IS 的骨干区域必须连续。  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/119927300