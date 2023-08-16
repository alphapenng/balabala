> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/120018001)

今天继续给大家介绍 IS-IS 相关内容。本文主要内容是 IS-IS 的报文结构、各字段作用以及 LSP 报文的抓包。  
阅读本文，您需要有一定的 IS-IS 基础，如果您对此存在困惑，欢迎查阅我博客的其他内容，相信您一定会有所收获。  
推荐阅读：  
[IS-IS 详解（一）——IS-IS 基础](https://blog.csdn.net/weixin_40228200/article/details/119927300)  
[IS-IS 详解（二）——IS-IS 邻居建立](https://blog.csdn.net/weixin_40228200/article/details/119954928)  
[IS-IS 详解（三）——IS-IS 报文结构与功能](https://blog.csdn.net/weixin_40228200/article/details/119974141)  
[IS-IS 详解（四）——IS-IS Hello 报文详解](https://blog.csdn.net/weixin_40228200/article/details/119974828)  
[IS-IS 详解（五）——IS-IS 三次握手与两次握手](https://blog.csdn.net/weixin_40228200/article/details/119997450)  
[IS-IS 详解（六）——IS-IS LSP 机制详解](https://blog.csdn.net/weixin_40228200/article/details/120004588)

一、LSP 报文格式
----------

LSP 报文，即 Link State PDUs，是 IS-IS 的链路状态报文，用于交换链路信息。LSP 分为 L1 LSP 和 L2 LSP，不同级别的 LSP 除了级别外差距不大，各字段基本相同。LSP 报文也符合 IS-IS 报文的基本格式，由 ISO 头部、LSP 报文头部和 TLV 字段构成。  
其中 LSP 头部报文格式如下：  
![](https://img-blog.csdnimg.cn/5aa9ee14205f40dd8f353c367c18e5d2.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

二、LSP 报文各字段项详解
--------------

LSP 报文各字段作用和功能如下：  
**1、PDU Lengths。** PDU 的总长度，单位为 Byte。  
**2、Remaining Lifetime。** LSP 生存时间，单位为 s。  
**3、LSP ID。** LSP ID，由 System id，伪节点标识符和分片标识符三部分组成，唯一标识一条 LSP 报文。  
**4、Sequency Number。** LSP 的序列号。  
**5、Checksum。** LSP 的校验和。  
**6、P（Partition Repair）。** 仅与 L2 LSP 有关，表示路由器是否支持修复区域分割。  
**7、ATT（Attachment）。** 一般由 L1/2 路由器产生，用于控制 L1 区域对 L2 区域的路由学习情况。  
**8、OL（LSDB Overload）。** 过载标志位。  
**9、IS Type。** 生成的 LSP 的路由器的级别，用来指名是 L1 的路由器还是 L2 的路由器。

三、LSP 报文抓包
----------

使用 wireshark，对 LSP 报文抓包显示如下：  
![](https://img-blog.csdnimg.cn/d372b319b36a42309d424aa52a64c1f5.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16)  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/120018001