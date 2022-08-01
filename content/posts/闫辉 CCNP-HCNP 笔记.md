---
2022-08-01 19:49:40
---

# 闫辉 CCNP/HCNP 笔记

[toc]

## OSPF
- Preference 0-255
- `loopback0 24 32`
- `3类LSA 不再包含拓扑信息 ABR Area 0`
- 报文类型
    - Hello DBD LSR LSU LSAck  `Layer 2|IP|OSPF|FCS 协议号89`
        1. `Hello` 发现和维护邻居关系
        2. `Database Description` 发送链路状态数据库摘要
        3. `Link State Request` 请求特定的链路状态信息 `三个字段唯一标识一个LSA：LS Type、Link State ID、Advertising Router`
        4. `Link State Update` 发送详细的链路状态信息
        5. `Link State Ack` 发送确认报文
    - OSPF 11 类 LSA 1-5类、7类
    - `OSPF 既支持周期性 30min 老化计时器LS age（默认60min）更新又支持触发更新`
    - OSPF LSA 报头序列号从 80000001 开始
    ![OSPF包含在各种报报文中的LSA信息](https://i.imgur.com/p8WOrC3.jpg)
    ![OSPF报文的目的地址1](https://i.imgur.com/uRGJR6D.jpg)
    ![OSPF报文的目的地址2](https://i.imgur.com/XxZjKMu.jpg)
- 显式确认和隐式确认
    1.显式确认：LSAck
    2.隐式确认：hello DBD Seq
- 参数匹配
    - OSPF 报头的参数
        1. Version
        2. Area ID
        3. Authentication Type
        4. Key
    - Hello `不匹配无法建立邻居 Two-way`
        1. hello 时间和 dead 时间
        2. RID 不能冲突
        3. Area ID
        4. Option 字段 标准区域 E 1 N 0 stub E 0 N 0 NSSA E 0 N 1
        5. Authentication
        6. 子网掩码
    - DBD
        1. MTU（Cisco）
    - `两端接口 OSPF 网络类型要匹配 LS Type`
- 邻居与邻接
    - Neighbor hello
    - Adjacency 5类
    - 邻接状态机
        - Down
        - Attempt NMBA才有
        - Init
        - Two-way 邻居
        - Exstart
        - Exchange
        - Loading
        - Full 邻接
    ![OSPF邻居状态变换（邻居关系）](https://i.imgur.com/WyWr7s1.jpg)
    ![OSPF邻居状态变换（邻接关系）](https://i.imgur.com/Kh13iuo.jpg)
- 网络类型 逻辑概念
    - Cisco： Loopback Point-to-Point Broadcast Non-Broadcast(NBMA) Point-to-Multipoint Point-to-Multipoint Non-Broadcast
    - Huawei: 
        - Point-to-Point Serial(HDLC/PPP) ISDN BRI Frame Relay point-to-point subinterface `不选DR/BDR` 支持单播/组播/广播 `只能建立1个邻接关系` Link state包含 Stub Point-to-Point
            - **LSA Link state（1类LSA）宣告的链路类型：Stub Transit Point-to-Point VL**
        - Broadcast Ethernet `选举DR/BDR wait interval` 支持组播 `可以建立任意多个邻接关系` Link state Transit + LSA Type2
        - Non-Broadcast(NBMA) ATM Frame Relay 帧中继多点子接口 `选举DR/BDR` 不支持组播 Link state Transit
        - Point-to-Multipoint `不选DR/BDR` 多个邻接关系 支持组播 Link state Stub Point-to-Point
        - VL
            - `Cisco：建立好邻居就抑制 hello 报文 LSA 也不会周期性泛洪`
            - Huawei：会继续发送
            - 部署条件：
                1. 连接多区域的路由器之间建立
                2. 两个路由器必须要共享至少一个区域
                3. 指定对端 Router-id
                4. 基于对端设备的 LSA Type-1 判断对方在本区域所属的 SPF 树的哪个部分来判断本地去往对端的最优路径
                5. **逻辑的点到点的只属于 Area 0 的路径**
            - 建立过程：发送单播hello（报头area ID：0.0.0.0）报文至对端物理口➡️发送组播224.0.0.5 LS Update在传输区域（Type1 ABR位置1）➡️发送组播224.0.0.5 LS Update在传输区域（Type3 宣告area2网段）➡️收到对端单播hello至本端物理接口➡️收到对端的组播224.0.0.5 LS Ack在传输区域➡️双方单播发送DBD、LS Request、LS Update和LS Ack在骨干区域➡️双方在传输区域发送组播224.0.0.5 LS Update（Type1 Virtual link endpoint位置1）➡️双方在传输区域发送组播224.0.0.5 LS Ack确认➡️邻居达到full，不断在骨干区域单播交互hello报文。
            - `同 area 0 认证`
                - `同时配置 area 0 认证，可行`
                - `配置 area 0、vlink-peer认证，不一定一样，vlink-peer认证高于area 0认证，可行`
                - 配置 area 0、area 1 相同认证，不可行
                - 配置 area 0、物理接口认证，不可行
- DR/BDR
    - `第一台进入 two-way 状态的路由器宣告选举开始`
    - two-way： wait interval 40s 120s
    - 优先级 1 RID
    - 特征
        1. 不可抢占
        2. DR 挂了永远是 BDR 成为新的 DR
        3. 基于一个网络进行选择
        4. 接口 OSPF 优先级为 0 的时候没有资格成为 DR/BDR
        5. FR Hub & Spoke 只有DR
        6. DR/BDR 选举是有时限的
- OSPF 接口状态机
![OSPF MA端口状态机](https://i.imgur.com/ZQuBwGL.jpg)
- 认证  0: 不认证 1: 明文认证 2: MD5
    - 链路级认证
    - 区域级认证
    `Area 0 开启认证：属于 Area 0 的所有路由器 不属于 Area 0 的 VL 连接者`
    - 虚链路认证
    - HMAC 散列认证信息码 数字签名
- 路由类型
    - 域内路由 O 10 1类2类
    - 域间路由 O IA 10 3类
    - 域外路由 O E1（一类的外部） O E2（二类的外部） 150 4类5类
- LSA 类型
    - Router LSA `任何路由器都会形成1类LSA 泛洪范围：一个区域内 内容：该路由器宣告进该区域内的所有接口的链路状态信息（宣告的链路类型：Stub Transit Point-to-Point）有flag字段指明ABR和ASBR：B 1 E 1`
    - Network LSA `DR会针对其所在的MA网络形成一条2类LSA 泛洪范围：一个区域内 内容：所有属于该MA网络的路由器的RID 掩码`
    - Summary LSA `ABR（非RFC定义）每条3类LSA指定的都是一个独立的域间路由 泛洪范围：整个路由3选择域 内容：一条域间路由O IA` `防止路由反馈：一台ABR通过非骨干区域收到3类LSA只会加入LSDB但是不会执行任何处理（加入路由表或转发给其他人）`
    - Summary ASB LSA `ASBR所在区域内的ABR 泛洪范围：除了ASBR所在区域外的整个OSPF域内传递 内容：ASBR的RID以及该ABR去往ASBR路径的度量值`
    - External LSA `ASBR 泛洪范围：整个路由选择域（但不会出现环路 通过4类/3类进行防环处理） 内容：一条5类LSA包含一条域外路由（FA地址、Tag 32bit修改路由度量值、下一跳或路由过滤）`
        - **FA最末跳路由优化机制：1.路由的下一跳地址所连接的网络被ASBR宣告进OSPF 2.ASBR连接该网络接口网络类型必须是MA/NBMA 3.接口状态必须是upup** `FA地址可达，3类LSA无环，把报文发送给FA地址 若无FA地址，4类LSA无环`
        - Tag：`只有5类和7类才有 默认0 32bit修改路由度量值、下一跳或路由过滤 route-policy`
        - seed metric 1
        - Type 1 O ASE1
        - Type 2 O ASE2
    - NSSA LSA
- 计算 OSPF 区域内路由
    - 节点（路由器RID） 树叶（网络）
    - MA 大于等于2台才能形成 Transit 类型
    - `网段宣告对应的 Router-LSA 的link数量（只有1类LSA才有link count值）`
        - Loopback 1link Stub
        - Serial HDLC/PPP 2link Stub+P2P 
        - Ethernet FR 1link Transit
        ![OSPF Router-LSA中的重要字段](https://i.imgur.com/tHkfFch.jpg)
        ![OSPF配置接口开销](https://i.imgur.com/pYunDga.jpg)
- 计算 OSPF 区域间路由
    - ToS
        - IP Precedence 3bit 0-7 0 1 2 3 4 5 6（控制层面OSPF报文发送所携带的值，`二进制11000000 十进制192`OSPF流量ip报头对应的值，可用作acl流量抓取） 7
        - DSCP 6bit 
    - 虚连接（Virtual Link）
- OSPF 外部路由
    - seed metric 外部度量值
    - 优先级 O<O IA<O E1<O E2
- OSPF 特殊区域
    - Stub 区域 末节区域
        - ABR 3类0.0.0.0/0 metric 1
    - NSSA 次末节区域
        - 7类 NSSA External LSA type1 type2 O N1 O N2
        - 转换者 ABR RID（最大，只有1台） 5类LSA   
        - 7类 LSA 一定会携带FA 地址：
            1. 宣告进 OSPF 的最大环回口地址
            2. 宣告进 OSPF 的最大物理接口地址
            3. 接口状态 UP UP
        - `NSSA 多台 ABR 非转换者上做重分发，会以7类在 NSSA 区域传递，会以5类在常规区域传递；转换者就不会转换7类以5类转发出去。`
        - 外部默认路由下放 7类LSA
        ![OSPF配置NSSA默认路由下放](https://i.imgur.com/9qNGY60.jpg)
        - `No-redistribution 无需重分发7类明细 就让外部路由不要进入 NSSA 区域直接进入其他区域`
            4. ABR 下放 7类缺省
            5. ABR 下放 3类缺省
        - `总结`
            - Stub ABR 过滤 4/5类 LSA 进入区域内不能拥有 ASBR ABR 主动下放3类缺省
            - Totally Stub ABR 增加对进入该区域3类 LSA 过滤，只需要在 ABR 上开启 totally stub 特性
            - NSSA ABR 过滤4/5类进入，区域内可以拥有 ASBR 区域中拥有最大 RID 的 ABR 成为转换者 ABR 不会主动下放缺省，需要下放要通过配置命令实现 ABR 可以下放 ASBR 也可以下放（ASBR 下放前提有默认路由）
            - Totally NSSA ABR 过滤3类 ABR 主动下放 3类 LSA
        ![OSPF NSSA区域FA地址的重要性1](https://i.imgur.com/uy548S3.jpg)
        ![OSPF NSSA区域FA地址的重要性2](https://i.imgur.com/fjDr97E.jpg)
- OSPF 故障处理
    - OSPF 形成过程
        1. 建邻居
        2. 传LSA LSDB
        3. 将LSA转成路由条目加入路由表
    - IGP 直连路由器之间要通
        - X--R1--R2--Y
            1. `ping 直连 协议号 89 组播地址：224.0.0.5 224.0.0.6 Tos 字段为192，IP Precedence 为 6 的放行 `
            2. 宣告接口 `dis ospf interface`  `dis ospf peer bri`
            3. hello 路由器ID不能冲突 MA/NBMA 网络子网掩码 相同的hello时间和dead时间 相同的区域 相同的认证类型和密钥 相同的option值（相同的区域类型）Two-way `不通 Init：ACL过滤掉了hello；Exstart：选举主从；`
            4. 有 LSA5 类没有路由 有 FA 必须可达 没有 FA 就是没有收到 LSA4 类
            5. `PBR 策略路由优于路由表查询` traceroute
- **ABR 跟area 0内路由器建立full邻接关系 loopback 0即使宣告进area 0也建立不了邻接关系，不算真正的 ABR**
- **cost值：控制层面 路由流向的所有入接口度量值累加**

## 组播
* `比较三种流量类型`
    - Unicast:
    - Broadcast:
    - Multicast:
        - 优点
            - Video on demand:VOD
            - 利用链路带宽
            - 节约处理器资源
            - `不需要知道接收者的ip地址`
            - `同时性，股票大厅大屏`
            - 路由器可以基于组播转发——`组播动态路由选择协议`
        - 缺点
            - `数据层面：基于UDP`
                - UDP报头长度8个字节，TCP报头长度至少20个字节 UDP比TCP占用带宽少
                - `TCP比UDP带来的好处：流控、防乱序、防丢包、重传，组播不需要TCP提供的可靠服务` 
                - `TCP是基于点到点协议，无法应用到组播`
                - 尽力而为的传输
                - 无拥塞避免机制
                - 重复报文：一台设备接收到一模一样的多份报文（`解决：靠组播路由选择协议`）
                - 传递乱序：`组播封装包：L2➡️IP➡️UDP➡️RTP（Real Time Transport Protocol实时传输协议为整个数据流提供传递的序列性，这个报头中包含序列号字段）➡️VoIP➡️FCS`
* 基于组播的应用
    - `一对多：VoIP（电话会议）、VOD（封装：Audio-表示层：G.7xx,PCM（解码器）➡️RTP/RTCP➡️UDP➡️IP；Video：表示层：H.261，MPEG➡️RTP/RTCP➡️UDP➡️IP）`
    - 多到多：视频会议、共享白板
    - 多对一：监控
* 组播服务架构-组播环境划分为3⃣️大块
    - 第一跳路由器：`First-hop` routers forward data
    - 最后一跳路由器：`Last-hop(leaf)` routers communicate group membership to the network
    - 第1⃣️大块：Source segment
    - 第2⃣️大块：Multicast distribution tree-`PIM(Protocol Independent Multicast)组播动态路由选择协议`
        1. `第一跳路由器收到报文后如何转发？`
        2. `转发机制是什么？`
        3. 使用什么路径进行转发？树形or环形
        4. 组播动态路由选择协议
            - IGP：DVMRP,PIM,MOSPF,CBT
            - EGP：`MBGP`/`MSDP`
    - 第3⃣️大块：Receiver segment-`IGMP`
        1. `让最后一跳路由器知道下游有哪些PC想要接收发往哪个组播组流量`
        2. `让下游PC得知我想要接收组播组流量时我把消息发给哪台路由器告知它这点`
* 组播地址
    - 范围：`224.0.0.0 to 239.255.255.255`
    - `组播地址和节点没有任何关联，组播地址只跟组播服务有一个关联，它永远只能够成为流量的目的地址`
    - `组播地址要有掩码也是32，扁平化地址，总共有` 2^28^ `个地址，分成3⃣️大类`
        1. 被保留的`链路本地（广播域本地TTL=1）`地址：224.0.0.0 to 224.0.0.255
            - 224.0.0.1-全体的组播地址
            - 224.0.0.2-同一个广播域的路由器监听
            - 224.0.0.5-OSPF
            - 224.0.0.6-OSPF报文发给DR、BDR
            - 224.0.0.9-RIPv2发送更新的组播组地址
            - 224.0.0.10-EIGRP发送组播组地址
            - `224.0.0.13-PIM发送Hello地址`
        2. 全球可聚合的组播地址（公网可路由的）：224.0.1.0 to 238.255.255.255 有以下2段无法使用：
            - `232.0.0.0-232.255.255.255 指定源组播（Source specific multicast）这是PIM的高级应用，这是默认SSM地址，可以修改`
            - `ASM（Any source multicast) 任意源组播：不关心源，这导致下游PC收到流量不知道是谁发的`
            - `SSM：下游PC可以得知我监听的是哪个服务器给我发的流量`
            - 233.0.0.0-233.255.255.255 AS➡️Multicast AS号12345➡️0x30｜39➡️233.48.57.0-233.48.57.255（GLOP addresses）
        3. 私有广播地址（只有在AS内使用）：239.0.0.0 to 239.255.255.255.255
        4. 组播地址跟MAC地址映射
            - ipv4: 0100.5E+ip地址后23位 **映射比是32：1**
            - ipv6: 3333.+ipv6后32位
            ![组播IP地址到mac地址的映射](https://i.imgur.com/g01LyBB.jpg)
    - 组播 IP 模型分类
        - ASM（Any-Source Multicast）
        - SFM（Source-Filtered Multicast）
        - SSM（Sourece-Specific Multicast）指定源组查询 `启用条件：终端主机要支持 IGMPv3 或者 IGMPｖ2 group-map`
* 组播动态路由选择协议
    - AS-Sourece-FH-LH-Receive
        - IGP：PIM   
        - EGP：MSDP MPBGP ipv4 multicast
    - 组播分发树
        - 组播分发树的两个基本类型
            - 源路径树（DM）
            - 共享树（SM）
                - RP 汇合点
                - FH—RP SPT
                - RP-LH RPT
            - `组播路由表的表项描述的就是树形结构（S，G）（1.1.1.1，224.1.1.1）Incoming-interface Outgoing-interface-list`
            - dense-mode 初始泛洪➡️回向修剪（prune）
            - sparse-mode 在IGMP report中pc告诉LH路由器我要接收发往 224.1.1.1 的组播组流量，不关心信源是谁➡️LH路由器会发送一跳一跳的（`*`，224.1.1.1）join 最终发送给 RP（沿途路径按照单播igp计算而得的最优路径）➡️这时就已经形成了 RP-LH 的 共享树➡️信源开始发送组播后，FH路由器会发送注册给RP，询问RP域内有没有接收者➡️`如果RP判断没有接收者，会直接给FH路由器发送register stop,告知没有接收者，请直接停止➡️FH路由器的组播接口在接收到组播流量后就什么也不会`➡️如果RP判断域内有接收者，**注册是指FH路由器在收到组播组信源发送的第一个组播流量，再把第一个组播流量通过封装的形式封装成单播pim注册发送给RP**，会把pim注册解封装成原始组播流量，然后通过共享树发送下去➡️只要发送下来，RP的地址就成为共享树中的路由器对于组播流量的RPF评判标准， **RP到FH路由器会发送2个报文：（source，G）join和register stop**➡️形成（`*`，G）表项
            ![组播PIM SM共享树](https://i.imgur.com/msqJshW.jpg)
    - PIM
        - Dense-Mode SPT 源树
        - Sparse-Mode RPT 共享树 SPT
        - RPF 反向路径转发 组播路由表项    
* 组播数据转发
    - `组播路由使用「反向路径转发」机制（RPF， Reverse Path Forwarding）`
    - `对于一个Source一台路由器只有一个接口可以接收他发送的组播流量`
    - RPF 接口
        1. 路由器收到组播数据报文后，只有确认这个数据报文是从自身连接到组播源的接口上收到的，才进行转发，否则丢弃。
        2. 最长匹配原则
            - 1.1.0.0/16 fa0/1 12.1.1.1
            - 1.1.0.0/16 serial1/0/1 13.1.1.1 `RPF接口看接口ip地址大小`
        3. 比较管理距离谁最小，RPF接口就是谁
        4. 组播静态>MP-BGP>单播路由
* IGMP-`Internet Group Management Protocol`
    - `OSI定义的4⃣️层协议：封装 L2➡️IP➡️IGMP➡️FCS` `对应IP层的上层协议号字段是2`
    - IGMPv1：C/S架构模型 
    - Membership Queries(组播组成员资格查询):`周期发，默认60s一次` `发送前提是路由器连接下游网段接口必须要启用某种模式的PIM`
        - 类型：0x11
        - `封装：Ethernet➡️IP(SIP: Router接口IP,DIP:224.0.0.1 with TTL=1)➡️IGMP(Group:0.0.0.0)➡️FCS`
        - HoldTime计时器：180s `IGMP表项过期时间，离组确认要180s时间`
    - Membership Reports(组播组成员资格通告)
        - 类型：0x12 `版本2:0x16`
        - `封装：Ethernet➡️IP(SIP: PC1接口IP,DIP:224.1.1.1 with TTL=1)➡️IGMP(Group:224.1.1.1我想要加入的组播组地址)➡️FCS`
        - `告知网段内的最后一跳路由器该网段内有人想接收去往224.1.1.1的组播流量`
        - `告知网段内所有想加入相同组的成员请你们不要再发送report报文`
        - `收到queries后会开启最大响应时间计时器 1s-10s不等（随机时间）`
        - `Report报文2个用途：`
            1. 充当ACK
            2. 主动发送
        - `IGMPv1中PIM DR机制来指定查询者，避免重复报文`
* IGMPv2
    * 新增2类报文：
        - `Group-specific query(指定组查询报文) 只有收到离组报文时才会触发 源IP：路由器的IP 目的IP：224.1.1.1`
            - pc收到指定组查询报文后，不会再开启1s-10s不等的最大响应时间计时器，`会开启一个2s（cisco 2s、huawei 1s）的随机计时器`，会在2s内给路由器做响应
            - `路由器收到响应后，把IGMP表项超时时间恢复成180s`
            - `路由器没有收到响应后，直接丢弃表项，离组完成`
            - cisco离组最多耗时`2`s
        - `Leave Group message(离组报文)` `源IP：PC1的IP 目的IP：224.0.0.2 GROUP:224.1.1.1(想离开的组)`
            - 类型：0x17
            - 收到离组报文，路由器会担心组内还有没有其他人，如果没人再保持发报文就浪费带宽
            - 收到离组报文，路由器会干2件事
                1. 把接口所关联的IGMP表项的超时时间从180s缩短到2s
                2. `通过这个接口发送一个指定组查询报文，目的IP：224.1.1.1，Group：224.1.1.1`
    *  Querier election mechanism(查询者选举机制)-`多台最后一跳路由器，避免重复报文`
        - `比较最后一跳路由器连接下游网段的接口的ip地址，谁ip地址小，谁就成为查询者`
        - `路由器之间交互第一份查询报文来选举查询者`
        - `查询者超时计时器：120s，如果备份查询者在120s内没有收到查询者发送queries报文，意识到查询者down，还是通过选举机制来查看能否成为新的查询者，如果当上新的查询者，就周期性发送query并向下游转发组播流量`
            - `show ip igmp group`
    - 配置实验
       -  Cisco 在接口启用 PIM，自动启用 IGMP
        - R1
            
            ```
            思科
            en
            conf t
            ip multicast-routing 开启组播路由选择功能
            int fa 0/0
            ip pim sparse-mode
            end
            show ip igmp interface fa 0/0
            show ip igmp groups
            logging on
            logging buffered debugging
            exit
            debug
            debug ip igmp
            华为
            []multicast-routing-enable
            []int e0/0
            [e0/0]ip add 172.16.1.3 255.255.255.0
            [e0/0]igmp enable
            [e0/0]igmp version 2
            []dis igmp interface
            []dis igmp group
            ```
        - R2
        
            ``` 
            思科
            en
            conf t
            ip multicast-routing
            int fa 0/0
            ip pim sparse-mode
            end
            show ip igmp interface fa 0/0
            show ip igmp groups
            logging on
            logging buffered debugging
            end
            debug
            debug ip igmp
            华为
            []multicast routing-enable
            []int e0/1
            [e0/1]ip add 172.16.1.1 255.255.255.0
            [e0/1]igmp enable
            [e0/1]igmp version 2
            []dis igmp interface
            []dis igmp group
            ```
        - PC3
        
            ```
            思科
            en
            conf t
            int fa 0/0
            ip igmp join-group 224.1.1.1 接口加入组播组
            exit
            debug
            debug ip igmp
            conf t
            int fa 0/0
            no ip igmp join-group 224.1.1.1
            ```
- IGMPv3
    - `与SSM使用可以指定组播源`
    - `report 组播组地址是 224.0.0.22`
    ![组播IGMPv3工作机制](https://i.imgur.com/M06hV2Q.jpg)
    ![组播IGMP版本比较](https://i.imgur.com/TyXjVHV.jpg)
- `Layer 2 Multicast Switching Solutions`
    - 工作机制 当二层以太网交换机收到主机和路由器之间传递的IGMP报文时，IGMP Snooping分析报文所带的信息：
        - 如果主机发出IGMP主机报告报文时，交换机将该主机加入到相应的组播表中
        - 如果主机发出IGMP离开报文时，交换机将删除与该主机对应的组播表项
        - `交换机无法抑制report报文`
    ![组播IGMP Snooping建立和维护组](https://i.imgur.com/I7uiESi.jpg)
    - `组播ip地址到组播mac地址的映射：32:1`
    - `组播mac地址：01-00-5e-7f-00-01 前25bits不变，后23bits同组播IP地址后23bits一一对应`
    - `交换机拥有组播相对应的mac表项，2⃣️种机制：`
        - IGMP snooping：
            - 开启后能拆3层信息
            - 截获pc发给路由器的report报文3⃣️层的源目ip地址，源：pc的ip、目：224.1.1.1
            - IGMP Snooping表项
            - `纯3⃣️层交换机开启igmp snooping`
        - IGMP snooping proxy(最新标准):
    - 配置实验
    ![组播L2igmp-snooping配置](https://i.imgur.com/WpJw1fA.png)
        - SW1:
        
            ```
            思科
            show ip igmp snooping
            Show ip igmp snooping groups
            华为
            []vlan 2
            [vlan2]port e1/0/5 to e1/0/8
            [vlan2]igmp-snooping enable
            []dis igmp-snooping group
            ```
        - PC3:
        
            ```
            思科
            ip igmp join-group 224.1.1.1
            show ip igmp groups
            华为
            ```
- PIM-DM 协议原理
    - DM SPT Push Initial Flooding `（S，G）表项` Prune 180s（超时时间huawei 210s）`相当于每3分钟一次的泛洪和修剪过程`
    - 封装 `Ethernet2｜IP｜PIM｜FCS 协议号 103`
        - 报头类型：
            0:Hello `每30s一次 组播地址：224.0.0.13 老化计时器：105s`
            3:加入/剪枝
            5:Assert
            6:嫁接
            7:嫁接回应
            9:状态刷新
    - 版本1和版本2的区别：路由器是否支持状态可刷新 路由器是否可以识别pim优先级 `优先级高的或者IP地址大的成为DR`
    - 命令
    
    ```
    []multicast routing-enable
    []int s0/0
    [s0/0]pim dm
    ```
    - Graft 嫁接：新加入的接收者想接收组播
    - Assert 机制：`MA网络防止重复报文 路由器-路由器` 
        - 触发前提：`1台路由器通过一个接口收到组播流量， RPF校验失败 通过这个接口要发送相同组播流量`
        - 彼此发送pim assert报文：`描述我这台路由器去往信源的单播路由条目的管理距离、度量值还有我这个接口的ip地址`
        - DM 和 SM 都可能用到
    - 查看PIM-DM组播路由表
        - `dis pim routing-table`
    - 查看PIM邻居
        - `dis pim neighbor`
    - 查看PIM接口配置
        - `dis pim interface verbose`
- PIM-SM 协议原理
    - 一个域内 RP 有且只有1个
    - SM RPT Pull SPT RPT SPT `SPT threshold`
    - BSR `BootStrap Router 自举路由器 AutoRP`
        - CRP RP-candidate 配置优先级 默认为0 配置ACL成为哪些组播组的rp 224.0.0.0-239.255.255.255 默认224.0.0.0/4 group-policy `CRP发送advertise报文给BSR默认60s一次`
        - MA BSR-candidate 平行存在，选举原则一致，确定相同RP，发送discovery报文
            - 先比较 C-BSR 的优先级 大代表越高 优先级一样比较接口的ip地址 先认为自己是 BSR，再开启初始计时器默认130s➡️过期后发送 BootStrap Message自举消息(130s一次)，使用pim报文发送，目的地址：`224.0.0.13`，报文内容包含`BSR的优先级 IP地址 HASH掩码 RP-SET空`，发送我的所有邻居路由器➡️邻居路由器收到后会作BSR RPF校验`（校验内容：路由表里查看去往BSR地址的路由对应的出接口 去往BSR的路由条目的下一跳地址是不是3层报头中的源ip地址）`
    - RPT 形成：receiver发送report➡️LH路由器去往RP单播路由条目的下一跳发送（`*`，G）join，同时本地形成（`*`，G）的表项➡️上游收到也会形成（`*`，G）的表项➡️RP也会形成（`*`，G）的表项
    - SPT 形成：FH路由器收到组播组信源发送的第一个组播数据封装成pim的单播注册报文，然后把register报文发送给rp➡️rp不知道有没有接收者就（不会作任何响应，FH会周期性发register，提醒rp信源存在/发送register stop，FH不再发register，但一旦有receiver，也无法通知FH）➡️如果有接收者，rp先解封装然后还原成原始组播数据包通过共享树发下去➡️共享树沿途路由器收到组播流量基于rp作RPF校验➡️rp会发送（S，G）的join给FH路由器，告知FH路由器请你把组播组信源流量通过SPT发下来，同时rp会给FH路由器发送register stop停止发送注册报文
    ![组播PIM-SM概述](https://i.imgur.com/4eP4PzY.jpg)
    - PIM-SM 基本配置
    
    ```
    []multicast routing-enable
    []pim
    [pim]static-rp 172.16.1.1
    []int e0/1
    [e0/1]pim sm
    ``` 
    
    ```
    []multicast routing-enable
    []int g2/0/0
    [g2/0/0]igmp enable
    [g2/0/0]igmp version 2
    [g2/0/0]pim sm
    [g2/0/0]quit
    []int pos3/0/0
    [pos3/0/0]pim sm
    [pos3/0/0]quit
    ```
    - C-RP 和 C-BSR 配置
    
    ```
    []acl number 2005
    [acl-basic-2005]rule permit source 225.1.1.0 0.0.0.255
    [acl-basic-2005]quit
    []pim
    [pim]c-bsr pos 3/0/0
    [pim]c-rp pos 3/0/0 group-policy 2005
    []dis pim interface
    []dis pim bsr-info
    []dis pim rp-info
    []dis pim routing-table
    ```

    - PIM-SM 验证
    
    ```
    dis pim neighbor
    dis pim rp-info
    dis pim interface verbose
    dis pim routing-table
    ```
    - `DR 在 第一跳 DR 和 最后一跳 DR 有用避免重复报文`
    - RP(Rendezvous Point)发现
        - 静态RP：所有路由器都要指定，包括rp
        - 动态RP：BSR 见上
        - 选举RP：PC发送report 224.1.1.1给LH路由器➡️LH路由器通过BSR得知多个RP信息，比较第一步对比group-policy（最长匹配原则），第二步对比C-RP的优先级（值越小代表优先级越高），第三步对比BSR HASH，第四步对比C-RP的接口地址
        - `一个RP可以同时为多个组播组服务，但一个组播组只能对应一个RP。`
    ![组播c-rp group-policy](https://i.imgur.com/Bin4V2K.png)
    ![组播RP选举](https://i.imgur.com/C1LRXvU.png)
    ![组播PIM-SM共享树构建和组播源注册](https://i.imgur.com/F5qX6nc.png)
    ![组播PIM-SM之源树切换](https://i.imgur.com/r86EXIE.png)
    ![组播PIM-SM动态RP之BSR管理域](https://i.imgur.com/8okVU1V.png)
    - SPT Threshold 默认0 直接组播路径转换
    - PIM-SM 的工作过程主要有：
        - 邻居发现
        - DR 选举
        - RP 发现
        - 加入
        - 注册
        - SPT 切换
        - 剪枝
    - PIM-SM 基本配置
    ![组播PIM-SM（SSM模型）](https://i.imgur.com/Bp3kp0G.png)
       
## BGP
- 动态路由选择协议
    - IGP：RIP EIGRP OSPF IS-IS
    - EGP：BGP（CLassless）
        1. EGP
        2. 路径矢量协议 internet AS-AS（一跳是从AS➡️AS）ECMP（默认不支持负载均衡）
        3. Classless 
- 封装：Layer 2｜IP｜TCP｜BGP｜FCS `目的端口号179`
- 什么是 BGP？
    - AS号：0-65535 IANA 公有：1-64511 私有：64512-65535
    - `为什么不能通过IGP在AS之间传递路由？`
        - 管理
        - 开销 OSPF支持3万条路由前提是：路由器性能比较强大
        - 选路 属性
        - 路由支持（ipv4/ipv6）`BGPv4：IPv4-unicast BGPv4+：Address-family ipv4-unicast、ipv4-multicast、ipv6-unicast、ipv6-multicast、VPNv4-unicast、VPNv4-multicast、VPNv6-unicast、VPNv6-multicast`
    - BGP route-policy和正则表达式
- BGP 的基本工作机制
    - 本地始发路由
        1. `network语句路由通告（路由表中已存在的路由条目信息）`
        2. redistribute
        3. aggregate（路由聚合）
    - 非本地始发路由
        - IBPG：`默认情况下，一条BGP路由在一个AS域内传递时，下一跳是永远维持不变的`
        - EBGP
    - BGP 可靠的路由更新
        - TCP 端口号179
        - 无需周期性更新
        - 路由更新：只发送增量路由
        - 周期性发送keepalive报文检测TCP的连通性
            - `IGP Hello报文 1.邻居发现 2.维护邻居`
            - `BGP Open报文只发一次 keepalive报文周期性发送，用来维护邻居，Cisco60s一次，holdtime180s`
- BGP 消息类型
    - BGP 报文有五种类型：
        - Open：负责和对等体建立邻居关系
        - KeepAlive：该消息在对等体之间周期性地发送，用以维护连接
        - Update：该消息被用来在BGP对等体之间传递路由信息
        - Notification：当BGP Speaker检测到错误的时候，就发送该消息给对等体
        - Route-refresh：用来通知对等体自己支持路由刷新能力
    - 状态机
        - Idle
            - `TCP通过自身的哪个接口发出`
        - Connect：尝试完成TCP三次握手会话
        - Active
        - Open-sent
        - Open-confirm
        - established
        ![BGP状态机](https://i.imgur.com/ZBe7vnb.jpg)
- BGP 的数据库
    - IP路由表（IP-RIB）
        - 全局路由信息库，包括所有IP路由信息
        - `BGP选出的最优路由标识号：*> *表示该路由有资格加入路由表`
        - `AD Cisco EBGP 20 IBGP 200 Huawei EBGP/IBGP 255`
    - BGP路由表（Loc-RIB）
        - BGP路由信息库，包括本地BGP Speaker选择的路由信息
    - 邻居表
        - 对等体邻居清单列表
    - Adj-RIB-In
        - `对等体宣告给本地Speaker的未处理的路由信息库`
    - Adj-RIB-Out
        - `本地Speaker宣告给指定对等体的路由信息库`
    ![BGP路由信息处理](https://i.imgur.com/2fZc8IA.jpg)
- BGP 工作原理
    - BGP 邻居关系
        - EBGP R1 AS1 R2 AS2 `通过AS-Path属性防环`  **TTL=1路由器必须直连**
        - IBGP `前提运行IGP  默认TTL=255 尽可能使用路由器的环回口建立`
        - `防火墙给TCP端口号179放行`
        - `Open报文 源ip地址一定要在 neighbor｜peer IP地址中`
            - 更新源地址：Cisco `neighbor 4.4.4.4 update-source lookback 0`
            ![BGP的EBGP多跳和指定更新源](https://i.imgur.com/2S2A9yT.jpg)
    - BGP 通告原则
        - 本地产生了BGP路由 0.0.0.0 127.0.0.1 
            - `下一跳地址为0.0.0.0:Connect、没有下一跳地址的Static`
            - **下一跳继承 没有下一跳路由通告进BGP就是0.0.0.0，拥有下一跳路由通告进BGP，通告者BGP路由表里会维持原始下一跳不变**
        - `本地产生的BGP路由向所有IBGP邻居和EBGP通告`
        - `IBGP路由默认只能传给所有EBGP邻居，不会通告给它的IBGP邻居，解决方法：IBGP全互连`
            - `路由黑洞：解决方法1.IBGP之间物理链路全互连；2.IBGP邻接关系全互连；3.BGP被引入IGP内；4.在所有运行BGP的路由器之间加tunnel；5.MPLS BGP路由下一跳地址根据IGP路由的标签（最优方案）；5.路由反射器；6.联盟`
            ![BGP路由黑洞](https://i.imgur.com/hlU8e2z.png)
        - `IGP引入BGP原则：默认只有EBGP路由可以被重分发进入`
        - `EBGP路由默认可以传给所有其他EBGP邻居以及所有IBGP邻居`
        - **BGP判断最优路由：选路原则，最优就会标记「>」，是否有资格加路由表就和IGP比较AD**
        - `路由无标记「>」，对IBGP而言1.下一跳地址不可达；2.BGP同步原则没有满足`
        - `第一跳传递规则：始发路由器把BGP路由传递给邻居下一跳自动变更为针对该邻居的更新源地址`
        - `第二跳传递，当传给IBGP邻居时，路由的下一跳地址不变，解决方法：peer 1.1.1.1 next-hop-local；当传给EBGP邻居时，路由的下一跳会变更为更新源地址`
    - BGP 路由提高
        
        ```
        bgp 200
            ipv4-family unicast
                network 18.0.0.1 255.255.255.255
        ```
- BGP 路径选择
    - BGP路径属性介绍
        - BGP路径属性可以被分为四大类：
            - 公认属性：所有设备厂商都能支持的属性
                - 公认强制(Well-known mandatory)：必须携带
                - 公认自由(Well-known discretionary)
            - 可选属性：厂商的私有属性
                - 可选传递(Optional transitive)：`当你一个属性不能被路由器厂商支持，这个属性值是否会记住在路由器条目中继续传递下去`
                    - 完整属性
                    - 部分属性
                - 可选非传递(Optional non-transitive)
        - 常见BGP路由属性
            1. `Origin`：公认强制（i、e、？）
                
            ```
            [R1]int loo0
            [R1-loo0]ip add 1.1.1.1 24
            [R1-loo0]int g0/0/0
            [R1-g0/0/0]ip add 12.1.1.1 24
            [R1]bgp 10
            [R1-bgp]router-id 1.1.1.1
            [R1-bgp]ipv4-family unicast
            [R1-bgp-af-ipv4]quit
            [R1-bgp]peer 12.1.1.2 as-number 20
            [R1-bgp]ipv4-family unicast
            [R1-bgp-af-ipv4]peer 12.1.1.2 enable
            [R1-bgp-af-ipv4]network 1.1.1.0 255.255.255.0
            [R1-bgp-af-ipv4]quit
            [R1-bgp]quit
            [R1]dis bgp routing-table
            [R2]int g0/0/0
            [R2-g0/0/0]ip add 12.1.1.2 24
            [R2]bgp 20
            [R2-bgp]router-id 2.2.2.2
            [R2-bgp]peer 12.1.1.1 as-number 10
            [R2-bgp]ipv4-family unicast
            [R2-bgp-af-ipv4]peer 12.1.1.1 enable
            [R2-bgp-af-ipv4]ping 12.1.1.1
            [R2-bgp-af-ipv4]quit
            [R2-bgp]quit
            [R2]ip ip-prefix test index 10 permit 1.1.1.0 24
            [R2]route-policy origin permit node 10
            [R2-route-policy]if-match ip-prefix test
            [R2-route-policy]apply origin [egp 20/incomplete]
            [R2-route-policy]quit
            [R2]dis route-policy
            [R2]route-policy origin permit node 20
            [R2-route-policy]quit
            [R2]dis route-policy 做条空语句，匹配所有
            [R2]bgp 20
            [R2-bgp]ipv4-family unicast
            [R2-bgp-af-ipv4]peer 12.1.1.1 route-policy origin import
            [R2-bgp-af-ipv4]quit
            [R2-bgp]quit
            [R2]dis bgp routing-table
            [R2]quit
            <R2>refresh bgp all import
            <R2>dis bgp routing-table
            <R2>dis cur section bgp
            ```
            2. `AS_PATH`：公认强制 `当你把一条路由发送给你的EBGP邻居时，你在发送之前会在AS_PATH属性中填充你自身的AS号`
            3. `Next hop`：公认强制
                - `BGP下一跳特例：两个AS之间通过MA网络互连，RC 20.0.0.0/8 10.0.0.3 要跟RA建邻居 10.0.0.1`
                ![BGP下一跳特例](https://i.imgur.com/1mX9DRD.jpg)
            4. `MED`：可选非传递
                ![BGP MED属性](https://i.imgur.com/p5W6DJq.jpg)
                - `比较MED的前提条件：邻居要来自同一个AS，我们可以通过配置compare-different-as-med命令来允许比较来自不同自治系统中的邻居的路由的MED值。不过，除非能够确认不同的自治系统采用了同样的IGP和路由选择方式，否则不要使用此命令。`
                ![BGP不同AS邻居MED值的比较](https://i.imgur.com/55A6Ktv.jpg)
            5. `Local-Preference`：公认自由
                - 默认值 100 `针对EBGP邻居在接收方向去做修改，或者针对IBGP邻居在发送方向去做修改，一般在边界路由器上做修改`
            6. Atomic-Aggregate：公认自由
            7. Aggregator：可选传递
            8. `Community`：可选传递
                - 标准的community属性
                    - 公有团体属性：
                        1. no-advertise(0xFFFFFF02）`这条路由不能再发送给任何人`
                        2. no-export(0xFFFFFF01)`只能发送给IBGP邻居，不能发送给EBGP邻居，不会影响联邦内子AS之间的EBGP路由传递`
                        3. local-as(0xFFFFFF03)`即不能发送给EBGP邻居，也不能发送给联邦内子AS之间的EBGP邻居`
                    - 私有团体属性：
                - 扩展的community属性：MPLS VPN
                - 通过 `peer 12.1.1.2 advertise-community` 开启属性功能
            9. Originator-ID：可选非传递
            10. Cluster-List：可选非传递
            11. MP_Reach_NLRI
            12. MP_Unreach_NLRI
            13. Extended_Communities
    - `BGP路径选择过程`
        1. 如果此路由的下一跳不可达，忽略此路由（IBGP忘记`next-hop-local`或者开启同步但同步不满足）
        2. Preferred-Value值数值高的优先 等同于Cisco的Weight `接收到的BGP路由加入到BGP路由表中会打上这个值 本地路由Weight 32768 非本地0` **不具备传递性，路由器本地入栈修改**
        3. Local-Preference值最高路由优先 `PV一样后比较LP，只能在一个AS内传递，默认值100，值越高越好，当出AS发送给EBGP邻居时值恢复为100` **当一个AS内有多台边界路由器，当多台边界路由器给AS发送相同BGP路由时，可修改LP值选最优，就相当于你转发去往外网报文时，你选择谁作为出口（出）**
        4. `本地路由要优于邻居产生的路由`
            1. 聚合路由优先于非聚合路由
            2. 本地手动聚合路由的优先级高于本地自动聚合的路由
            3. 本地通过network命令引入的路由的优先级高于本地通过import-route命令引入的路由
        5. AS路径的长度最短的路径优先
        6. `比较Origin属性，IGP优于EGP，EGP优于Incomplete（i(network、aggregate）>e>?（其他方式import-route))`
        7. `选择MED较小的路由 通告给EBGP邻居，让EBGP邻居发包去往本地的时候优选哪条路径进入 默认值是0 只能在邻居AS内传递，传递给其他AS后还原为默认值`**（进）**
        8. EBGP路由优于IBGP路由 `选路原则中根本不会看AD值`
        9. BGP优先选择到BGP下一跳的IGP度量最低的路径
            1. 当以上全部相同，则为等价路由，可以负载分担
                1. `注：AS_PATH必须一致`
                2. 当负载分担时，以下3条原则无效
        10. 比较Cluster-List长度，短者优先 `当你在一个AS内部署路由反射器，路由反射器每反射一次路由都会把它的Cluster_ID填充到Cluster-List中`
        11. 比较Originator_ID（如果没有Originator_ID，则用Router ID比较），选择数值较小的路径
        12. 比价对等体的IP地址，选择IP地址数值最小的路径
        ![BGP路径选择过程](https://i.imgur.com/1kJhxa6.jpg)
        ![BGP路径选择过程（续）](https://i.imgur.com/i3FYAiw.jpg)
- BGP 路由聚合
    - 自动汇总
        - auto-summary
        - 影响2⃣️类路由
            - 主类network 
                - 不汇总 10.1.1.0/24 10 MED 下一跳1.1.1.1
                - 以主类network宣告 不携带MED和下一跳1.1.1.1
            - redistribute `开启自动汇总后MED和下一跳会被抑制掉 MED为0 下一跳为0.0.0.0`
    - 手动汇总
        - 民间做法
            - 172.16.0.0/24 172.16.1.0/24➡️ip route 172.16.0.0 255.255.254.0 null 0 `只针对始发路由`
        - 官方做法
            - aggregate
            
            ```
            [RTA]bgp 100
            [RTA-bgp]network 192.168.1.1 255.255.255.255
            [RTA-bgp]network 192.168.1.2 255.255.255.255
            [RTA-bgp]network 192.168.1.3 255.255.255.255
            [RTA-bgp]peer 10.1.1.2 as-num 101
            [RTA-bgp]aggregate 192.168.1.0 24 detail-suppressed
            ```
            - BGP路由属性的继承
                - AS-Path
                - Origin
                - Community
                - `aggregate 160.0.0.0 255.0.0.0 detail-suppressed as-set 路由的始发路由器和聚合路由器不在同一个AS才要设置as-set`
            - 过滤策略
                - origin-policy：仅选择符合route-policy的具体路由来生成聚合路由
                - suppress-policy：抑制指定路由的通告
                - attribute-policy：把你生成的聚合路由的某些属性做修改
- BGP 路由策略
    - BGP可以修改的选路参数
        - Local-Preference
            - **通过BGP获悉路由的方式**
                1. network
                2. redistribute
                3. aggregate
                4. EBGP
                5. IBGP
            - 通过 `[Router-bgp]default local-preference 配置BGP的缺省本地优先级`能影响除aggregate以外的所有BGP获悉路由的方式
            ![BGP通过策略设置Local- Preference1](https://i.imgur.com/oj5PhwZ.jpg)
            ![BGP通过策略设置Local- Preference2](https://i.imgur.com/LGe3BNL.jpg)
            ![BGP通过策略设置Local- Preference3](https://i.imgur.com/7cwcARA.jpg)
        - AS-Path Filter
            - 正则表达式
                ![BGP正则表达式](https://i.imgur.com/VsTMPbW.jpg)
                - `ip as-path-filter 1 permit ^12.*74$` 匹配以12开始并且以74结束的AS路径
                - `ip as-path-filter 1 permit 23|43` 匹配有23或43的AS号
                - `ip as-path-filter 1 permit [1-3][47]` 匹配有14，17，24，27，34或37的AS号
                - `ip as-path-filter 1 permit _34512 170$` AS34512与AS170直接相连
                - `ip as-path-filter 1 permit [1-3].[47]`
                - `ip as-path-filter 1 permit _621 .+ 170$` 接受从AS170始发的路由，但是要经过AS621
            - BGP一些常用的正则表达式
                ![BGP一些常用的正则表达式](https://i.imgur.com/1eCjoIE.jpg)
            - 过滤路由
                ![BGP AS-Path Filter过滤路由](https://i.imgur.com/arD3c6m.jpg)
                ![BGP AS-Path Filter过滤路由1](https://i.imgur.com/wGYFsLW.jpg)
        - MED
            - 通过 `[Router-bgp]default med 配置BGP的缺省MED值，缺省情况下，MED的值为0`
            - `前缀列表`
                - `ip prefix-list 10 seq 10 permit 10.1.1.0/24`
                - **前24位前缀为10.1.1.0的前24位**
                - **掩码为24位**
                - `ip prefix-list 10 seq 20 permit 172.16.0.0/16 ge 24`
                - **前缀的前16位和172.16.0.0一致**
                - **掩码必须要大于等于24位 172.16.0-255.0/24**
                - `ip prefix-list 10 seq 30 permit 10.0.0.0/7 le 24`
                - **前缀的前7位必须为10.0.0.0**
                - **掩码长度要小于等于24位**
                - `ip prefix-list 10 seq 40 permit 10.1.0.0/16 ge 24 le 32`
                - **x<=y<=z**
                - **前缀的前16位必须是10.1.0.0**
                - **掩码长度必须大于等于24**
                - **掩码长度必须小于等于32**
                - 匹配主A类：`ip prefix-list A seq 10 permit 0.0.0.0/1 ge 8 le 8`
                - 匹配主B类：`ip prefix-list B seq 10 permit 128.0.0.0/2 ge 16 le 16`
                - 匹配主C类：`ip prefix-list C seq 10 permit 192.0.0.0/3 ge 24 le 24`
                - 匹配any：`ip prefix-list Any seq 10 permit 0.0.0.0/0 le 32`
            ![BGP通过策略设置MED1](https://i.imgur.com/nYSScus.jpg)
            ![BGP通过策略设置MED2](https://i.imgur.com/MCSxwhX.jpg)
            ![BGP通过策略设置MED3](https://i.imgur.com/l0EwIlt.jpg)
        - Communities
            ![BGP路由策略Community1](https://i.imgur.com/3DnEfkR.jpg)
            ![BGP路由策略Community2](https://i.imgur.com/d2PGQGj.jpg)
            ![BGP路由策略Community3](https://i.imgur.com/louPeW7.jpg)
            ![BGP路由策略Community4](https://i.imgur.com/vDjCbhR.jpg)
            ![BGP查看团体属性1](https://i.imgur.com/9BQMiWr.jpg)
            ![BGP查看团体属性2](https://i.imgur.com/vikXMqP.jpg)
- BGP 反射与联盟
    - BGP 是怎样防止环路的？
        - EBGP
            - `通过AS-Path属性，丢弃从EBGP对等体接收到的在AS-Path属性里包含自身AS号的任何更新信息`
        - IBGP
            - `BGP路由器不会将任何从IBGP对等体接收到的更新信息传给其它IBGP对等体`
    - IBGP 防止环路机制带来的问题
        - 为保证更新信息可以到达所有IBGP对等体
            - 解决方案：IBGP Speaker与IBGP Speaker之间要保证会话的全互连
            - `从而又带来IBGP会话数 n(n-1)/2 的问题`
        - 路由反射（RFC2796）
            - IBGP对等体可以有三种角色：
                - 路由反射器（Router Reflector）
                - 客户机（Client）
                - 非客户机（Non-Client）
            - `对等体之间的关系`
                - Client只需维护与RR之间的IBGP会话
                - RR与RR之间需要建立IBGP的全互连
                - Non-Client与Non-Client之间需要建立IBGP全互连
                - RR与Non-Client之间需要建立IBGP全互连
            - 路由反射宣告原则
            ![BGP路由反射宣告原则](https://i.imgur.com/mSrffEf.jpg)
            - 路由反射簇（Cluster）
            ![BGP路由反射簇（Cluster）](https://i.imgur.com/ThOUvtn.jpg)
                - Cluster ID 32bit Router ID
                - **Cluster-list 当你一条路由在被做第一次反射时，这个RR收到路由之后会给这条路由添加Cluster-list，在这个Cluster-list中会放置自身的Cluster ID**
                - `只有RR会查看Cluster ID`
            - 路由反射环路防止机制-Originator_ID
            - `RR用于控制层面，尽量不要用于数据层面`
            - 层次化路由反射
            ![BGP层次化路由反射](https://i.imgur.com/bWRczNp.jpg)
        - 联盟（RFC3065）
            ![BGP联盟](https://i.imgur.com/72wqDNH.jpg)

            ```
            Router bgp 1001
                bgp confederation identifier 100
                bgp confederation peer 1002
                bgp confederation peer 1003
            ```
            - `一条路由在联邦内传递时基本所有属性都是保持不变的，AS-Path会变，联邦内的AS-Path只用来防环，不用来计算选路（1002 1001 1003）`
            ![BGP AS-Path四种类型](https://i.imgur.com/4hsBEzL.jpg)
            ![BGP联盟AS_Path变化（入）](https://i.imgur.com/wmQpRVG.jpg)
            ![BGP联盟AS_Path变化（出）](https://i.imgur.com/kDbONWv.jpg)
        - BGP 联盟与反射的比较
        ![BGP联盟与反射的比较](https://i.imgur.com/EOPXswM.jpg)
- BGP 多归属
    - Multi-Homing 多宿主
        - 单路由器单出口
        - 双路由器单出口
        - 单路由器双出口/双路由器双出口
    - 单归属末端网络
        - 可以用静态路由或缺省路由代替BGP
- BGP 故障排除
    - BGP故障处理流程
    - BGP对等体建立故障
        - TCP连接
            - `BGP连接建立在TCP会话基础之上，端口号为179`
        - IP连通性
            - BGP对等体在大多数的情况下，需要静态路由或IGP提供可达性
        - OPEN消息的交互
            - OPEN消息是BGP建立对等体关系时交互信息的主要报文，交互的信息主要有：AS号、更新源地址以及其他参数
        - EBGP多跳
            - `建立EBGP邻居关系时，报文的默认TTL值为1，当建立非直连邻居关系时需要手动修改TTL值`
        - 其它问题
            - 物理连接的不稳定导致振荡（经常UP/DOWN）
        - 检查故障
            - `dis bgp peer`
            - `dis tcp status`
            - `<RTB>debug tcp packet`
            - `ping -a 2.2.2.2 1.1.1.1`
            - `dis cur configuration bgp`
    - BGP路由学习故障
        - 成为BGP路由的方法
            - 通过network命令
                - `被network命令通告的前缀必须存在于IP路由表里`
            - 通过aggregate命令
                - `被aggregate命令通告的前缀必须存在于BGP路由表里`
            - 通过import命令
                - `被import命令通告的前缀也必须是存在于IP路由表里`
                - R中A重分发进B **R宣告进协议A的所有直连路由以及通过协议A学习到的已加入路由表的路由**
        - `路由器永远只会把它认为最优的BGP路由发送给邻居，也就是路由前面要有>标志`
    - BGP路径选择故障
    
## 路由选择工具
- 路由选择工具
![路由选择工具](https://i.imgur.com/BfGraIB.jpg)
    - ACL 反码精确匹配前缀
        - basic acl只能抓前缀`access-list 10 permit 10.1.1.0 0.0.0.255 匹配 10.1.1.0-10.1.1.255 掩码多少无所谓 10.1.1.0/24 10.1.1.0/25 10.1.1.0/26` 取值范围2000～2999
        - advanced acl源抓前缀，目的匹配掩码`access-list 100 permit ip host 1.1.1.0 host 255.255.255.128` 取值范围3000～3999
        - interface-based acl 1000～1999
        ![ACL示例1](https://i.imgur.com/b7FQpZO.jpg)
        ![ACL示例2](https://i.imgur.com/jYrfdgF.jpg)
        ![ACL示例3](https://i.imgur.com/bj2GzUU.jpg)
        ![ACL示例4](https://i.imgur.com/dD8UowJ.jpg)
        ![ACL示例5](https://i.imgur.com/Iu4mG5X.jpg)
    - 前缀列表
        ![前缀列表](https://i.imgur.com/7cjXP3b.jpg)
        ![前缀列表示例](https://i.imgur.com/nGU4uDf.jpg)
    - AS-Path-Filter
        ![AS-Path-Filter](https://i.imgur.com/blmtPCZ.jpg)
    - Community-filter
        ![Community-filter](https://i.imgur.com/M4htLjW.jpg)
    - Route-policy
        - router-map test permit/deny 10
            - match ACL prefix
        - `三大用途`
            1. 路由选择协议的重分发
            2. `BGP修改属性（需要加空语句把不需要修改属性的都放行）`
            3. `PBR 策略路由 ACL抓的是真实层面的数据流 凌驾于路由表之上的路由转发策略 对于接收这股流量的入接口部署PBR permit/deny匹配或者不匹配流量`
        ![Route-policy](https://i.imgur.com/RWLrfRf.jpg)
        ![Route-policy示例](https://i.imgur.com/i0Ut2FO.jpg)
        
## 路由策略
- 路由引入 import-route OSPF---R1---EIGRP
    - 单点双向重分发
    - 双点双向重分发
- 路由过滤
    - 避免路由引入导致的次优路由
    - 避免路由回馈导致的路由环路
    - 进行精确的路由引入和路由通告控制
    - `单一协议 发送或接收路由过滤 分发列表distribute-list 路由过滤 只针对DV RIP EIGRP BGP`
    - `使用filter-policy在做acl调用时，只能调用标准acl来完成路由过滤`
    ![使用路由过滤避免次优路由配置](https://i.imgur.com/tyWPqjT.jpg)
    - BGP精确控制路由引入和路由发布
    ![BGP精确控制路由引入和路由发布](https://i.imgur.com/mPzrj6S.jpg)
    - 路由过滤规则
    ![路由过滤规则](https://i.imgur.com/kt7qLBl.jpg)
- 使用路由协议优先级
- 控制缺省路由下发
    - OSPF 可以配置多种下发方式
        - 在ABR上下发
        - 在ASBR上下发
        - 强制下发
        - 非强制下发
    ![OSPF下发缺省路由](https://i.imgur.com/FP7PnSE.jpg)
    - BGP下发缺省路由
    ![BGP下发缺省路由1](https://i.imgur.com/IkwbiN0.jpg)
    ![BGP下发缺省路由2](https://i.imgur.com/ZcrUKvr.jpg)
    ![BGP下发缺省路由3](https://i.imgur.com/m3Eqdhl.jpg)
    ![BGP下发缺省路由4](https://i.imgur.com/eE7UN10.jpg)
    ![BGP下发缺省路由5](https://i.imgur.com/5qLiFq0.jpg)
    
    ```
    [RTA]int loo0
    [RTA-loo0]ip add 1.1.1.1 32
    [RTA-loo0]quit
    [RTA]int g0/0/1
    [RTA-g0/0/1]ip add 13.1.1.1 24
    [RTA-g0/0/1]undo shutdown
    [RTA-g0/0/1]int g0/0/2
    [RTA-g0/0/2]ip add 14.1.1.1 24
    [RTA-g0/0/2]undo shutdown
    [RTA]router id 1.1.1.1
    [RTA]ospf 1
    [RTA-ospf-1]area 0.0.0.0
    [RTA-ospf-1-area-0.0.0.0]network 1.1.1.1 0.0.0.0
    [RTA-ospf-1-area-0.0.0.0]network 14.1.1.1 0.0.0.0
    [RTA-ospf-1-area-0.0.0.0]network 13.1.1.1 0.0.0.0
    [RTA-ospf-1-area-0.0.0.0]quit
    [RTA-ospf-1]quit
    [RTA]dis ospf int bri
    [RTA]dis ip routing-table protocol ospf
    [RTA]tracert -a 1.1.1.1 6.6.6.6
    [RTA]ping 5.5.5.5
    ```
    
    ```
    [RTB]int loo0
    [RTB-loo0]ip add 2.2.2.2 32
    [RTB-loo0]quit
    [RTB]int g0/0/1
    [RTB-g0/0/1]ip add 23.1.1.2 24
    [RTB-g0/0/1]undo shutdown
    [RTB-g0/0/1]int g0/0/2
    [RTB-g0/0/2]ip add 24.1.1.2 24
    [RTB-g0/0/2]undo shutdown
    [RTB]router id 2.2.2.2
    [RTB]ospf 1
    [RTB-ospf-1]area 0.0.0.0
    [RTB-ospf-1-area-0.0.0.0]network 2.2.2.2 0.0.0.0
    [RTB-ospf-1-area-0.0.0.0]network 23.1.1.2 0.0.0.0
    [RTB-ospf-1-area-0.0.0.0]network 24.1.1.2 0.0.0.0
    [RTB-ospf-1-area-0.0.0.0]quit
    [RTB-ospf-1]quit
    [RTB]dis ospf int bri
    [RTB]dis ip routing-table protocol ospf
    [RTB]ping 5.5.5.5
    ```
    
    ```
    [RTC]int loo0
    [RTC-loo0]ip add 3.3.3.3 32
    [RTC-loo0]quit
    [RTC]int e1/0/0
    [RTC-e1/0/0]ip add 13.1.1.3 24
    [RTC-e1/0/0]undo shutdown
    [RTC-e1/0/0]int e1/0/1
    [RTC-e1/0/1]ip add 23.1.1.3 24
    [RTC-e1/0/1]undo shutdown
    [RTC-e1/0/1]int g0/0/1
    [RTC-g0/0/1]ip add 35.1.1.3 24
    [RTC-g0/0/1]undo shutdown
    [RTC-g0/0/1]int g0/0/0
    [RTC-g0/0/0]ip add 34.1.1.3 24
    [RTC-g0/0/0]undo shutdown
    [RTC]router id 3.3.3.3
    [RTC]ospf 1
    [RTC-ospf-1]area 0.0.0.0
    [RTC-ospf-1-area-0.0.0.0]network 3.3.3.3 0.0.0.0
    [RTC-ospf-1-area-0.0.0.0]network 13.1.1.3 0.0.0.0
    [RTC-ospf-1-area-0.0.0.0]network 23.1.1.3 0.0.0.0
    [RTC-ospf-1-area-0.0.0.0]network 34.1.1.3 0.0.0.0
    [RTC-ospf-1-area-0.0.0.0]quit
    [RTC-ospf-1]quit
    [RTC]dis ospf int bri
    [RTC]dis ospf peer bri
    [RTC]bgp 100
    [RTC-bgp]router-id 3.3.3.3
    [RTC-bgp]peer 35.1.1.5 as-number 200
    [RTC-bgp]peer 4.4.4.4 as-number 100
    [RTC-bgp]peer 4.4.4.4 connect-interface lo 0
    [RTC-bgp]ipv4-family unicast
    [RTC-bgp-af-ipv4]peer 35.1.1.5 enable
    [RTC-bgp-af-ipv4]peer 4.4.4.4 enable
    [RTC-bgp-af-ipv4]peer 4.4.4.4 next-hop-local
    [RTC-bgp-af-ipv4]quit
    [RTC-bgp]quit
    [RTC]dis bgp routing-table
    [RTC]bgp 100
    [RTC-bgp]ipv4-family unicast
    [RTC-bgp-af-ipv4]import-route ospf 1
    [RTC-bgp-af-ipv4]quit
    [RTC-bgp]quit
    [RTC]ospf 1
    [RTC-ospf-1]default-route-advertise always
    [RTC-ospf-1]undo default-route-advertise
    [RTC-ospf-1]default-route-advertise
    [RTC]bgp 100
    [RTC-bgp]preference 100 255 255
    优先级只是一个本地概念
    ```

    ```
    [RTD]int loo0
    [RTD-loo0]ip add 4.4.4.4 32
    [RTD-loo0]quit
    [RTD]int e1/0/0
    [RTD-e1/0/0]ip add 14.1.1.4 24
    [RTD-e1/0/0]undo shutdown
    [RTD-e1/0/0]int e1/0/1
    [RTD-e1/0/1]ip add 24.1.1.4 24
    [RTD-e1/0/1]undo shutdown
    [RTD-e1/0/1]int g0/0/1
    [RTD-g0/0/1]ip add 46.1.1.4 24
    [RTD-g0/0/1]undo shutdown
    [RTD-g0/0/1]int g0/0/0
    [RTD-g0/0/0]ip add 34.1.1.4 24
    [RTD-g0/0/0]undo shutdown
    [RTD]router id 3.3.3.3
    [RTD]ospf 1
    [RTD-ospf-1]area 0.0.0.0
    [RTD-ospf-1-area-0.0.0.0]network 4.4.4.4 0.0.0.0
    [RTD-ospf-1-area-0.0.0.0]network 14.1.1.4 0.0.0.0
    [RTD-ospf-1-area-0.0.0.0]network 24.1.1.4 0.0.0.0
    [RTD-ospf-1-area-0.0.0.0]network 34.1.1.4 0.0.0.0
    [RTD-ospf-1-area-0.0.0.0]quit
    [RTD-ospf-1]quit
    [RTD]dis ospf int bri
    [RTD]dis ospf peer bri
    [RTD]bgp 100
    [RTD-bgp]router-id 4.4.4.4
    [RTD-bgp]peer 46.1.1.6 as-number 200
    [RTD-bgp]peer 3.3.3.3 as-number 100
    [RTD-bgp]peer 3.3.3.3 connect-interface lo 0
    [RTD-bgp]ipv4-family unicast
    [RTD-bgp-af-ipv4]peer 46.1.1.6 enable
    [RTD-bgp-af-ipv4]peer 3.3.3.3 enable
    [RTD-bgp-af-ipv4]peer 3.3.3.3 next-hop-local
    [RTD-bgp-af-ipv4]quit
    [RTD-bgp]quit
    [RTD]dis bgp routing-table
    [RTD]bgp 100
    [RTD-bgp]ipv4-family unicast
    [RTD-bgp-af-ipv4]import-route ospf 1
    [RTD-bgp-af-ipv4]quit
    [RTD-bgp]quit
    [RTD]ospf 1
    [RTD-ospf-1]default-route-advertise always
    [RTD]int g0/0/1
    [RTD-g0/0/1]shutdown
    [RTD]dis bgp routing-table
    [RTD]tracert -a 4.4.4.4 6.6.6.6
    [RTD]int g0/0/0
    [RTD-g0/0/0]shutodwn
    [RTD]dis ospf peer brief
    [RTD]dis bgp peer
    [RTD]dis bgp routing-table
    [RTD]dis ip routing-tabel protocol ospf
    [RTD-ospf-1]undo default-route-advertise
    [RTD-ospf-1]default-route-advertise
    [RTD]bgp 100
    [RTD-bgp]preference 100 255 255
    优先级只是一个本地概念
    ```

    ```
    [RTE]int loo0
    [RTE-loo0]ip add 5.5.5.5 32
    [RTE-loo0]quit
    [RTE]int g0/0/1
    [RTE-g0/0/1]ip add 35.1.1.5 24
    [RTE-g0/0/1]undo shutdown
    [RTE-g0/0/1]int g0/0/0
    [RTE-g0/0/0]ip add 56.1.1.5 24
    [RTE-g0/0/0]undo shutdown
    [RTE]bgp 200
    [RTE-bgp]router-id 5.5.5.5
    [RTE-bgp]peer 35.1.1.3 as-number 100
    [RTE-bgp]ipv4-family unicast
    [RTE-bgp-af-ipv4]peer 35.1.1.3 enable
    [RTE-bgp-af-ipv4]quit
    [RTE-bgp]quit
    [RTE]router id 5.5.5.5
    [RTE]ospf 200
    [RTE-ospf-200-area-0.0.0.200]network 5.5.5.5 0.0.0.0
    [RTE-ospf-200-area-0.0.0.200]network 56.1.1.5 0.0.0.0
    [RTE-ospf-200-area-0.0.0.200]quit
    [RTE-ospf-200]quit
    [RTE]bgp 200
    [RTE-bgp]peer 6.6.6.6 as-number 200
    [RTE-bgp]peer 6.6.6.6 connect-interface lo 0
    [RTE-bgp]ipv4-family unicast
    [RTE-bgp-af-ipv4]peer 6.6.6.6 enable
    [RTE-bgp-af-ipv4]peer 6.6.6.6 next-hop-local
    [RTE-bgp-af-ipv4]quit
    [RTE-bgp]quit
    [RTE]dis bgp peer
    [RTE]bgp 200
    [RTE-bgp]ipv4-family unicast
    [RTE-bgp-af-ipv4]peer 35.1.1.3 default-route-advertise
    [RTE-bgp-af-ipv4]quit
    [RTE-bgp]quit
    [RTE]dis ip routing-table
    ```
    
    ```
    [RTF]int loo0
    [RTF-loo0]ip add 6.6.6.6 32
    [RTF-loo0]quit
    [RTF]int g0/0/1
    [RTF-g0/0/1]ip add 46.1.1.6 24
    [RTF-g0/0/1]undo shutdown
    [RTF-g0/0/1]int g0/0/0
    [RTF-g0/0/0]ip add 56.1.1.6 24
    [RTF-g0/0/0]undo shutdown
    [RTF]bgp 200
    [RTF-bgp]router-id 6.6.6.6
    [RTF-bgp]peer 46.1.1.4 as-number 100
    [RTF-bgp]ipv4-family unicast
    [RTF-bgp-af-ipv4]peer 46.1.1.4 enable
    [RTF-bgp-af-ipv4]quit
    [RTF-bgp]quit
    [RTF]router id 6.6.6.6
    [RTF]ospf 200
    [RTF-ospf-200-area-0.0.0.200]network 6.6.6.6 0.0.0.0
    [RTF-ospf-200-area-0.0.0.200]network 56.1.1.6 0.0.0.0
    [RTF-ospf-200-area-0.0.0.200]quit
    [RTF-ospf-200]quit
    [RTF]bgp 200
    [RTF-bgp]peer 5.5.5.5 as-number 200
    [RTF-bgp]peer 5.5.5.5 connect-interface lo 0
    [RTF-bgp]ipv4-family unicast
    [RTF-bgp-af-ipv4]peer 5.5.5.5 enable
    [RTF-bgp-af-ipv4]peer 5.5.5.5 next-hop-local
    [RTF-bgp-af-ipv4]quit
    [RTF-bgp]quit
    [RTF]dis bgp peer
    [RTF]bgp 200
    [RTF-bgp]ipv4-family unicast
    [RTF-bgp-af-ipv4]peer 46.1.1.4 default-route-advertise
    ```
    **通过default-route-advertise always下发缺省路由要谨慎，最好不要带always参数**
- 基于策略的路由选择(两种方式）
    - 前提路由表中要有路由条目
    - 不管有没有路由条目都转发
    - 调用方式
        - 全局：`ip local policy-based-route PBR1`  
    ![策略路由实例](https://i.imgur.com/vp2P8jq.jpg)


## MPLS
- MPLS概述
    - Multi Protocol Label Switching
    - 控制层面
        - IGP BGP Static
    - 数据层面
        - Switch CAM表 ASIC
        - Router 网络号 CPU
        - Router转发比Switch转发慢的原因
            1. 表项无法精确匹配报文目的地址
            2. CPU查表不依赖ASIC
            3. MPLS增加Router转发效率，减小延迟
    - MPLS标签20bit
        - `标签分发基于FEC：转发等价类 一组去往相同目的地（广播域）的报文集合 可以理解为同一条路由条目转发的数据包`
        - LFIB 标签转发信息库
        - 必须要启用CEF（Cisco极速/快速转发）交换机制 `路由器交换机启用后会有FIB（转发信息库）和Adjacency Table(邻接关系表）集成在ASIC芯片中`
        - FIB基于ASIC芯片的（无需再递归查询）
        - 路由器转发从进程交换➡️快速交换（数据流Flow Flow中的转发第一个数据所需要的信息形成Cache---ASIC）`一次查表多次转发`➡️CEF
        - 可以解决BGP的黑洞
        - 高级特性MPLS VPN MPLS TE（大规模部署的PBR）
        - 标签分为2种
            4. `in-label 入标签 路由器自身关于一条路由条目所产生的标签`
            5. `out-label 出标签`
- MPLS基本原理
    - MPLS基本结构
        - PHP：次末跳标签弹出
        - 标签押入impose
        - 标签弹出pop
        - 标签交换switch
        - 控制协议
            - TDP/LDP
            - MP-BGP对应VPN
            - RSVP对应TE
        - `0-15被保留标签 3（Cisco下游最后一跳路由器产生隐式空标签）Cisco从16开始创建 Huawei 1024`
        - LIB标签信息库类似于OSPF LSDB➡️LFIB（本地标签/远程标签 出接口 下一跳地址）
    ![MPLS结构](https://i.imgur.com/F0UijTD.jpg)
    - MPLS标签格式
    ![帧格式MPLS](https://i.imgur.com/IU1ZSA0.jpg)
    ![MPLS标签嵌套](https://i.imgur.com/R9Nngd1.jpg)
    - MPLS转发流程传统IP转发
        - `<SWA>dis mpls lsp include 10.2.0.0 24 verbose`
        ![MPLS转发- Ingress LER](https://i.imgur.com/IF1ijcJ.jpg)
        ![MPLS转发-Ingress LER（SWA）](https://i.imgur.com/a59pS1U.jpg)
        - `<SWB>dis mpls lsp include 10.2.0.0 24 in-label 1030 verbose`
        ![MPLS转发-LSR（SWB）](https://i.imgur.com/OdZnxT7.jpg)
        ![MPLS转发-LSR（SWB）续](https://i.imgur.com/3oPiFdq.jpg)
        ![MPLS转发- Egress LER（SWD）](https://i.imgur.com/X6iPC1o.jpg)
        ![MPLS转发-Egress LER（SWD）续](https://i.imgur.com/4FCU4Lx.jpg)
- MPLS环路检测
    - MPLS TTL环路检测
        
        ```
        [SW]mpls
        [SW-mpls]undo ttl propagate public
        ```
    - LDP环路检测
        - LDP路径向量法
        ![MPLS LDP路径向量法](https://i.imgur.com/MJXhlMN.jpg)
        - LDP最大跳数法
        ![MPLS LDP最大跳数法](https://i.imgur.com/rRTqOtM.jpg)
        - LDP环路检测基本配置
        `[SWC-mpls-ladp]dis mpls ldp`
        ![LDP环路检测基本配置](https://i.imgur.com/Ti7gr28.jpg)
        ![LDP环路检测基本配置（续）](https://i.imgur.com/RS2eZEw.jpg)
- LDP协议原理
    - LDP邻居发现和会话建立
        - LDP基本概念
        ![LDP基本概念](https://i.imgur.com/bNkL9yK.jpg)
            - `华为默认会对主机路由/32进行标签分发`
            - 主要干两件事
                1. `产生标签 纯本地化`
                2. `通告标签 in label/out label`
            - 封装：Layer2｜IP｜TCP/UDP｜TDP/LDP｜FCS
            - LDP消息类型与封装格式
            ![LDP消息类型](https://i.imgur.com/D8to37D.jpg)
            ![LDP消息类型与封装格式](https://i.imgur.com/WFzw28x.jpg)
                - LDP Identifier
                    - `4byte Router-id X.X.X.X`
                    - `2byte 标签空间 （帧模式）基于平台的标签空间/（信元模式）基于接口的标签空间`
            - LDP消息作用
             ![LDP消息作用](https://i.imgur.com/MUOIrR6.jpg)
                - **LDP组播地址 224.0.0.2 发送hello源地址router-id 如果你的路由器router-id是loop0，loop0必须要宣告进IGP去**
        - LDP邻居发现机制
            ![LDP发现机制](https://i.imgur.com/PppqUGx.jpg)
        - LDP会话建立过程
            ![本地LDP会话基本设置](https://i.imgur.com/v9FC6vx.jpg)
            ![本地LDP会话基本配置～](https://i.imgur.com/FSfytPv.jpg)
            ![本地LDP会话基本配置（续）](https://i.imgur.com/9OBa4sq.jpg)
            ![本地LDP会话基本配置transport-address](https://i.imgur.com/RE5nr4L.jpg)
            ![本地LDP会话基本配置transport-address（续）](https://i.imgur.com/GkIhiMU.jpg)
            ![远端LDP会话基本配置](https://i.imgur.com/pXwW0B7.jpg)
            ![远端LDP会话基本配置（续）](https://i.imgur.com/hSEnYPr.jpg)
        - LDP状态机
            ![LDP状态机](https://i.imgur.com/pOnZYGw.jpg)
            ![LDP状态机案例分析](https://i.imgur.com/bc6bl0x.jpg)
            ![LDP状态机案例分析（续）](https://i.imgur.com/P3pxaOP.jpg)
        - LDP标签空间
        ![基于平台的标签空间](https://i.imgur.com/OJ88wLX.jpg)
        - 标签通告
            - DU（Distribution Unsolicited）独立通告
            - DoD（Distribution on Demand）按需通告
            ![标签分发配置实例与分析](https://i.imgur.com/HX0DfHs.jpg)
            ![标签分发配置实例与分析（续）](https://i.imgur.com/HX0DfHs.jpg)
        - 标签分发
            - Ordered有序 `最后一跳路由器会针对FEC做自动标签分发，不是最后一跳路由器依据我的下游路由器已经把它所分发的标签分发给我了` Huawei
            - Independent独立 Cisco
            ![标签分发DoD+Independent](https://i.imgur.com/tXVgKTh.jpg)
            ![标签分发DU+Independent](https://i.imgur.com/6VSqecM.jpg)
            ![标签分发Dod+Ordered](https://i.imgur.com/h3ZnFwe.jpg)
            ![标签分发DU+Ordered](https://i.imgur.com/81zN5ZD.jpg)
            ![标签通告和分发方式实例分析1](https://i.imgur.com/JDexN1D.jpg)
            ![标签通告和分发方式实例分析2](https://i.imgur.com/icodKP2.jpg)
            ![标签通告和分发方式实例分析3](https://i.imgur.com/d0bu3bu.jpg)
            ![标签通告和分发方式实例分析4](https://i.imgur.com/ByEjDrD.jpg)
        - 标签保存
            - conservative保守的
            - liberal自由的
            ![标签保存- Conservative](https://i.imgur.com/uHVHSCv.jpg)
            ![标签保存- Liberal](https://i.imgur.com/l6f9r8c.jpg)
            ![标签保存-配置实例与分析1](https://i.imgur.com/wERAVZh.jpg)
            ![标签保存-配置实例与分析2](https://i.imgur.com/Hz5eHD1.jpg)
            ![标签保存-配置实例与分析3](https://i.imgur.com/PISHdOM.jpg)
            ![标签保存-配置实例与分析4](https://i.imgur.com/9mflDB1.jpg)
            ![标签保存-配置实例与分析5](https://i.imgur.com/C9ZnelS.jpg)
        - PHP
            - `Penultimate Hop Popping 倒数第二跳弹出`
            - 隐式（默认，标签号为3）
            ![PHP（隐式）](https://i.imgur.com/0TZmnix.jpg)
            - 显式
            ![PHP（显式）](https://i.imgur.com/3uzR7QV.jpg)
            - NULL
            ![PHP（NULL）](https://i.imgur.com/nm1sbN5.jpg)
    - LDP标签管理

## MPLS IP VPN
- basic concepts and principles of mpls vpn
    - a vpn has tow characteristics
        - virtual and dedicated
    - a type of Layer 3 VPN(L3VPN)
        - consists of four parts - BGP, MPLS, IP and VPN
            - BGP advertises VPN routes on the backbone network of a service provider(通告）
            - MPLS forwards VPN packets on the backbone network(转发)
            - IP packets are transmitted on such a network(传输)
            - VPN indicates the BGP/MPLS IP VPN is a VPN technology
    - basic terms of mpls vpn
        - CEs are unaware of VPNs and do not need to support MPLS
        - PEs need to be aware of, obtain, and advertise customer network routes, which are also known as VPN routes.
    - VPN Instance
    ![VPN Instance](https://i.imgur.com/1fs23IC.jpg)
    ![VPN Instance Application](https://i.imgur.com/wOEPHNh.jpg)
        - how do i prevent these routes from conflicting with each other?
            - Virtual routing and forwarding(VRF) is involved in the process(VRF is also known as VPN Instance) 
            - VPN instances are use to logically divide a physical device, enabling multiple virtual devices(also called VRFs) to be created on the physical device(such as a router or a switch).
    - Route Distinguisher
    ![Route Distinguisher](https://i.imgur.com/PRGOljK.jpg)
    ![Route Distinguisher Application](https://i.imgur.com/ERtf2Vd.jpg)
    - MP-BGP
    ![MP-BGP](https://i.imgur.com/WyeKdk2.jpg)
    - Route Target(RT)     
    ![Route Target](https://i.imgur.com/y2fOFAl.jpg)
    - VPN Route Advertisement 
    ![VPN Route Advertisement](https://i.imgur.com/zWHXK7c.jpg)
    - Route Processing on PE2
    ![Route Processing on PE2](https://i.imgur.com/qXTMr0G.jpg)
    - Usage of an MPLS Tunnel
    ![Usage of an MPLS Tunnel](https://i.imgur.com/iuzwtMh.jpg)
    ![USage of an MPLS Tunnel（续）](https://i.imgur.com/TZfxjhi.jpg)
- route exchange and data forwarding of mpls vpn
    ![PE-CE Routing Protocol and VPN Instance](https://i.imgur.com/H9hSRT3.jpg)
    - Functional Modules on the PE
    ![Functional Modules on the PE](https://i.imgur.com/2c4RO91.jpg)
        1. Configure VPN instances to exchange routes with CEs and store VPN instance routes.
        2. Establish IGP neighbor relationships on the public network and store IGP routing tables.
        3. Establish MPLS tunnels and maintain all entries related to MPLS.
        4. Establish MP-BGP peer relationships and maintain the VPNv4 routing tables.
    - Before delving into the process of VPNv4 route advertisement on an MPLS VPN network,let's examine the regular configuration:
        5. CEs and PEs maintain IGP neighbor relationships or BGP peer relationships, and exchange VPN IPv4 routes.
        6. An MP-BGP peer relationship is established between PEs. If PEs are in the same AS, an MP-IBGP peer relationship is established to exchange VPNv4 routes and labels.
    - VPNv4 Route Advertisement on an MPLS VPN Network
    ![VPNv4 Route Advertisement on an MPLS VPN Network1](https://i.imgur.com/OPkog8b.jpg)
    ![VPNv4 Route Advertisement on an MPLS VPN Network2](https://i.imgur.com/ovKa4PQ.jpg)
    ![VPNv4 Route Advertisement on an MPLS VPN Network3](https://i.imgur.com/Rg0gvbf.jpg)
        7. Each CE advertises a private IPv4 route to PE1.
        8. PE1 adds the VPN routes to the IP routing tables of the VPN instances.
        9. PE1 adds the RD to a VPN route prefix to form a VPNv4 route. In addition, the export RT is added to the VPNv4 route.
        10. PE1 advertises the VPNv4 route to its peer through the MP-BGP peer relationship.
        11. After receiving the VPNv4 route,PE2 matches the export RT of the VPNv4 route against the import RT of a VPN instance. If they match, PE2 removes the RD from the VPNv4 route and injects the IPv4 route to a specific VPN instance.
        12. PE2 advertises the IPv4 route to a CE through a BGP peer relationship, and the CE adds the route to its own IP routing table.
    - MPLS VPN Data Transmission(Label Value Preparation)
    ![MPLS VPN Data Transmission-Label Value Preparation-](https://i.imgur.com/880JbsQ.jpg)
    ![MPLS VPN Data Transmission](https://i.imgur.com/p2ZgMS5.jpg)
- 原理与配置
![VPN模型-Overlay VPN](https://i.imgur.com/hDInDfp.jpg)
![VPN模型-Peer-to-Peer VPN](https://i.imgur.com/5oU6eVg.jpg)
![解决地址空间重叠问题的讨论](https://i.imgur.com/mKtmB6K.jpg)
![本地路由冲突的解决方案](https://i.imgur.com/PFnQYRk.jpg)
![如何在网络传递过程中区分冲突路由](https://i.imgur.com/jbAx4SC.jpg)
![Hub-Spoke场景中VPN路由的引入问题](https://i.imgur.com/izi2KE1.jpg)
![Hub-Spoke场景中路由引入问题的解决](https://i.imgur.com/uuaA0Ny.jpg)
![Hub-Spoke场景中路由引入问题的优化](https://i.imgur.com/Qp1ZYth.jpg)
![解决数据转发过程中冲突路由的查找](https://i.imgur.com/b1800fF.jpg)
![MPLS标签嵌套的应用](https://i.imgur.com/vt6MTD6.jpg)
![VPN路由注入MP-BGP的过程](https://i.imgur.com/uDYentt.jpg )
![VPN路由注入MP-BGP的过程（续）](https://i.imgur.com/rDgircO.jpg)
![公网标签的分配过程](https://i.imgur.com/0OXCTKI.jpg)
![CE设备到PE设备的数据转发](https://i.imgur.com/Z1JbFw0.jpg)
![MPLS VPN配置实例](https://i.imgur.com/PH1GmFE.jpg)
    - 配置步骤
        1. `实现公网互通；`
        2.` 创建VPN；`
        3. `在公网中做MPLS加快数据转发；`
        4. `配置BGP，实现私网相同的VPN互访；`
        
    ```
    [pe1]int g0/0/0
    [pe1-g0/0/0]ip add 34.34.34.3 24
    [pe1-g0/0/0]int loo0
    [pe1-loo0]ip add 3.3.3.3 32
    [pe1-loo0]ospf r 3.3.3.3
    [pe1-ospf-1]a 0
    [pe1-ospf-1-area-0.0.0.0]network 34.34.34.0 0.0.0.255
    [pe1-ospf-1-area-0.0.0.0]network 3.3.3.3 0.0.0.0
    [pe1-ospf-1-area-0.0.0.0]q
    [pe1-ospf-1]q
    [pe1]ip vpn-instance vpn1
    [pe1-vpn-instance-vpn1]ipv4-family
    [pe1-vpn-instance-vpn1-af-ipv4]q
    [pe1-vpn-instance-vpn1]q
    [pe1]ip vpn-instance vpn2
    [pe1-vpn-instance-vpn2]ipv4-family
    [pe1-vpn-instance-vpn2-af-ipv4]q
    [pe1-vpn-instance-vpn2]q
    [pe1]int g0/0/1
    [pe1-g0/0/1]ip binding vpn-instance vpn1
    [pe1-g0/0/1]ip add 192.168.1.1 24
    [pe1-g0/0/1]int g0/0/2
    [pe1-g0/0/2]ip binding vpn-instance vpn2
    [pe1-g0/0/2]ip add 192.168.1.1 24
    [pe1-g0/0/2]q
    [pe1]dis ip int b
    [pe1]ip vpn-instance vpn1
    [pe1-vpn-instance-vpn1]route-distinguisher 100:400
    [pe1-vpn-instance-vpn1]vpn-target 1:6 export-extcommunity
    [pe1-vpn-instance-vpn1]vpn-target 6:1 import-extcommunity
    [pe1-vpn-instance-vpn1]q
    [pe1]ip vpn-instance vpn2
    [pe1-vpn-instance-vpn2]route-distinguisher 200:500
    [pe1-vpn-instance-vpn2]vpn-target 10:10
    [pe1-vpn-instance-vpn2]q
    [pe1]mpls lsr-id 3.3.3.3
    [pe1-mpls]lsp-trigger all
    [pe1-mpls]q
    [pe1]mpls ldp
    [pe1-mpls-ldp]q
    [pe1]int g0/0/0
    [pe1-g0/0/0]mpls 
    [pe1-g0/0/0]mpls ldp
    [pe1-g0/0/0]q
    [pe1]ping lsp -a 3.3.3.3 ip 5.5.5.5 32
    [pe1]bgp 300
    [pe1-bgp]peer 5.5.5.5 as 300
    [pe1-bgp]peer 5.5.5.5 c l0
    [pe1-bgp]peer 5.5.5.5 next-hop-local
    [pe1-bgp]ipv4-family vpnv4
    [pe1-bgp-af-vpnv4]peer 5.5.5.5 enable
    [pe1-bgp-af-vpnv4]di th
    [pe1-bgp-af-vpnv4]q
    [pe1-bgp]q
    [pe1]dis bgp peer
    [pe1]bgp 300
    [pe1-bgp]peer 192.168.1.2 as 100
    [pe1-bgp]undo peer 192.168.1.2
    [pe1-bgp]ipv4-family vpn-instance vpn1
    [pe1-bgp-vpn1]peer 192.168.1.2 as 100
    [pe1-bgp-vpn1]q
    [pe1-bgp]ipv4-family vpn-instance vpn2
    [pe1-bgp-vpn2]peer 192.168.1.2 as 200
    [pe1-bgp-vpn2]q
    [pe1-bgp]q
    [pe1]dis bgp peer
    [pe1]dis bgp vpnv4 vpn-instance vpn1 peer
    [pe1]dis bgp vpnv4 vpn-instance vpn2 peer
    [pe1]dis cu c bgp
    [pe1]dis ip routing-table
    [pe1]dis ip routing-table vpn-instance vpn1
    [pe1]dis ip routing-table vpn-instance vpn2
    ```
    
    ```
    [p]int g0/0/0
    [p-g0/0/0]ip add 34.34.34.4 24
    [p-g0/0/0]int g0/0/1
    [p-g0/0/1]ip add 45.45.45.4 24
    [p-g0/0/1]int loo0
    [p-loo0]ip add 4.4.4.4 32
    [p-loo0]ospf r 4.4.4.4
    [p-ospf-1]a 0
    [p-ospf-1-area-0.0.0.0]network 34.34.34.0 0.0.0.255
    [p-ospf-1-area-0.0.0.0]network 45.45.45.0 0.0.0.255
    [p-ospf-1-area-0.0.0.0]network 4.4.4.4 0.0.0.0
    [p-ospf-1-area-0.0.0.0]q
    [p-ospf-1]q
    [p]mpls lsr-id 4.4.4.4
    [p-mpls]lsp-trigger all
    [p-mpls]q
    [p]mpls ldp
    [p-mpls-ldp]q
    [p]int g0/0/0
    [p-g0/0/0]mpls 
    [p-g0/0/0]mpls ldp
    [p-g0/0/0]int g0/0/1
    [p-g0/0/1]mpls
    [p-g0/0/1]mpls ldp
    [p-g0/0/1]q
    [p]dis mpls ldp session
    ```
    
    ```
    [pe2]int g0/0/0
    [pe2-g0/0/0]ip add 45.45.45.5 24
    [pe2-g0/0/0]int loo0
    [pe2-loo0]ip add 5.5.5.5 32
    [pe2-loo0]ospf r 5.5.5.5
    [pe2-ospf-1]a 0
    [pe2-ospf-1-area-0.0.0.0]network 45.45.45.0 0.0.0.255
    [pe2-ospf-1-area-0.0.0.0]network 5.5.5.5 0.0.0.0
    [pe2-ospf-1-area-0.0.0.0]q
    [pe2-ospf-1]q
    [pe2]ip vpn-instance vpn3
    [pe2-vpn-instance-vpn3]ipv4-family
    [pe2-vpn-instance-vpn3-af-ipv4]q
    [pe2-vpn-instance-vpn3]q
    [pe2]ip vpn-instance vpn4
    [pe2-vpn-instance-vpn4]ipv4-family
    [pe2-vpn-instance-vpn4-af-ipv4]q
    [pe2-vpn-instance-vpn4]q
    [pe1]int g0/0/1
    [pe2-g0/0/1]ip binding vpn-instance vpn3
    [pe2-g0/0/1]ip add 192.168.2.1 24
    [pe2-g0/0/1]int g0/0/2
    [pe2-g0/0/2]ip binding vpn-instance vpn2
    [pe2-g0/0/2]ip add 192.168.2.1 24
    [pe2-g0/0/2]q
    [pe2]dis ip int b
    [pe2]ip vpn-instance vpn3
    [pe2-vpn-instance-vpn3]route-distinguisher 4:1
    [pe2-vpn-instance-vpn3]vpn-target 6:1 export-extcommunity
    [pe2-vpn-instance-vpn3]vpn-target 1:6 import-extcommunity
    [pe2-vpn-instance-vpn3]q
    [pe2]ip vpn-instance vpn4
    [pe2-vpn-instance-vpn4]route-distinguisher 200:500
    [pe2-vpn-instance-vpn4]vpn-target 10:10
    [pe2-vpn-instance-vpn4]q
    [pe2]mpls lsr-id 5.5.5.5
    [pe2-mpls]lsp-trigger all
    [pe2-mpls]q
    [pe2]mpls ldp
    [pe2-mpls-ldp]q
    [pe2]int g0/0/0
    [pe2-g0/0/0]mpls 
    [pe2-g0/0/0]mpls ldp
    [pe2]bgp 300
    [pe2-bgp]peer 3.3.3.3 as 300
    [pe2-bgp]peer 3.3.3.3 c l0
    [pe2-bgp]peer 3.3.3.3 next-hop-local
    [pe2-bgp]ipv4-family vpnv4
    [pe2-bgp-af-vpnv4]peer 3.3.3.3 enable
    [pe2-bgp-af-vpnv4]di th
    [pe2-bgp-af-vpnv4]q
    [pe2-bgp]q
    [pe2]dis bgp peer
    [pe2]bgp 300
    [pe1-bgp]ipv4-family vpn-instance vpn3
    [pe1-bgp-vpn3]peer 192.168.2.2 as 400
    [pe1-bgp-vpn3]q
    [pe1-bgp]ipv4-family vpn-instance vpn4
    [pe1-bgp-vpn4]peer 192.168.2.2 as 500
    [pe1-bgp-vpn4]q
    [pe1-bgp]q
    [pe1]dis bgp peer
    [pe1]dis bgp vpnv4 vpn-instance vpn3 peer
    [pe1]dis bgp vpnv4 vpn-instance vpn4 peer
    ```
    
    ```
    [ce1]int g0/0/0
    [ce1-g0/0/0]ip add 192.168.1.2 24
    [ce1-g0/0/0]ping 192.168.1.1 
    [ce1-g0/0/0]int loo172
    [ce1-loo172]ip add 172.16.1.1 24
    [ce1-loo172]q
    [ce1]bgp 100
    [ce1-bgp]peer 192.168.1.1 as 300
    [ce1-bgp]network 172.16.1.0 24
    [ce1-bgp]q
    ```
    
    ```
    [ce2]int g0/0/0
    [ce2-g0/0/0]ip add 192.168.1.2 24
    [ce2-g0/0/0]ping 192.168.1.1 
    [ce2-g0/0/0]int loo172
    [ce2-loo172]ip add 172.16.1.1 24
    [ce2-loo172]q
    [ce2]bgp 200
    [ce2-bgp]peer 192.168.1.1 as 300
    [ce2-bgp]network 172.16.1.0 24
    [ce2-bgp]q
    ```

    ```
    [ce3]int g0/0/0
    [ce3-g0/0/0]ip add 192.168.2.2 24
    [ce3-g0/0/0]ping 192.168.2.1 
    [ce3-g0/0/0]int loo172
    [ce3-loo172]ip add 172.16.2.1 24
    [ce3-loo172]int loo60
    [ce3-loo60]ip add 60.1.1.1 32
    [ce3-loo60]q
    [ce3]bgp 400
    [ce3-bgp]peer 192.168.2.1 as 300
    [ce3-bgp]network 172.16.2.0 24
    [ce3-bgp]network 60.1.1.1 32
    [ce3-bgp]q
    ```
    
    ```
    [ce4]int g0/0/0
    [ce4-g0/0/0]ip add 192.168.2.2 24
    [ce4-g0/0/0]ping 192.168.2.1 
    [ce4-g0/0/0]int loo172
    [ce4-loo172]ip add 172.16.2.1 24
    [ce4-loo172]int loo70
    [ce4-loo70]ip add 70.1.1.1 32
    [cd4-loo70]q
    [ce4]bgp 500
    [ce4-bgp]peer 192.168.2.1 as 300
    [ce4-bgp]network 172.16.1.0 24
    [ce4-bgp]network 70.1.1.1 32
    [ce4-bgp]q
    ```

## VLAN
- Mux VLAN
    - `MUX VLAN分为主VLAN和从VLAN，从VLAN又分为互通性从VLAN和隔离型从VLAN`
    ![mux vlan配置](https://i.imgur.com/GfcIZuT.jpg)
- ARP Proxy方式
    - 路由式ARP Proxy：解决同一网段不同物理网络上计算机的互通问题；
    - VLAN内ARP Proxy：解决相同VLAN内，且VLAN配置用户隔离后的网络上计算机互通问题；
    - VLAN间ARP Proxy：解决不同VLAN之间对应计算机的三层互通问题
- VLAN Mapping原理
![vlan mapping配置](https://i.imgur.com/eqMI5F3.jpg)
- 端口隔离配置
    - `只在同一计算机上起作用`
![vlan端口隔离配置](https://i.imgur.com/B4X46uw.jpg)

## QinQ
- QinQ概述
    - 什么是QinQ
        - 基于802.1Q封装的隧道协议
        - 报文封装双层VLAN Tag
    - QinQ优点
        - 解决日益紧缺的公网VLAN ID资源问题
        - 用户可以规划自己的私网VLAN ID
        - 提供一种较为简单的二层VPN解决方案
        - 使用户网络具有较高的独立性
- QinQ的分类
    - 基于端口的QinQ
    - 灵活QinQ：VLAN Stacking
    - 基于流的灵活QinQ：基于ACL的灵活QinQ
- QinQ配置
    - 基于端口的QinQ配置
    ![基于端口的QinQ配置](https://i.imgur.com/e925ttw.jpg)
    ![基于端口的QinQ配置（续）](https://i.imgur.com/k9BgMGG.jpg)

## STP
- `二层帧没有TTL`
- 选举非根交换机的根端口（`1台交换机的多个端口之间`）
    1. Root ID 小
    2. Designated Cost + self cost 小
    3. Bridge ID 小
    4. Port ID 上游发送接口的Port ID 小
    5. Self Port ID 小
    Port ID 2个字节：第1个字节-priority 取值0-255 默认128 修改大小必须是16的倍数；第2个字节-接口编号
- 选举网段的指定端口（`链路两端的交换机接口之间进行选举` `发送BPDU的端口`）
- Alternate Port（`只能接收BPDU，不能发送`）
- 避免可能的临时环路（forward delay 默认15s）
![stp可能的临时环路](https://i.imgur.com/0OYVmz0.jpg)
![stp端口状态转换](https://i.imgur.com/Rbt31h8.jpg)
![stp端口状态描述](https://i.imgur.com/CDCeWMR.jpg)
- 根桥、根端口、指定端口选举过程
    1. 全局和接口都是自身为root的信息
    2. 接收BPDU对比BPDU中的4个字段和接口记录的STP4个字段
    3. 更新接收接口的信息
    4. 在接口之间PK选最优的
    5. 最优的接口的designated root和自身BID PK（根桥和Root port判断）
    6. 更新全局参数
    7. 选指定端口
    8. 更新指定端口参数
- RSTP
    - 802.1D STP
    - 802.1W RSTP `P/A 提议和同意`
    - 802.1S MSTP
    ![RSTP交换机端口状态](https://i.imgur.com/TxnVGir.jpg)
    - Proposal/Agreement
        - 普通（Cisco）和增强（Huawei增强）
        - A B口变成非边缘DP➡️Discarding➡️发送Proposal BPDU➡️有没有其他的非边缘DP➡️同步（把所有非边缘DP置为discarding）➡️所有非边缘DP发送Proposal
    - `与STP区别`
        - 端口角色 NDP AP BP
        - 转发状态` disable blocking listening=discarding`
        - 边缘端口
        - Proposal/Agreement
        - 次级BPDU（根桥和备份根桥切换）
        - 边缘接口 非边缘接口
        - 点到点链路 共享链路
        - 端口迁移，只要确定无环，立即forwarding（P/A）
        - BPDU flag
        - 只有非边缘接口up才算拓扑变更
        - 不发TCN直接发送TC-BPDU，因此不需要TCA
        - 有邻接关系交换机间3次hello时间没收到对方BPDU，发现拓扑变更
- MSTP
    - `region`
        1. 域名
        2. 修订号
        3. 进程到VLAN的mapping
    - instance0 ISTI 内部生成树实例
    - CIST 混合生成树域
    - 边缘端口特性
        4. 连线后跳过forward delay直接进入forwarding
        5. UP交换机不会发送TC BPDU
        6. 收到TC-BPDU后不会影响接口学习MAC地址的老化计时器
        7. P/A协商过程中不会blocking边缘端口
        8. 不会通过边缘端口泛洪TC-BPDU
        9. 接收配置BPDU后，状态还原常规STP接口

## 802.1x原理与配置
- NAC技术简介
    - PC（接入者）--NAS--ACS（ISE）RADUIS TACACS+命令授权 RBAC
    ![NAC关键组件](https://i.imgur.com/wrIsvNv.jpg)
    - AAA
        - Authentication
        - Authorization
        - Accounting（审计、计费）
    - NAC认证方式
        - 802.1x认证接入（包括旁路认证）
        - MAC地址认证接入
        - Web认证接入
- 802.1x工作原理
    ![8021x体系结构](https://i.imgur.com/BTlrB5J.jpg)
- EAP和EAPOL
    ![EAP数据报](https://i.imgur.com/tpE2sqx.jpg)
    ![EAPOL数据报1](https://i.imgur.com/hfNSAGE.jpg)
    ![EAPOL数据报2](https://i.imgur.com/mmbIWDs.jpg)
    ![EAPOL数据报3](https://i.imgur.com/BmfWMxO.jpg)
- 802.1x协议运行过程
    ![8021x中继方式认证](https://i.imgur.com/N4fUqcR.jpg)
    ![8021x终结方式认证](https://i.imgur.com/20F8uYe.jpg)
- 802.1x业务配置
    ![8021x业务配置基本组网](https://i.imgur.com/Yt7XlXr.jpg)
    ![8021x配置装备](https://i.imgur.com/NTTpmvu.jpg)
    ![8021x业务配置1](https://i.imgur.com/OEtzQkL.jpg)
    ![8021x业务配置2](https://i.imgur.com/aTOytoI.jpg)
    ![8021x业务配置3](https://i.imgur.com/gMqDp1d.jpg)
    ![8021x业务配置4](https://i.imgur.com/2UNJqFQ.jpg)
    ![8021x业务配置5](https://i.imgur.com/S4b1o4n.jpg)
- 802.1x基本故障诊断
    ![8021x故障处理流程](https://i.imgur.com/kORk1yU.jpg)

    ```
    # 查看dot1x是否使能
    [SW]dis dot1x
    [SW]dis dot1x int g2/0/2
    ```

## USG防火墙产品基本功能特性与配置
- 防火墙有3⃣️代：
    1. Router + 自反ACL
    2. 硬件防火墙 包过滤防火墙 第1⃣️代
    3. 代理服务器 PC---FW---Server 第2⃣️代
    4. 状态化分组过滤器 ASPF 第3⃣️代
    5. 下一代防火墙
- 防火墙的基本概念
    - 安全区域
        - `USG防火墙上保留五个安全区域：`
            1. 本地区域（Local）安全优先级100
            2. 受信区（Trust）安全优先级85
            3. 非军事化区（DMZ）安全优先级50
            4. 非受信区（Untrust）安全优先级5
            5. 虚拟区（VZone）安全优先级0
        ![接口 网络和安全区域关系](https://i.imgur.com/muzGRzb.jpg)
    - 防火墙工作模式
        - `路由模式`
        - `透明模式`
        - `混合模式`
    - 会话
- 防火墙关键技术
- 防火墙基本功能
- 防火墙扩展功能

## USG防火墙攻击防范业务特性与配置
- 网络中典型的攻击类型
![网络中典型的攻击类型](https://i.imgur.com/2SknhhD.jpg)
- 攻击防范特性与配置
    - 拒绝服务攻击
    - 畸形报文攻击
        - TCP Flag攻击
        - IP分片攻击
        - Tear Drop攻击
        - Ping of Death攻击
    - 扫描窥探攻击
        - IP Sweep攻击
        - Port Scan攻击
- 防火墙防范的其他报文
    - ICMP Redirect
    - ICMP Unreachable
    - Large ICMP
    - Route Record
    - Tracert

## USG防火墙双机热备业务特性与配置
- 防火墙双机热备份技术分析
    - 防火墙双机热备份技术的特征
        - 控制主、备用防火墙的切换
        - 状态信息的备份
    - USG防火墙的双机热备份技术依靠三种协议实现：
        - VRRP（虚拟路由冗余协议）
        - VGMP（VRRP组管理协议）
        - HRP（华为冗余协议）

## IP QoS概述
- Quality of Service
    - 集成服务模型
        - RSVP 资源预留协议
        - Call Admission Control CAC 呼叫准入控制
    - 区分服务模型
        - 流量分类 acl route-map NLRI 流量标记tag 队列 管制（监管Police）令牌桶算法 流量整形Serial 拥塞避免（WRED TCP RAM Tail Drop）
        - MQC 模块化QoS命令行界面 
            - Class-map 流量分类 
            - Policy-map 标记队列管制整形WRED
            - Service policy
- `端到端时延 = 路径上所有传输时延、处理时延与队列时延之和`
    - 传输时延
    - 处理时延
    - 串行化时延
    - 队列时延 Buffer RAM 软件队列 FIFO CQ PQ WFQ CBWFQ CBLLQ
- `抖动是因为每个包的端到端时延不相等造成的`
- 丢包可能在传输过程的每一个环节发生
- IPv4 Type of Service ToS 8bit  IP Precedence DSCP区分服务码点
    - IP Precedence XXX.....前3bit 取值0-7 
        - IPP0 ToS 0
        - IPP1 ToS 32
        - IPP2 ToS 64
        - IPP3 ToS 96
    - DSCP XXXYY0.. 最低位Y位恒为0
        - Default BE X=0 Y=0
        - Class Selector 向后兼容IP Precedence X不等于0 Y恒等于0
        - Assured Forwarding X=1-4 Y=1-3 X代表优先级 Y代表丢弃优先级
        - Expedited Forwarding X=5 Y=3 10111000
    - DSCP PHB BE CS AF EF DSCP值 ToS字段的值
        - DSCP BE0 00000000 DSCP值0 ToS字段的值0
        - DSCP CS6 11000000 DSCP值48 ToS字段的值192
        - DSCP AF32 01110000 DSCP值28 ToS字段的值112
        - DSCP EF 10111000 DSCP值46 ToS字段的值184

## 流量分类与标记
- 标记方式
    - ipv4/ipv6 ToS/Traffic Class 1Byte
    - 802.1Q｜802.1P 3bit priority CoS
    - MPLS EXP
    - Frame Relay DE
![简单流分类和标记](https://i.imgur.com/vfN6Lvm.jpg)
- 抓所有VoIP媒体流量
   - 都是组播/单播 
   - UDP RTP（实时传输协议） 端口号16384-32767 偶数端口：媒体流量本身 奇数端口：信令流量
       
    ```
    access-list 100 permit udp any any range 16384 32767
    class-map match-any RTP
        match access-group 100
    Policy-map CBMark
        class RTP
            set ip dscp (ef/46)
    ```

## 流量监管与整形
- 管制 Policing    
- `整形只能出站部署` 整形队列
- TB算法 令牌桶算法MIB

## 拥塞管理与拥塞避免
- 拥塞管理 队列 FIFQ CQ PQ WRR WFQ CBWFQ CBLLQ
![队列技术](https://i.imgur.com/xxh9Oir.jpg)
![各种队列调度技术对比](https://i.imgur.com/2tI5E1f.jpg)
- 拥塞避免 Tail Drop RED（随机早期检测） WRED（加权随机早期检测）
- 硬件队列 Bandwidth FIFO
- 软件队列 RAM

## IS-IS
-简介
    - IS 中间系统 OSI 网络设备 IS-IS
    - IGP 支持中到大型网络
    - LS协议 LSP（PDU 协议数据单元）➡️LSDB➡️IP Routing
    - OSI TCP/IP IPv4 IPv6
    - 封装 `Layer 2｜IS-IS｜FCS`
- 理解IS-IS基本原理
    - IS-IS基本概念
        - IS-IS历史
        ![IS-IS历史](https://i.imgur.com/gBCIZAf.jpg)
        - IS-IS地址结构
            - NSAP：长度从8Byte（1Byte 6Byte 1Byte）-20Byte
            
            ```
            IDP（Initial Domain Part）           ｜DSP（Domain Specific Part）
            AFI（组织格式标识符）｜IDI（初始域标识符）｜High Order DSP（高位域指定部分）｜System ID（系统标识符）            ｜NSEL（网络服务选择器）
            1B 45 47 49私有地址｜可变长            ｜区域部分 可变长2B 0001 0002    ｜定长6B MAC或变形IP 1921.6801.0001 ｜1B 00 Protocol Port
            ```
            -`IS-IS的NSAP地址：1AFI+2HODSP+6SID+1NSEL 共10Byte`
        - IS-IS整体拓扑
        ![IS-IS整体拓扑](https://i.imgur.com/KMkkivC.jpg)
            - `OSPF划分区域：一个接口宣告进协议进程的时候 表明一台路由器可以属于一个区域也可以属于多个区域 两台路由器要建邻居必须直连接口宣告进同一个区域`  **任何一根路由器间链路必须属于同一个区域** `Area0是骨干区域`
            - `ISIS划分区域：由NET地址决定 AFI+HODSP来决定` **路由器间的一根链路是可以跨越不同区域的** `没有骨干区域只有骨干链路，由L2和L1/2相连而成的链路 Level1（区域内） Level2（区域间）默认ISIS Type L1/2` `邻居关系也分两种：L1（建立必须要在同一个区域） L2（可以同一个区域也可以跨越区域）`
            - `L1/2路由器 1⃣️L1/2路由器拥有其他区域L2的邻居2⃣️L1/2的L2 LSDB中拥有其他区域的L2 LSP➡️L1 LSP ATT位0置1`
            - `避免非对称路由 ISIS的路由泄露：在边界L1/2路由器上，强制要求把Level2的LSP拷贝一份变成Level1的形式然后通过区域内去发送`
        - IS-IS路由器分类
        ![IS-IS路由器分类](https://i.imgur.com/TtxM84s.jpg)
        - IS-IS网络类型
            - 点到点链路：PPP、HDLC等
            - 广播链路：如Ethernet等
                - DIS：Designated IS指定中间系统
                - 功能：在广播网络实现更高效的数据库同步
                - 选取DIS
                    1. 接口优先级：0-127 默认64
                    2. `比较SNPA（即MAC地址） IS-IS描述设备NSAP 描述接口Circuit-ID电路ID 1Byte system-id.Circuit-ID描述某台设备的某个接口 SNPA描述接口类型 HDLC PPP MAC`
                    3. `选出DIS后，路由器之间仍然会俩俩建邻居 N（N-1）/2`
                - DIS作用
                    - SNP（序号PDU）CSNP（完整序列号PDU类似OSPF DBD）PSNP（部分序列号PDU类似OSPF LSR LSAck）`DIS在收到LSP收录到LSDB然后会每10S发送CSNP（包含它的LSDB中的所有LSP报头）`
                - `DIS可以任意抢占`
                    - `OSPF如果DR、BDR被抢占会造成邻接关系重新建立`
                    - `DR、BDR地址写在OSPF hello报文中，如果改变会造成hello报文不匹配`
                    - DIS只发CSNP，谁发都一样
        - IS-IS报文类型
            - HELLO PDU（IIH）用于建立和维持邻居关系
                - Level-1 LAN IIH（广播）`三次握手类似于OSPF two-way`
                - Level-2 LAN IIH（广播）三次握手
                - P2P IIH（单播）两次握手
            - LSP PDU用于交换链路状态信息
                - Level-1 LSP 区域内交互
                - Level-2 LSP
            - SNP PDU用于维护LSDB的完整与同步，且为摘要信息
                - CSNP
                    - Level 1 CSNP
                    - Level 2 CSNP
                - PSNP
                    - Level 1 PSNP
                    - Level 2 PSNP
    - IS-IS基本原理
        - 形成邻居关系的条件
            - 同一层次
            - 同一区域
            - 同一网段
            - 相同网络类型
            - `邻居建立不传路由：Metric-Style要匹配 度量值类型 Narrow（默认 路径度量值取值范围10bit 0-1023，接口度量值取值范围6bit 0-63） Wide（路径度量值取值范围32bit，接口度量值取值范围24bit）`
    - IS-IS基本特点
        - 路由渗透
        ![IS-IS路由渗透](https://i.imgur.com/YNskgex.jpg)
            - I l1路由
            - I l2路由
            - I ia渗透路由 down bit
        - 路由过载
        ![IS-IS路由过载](https://i.imgur.com/FwuT9l4.jpg)
            - `OL置1 overload过载bit 可用作分片扩展`
    - IS-IS收敛特性
    ![IS-IS收敛特性](https://i.imgur.com/N3omJBK.jpg)
    - IS-IS扩展特性
        - IS-IS认证
            - 认证分类
                - 接口认证
                    - 只对Level-1和Level-2的Hello报文进行认证
                - 区域认证
                    - 对Level-1的SNP和LSP报文进行认证
                - 路由域认证
                    - 对Level-2的SNP和LSP报文进行认证
            - 认证方式
                - Null
                - 明文
                - MD5
        - LSP分片扩展
        ![IS-IS LSP分片扩展](https://i.imgur.com/yjitAWk.jpg)
    - IS-IS管理特性
        - IS-IS管理标记（Tag）
        ![IS-IS管理标记（Tag）](https://i.imgur.com/wbe5Daq.jpg)
- 掌握IS-IS配置命令
![配置IS-IS的基本功能](https://i.imgur.com/7YSHV5Y.jpg)
![配置IS-IS的基本功能（续）](https://i.imgur.com/cDnbdhc.jpg)
![配置IS-IS在不同网络类型中的属性](https://i.imgur.com/erB5o17.jpg)
![配置IS-IS在不同网络类型中的属性（续）](https://i.imgur.com/HidM27M.jpg)
![控制IS-IS路由信息的发布](https://i.imgur.com/ZeFGLso.jpg)
![控制IS-IS路由信息的发布（续）](https://i.imgur.com/YViiv5J.jpg)
![控制IS-IS路由信息的接收](https://i.imgur.com/OfmuhEa.jpg)
![控制IS-IS路由信息的接收（续）](https://i.imgur.com/duArU26.jpg)
![提高IS-IS的安全性](https://i.imgur.com/63Jmg9V.jpg)
![提高IS-IS的安全性（续）](https://i.imgur.com/kKHBlMZ.jpg)
- 提升IS-IS排错能力
![IS-IS故障诊断](https://i.imgur.com/dUC41c0.jpg)
![IS-IS故障排除流程](https://i.imgur.com/lKDbOqe.jpg)
- 加强IS-IS综合运用能力
![IS-IS案例1](https://i.imgur.com/iW2W7PA.jpg)
![IS-IS案例1-需求1](https://i.imgur.com/0ZBoVJh.jpg)
![IS-IS案例1-需求2](https://i.imgur.com/z1n2g3a.jpg)
![IS-IS案例1-需求3](https://i.imgur.com/ijiMcON.jpg)
![IS-IS案例2](https://i.imgur.com/Ldm4KDx.jpg)
![IS-IS案例2-预配](https://i.imgur.com/2LxWkyk.jpg)
![IS-IS案例2-需求1](https://i.imgur.com/SdYt0ns.jpg)
![IS-IS案例2-需求2](https://i.imgur.com/AMLwxe1.jpg)
- 增强应试能力





















        

 
 