> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [1024.day](https://1024.day/d/244)

> Linux 终端挂代理，下面分享两种方法： 1、ProxyChains 是一个终端代理方案，使用比较简单，直接安装： apt install proxychains 编辑 /etc/proxychain......

Linux 终端挂代理，下面分享两种方法：

1、ProxyChains 是一个终端代理方案，使用比较简单，直接安装：

`apt install proxychains`

编辑 `/etc/proxychains.conf` 文件，vi 翻至最下面，把默认的 tor 的代理端口，换成你的客户端代理端口，比如常用的 Shawdowsocks 代理：

`vi /etc/proxychains.conf`

翻到最下面把 tor 端口改成：

`socks5 127.0.0.1 1080`

先启动代理，连接至服务器，然后，只需要在运行程序的命令前加上 proxychains 即可。比如：

`proxychains curl www.google.com`

2、把代理服务器地址写入 shell 配置文件 .bashrc

`echo "export ALL_PROXY=socks5://127.0.0.1:1080" >> /root/.bashrc`

然后： `source /root/.bashrc`

这种方法会导致所有请求都走代理了，没有第一种来得方便。