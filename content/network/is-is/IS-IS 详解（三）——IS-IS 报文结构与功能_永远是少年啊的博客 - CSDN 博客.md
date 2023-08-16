> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_40228200/article/details/119974141)

从今天开始，给大家介绍 IS-IS 协议相关内容。本文主要内容是 IS-IS 通用报文（ISO 报文头）的结构与功能。  
推荐阅读：  
[IS-IS 详解（一）——IS-IS 基础](https://blog.csdn.net/weixin_40228200/article/details/119927300)  
[IS-IS 详解（二）——IS-IS 邻居建立](https://blog.csdn.net/weixin_40228200/article/details/119954928)

一、IS-IS 报文格式
------------

IS-IS 报文时直接封装在数据链路帧里面的。所有的 IS-IS 协议报文可以分为两个部分 —— **报文头**和 **TLV 数据段**（TLV 也被称为**变长字段部分**） 。其中报文头部又可以细分为通用头部和专用头部。对于所有的 IS-IS 报文来说，通用报头都是相同的，但是专用报头根据不同的 IS-IS 报文种类而不同。  
IS-IS 报文格式：  
![](https://img-blog.csdnimg.cn/1df4c2267fb84598a71bd6adf327c3f5.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

二、IS-IS 通用报文格式
--------------

IS-IS 通用报文也可以成为 ISO 头部，其格式如下：  
![](https://img-blog.csdnimg.cn/c4c00f6e4b9f499eb72692e4e68d6f7f.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAd2VpeGluXzQwMjI4MjAw,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

三、IS-IS 通用报文各字段作用
-----------------

**1、Interdomain Routing Protocol Discriminator。** 域内路由协议鉴别符，占用 1B，IS-IS 协议固定为 0x83  
**2、Length Indicator。** IS-IS 报文头部长度（单位为字节），包括通用报文和专用报文头部，不包括 TLV 字段，占用 1B。  
**3、Version/Protocol ID Extension。** 版本 / 协议标识扩展，固定为 0x1，占用 1B。  
**4、ID Length。** NSAP 地址中，System ID 区域的长度，长度为 1B。注意，当该字段值为 0 时，表示 System ID 长度为 6，值为 255 时，表示 System ID 长度为 0。  
**5、Reserved。** 保留字段，恒为 0。  
**6、PDU Type。** IS-IS PUD 报文类型（一共 9 种）。  
**7、Version。** IS-IS 版本，恒为 0x1。（IS-IS 通用报文头部有两个 Version 字段）  
**8、Maximum Area Address。** 同时支持的最大区域个数，占用 1B。该字段值默认值为 0，且此时的 “0”，表示支持的最大区域个数为 3。  
原创不易，转载请说明出处：https://blog.csdn.net/weixin_40228200/article/details/119974141