---
2022-11-12 14:05:21
---

# HCNP 常用命令

[toc]{type: "ul", level: [2,3]}

## OSPF

### OSPF 基本配置

1. 查看 DR/BDR 选举情况

```
<>dis ospf interface
[]int g0/0/1
[g0/0/1]ospf dr-priority 2
<>reset ospf 1 process
```

2. 配置 OSPF 的接口开销值

```
[]int g0/0/0
[g0/0/0]ospf cost 2000
```

3. 配置 OSPF 被动接口

```
[]ospf
[ospf-1]silent-interface e1/0/0
```

4. 配置 OSPF 的认证功能

```
[]ospf 1
[ospf-1]area 0
[ospf-1-area-0.0.0.0]authentication-mode simple plain Huawei
<>dis ospf peer brief
[]int e1/0/0
[e1/0/0]ospf authentication-mode md5 cipher Huawei
```

### OSPF 邻居邻接关系

```
<>dis ospf peer brief
<>dis ospf peer
<>dis ospf peer g0/0/0
```

1. 观察 OSPF 邻居邻接关系的建立过程

```
<R1>dis ospf peer brief
<R1>debugging ospf packet
<R1>reset ospf process
# 将 Ｒ1 的 GE 0/0/0 和 R2 的 GE 0/0/0 接口优先级的值改为 0，放弃 DR 的选举，使它们都成为 DRothers，以便观察它们之间的 OSPF 邻居关系
[R1]interface g0/0/0
[R1-g0/0/0]ospf dr-priority 0
[R2]interface g0/0/0
[R2-g0/0/0]ospf dr-priority 0
<R3>dis ospf peer R3 与 R1 和Ｒ 2 都为 Full 状态
<R1>dis ospf peer R1 和 R2 为 2-way 状态
<R1>debugging ospf packet
<R1>reset ospf process
# 观察点到点网络中 OSPF 的邻居关系建立情况
<R1>dis ospf peer brief
<R1>debugging ospf packet
<R1>reset ospf process
```

💁 **点到点路由器没有经过 2-way 状态，并且也不存在 2-way 状态，说明点到点网络与广播网络中 OSPF 的邻接关系建立过程不是完全一样的。在点到点网络中，能够建立 OSPF 邻居关系的路由器一定会继续建立邻接关系。**

2. 观察 OSPF 链路状态数据库的同步过程

```
<R1>debugging ospf packet
<R1>reset ospf process
```

💁 **OSPF 邻居邻接关系建立的过程：首先双方通过 Hello 报文进行协商，然后通过数据库描述（DD：Database Description）报文、链路状态请求（LSR：Link State Request）报文、链路状态更新（LSU：Link State Update）报文等，最终实现了 LSDB 的同步，并建立起 OSPF 邻接关系。**

💁 **Hello 报文：网络掩码 24 位，Hello 间隔时间为 10s，路由器死亡时间间隔为 40s，网络上没有 DR 和 BDR。另外，报文中指出了活跃邻居，这说明双方成功建立了 OSPF 邻居关系。**

### OSPF 链路状态数据库

-   Type-1 LSA（Router LSA）：每台路由器都会产生，用来描述路由器的直连链路状态和开销值。Type-1 LSA 只能在所属区域内部泛洪，不能泛洪到其他区域。
-   Type-2 LSA（Network LSA）：它是由 DR 产生的，主要用来描述该 DR 所在网段的网络掩码以及该网段内有哪些路由器。 Type-2 LSA 只能在所属区域内部泛洪，不能泛洪到其他区域。
-   Type-3 LSA（Network Summary LSA）：它是由 ABR（Area Boundary Router）产生的，ABR 路由器将所连区域的 Type-1 和 Type-2 LSA 转换为 Type-3 LSA，用来描述区域间的路由信息。Type-3 LSA 可以泛洪到整个 AS （Autonomous System，自治域）内部，但不能泛洪到 Totally Stub 区域和 Toally NSSA（Not-So-Stubby Area）区域。
-   Type-4 LSA（ASBR Summary LSA）：它是由 ASBR（Autonomous System Boundary Router）所在区域的 ABR 产生的，用来描述到 ASBR 的路由。Type-4 LSA 可以泛洪到整个 AS 内部，但不能泛洪到 Stub 区域、Totally Stub 区域、NSSA 区域和 Totally NSSA 区域中。
-   Type-5 LSA （AS External LSA）：它是由 ASBR 产生的，用来描述到 AS 外部网络的路由。Type-5 LSA 可以泛洪到整个 AS 内部，但不能泛洪到 Stub 区域、Totally Stub 区域、NSSA 区域和 Totally NSSA 区域中。
-   Type-6 LSA：用于 OSPF 组播。
-   Type-7 LSA（NSSA LSA）：它是由 NSSA 区域或 Totally NSSA 区域的 NSSA ASBR 产生的，用来描述到 AS 外部的路由。Type-7 LSA 只能出现在所属 NSSA 区域或 Totally NSSA 区域内部。

1. 在 Ｒ 2、R5 的 GE0/0/0 接口上修改接口优先级的值，使 R5 成为 DR，Ｒ 2 成为 BDR。

```
[R2]int g0/0/0
[R2-g0/0/0]ospf dr-priority 50
[R5]int g0/0/0
[R5-g0/0/0]ospf dr-priority 100
# 在 R2、R3、R5 上重启 OSPF 进程
<R5>reset ospf process
# 在 R1 和 R4 上使用 Route-Policy 精确匹配 Loopback 1 接口的直连路由并引入 OSPF 进程
[R1]acl 2000
[R1-acl-basic-2000]rule permit source 192.168.1.0 0.0.0.255
[R1-acl-basic-2000]route-policy 10 permit node 1
[R1-route-policy]if-match acl 2000
[R1-route-policy]ospf 10
[R1-ospf-10]import-route direct route-policy 10
[R4]acl 2000
[R4-acl-basic-2000]rule permit source 172.16.1.0 0.0.0.255
[R4-acl-basic-2000]route-policy 10 permit node 1
[R4-route-policy]if-match acl 2000
[R4-route-policy]ospf 10
[R4-ospf-10]import-route direct route-policy 10
```

2. 查看 Type-1 LSA，Type-2 LSA，Type-3 LSA

```
<R5>dis ospf lsdb
# 在 R5 上查看 Router-ID 为 10.0.2.2 产生的 Router LSA 的详细信息
<R5>dis ospf lsdb router 10.0.2.2
# OSPF 协议会把 Broadcast 和 NBMA 这两种具有多路访问能力的网络都认为是 TransNet 网络。
<R5>dis ospf lsdb network 10.0.235.5
# 在 R2 上查看 LinkState ID 为 10.0.12.0 的这条 Sum-Net LSA 的详细信息
<R2>dis ospf lsdb summary 10.0.12.0
```

💁 **区域间的路由是根据 Sum-Net LSA 并结合 Router LSA 及 Network-LSA 计算出来的。对于某个区域的一台 OSPF 路由器来说，它无需了解其他区域的链路状态信息，但可以通过 Sum-Net LSA 并结合 Router LSA 及 Network-LSA 计算出区域间路由；计算区域间路由时，采用的不再是链路状态算法，而是距离矢量算法。**

💁 **对于 ABR 来说，如果在自己相连的某个区域的 LSDB 中存在某条 Sum-Net LSA，并且该 Sum-Net LSA 的 AdvRouter 不是自己的 Router-ID 时，就会将这条 Sum-Net LSA 的 AdvRouter 修改为自己的 Router-ID，并重新计算自己到达这条 Sum-Net LSA 的 Cost 值，然后将之泛洪到与自己相连的其他区域中。**

3. 查看 Type-4 LSA 和 Type-5 LSA

```
[R1]dis ospf lsdb ase 192.168.1.0
[R5]dis ospf lsdb asbr 10.0.1.1
在 R5 上使用 display ospf abr-asbr 命令查看到达 ABR 和 ASBR 的 Cost 值。
<R5>dis ospf abr-asbr
```

💁 **Sum-Net LSA 和 Sum-Asbr LSA 的相同点是它们都由 ABR 产生，并且其 AdvRouter 在泛洪过程中会作相应的改变，不同点在于 Sum-Net LSA 是用来计算区域间的路由的，而 Sum-Asbr LSA 是用来计算到达 ASBR 的路由的。**

4. 查看 Type-7 LSA

```
<R4>dis ospf lsdb nssa 172.16.1.0
```

### OSPF Stub 区域

💁 **配置 Stub 和 Totally Stub 区域的时候需要注意以下几点：骨干区域（Area 0）不能被配置成为 Stub 区域或者 Totally Stub 区域，Virtual-link 不能通过 Stub 区域或者 Totally Stub 区域，Stub 区域或者 Totally Stub 区域中不允许包含有 ASBR 路由器。**

1. 使用命令 display ospf 1 routing 来只查看 OSPF 路由表的信息。

```
<R4>dis ospf 1 routing
<R4>dis ospf lsdb
```

💁 **在 LSDB 中，除了表示企业外部网络 20.0.0.0 的那条 External LSA 之外，还存在着另外 3 条 External LSA，其原因是此前采取了直接引入直连路由的方式来引入外部路由，所以将 R3 上的所有直连网段的路由全部引入了进来。也就是说，现在 R4 可以通过两种方式获得这 3 条路由（10.0.13.0/24，10.0.23.0/24，3.3.3.3/32），一种是在 OSPF 内部获得，一种是通过 OSPF 外部获得。在这种情况下，会首先比较两种不同方式下的路由优先级：OSPF 内部路由优先级的值为 10，而外部路由优先级的值为 150，所以最终的选择结果应该是从内部获得该 3 条路由（注意，优先级的值越大，优先级越低）。**

2. 配置 Stub 区域

```
[R1]ospf
[R1-ospf-1]area 1
[R1-ospf-1-area-0.0.0.0]stub
[R1-ospf-1-area-0.0.0.1]area 2
[R1-ospf-1-area-0.0.0.2]stub
<R4>dis ospf lsdb
# 通过调整 ABR 路由器所通告的缺省路由的开销值来实现主备备份。在 R2 的区域 1 中，配置命令 default cost 10，表示将发送到该 Stub 区域的 Type-3 LSA 的缺省路由开销值设为 10。同样，在 R1 的区域 2 中，配置命令 default cost 10。
[R2]ospf
[R2-ospf-1]area 1
[R2-ospf-1-area-0.0.0.1]default-cost 10
[R1]ospf
[R1-ospf-1]area 2
[R1-ospf-1-area-0.0.0.2]default-cost 10
<R4>dis ospf lsdb
<R5>dis ospf lsdb
```

3. 配置 Totally Stub 区域

```
# 配置 Totally Stub 区域时，只需在 stub 命令之后添加 no-summary 选项，且只需在 ABR 上进行配置。
[R1]ospf
[R1-ospf-1]area 1
[R1-ospf-1-area-0.0.0.1]stub no-summary
[R1-ospf-1]area 2
[R1-ospf-1-area-0.0.0.2]stub no-summary
[R2]ospf
[R2-ospf-1]area 1
[R2-ospf-1-area-0.0.0.1]stub no-summary
[R2-ospf-1]area 2
[R2-ospf-1-area-0.0.0.2]stub no-summary
<R4>dis ospb lsdb
```

### OSPF NSSA 区域

1. 配置 NSSA 和 Totally NSSA 区域

```
[R2]ospf 10
[R2-ospf-10]area 1
[R2-ospf-10-area-0.0.0.1]nssa
[R3]ospf 10
[R3-ospf-10]area 1
[R3-ospf-10-area-0.0.0.1]nssa
[R4]ospf 10
[R4-ospf-10]area 1
[R4-ospf-10-area-0.0.0.1]nssa
<R4>dis ospf lsdb
# 使用 nssa no-summary 命令还可以进一步阻止 Type-3 LSA 泛洪到 NSSA 区域 1，使之成为一个 Totally NSSA 区域。
[R2]ospf 10
[R2-ospf-10]area 1
[R2-ospf-10-area-0.0.0.1]nssa no-summary
[R3]ospf 10
[R3-ospf-10]area 1
[R3-ospf-10-area-0.0.0.1]nssa no-summary
<R4>dis ospf lsdb
```

2. 修改 NSSA 区域缺省路由开销值

```
# 增大 R3 向区域 1 通告的 LinkState ID 为 0.0.0.0 的 Type-3 LSA 的开销值。
[R3]ospf 10
[R3-ospf-10]area 1
[R3-ospf-10-area-0.0.0.1]default-cost 10
```

### OSPF 虚链路

💁 **OSPF 协议还要求骨干区域必须是唯一且连续的，然而，由于发生故障等原因，骨干区域有可能出现被分割的情况。此时，同样可以使用需链路来实现物理上被分割的骨干区域能够逻辑相连。**

💁 **虚链路在网络中会穿越其他区域，因此可能会带来安全隐患，所以通常都会对虚链路进行认证功能的配置。虚链路认证其实是 OSPF 接口认证的一种，支持 MD5、HMAC-MD5、明文及 Keychain 等特性。**

1. 使用虚链路使区域 2 与 区域 0 逻辑相连

```
# 在 R3 的区域 1 视图下，使用 vlink-peer 命令建立与 R1 的虚链路。
[R3]ospf 10
[R3-ospf-10]area 1
[R3-ospf-10-area-0.0.0.1]vlink-peer 10.0.1.1
# 同样，在 R1 的区域 1 视图下，使用 vlink-peer 命令建立与 R3 的虚链路。
[R1]ospf 10
[R1-ospf-10]area 1
[R1-ospf-10-area-0.0.0.1]vlink-peer 10.0.3.3
[R1]dis ospf vlink
```

2. 修改虚链路的开销值

```
[R2]ospf 10
[R2-ospf-10]area 1
[R2-ospf-10-area-0.0.0.1]vlink-peer 10.0.3.3
[R3]ospf 10
[R3-ospf-10]area 1
[R3-ospf-10-area-0.0.0.1]vlink-peer 10.0.2.2
[R3]dis ospf vlink
# 由于虚链路实际使用的路径是在传输区域内经过 SPF（Short Path First）算法计算出的最优路径，虚链路的开销值其实就是 OSPF 协议在传输区域内所选用的物理路径的开销值，所以修改虚链路的开销值其实就是修改物理路径的 OSPF 开销值。
在 R3 的 GE0/0/2 接口上修改 OSPF 协议开销值。
[R3]int g0/0/2
[R3-g0/0/2]ospf cost 10
在 R2 的 GE0/0/2 接口上完成同样的配置。
[R2]int g0/0/2
[R2-g0/0/2]ospf cost 10
```

3. 使用虚电路作为区域 0 链路的冗余备份

```
# R1 与 R2 之间只有单条链路连接，如果出现链路故障，就会导致区域 0 被分割的问题。为了解决这一问题，增强网络的可靠性，可以以区域 1 为传输区域，在 R1 与 R2 之间建立一条虚链路作为冗余备份。
[R1]ospf 10
[R1-ospf-10]area 1
[R1-ospf-10-area-0.0.0.1]vlink-peer 10.0.2.2
[R2]ospf 10
[R2-ospf-10]area 1
[R2-ospf-10-area-0.0.0.1]vlink-peer 10.0.1.1
[R1]dis ospf vlink
```

4. 配置虚链路的认证功能

```
[R1]ospf 10
[R1-ospf-10]area 1
[R1-ospf-10-area-0.0.0.1]vlink-peer 10.0.2.2 hmac-md5 1 plain huawei
<R1>dis ospf vlink
[R2]ospf 10
[R2-ospf -10]area 1
[R2-ospf-10-area-0.0.0.1]vlink-peer 10.0.1.1. hmac-md5 1 plain huawei
<R1>dis ospf vlink
```

### OSPF 网络类型

```
<R1>debugging ospf packet hello 对 OSPF Hello 报文的情况进行调试
```

1. 配置 OSPF 的 NBMA 及 Broadcast 网络类型

```
[R1]int s1/0/0
[R1-s1/0/0]ospf network-type nbma
[R2]int s1/0/0
[R2-s1/0/0]ospf network-type nbma
[R3]int s1/0/0
[R3-s1/0/0]ospf network-type nbma
# 为了验证 NBMA 网络的特点，可在 R1，R2，R3 的 Serial 1/0/0 接口配置帧中继映射时不添加关键字 Broadcast，这样一来，即使 OSPF 希望通过组播形式发送 Hello 报文，链路层也无法对组播 Hello 报文进行封装，从而导致无法建立邻接关系。
[R1]interface s1/0/0
[R1-s1/0/0]fr map ip 10.0.123.2 102
[R1-s1/0/0]fr map ip 10.0.123.3 103
[R2]interface s1/0/0
[R2-s1/0/0]fr map ip 10.0.123.1 201
[R3]interface s1/0/0
[R3-s1/0/0]fr map ip 10.0.123.1 301
[R3]dis ospf peer brief
# NBMA 网络类型不支持通过组播方式自动发现邻居，而需要通过手动配置来指定邻居，并通过单播 OSPF Hello 报文来建立邻接关系。
# 在 R1、R2、R3 上使用 peer 命令指定 OSPF 邻居。
[R1]ospf 10
[R1-ospf-10]peer 10.0.123.2
[R1-ospf-10]peer 10.0.123.3
[R2]ospf 10
[R2-ospf-10]peer 10.0.123.1
[R3]ospf 10
[R3-ospf-10]peer 10.0.123.1
<R1>dis ospf peer brief
[R1]int s1/0/0
[R1-s1/0/0]ospf dr-priority 10
[R2]int s1/0/0
[R2-s1/0/0]ospf dr-priority 0
[R3]int s1/0/0
[R3-s1/0/0]ospf dr-priority 0
<R1>dis ospf interface s1/0/0
# 我们还可以将 R1、R2、R3 组成的网络修改为 OSPF Broadcast 类型的网络，但是这有个前提，就是网络中的 PVC 必须支持广播。
[R1]int s1/0/0
[R1-s1/0/0]ospf network-type broadcast
[R1-s1/0/0]fr map ip 10.0.123.2 102 broadcast
[R1-s1/0/0]fr map ip 10.0.123.3 103 broadcast
[R2]int s1/0/0
[R2-s1/0/0]ospf network-type broadcast
[R2-s1/0/0]fr map ip 10.0.123.1 201 broadcast
[R3]int s1/0/0
[R3-s1/0/0]ospf network-type broadcast
[R3-s1/0/0]fr map ip 10.0.123.1 301 broadcast
```

2. 配置 OSPF 的点到多点网络类型
   💁 **点到多点类型与点到点类型非常相似，点到多点网络可以理解为由多个点到点网络组成，它通过组播 OSPF Hello 报文自动发现邻居并建立邻接关系，不选举也不存在 DR 和 BDR。**

```
[R1]int s1/0/0
[R1-s1/0/0]ospf network-type p2mp
[R1-s1/0/0]fr map ip 10.0.123.2 102 broadcast
[R1-s1/0/0]fr map ip 10.0.123.3 103 broadcast
[R2]int s1/0/0
[R2-s1/0/0]ospf network-type p2mp
[R2-s1/0/0]fr map ip 10.0.123.1 201 broadcast
[R3]int s1/0/0
[R3-s1/0/0]ospf network-type p2mp
[R3-s1/0/0]fr map ip 10.0.123.1 301 broadcast
<R1>dis ospf peer
```

### OSPF 路由聚合

-   与 RIP 不同，OSPF 不支持自动路由聚合，仅支持手动路由聚合。OSPF 的路由聚合有两种机制：区域间路由聚合和外部路由聚合。区域间路由聚合必须配置在 ABR 路由器上，指的是 ABR 在把与自己直接相连区域（Area）中的 Type-1 和 Type-2 LSA 转换成 Type-3 LSA 时，对生成的 Type-3 LSA 进行聚合。外部路由聚合必须配置在 ASBR 路由器上，指的是 ASBR 对 Type-5 LSA 进行聚合。

-   区域间路由聚合是 ABR 对与自己直接相连区域内的路由进行聚合，从而减少传播至与自己直接相连的其他区域的 Type-3 LSA 的数量。需要特别强调的是，区域间路由只能聚合由 Type-1 LSA 或 Type-2 LSA 产生的路由；如果路由是由外部或其他区域传到本区域的（或者说路由是由 Type-5 LSA 或 Type-3 LSA 生成的），则对于这样的路由 ABR 是不能够进行聚合的。

-   外部路由聚合是指在 ASBR 路由器上针对引入 OSPF 网络的外部路由进行的聚合，目的是减少在 OSPF 网络中的 Type-5 LSA 的数量。外部路由聚合必须在外部路由进入 OSPF 网络的 ASBR 上进行；外部路由进入 OSPF 网络后，在 ABR 上是无法对相应的 Type-5 LSA 进行聚合的。
-   对于 NSSA 区域，当该区域的 ABR 将 Type-7 LSA 转换为 Type-5 LSA 时，该 ABR 也可以充当 ASBR 的角色，并对 Type-5 LSA 进行聚合。需要注意的是，当 NSSA 区域存在多台 ABR 时，必须由 Router-ID 最大的 ABR 进行 Type-7 LSA 到 Type-5 LSA 的转换操作。NSSA 区域的外部路由聚合有两种方式，一种是在 NSSA 区域的 ASBR 上直接对外部路由进行聚合，另一种是在 NSSA 区域中 Router-ID 最大的、负责将 Type-7 LSA 转成 Type-5 LSA 的 ABR 上进行聚合。

1. 配置 OSPF 及路由引入

```
# 在 R4 上配置去往外部网络的静态路由，并进行引入。
[R4]ip route-static 20.0.5.1 255.255.255.255 10.0.45.5
[R4]ip route-static 20.0.5.2 255.255.255.255 10.0.45.5
[R4]ip route-static 20.0.5.3 255.255.255.255 10.0.45.5
[R4]ospf 10
[R4-ospf-10]import-route static
[R1]dis ospf peer
<R1>dis ip routing-table
```

2. 配置区域间路由聚合

```
<R2>dis ospf lsdb
# 在 ABR 路由器 R1 的区域 1 中配置区域间路由聚合
[R1]ospf 10
[R1-ospf-10]area 1
[R1-ospf-10-area-0.0.0.1]abr-summary 20.0.0.0 255.255.252.0
<R2>dis ospf lsdb
<R2>dis ip routing-table
```

3. 配置外部路由聚合

```
[R4-ospf-10]asbr-summary 20.0.5.0 255.255.255.252
```

4. 在 NSSA 区域的 ABR 上配置外部路由聚合

```
[R3-ospf-10]asbr-summary 20.0.5.0 255.255.255.252
```

### OSPF 监测和调试

1. 监测 OSPF 的基本状态

```
<R2>dis ospf peer
<R2>dis ospf peer brief
<R2>dis ospf interface
<R2>dis ospf interface g0/0/0
<R2>dis ospf lsdb
# dis ospf lsdb 命令后面可以通过添加关键字 router、network、summary、asbr、ase 和 nssa 来查看相应类型的 LSA 的详细信息。
<R2>dis ospf routing
```

2. 调试 OSPF 的工作过程

```
# 开启 debug 功能
<R1>terminal debugging
# 通常情况下，应该避免使用诸如 debugging ip packet 或是 debug nat all 等信息输出特别多的调试命令。
<R1>debugging ospf event 查看 OSPF 协议工作过程中的所有事件
<R1>reset ospf process
# 在获取了所需的调试输出信息后，应尽快使用 undo debugging all 命令关闭所有的调试功能，以减轻设备负担。
<R1>undo debugging all
<R1>debugging ospf packet 通常携带 hello、update 等关键字以便对特定类型的数据包进行调试。
<R1>debugging ospf packet hello 查看 OSPF 协议的 Hello 数据包
```

### OSPF 缺省路由

💁 **在 OSPF 网络环境中，有两种方法可以动态地注入缺省路由。第一种方法是在 ASBR 上手动注入缺省路由，也就是 ASBR 向整个 OSPF 网络泛洪表示缺省路由的 Type-5 LSA，其他路由器通过 Type-5 LSA 所表示的缺省路由来访问外部网络。第二种方法是在 Stub 区域或 Totally Stub 区域以及 NSSA 区域或 Totally NSSA 区域中，由 ABR 自动注入缺省路由，也就是 ABR 向该区域泛洪表示缺省路由的 Type-3 LSA 或 Type-7 LSA，该区域内的路由器通过 Type-3 LSA 或 Type-7 LSA 所表示的缺省路由来访问该区域以外的任何目的地。**

1. 向 stub 区域或 Totally-stub 区域注入缺省路由
2. 向 NSSA 区域或 Totally-NSSA 区域注入缺省路由

### OSPF 故障排除

💁 **OSPF 协议故障问题可以大致分为三类，第一类是涉及 OSPF 邻居关系的建立问题，第二类是涉及 OSPF LSA 的泛洪问题，第三类是涉及 OSPF 路由的计算问题。**

1. 排除 OSPF 的邻居关系故障

```
[R5]dis ospf peer
<R5>reset ospf counter 清空 OSPF 计数器
<R5>dis ospf error 查看错误报文信息
<R1>dis ospf routing router-id 查看 R1 和 R2 的 Router-ID
<R2>dis ospf routing router-id
```

2. 排除 OSPF 的虚链路故障

```
<R3>dis ospf vlink
<R3>dis ospf error
```

## 组播

### IP 组播的基本概念

💁 **广播方式只在同一个网段中才有效，不能跨越网段。**

1. 观察组播方式

```
[R1]multicast routing-enable
[R1]int g0/0/0
[R1-g0/0/0]pim dm
[R1-g0/0/0]int g0/0/1
[R1-g0/0/1]pim dm
[R1-g0/0/1]igmp enable
[R1-g0/0/1]int g0/0/2
[R1-g0/0/2]pim dm
[R1-g0/0/2]igmp enable
```

### IGMP

1. 配置组播协议

```
[R1]multicast routing-enable
[R1]int g0/0/0
[R1-g0/0/0]pim dm
[R1-g0/0/0]int g0/0/1
[R1-g0/0/1]pim dm
[R2]multicast routing-enable
[R2]int g0/0/0
[R2-g0/0/0]pim dm
[R2-g0/0/0]int g0/0/1
[R2-g0/0/1]pim dm
```

2. 配置 IGMPv1

```
[R1]int g0/0/1
[R1-g0/0/1]igmp enable
[R1-g0/0/1]igmp version 1
<R1>dis igmp interface
# 在 R1 上打开 IGMP 的 Debug 功能
<R1>debugging igmp report
<R1>debugging igmp event
<R1>terminal monitor
<R1>terminal debugging
<R1>dis igmp group
# 在 R1 上打开 IGMP Debug 离组消息
<R1>dubugging igmp leave
```

3. 配置 IGMPv2

```
[R1]int g0/0/1
[R1]g0/0/1]igmp version 2
[R2]int g0/0/1
[R2-g0/0/1]igmp enable
[R1]dis igmp interface
[R2]dis igmp interface
<R1>debugging igmp report
<R1>debugging igmp leave
```

4. 配置 IGMPv3

```
[R1]int g0/0/1
[R1-g0/0/1]igmp version 3
[R2]int g0/0/1
[R2-g0/0/1]igmp version 3
```

5. 配置 IGMP 版本兼容性

```
<R1>dis igmp interface
```

### PIM-DM

1. 配置 PIM-DM

```
# 在所有路由器上开启组播功能，并在每台路由器的每个接口下配置命令 pim dm。
[R1]multicast routing-table
[R1]interface g0/0/0
[R1-g0/0/0]pim dm
<R1>dis pim neighbor
# 在 R2、R3、R4、R5 的用户侧接口下使能 IGMP
[R2]int g0/0/1
[R2-g0/0/1]igmp enable
```

2. 观察 PIM-DM 中 DR 的选举

```
[R3]int g0/0/0
[R3-g0/0/0]igmp version 1
[R4]int g0/0/0
[R4-g0/0/0]igmp version 1
<R3>dis pim interface
<R4>dis pim interface
# PIM-DR 选举出的 DR 为 R4（优先级一样时，IP 地址较大者为 DR）。
# 观察 PIM-DM 中的 Assert 机制
```

### PIM-SM

1. 配置 PIM-SM

```
# 在所有路由器上开启组播功能，并在每台路由器的每个接口下配置命令 pim sm，除此之外，还需要在 R5 和 R6 的 GE0/0/0 接口下使能 IGMP
[R5]multicast routing-enable
[R5]int g0/0/0
[R5-g0/0/0]pim sm
[R5-g0/0/0]igmp enable
[R5-g0/0/0]int g0/0/1
[R5-g0/0/1]pim sm
# 选择 R3 为 RP 节点，并在每台路由器上手工配置 R3 为静态 RP。
[R1]pim
[R1-pim]static-rp 10.0.3.3
# 配置完成后，查看 R3 的 PIM 邻居信息。
<R3>di pim neighbor
```

2. 用户端 DR 与组播源端 DR

```
<R5>dis pim interface
<R6>dis pim interface
<R3>dis pim routing-table
# 通过修改优先级的方法来强制让 R1 成为组播源端 DR
[R1]int g0/0/0
[R1-g0/0/0]pim hello-option dr-priority 2
```

2. 从 RPT 切换到 SPT

```
<R4>dis pim routing-table
# 在用户端 DR 上配置了切换阈值后，只有当组播报文的速率超过阈值时，用户端 DR 才会发起切换。
[R4]pim
[R4-pim]spt-switch-threshold infinity
<R4>dis pim routing-table
```

3. 配置 PIM-Silent 接口

```
[R4]int g0/0/1
[R4-g0/0/1]pim silent
[R4]dis pim interface g0/0/1 verbose
```

### PIM-SM 的 RP

💁 **在传统的 PIM-SM 网络中，每个组播组只能映射到一个 RP，当网络负载较大以及流量分布不合理时，可能导致 RP 拥塞或者网络资源严重浪费的情况。解决上述问题的一个方案便是配置 Anycast RP：在同一个 PIM-SM 网络中设置多个具有相同环回地址的 RP，组播源和组播用户分别选择距离自己最近的 RP 进行 RPT 的创建，从而实现分担和优化组播流量的目的。**

1. 配置 PIM-SM 和静态 RP

```
[R1]multicast routing-enable
[R1]int g0/0/0
[R1-g0/0/0]pim sm
[R1-g0/0/0]int g0/0/1
[R1-g0/0/1]pim sm
[R1-g0/0/1]int g0/0/2
[R1-g0/0/2]pim sm
[R1-g0/0/2]igmp enable
# 在每台路由器上手工配置 R1（10.0.11.11）为静态 RP。
[R1]int loo1
[R1-loo1]pim sm
[R1-loo1]pim
[R1-pim]static-rp 10.0.11.11
```

2. 配置动态 RP

```
[R1]int loo0
[R1-loo0]pim sm
[R1-loo0]pim
[R1-pim]c-rp loo0
[R6]int loo1
[R6-loo1]pim sm
[R6-loo1]pim
[R6-pim]c-rp loo1
[R3]int loo0
[R3-loo0]pim sm
[R3-loo0]pim
[R3-pim]c-bsr loo0
[R4]int loo0
[R4-loo0]pim sm
[R4-loo0]pim
[R4-pim]c-bsr loo0
<R1>dis pim rp-info
<R1>dis pim rp-info 224.1.1.1
<R1>dis pim bsr-info
# 当静态 RP 和动态 RP 同时存在时，动态 RP 优先。在优先级和 Hash 值的掩码长度相同的情况下，IP 地址较大的 C-RP（R6）被选为了 RP。另外，C-BSR 优先级相同的情况下，IP 地址较大的 R4 成为了 BSR。
# 通过修改优先级，可以控制 RP 的选举。
[R6]pim
[R6-pim]c-rp priority 10
<R1>dis pim rp-info 224.1.1.1
可以看到，当 R6 的 RP 优先级的值调整为 10（数值越小优先级越高）时，优先级较高的 R1 成为了 RP。
```

3. 配置 Anycast RP

```
[R1]int loop0
[R1-loo0]pim sm
[R1-loo0]int loop1
[R1-loo1]pim sm
[R1-loo1]pim
[R1-pim]c-rp loop0
[R1-pim]anycast-rp 10.0.1.1
[R1-pim-anycast-rp-10.0.1.1]local-address 10.0.11.11
[R1-pim-anycast-rp-10.0.1.1]peer 10.0.6.6
[R6]int loop0
[R6-loo0]pim sm
[R6-loo0]int loop1
[R6-loo1]pim sm
[R6-loo1]pim
[R6-pim]c-rp loop0
[R6-pim]anycast-rp 10.0.1.1
[R6-pim-anycast-rp-10.0.1.1]local-address 10.0.6.6
[R6-pim-anycast-rp-10.0.1.1]local-address 10.0.11.11
<R1>dis pim rp-info 224.1.1.1
<R6>dis pim rp-info 225.1.1.1
# 在 R1 和 R6 上打开 Debugging 功能。
<R1>debugging pim register
<R1>debugging pim join-prune
<R1>terminal monitor
<R1>terminal debugging
```

### RPF 校验

1. RPF 校验过程
   💁 **路由器之所以会发送裁剪消息避免重复包和环路问题，是由于 PIM-DM 具有 RPF 校验功能。路由器如果从非 RPF 接口收到了组播数据包，就会立即从该接口发送裁剪消息。**

```
# 在 R4 上可以观察到关于组播源 172.16.1.1 的 RPF 接口
<R4>dis multicast rpf-info 172.16.1.1
```

2. 配置组播静态路由。

```
# 在 R4 上配置组播静态路由，修改关于组播源 172.16.1.1.的 RPF 接口
[R4]ip rpf-route-static 172.16.1.0 24 10.0.24.2
# 配置完成后，在 R4 上查看关于组播源 172.16.1.1 的 RPF 接口。
[R4]dis multicast rpf-info 172.16.1.1
```

## BGP

### BGP 邻居

💁 **BGP 虽然是一种动态路由协议，但它实际上本身并不产生路由、不发现路由、不计算路由，其主要功能是完成最佳路由的选择并在 BGP 邻居之间进行最佳路由的传递。BGP 选择了 TCP 作为其传输协议，端口号为 179。**

💁 **BGP 支持无类域间路由 CIDR（Classless Inter-Domain Routing），并且采用了触发增量更新方式，这大大地减少了 BGP 在传播路由信息时所占用的带宽，特别适用于在互联网上传播大量的路由信息。**

1. 配置 IBGP 邻居

```
[R1]ip route-static 10.0.2.2 32 10.0.12.2
[R1]ip route-static 10.0.2.2 32 10.0.21.2
[R1]ip route-static 10.0.1.1 32 10.0.12.1
[R1]ip route-static 10.0.1.1 32 10.0.21.1
[R1]bgp 100
[R1-bgp]router-id 10.0.1.1
[R1-bgp]peer 10.0.2.2 as-number 100
[R1-bgp]peer 10.0.2.2 connect-interface loo0
[R2]bgp 100
[R2-bgp]router-id 10.0.2.2
[R2-bgp]peer 10.0.1.1 as-number 100
[R2-bgp]peer 10.0.1.1 connect-interface loo0
[R2]dis bgp peer
[R2]dis bgp routing-table
[R2]dis ip routing-table
```

2. 配置 EBGP 邻居

## MPLS

### MPLS 和 LDP 基本配置

1. 配置 MPLS 协议

```
[R1]mpls lsr-id 10.0.1.1
[R1]mpls
[R1-mpls]int g0/0/0
[R1-g0/0/0]mpls
[R1]dis mpls lsp
```

2. 配置静态 LSP

```
[R1]static-lsp ingress R1toR3 destination 10.0.3.3 32 netxhop 10.0.12.2 out-label 102
[R2]mpls lsr-id 10.0.2.2
[R2]mpls
[R2-mpls]int g0/0/0
[R2-g0/0/0]mpls
[R2-g0/0/0]int g0/0/1
[R2-g0/0/1]mpls
[R2-g0/0/1]quit
[R2]static-lsp transit R1toR3 incoming-interface g0/0/0 in-label 102 nexthop 10.0.23.3 out-label 203
[R3]mpls lsr-id 10.0.3.3
[R3]mpls
[R3-mpls]int g0/0/1
[R3-g0/0/1]mpls
[R3-g0/0/1]quit
[R3]static-lsp egress R1toR3 incoming-interface g0/0/1 in-label 203
<R1>dis mpls lsp
<R2>dis mpls lsp
<R3>dis mpls lsp
<R1>tracert lsp ip 10.0.3.3 32
<R3>tracert lsp ip 10.0.1.1 32 说明了 LSP 具有单向性
[R3]static-lsp ingress R3toR1 destination 10.0.1.1 32 nexthop 10.0.23.2 out-label 101
[R2]static-lsp transit R3toR1 incoming-interface g0/0/1 in-label 101 nexthop 10.0.12.1 out-label 201
[R1]static-lsp egress R3toR1 incoming-interface g0/0/0 in-label 201
[R3]tracert lsp ip 10.0.1.1 32
```

3. 利用 LDP 动态分发标签并建立 LSP

```
# 首先，在 R1、R2、R3 上删除之前创建的静态 LSP
[R1]undo static-lsp ingress R1toR3
[R1]undo static-lsp egress R3toR1
[R2]undo static-lsp transit R1toR3
[R2]undo static-lsp transit R3toR1
[R3]undo static-lsp egress R1toR3
[R3]undo static-lsp ingress R3toR1
# 在 R1、R2、R3 上使用 mpls ldp 命令全局启用 LDP，然后在接口上使用同样的命令是能 LDP
[R1]mpls ldp
[R1-mpls-ldp]int g0/0/0
[R1-g0/0/0]mpls ldp
[R2]mpls ldp
[R2-mpls-ldp]int g0/0/0
[R2-g0/0/0]mpls ldp
[R2-g0/0/0]int g0/0/1
[R2-g0/0/1]mpls ldp
[R3]mpls ldp
[R3-mpls-ldp]int g0/0/1
[R3-g0/0/1]mpls ldp
[R1]dis mpls ldp interface
# 在 R1、R2、R3 上使用 dis mpls ldp session 命令查看 LDP 会话信息
[R1]dis mpls ldp session
[R2]dis mpls ldp session
[R3]dis mpls ldp session
# 在 R1、R2、R3 上使用 dis mpls lsp 查看 LSP 信息
[R1]dis mpls lsp
[R2]dis mpls lsp
[R3]dis mpls lsp
# 在 R1 上验证去往 10.0.3.3/32 的 MPLS 报文所经过的路径
<R1>tracert lsp ip 10.0.3.3. 32
# 在 R3 上验证去往 10.0.1.1/32 的 MPLS 报文所经过的路径
<R3>tracert lsp ip 10.0.1.1. 32
<R1>ping lsp ip 10.0.3.3 32
<R3>ping lsp ip 10.0.1.1 32
```

### BGP/MPLS VPN 基本配置

1. 基本配置
2. 配置运营商网络的 OSPF 路由协议
3. 配置运营商网络的 MPLS 协议与 LDP

```
[R1]mpls lsr-id 10.0.1.1
[R1]mpls
[R1-mpls]mpls ldp
[R1-mpls-ldp]int g0/0/0
[R1-g0/0/0]mpls
[R1-g0/0/0]mpls ldp
[R2]mpls lsr-id 10.0.2.2
[R2]mpls
[R2-mpls]mpls ldp
[R2-mpls-ldp]int g0/0/0
[R2-g0/0/0]mpls
[R2-g0/0/0]mpls ldp
[R2-g0/0/0]int g0/0/1
[R2-g0/0/1]mpls
[R2-g0/0/1]mpls ldp
[R3]mpls lsr-id 10.0.3.3
[R3]mpls
[R3-mpls]mpls ldp
[R3-mpls-ldp]int g0/0/1
[R3-g0/0/1]mpls
[R3-g0/0/1]mpls ldp
[R2]dis mpls ldp session
[R1]dis mpls lsp
```

4. 配置 PE 设备间的 MP-BGP

```
[R1]bgp 100
[R1-bgp]peer 10.0.3.3 as 100
[R1-bgp]peer 10.0.3.3 connect-interface loo0
[R1-bgp]peer 10.0.3.3 next-hop-local
[R1-bgp]ipv4-family vpnv4
[R1-bgp-af-vpnv4]peer 10.0.3.3 enable
[R1-bgp-af-vpnv4]peer 10.0.3.3 advertise-community
[R3]bgp 100
[R3-bgp]peer 10.0.1.1 as 100
[R1-bgp]peer 10.0.1.1 connect-interface loo0
[R1-bgp]peer 10.0.1.1 next-hop-local
[R1-bgp]ipv4-family vpnv4
[R1-bgp-af-vpnv4]peer 10.0.3.3 enable
[R1-bgp-af-vpnv4]peer 10.0.3.3 advertise-community
[R1]dis bgp peer
```

5. 在 PE 上创建 VPN 实例并与接口进行绑定

```
[R1]ip vpn-instance vpna
[R1-vpn-instance-vpna]ipv4-family
[R1-vpn-instance-vpna-af-ipv4]route-distinguisher 300:1
[R1-vpn-instance-vpna-af-ipv4]vpn-target 100:1 both
[R1]int g0/0/1
[R1-g0/0/1]ip binding vpn-instance vpna
[R1-g0/0/1]ip add 10.0.14.1 255.255.255.0
[R1]ip vpn-instance vpnb
[R1-vpn-instance-vpnb]ipv4-family
[R1-vpn-instance-vpnb-af-ipv4]route-distinguisher 300:2
[R1-vpn-instance-vpna-af-ipv4]vpn-target 100:2 both
[R1]int g0/0/2
[R1-g0/0/1]ip binding vpn-instance vpnb
[R1-g0/0/1]ip add 10.0.15.1 255.255.255.0
[R3]ip vpn-instance vpna
[R3-vpn-instance-vpna]ipv4-family
[R3-vpn-instance-vpna-af-ipv4]route-distinguisher 300:1
[R3-vpn-instance-vpna-af-ipv4]vpn-target 100:1 both
[R3]int g0/0/0
[R3-g0/0/0]ip binding vpn-instance vpna
[R3-g0/0/0]ip add 10.0.36.3 255.255.255.0
[R3]ip vpn-instance vpnb
[R3-vpn-instance-vpnb]ipv4-family
[R3-vpn-instance-vpnb-af-ipv4]route-distinguisher 300:2
[R3-vpn-instance-vpna-af-ipv4]vpn-target 100:2 both
[R3]int g0/0/2
[R3-g0/0/2]ip binding vpn-instance vpnb
[R3-g0/0/2]ip add 10.0.37.3 255.255.255.0
```

6. 为公司 A 配置基于 BGP 的 PE-CE 连通性

```
[R4]bgp 10
[R4-bgp]peer 10.0.14.1 as 100
[R4-bgp]nework 10.0.4.4 32
[R1]bgp 100
[R1-bgp]ipv4-family vpn-instance vpna
[R1-bgp-vpna]peer 10.0.14.4 as 10
[R4]dis bgp peer
[R1]dis bgp vpnv4 vpn-instance vpna peer
[R3]bgp 100
[R3-bgp]ipv4-family vpn-instance vpna
[R3-bgp-vpna]peer 10.0.36.6 as 20
[R6]bgp 20
[R6-bgp]peer 10.0.36.3 as 100
[R6-bgp]network 10.0.6.6 32
[R1]dis bgp vpnv4 vpn-instance vpna routing-table
<R1>dis mpls lsp 查看 MP-BGP 协议分配的内层标签
<R3>dis mpls lsp
<R4>ping -c 1 -a 10.0.4.4 10.0.6.6
```

7. 为公司 B 配置基于静态路由及 OSPF 协议的 PE-CE 连通性

```
[R5]ip route-static 0.0.0.0 0 10.0.15.1
[R1]ip route-static vpn-instance vpnb 10.0.5.5 32 10.0.15.5
[R1]bgp 100
[R1-bgp]ipv4-family vpn-instance vpnb
[R1-bgp-vpnb]import-route static
[R7]ospf 2 router-id 10.0.7.7
[R7-ospf2]area 0
[R7-ospf-2-area-0.0.0.0]network 10.0.37.0 0.0.0.255
[R7-ospf-2-area-0.0.0.0]network 10.0.7.7 0.0.0.0
[R3]ospf 2 vpn-instance vpnb
[R3-ospf-2]area 0
[R3-ospf-2-area-0.0.0.0]network 10.0.37.0 0.0.0.255
[R3]dis ospf peer bri
[R3]ospf 2
[R3-ospf-2]import-route bgp 将 VPN 实例 vpnb 的 BGP 路由引入 OSPF
[R3]bgp 100
[R3]ipv4-family vpn-instance vpnb
[R3]import-route ospf 2
[R3]dis bgp vpnv4 vpn-instance vpnb routing-table
[R3]ip ip-prefix 1 deny 10.0.37.0 24
[R3]ip ip-prefix 1 permit 0.0.0.0 32
[R3]router-policy 10 permit node 10
[R3-route-policy]if-match ip-prefix 1
[R3-route-policy]bgp 100
[R3-bgp]ipv4-family vpn-instance vpnb
[R3-bgp-vpnb]import-route ospf 2 route-policy 10
[R3]dis mpls lsp
<R7>ping -c 1 -a 10.0.7.7 10.0.4.4
<R7>ping -c 1 -a 10.0.7.7 10.0.5.5
<R7>ping -c 1 -a 10.0.7.7 10.0.6.6
```

## 交换技术

### 观察和配置 MAC 地址表

```
[SW1]undo mac-address dynamic
[SW1]dis mac-address
[SW1]dis mac-address aging-time
在 PC 上使用命令 arp -d 清空 ARP 缓存表
[SW1]mac-address static 3-3-3 g0/0/3 vlan 1
[SW1]dis mac-address
```

### Mux VLAN

💁 **Mux VLAN 拥有一个 Principal VLAN，即主 VLAN，同时拥有多个与主 VLAN 关联的 Subordinate VLAN，即从 VLAN。从 VLAN 又有两种类型，一种是 Separate VLAN，即隔离型从 VLAN，另一种是 Group VLAN，即互通型从 VLAN。任何从 VLAN 中的设备都能够与主 VLAN 中的设备进行通信。除此之外，互通型从 VLAN 中的设备只能与本互通型从 VLAN 中的设备进行通信，不能与其他互通型从 VLAN 中的设备进行通信，也不能与隔离型从 VLAN 中的设备进行通信；隔离型从 VLAN 中的设备不能与互通型从 VLAN 中的设备进行通信，也不能与其他隔离型从 VLAN 中以及本隔离型从 VLAN 中的设备进行通信。**

💁 **另外需要说明的是，交换机上加入 Mux VLAN 的端口只能允许一个 VLAN 的帧通过，允许多个 VLAN 的帧通过的端口是不能被加入到 Mux VLAN 中的。**

```
[SW]vlan batch 2 3 4
[SW]vlan 2
[SW-vlan2]mux-vlan
[SW-vlan2]subordinate group 3
[SW-vlan2]subordinate separate 4
[SW-vlan2]quit
[SW]int g0/0/1
[SW-g0/0/1]port link-type access
[SW-g0/0/1]port default vlan 2
[SW-g0/0/1]port mux-vlan enable vlan 2
[SW-g0/0/1]quit
[SW]int g0/0/2
[SW-g0/0/2]port link-type access
[SW-g0/0/2]port default vlan 3
[SW-g0/0/2]port mux-vlan enable vlan 3
[SW-g0/0/2]quit
[SW]int g0/0/3
[SW-g0/0/3]port link-type access
[SW-g0/0/3]port default vlan 3
[SW-g0/0/3]port mux-vlan enable vlan 3
[SW-g0/0/3]quit
[SW]int g0/0/4
[SW-g0/0/4]port link-type access
[SW-g0/0/4]port default vlan 4
[SW-g0/0/4]port mux-vlan enable vlan 4
[SW-g0/0/4]quit
[SW]int g0/0/5
[SW-g0/0/5]port link-type access
[SW-g0/0/5]port default vlan 4
[SW-g0/0/5]port mux-vlan enable vlan 4
[SW-g0/0/5]quit
```

### MSTP/RSTP 的保护功能

```
# 配置根保护（在指定端口上）
[S1]int g0/0/1
[S1-g0/0/1]stp root-protection
[S1-g0/0/1]int g0/0/2
[S1-g0/0/2]stp root-protection
[S2]int g0/0/2
[S2-g0/0/2]stp root-protection
[S3]int g0/0/1
[S3-g0/0/1]stp root-protection
```
