---
title: "OmniEdge 异地组网部署"
date: 2022-12-31T22:53:24+08:00
draft: false
tags: ["geek","homelab","omniedge","vpn"]
categories: ["geek"]
authors:
- alphapenng
---

## OmniEdge 是什么？

打开 OmniEdge的官网 [https://omniedge.io/](https://omniedge.io/) 可以看到它的 slogan：

> **连接 任何设备 到局域网**
> 使用 OmniEdge 的下一代异地组网 Mesh VPN，将局域网架设到网上，将任何地方的任何设备连接到局域网，实现快速的访问。

OmniEdge 的功能其实跟 WireGuard 类似，是一个 VPN 软件，可以实现远程 Mesh 互连, 组建「大」局域网。

## 为什么选择 OmniEdge？

在上一篇博文 [Tailscale 异地组网实践：Headscale 的部署方法和使用](https://alphapenng.github.io/zh-cn/2022/10/10/tailscale-%E5%BC%82%E5%9C%B0%E7%BB%84%E7%BD%91%E5%AE%9E%E8%B7%B5headscale-%E7%9A%84%E9%83%A8%E7%BD%B2%E6%96%B9%E6%B3%95%E5%92%8C%E4%BD%BF%E7%94%A8/) 中，我选择通过 Headscale + Tailscale 来组建我的「大」局域网，但在部署完成后测试各节点连通情况时，我发现我的节点之间并没有走直连方式，都是通过中继服务器来达成连接，公共的中继服务器都在国外，通过中继连接等于迂回了路由，效果不理想。虽然可以在国内云服务器上部署私有中继服务器，参考这篇文章 [Tailscale 基础教程：部署私有 DERP 中继服务器](https://icloudnative.io/posts/custom-derp-servers/)，但文中提到这种方案实现的前提是需要满足以下几个条件：

- 需要准备一台或多台云主机
- 要有自己的域名，并且申请了 SSL 证书
- 如果服务器在国内，域名需要备案

云主机我是有一台，在腾讯云上买的轻量应用服务器，享受的新用户首单特惠 88 元一年。

<div align="center"> <img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101000839_c4gT7e.png" alt="lighthouse" width="50%" /> </div>

但没有申请域名，想着申请域名要花钱还要备案，就果断放弃了。

于是我就转向了 OmniEdge，OmniEdge 也可以部署私有中继服务器，在 OmniEdge 中它叫做 Supernode。部署 Supernode 只需要云主机有公网 ip 就行了，另外 OmniEdge 的其他客户端部署也较为容易，只要跟着文档一步一步来就行了。

## Supernode 部署

1. 安装 docker 环境

    部署 Supernode 需要云主机有 docker 环境，我的云主机系统是 `Ubuntu Jammy 22.04 (LTS)`的，可以参考 docker 官方文档，按照 [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/) 指引，按步骤执行即可，最后通过 `sudo docker run hello-world` 测试是否安装成功

2. 安装 supernode

    只需要执行一条命令即可

    ```bash
    sudo docker run -d -p 7787:7787/udp omniedge/supernode:latest
    ```

    查看 supernode 是否运行

    ```bash
    sudo docker container ls
    ```

    ![container_ls](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101005124_K9ryPa.png)

    查看容器日志

    ```bash
    sudo docker logs -f <container-names>
    ```

    ![container_logs](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101005614_twHYEV.png)

    看到以上日志，就说明 supernode 启动成功了，如果日志有报错，就根据报错再排查。

3. 开启云主机防火墙 7787 端口。

    找到云主机防火墙设置页面，在防火墙设置页添加一条规则，以允许云主机开放 udp/7787 端口。

    ![firewall](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101010035_2bvbGK.png)

至此，supernode 就算部署完成了，接着我们根据需要安装客户端。

## 安装 OmniEdge 客户端

### 注册 OmniEdge，添加虚拟网络

首先访问 [OmniEdge 注册页面](https://omniedge.io/register)，注册用户，然后登录后，点击虚拟网络选项，创建虚拟网络，免费用户只能创建一个虚拟网络，不过对于只组建一个「大」局域网的我来说，已经够了。

![virtual-network](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101155001_vZc9Wq.png)

### 安装 macOS 客户端

可以参考官方文档 [Installing on MacOS](https://omniedge.io/docs/article/install/macos) 进行安装。

这里我选择安装命令行客户端

1. 安装 Tun/Tap 驱动

   - 下载驱动文件，[https://sourceforge.net/projects/tuntaposx/files/latest/download](https://sourceforge.net/projects/tuntaposx/files/latest/download)
   - 解压 `tuntap_20150118.tar.gz` 后双击 `tuntap_20150118.pkg` 进行安装
   - 在终端下运行 `sudo kextload /Library/Extensions/tap.kext`

2. 安装命令行客户端
    - 通过脚本安装：`curl https://omniedge.io/install/omniedge-install.sh | bash`
    - 然后在此页面 [https://omniedge.io/dashboard](https://omniedge.io/dashboard) 创建安全码

        ![secret-key](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101013508_UYY8u8.png)

        ![create-key](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101013839_YfQbCn.png)

        ![list-key](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101014146_BzZ8zB.png)

    - 通过刚才创建的安全码进行登录：`omniedge login -s <yoursecuritykey>`
    - 加入你创建的虚拟网络：`sudo omniedge join`
        ![join_virtual_network](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101092947_yPzu61.png)

至此，macOS 命令行客户端安装完成，接着我们安装 windows 客户端

### 安装 windows 客户端

可以参考官方文档 [Installing on Windows](https://omniedge.io/docs/article/install/windows) 进行安装。

windows 客户端安装相对简单。

1. 从 [这里](https://omniedge.io/install/download/0.2.3/omniedge-setup-0.2.3.exe) 下载 windows 安装包。下载完成后，双击运行进行安装。

2. 右键点击系统托盘上的 OmniEdge 图标，在弹出的菜单中选择“Log in...”。

    ![log_in](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101094156_uEDffB.png)

3. 登录客户端，再次打开系统托盘上的 OmniEdge 菜单，点击“Virtual Networks”，选择所要加入的虚拟网络名，点击“join”加入。

    ![join_virtual_network](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101154006_QIkWSd.png)

4. 当获取到虚拟网络IP地址后，即表示连接成功。

    ![connected](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101152134_2FrBJr.png)

至此，windows 客户端安装完成并连接成功，接着我们安装 openwrt 客户端。

### 安装 openwrt 客户端

待更新。。。

## 测试节点联通情况

回到 mac，我们打开终端，测试一下与 windows 的连通情况，输入一下命令：

```bash
# 10.1.0.1 为 windows 客户端的虚拟网络 ip
gping -4 10.1.0.1
```

gping 是一个图表化 ping 命令的开源工具，可以通过 [https://github.com/orf/gping](https://github.com/orf/gping) 下载安装。

![omniedge_test](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230101163017_tty.gif)

从测试结果可以看出，最高延时在 158ms，最低延时在 56ms，平均延时稳定在 88ms，效果还是不错的。从我的网络情况来看，两个节点之间应该是通过中继服务器连接的，能达到这种延时不错了，就是不知道直连效果怎样。无论是在客户端还是在 supernode 上，都不知道怎样查看节点之间是直连还是中继的，今后就这样使用再看看稳定性如何。
