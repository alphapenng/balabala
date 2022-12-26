---
title: "Tailscale 异地组网实践：Headscale 的部署方法和使用"
date: 2022-10-10T22:56:20+08:00
draft: false
tags: ["geek","wireguard","homelab"]
categories: ["geek"]
authors:
- alphapenng
---

![toc](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221226163600_ha9Q2A.png)

此篇文章是参考了 👨‍💻[云原生实验室](https://icloudnative.io/)关于`WireGuard` 的[Tailscale 基础教程：Headscale 的部署方法和使用教程](https://icloudnative.io/posts/how-to-set-up-or-migrate-headscale)，再根据自己的异地组网需求，在搭建自己的家庭网络后总结记录而成，也给喜欢折腾并且有同样需求的朋友提供一个参考。

## 前言

为了满足在任何地点都能访问家庭网络，并且要求网络稳定，带宽和延时在合理的范围内，在斟酌众多内网穿透技术后，觉得还是通过 VPN 协议来组建大内网比较靠谱。至于该选择哪种 VPN， 在比较了各种 VPN 协议之间的优劣后，最终决定使用 WireGuard 协议来组建。

## 为什么选择 WireGuard

WireGuard 相比于传统 VPN 的核心优势是没有 VPN 网关，所有节点之间都可以点对点（P2P）连接，通过 WireGuard 既可以搭建依靠中继服务器为中心的星型网络结构，也可以通过所有节点的点对点连接组建全互联模式（full mesh）。这里就不展开具体细节，想深入的话可以参考这篇文章[Wireguard 全互联模式（full mesh）配置指南](https://icloudnative.io/posts/wireguard-full-mesh/#1-%e5%85%a8%e4%ba%92%e8%81%94%e6%a8%a1%e5%bc%8f%e6%9e%b6%e6%9e%84%e4%b8%8e%e9%85%8d%e7%bd%ae)。

WireGuard 本身只是一个内核级别的模块，只是一个数据平面，至于上层的更高级的功能（比如秘钥交换机制，UDP 打洞，ACL 等），需要通过用户空间的应用来实现。

下面就轮到 Tailscale 登场了。

## Tailscale 是什么

Tailscale 是一种基于 WireGuard 的虚拟组网工具，是在用户态实现了 WireGuard 协议，它在功能和易用性上绝对是完爆其他工具：

1. 开箱即用
    - 无需配置防火墙
    - 没有额外的配置
2. 高安全性 / 私密性
    - 自动密钥轮换
    - 点对点连接
    - 支持用户审查端到端的访问记录
3. 在原有的 ICE、STUN 等 UDP 协议外，实现了 DERP TCP 协议来实现 NAT 穿透
4. 基于公网的控制服务器下发 ACL 和配置，实现节点动态更新
5. 通过第三方（如 Google） SSO 服务生成用户和私钥，实现身份认证

简而言之，我们可以将 Tailscale 看成是更为易用、功能更完善的 WireGuard。

## Headscale 是什么

Tailscale 的控制服务器是不开源的，而且对免费用户有诸多限制。好在目前有一款开源的实现叫 [Headscale](https://github.com/juanfont/headscale)，这也是唯一的一款，希望能发展壮大。

Headscale 由欧洲航天局的 Juan Font 使用 Go 语言开发，在 BSD 许可下发布，实现了 Tailscale 控制服务器的所有主要功能，可以部署在企业内部，没有任何设备数量的限制，且所有的网络流量都由自己控制。

目前 Headscale 还没有可视化界面，期待后续更新吧。

## Headscale 部署

Headscale 部署很简单，推荐直接在 Linux 主机上安装。

> 💁 理论上来说只要你的 Headscale 服务可以暴露到公网出口就行，但最好不要有 NAT，所以推荐将 Headscale 部署在有公网 IP 的云主机上。

首先需要到其 GitHub 仓库的 Release 页面下载最新版的二进制文件。

```bash
wget --output-document=/usr/local/bin/headscale \
   https://github.com/juanfont/headscale/releases/download/v<HEADSCALE VERSION>/headscale_<HEADSCALE VERSION>_linux_<ARCH>

chmod +x /usr/local/bin/headscale
```

创建配置目录：

```bash
mkdir -p /etc/headscale
```

创建目录用来存储数据与证书：

```bash
mkdir -p /var/lib/headscale
```

创建空的 SQLite 数据库文件：

```bash
touch /var/lib/headscale/db.sqlite
```

创建 Headscale 配置文件：

```bash
wget https://github.com/juanfont/headscale/raw/main/config-example.yaml -O /etc/headscale/config.yaml
```

-   修改配置文件，将 `server_url` 改为公网 IP 或域名。💁 **如果是国内服务器，域名必须要备案。** 没有域名就直接用公网 IP 。
    ![server_url](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225214651_Xnip2022-12-25_16-35-00.jpg)
-   修改监听地址，在所有 ip 上监听
    ![listen_addr](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225214825_Xnip2022-12-25_16-35-09.jpg)
-   修改 grpc 监听地址，在所有 ip 上监听
    ![grpc_listen_addr](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225215212_Xnip2022-12-25_21-30-45.jpg)
-   修改 private_key 存储路径
    ![private_key_path](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225215346_Xnip2022-12-25_21-30-56.jpg)
-   修改 noise_private_key 存储路径
    ![noise_private_key](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225215500_Xnip2022-12-25_21-31-16.jpg)
-   可自定义私有网段，也可同时开启 IPv4 和 IPv6
    ![ip_prefixes](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225215830_Xnip2022-12-25_21-31-32.jpg)
-   修改数据库存储路径
    ![db_path](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225220137_Xnip2022-12-25_21-32-06.jpg)
-   如果暂时用不到 DNS 功能，可以先将 `magic_dns` 设为 false
    ![magic_dns](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225220319_Xnip2022-12-25_21-32-22.jpg)
-   修改 `unix_socket`的路径
    ![unix_socket](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225220427_Xnip2022-12-25_21-32-29.jpg)

创建 SystemD service 配置文件：

```
# /etc/systemd/system/headscale.service
[Unit]
Description=headscale controller
After=syslog.target
After=network.target

[Service]
Type=simple
User=headscale
Group=headscale
ExecStart=/usr/local/bin/headscale serve
Restart=always
RestartSec=5

# Optional security enhancements
NoNewPrivileges=yes
PrivateTmp=yes
ProtectSystem=strict
ProtectHome=yes
ReadWritePaths=/var/lib/headscale /var/run/headscale
AmbientCapabilities=CAP_NET_BIND_SERVICE
RuntimeDirectory=headscale

[Install]
WantedBy=multi-user.target
```

创建 headscale 用户：

```bash
useradd headscale -d /home/headscale -m
```

修改 /var/lib/headscale 目录的 owner：

```bash
chown -R headscale:headscale /var/lib/headscale
```

Reload SystemD 以加载新的配置文件：

```bash
systemctl daemon-reload
```

启动 Headscale 服务并设置开机自启：

```bash
systemctl enable --now headscale
```

查看运行状态：

```bash
systemctl status headscale
```

![headscale_status](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225221236_g71Quo.png)

查看占用端口：

```bash
ss -tulnp|grep headscale
```

![headscale_port](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225221452_b2Ve6p.png)

Tailscale 中有一个概念叫 tailnet，你可以理解成租户，租户与租户之间是相互隔离的，详情见 Tailscale 的官方文档： [What is a tailnet](https://tailscale.com/kb/1136/tailnet/)。Headscale 也有类似的实现叫 namespace，即命名空间。我们需要先创建一个 namespace，以便后续客户端接入，例如：

```bash
headscale namespaces create default
```

查看命名空间：

```bash
headscale namespaces list
```

![headscale_namespace](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225222030_3ZXzRp.png)

## Tailscale 客户端接入

### macOS

macOS 有 3 种安装方法：

1. 直接通过应用商店安装，地址： [https://apps.apple.com/ca/app/tailscale/id1475387142](https://apps.apple.com/ca/app/tailscale/id1475387142)。前提是你需要一个美区 ID。
2. 下载[安装包](https://pkgs.tailscale.com/stable/#macos)直接安装，绕过应用商店。
3. 安装开源的命令行工具 `tailscale` 和 `tailscaled`。相关链接： [https://github.com/tailscale/tailscale/wiki/Tailscaled-on-macOS](https://github.com/tailscale/tailscale/wiki/Tailscaled-on-macOS)。

这三种安装包的核心数据包处理代码是相同的，唯一的区别在于在于打包方式以及与系统的交互方式。

这里我直接通过第 2 种方式下载安装包进行安装。安装完应用后还需要做一些操作，才能让 Tailscale 使用 Headscale 作为控制服务器。当然，Headscale 已经给我们提供了详细的操作步骤，你只需要在浏览器中打开 URL：`http://<HEADSCALE_PUB_IP>:8080/apple`，其中`<HEADSCALE_PUB_IP>`就是你部署 Headscale 的公网 ip，便会出现如下的界面：

![Img](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225224403_E9Y7VH.png)

修改完成后重启 Tailscale 客户端，在 macOS 顶部状态栏中找到 Tailscale 并点击，然后再点击 `Log in`。

然后立马就会跳转到浏览器并打开一个页面。

![machine_registration](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225230100_Xnip2022-12-25_23-00-48.jpg)

将红色框内的命令复制粘贴到 headscale 所在机器的终端中，并将 NAMESPACE 替换为前面所创建的 namespace。

```bash
headscale -n default nodes register --key nodekey:xxxxxx
```

注册成功，查看注册的节点：

```bash
headscale nodes list
```

![nodes_list](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225231053_SOSmsv.png)

回到 macOS，测试是否能 ping 通对端节点：

```bash
ping 10.1.0.2
```

也可以使用 Tailscale CLI 来测试：

```bash
/Applications/Tailscale.app/Contents/MacOS/Tailscale ping 10.1.0.2
```

### OpenWrt

OpenWrt 安装方法参考 [https://github.com/adyanth/openwrt-tailscale-enabler](https://github.com/adyanth/openwrt-tailscale-enabler)

1.  下载安装包 [`openwrt-tailscale-enabler-<tag>.tgz`](https://github.com/adyanth/openwrt-tailscale-enabler/releases)

2.  通过 scp 命令将安装包拷贝至 openwrt 的 `/tmp` 目录下

    ```bash
    scp -O openwrt-tailscale-enabler-v1.34.1-f5576b5-autoupdate.tgz root@<openwrt_ip>:/tmp
    ```

3.  解压安装包

    ```bash
    tar x -zvC / -f openwrt-tailscale-enabler-<tag>.tgz
    ```

4.  预安装软件

    ```bash
    opkg update
    opkg install libustream-openssl ca-bundle kmod-tun
    ```

5.  运行 tailscale 初始化

    ```bash
    /etc/init.d/tailscale start
    tailscale up --login-server=<headscale_ip>:8080 --accept-routes=true --accept-dns=false
    ```

6.  复制生成的 URL，并在浏览器中打开

    ![register_url](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221226073524_3iszn6.png)

    ![machine_registration](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225230100_Xnip2022-12-25_23-00-48.jpg)

7.  将红色框内的命令复制粘贴到 headscale 所在机器的终端中，并将 NAMESPACE 替换为前面所创建的 namespace。

    ```bash
    headscale -n default nodes register --key nodekey:xxxxxx
    ```

    注册成功，查看注册的节点：

    ```bash
    headscale nodes list
    ```

    ![nodes_list](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221225231053_SOSmsv.png)

    回到 openwrt，可以看到 Tailscale 会自动创建相关的路由表和 iptables 规则。路由表可通过以下命令查看：

    ```bash
    ip route show table 52
    ```

    ![route_table](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221226081250_FLxN5g.png)

    查看 iptables 规则：

    ```bash
    iptables -S
    ```

    测试是否能 ping 通对端节点：

    ```bash
    ping 10.1.0.1
    ```

    也可以使用 tailscale cli 来测试：

    ```bash
    tailscale ping 10.1.0.1
    ```

8.  设置 tailscale 开机自启动

    ```bash
    /etc/init.d/tailscale enable
    ```

    查看是否设置成功

    ```bash
    ls /etc/rc.d/S*tailscale*
    ```

    ![tailscale_boot](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221226084534_1PGL1X.png)

9.  以后升级 tailscale，只需从[这里](https://pkgs.tailscale.com/stable/#static)下载最新的安装包，下载的包名是类似 `1.2.10_mips` 这种结构，然后替换掉 `/usr/bin/tailscale` 和 `/usr/bin/tailscaled` 相同路径下的二进制文件。

## 打通局域网

到目前为止我们只是打造了一个点对点的 Mesh 网络，各个节点之间都可以通过 WireGuard 的私有网络 IP 进行直连。我们还可以通过适当的配置让每个节点都能访问其他节点的局域网 IP。这个使用场景就比较多了，你可以直接访问家庭内网的 NAS，或者内网的任何一个服务，更高级的玩家可以使用这个方法来访问云上 Kubernetes 集群的 Pod IP 和 Service IP。

我们以安装了 tailscale 客户端的 OpenWrt 为例，我们希望其他 tailscale 客户端可以直接通过 OpenWrt 路由器的局域网 IP（例如 10.0.1.0/24） 访问 OpenWrt 内网的任何一台设备。

1. 配置方法很简单，首先需要设置 IPv4 与 IPv6 路由转发：

    ```bash
    echo 'net.ipv4.ip_forward = 1' | tee /etc/sysctl.d/ipforwarding.conf
    echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/ipforwarding.conf
    sysctl -p /etc/sysctl.d/ipforwarding.conf
    ```

2. 客户端修改注册节点的命令，在原来命令的基础上加上参数 --advertise-routes=10.0.1.0/24，告诉 Headscale 服务器 “我这个节点可以转发这些地址的路由”。

    ```bash
    tailscale up --login-server=http://<HEADSCALE_PUB_IP>:8080 --accept-routes=true --accept-dns=false --advertise-routes=10.0.1.0/24 --reset
    ```

3. 在 Headscale 端查看路由，可以看到相关路由是关闭的。

    ```bash
    headscale nodes list
    ```

    ![node_id](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221226142834_C68va1.png)

    ```bash
    # 查看 id 为 2 的节点的路由，也就是 openwrt 的路由
    headscale routes list -i 2
    ```

    ![route_list](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221226155628_P9rA66.png)

    开启路由：

    ```bash
    headscale routes enable  -r 1
    ```

    其他 tailscale 节点查看路由结果：

    ```bash
    ip route show table 52|grep "10.0.1.0/24"
    ```

其他节点启动时需要增加 `--accept-routes=true` 选项来声明 “我接受外部其他节点发布的路由”。

现在你在任何一个 tailscale 客户端所在的节点都可以 ping 通 openwrt 路由器所在内网的机器了。
