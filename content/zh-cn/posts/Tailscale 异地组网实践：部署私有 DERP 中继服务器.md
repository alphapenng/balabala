<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-06-25 09:52:50
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-06-25 19:38:11
 * @FilePath: /balabala/content/zh-cn/posts/Tailscale 异地组网实践：部署私有 DERP 中继服务器.md
-->

# Tailscale 异地组网实践：部署私有 DERP 中继服务器

- [Tailscale 异地组网实践：部署私有 DERP 中继服务器](#tailscale-异地组网实践部署私有-derp-中继服务器)
  - [自建私有 DERP server](#自建私有-derp-server)
    - [使用域名方式](#使用域名方式)
    - [使用纯 IP 方式](#使用纯-ip-方式)
  - [防止 DERP 被白嫖](#防止-derp-被白嫖)

[第一篇文章](https://github.com/alphapenng/balabala/blob/main/content/zh-cn/posts/Tailscale%20%E5%BC%82%E5%9C%B0%E7%BB%84%E7%BD%91%E5%AE%9E%E8%B7%B5%EF%BC%9AHeadscale%20%E7%9A%84%E9%83%A8%E7%BD%B2%E6%96%B9%E6%B3%95%E5%92%8C%E4%BD%BF%E7%94%A8.md)介绍了如何使用 Headscale 替代 Tailscale 官方的控制服务器，并接入各个平台的客户端。本文将会介绍如何让 Tailscale 使用自定义的 DERP Servers 进行中继。

参考文章：[Tailscale 基础教程：部署私有 DERP 中继服务器](https://icloudnative.io/posts/custom-derp-servers/)

有关中继概念的阐述这里就不展开了，请移至参考文章中查看，里面介绍得非常好。下面我们就直接部署私有的 DERP 中继服务器。

## 自建私有 DERP server

[官方参考文档](https://tailscale.com/kb/1118/custom-derp-servers/)

### 使用域名方式

这种方案需要满足以下几个条件：

- 要有自己的域名，并且申请了 SSL 证书
- 需要准备一台或多台云主机
- 如果服务器在国内，域名需要备案
- 如果服务器在国外，则不需要备案

如果以上条件都俱备，就可以按照下面的步骤开始部署了。

推荐直接使用 Docker 来部署，我已经构建好了 Docker 镜像，直接部署就可以了：

```bash
🐳  → docker run --restart always \
  --name derper -p 12345:12345 -p 3478:3478/udp \
  -v /root/.acme.sh/xxxx/:/app/certs \
  -e DERP_CERT_MODE=manual \
  -e DERP_ADDR=:12345 \
  -e DERP_DOMAIN=xxxx \
  -d ghcr.io/yangchuansheng/derper:latest
```

有几点需要注意：

- 能用 443 端口尽量用 443 端口，实在不行再用别的端口；
- 默认情况下也会开启 STUN 服务，UDP 端口是 3478；
- 防火墙需要放行端口 12345 和 3478；
- 准备好 SSL 证书；(生成免费证书方法请前往[此文](https://github.com/alphapenng/balabala/blob/main/content/private/Ubuntu%20%E7%B3%BB%E7%BB%9F%E9%85%8D%E7%BD%AE%E6%8C%87%E5%8D%97.md#acmesh-%E7%94%9F%E6%88%90%E5%85%8D%E8%B4%B9%E8%AF%81%E4%B9%A6%E4%B8%8D%E6%8E%A8%E8%8D%90%E6%8E%A8%E8%8D%90%E4%BD%BF%E7%94%A8-nginx-proxy-manager-%E6%9D%A5%E7%94%9F%E6%88%90%E8%AF%81%E4%B9%A6)查看)
- 域名部分我打了码，请换成你自己的域名。

💁 关于证书部分需要重点说明：假设你的域名是 `xxx.com`，那么证书的名称必须是 `xxx.com.crt`，一个字符都不能错！同理，私钥名称必须是 `xxx.com.key`，一个字符都不能错！

查看容器日志：

```bash
🐳  → docker logs -f derper
2022/03/26 11:36:28 no config path specified; using /var/lib/derper/derper.key
2022/03/26 11:36:28 derper: serving on :12345 with TLS
2022/03/26 11:36:28 running STUN server on [::]:3478
```

目前 derper 运行一段时间就会崩溃，暂时还没有更好的解决方案，只能通过定时重启来解决，比如通过 crontab 来设置每两小时重启一次容器：

```bash
0 */2 * * * docker restart derper &> /dev/null
```

具体可参考这个 issue： [Derper TLS handshake error: remote error: tls: internal error](https://github.com/tailscale/tailscale/issues/4082)

部署好 derper 之后，就可以修改 Headscale 的配置来使用自定义的 DERP 服务器了。Headscale 可以通过两种形式的配置来使用自定义 DERP：

- 一种是在线 URL，格式是 `JSON`，与 Tailscale 官方控制服务器使用的格式和语法相同。
- 另一种是本地文件，格式是 `YAML`。

我们可以直接使用本地的 YAML 配置文件，内容如下：

```yaml
# /etc/headscale/derp.yaml
regions:
  900:
    regionid: 900
    regioncode: thk 
    regionname: Tencent Hongkong 
    nodes:
      - name: 900a
        regionid: 900
        hostname: xxxx
        ipv4: xxxx
        stunport: 3478
        stunonly: false
        derpport: 12345
      - name: 900b
        regionid: 900
        hostname: xxxx
        ipv4: xxxx
        stunport: 3478
        stunonly: false
        derpport: 12345
  901:
    regionid: 901
    regioncode: hs 
    regionname: Huawei Shanghai 
    nodes:
      - name: 901a
        regionid: 901
        hostname: xxxx
        ipv4: xxxx
        stunport: 3478
        stunonly: false
        derpport: 12345
```

配置说明：

- `regions` 是 YAML 中的对象，下面的每一个对象表示一个可用区，每个可用区里面可设置多个 DERP 节点，即 `nodes`。
- 每个可用区的 `regionid` 不能重复。
- 每个 `node` 的 `name` 不能重复。
- `regionname` 一般用来描述可用区，`regioncode` 一般设置成可用区的缩写。
- `ipv4` 字段不是必须的，如果你的域名可以通过公网解析到你的 DERP 服务器地址，这里可以不填。如果你使用了一个二级域名，而这个域名你并没有在公共 DNS server 中添加相关的解析记录，那么这里就需要指定 IP（前提是你的证书包含了这个二级域名，这个很好支持，搞个泛域名证书就行了）。
- `stunonly: false` 表示除了使用 STUN 服务，还可以使用 DERP 服务。
上面的配置中域名和 IP 部分我都打码了，你需要根据你的实际情况填写。

接下来还需要修改 Headscale 的配置文件，引用上面的自定义 DERP 配置文件。需要修改的配置项如下：

```yaml
# /etc/headscale/config.yaml
derp:
  # List of externally available DERP maps encoded in JSON
  urls:
  #  - https://controlplane.tailscale.com/derpmap/default

  # Locally available DERP map files encoded in YAML
  #
  # This option is mostly interesting for people hosting
  # their own DERP servers:
  # https://tailscale.com/kb/1118/custom-derp-servers/
  #
  # paths:
  #   - /etc/headscale/derp-example.yaml
  paths:
    - /etc/headscale/derp.yaml

  # If enabled, a worker will be set up to periodically
  # refresh the given sources and update the derpmap
  # will be set up.
  auto_update_enabled: true

  # How often should we check for DERP updates?
  update_frequency: 24h
```

可以把 Tailscale 官方的 DERP 服务器禁用，来测试自建的 DERP 服务器是否能正常工作。

修改完配置后，重启 headscale 服务：

```bash
systemctl restart headscale
```

在 Tailscale 客户端上使用以下命令查看目前可以使用的 DERP 服务器：

```bash
tailscale netcheck

Report:
        * UDP: true
        * IPv4: yes, xxxxx:57068
        * IPv6: no
        * MappingVariesByDestIP: false
        * HairPinning: false
        * PortMapping: 
        * Nearest DERP: Tencent Hongkong
        * DERP latency:
                - thk: 39.7ms (Tencent Hongkong)
```

`tailscale netcheck` 实际上只检测 `3478/udp` 的端口， 就算 netcheck 显示能连，也不一定代表 12345 端口可以转发流量。最简单的办法是直接打开 DERP 服务器的 URL：<https://xxxx:12345>，如果看到如下页面，且地址栏的 SSL 证书标签显示正常可用，那才是真没问题了。

![derp](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230625154420_GfwQ6d.png)

查看与通信对端的连接方式：

```bash
tailscale status
```

使用 ping 来测试连通性：

```bash
ping 10.1.0.2
```

也可以使用 Tailscale 命令行工具来测试：

```bash
tailscale ping 10.1.0.8
pong from oneplus-8t (10.1.0.8) via DERP(thk) in 104ms
pong from oneplus-8t (10.1.0.8) via DERP(thk) in 111ms
pong from oneplus-8t (10.1.0.8) via DERP(thk) in 105ms
```

这个更加友好一点，会直接告诉你是通过 DERP 中继服务器来和对方通信的。

如果当前 Tailscale 客户端所在主机开启了 IPv6，那么与手机便可以直接通过 IPv6 点对点连接：

```bash
/Applications/Tailscale.app/Contents/MacOS/Tailscale status
                coredns              default      linux   active; direct xxxx:45986; offline, tx 124352 rx 185736
                oneplus-8t           default      android active; direct [240e:472:da0:24a2:a07f:2a67:2a1e:4475]:37237; offline, tx 125216 rx 20052
                openwrt              default      linux   active; direct [240e:390:caf:1870:c02c:e8ff:feb9:b0b]:41641; offline, tx 181992 rx 3910120

/Applications/Tailscale.app/Contents/MacOS/Tailscale ping 10.1.0.8
pong from oneplus-8t (10.1.0.8) via [240e:472:da0:24a2:a07f:2a67:2a1e:4475]:37237 in 62ms
```

所以如果你开启了 IPv6，可以大大增加点对点连接的成功率。

### 使用纯 IP 方式

因为我没有使用这种方式部署，所以也不记录了，需要用这种方式部署的同学请移步到参考文章中。

## 防止 DERP 被白嫖

默认情况下 DERP 服务器是可以被白嫖的，只要别人知道了你的 DERP 服务器的地址和端口，就可以为他所用。如果你的服务器是个小水管，用的人多了可能会把你撑爆，因此我们需要修改配置来防止被白嫖。

💁 特别声明：只有使用域名的方式才可以通过认证防止被白嫖，使用纯 IP 的方式无法防白嫖，你只能小心翼翼地隐藏好你的 IP 和端口，不能让别人知道。

只需要做两件事情：

1. 在 DERP 服务器上安装 Tailscale。

    第一步需要在 DERP 服务所在的主机上安装 Tailscale 客户端，启动 tailscaled 进程。

2. derper 启动时加上参数 `--verify-clients`。

    本文推荐的是通过容器启动， Dockerfile 内容如下：

    ```yaml
    FROM golang:latest AS builder

    LABEL org.opencontainers.image.source https://github.com/yangchuansheng/docker-image

    WORKDIR /app

    # https://tailscale.com/kb/1118/custom-derp-servers/
    RUN go install tailscale.com/cmd/derper@main

    FROM ubuntu
    WORKDIR /app

    ARG DEBIAN_FRONTEND=noninteractive

    RUN apt-get update && \
        apt-get install -y --no-install-recommends apt-utils && \
        apt-get install -y ca-certificates && \
        mkdir /app/certs

    ENV DERP_DOMAIN your-hostname.com
    ENV DERP_CERT_MODE letsencrypt
    ENV DERP_CERT_DIR /app/certs
    ENV DERP_ADDR :443
    ENV DERP_STUN true
    ENV DERP_HTTP_PORT 80
    ENV DERP_VERIFY_CLIENTS false

    COPY --from=builder /go/bin/derper .

    CMD /app/derper --hostname=$DERP_DOMAIN \
        --certmode=$DERP_CERT_MODE \
        --certdir=$DERP_CERT_DIR \
        --a=$DERP_ADDR \
        --stun=$DERP_STUN  \
        --http-port=$DERP_HTTP_PORT \
        --verify-clients=$DERP_VERIFY_CLIENTS
    ```

    默认情况下 `--verify-clients` 参数设置的是 `false`。我们不需要对 Dockerfile 内容做任何改动，只需在容器启动时加上环境变量即可，将之前的启动命令修改一下：

    - 首先停止容器运行并备份

        ```bash
        docker stop derper
        docker rename derper derper_bak
        ```

    - 运行新的 docker 命令

        ```bash
        🐳  → docker run --restart always \
        --name derper -p 12345:12345 -p 3478:3478/udp \
        -v /root/.acme.sh/xxxx/:/app/certs \
        -v /var/run/tailscale/tailscaled.sock:/var/run/tailscale/tailscaled.sock \
        -e DERP_CERT_MODE=manual \
        -e DERP_ADDR=:12345 \
        -e DERP_DOMAIN=xxxx \
        -e DERP_VERIFY_CLIENTS=true \
        -d ghcr.io/yangchuansheng/derper:latest
        ```

    - 确认运行正常后删除旧的备份

        ```bash
        docker rm derper_bak
        ```

这样就大功告成了，别人即使知道了你的 DERP 服务器地址也无法使用，但还是要说明一点，即便如此，你也应该尽量不让别人知道你的服务器地址，防止别人有可趁之机。
