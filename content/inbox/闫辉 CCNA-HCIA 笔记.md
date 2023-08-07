# 闫辉 CCNA/HCIA 笔记

- [闫辉 CCNA/HCIA 笔记](#闫辉-ccnahcia-笔记)
  - [基础介绍](#基础介绍)
  - [网络架构](#网络架构)
  - [VLSM](#vlsm)
  - [IP路由基础](#ip路由基础)
  - [OSPF](#ospf)
  - [VLAN](#vlan)
  - [STP-没有冗余连接，交换机工作的先决条件](#stp-没有冗余连接交换机工作的先决条件)
  - [ACL](#acl)
  - [网络地址转换](#网络地址转换)
  - [广域网技术](#广域网技术)
  - [IPv6](#ipv6)
  - [SDN 与 NFV 概述](#sdn-与-nfv-概述)
  - [CCNA综合练习](#ccna综合练习)
  - [HCNA综合实验一](#hcna综合实验一)
  - [HCNA 综合实验二](#hcna-综合实验二)

## 基础介绍
- 电缆 双绞线 网线 100M
- 光缆 光纤 lc `SFP(GBIC)` 1000M
- MLS 3560 3560v2 3560-E 3560-X
- Router： 光纤 MLS NAT PAT
- RFC1918
  - 私有10.0.0.0/8 `A: 最高位必须为0` `0`0000000.X.X.X 8 0-127(其中0、127去除)能用 1.0.0.0-126.0.0.0
  - 私有172.16.0.0/16 172.31.0.0/16 `B: 最高2位为10` `10`000000.X.X.X 16 128.0.0.0-191.255.0.0 
  - 私有192.168.0.0/24 192.168.255.0/24 `C：最高3位为110` `110`00000.X.X.X  24 192.0.0.0-223.255.255.0
- 模拟器
  - GNS3:
  - IOU: VM

## 网络架构
- 园区网：自制系统 AS
    - 接入层
    - 汇聚层
    - 核心层
- 数据层面：
    - 邮政系统
    - 数据封装 OSI TCP/IP
    - 地址信息： `（IPv4｜IPv6）护照`
    - 手工配置：x.x.x.x 32bit 点分十进制 X:X:X:X:X:X:X:X 128bit
    - 国内：网段内 二层地址 广播域
    - 自动获取：DHCP协议
    - 2层：数据链路层 Switch （不能识别3层地址信息）
        - LAN：Ethernet 以太网 90% 双绞线 100m 同轴电缆 光线 100KM
            - `MAC：Media Access Control ROM：只读存储器`
            - IANA：XXXX.XXXX.XXXX 0000.0C（Cisco）
        - WAN：PPPoE 
    - 3层：网络层 Router
        - AQ BQ ➡️ SMAC DMAC｜SIP DIP｜SPORT DPORT｜payload｜`FCS（帧校验序列）`
        - 二层转发CAM表（MAC地址表）MAC➡️interface映射 `关注去往一个主机该怎么走`
        - 三层转发 IPv4 Unicast Routing：16W条  前缀 掩码 出站接口 下一跳地址 `度量值` `管理距离（0-255）：值越小代表路由获悉方式越可靠` `关注去往一个网段该怎么走`
        - `直连路由`
        - `非直连路由`
        - 静态：
        - 动态路由选择协议：RIP EIGRP OSPF ISIS BGP
    - 子网化：10.1.1.1/24
    - 网络中存在3种数据：数据比例6:2:2 
        - Unicast 
        - Multicast 
        - Broadcast
    - Next-hop：`1台三层网络设备就是1跳` `直连就是经过0跳` 
- 控制层面
    - Switch：CAM表（`自动学习`） 数据帧Frame
        - VLAN 
            - Access接入接口
            - Trunk中继接口
        - MAC地址
        - interface
        - CAM表自动学习：STP➡️工作状态：Blocking（初识状态） Listening `自动学习前提➡️Learning Forwarding（转发状态）`
        - `收集信息: SMAC interface vlan` 300s(刷新)
        - 泛洪：Flooding（组播、广播必泛洪）
        - 冗余：Redundancy
        - `静态MAC表项优先级高于动态MAC表项`
        - `广播域和网段可以理解为同一个概念`
        - SVI: switch vlan interface（逻辑接口）
    - Router：精确转发
        - 直连路由获悉：`IP地址（up up）` up down(物理层OK，数据链路层down) down down（物理层、数据链层down）administratively down（管理型down，人为shutdown）
        - 包含三要素：前缀 掩码 出站接口 10.1.1.0/24 ethernet 0/1 `管理距离0（协议最可靠）` 
        - 非直连路由获悉：
            1. IGP（内部网关协议）：RIP EIGRP OSPF IS-IS EGP（外部网关协议）AS EGP BGP
            2. DV（距离矢量） LS（链路状态）LSDB SPF
            3. Classful（有类）FLSM classless（无类）VLSM/CIDR
            4. `比较管理距离➡️比较度量值➡️ECMP：等价负载均衡`
    - 路由器三种交换机制
        - 进程交换 最长匹配原则
        - 快速交换
        - CEF（Cisco极速转发）
    - `no ip routing 关闭路由功能，就变成1台pc`
- Protocol suit 协议栈 OSI TCP/IP IPX/SPX Appletalk
    - OSI 1978
      1. 物理层 TIA/EIA 
         - 双绞线 568B 568A
           - 直通线 非同类设备
           - 交叉线 同类设备
      2. 数据链路层 Ethernet（`封装标准：EthernetII私有协议（数据层面）type支持插入式封装（主要封装vlan） IEEE 802.3公有协议（控制层面）length不支持插入式封装`） PPPoE
         - `中继封装协议： ISL（Cisco私有）添加帧头帧尾（已淘汰） ISL｜Frame｜ISL 802.1Q`
         - STP PvST BPDU 扩展系统ID BID 8byte➡️ 2（优先级）byte➡️4bit（优先级） 12bit（扩展系统ID）`告诉接收者你收到的BPDU是来自哪个vlan的` 6byte（地址）
      3. 网络层 IPv4 IPv6
      4. 传输层 `MTU` 1500byte `Jumbo MTU` 9216 `数据切片` header TCP UDP
      5. 会话层 
      6. 表示层
      7. 应用层
    - TCP/IP 
    - DHCP
      - `0.0.0.0 未指定地址` `255.255.255.255 全向广播地址` `FFFF.FFFF.FFFF 全向广播MAC地址`
      - `Ethernet2(SMAC 本机MAC DMAC FFFF.FFFF.FFFF)|IPv4(SIP 0.0.0.0 DIP 255.255.255.255)|UDP（SPORT 67 DPORT 68）|DHCP|FCS`
    - ICMP：工具集ping echo-request—————echo-reply
- Router DHCP配置
  - R1-DHCP Server
  
    ```
    en
    show privilege
    show ip int brief
    conf t
    int fa 0/0
    no shutdown
    ip adds 123.1.1.1 255.255.255.0
    do show ip interface brief
    end
    conf t
    service dhcp
    ip dhcp pool R123
    network 123.1.1.0 255.255.255.0
    default-router 123.1.1.1
    dns-server 123.1.1.1
    lease 1 0 0(配置租期1天又0个小时又0分钟)
    domain-name cisco.com(配置域名)
    exit
    ip host R1 123.1.1.1(IP地址映射)
    ip host R2 123.1.1.2
    ip host R3 123.1.1.3
    ip domain-lookup(开启域名解析功能，默认关闭)
    ip name-server
    show run | section dhcp
    ```
    - R2|R3-DHCP Client
    
    ```
    en
    conf t
    no ip routing
    int fa 0/0
    no shutdown
    ip address dhcp
    show ip interface breif
    show run interface fa 0/0
    ip domain-lookup`
    ```

- L3 Switch DHCP配置
    - SW1-DHCP Server
    
    ```
    hostname SW1
    vlan 10
    exit
    interface range ethernet 0/0 - 1
    switchport mode access
    switchport access vlan 10
    exit
    interface vlan 10
    no shutdown
    ip address 10.1.1.6 255.255.255.0
    exit
    service dhcp
    ip dhcp pool VLAN10
    network 10.1.1.0 255.255.255.0
    default-router 10.1.1.6
    dns-server 10.1.1.6
    domain-name cisco.com
    ```
    
    - R1|R2-dhcp Client
  
    ```
    enable
    conf t
    hostname R1|R2
    int ethernet 0/0
    no shutdown
    ip address dhcp
    end
    ping 10.1.1.6
    ping 10.1.1.2|10.1.1.1
    ```

- dhcp中继-网关接口收到广播dhcp discovery报文转变为单播发送给dhcp服务器
    - R1-网关
    
    ```
    enable
    conf t
    int fa 0/0
    no shutdown
    ip address 12.1.1.1 255.255.255.0
    exit
    int fa 0/1
    ip address 13.1.1.1 255.255.255.0
    exit
    int fa 0/0
    ip help-address 13.1.1.3
    ```
    - R2-PC
    
    ```
    enable
    conf t
    no ip routing
    int fa 0/1
    no shutdown
    ip address dhcp
    ```
    - R3-dhcp server
    
    ``` 
    enable
    conf t
    no ip routing
    int fa 0/0
    ip address 13.1.1.3 255.255.255.0
    no shutdown
    exit
    service dhcp
    ip dhcp pool VLAN12
    network 12.1.1.0 255.255.255.0(网段池)
    default-router 12.1.1.1
    dns-server 12.1.1.1
    domain-name cisco.com
    exit
    ```
- dhcp主机池

    - R3-dhcp server
    
    ```
    show run | section dhcp
    ip dhcp pool Printer
    host 12.1.1.200 255.255.255.0
    default-router 12.1.1.1
    dns-server 12.1.1.1
    domain-name cisco.com
    client-id 01ca.0241.4000.06
    ```
    - R2-printer
    
    ```
    int fa 0/1
    ip addr dhcp client-id fa 0/1
    exit
    01ca.0241.4000.06(client-id在dhcp服务器上配置)
    ```

## VLSM


## IP路由基础
- 路由6要素
    - 目的网络
    - 掩码
    - 出接口
    - `下一跳`
        - `直连路由 没有度量值`
        - 非直连路由
    - `Cost metric 度量值（越小越好）` `静态路由没有度量值`
    - `Preference 优先级 AD 管理距离 范围0-255`
- ECMP 等价负载均衡
- 模糊匹配
    - 使用路由表中的所有路由条目 逐条匹配数据包的DIP
- 静态路由
    - `出接口所连网络2种类型：`
        - MA 多路访问 `下一跳不定` 
        - P2P 点到点 `下一跳固定`
- 动态路由协议
    - `IGP：RIP EIGRP OSPF IS-IS`
    - `EGP：BGP`
    - `DV 距离矢量协议-基于传闻 RIP EIGRP BGP`
        - `路由更新信息包含：网络号 掩码 下一跳地址 度量值`
        - `Classful：网络号 度量值`
        - Classless
  - `LS 链路状态协议-基于拓扑 OSPF IS-IS`
- CIDR
    - 路由汇总 Summary
        - 172.16.0.0/24
        - 172.16.1.0/24
        - 172.16.0.0/23
    - 路由聚合 Aggregation
        - 192.168.0.0/24
        - 192.168.1.0/24
        - `192.168.0.0/23 超网路由`
    - `汇总不明细会出现路由黑洞和路由环路`
        - 172.16.1.0/24
        - 172.16.2.0/24
        - `172.16.0.0/22 汇总后多了172.16.0.0/24和172.16.3.0/24`
    
## OSPF
- 三张表
    - 邻居表-邻居的名字，拿什么接口跟我连接，接口的IP地址，邻居关系状态
        - `display ospf peer`
    - LSDB
        - `display ospf lsdb 只能看lsa报头`
    - 路由表
        - `display ospf routing`
        - `display ip routing-table protocol ospf`
- 度量值
    - `缺省时接口Cost值=100Mbit/s/接口带宽。其中100Mbit/s为OSPF指定的缺省参考值，该值是可配置的。`
    - `封装：Layer 2｜IPv4|OSPF|FCS`
- 协议报文类型
    - Hello:周期性发送，用来发现和维护OSPF邻居关系
        - `只交互hello报文 邻居状态 Two-way`
        - `五种报文都交互完了 邻接状态 Full 只有Full状态才能自由交互LSA` 
    - Database Description:描述本地LSDB的摘要信息，用于两台设备进行数据库同步；`交互LSA报头`
        - 确认机制
            - `显式确认 DBD ACK`
            - `隐式确认 DBD（序列号100） DBD（序列号100）` Master/Slave
    - Link State Request:用于向对方请求所需要的LSA。设备只有在OSPF邻居双方成功交换DD报文后才会向对方发出LSA报文。
    - Link State Update:用于向对方发送其所需要的LSA。
    - Link State ACK:用来对收到的LSA进行确认。
- OSPF路由器之间的关系
    - 初识OSPF邻接关系建立过程
        1. `建立双向邻居关系` Init➡️Two-way（`看Neighbor字段是否包含自身的router-id判断`）
        2. `协商主/从（Master/Slave）`
        3. `相互描述各自的LSDB（摘要信息）`
        4. `更新LSA，同步双方LSDB`
    ![闫辉HCNAospf邻接1](https://i.imgur.com/FTIeRlr.png)   
    ![闫辉HCNAospf邻接2-3](https://i.imgur.com/rHpUYDC.png)
    ![闫辉HCNAospf邻接4](https://i.imgur.com/CjHwzYB.png)
- OSPF网络类型简介
    - broadcast
    - nbma FR主接口和多点子接口
    - p2mp
    - p2p
    - `更改接口网络类型：[g0/0/0]ospf network-type xx`
- DR 与 BDR
    - `第一个到达Two-way的路由器宣布选举开始`
    - `每个网络的DR与BDR之间没有关系`
- OSPF多区域
    - `基于路由器接口来划分`
    - 区域内路由器(Internal Router)
    - 区域边界路由器ABR(Area Border Router)
    - `骨干路由器 (Backbone Router) ABR也是BR`
    - 自治系统边界路由器ASBR (AS Boundary Router)
    - `链路翻动 Flapping-接口一会up一会down`
    - `在区域边界可以做路由汇总，减小了路由表规模`
- 基础配置命令
    - `[g0/0/0]ospf cost xx 配置OSPF接口开销`
    - `[ospf-1]bandwidth-reference value` `设置OSPF带宽参考值，取值范围1-2147483648`
    - `[g0/0/0]ospf dr-priority xx 设置接口在选举DR时的优先级,取值范围0-255`

## VLAN

- 设计欠佳的网络中存在的问题
    - 较大的广播域
    - 可能存在安全漏洞
- Virtual Local Area Network
    1. Access 模式 `必须要关联一个vlan(缺省vlan1)`
    2. Trunk 模式
    3. `交换机泛洪：基于VLAN的泛洪`
    4. `多一个vlan，多一个cam表`
- 创建VLAN 
    - `不影响running-config startup-config` 
    - 独立存在于`VLAN DATABASE` 
    - `vlan.dat放在Flash（交换机路由器硬盘中，断电不会消失）中`
    - `Delete flash:vlan.dat（删除 vlan 配置）` 
    - `删除后还存在 vlan 1 1002-1005 5个 vlan`
    - `可以创建的vlan 1-1005 标准VLAN 1006-4094 扩展VLAN(创建前提：要支持3层功能（SVI）；VTP version 3/VTP 模式Transparent)`
- VLAN1 Default management native DTP(思科私有)
    - `show vlan brief`
    - `show mac address-table`
    - `接口组配置`
        - interface range ethernet 0/2 -3 连续
        - interface range ethernet 0/2, ethernet 0/3 不连续
        - switchport mode access
        - switchort acces vlan 10
  - SVI: Switch VLAN Interface
- Trunk 802.1Q(`native vlan通过 trunk 接口不用打vlan tag`) 1-4094
    - 中继封装协议：802.1Q `native vlan本证VLAN 1` 
    - interface range ethernet 2/0 -3
    - `switchport trunk encapsulation dot1q(中继封装协议)`
    - switchport mode trunk
    - `switchport trunk allowed vlan 1-100`
    - no shutdown
    - `show interfaces trunk`
- Data vlan 10 Voci vlan 20 Switch—IP电话—PC trunk mini trunk CDP
    - trunk
        - interface fa0/1
        - switchport trunk encapsulation dot1q
        - switchport mode trunk
        - switchport voice vlan 20
        - switchport trunk native vlan 10
        - no shutdown
    - mini-trunk
        - interface fa0/1
        - `default interface fa 0/1(还原接口配置)`
        - switchport mode access
        - switchport access vlan 10
        - switchport voice vlan 20
        - no shutdown
- `cam表 Aging timer: 300s` 
- VTP-交换机之间自动同步VLAN信息
    - 封装：802.3|VTP|FCS
    - `前提条件：相同的VTP域名、相同的VTP密码`
    - `域名默认为空 Null，为空时VTP域名可以同步`
    - VTP模式
        - server：创建、修改、删除、发送和转发通告、同步；
        - client：无法创建、修改和删除VLAN，发送和转发通告，同步；
        - transparent：仅创建、修改和删除本地VLAN，转发通告，不进行同步。
    - 配置
        - vtp mode server|client|transparent｜off
        - vtp domain xx
        - vtp password xx（可选配置）`show vtp password`
        - vtp version（默认版本1，server模式可以修改，transparent模式可以修改）
        - `重置配置修订号，保证新加入域的client交换机配置修订号<server交换机`
            1. VTP模式设置为透明模式：0
            2. 修改VTP域名：cisco➡️cisco123
        - en
        - show vlan brief
        - show vtp status
        - SW1(config)#int range e2/0-3, e3/0-1 
        - SW1(config-if-range)#switchport trunk encapsulation dot1q
        - SW1(config-if-range)#switchport mode trunk
        - SW1(config-if-range)#no shutdown
        - SW1(config-if-range)#exit
        - SW1(config)#end
        - SW1#show interfaces trunk
        - SW3#(config)#vtp domain CCIE
        - SW3#(config)#end
        - SW3#show vtp status
        - SW3(config)#vtp password cisco
        - SW3(config)#`vtp version 2`
        - SW3(config)#`vtp pruning`
        - SW1(config)#vtp password cisco
        - SW1(config)#`vtp mode client`
    - VTP修剪
        - vtp prunning（server和transparent模式下开启）
- `交换机怎么部署VLAN、Access、Trunk、VTP`
    - Trunk➡️VTP➡️VLAN➡️Access

## STP-没有冗余连接，交换机工作的先决条件
* 3种协议
  * IEEE 802.1D STP-初始收敛30s，重新收敛30-50s
  * IEEE 802.1W RSTP-初始收敛快，链路出现问题时，重新收敛也很快
  * IEEE 802.1S MSTP
* 2nd generation Ethernet
  * Fabricpath 借鉴 MPLS VPN
* **用作配置路由协议的交换机物理接口关闭生成树协议**

## ACL
- Security-zone 安全领域（安全区域）
- Trust
- Untrust
- DMZ非军事化区域
- 作用
  - 流量过滤
  - 流量（路由）抓取 permit代表抓取 deny代表不抓取
- 基本 ACL（三层工具）`只关注源ip` `尽可能靠近流量的目的地去部署`

    ```
    acl number 2000
    rule 10 deny source 172.16.10.0 0.0.0.255
    rule 15 permit 
    ```
- 高级 ACL（三层加四层工具）`尽可能靠近流量的信源来部署`
    - `rule 5 permit ip source 10.1.1.0 0.0.0.255 destination 10.1.3.0 0.0.0.255` 协议字段为`ip`表明匹配所有协议号
    - `rule 10 permit tcp source 10.1.2.0 0.0.0.255 destination 10.1.3.0 0.0.0.255 destintation-port eq 21`
- ACL 里的每个语句成为 `ACE`-Access Control Entry 一个策略语句
    - 一股流量任何 ACE 都不能匹配上，`思科直接丢弃，华为自然处理`
- `自顶向下的匹配流程 一经匹配立即执行策略`
- `路由协议中反码要连续，ACL 中反码不用连续`
    - `rule 40 deny 192.168.1.1 0.0.0.254` 匹配子网中的奇数IP地址
- 在路由策略中被调用
    - 一种是 ACL 
    - 一种是 前缀列表
- ACL 的匹配位置
    - inbound（入站）方向
    - outbound（出站）方向：`只会过滤穿越流量，不会过滤始发流量`

## 网络地址转换
- NAT `不能实现复用`
    - 静态 NAT `内网和公网都能相互访问`
    - 动态 NAT
- PAT `能实现复用`
    - NAPT

    ```
    [R1]nat address-group 1 122.1.2.1 122.1.2.1
    [R1]acl 2000
    [R1-acl-basic-2000]rule 5 permit source 192.168.1.0 0.0.0.255
    [R1-acl-basic-2000]quit
    [R1]int g0/0/1
    [R1-g0/0/1]nat outbound 2000 address-group 1
    ```
    
    - Easy-IP
    - NAT Server 静态PAT
    
    ```
    [R1]int g0/0/1
    [R1-g0/0/1]ip add 122.1.2.1 24
    [R1-g0/0/1]nat server protocol tcp global 122.1.2.1 www inside 192.168.1.10 8080
    ```

## 广域网技术
- 狭义和广义的 WAN 定义
    - 局域网：Ethernet Token Ring FDDI
    - 广域网：HDLC PPP Frame Relay
    - VPN IPSec L2TP PPTP DMVPN DSVPN GRE SSL GETVPN
    - 专线 MPLS VPN
    - Serial 异步 同步
- PPP 协议
    - 发包地址是 FFFF.FFFF.FFFF
    - ISP：Internet Service Provider 
    - PE：Provider Edge 运营商边界
    - CE：Customer Edge 用户边缘设备
    - PPP 协议伞包含的子协议及其工作原理
        - `LCP（链路控制协议）`
        - `PAP/CHAP（链路级认证）`
            - PAP（Password Authentication Protocol）密码认证协议
            - CHAP （Challenge Handshake Authentication Protocol） 挑战握手认证协议
        - `NCP（网络控制协议）众多协议组合而成`
            - IPCP 上层如果用 IPv4 协议
            - IPv6CP
            - IPXCP
            - ARPCP
            - CLNPCP
    - PPP 链路建立流程
        - 链路层协商：通过 LCP 报文进行链路参数协商，建立链路层连接
        - 认证协商（可选）：通过链路建立阶段协商的认证方式进行链路认证
        - 网络层协商：通过 NCP 协商来选择和配置一个网络层协议并进行网络层参数协商
      ![PPP链路状态接口机](https://i.imgur.com/3E5cZS6.jpg)
    - LCP 报文格式
        - `Flag(0x7E)|Address(0xFF)|Control(0x03)|Protocol(0xC021)|Information(0-1500Byte)|FCS(4Byte)|Flag(0x7E)`
        - 当 Protocol 字段为 0xC021 时，代表是 LCP 报文。
        - `Protocol 字段值：`
            - 0x0021:IP报文
            - 0x8021:IPCP报文
            - 0xC021:LCP报文
            - 0xC023:PAP报文
            - 0xC223:CHAP报文
        - `Information Code字段值：`
            - 0x01:Configure-Request 配置请求报文
            - 0x02:Configure-Ack 配置成功报文
            - 0x03:Configure-Nak 配置参数需协商
            - 0x04:Configure-Reject 配置参数不识别
        - `Information Data字段值：`
            - TLV 类型长度值 包含LCP协商过程中常用的参数，例如 MRU、认证协议和魔术字等
    - LCP 协商过程
        - 协商参数
            - `MRU：最大接收单元 一般1500Byte`
            - `Magic Number魔术字 防环`
            - 要不要做认证 使用 PAP 还是使用 CHAP
            - QP Qos
            - Multi-link
    - PPP 认证模式 - PAP
        - `PAP 认证双方有两次握手。协商报文以明文的形式在链路上传输`
    - PPP 认证模式 - CHAP
        - `CHAP 认证双方有三次握手。协商报文被加密后再在链路上传输`
        - MD5 信息摘要5算法 散列算法 哈希算法
            1. 不定长输入定长输出
            2. 不可逆
            3. 雪崩效应
    - NCP 协商
        - 静态IP地址协商
        - 动态IP地址协商
        - `Peer neighbor-route` 隶属于 IPCP
            - `有地址，并且地址不冲突就能协商通过`
            - 1.1.1.1/24 2.2.2.2/24
            - `Peer neighbor-route 属性会自动产生一条32位主机路由指向对端接口地址`
                - 1.1.1.1/24 会自动形成一条 2.2.2.2/32主机路由指向对端
                - 2.2.2.2/24 会自动形成一条 1.1.1.1/32主机路由指向对端
                - `属性关闭后就ping不通了`
    - PAP 认证配置命令
        - `验证方`
            - [s0/0/0]link-protocol ppp
            - [aaa]local-user *user-name* password cipher *password*
            - [aaa]local-user *user-name* service-type ppp
            - [s0/0/0]ppp authentication-mode pap
        - `被验证方`
            - [s0/0/0]ppp pap local-user *user-name* password cipher *password*
    - CHAP 认证配置命令
        - `验证方`
            - [s0/0/0]link-protocol ppp
            - [aaa]local-user *user-name* password cipher *password*
            - [aaa]local-user *user-name* service-type ppp
            - [s0/0/0]ppp authentication-mode chap
        - `被验证方`
            - [s0/0/0]ppp chap user *user-name*
            - [s0/0/0]ppp chap password cipher *password*
- 什么是 PPPoE
    - `PPP 帧结构`
        - Flag|Address|Control|Protocol|Information|FCS|Flag
    - `PPPoE 帧结构`
        - DMAC|SMAC|Eth-Type|PPPoE-Packet|FCS
    - `XoY 技术 先封装X再封装Y`
    - PPPoE 会话建立
        - PPPoE 发现：PPPoE 协商 用户接入，创建PPPoE虚拟链路
        - PPPoE 会话：PPP 协商 协商内容包括 LCP 协商、PPP/CHAP认证、NCP协商等阶段
        - PPPoE 终结：PPPoE 断开 用户下线，客户端断开连接或者服务器端断开连接
    - PPPoE-Header
    ![PPPoE报文](https://i.imgur.com/QfMS9aE.jpg)
    - PPPoE发现阶段
    ![PPPoE发现阶段](https://i.imgur.com/8i7EYkl.jpg)
    - PPPoE会话阶段
    - PPPoE会话终结阶段

## IPv6
- IPv6 优势
    - `「无限」地址空间` 地址长度为 128 bit，海量的地址空间，满足物联网等新兴业务、有利于业务演进及扩展
    - `层次化的地址结构` 相较于IPv4地址，IPv6地址的分配更加规范，利于路由聚合（缩减IPv6路由表规模）、路由快速查询
    - `即插即用` IPv6支持无状态地址自动分配（SLAAC），终端接入更简单
    - `简化的报文头部` 简化报文头，提高效率；通过扩展包头支持新应用，利于路由器等网络设备的转发处理，降低投资成本
    - `安全特性` IPSec、真实源地址认证等保证端到端安全；避免NAT破坏端到端通信的完整性
    - `移动性` 对移动网络实时通信有较大改进，整个移动网络性能有比较大的提升
    - `增强的Qos特性` 额外定义了流标签字段，可为应用程序或者终端所用，针对特殊的服务和数据流，分配特定的资源
- `IPv6 一个主机获得地址的方式`
    - 手工配置 静态地址
    - 动态地址 
        - `DHCPv6` 有状态地址自动配置
        - `NDP` 无状态地址自动配置 
            - `交互报文： RS（路由器请求） RA（路由器通告）`
- IPv6 基本报头
![IPv6基本报头](https://i.imgur.com/7w4Hh8p.jpg)
- IPv6 地址
    - `IPv6 前64位 前缀 后64位 接口ID`
    - IPv6 地址缩写规范
    ![IPv6地址缩写规范](https://i.imgur.com/hECJBsI.jpg)
- `IPv6 地址分类`
    - `组播地址`
        - **8bit(11111111)|4bit(Flags)|4bit(Scope)|80bit(Reserved必须为0)|32bit(Group ID)**
            - FLags:用来表示永久或临时组播组 `0永久 1临时`
            - Scope：表示组播组的范围
            - Group ID：组播组ID
            - `被请求节点组播地址（对应IPv4广播地址）`
                - **104bit(固定前缀)FF02:0000:0000:0000:0000:0001:FF|24bit(IPv6单播或任意播地址)**
                - PCA--SW1--PCB `IPv6地址到MAC地址解析 通过ICMPv6 NDP`
                - `NDP包括2种报文：NS邻居请求 NA邻居通告`
            - `组播IPv6地址跟组播MAC地址一一对应`
                - 组播MAC地址：`3333:XXXX：XXXX（组播IPv6地址后32bit加上3333）`
            - 主机A跟主机B通信
                1. 根据B IPv6单播地址➡️B 被请求节点组播地址
                2. B 被请求节点组播地址➡️B 组播MAC地址
                3. A NS报文发出➡️B 形成 A 的映射表项
                4. B 单播回复 NA➡️A 形成 B 的映射表项
            - `224.0.0.1 所有节点组播 对应IPv6 FF02::1`
            - `224.0.0.2 所有路由器组播 对应IPv6 FF02::2`
    - `单播地址`
        - `GUA(Global Unicast Address）全球单播地址 所谓公有地址` 
            - `2000::/3 2000:: - 3FFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF `
            - 常用地址 `开头2001 正常IPv6地址` `开头2002 隧道专用地址`
        - `ULA(Unique Local Address) 唯一本地地址 所谓IPv6私有地址`
            -  `FD00::/8` **8bit(11111101)|40bit(Global ID伪随机产生)|16bit(子网ID)|64bit(接口标识)**
        - `LLA(Link-Local Address）链路本地地址`
            - **IPv6 一个接口可以同时拥有多个地址 LLA有且只有一个 GUA可以同时有多个（没有、1个、多个都可以）**
            - `FE80::/10`**10bit(1111111010)|54bit(固定为0)|64bit(接口标识）**
            - EUI64(64位扩展通用标识符) 方式生成 LLA 后64位
            ![IPv6单播地址接口标识](https://i.imgur.com/Tt0kzKn.jpg)

        - `特殊地址`
        - `其他单播地址……` 
    - `任播地址`
        - `一对最近`
        - 一个 GUA 地址同时提供给提供相同服务的多个服务器使用
- 主机和路由器的 IPv6 地址
![主机和路由器的IPv6地址](https://i.imgur.com/InaA9ZS.jpg)
- IPv6 单播地址业务流程
    - 一个接口在发送 IPv6 报文之前要经历地址配置、DAD、地址解析这三个阶段，NDP（Neighbor Discovery Protocol，邻居发现协议）扮演了重要角色
        - 地址配置：全球单播地址和链路本地地址是接口上最常见的IPv6单播地址，一个接口上可以配置多个IPv6地址
            - 全球单播地址：手工配置、无状态自动配置（NDP）、有状态自动配置（DHCPv6）
            - 链路本地地址：手工配置、系统生成、根据EUI-64规范动态生成
        - DAD（Duplicate Address Detection，重复地址检测）类似于IPv4中的免费ARP检测，用于检测当前地址是否与其他接口冲突 `通过免费NS`
        - 地址解析：类似于IPv4中的ARP请求，通过ICMPv6报文形成IPv6地址与数据链路层地址（一般是MAC地址）的映射关系
        - IPv6 数据转发
    - NDP
    ![NDP](https://i.imgur.com/midvuKg.jpg)
    - IPv6 动态地址配置
    ![IPv6动态地址配置](https://i.imgur.com/L4tTSgK.jpg)
    - DAD
    ![IPv6DAD](https://i.imgur.com/mPI7B2V.jpg)
    - 地址解析
    ![IPv6地址解析](https://i.imgur.com/JTRSiCo.jpg)
- IPv6 基本配置
    1.使能IPv6
    
    ```
    []ipv6
    [g0/0/0]ipv6 enable
    ```
    2.配置接口的链路本地地址
    
    ```
    [g0/0/0]ipv6 add ipv6-address link-local
    [g0/0/0]ipv6 address auto link-local
    ```
    3.配置接口的全球单播地址
    
    ```
    [g0/0/0]ipv6 address {ipv6-address prefix-length | ipv6-address/prefix-length}
    [g0/0/0]ipv6 address auto {global|dhcp}
    ```
    4.配置IPv6静态路由
    
    ```
    []ipv6 route-static dest-ipv6-address prefix-length {interface-type interface-number [nexthop-ipv6-address]|nexthop-ipv6-address} [preference preference]
    ```
    5.查看接口的IPv6信息
    
    ```
    []dis ipv6 interface [interface-type interface-number | brief]
    ```
    6.查看邻居表项信息
    
    ```
    []dis ipv6 neighbors
    ```
    7.使能系统发布RA报文功能
    
    ```
    [g0/0/0]undo ipv6 nd ra halt
    ```
- 案例：配置一个小型 IPv6 网络
![配置一个小型IPv6网络1](https://i.imgur.com/z8RvAW7.jpg)
![配置一个小型IPv6网络2](https://i.imgur.com/WkYyFDb.jpg)
![配置一个小型IPv6网络3](https://i.imgur.com/wlILprp.jpg)
![配置一个小型IPV6网络4](https://i.imgur.com/lY3pwYl.jpg)

## SDN 与 NFV 概述
- SDN 起源提出了三个特征：转控分离、集中控制和开放可编程接口
- NFV(Network Functions Virtualization,网络功能虚拟化)
 
## CCNA综合练习
![闫辉ccna综合练习拓扑](https://i.imgur.com/eg381i1.png)
- 配置
  - R1
  
    ```
    #en
    #conf t
    (config)#interface lo0
    (config-if)#ip add 1.1.1.1 255.255.255.0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#int ser1/1
    (config-if)#no shutdown
    (config-if)#ip add 13.1.1.1 255.255.255.0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#int ser1/0
    (config-if)#no shutdown
    (config-if)#ip add 12.1.1.1 255.255.255.0
    (config-if)#no shutdown
    (config)#router eigrp CCIE
    (config-router)#address-family ipv4 unicast autonomous-system 90
    (config-router-af)#eigrp router-id 1.1.1.1
    (config-router-af)#no shutdown
    (config-router-af)#network 1.1.1.1 0.0.0.0
    (config-router-af)#network 12.1.1.1 0.0.0.0
    (config-router-af)#network 13.1.1.1 0.0.0.0
    (config-router-af)#topology base
    (config-router-af-topology)#no auto-summary
    (config-router-af-topology)#end
    #show ip route eigrp
    ```
    - R2
    
    ```
    (config)#int ser1/1
    (config)#no shutdown
    (config-if)#ip add 12.1.1.2 255.255.255.0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#interface lo0
    (config-if)#ip add 2.2.2.2 255.255.255.0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#router eigrp CCIE
    (config-router)#address-family ipv4 unicast autonomous-system 90
    (config-router-af)#eigrp router-id 2.2.2.2
    (config-router-af)#no shutdown
    (config-router-af)#network 2.2.2.2 0.0.0.0
    (config-router-af)#network 12.1.1.2 0.0.0.0
    (config-router-af)#topology base
    (config-router-af-topology)#no auto-summary
    (config-router-af-topology)#end
    #show ip route eigrp
    #conf t
    (config)#int fa 0/0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#int fa 0/0.4
    (config-subif)#encapsulation dot1Q 4
    (config-subif)#ip add 172.16.4.254 255.255.255.0
    (config-subif)#no shutdown
    (config-subif)#exit
    (config)#int fa 0/0.6
    (config-subif)#encapsulation dot1Q 6
    (config-subif)#ip add 172.16.6.254 255.255.255.0
    (config-subif)#no shutdown
    (config-subif)#exit
    (config)#service dhcp
    (config)#ip dhcp pool R4
    (dhcp-config)#host 172.16.4.4 255.255.255.0
    (dhcp-config)#client-identifier 01ca.0437.e800.08 R4的clientid
    (dhcp-config)#default-router 172.16.4.254
    (dhcp-config)#dns-server 8.8.8.8
    (dhcp-config)#domain-name cisco.com
    (dhcp-config)#exit
    (config)#ip dhcp pool R6
    (dhcp-config)#host 172.16.6.6 255.255.255.0
    (dhcp-config)#client-identifier 01ca.063b.a000.08 R6的clientid
    (dhcp-config)#default-router 172.16.6.254
    (dhcp-config)#dns-server 8.8.8.8
    (dhcp-config)#domain-name cisco.com
    (dhcp-config)#exit
    (config)#interface s1/1
    (config-if)#ip nat outside
    (config-if)#exit
    (config)#int fa 0/0.4
    (config-subif)#ip nat inside
    (config-subif)#int fa 0/0.6
    (config-subif)#ip nat inside
    (config-subif)#exit
    (config)#access-list 10 permit 172.16.4.0 0.0.0.255
    (config)#access-list 10 permit 172.16.6.0 0.0.0.255
    (config)#ip nat inside source list 10 interface serial 1/1 overload
    (config)#interface tunnel 2
    (config-if)#tunnel source 12.1.1.2
    (config-if)#tunnel destination 13.1.1.3
    (config-if)#ip add 10.1.1.2 255.255.255.0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#do ping 10.1.1.3
    (config)#crypto isakmp key cisco address 0.0.0.0
    (config)#cyrpto isakmp policy 10
    (config-isakmp)#encryption aes
    (config-isakmp)#authentication pre-share
    (config-isakmp)#hash sha
    (config-isakmp)#group 5
    (config-isakmp)#exit
    (config)#end
    #show run | section isakmp
    #conf t
    (config)#crypto ipsec transform-set TEST esp-aes esp-md5-hmac
    (cfg-crypto-trans)#mode transport
    (cfg-crypto-trans)#exit
    (config)#crypto ipsec profile R2
    (ipsec-profile)#set transform-set TEST
    (ipsec-profile)#exit
    (config)#int tunnel 2
    (config-if)#tunnel protection ipsec profile R2
    (config-if)#exit
    (config)#router ospf 110
    (config-router)#router-id 2.2.2.2
    (config-router)#network 10.1.1.2 0.0.0.0 area 0
    (config-router)#network 172.16.4.254 0.0.0.0 area 0
    (config-router)#network 172.16.6.254 0.0.0.0 area 0
    (config-router)#end
    #show ip route ospf
    ```
    - R3
    
    ```
    (config)#int ser1/0
    (config)#no shutdown
    (config-if)#ip add 13.1.1.3 255.255.255.0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#interface lo0
    (config-if)#ip add 3.3.3.3 255.255.255.0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#router eigrp CCIE
    (config-router)#address-family ipv4 unicast autonomous-system 90
    (config-router-af)#eigrp router-id 3.3.3.3
    (config-router-af)#no shutdown
    (config-router-af)#network 3.3.3.3 0.0.0.0
    (config-router-af)#network 13.1.1.2 0.0.0.0
    (config-router-af)#topology base
    (config-router-af-topology)#no auto-summary
    (config-router-af-topology)#end
    #show ip route eigrp
    #conf t
    (config)#int fa 0/0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#int fa 0/0.5
    (config-subif)#encapsulation dot1Q 5
    (config-subif)#ip add 192.168.5.254 255.255.255.0
    (config-subif)#no shutdown
    (config-subif)#exit
    (config)#int fa 0/0.7
    (config-subif)#encapsulation dot1Q 7
    (config-subif)#ip add 192.168.7.254 255.255.255.0
    (config-subif)#no shutdown
    (config-subif)#exit
    (config)#service dhcp
    (config)#ip dhcp pool R5
    (dhcp-config)#host 192.168.5.5 255.255.255.0
    (dhcp-config)#client-identifier 01ca.0536.d400.08 R5的clientid
    (dhcp-config)#default-router 192.168.5.254
    (dhcp-config)#dns-server 8.8.8.8
    (dhcp-config)#domain-name cisco.com
    (dhcp-config)#exit
    (config)#ip dhcp pool R7
    (dhcp-config)#host 192.168.7.7 255.255.255.0
    (dhcp-config)#client-identifier 01ca.073a.a800.08 R7的clientid
    (dhcp-config)#default-router 192.168.7.254
    (dhcp-config)#dns-server 8.8.8.8
    (dhcp-config)#domain-name cisco.com
    (dhcp-config)#exit
    (config)#interface s1/0
    (config-if)#ip nat outside
    (config-if)#exit
    (config)#int fa 0/0.5
    (config-subif)#ip nat inside
    (config-subif)#int fa 0/0.7
    (config-subif)#ip nat inside
    (config-subif)#exit
    (config)#access-list 10 permit 192.168.5.0 0.0.0.255
    (config)#access-list 10 permit 192.168.7.0 0.0.0.255
    (config)#ip nat inside source list 10 interface serial 1/0 overload
    (config)#interface tunnel 3
    (config-if)#tunnel source 13.1.1.3
    (config-if)#tunnel destination 12.1.1.2
    (config-if)#ip add 10.1.1.3 255.255.255.0
    (config-if)#no shutdown
    (config-if)#exit
    (config)#do ping 10.1.1.2
    (config)#crypto isakmp key cisco address 0.0.0.0
    (config)#cyrpto isakmp policy 10
    (config-isakmp)#encryption aes
    (config-isakmp)#authentication pre-share
    (config-isakmp)#hash sha
    (config-isakmp)#group 5
    (config-isakmp)#exit
    (config)#end
    #show run | section isakmp
    #conf t
    (config)#crypto ipsec transform-set TEST esp-aes esp-md5-hmac
    (cfg-crypto-trans)#mode transport
    (cfg-crypto-trans)#exit
    (config)#crypto ipsec profile R3
    (ipsec-profile)#set transform-set TEST
    (ipsec-profile)#exit
    (config)#int tunnel 3
    (config-if)#tunnel protection ipsec profile R3
    (config-if)#exit
    (config)#router ospf 110
    (config-router)#router-id 3.3.3.3
    (config-router)#network 10.1.1.3 0.0.0.0 area 0
    (config-router)#network 192.168.5.254 0.0.0.0 area 0
    (config-router)#network 192.168.7.254 0.0.0.0 area 0
    (config-router)#end
    #show ip route ospf
    ```
    - R4
    
    ```
    #en
    #conf t
    (config)#end
    #show interfaces fa 0/0 查看mac地址，计算dhcp clientid
    #conf t
    (config)#no ip routing
    (config)#int fa 0/0
    (config-if)#no shutdown
    (config-if)#ip add dhcp client-id fa0/0 hostname R4
    (config-if)#end
    #ping 172.16.6.6
    ```
    - R6
 
    ```
    #en
    #conf t
    (config)#end
    #show interfaces fa 0/0 查看mac地址，计算dhcp clientid
    #conf t
    (config)#no ip routing
    (config)#int fa 0/0
    (config-if)#no shutdown
    (config-if)#ip add dhcp client-id fa0/0 hostname R6
    ```
    - R5
    
    ```
    #en
    #conf t
    (config)#end
    #show interfaces fa 0/0 查看mac地址，计算dhcp clientid
    #conf t
    (config)#no ip routing
    (config)#int fa 0/0
    (config-if)#no shutdown
    (config-if)#ip add dhcp client-id fa0/0 hostname R5
    (config-if)#end
    #ping 192.168.7.7
    ```
    - R7
    
    ```
    #en
    #conf t
    (config)#end
    #show interfaces fa 0/0 查看mac地址，计算dhcp clientid
    #conf t
    (config)#no ip routing
    (config)#int fa 0/0
    (config-if)#no shutdown
    (config-if)#ip add dhcp client-id fa0/0 hostname R7

    ```
    
## HCNA综合实验一

![闫辉hcna综合实验](https://i.imgur.com/RM7qVUX.png)
- 配置步骤
  1. 给园区网内网的所有设备配置主机名
  2. 二层配置先trunk➡️Ether-Trunk➡️VLAN➡️STP 802.1S MSTP➡️Access
  3. 地址规划
     - vlan 10: 172.16.10.0/24
     - vlan 20: 172.16.20.0/24
     - vlan 30: 172.16.30.0/24
     - vlan 40: 172.16.40.0/24
  4. `FHRP第一跳冗余协议`
     - `HSRP`
     - `VRRP` Group 10
     - `GLBP`
  5. `交换机接口模式`
     - Portswitch 交换接口模式
     - Undo portswitch 路由接口模式(模拟机不支持)

  - R1
  
    ```
    <>system
    []sysna R1
    []int g0/0/0
    [g0/0/0]ip add 172.16.100.1 24
    [g0/0/0]int g0/0/1
    [g0/0/1]ip add 172.16.200.1 24
    []ospf 10 router-id 1.1.1.1
    [ospf-10]area 0
    [ospf-10-area-0.0.0.0]network 172.16.100.1 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.200.1 0.0.0.0
    []dis ospf peer brief
    []int g0/0/2
    [g0/0/2]ip add 12.1.1.1 24
    [g0/0/2]ping 12.1.1.2
    []ip route-static 0.0.0.0 0 g0/0/2 12.1.1.2
    []ospf 10
    [ospf-10]default-route-advertise
    [ospf-10]quit
    []acl number 2000
    [acl-basic-2000]rule 10 permit source 172.16.0.0 0.0.255.255
    [acl-basic-2000]quit
    []int g0/0/2
    [g0/0/2]nat outbound 2000
    [g0/0/2]quit
    []dis nat outbound
    []dis nat mapping table all
    ```
  - R2
 
    ```
    <>system
    []sysna R2
    []int g0/0/0
    [g0/0/0]ip add 12.1.1.2 24
    [g0/0/0]int g0/0/1
    [g0/0/1]ip add 100.100.100.2 24
    ```
    - SW1

    ```
    <>system
    []sysna SW1
    []vlan batch 12 21 13 14
    []int g0/0/1
    [g0/0/1]port link-type access
    [g0/0/1]port default vlan 13
    [g0/0/1]undo stp enable
    [g0/0/1]int g0/0/2
    [g0/0/2]port link-type access
    [g0/0/2]port default vlan 14
    [g0/0/2]undo stp enable
    [g0/0/2]int g0/0/3
    [g0/0/3]port link-type access
    [g0/0/3]port default vlan 12
    [g0/0/3]undo stp enable
    [g0/0/3]int g0/0/4
    [g0/0/4]port link-type access
    [g0/0/4]port default vlan 21
    [g0/0/4]undo stp enable
    [g0/0/4]quit
    [g0/0/4]int vlan 12
    [vlanif12]ip add 172.16.12.1 24
    [vlanif12]int vlan 21
    [vlanif21]ip add 172.16.21.1 24
    [vlanif21]int vlan 13
    [vlanif13]ip add 172.16.13.1 24
    [vlanif13]int vlan 14
    [vlanif14]ip add 172.16.14.1 24
    [vlanif14]quit
    []vlan 100
    [vlan100]quit
    []int g0/0/5
    [g0/0/5]port link-type access
    [g0/0/5]port default vlan 100
    [g0/0/5]undo stp enable
    [g0/0/5]int vlan 100
    [vlanif100]ip add 172.16.100.2 24
    []ospf 10 router-id 11.11.11.11
    [ospf-10]area 0
    [ospf-10-area-0.0.0.0]network 172.16.100.2 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.12.1 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.21.1 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.13.1 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.14.1 0.0.0.0
    []dis ospf peer brief
    ```
    - SW2
    
    ```
    <>system
    []sysna SW2
    []vlan batch 12 21 23 24
    []int g0/0/1
    [g0/0/1]port link-type access
    [g0/0/1]port default vlan 23
    [g0/0/1]undo stp enable
    [g0/0/1]int g0/0/2
    [g0/0/2]port link-type access
    [g0/0/2]port default vlan 24
    [g0/0/2]undo stp enable
    [g0/0/2]int g0/0/3
    [g0/0/3]port link-type access
    [g0/0/3]port default vlan 12
    [g0/0/3]undo stp enable
    [g0/0/3]int g0/0/4
    [g0/0/4]port link-type access
    [g0/0/4]port default vlan 21
    [g0/0/4]undo stp enable
    [g0/0/4]quit
    [g0/0/4]int vlan 12
    [vlanif12]ip add 172.16.12.2 24
    [vlanif12]int vlan 21
    [vlanif21]ip add 172.16.21.2 24
    [vlanif21]int vlan 23
    [vlanif23]ip add 172.16.23.2 24
    [vlanif23]int vlan 24
    [vlanif24]ip add 172.16.24.2 24
    [vlanif24]quit
    []vlan 200
    [vlan200]quit
    []int g0/0/5
    [g0/0/5]port link-type access
    [g0/0/5]port default vlan 200
    [g0/0/5]undo stp enable
    [g0/0/5]int vlan 200
    [vlanif200]ip add 172.16.200.2 24
    []ospf 10 router-id 12.12.12.12
    [ospf-10]area 0
    [ospf-10-area-0.0.0.0]network 172.16.200.2 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.12.2 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.21.2 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.23.2 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.24.2 0.0.0.0
    []dis ospf peer brief
    ```
  - SW3
  
    ```
     <>system
    []sysna SW3
    []int g 0/0/1
    [g0/0/1]port link-type trunk
    [g0/0/1]port trunk allow-pass vlan 10 20 30 40
    [g0/0/1]dis this
    [g0/0/1]int g0/0/2
    [g0/0/2]port link-type trunk
    [g0/0/2]port trunk allow-pass vlan 10 20 30 40
    [g0/0/2]int g0/0/3
    [g0/0/3]port link-type trunk
    [g0/0/3]port trunk allow-pass vlan 10 20 30 40
    []int eth-trunk 34
    [eth-trunk34]trunkport g0/0/4 to g0/0/5
    [eth-trunk34]port link-type trunk
    [eth-trunk34]port trunk allow-pass vlan 10 20 30 40
    []dis etc-trunk 34
    []dis port vlan
    []vlan batch 10 20 30 40
    []dis vlan
    []stp mode mstp
    []stp region-configuration
    [mst-region]region-name Tiger
    [mst-region]revision-level 34567
    [mst-region]instance 1 vlan 10 20
    [mst-region]instance 2 vlan 30 40
    [mst-region]active region-configuration
    [mst-region]display this
    [mst-region]quit
    []stp instance 1 root primary
    []stp instance 2 root secondary
    []dis stp instance 1
    []dis stp instance 2
    []int vlan 10
    [vlanif-10]ip add 172.16.10.13 24
    [vlanif-10]vrrp vrid 10 virtual-ip 172.16.10.254
    [vlanif-10]vrrp vrid 10 priority 105
    [vlanif-10]int vlan 20
    [vlanif-20]ip add 172.16.20.13 24
    [vlanif-20]vrrp vrid 20 virtual-ip 172.16.20.254
    [vlanif-20]vrrp vrid 20 priority 105
    [vlanif-30]int vlan 30
    [vlanif-30]ip add 172.16.30.13 24
    [vlanif-30]vrrp vrid 30 virtual-ip 172.16.30.254
    [vlanif-30]int vlan 40
    [vlanif-40]ip add 172.16.40.13 24
    [vlanif-40]vrrp vrid 40 virtual-ip 172.16.40.254
    [vlanif-40]quit
    []dis cur 
    []dis vrrp brief
    []vlan batch 13 23
    []int g0/0/6
    [g0/0/6]port link-type access
    [g0/0/6]port default vlan 13
    [g0/0/6]undo stp enable
    [g0/0/6]int g0/0/7
    [g0/0/7]port link-type access
    [g0/0/7]port default vlan 23
    [g0/0/7]undo stp enable
    [g0/0/7]quit
    [g0/0/7]int vlan 13
    [vlanif13]ip add 172.16.13.3 24
    [vlanif13]int vlan 23
    [vlanif23]ip add 172.16.23.3 24
    [vlanif23]quit
    []ospf 10 router-id 13.13.13.13
    [ospf-10]area 0
    [ospf-10-area-0.0.0.0]network 172.16.13.3 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.23.3 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.10.13 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.20.13 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.30.13 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.40.13 0.0.0.0
    []dis ospf peer brief
    [ospf-10]silent-interface vlanif 10
    [ospf-10]silent-interface vlanif 20
    [ospf-10]silent-interface vlanif 30
    [ospf-10]silent-interface vlanif 40
    []dis ospf peer brief
    ```
    - SW4
    
    ```
    <>system
    []sysna SW4
    []int g 0/0/1
    [g0/0/1]port link-type trunk
    [g0/0/1]port trunk allow-pass vlan 10 20 30 40
    [g0/0/1]dis this
    [g0/0/1]int g0/0/2
    [g0/0/2]port link-type trunk
    [g0/0/2]port trunk allow-pass vlan 10 20 30 40
    [g0/0/2]int g0/0/3
    [g0/0/3]port link-type trunk
    [g0/0/3]port trunk allow-pass vlan 10 20 30 40
    []int eth-trunk 34
    [eth-trunk34]trunkport g0/0/4 to g0/0/5
    [eth-trunk34]port link-type trunk
    [eth-trunk34]port trunk allow-pass vlan 10 20 30 40
    []dis etc-trunk 34
    []dis port vlan
    []vlan batch 10 20 30 40
    []dis vlan
    []stp mode mstp
    []stp region-configuration
    [mst-region]region-name Tiger
    [mst-region]revision-level 34567
    [mst-region]instance 1 vlan 10 20
    [mst-region]instance 2 vlan 30 40
    [mst-region]active region-configuration
    [mst-region]display this
    [mst-region]quit
    []stp instance 1 root secondary
    []stp instance 2 root primary
    []dis stp instance 2
    []int vlan 10
    [vlanif-10]ip add 172.16.10.14 24
    [vlanif-10]vrrp vrid 10 virtual-ip 172.16.10.254
    [vlanif-10]int vlan 20
    [vlanif-20]ip add 172.16.20.14 24
    [vlanif-20]vrrp vrid 20 virtual-ip 172.16.20.254
    [vlanif-30]int vlan 30
    [vlanif-30]ip add 172.16.30.14 24
    [vlanif-30]vrrp vrid 30 virtual-ip 172.16.30.254
    [vlanif-30]vrrp vrid 30 priority 105
    [vlanif-30]int vlan 40
    [vlanif-40]ip add 172.16.40.14 24
    [vlanif-40]vrrp vrid 40 virtual-ip 172.16.40.254
    [vlanif-40]vrrp vrid 40 priority 105
    [vlanif-40]quit
    []dis cur 
    []dis vrrp brief
    []vlan batch 14 24
    []int g0/0/6
    [g0/0/6]port link-type access
    [g0/0/6]port default vlan 14
    [g0/0/6]undo stp enable
    [g0/0/6]int g0/0/7
    [g0/0/7]port link-type access
    [g0/0/7]port default vlan 24
    [g0/0/7]undo stp enable
    [g0/0/7]quit
    [g0/0/7]int vlan 14
    [vlanif14]ip add 172.16.14.4 24
    [vlanif14]int vlan 24
    [vlanif24]ip add 172.16.24.4 24
    [vlanif24]quit
    []ospf 10 router-id 13.13.13.13
    [ospf-10]area 0
    [ospf-10-area-0.0.0.0]network 172.16.14.4 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.24.4 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.10.14 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.20.14 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.30.14 0.0.0.0
    [ospf-10-area-0.0.0.0]network 172.16.40.14 0.0.0.0
    []dis ospf peer brief
    [ospf-10]silent-interface vlanif 10
    [ospf-10]silent-interface vlanif 20
    [ospf-10]silent-interface vlanif 30
    [ospf-10]silent-interface vlanif 40
    []dis ospf peer brief
    ```
    - SW5

    ```
    <>system
    []sysna SW5
    []int g0/0/1
    [g0/0/1]port link-type trunk
    [g0/0/1]port trunk allow-pass vlan 10 20 30 40
    [g0/0/1]int g0/0/2
    [g0/0/2]port link-type trunk
    [g0/0/2]port trunk allow-pass vlan 10 20 30 40
    []dis port vlan
    []vlan batch 10 20 30 40
    []dis vlan
    []stp mode mstp
    []stp region-configuration
    [mst-region]region-name Tiger
    [mst-region]revision-level 34567
    [mst-region]instance 1 vlan 10 20
    [mst-region]instance 2 vlan 30 40
    [mst-region]active region-configuration
    [mst-region]display this
    []dis stp instance 1
    []dis stp instance 2
    []instance e0/0/1
    [e0/0/1]port link-type access
    [e0/0/1]port default vlan 10
    [e0/0/1]stp edged-port enable
    []dis port vlan
    ```
    - SW6

    ```
    <>sysem
    []sysna SW6
    []int g0/0/1
    [g0/0/1]port link-type trunk
    [g0/0/1]port trunk allow-pass vlan 10 20 30 40
    [g0/0/1]int g0/0/2
    [g0/0/2]port link-type trunk
    [g0/0/2]port trunk allow-pass vlan 10 20 30 40
    []dis port vlan
    []vlan batch 10 20 30 40
    []dis vlan
    []stp mode mstp
    []stp region-configuration
    [mst-region]region-name Tiger
    [mst-region]revision-level 34567
    [mst-region]instance 1 vlan 10 20
    [mst-region]instance 2 vlan 30 40
    [mst-region]active region-configuration
    [mst-region]display this
    []int e0/0/1
    [e0/0/1]port link-type access
    [e0/0/1]port default vlan 20
    [e0/0/1]stp edged-port enable
    [e0/0/1]int e0/0/2
    [e0/0/2]port link-type access
    [e0/0/2]port default vlan 40
    [e0/0/2]stp edged-port enable
    []dis port vlan
    ```
    - SW7


    ```
    <>sysem
    []sysna SW7
    []int g0/0/1
    [g0/0/1]port link-type trunk
    [g0/0/1]port trunk allow-pass vlan 10 20 30 40
    [g0/0/1]int g0/0/2
    [g0/0/2]port link-type trunk
    [g0/0/2]port trunk allow-pass vlan 10 20 30 40
    []dis port vlan
    []vlan batch 10 20 30 40
    []dis vlan
    []stp mode mstp
    []stp region-configuration
    [mst-region]region-name Tiger
    [mst-region]revision-level 34567
    [mst-region]instance 1 vlan 10 20
    [mst-region]instance 2 vlan 30 40
    [mst-region]active region-configuration
    [mst-region]display this
    [e0/0/1]port link-type access
    [e0/0/1]port default vlan 30
    [e0/0/1]stp edged-port enable
    []dis port vlan
    ```

## HCNA 综合实验二
![闫辉hcna综合实验2](https://i.imgur.com/2pcPol1.jpg)
- SW7

```
<SW7>sys
[SW7]int g0/0/1
[SW7-g0/0/1]port link-type trunk
[SW7-g0/0/1]port trunk allow-pass vlan 100
[SW7-g0/0/1]quit
[SW7]int g0/0/2
[SW7-g0/0/2]port link-type trunk
[SW7-g0/0/2]port trunk allow-pass vlan 100
[SW7-g0/0/2]quit 
[SW7]vlan 100
[SW7-vlan 100] quit
[SW7]stp mode mstp
[SW7]stp region-configuration
[SW7-mst-region]region-name Tiger
[SW7-mst-region]revision-level 127
[SW7-mst-region]instance 1 vlan 100
[SW7-mst-region]active region-configuration
[SW7-mst-region]quit
[SW7]dis stp region-configuration
[SW7]stp instance 1 root primary
[SW7]dis port vlan 检查中继接口
[SW7]ipv6
[SW7]int vlan 100
[SW7-vlanif100]ipv6 enable
[SW7-vlanif100]ipv6 add 2001:0:0:100::7/64
[SW7-vlanif100]quit
[SW7]dis ipv6 interface brief
[SW7]dis ipv6 interface vlanif 100
[SW7]quit
<SW7>quit  
<SW7>ping ipv6 2001:0:0:100::1
<SW7>ping ipv6 2001:0:0:100::2
<SW7>sys
[SW7]vlan 17
[SW7-vlan17]quit
[SW7]int g0/0/3
[SW7-g0/0/3]port link-type access
[SW7-g0/0/3]port default vlan 17
[SW7-g0/0/3]stp edged-port enable
[SW7-g0/0/3]quit
[SW7]int vlan 17
[SW7-vlanif17]ipv6 enable
[SW7-vlanif17]ipv6 address 2001:0:0:17::7/64
[SW7-vlanif17]quit
[SW7]ospfv3 10
[SW7-ospfv3-10]router-id 7.7.7.7
[SW7-ospfv3-10]area 0
[SW7-ospfv3-10-area-0.0.0.0]quit
[SW7-ospfv3-10]quit
[SW7]int vlanif100
[SW7-vlanif100]ospfv3 10 area 0
[SW7-vlanif100]quit
[SW7]int vlan 17
[SW7-vlanif17]ospfv3 10 area 0
[SW7-vlanif17]quit
[SW7]dis ipv6 routing-table protocol ospfv3
```
- SW1

```
<SW1>sys
[SW1]int g0/0/1
[SW1-g0/0/1]port link-type trunk
[SW1-g0/0/1]port trunk allow-pass vlan 100
[SW1-g0/0/1]quit
[SW1]vlan 100
[SW1-vlan 100] quit
[SW1]int e0/0/1
[SW1-e0/0/1]port link-type access
[SW1-e0/0/1]port default vlan 100
[SW1-e0/0/1]stp edged-port en
[SW1-e0/0/1]quit
[SW1]stp mode mstp
[SW1]stp region-configuration
[SW1-mst-region]region-name Tiger
[SW1-mst-region]revision-level 127
[SW1-mst-region]instance 1 vlan 100
[SW1-mst-region]active region-configuration
[SW1-mst-region]quit
[SW1]dis stp region-configuration
```
- SW2

```
<SW2>sys
[SW2]int g0/0/1
[SW2-g0/0/1]port link-type trunk
[SW2-g0/0/1]port trunk allow-pass vlan 100
[SW2-g0/0/1]quit
[SW2]vlan 100
[SW2-vlan 100] quit
[SW2]int e0/0/1
[SW2-e0/0/1]port link-type access
[SW2-e0/0/1]port default vlan 100
[SW2-e0/0/1]stp edged-port en
[SW2-e0/0/1]quit
[SW2]stp mode mstp
[SW2]stp region-configuration
[SW2-mst-region]region-name Tiger
[SW2-mst-region]revision-level 127
[SW2-mst-region]instance 1 vlan 100
[SW2-mst-region]active region-configuration
[SW2-mst-region]quit
[SW2]dis stp region-configuration
```
- SW8

```
<SW8>sys
[SW8]int g0/0/1
[SW8-g0/0/1]port link-type trunk
[SW8-g0/0/1]port trunk allow-pass vlan 10
[SW8-g0/0/1]quit
[SW8]int g0/0/2
[SW8-g0/0/2]port link-type trunk
[SW8-g0/0/2]port trunk allow-pass vlan 10
[SW8-g0/0/2]quit 
[SW8]vlan 10
[SW8]stp mode mstp
[SW8]stp region-configuration
[SW8-mst-region]region-name Tiger
[SW8-mst-region]revision-level 348
[SW8-mst-region]instance 1 vlan 10
[SW8-mst-region]active region-configuration
[SW8-mst-region]quit
[SW8]dis stp region-configuration
[SW8]stp instance 1 root primary
[SW8]dis port vlan
[SW8]int vlan 10
[SW8-vlanif10]ip add 172.16.10.8 255.255.255.0
[SW8-vlanif10]quit
[SW8]dis ip interface bri
[SW8]ping 172.16.10.3
[SW8]ping 172.16.10.4
[SW8]vlan 18
[SW7-vlan18]quit
[SW8]int g0/0/3
[SW8-g0/0/3]port link-type access
[SW8-g0/0/3]port default vlan 18
[SW8-g0/0/3]stp edged-port enable
[SW8-g0/0/3]quit
[SW8]int vlan 18
[SW8-vlanif18]ip address 172.16.18.8 24
[SW8-vlanif18]quit
[SW8]ospf 10 router-id 8.8.8.8
[SW8-ospf-10]area 0
[SW8-ospf-10-area-0.0.0.0]network 172.16.10.8 0.0.0.0
[SW8-ospf-10-area-0.0.0.0]network 172.16.18.8 0.0.0.0
[SW8-ospf-10-area-0.0.0.0]quit
[SW8-ospf-10]dis ip routing-table protocol ospf
```
- SW3

```
<SW3>sys
[SW3]int g0/0/1
[SW3-g0/0/1]port link-type trunk
[SW3-g0/0/1]port trunk allow-pass vlan 10
[SW3-g0/0/1]quit
[SW3]vlan 10
[SW3-vlan 10] quit
[SW3]int e0/0/1
[SW3-e0/0/1]port link-type access
[SW3-e0/0/1]port default vlan 10
[SW3-e0/0/1]stp edged-port en
[SW3-e0/0/1]quit
[SW3]stp mode mstp
[SW3]stp region-configuration
[SW3-mst-region]region-name Tiger
[SW3-mst-region]revision-level 348
[SW3-mst-region]instance 1 vlan 10
[SW3-mst-region]active region-configuration
[SW3-mst-region]quit
[SW3]dis stp region-configuration
```
- SW4

```
<SW4>sys
[SW4]int g0/0/1
[SW4-g0/0/1]port link-type trunk
[SW4-g0/0/1]port trunk allow-pass vlan 10
[SW4-g0/0/1]quit
[SW4]vlan 10
[SW4-vlan 10] quit
[SW4]int e0/0/1
[SW4-e0/0/1]port link-type access
[SW4-e0/0/1]port default vlan 10
[SW4-e0/0/1]stp edged-port en
[SW4-e0/0/1]quit
[SW4]stp mode mstp
[SW4]stp region-configuration
[SW4-mst-region]region-name Tiger
[SW4-mst-region]revision-level 348
[SW4-mst-region]instance 1 vlan 10
[SW4-mst-region]active region-configuration
[SW4-mst-region]quit
[SW4]dis stp region-configuration
```
- PC1

```
IPv6: 2001:0:0:100::1
前缀: 64
网关: 2001:0:0:100::7
```
- PC2

```
IPv6: 2001:0:0:100::2
前缀: 64
网关: 2001:0:0:100::7
```
- PC3

```
IPv4: 172.16.10.3
掩码: 255.255.255.0
网关: 172.16.10.8
```
- PC4

```
IPv4: 172.16.10.4
掩码: 255.255.255.0
网关: 172.16.10.8
```
- R1

```
<AR1>sys
[AR1]ipv6
[AR1]int g0/0/0
[AR1-g0/0/0]ipv6 enable
[AR1-g0/0/0]ipv6 add 2001:0:0:17::1/64
[AR1-g0/0/0]quit
[AR1]ping ipv6 2001:0:0:17::7
[AR1]int g0/0/1
[AR1-g0/0/1]ip add 172.16.18.1 24
[AR1-g0/0/1]quit
[AR1]ping 172.16.18.8
[AR1]dis ipv6 routing-table
[AR1]dis ip routing-table
[AR1]ospfv3 10
[AR1-ospfv3-10]router-id 1.1.1.1
[AR1-ospfv3-10]area 0
[AR1-ospfv3-10-area-0.0.0.0]quit
[AR1-ospfv3-10]quit
[AR1]int g0/0/0
[AR1-g0/0/0]ospfv3 10 area 0.0.0.0
[AR1-g0/0/0]quit
[AR1]ospf 10 router-id 1.1.1.1
[AR1-ospf-10]area 0
[AR1-ospf-10-area-0.0.0.0]network 172.16.18.1 0.0.0.0
[AR1-ospf-10-area-0.0.0.0]quit
[AR1-ospf-10]default-route-advertise always
[AR1-ospf-10]quit
[AR1]ospfv3 10
[AR1-ospfv3-10]default-route-advertise always
[AR1-ospfv3-10]quit
[AR1]dis ospfv3 peer
[AR1]dis ospf peer brief
[AR1]dis ipv6 routing-table protocol ospfv3
[AR1]dis ip routing-table protocol ospf
[AR1]ping ipv6 2001:0:0:100::1
[AR1]ping ipv6 2001:0:0:100::2
[AR1]ping 172.16.10.3
[AR1]ping 172.16.10.4
[AR1]int g0/0/2
[AR1-g0/0/2]ip add 100.1.14.1 24
[AR1-g0/0/2]quit
[AR1]ping 100.1.14.4
[AR1]ip route-static 0.0.0.0 0 g0/0/2 100.1.14.4
[AR1]ping 100.1.26.2
[AR1]int tunnel 0/0/12
[AR1-tunnel0/0/12]ipv6 enable
[AR1-tunnel0/0/12]tunnel-protocol ipv6-ipv4
[AR1-tunnel0/0/12]source 100.1.14.1
[AR1-tunnel0/0/12]destination 100.1.26.2
[AR1-tunnel0/0/12]ipv6 add 2001:0:0:12::1/64
[AR1-tunnel0/0/12]ospfv3 10 area 0
[AR1-tunnel0/0/12]quit
[AR1]dis ospfv3 peer
[AR1]dis ipv6 routing-table protocol ospf
[AR1]int tunnel 0/0/13
[AR1-tunnel0/0/13]ipv6 enable
[AR1-tunnel0/0/13]tunnel-protocol gre
[AR1-tunnel0/0/13]source 100.1.14.1
[AR1-tunnel0/0/13]destination 100.1.38.3
[AR1-tunnel0/0/13]ip add 172.16.13.1 24
[AR1-tunnel0/0/13]quit
[AR1]int tunnel0/0/13
[AR1-tunnel0/0/13]ospf enable 10 area 0
[AR1]dis ospf peer brief
[AR1]dis ip routing-table protocol ospf
[AR1]acl number 2000
[AR1-acl-basic-2000]rule 10 permit source 172.16.10.0 0.0.0.255
[AR1-acl-basic-2000]quit
[AR1]int g0/0/02
[AR1-g0/0/2]nat outbound 2000
```
- PC5

```
IPv6: 2001:0:0:200::5
前缀: 64
网关: 2001:0:0:100::2
```
- PC6

```
IPv6: 2001:0:0:200::6
前缀: 64
网关: 2001:0:0:100::2
```
- SW5

```
[SW5]vlan 200
[SW5-vlan200]quit
[SW5]int e0/0/1
[SW5-e0/0/1]port link-type access
[SW5-e0/0/1]port default vlan 200
[SW5-e0/0/1]stp edged-port enable
[SW5-e0/0/1]quit
[SW5]int e0/0/2
[SW5-e0/0/2]port link-type access
[SW5-e0/0/2]port default vlan 200
[SW5-e0/0/2]stp edged-port enable
[SW5-e0/0/2]quit
[SW5]int g0/0/1
[SW5-g0/0/1]port link-type access
[SW5-g0/0/1]port default vlan 200
[SW5-g0/0/1]stp edged-port enable
```
- AR2

```
[AR2]ipv6
[AR2]int g0/0/1]
[AR2-g0/0/1]ipv6 enable
[AR2-g0/0/1]ipv6 add 2001:0:0:200::2/64
[AR2-g0/0/1]quit
[AR2]dis ipv6 interface brief
[AR2]ping ipv6 2001:0:0:200::5
[AR2]ping ipv6 2001:0:0:200::6
[AR2]int g0/0/0
[AR2-g0/0/0]ip add 100.1.26.2 24
[AR2-g0/0/0]quit
[AR2]ping 100.1.26.6
[AR2]ip route-static 0.0.0.0 0 g0/0/0 100.1.26.6
[AR2]ping 100.1.14.1
[AR2]int tunnel 0/0/12
[AR2-tunnel0/0/12]ipv6 enable
[AR2-tunnel0/0/12]tunnel-protocol ipv6-ipv4
[AR2-tunnel0/0/12]source 100.1.26.2
[AR2-tunnel0/0/12]destination 100.1.14.1
[AR2-tunnel0/0/12]ipv6 add 2001:0:0:12::2/64
[AR2-tunnel0/0/12]quit
[AR2]ping ipv6 2001:0:0:12::1
[AR2]ospfv3 10 
[AR2-ospfv3-10]router-id 2.2.2.2
[AR2-ospfv3-10]area 0
[AR2-ospfv3-10-area-0.0.0.0]quit
[AR2-ospfv3-10]quit
[AR2]int tunnel 0/0/12
[AR2-tunnel0/0/12]ospfv3 10 area 0
[AR2-tunnel0/0/12]int g0/0/1
[AR2-g0/0/1]ospfv3 10 area 0
[AR2-g0/0/1]quit
[AR2]dis ipv6 routing-table protocol ospf
```
- PC7

```
IPv4: 172.16.20.7
掩码: 255.255.255.0
网关: 172.16.20.3
```
- PC8

```
IPv4: 172.16.20.8
掩码: 255.255.255.0
网关: 172.16.20.3
```
- SW6

```
[SW6]vlan 20
[SW6-vlan20]quit
[SW6]int e0/0/1
[SW6-e0/0/1]port link-type access
[SW6-e0/0/1]port default vlan 20
[SW6-e0/0/1]stp edged-port enable
[SW6-e0/0/1]quit
[SW6]int e0/0/2
[SW6-e0/0/2]port link-type access
[SW6-e0/0/2]port default vlan 20
[SW6-e0/0/2]stp edged-port enable
[SW6-e0/0/2]quit
[SW6]int g0/0/1
[SW6-g0/0/1]port link-type access
[SW6-g0/0/1]port default vlan 20
[SW6-g0/0/1]stp edged-port enable
```
- AR3

```
[AR3]int g0/0/1]
[AR3-g0/0/1]ip add 172.16.20.3 24
[AR3-g0/0/1]quit
[AR3]ping 172.16.20.7
[AR3]ping 172.16.20.8
[AR3]int g0/0/0
[AR3-g0/0/0]ip add 100.1.38.3 24
[AR3-g0/0/0]ping 100.1.38.8
[AR3]ip route-static 0.0.0.0 0 g 0/0/0 100.1.38.8
[AR3]dis ip routing-table protocol static
[AR3]ping 100.1.14.1
[AR3]int tunnel 0/0/13
[AR3-tunnel0/0/13]ipv6 enable
[AR3-tunnel0/0/13]tunnel-protocol gre
[AR3-tunnel0/0/13]source 100.1.38.3
[AR3-tunnel0/0/13]destination 100.1.14.1
[AR3-tunnel0/0/13]ip add 172.16.13.3 24
[AR3-tunnel0/0/13]quit
[AR3]ping 172.16.13.1
[AR3]ospf 10 routed-id 3.3.3.3
[AR3-ospf-10]area 0
[AR3-ospf-10-area-0.0.0.0]network 172.16.13.3 0.0.0.0
[AR3-ospf-10-area-0.0.0.0]network 172.16.20.3 0.0.0.0
[AR3-ospf-10-area-0.0.0.0]quit
[AR3-ospf-10]ids ip routing-table protocol ospf
[AR3-ospf-10]quit
[AR3] acl number 2000
[AR3-acl-basic-2000]rule 10 permit source 172.16.20.0 0.0.0.255
[AR3-acl-basic-2000]quit
[AR3]int g0/0/0
[AR3-g0/0/0]nat outbound 2000
```
- AR4

```
[AR4]int g0/0/0
[AR4-g0/0/0]ip add 100.1.14.4 24
[AR4-g0/0/0]quit
[AR4]int g0/0/1
[AR4-g0/0/1]ip add 100.1.45.4 24
[AR4-g0/0/1]quit
[AR4]int g0/0/2
[AR4-g0/0/2]ip add 100.1.47.4 24
[AR4-g0/0/2]quit
[AR4]isis 15
[AR4-isis-15]network-entity 49.0100.0000.0000.0004.00
[AR4-isis-15]log-peer-change topology
[AR4-isis-15]is-level level-2
[AR4-isis-15]cost-style wide
[AR4-isis-15]dis this
[AR4]int g0/0/0
[AR4-g0/0/0]isis enable 15
[AR4-g0/0/0]isis silent
[AR4-g0/0/0]quit
[AR4]int g0/0/1
[AR4-g0/0/1]isis enable 15
[AR4-g0/0/1]quit
[AR4]int g0/0/2
[AR4-g0/0/2]isis enable 15
[AR4-g0/0/2]quit
[AR4]dis ip routing-table isis
```
- AR5

```
[AR5]int g0/0/0
[AR5-g0/0/0]ip add 100.1.45.5 24
[AR5-g0/0/0]quit
[AR5]int g0/0/1
[AR5-g0/0/1]ip add 100.1.56.5 24
[AR5-g0/0/1]quit
[AR5]isis 15
[AR5-isis-15]network-entity 49.0100.0000.0000.0005.00
[AR5-isis-15]log-peer-change topology
[AR5-isis-15]is-level level-2
[AR5-isis-15]cost-style wide
[AR5-isis-15]dis this
[AR5]int g0/0/0
[AR5-g0/0/0]isis enable 15
[AR5-g0/0/0]quit
[AR5]int g0/0/1
[AR5-g0/0/1]isis enable 15
[AR5-g0/0/1]quit
```
- AR6

```
[AR6]int g0/0/0
[AR6-g0/0/0]ip add 100.1.56.6 24
[AR6-g0/0/0]quit
[AR6]int g0/0/1
[AR6-g0/0/1]ip add 100.1.26.6 24
[AR6-g0/0/1]quit
[AR6]isis 15
[AR6-isis-15]network-entity 49.0100.0000.0000.0006.00
[AR6-isis-15]log-peer-change topology
[AR6-isis-15]is-level level-2
[AR6-isis-15]cost-style wide
[AR6-isis-15]dis this
[AR6]int g0/0/0
[AR6-g0/0/0]isis enable 15
[AR6-g0/0/0]quit
[AR6]int g0/0/1
[AR6-g0/0/1]isis enable 15
[AR6-g0/0/1]isis silent
[AR6-g0/0/1]quit
```
- AR7

```
[AR7]int g0/0/0
[AR7-g0/0/0]ip add 100.1.47.7 24
[AR7-g0/0/0]quit
[AR7]int g0/0/1
[AR7-g0/0/1]ip add 100.1.78.7 24
[AR7-g0/0/1]quit
[AR7]isis 15
[AR7-isis-15]network-entity 49.0100.0000.0000.0007.00
[AR7-isis-15]log-peer-change topology
[AR7-isis-15]is-level level-2
[AR7-isis-15]cost-style wide
[AR7-isis-15]dis this
[AR7]int g0/0/0
[AR7-g0/0/0]isis enable 15
[AR7-g0/0/0]quit
[AR7]int g0/0/1
[AR7-g0/0/1]isis enable 15
[AR7-g0/0/1]quit
```
- AR8

```
[AR8]int g0/0/0
[AR8-g0/0/0]ip add 100.1.78.8 24
[AR8-g0/0/0]quit
[AR8]int g0/0/1
[AR8-g0/0/1]ip add 100.1.38.8 24
[AR8-g0/0/1]quit
[AR8]isis 15
[AR8-isis-15]network-entity 49.0100.0000.0000.0008.00
[AR8-isis-15]log-peer-change topology
[AR8-isis-15]is-level level-2
[AR8-isis-15]cost-style wide
[AR8-isis-15]dis this
[AR8]int g0/0/0
[AR8-g0/0/0]isis enable 15
[AR8-g0/0/0]quit
[AR8]int g0/0/1
[AR8-g0/0/1]isis enable 15
[AR8-g0/0/1]isis silent
[AR8-g0/0/1]quit
```
