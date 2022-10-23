---
title: "Tailscale 异地组网实践：Headscale 的部署方法和使用"
date: 2022-10-10T22:56:20+08:00
draft: true
tags: ["geek","homelab"]
categories: ["geek"]
authors:
- alphapenng
---

-   Tailscale 异地组网实践：Headscale 的部署方法和使用{.mindmap}
    -   前言
    -   为什么选择 WireGuard
    -   Tailscale 是什么
    -   Headscale 是什么
    -   Headscale 部署

此篇文章是参考了 👨‍💻[云原生实验室](https://icloudnative.io/)关于`WireGuard` 的[一系列文章](https://icloudnative.io/tags/wireguard/)，再根据自己的异地组网需求，在搭建自己的家庭网络后总结记录而成，也给喜欢折腾并且有同样需求的朋友提供一个参考。

## 前言

为了满足在任何地点都能访问家庭网络，并且要求带宽和延时能够达到访问家庭 NAS 观看 1080p 影片无卡顿和延迟的观感，在斟酌众多内网穿透技术后，觉得还是通过 VPN 协议来组建大内网比较靠谱。至于该选择哪种 VPN， 在比较了各种 VPN 协议之间的优劣后，最终决定使用 WireGuard 协议来组建。

## 为什么选择 WireGuard

WireGuard 相比于传统 VPN 的核心优势是没有 VPN 网关，所有节点之间都可以点对点（P2P）连接，通过 WireGuard 既可以搭建依靠中继服务器为中心的星型网络结构，也可以通过所有节点的点对点连接组建 全互联模式（full mesh），。
