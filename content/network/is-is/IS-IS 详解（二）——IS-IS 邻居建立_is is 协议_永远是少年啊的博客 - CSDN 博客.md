> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/119954928)

从今天开始，给大家介绍 IS-IS 协议相关内容。本文主要内容为 IS-IS 报文和 IS-IS 邻居建立相关内容。  
推荐阅读：  
[IS-IS 详解（一）——IS-IS 基础](https://blog.csdn.net/weixin_40228200/article/details/119927300)

一、IS-IS 报文简介
------------

IS-IS 协议中一共定义了 9 中报文类型，大致可以分为三种：  
**1、Hello 报文。**  
Hello 报文主要用于建立和维持邻居关系，根据链路和邻居级别又可以分为一下三种：  
（1）L1 Hello 报文。  
用于在广播型链路上建立 L1 的邻居。  
（2）L2 Hello 报文。  
用于在广播型链路上建立 L2 的邻居。  
（3）P2P Hello 报文。  
用于在 P2P 链路上建立 L1 和 L2 的邻居。  
**2、LSP 报文。**  
LSP 报文主要用于描述携带的 LSA（链路状态信息），可以细分为两种：  
（4）L1 LSP  
用于描述非骨干区域链路状态表  
（5）L2 LSP  
用于描述骨干区域链路状态表  
**3、SNP 报文。**  
SNP 报文用于维护 LSDB 的完成和同步。该报文可以分为以下四类：  
（6）L1 CSNP  
L1 级别的完全序列号 PDU，类似 OSPF DD 报文。  
（7）L2 CSNP  
L2 级别的完全序列号 PDU，类似 OSPF DD 报文。  
（8）L1 PSNP  
L1 级别的部分序列号 PDU，类似于 OSPF 的 LSR 和 LSACK。  
（9）L2 PSNP  
L2 级别的部分序列号 PDU，类似于 OSPF 的 LSR 和 LSACK。

二、IS-IS 邻居状态
------------

与 OSPF 协议不同，IS-IS 协议一共定义了三种邻居状态，如下所示：  
**1、Down。** 没有收到邻居 Hello 包时处于 Down 状态。  
**2、Initiated。** 收到邻居 Hello 包，但是在 Hello 包中没有发现自己的信息，也称为 one-way 状态。  
**3、Up。** 收到邻居 Hello 包，并发现自己的信息。  
可以看出，IS-IS 仅仅根据 Hello 包的交互情况来定义自己的状态，并没有链路状态信息的相关状态。

三、IS-IS 邻居建立
------------

IS-IS 邻居建立过程如下：

### （一）广播型链路邻居关系建立

在广播型链路上，IS-IS 邻居的建立采用三次握手机制，流程如下：  
![](https://img-blog.csdnimg.cn/576d9bdc006e404a8b4d267060e501b2.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)  
此外，如果数据包发送的次序稍有变化，R2 在收到 R1 发送的 Hello 包之前发送了自身的 Hello 包，还有可能是以下情况：  
![](https://img-blog.csdnimg.cn/d49be36217964035827ff02eb928f176.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)  
从中可以看出，在广播行链路上，双方邻居关系的建立要经过一个三次握手过程，才能最终完成邻居关系的建立。  
注意：以上示意图中发送的数据包都是 Hello 包，并且没有涉及到链路状态数据信息的发送过程。

### （二）P2P 链路邻居关系建立

与广播型链路稍有区别，P2P 链路上建立 IS-IS 邻居可以采用根据配置，采取三次握手或者两次握手的方式建立 IS-IS 邻居关系。当采用两次握手建立邻居时，只要收到对端的 Hello 包就处于 Up 状态，这样邻居建立更快，但是可靠性有所降低，尤其是当采用的线路采用光纤时，有可能存在单向通路的状况，这有可能导致 IS-IS 邻居建立了单向邻居。  
两次握手时 P2P 邻居关系建立过程如下：  
![](https://img-blog.csdnimg.cn/bdd83d312cef4d739812099906fd0319.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/119954928