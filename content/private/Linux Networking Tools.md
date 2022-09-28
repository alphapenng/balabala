---
2022-08-01 17:10:51
---

# Linux Networking Tools

[toc]

## ss

> ss command is a tool that is used for displaying network socket related information on a Linux system.

ss 命令是一个用于在 Linux 系统上显示网络套接字相关信息的工具。

![ss](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_ss.png)

## nmap

> Nmap is short for Network Mapper. It is an open-source Linux cmd-line tool that is used to scan IPs & ports in a nw & to detect installed apps. Nmap allows nw admins to find which devices r running on their nw, discover open ports & services, and detect vulnerabilities.

Nmap 是网络映射器的缩写。它是一个开源 Linux cmd-line 工具，用于扫描网络中的 IP 和端口并检测已安装的应用程序。 Nmap 允许网络管理员找到哪些设备在他们的网络上运行，发现开放的端口和服务，并检测漏洞。

![nmap](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_nmap.png)

## ping & traceroute

> Ping cmd is used to test d ability of d src system to reach a specified destination system.

ping cmd 用于测试 d src 系统到达指定目标系统的能力。

> Traceroute is a nw diagnostic tool used to track in realtime d pathway taken by a pkt on an IP nw from src to dest,reporting d IPaddr of all d routers it pinged in b/n

Traceroute 是一个网络诊断工具，用于实时跟踪数据包在 IP 网络上从 src 到 dest 采取的路径，报告它在 b/n 中 ping 的所有 d 路由器的 d IPaddr

![ping_traceroute](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_ping_traceroute.png)

## ethtool

> Ethtool is a Network Interface Card (NIC) utility/configuration tool. Ethtool allows you to query and change your NIC settings such as the Speed, Port, auto-negotiation and many other parameters.

Ethtool 是网络接口卡 (NIC) 实用程序 / 配置工具。 Ethtool 允许您查询和更改您的 NIC 设置，例如速度、端口、自动协商和许多其他参数。

![ethtool](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_ethtool.png)

## dig

> Dig (Domain Information Groper) is a powerful cmd-line tool for querying DNS name servers.
> It allows you to query info abt various DNS records, including host addresses, mail exchanges, & name servers. A most common tool among sysadmins for troubleshooting DNS problems.

Dig (Domain Information Groper) 是一个强大的命令行工具，用于查询 DNS 名称服务器。
它允许您查询各种 DNS 记录的信息，包括主机地址、邮件交换和名称服务器。它是系统管理员用于解决 DNS 问题的最常用工具。

![dig](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_dig.png)

## netcat

> Netcat is one of d powerful networking tool, security tool or nw monitoring tool. It acts like cat cmd over a nw.
> It is generally used for:
> Port Scanning /listening/redirection
> open Remote connections
> Read/Write data across network
> Network debugging
> Network daemon test

Netcat 是强大的网络工具、安全工具或网络监控工具之一。它的作用就像 cat cmd over a nw。
它一般用于：
端口扫描 / 监听 / 重定向
打开远程连接
跨网络读 / 写数据
网络调试
网络守护程序测试

![netcat](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_netcat.png)

## socat

> The socat command shuffles data between two locations. One way to think of socat is as the cat command which transfers data between two locations rather than from a file to standard output.

socat 命令在两个位置之间打乱数据。将 socat 视为 cat 命令的一种方式，它在两个位置之间传输数据，而不是从文件传输到标准输出。

![socat](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_socat.png)

## tcpdump

> Tcpdump is a command line utility that allows you to capture and analyze network traffic going through your system. It is often used to help troubleshoot network issues, as well as a security tool.

Tcpdump 是一个命令行实用程序，可让您捕获和分析通过系统的网络流量。它通常用于帮助解决网络问题以及安全工具。

![tcpdump](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_tcpdump.png)

## top

> The top command is used to show the active Linux processes. It provides a dynamic real-time view of the running system. Usually, this command shows the summary information of the system and the list of processes or threads which are currently managed by the Linux kernel.

top 命令用于显示活动的 Linux 进程。它提供了正在运行的系统的动态实时视图。通常，此命令显示系统的摘要信息以及当前由 Linux 内核管理的进程或线程列表。

![top](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_top.png)

## wireshark

> Wireshark is a packet sniffer and analysis tool. It captures network traffic on the local network and stores that data for offline analysis.

Wireshark 是一个数据包嗅探器和分析工具。它捕获本地网络上的网络流量并存储该数据以供离线分析。

![wireshark_cheatsheet](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_10_wireshark_cheatsheet.jpg)
