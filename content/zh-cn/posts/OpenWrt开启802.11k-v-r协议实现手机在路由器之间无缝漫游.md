---
title: "OpenWrt开启802.11k-v-r协议实现手机在路由器之间无缝漫游"
date: 2022-12-02T21:14:34+08:00
draft: false
tags: ["geek","homelab"]
categories: ["geek"]
authors:
- alphapenng
---

![toc](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_07_epB5YQ.png)

## mesh 路由器基本概念

`以一张脑图梳理一下 mesh 路由器的基本概念`

![mesh](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_07_OwGgb3.png)

⚠️ **802.11k/v/r 这三个协议必须是路由器和设备同时支持才可以起作用** ⚠️

-   设备这方面我们基本不用太担心,只要不是特别老的手机基本都支持

-   另一方面不是必须 802.11k/v/r 这三个协议同时支持才能达到无缝漫游的效果，事实上现在大部分的 mesh 路由器都只支持 K 和 V 这两个协议

## OpenWrt 配置 802.11k/v/r 协议实现无缝漫游

![进入lan口修改页面](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_04_IXO0rh.png)

![修改IP地址](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_04_ZQPakc.png)

![修改dhcp设置](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_04_wVqsxW.png)

![修改ipv6设置](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_04_zRVMPx.png)

![保存并应用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_04_H0W4Lr.png)

⚠️ **无线参数需要在提供 wifi 接入的设备（包括主路由和每个 AP） 上都设置一次** ⚠️

💁 **由于前面的操作我们已经关闭了 AP 的 DHCP 服务，在连接主路由之前，如果需要把 AP 接到电脑上设置，要手动指定网卡的 IP 地址**

![进入无线配置页面](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_04_Gujron.png)

![选择信道及设置wifi名称](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_oJDzOB.png)

![无缝漫游设置](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_KjEi6o.png)

![保存并应用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_sjgk94.png)

用同样的方法可以设置其他 AP 或者主路由。

当我们设置好了所有的路由器以后，将路由器部署到家里指定位置，然后测试一下信号。

安卓手机可以下载一款叫做 `wifi分析仪` 的应用，[下载链接](https://github.com/VREMSoftwareDevelopment/WiFiAnalyzer/releases)，打开后查看 wifi 详情

![wifi分析仪](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_uidQgU.png)

接着去各大应用市场下载一款叫做“WiFi 魔盒”的应用，打开后进行如下操作进入漫游测试页面

![wifi魔盒](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_ygx8pm.png)

将手机从一个路由器（AP）处慢慢移动至另一个路由器（AP）处，并再次返回，测试漫游切换功能。

![测试漫游](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_8dtuXU.png)

可以看到，漫游都是成功切换的，时间一次是 45ms，一次是 25ms，对于手机看视频等的日常应用是完全能够满足需要的，可以做到无感的，只是不要在手机玩游戏的时候频繁在房间里移动，在切换的时候还是会发生掉线。

## 总结

1. OpenWrt 系统 802.11k/v/r 漫游可以整合不同品牌路由器组成一个无缝漫游的网络

2. 可分别设置 2.4G 和 5G 是否漫游

3. 可根据使用需求单独设置信道，发射功率等参数，保证了组网的灵活性
