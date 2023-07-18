> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blognas.hwb0307.com](https://blognas.hwb0307.com/skill/1531)

> 使用 FRP 进行内网穿透的最佳实践 - 用最官方的方法来使用 frp，实现内网穿透！

本文最后更新于 141 天前，如有失效请评论区留言。

> 有需要可加**[电报群](https://t.me/benszhub "电报群")**获得更多帮助。本博客用什么 **[VPS](https://blognas.hwb0307.com/ad "VPS")**？创作不易，请**[支持](https://blognas.hwb0307.com/thankyou "支持")**苯苯！推荐购买本博客的 **[VIP](https://blognas.hwb0307.com/subscribe "VIP")** 喔，10 元 / 年即可畅享所有 VIP 专属内容！也欢迎大佬对本文进行**[慈善承包](https://blognas.hwb0307.com/enterprise "慈善承包")** (ฅ´ω`ฅ)

前不久我出过一期《[Docker 系列 通过 FRP 实现内网穿透](https://blognas.hwb0307.com/linux/docker/1503)》讲述怎么利用 FRP 进行内网穿透。不过，经过测试，很快我发现此文有相当大的局限性，列举如下：

*   仅限`x86`架构的机器 / VPS 可以使用
*   不是官方维护的镜像，很难获得开发者的支持

但是，frp 开发者对于 Docker 镜像的态度比较随意，这对于使用 Docker 的用户来不太友好。其实`fatedier/frps`的 Docker 镜像估计也是可以用的，不过我不准备折腾了。因为我感觉**作者的主要精力还是放在原生 frp 程序里**。所以我们干脆就**用最官方的方法来使用 frp**！我看了一下 Github 的 README 文档，也不是很难。下面我们用新的方法再安装一次 frp 吧！

这个教程可以**支持 frp 所支持的所有架构 / 系统类型**，可以放心食用。如果你是高级用户，可以直接在 [Github Repo](https://github.com/fatedier/frp "Github Repo") 了解如何进行更加细致的设置。

除 frp 外，**Cloudflare 隧道内网穿透**（比如[此教程](https://johnrosen1.com/2022/04/19/cloudflare/ "此教程")）也是一种比较常见的方案，不要求你具有一个用于布署服务端 frp 的 VPS。感兴趣的小伙伴可以自己试试看 (～￣▽￣)～

FRP 的基本原理大致如下：

*   在一个有公网 ip 的 VPS 中搭建 frp server(frps) 服务。将域名`test.sample.com`解析到 VPS 里。
*   给 frps 开放某些特定的端口，比如`1234`
*   在本地电脑安装 frp customer(frpc) 服务。通过`common`系列参数保证`frps-frpc`的通信正常。
*   本地某服务上线，比如`localapp:6534`。
*   frpc 进行内部连接，比如`frpc:1234`
*   穿透路线：`test.sample.com→VPS→frps:1234→frpc:1234→localapp:6534`

按下面的步骤走，你就能深切地体会到原理对应的具体的命令行操作。

如果想要降低失败率，你需要较好地掌握 Linux 基础，特别是与用户（组）相关的知识。如果你不太会 Linux，你可以试一下本教程，有问题可加 Telegram 群或评论区提问。

你需要提前将待用域名解析到 VPS（frps 端）的公网 ip 中。在本章的示范中，需要用到以下域名：

*   **frps.sample.com**：用于访问服务器端的 frps。
*   **httptest.sample.com**：用于验证 http 内网穿透是否生效

如果你还需要 https，还需要：

*   **httpstest.sample.com**：用于验证 https 内网穿透的是否生效

提前申请并下载好 **httpstest.sample.com** 的 SSL 证书，即下文的`httpstest.sample.com.pem`、`httpstest.sample.com.key`。

frp 不同版本所使用的软件是不同的。在 frp 的 [Github Repo](https://github.com/fatedier/frp "Github Repo") 中，你可以看到最新的版本：

![](https://chevereto.hwb0307.com/images/2022/06/15/NVIDIA_Share_VQ080QJnST.webp)

点进去后，你要根据自己的 VPS / 本地设备的架构 / 系统来下载软件：

![](https://chevereto.hwb0307.com/images/2022/06/15/chrome_gAJd96TpZI.webp)

如果你不知道自己的机子是什么架构，可以用`uname -a`来查看。有问题加群或评论区提问。

首先，创建工作目录：

```
work=~/Downloads/frp
```

创建并进入目录：

```
mkdir -p $work && cd $work
```

下载软件（不同 CPU 架构要选不同的[版本](https://github.com/fatedier/frp/releases/tag/v0.43.0 "版本")）。或者你也可以在电脑下载，然后通过 sftp 上传到工作目录。

```
wget https://github.com/fatedier/frp/releases/download/v0.43.0/frp_0.43.0_linux_386.tar.gz
```

解压 tar.gz 文件：

```
tar zvfx frp_0.43.0_linux_386.tar.gz && mv frp_0.43.0_linux_386/* . && rm -r frp_0.43.0_linux_386/
```

此时文件夹的内容类似于：

```
$ ls -hl-rw-rw-r-- 1 test_user test 8.8M May 27 16:35 frp_0.43.0_linux_386.tar.gz-rwxr-xr-x 1 test_user test 9.8M May 27 16:31 frpc-rw-r--r-- 1 test_user test  11K May 27 16:35 frpc_full.ini-rw-r--r-- 1 test_user test  126 May 27 16:35 frpc.ini-rwxr-xr-x 1 test_user test  13M May 27 16:31 frps-rw-r--r-- 1 test_user test 5.5K May 27 16:35 frps_full.ini-rw-r--r-- 1 test_user test   26 May 27 16:35 frps.ini-rw-r--r-- 1 test_user test  12K May 27 16:35 LICENSE
```

修改`frps.ini`的内容。主要是**对端口号、帐号和密码、token 进行一定改动**。大家注意中文注释对应的参数。

```
vim ./frps.ini
```

填入以下内容。如果你是高级用户，你可以根据`frps_full.ini`自己进行调整。小白用户不妨直接基于我写好的配置进行改动（注意中文标注的相应参数，推荐自定义，不要用我的默认值）。

```
[common]# A literal address or host name for IPv6 must be enclosed# in square brackets, as in "[::1]:80", "[ipv6-host]:http" or "[ipv6-host%zone]:80"# For single "bind_addr" field, no need square brackets, like "bind_addr = ::".bind_addr = 0.0.0.0# 按需修改。默认bind_port = 7000bind_port = 6500  # udp port to help make udp hole to penetrate nat# 按需修改。默认bind_udp_port = 7001bind_udp_port = 6502 # udp port used for kcp protocol, it can be same with 'bind_port'# if not set, kcp is disabled in frps# 按需修改。默认bind_port = 7000kcp_bind_port = 6500 # specify which address proxy will listen for, default value is same with bind_addr# proxy_bind_addr = 127.0.0.1 # if you want to support virtual host, you must set the http port for listening (optional)# Note: http port and https port can be same with bind_port# 按需修改。默认vhost_http_port = 80, vhost_https_port = 443。但一般VPS的80和443端口都要给Nginx之类的应用来托管。如果你的VPS专门只是用来反代的话，可以使用默认的80和443端口。vhost_http_port = 6503vhost_https_port = 6504 # response header timeout(seconds) for vhost http server, default is 60s# vhost_http_timeout = 60 # tcpmux_httpconnect_port specifies the port that the server listens for TCP# HTTP CONNECT requests. If the value is 0, the server will not multiplex TCP# requests on one single port. If it's not - it will listen on this value for# HTTP CONNECT requests. By default, this value is 0.# tcpmux_httpconnect_port = 1337 # If tcpmux_passthrough is true, frps won't do any update on traffic.# tcpmux_passthrough = false # set dashboard_addr and dashboard_port to view dashboard of frps# dashboard_addr's default value is same with bind_addr# dashboard is available only if dashboard_port is setdashboard_addr = 0.0.0.0dashboard_port = 6501 # dashboard user and passwd for basic auth protect# frps后台的用户名和密码dashboard_user = supermandashboard_pwd = test0test # enable_prometheus will export prometheus metrics on {dashboard_addr}:{dashboard_port} in /metrics api.enable_prometheus = true # dashboard assets directory(only for debug mode)# assets_dir = ./static # console or real logFile path like ./frps.log# log_file = ./frps.log # trace, debug, info, warn, errorlog_level = info log_max_days = 3 # disable log colors when log_file is console, default is falsedisable_log_color = false # DetailedErrorsToClient defines whether to send the specific error (with debug info) to frpc. By default, this value is true.detailed_errors_to_client = true # authentication_method specifies what authentication method to use authenticate frpc with frps.# If "token" is specified - token will be read into login message.# If "oidc" is specified - OIDC (Open ID Connect) token will be issued using OIDC settings. By default, this value is "token".authentication_method = token # authenticate_heartbeats specifies whether to include authentication token in heartbeats sent to frps. By default, this value is false.authenticate_heartbeats = false # AuthenticateNewWorkConns specifies whether to include authentication token in new work connections sent to frps. By default, this value is false.authenticate_new_work_conns = false # auth tokentoken = D3YhBv*sD3#*3LrvQX!%tA&r9xHN9N # oidc_issuer specifies the issuer to verify OIDC tokens with.# By default, this value is "".oidc_issuer = # oidc_audience specifies the audience OIDC tokens should contain when validated.# By default, this value is "".oidc_audience = # oidc_skip_expiry_check specifies whether to skip checking if the OIDC token is expired.# By default, this value is false.oidc_skip_expiry_check = false # oidc_skip_issuer_check specifies whether to skip checking if the OIDC token's issuer claim matches the issuer specified in OidcIssuer.# By default, this value is false.oidc_skip_issuer_check = false # heartbeat configure, it's not recommended to modify the default value# the default value of heartbeat_timeout is 90. Set negative value to disable it.# heartbeat_timeout = 90 # user_conn_timeout configure, it's not recommended to modify the default value# the default value of user_conn_timeout is 10# user_conn_timeout = 10 # only allow frpc to bind ports you list, if you set nothing, there won't be any limitallow_ports = 3505-3510 # pool_count in each proxy will change to max_pool_count if they exceed the maximum valuemax_pool_count = 5 # max ports can be used for each client, default value is 0 means no limitmax_ports_per_client = 0 # tls_only specifies whether to only accept TLS-encrypted connections. By default, the value is false.tls_only = false # tls_cert_file = server.crt# tls_key_file = server.key# tls_trusted_ca_file = ca.crt # if subdomain_host is not empty, you can set subdomain when type is http or https in frpc's configure file# when subdomain is test, the host used by routing is test.frps.com# 改成subdomain_host = frps.sample.com # if tcp stream multiplexing is used, default is true# tcp_mux = true # specify keep alive interval for tcp mux.# only valid if tcp_mux is true.# tcp_mux_keepalive_interval = 60 # tcp_keepalive specifies the interval between keep-alive probes for an active network connection between frpc and frps.# If negative, keep-alive probes are disabled.# tcp_keepalive = 7200 # custom 404 page for HTTP requests# custom_404_page = /path/to/404.html # specify udp packet size, unit is byte. If not set, the default value is 1500.# This parameter should be same between client and server.# It affects the udp and sudp proxy.udp_packet_size = 1500
```

如果你用了宝塔、ufw 等软件，请打开防火墙的相应端口：`6500-6504`、`3505-3510`。

为了可以比较方便地对这个软件进行管理，我们通过**构建 Linux Service 的方式管理 frp**。我们创建`frps`服务：

```
sudo vim /etc/systemd/system/frps.service
```

填入以下内容：

```
[Unit]Description=frps serviceWants=network-online.targetAfter=network.target [Service]Type=simpleExecStart=/home/test_user/Downloads/frp/frps -c /home/test_user/Downloads/frp/frps.ini# ExecStop=Restart=on-failure # alwaysKillMode=processTimeoutSec=120RestartSec=60 [Install]WantedBy=multi-user.target
```

注意：

*   `ExecStart`如果有引用文件，应该使用绝对路径
*   `ExecStart`中的`/home/test_user`字段代表的是用户 home 目录。如果你有一个非 root 用户`test_user`，一般地你可以使用本例中的`/home/test_user`。如果你是 root 用户，要将`/home/test_user`替换成`/root`。

启动服务：

```
sudo systemctl start frps.service
```

查看状态：

```
systemctl status frps.service
```

如果成功，有类似下面的日志（有`success`字样）：

![](https://chevereto.hwb0307.com/images/2022/06/15/NVIDIA_Share_zaOu05LKsK.webp)

最后，不要忘了**设置开机自动启动**：

```
sudo systemctl enable frps.service
```

其它常用的命令还包括：

*   重启服务：

```
sudo systemctl restart frps.service
```

*   停止服务：

```
sudo systemctl stop frps.service
```

当然，你也可以访问 frps 的 dashboard：http://frps.sample.com:6501。帐户 / 密码是：`superman/test0test`。

![](https://chevereto.hwb0307.com/images/2022/06/13/NVIDIA_Share_Tx8g4dMY37.webp)

> 本地端的创建很多原则和服务端是一致的，比如用户目录的设置。大家注意按需修改

如果你用了宝塔、ufw 等软件，请打开防火墙的相应端口：`3505-3510`。

此隐藏内容仅限 VIP 查看。包年 VIP 仅 10 元，建议**[升级](https://blognas.hwb0307.com/user?pd=vip)**。VIP 可享有哪些**[特权](https://blognas.hwb0307.com/subscribe "特权")**？

这部份和之前的教程是一样的，没有区别。

你在自己的 Shell 终端里测试一下即可：

*   地址：frps.sample.com
*   端口号：3505
*   帐户：<自己的帐户>
*   密码：<自己的密码>

访问`http://httptest.sample.com:6503`可成功访问应用。

访问`https://httpstest.sample.com:6504`可成功访问应用。

这个教程还是蛮顺的，使用时注意一下用户名 / 用户组的设置就行了。另外，我觉得端口、用户名 / 密码、Token 这些信息大家最好不要用默认的，自己改动一下，测试一下，以加深对 frp 的理解。FRP 的内网穿透服务还是很稳定的。除了 FRP 外，Cloudflare Tunnel 也是一种比较流行内网穿透方案。感兴趣的小伙伴可以看看这篇[文章](https://ednovas.xyz/2023/02/24/cloudflaretunnel/ "文章")。希望大伙们使用愉快喽！

*   [Cloudflare Tunnel 免费内网穿透 | EdNovas 的小站](https://ednovas.xyz/2023/02/24/cloudflaretunnel/ "Cloudflare Tunnel 免费内网穿透 | EdNovas 的小站")
*   Gihub: [https://github.com/fatedier/frp](https://github.com/fatedier/frp "https://github.com/fatedier/frp")
*   [How To Access Your PCs and Servers from Anywhere Using Guacamole and Cloudflare Tunnels – YouTube](https://www.youtube.com/watch?v=tg1CbMEzCsc "How To Access Your PCs and Servers from Anywhere Using Guacamole and Cloudflare Tunnels – YouTube")
*   [Remote Access to CasaOS (and Apps) via Cloudflare Tunnels – YouTube](https://www.youtube.com/watch?v=OAeQwdFXsQQ "Remote Access to CasaOS (and Apps) via Cloudflare Tunnels – YouTube")
*   [Kasm Workspaces + Cloudflare Tunnels = Access Kasm Workspaces from ANYWHERE! (Episode 3) – YouTube](https://www.youtube.com/watch?v=pv43JiCUlyI "Kasm Workspaces + Cloudflare Tunnels = Access Kasm Workspaces from ANYWHERE! (Episode 3) – YouTube")

---------------  
_完结，撒花！如果您点一下广告，可以养活苯苯_😍😍😍

基于 [m2w](https://blognas.hwb0307.com/linux/docker/2813 "m2w") 创作。版权声明：除特殊说明，博客文章均为 Bensz 原创，依据 [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/ "CC BY-SA 4.0") 许可证进行授权，转载请附上出处链接及本声明。**VIP 内容严禁转载**！由于可能会成为 AI 模型（如 chatGPT）的训练样本，**本博客禁止将 AI 自动生成内容作为文章上传（特别声明时除外）**。如有需要，请至[学习地图](https://blognas.hwb0307.com/other/447)系统学习本博客的教程。加 [Telegram 群](https://t.me/benszhub "Telegram群")可获得更多帮助喔！ | 博客订阅：[RSS](https://blognas.hwb0307.com/feed "RSS") | 广告招租请[留言](https://blognas.hwb0307.com/lyb "留言") | [博客 VPS](https://blognas.hwb0307.com/ad "博客VPS") | 致谢[渺软公益 CDN](https://cdn.onmicrosoft.cn/ "渺软公益CDN") |