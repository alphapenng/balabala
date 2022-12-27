---
title: "家庭网络homelab搭建记录"
date: 2022-12-05T16:27:15+08:00
draft: true
tags: ["geek","homelab"]
categories: ["geek"]
authors:
- alphapenng
---

## 家庭网络 homelab 拓扑图

![home_lab_diagram](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221226082316_homelab-network-diagram.png)

## 搭建过程

1. 红米 AX6 路由器解锁 SSH 并刷入 Openwrt 固件，此款红米 AX6 路由器是我从咸鱼淘的，入了两台，主要是为了改善家里无线信号覆盖问题。在解锁 SSH 后通过 uboot 方法刷入了 Openwrt 固件，相关教程详见[红米 AX6 解锁 SSH 安装 ShellClash 及刷机 Openwrt 教程](https://alphapenng.github.io/zh-cn/2022/10/06/%E7%BA%A2%E7%B1%B3-ax6-%E8%A7%A3%E9%94%81-ssh-%E5%88%B7%E6%9C%BA-openwrt-%E6%95%99%E7%A8%8B/)

2. 光猫设置桥接记录见[EPON 上行 E8 C 家庭网关（烽火 HG220GS） telecomadmin 密码获取及桥接设置](https://alphapenng.github.io/zh-cn/2022/11/21/epon-%E4%B8%8A%E8%A1%8C-e8-c-%E5%AE%B6%E5%BA%AD%E7%BD%91%E5%85%B3%E7%83%BD%E7%81%AB-hg220gs-telecomadmin-%E5%AF%86%E7%A0%81%E8%8E%B7%E5%8F%96%E5%8F%8A%E6%A1%A5%E6%8E%A5%E8%AE%BE%E7%BD%AE/)

3. 两台 AX6 路由器（Openwrt 系统）实现无缝漫游，详情见[OpenWrt 开启 802.11k-v-r 协议实现手机在路由器之间无缝漫游](https://alphapenng.github.io/zh-cn/2022/12/02/openwrt%E5%BC%80%E5%90%AF802.11k-v-r%E5%8D%8F%E8%AE%AE%E5%AE%9E%E7%8E%B0%E6%89%8B%E6%9C%BA%E5%9C%A8%E8%B7%AF%E7%94%B1%E5%99%A8%E4%B9%8B%E9%97%B4%E6%97%A0%E7%BC%9D%E6%BC%AB%E6%B8%B8/)

4. 家庭网络和工作网络及外出移动网络间进行异地组网互访， 详情见[OpenWrt 开启 802.11k-v-r 协议实现手机在路由器之间无缝漫游](https://alphapenng.github.io/zh-cn/2022/12/02/openwrt%E5%BC%80%E5%90%AF802.11k-v-r%E5%8D%8F%E8%AE%AE%E5%AE%9E%E7%8E%B0%E6%89%8B%E6%9C%BA%E5%9C%A8%E8%B7%AF%E7%94%B1%E5%99%A8%E4%B9%8B%E9%97%B4%E6%97%A0%E7%BC%9D%E6%BC%AB%E6%B8%B8/)
