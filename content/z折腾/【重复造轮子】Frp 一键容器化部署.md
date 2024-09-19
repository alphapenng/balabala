> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=Mzk0MTIzNTgzMQ==&mid=2247506627&idx=2&sn=6d0a6d5db790a6602e4e102ae020e56a&chksm=c2d711dbf5a098cd59b3d472d39f61f82f659fabda81661d4d29bb6540816c156fc32f9b86a7#rd)

✎ 阅读须知

  

乌鸦安全的技术文章仅供参考，此文所提供的信息只为网络安全人员对自己所负责的网站、服务器等（包括但不限于）进行检测或维护参考，未经授权请勿利用文章中的技术资料对任何计算机系统进行入侵操作。利用此文所提供的信息而造成的直接或间接后果和损失，均由使用者本人负责。

乌鸦安全拥有对此文章的修改、删除和解释权限，如转载或传播此文章，需保证文章的完整性，未经允许，禁止转载！

本文所提供的工具仅用于学习，禁止用于其他，请在 24 小时内删除工具文件！！！

1. 需求
=====

在很多攻防渗透中，由于客户要求，需要使用指定的 ip 进行渗透测试，一般来说，客户会给一个或者多个 `ip` 进行授权，我们的所有操作都需要通过这个 `ip` 进行，这个时候就需要配置一个隧道，将在这里以 `frp` 为例，将 `frp` 的客户端和服务端都跑在这个授权的 `ip`（在这以公网 `vps` 为例）上，配置 `frp` 稍微有些繁琐，如果配置一次可能还行，多次配置的时候就感觉稍微麻烦了，所以为了满足访问需求，直接一键安装使用，可以提高效率。

请注意：这里的 `frp` 客户端和服务端都是在一起的，也就是在一个机器上，这样管理起来比较方便，而且本地只需要配置 `vps` 的代理端口就行了。

在这里 `frp` 是自己使用的，所以不需要考虑 `frp` 的流量混淆等问题。

网上已经有了一篇在 `docker` 里面配置 `frpc` 的

```
https://github.com/stilleshan/frpc <br style="visibility: visible;">
```

这个项目只配置了 `frpc`，`frps` 一般配置在靶机上的，但是我们这里的 `frp` 只供自己用的，所以都部署在 `vps` 上就行。

对应工具已上传至 `github`：

```
https://github.com/crow821<br style="visibility: visible;">
```

或者在乌鸦安全公众号后台回复关键字：**frp** 下载

2. 配置
=====

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLHEwQzW88GArzmaicKNZMhfQ7eqbDrbUGNk6GYfSyNUSkfZuZnHECX2Q/640?wx_fmt=png)image.png

环境需求：

*   `linux` 公网
    
*   存在 `docker` 容器环境
    

### 2.1 Dockerfile 文件

```
FROM ubuntu:14.04LABEL maintainer="crowsec"ENV VERSION 0.48.0ENV TZ=Asia/Shanghai# 安装依赖软件包RUN apt-get update && apt-get install -y wget tar supervisor# 设置时区RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone# 判断系统并下载 frpRUN if [ "$(uname -m)" = "x86_64" ]; then export PLATFORM=amd64 ; \    elif [ "$(uname -m)" = "aarch64" ]; then export PLATFORM=arm64 ; \    elif [ "$(uname -m)" = "armv7" ]; then export PLATFORM=arm ; \    elif [ "$(uname -m)" = "armv7l" ]; then export PLATFORM=arm ; \    elif [ "$(uname -m)" = "armhf" ]; then export PLATFORM=arm ; fi \    && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${PLATFORM}.tar.gz \    && tar xzf frp_${VERSION}_linux_${PLATFORM}.tar.gz \    && cd frp_${VERSION}_linux_${PLATFORM} \    && mkdir /frp\    && mv frpc /frp \    && mv frps /frp \    && cd .. \    && rm -rf *.tar.gz frp_${VERSION}_linux_${PLATFORM}# 拷贝配置文件和监控进程工具COPY ./frpc.ini /frp/COPY ./frps.ini /frp/COPY frpcs.conf /etc/supervisor/conf.d/# 启动 supervisordCMD ["/usr/bin/supervisord"]
```

然后配置 `frp` 的两个配置文件

### 2.2 frpc.ini - 客户端配置

`frpc.ini` 这个是客户端的，也就是我们常用的 `vps` 端的，但是在这里其实是不区分的，毕竟是在一个 `vps` 上启代理：

```
[common]server_addr = 142.545.719.181 # 这个ip是到时候远程要连接的，就是你目前vps的ip地址server_port = 3489  # 这个是和服务端对接的端口，可以修改[plugin_socks5]type = tcpremote_port = 8455 # 这个是到时候你连接的代理端口plugin = socks5plugin_user = hhhh   # socks5用到的用户  plugin_passwd = jjjj # socks5用到的密码
```

建议配置账号密码信息，如果你不配置的话，理论上可以白嫖你的 `vps` 隧道。

### 2.3 frps.ini - 服务端

```
[common]bind_port = 3489 # 这个和frpc.ini对应的bind_addr = 0.0.0.0 # 这个不动哦protocol = tcptls_enable = true
```

### 2.4 frpcs.conf

```
[supervisord]
nodaemon=true

[program:frps]
command=/frp/frps -c /frp/frps.ini

[program:frpc]
command=/frp/frpc -c /frp/frpc.ini
```

这是启动客户端和服务端的，配置 `Dockerfile` 使用。

### 2.4 使用

首先目录结果如下：

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLtI4hHk9HfFlX9tx5jUiahC1Tzl86KKufolVrfvy84J3Yiar8ibfMqHGOg/640?wx_fmt=png)image.png

在当前目录下使用命令构建容器：

```
docker build -t frpcs:v1.0 .
```

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLMOxv31LibAv1O6ZV9pJW2vGBRDdK7aIONPqLBXxluZ4zaq6mF66Gggw/640?wx_fmt=png)image.png

构建完成之后，可以看下：

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLoR6TE8E76GiaeYZTOibYlnTR0Myu7niaK2ZK1xtk7NxNKweWibTHAsGWIA/640?wx_fmt=png)image.png

有点大，`200` 多 M，运行起来：

```
docker run -dt --name frpcs -p 3489:3489 -p 8455:8455 --rm frpcs:v1.0
```

请注意：这里的两个映射端口一定要和你 `frp` 的两个配置文件里面的保持一致：

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLrAKchibnPbtaicHgu8k59ScFtPJmmibiasWP05QR5n66MfCyRpdSyicrt6g/640?wx_fmt=png)image.png

此时使用命令看下是不是真的运行起来了：

```
docker logs frpcs
```

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLAywj9vDFnYcrXpiaeuMlUWv7DXybxr1DLWBVzHLeCIfNV2y9YQsd5ZQ/640?wx_fmt=png)image.png

貌似是起来了，此时的隧道就已经配置完成了。

### 2.5 连接测试

通过你配置的信息本地配置，然后访问下看看：

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLOUhP3Ma3OfxEPkCibkjsciayft4llCXLNoicvBeFl43eh1ib2oSmC0WtNQ/640?wx_fmt=png)image.png

成功：

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLWoCqCw2VKnbticPiaeOvBBCDCYu4IxyGnzu0R74gVXrBTzotAoBbrnicA/640?wx_fmt=png)image.png

3. 命令总结
=======

在部署的时候，只需要配置 `frpc.ini` 和 `frps.ini` 就行了。

### 3.1 frpc.ini

```
[common]server_addr = 160.55.78.180server_port = 33893[plugin_socks5]type = tcpremote_port = 44555plugin = socks5plugin_user = aDminplugin_passwd = Us@A
```

### 3.2 fprs.ini

```
[common]bind_port = 33893bind_addr = 0.0.0.0protocol = tcptls_enable = true
```

### 3.3 frpcs.ini

```
[supervisord]
nodaemon=true

[program:frps]
command=/frp/frps -c /frp/frps.ini 

[program:frpc]
command=/frp/frpc -c /frp/frpc.ini
```

### 3.4 Dockerfile 国际版

```
FROM ubuntu:14.04LABEL maintainer="crowsec"ENV VERSION 0.48.0ENV TZ=Asia/Shanghai# 安装依赖软件包RUN apt-get update && apt-get install -y wget tar supervisor# 设置时区RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone# 判断系统并下载 frpRUN if [ "$(uname -m)" = "x86_64" ]; then export PLATFORM=amd64 ; \    elif [ "$(uname -m)" = "aarch64" ]; then export PLATFORM=arm64 ; \    elif [ "$(uname -m)" = "armv7" ]; then export PLATFORM=arm ; \    elif [ "$(uname -m)" = "armv7l" ]; then export PLATFORM=arm ; \    elif [ "$(uname -m)" = "armhf" ]; then export PLATFORM=arm ; fi \    && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${PLATFORM}.tar.gz \ && sleep 5 \    && tar xzf frp_${VERSION}_linux_${PLATFORM}.tar.gz \    && cd frp_${VERSION}_linux_${PLATFORM} \    && mkdir /frp\    && mv frpc /frp \    && mv frps /frp \    && cd .. \    && rm -rf *.tar.gz frp_${VERSION}_linux_${PLATFORM}# 拷贝配置文件和监控进程工具COPY ./frpc.ini /frp/COPY ./frps.ini /frp/COPY frpcs.conf /etc/supervisor/conf.d/# 启动 supervisordCMD ["/usr/bin/supervisord"]
```

### 3.5 Dockerfile 国内版

在这里使用的是阿里云的源进行加速，但是 `github` 并没有加速，其实 `build` 起来还是很慢很慢。。。所以如果下载 `github` 下载不下来，需要多试几次：

```
FROM ubuntu:14.04LABEL maintainer="crowsec"ENV VERSION 0.48.0ENV TZ=Asia/Shanghai# 切换软件源为阿里云RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list# 安装依赖软件包RUN apt-get update && apt-get install -y wget tar supervisor# 设置时区RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone# 判断系统并下载 frpRUN if [ "$(uname -m)" = "x86_64" ]; then export PLATFORM=amd64 ; \    elif [ "$(uname -m)" = "aarch64" ]; then export PLATFORM=arm64 ; \    elif [ "$(uname -m)" = "armv7" ]; then export PLATFORM=arm ; \    elif [ "$(uname -m)" = "armv7l" ]; then export PLATFORM=arm ; \    elif [ "$(uname -m)" = "armhf" ]; then export PLATFORM=arm ; fi \    && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${PLATFORM}.tar.gz \ && sleep 6 \    && tar xzf frp_${VERSION}_linux_${PLATFORM}.tar.gz \    && cd frp_${VERSION}_linux_${PLATFORM} \    && mkdir /frp \    && mv frpc /frp \    && mv frps /frp \    && cd .. \    && rm -rf *.tar.gz frp_${VERSION}_linux_${PLATFORM}# 拷贝配置文件和监控进程工具COPY ./frpc.ini /frp/COPY ./frps.ini /frp/COPY frpcs.conf /etc/supervisor/conf.d/# 启动 supervisordCMD ["/usr/bin/supervisord"]
```

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLAsH70icIaZ9ML9HgvMia5qlBaCBUNQ1oTqRQFX4MINcaSicP4q1th0GVg/640?wx_fmt=png)image.png

### 3.6 使用

build：

```
docker build -t frpcs:v1.0 .
```

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLVLvIZdHJWlxrkjxE1qrco4PGzaZHS3BYicC7Qdb7ykyzGnVFXwGXJwQ/640?wx_fmt=png)image.png

使用：

```
docker run -dt --name frpcs -p 33893:33893 -p 44555:44555 --rm frpcs:v1.0
```

![](https://mmbiz.qpic.cn/mmbiz_png/HficxWTTwt1CCKViagK0ZAjichic1R9SXzZLSZKPa3Yiam9icSP2tVn4rLNg2qt5wTLFnfG2wtw4cdb3sjC1wIhVoMiaw/640?wx_fmt=png)image.png

4. 总结
=====

在这里可以简单理解为只做了 `frp` 的下载以及解压操作，没有对 `frp` 进行混淆啥的，毕竟自己用，能简单一点就简单一点吧。

tips：加我 wx，拉你入群，一起学习

![](https://mmbiz.qpic.cn/mmbiz_jpg/HficxWTTwt1ACBHDE9o8KA6icOCZVKdLBJOca699BJK50FDxBNnhRZrS1hyXb2K4AkLTYfJwticmyHQxv3X6vZHfQ/640?wx_fmt=jpeg)

![](https://mmbiz.qpic.cn/mmbiz_jpg/HficxWTTwt1CIQMic7eibrf45I1BAyu02iagmOZ70PmiaFwfKDMDZ7vuAicZ0cz6jYsYZHPLlVV63HvE4oz1CxjOmGhQ/640?wx_fmt=jpeg)

![](https://mmbiz.qpic.cn/mmbiz_png/CibE0jlnugbX5SLGI9312kOrkH7gXIN5NPic75bQ8WbAFMEqvZiaQ0WSk4W9eYUfJJRzlMgibjic8mIGicMvjialoDgmQ/640?wx_fmt=png)

![](https://mmbiz.qpic.cn/mmbiz_jpg/HficxWTTwt1ACBHDE9o8KA6icOCZVKdLBJkslQQ2B5nDuKBlpbKHHtME5RBrJsYucDbPWpyglY02yicRq93PTWn7w/640?wx_fmt=jpeg)

扫取二维码获取

更多精彩

乌鸦安全

![](https://mmbiz.qpic.cn/mmbiz_gif/HficxWTTwt1Bt3mgRlo88wGCQuAJ2kv0pzM18jFmpv4CJEBMNAicGSSvDlWSN6DG5JJ0Q8EI6oEuaZS0QNyAojYw/640?wx_fmt=gif)