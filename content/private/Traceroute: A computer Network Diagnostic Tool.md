<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2021-10-28 11:39:22
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-01-15 21:58:41
 * @FilePath: /balabala/content/private/Traceroute: A computer Network Diagnostic Tool.md
-->

# Traceroute: A computer Network Diagnostic Tool

- [Traceroute: A computer Network Diagnostic Tool](#traceroute-a-computer-network-diagnostic-tool)
  - [Traceroute: A computer Network Diagnostic Tool](#traceroute-a-computer-network-diagnostic-tool-1)
  - [What is traceroute ?](#what-is-traceroute-)
  - [The syntax](#the-syntax)
  - [How does it work?](#how-does-it-work)
  - [Time-To-Live](#time-to-live)
  - [Let’s look at an example](#lets-look-at-an-example)
  - [Time Outs](#time-outs)
  - [traceroute cmd](#traceroute-cmd)
    - [In Windows the command name is - tracert](#in-windows-the-command-name-is---tracert)
    - [The traceroute cmd on Linux](#the-traceroute-cmd-on-linux)
  - [RTT](#rtt)
  - [Asterisks(\*）](#asterisks)

## Traceroute: A computer Network Diagnostic Tool

- How does it work! 🤔
- Ping works fine but not traceroute! 🤨
- What are the stars in traceroute output! ***

## What is traceroute ?
>
> traceroute tracks the route packets take across an IP network on their way to a given host.
It assists you in troubleshooting nw connectivity issues from your Destination to a Remote destination by using echo packets (ICMP) to visually trace the route.

 traceroute 跟踪数据包在到达给定主机的途中通过 IP 网络的路由。
它通过使用回显数据包 (ICMP) 直观地跟踪路由，帮助您解决从目标到远程目标的网络连接问题。

## The syntax
>
> The cmd traceroute <x> (x here being an IP or hostname) is d most basic version & it will begin to send packets to d designated target. This result will allow u to trace d path of d packets sent from ur machine to each of d systems b/n u & ur desired destination.

traceroute <X> （x 在这里是 IP 或主机名）是 最基本的版本，它将开始向指定目标发送数据包。这个结果将允许你跟踪从你的机器发送到每个系统 b/n 和你想要的目的地的数据包的路径。

## How does it work?
>
> Traceroute uses TTL (Time to Live) field in d IP pkt header. TTL is used to prevent pkts from being forwarded forever when der is a routing loop. Whenever an IP pkt is forwarded by a router, d TTL is decreased by 1. When d TTL is 0, d IP pkt  will be discarded.

Traceroute 使用在 IP 数据包标头中 TTL（生存时间）字段。当目的地址为环路时，TTL用于防止数据包永远转发。每当路由器转发一个IP 数据包时，TTL 值减1。当 TTL 值为0 时， IP 数据包将被丢弃。

![IP 头字段](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_28_IP%20%E5%A4%B4%E5%AD%97%E6%AE%B5.png)

## Time-To-Live
>
> As the packet hops from one router to router through to get to its destination, each router is required to decrement the echo packets TTL by a minimum of 1 before proceeding to forward the packet to the next router.
In other words, Time-To-Live is a Hop Counter by design.

当数据包从一个路由器跳到另一个路由器以到达其目的地时，在继续将数据包转发到下一个路由器之前，每个路由器都需要将回声数据包 TTL 递减至少 1。
换句话说，Time-To-Live 是一个跳数计数器。

## Let’s look at an example

1. Let’s say that from H1 (192.168.1.1) we send a trace to S1 (192.168.3.1). The first IP packet that H1 sends, will have a TTL of 1:
    假设我们从 H1 (192.168.1.1) 向 S1 (192.168.3.1) 发送跟踪。 H1 发送的第一个 IP 数据包的 TTL 为 1：
    ![](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_28_ZG00AP.jpg)
2. When R1 receives the IP packet, it will want to forward it to R2 but it has to decrease the TTL from one to zero, as a result, the IP packet will be dropped and R1 will respond to H1 with a TTL exceeded message. H1 will now send a second packet with a TTL of 2:
    当 R1 收到 IP 数据包时，它想将其转发给 R2，但它必须将 TTL 从 1 减少到 0，结果，IP 数据包将被丢弃，R1 将使用 TTL 超出消息响应 H1。 H1 现在将发送第二个 TTL 为 2 的数据包：
    ![](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_28_BvUKIq.jpg)
3. R1 will decrease the TTL from two to one, forwards it and now R2 has to drop it. R2 will respond with a TTL exceeded message. H1 will now send another IP packet with a TTL of 3:
    R1 会将 TTL 从 2 减少到 1，转发它，现在 R2 必须丢弃它。 R2 将响应 TTL 超出消息。 H1 现在将发送另一个 TTL 为 3 的 IP 数据包：
    ![](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_28_CVNFR2.jpg)
4. R1 will decrease the TTL from three to two, R2 decrease it from two to one and R3 will have to drop it. R3 sends the TTL exceeded message to R1. The last IP packet that H1 will send will have a TTL of four:
    R1 将 TTL 从 3 减少到 2，R2 将其从 2 减少到 1，R3 将不得不放弃它。 R3 将 TTL 超出消息发送到 R1。 H1 将发送的最后一个 IP 数据包的 TTL 为 4：
    ![](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_28_G7WmXH.jpg)
5. Each router will decrease the TTL by one, our server on the other end will receive an IP packet with a TTL of one and replies with an ICMP reply to H1. We now know that the destination is reachable and we have learned all routers in our path.
    每个路由器都会将 TTL 减 1，我们另一端的服务器将收到一个 TTL 为 1 的 IP 数据包，并以 ICMP 回复回复 H1。我们现在知道目的地是可达的，并且我们已经了解了路径中的所有路由器。
6. Each IP packet that we send is called a probe. Traceroute can be used with ICMP, UDP and TCP, depending on your operating system.
    我们发送的每个 IP 数据包都称为探测。 Traceroute 可用于 ICMP、UDP 和 TCP，具体取决于您的操作系统。

## Time Outs

1. Time Outs - The most likely problem that you'll encounter when you use tracert is a timeout during one of the hops. Timeouts are indicated by asterisks where you'd expect to see a time.
    超时 - 使用 tracert 时最可能遇到的问题是其中一个跃点期间的超时。超时用星号取代了时间数值。
2. Possible Reason - Sometimes, timeouts are caused by temporary problems, so you should try the tracert again to see if the problem persists. If you keep getting timeouts at the same router, the router could be having a genuine problem.
    可能的原因 - 有时，超时是由临时问题引起的，因此您应该再次尝试 tracert 以查看问题是否仍然存在。如果您一直在同一路由器上超时，则路由器可能存在真正的问题。

## traceroute cmd

### In Windows the command name is - tracert
>
> To use tracert, type the tracert command followed by the host name of the computer to which you want to trace the route.

要使用 tracert，请键入 tracert 命令，后跟要跟踪路由的计算机的主机名。
 ![](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_28_sf28k2.jpg)

### The traceroute cmd on Linux
 >
 > The traceroute cmd on Linux works similar to Windows. One important difference is that it doesn’t use ICMP but UDP. It also allows u to specify the no of IP pkts (probes) you want to send.
For e.g.
`# traceroute -N 1 -q 1 192.168.3.1`
Where -q sets d  no. of probe pkts per hop.

Linux 上的 traceroute 命令的工作方式类似于 Windows。一个重要的区别是它不使用 ICMP，而是使用 UDP。它还允许您指定要发送的 IP 包（探针）的数量。
例如
`# traceroute -N 1 -q 1 192.168.3.1`
其中 -q 设置目的地每跳探测包的数量。

> Traceroute, by default, measures 30 hops of 60-byte packets.

默认情况下，Traceroute 测量 60 字节数据包的 30 跳。

## RTT
>
> You can tell here where hop one actually landed, and then there are three numerical values. These are known as the Round-Trip Time (RTT), which refers to the amount of time that a given packet takes to reach its destination and route back an ICMP message to the source.

你可以在前三个数值这里知晓每一跳实际到达的时间。这些被称为往返时间 (RTT)，它指的是给定数据包到达其目的地并将 ICMP 消息路由回源所花费的时间。
![](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_10_28_HvytSj.jpg)

> Every packet routes an ICMP error message back to the source when it reaches a device on the network. This action allows traceroute to determine the RTT of that packet and does not necessarily indicate an error.

当每个数据包到达网络上的设备时，它会将 ICMP 错误消息路由回源。此操作允许 traceroute 确定该数据包的 RTT，并且不一定指示错误。

## Asterisks(*）
>
> Sometimes We see only stars (*).
What does that mean?
What do these stars (asterisks) mean?
Were the packets dropped?
Are they timed out?
The same time ping works fine. What could be the reason!

有时我们只看到星星 (*).
这意味着什么？
这些星星（星号）是什么意思？
数据包是否被丢弃？
他们超时了吗？
同时 ping 工作正常。可能是什么原因！

> Let me explain.
There r two possibilities -
1st, ICMP/UDP may not be configured. If d traceroute cmd completes successfully & u see these stars, most likely d device dat was hit wasnt configured to reply to ICMP/UDP traffic. This result doesnt mean that d traffic wasn't passed.

让我解释。
有两种可能 ——
第一，ICMP/UDP 可能没有配置。如果 traceroute 命令成功完成并且您看到这些星星，很可能设备数据未配置为回复 ICMP/UDP 流量。这个结果并不意味着流量没有通过。

> The second possibility is that the packets were dropped due to an issue on the network. These results are usually packet timeouts, or the traffic has been blocked by a firewall.

第二种可能性是数据包由于网络问题而被丢弃。这些结果通常是数据包超时，或者流量已被防火墙阻止。

> In the traceroute cmd output few additional annotation can be printed:
!H, !N, !P (host, nw or protocol unreachable)
!S (source route failed)
!F (fragmentation needed)
!X (communication administratively prohibited)
!V (host precedence violation)
!C (precedence cutoff in effect)

在 traceroute cmd 输出中，可以打印一些额外的注释：

 !H, !N, !P（主机、网络或协议不可达）
 !S（源路由失败）
 !F（需要分片）
 !X（行政上禁止通信）
 !V（主机优先级冲突）
 !C（有效的优先级截止）
