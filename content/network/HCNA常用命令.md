---
2022-10-28 14:01:15
---

# HCNA 常用命令

- [HCNA 常用命令](#hcna-常用命令)
  - [eNSP 及 VRP 基础操作](#ensp-及-vrp-基础操作)
    - [基础查看](#基础查看)
    - [telnet 登录](#telnet-登录)
    - [stelnet 登录](#stelnet-登录)
    - [配置路由器为 FTP Server](#配置路由器为-ftp-server)
  - [交换机基础配置](#交换机基础配置)
    - [配置交换机双工模式、接口速率](#配置交换机双工模式接口速率)
    - [ARP 及 Proxy ARP](#arp-及-proxy-arp)
  - [VLAN](#vlan)
    - [查看](#查看)
    - [Hybrid 接口](#hybrid-接口)
    - [单臂路由实现 VLAN 间路由](#单臂路由实现-vlan-间路由)
    - [利用三层交换机实现 VLAN 间路由](#利用三层交换机实现-vlan-间路由)
  - [生成树](#生成树)
    - [STP 配置](#stp-配置)
    - [RSTP 基础配置](#rstp-基础配置)
    - [MSTP 基础配置](#mstp-基础配置)
  - [其他交换技术](#其他交换技术)
    - [GVRP 基础配置](#gvrp-基础配置)
    - [Smart Link 与 Monitor Link](#smart-link-与-monitor-link)
    - [配置 Eth-Trunk 链路聚合](#配置-eth-trunk-链路聚合)
  - [静态路由](#静态路由)
  - [OSPF](#ospf)
    - [配置 OSPF 的认证](#配置-ospf-的认证)
    - [OSPF 被动接口配置](#ospf-被动接口配置)
    - [OSPF 开销值、协议优先级及计时器的修改](#ospf-开销值协议优先级及计时器的修改)
  - [VRRP](#vrrp)
    - [VRRP 基本配置](#vrrp-基本配置)
    - [配置 VRRP 多备份组](#配置-vrrp-多备份组)
    - [配置 VRRP 的跟踪接口及认证](#配置-vrrp-的跟踪接口及认证)
  - [基础过滤工具](#基础过滤工具)
    - [配置基本的访问控制列表](#配置基本的访问控制列表)
    - [配置高级的访问控制列表](#配置高级的访问控制列表)
    - [配置前缀列表](#配置前缀列表)
  - [广域网](#广域网)
    - [WAN 接入配置](#wan-接入配置)
    - [PPP 的认证](#ppp-的认证)
  - [DHCP](#dhcp)
    - [配置基于接口地址池的 DHCP](#配置基于接口地址池的-dhcp)
    - [配置基于全局地址池的 DHCP](#配置基于全局地址池的-dhcp)
    - [配置 DHCP 中继](#配置-dhcp-中继)
  - [其他特性](#其他特性)
    - [SNMP 基础配置](#snmp-基础配置)
    - [GRE 协议基础配置](#gre-协议基础配置)
    - [配置 NAT](#配置-nat)

## eNSP 及 VRP 基础操作

### 基础查看

```cmd
<>dis ver
<>clock date time 12:00:00 2011-09-15
<>clock timezone BJ add 08:00:00
<>dis ip interface brief
<>dis ip routing-table
<>dis users
```

### telnet 登录

```cmd
[]aaa
[aaa]local-user admin password cipher hello
[aaa]local-user admin privilege level 15
[aaa]local-user admin service-type telnet
[]user-interface vty 0 4
[ui-vty0-4]authentication-mode aaa
```

### stelnet 登录

1. 配置 SSH Server

    ```cmd
    []rsa local-key-pair create
    []dis rsa local-key-pair public
    []user-interface vty 0 4
    [ui-vty0-4]authentication-mode aaa
    [ui-vty0-4]protocol inbound ssh
    []aaa
    [aaa]local-user huawei1 password cipher huawei1
    [aaa]local-user huawei1 privilege level 15
    [aaa]local-user huawei1 service-type ssh
    []ssh user huawei1 authentication-type password
    []stelnet server enable
    []dis ssh user-information huawei1
    []dis ssh server status
    []dis ssh server session
    ```

2. 配置 SSH Client

    ```cmd
    []ssh client first-time enable
    []stelnet 10.1.1.2
    []quit
    []sftp 10.1.1.2
    ```

3. 配置 SFTP Server

    ```cmd
    []aaa
    [aaa]local-user huawei2 password cipher huawei2
    [aaa]local-user huawei2 privilege level 15
    [aaa]local-user huawei2 service-type ssh
    [aaa]local-user huawei2 ftp-directory flash:
    []ssh user huawei2 authentication-type password
    []sftp server enable
    []dis ssh server status
    []dis ssh server session
    ```

### 配置路由器为 FTP Server

```cmd
[]aaa
[aaa]local-user ftp password cipher huawei
[aaa]local-user ftp privilege level 15
[aaa]local-user ftp service-type ftp
[aaa]local-user ftp ftp-directory flash:
```

## 交换机基础配置

### 配置交换机双工模式、接口速率

```cmd
[]int g0/0/1
[g0/0/1]undo negotiation auto
[g0/0/1]duplex full
[g0/0/1]speed 100
```

### ARP 及 Proxy ARP

1. PC 查看主机的 ARP 表

    ```cmd
    arp -a
    ```

2. 路由器查看 ARP 表

    ```cmd
    dis arp all
    ```

3. 配置静态 ARP

    ```cmd
    []arp static 10.1.1.1 5489-98cf-2803
    ```

4. 配置 Proxy ARP

    ```cmd
    []int g0/0/1
    [g0/0/1]arp-proxy enable
    ```

## VLAN

### 查看

```cmd
<>dis vlan summary
<>dis port vlan
```

### Hybrid 接口

```cmd
[]interface ethernet0/0/1
[e0/0/1]port link-type hybrid
[e0/0/1]port hybrid pvid vlan 10
[e0/0/1]port hybrid untagged vlan 10
[e0/0/1]port hybrid tagged vlan 20
```

### 单臂路由实现 VLAN 间路由

1. 配置路由器子接口和 IP 地址

    ```cmd
    []int g0/0/1.1
    [g0/0/1.1]ip add 192.168.1.254 24
    []int g0/0/1.2
    [g0/0/1.2]ip add 192.168.2.254 24
    []int g0/0/1.3
    [g0/0/1.3]ip add 192.168.3.254 24
    ```

2. 配置路由器子接口封装 VLAN

    ```cmd
    [g0/0/1.1]dot1q termination vid 10
    [g0/0/1.1]arp broadcast enable
    [g0/0/1.2]dot1q termination vid 20
    [g0/0/1.2]arp broadcast enable
    [g0/0/1.3]dot1q termination vid 30
    [g0/0/1.3]arp broadcast enable
    []dis ip interface brief
    []dis ip routing-table
    ```

### 利用三层交换机实现 VLAN 间路由

```cmd
[]interface vlanif 10
[vlanif10]ip add 192.168.1.254 24
[vlanif10]interface vlanif 20
[vlanif20]ip add 192.168.2.254 24
[]dis ip interface brief
```

## 生成树

### STP 配置

```cmd
[]stp enable
[]stp mode stp
[]dis stp
[]dis stp brief
```

1. 配置根交换机

    ```cmd
    []stp priority 0 主根交换机
    []stp root primary 主根交换机，两条命令选一即可
    []stp priority 4096 备份根交换机
    []stp root secondary 备份根交换机，两条命令选一即可
    ```

2. 每台非根交换机上只能有一个根端口

    ```cmd
    []interface ethernet0/0/2
    [ethernet0/0/2]stp cost 2000 更改接口的开销值会影响接口到达根交换机的根路径开销
    ```

### RSTP 基础配置

1. 配置 RSTP 基本功能

    ```cmd
    []stp mode rstp
    ```

2. 配置边缘端口

    ```cmd
    []interface e0/0/1
    [e0/0/1]stp edged-port enable
    ```

### MSTP 基础配置

1. 配置 MSTP 多实例

```cmd
[]stp region-configuration
[mst-region]region-name huawei
[mst-region]revision-level 1
[mst-region]instance 1 vlan 10
[mst-region]instance 2 vlan 20
[mst-region]active region-configuration
# 在同一 MST 域中，必须具有相同域名、修订级别以及 VLAN 到 MSTI 的映射关系
[]dis stp region-configuration
[]dis stp instance 0 brief
[]dis stp instance 1 brief
[]dis stp instance 2 brief
[]stp instance 2 priority 0 配置交换机成为实例 2 中的根交换机
```

## 其他交换技术

### GVRP 基础配置

1. 配置 GVRP 单向注册

    ```cmd
    []gvrp
    []interface g0/0/1
    [g0/0/1]gvrp
    ```

2. 配置 GVRP 双向注册
3. 配置 GVRP 的 Fixed 模式

    ```cmd
    []interface g0/0/1
    [g0/0/1]gvrp registration fixed
    ```

4. 配置 GVRP 的 Forbidden 模式

    ```cmd
    []int g0/0/1
    [g0/0/1]gvrp registration forbidden
    ```

### Smart Link 与 Monitor Link

1. 配置 Smart Link

    ```cmd
    []smart-link group 1
    [smlk-group1]smart-link enable
    []interface Ethernet 0/0/3
    [e0/0/3]stp disable
    []interface Ethernet 0/0/4
    [e0/0/4]stp disable
    []smart-link group 1
    [smlk-group1]port Ethernet 0/0/3 master
    [smlk-group1]port Ethernet 0/0/4 slave
    []dis smart-link group 1
    ```

2. 配置回切功能

    ```cmd
    []smart-link group 1
    [smlk-group]restore enable
    [smlk-group]timer wtr 30
    ```

3. 配置 Monitor Link

    ```cmd
    []monitor-link group 1
    [mtlk-group]port g0/0/1 uplink
    [mtlk-group]port e0/0/3 downlink
    [mtlk-group]timer recover-time 10
    ```

### 配置 Eth-Trunk 链路聚合

1. 手工负载分担模式（需要手动创建链路聚合组，并配置多个接口加入到所创建的 Eth-Trunk 中）

    ```cmd
    []interface Eth-Trunk 1
    [Eth-Trunk1]mode manual load-balance
    []interface g0/0/1
    [g0/0/1]eth-trunk 1
    []interface g0/0/2
    [g0/0/2]eth-trunk 1
    []dis eth-trunk 1
    []dis interface eth-trunk 1
    ```

2. 静态 LACP 模式（该模式通过 LACP 协议协商 Eth-Trunk 参数后自主选择活动接口）

    ```cmd
    []interface Eth-Trunk 1
    [Eth-Trunk1]mode lacp-static
    []int g0/0/1
    [g0/0/1]eth-trunk 1
    []int g0/0/2
    [g0/0/2]eth-trunk 1
    []int g0/0/5
    [g0/0/5]eth-trunk 1
    []dis eth-trunk 1
    []lacp priority 100
    []dis eth-trunk 1
    []int Eth-Trunk 1
    [Eth-Trunk]max active-linknumber 2
    []int g0/0/1
    [g0/0/1]lacp priority 100
    []int g0/0/2
    [g0/0/2]lacp priority 100
    []dis eth-trunk 1
    ```

## 静态路由

```cmd
[]ip route-static 192.168.20.0 255.255.255.0 10.0.12.2
[]ip route-static 192.168.10.0 24 serial 0/0/1
默认路由：[]ip route-static 0.0.0.0 0 10.0.12.2
```

## OSPF

### 配置 OSPF 的认证

1. 配置公司分部 OSPF 区域明文认证

    ```cmd
    [R1]ospf 1
    [R1-ospf-1]area 1
    [R1-ospf-1-area-0.0.0.1]authentication-mode simple plain huawei1 查看配置文件时，口令明文显示
    [R1-ospf-1-area-0.0.0.1]dis this
    [R1-ospf-1-area-0.0.0.1]authentication-mode simple huawei1 重新配置，并取消 plain
    [R1-ospf-1-area-0.0.0.1]dis this
    [R2]ospf 1
    [R2-ospf-1]area 1
    [R2-ospf-1-area-0.0.01]authentication-mode simple huawei1
    <R1>dis ospf peer brief
    [R4]ospf 1
    [R4-ospf-1]area 1
    [R4-ospf-1-area-0.0.0.1]authentication-mode simple huawei1
    ```

2. 配置公司总部 OSPF 区域密文认证

    ```cmd
    [R2]ospf 1
    [R2-ospf-1]area 0
    [R2-ospf-1-area-0.0.0.0]authentication-mode md5 1 huawei3
    [R3]ospf 1
    [R3-ospf-1]area 0
    [R3-ospf-1-area-0.0.0.0]authentication-mode md5 1 huawei3
    [R5]ospf 1
    [R5-ospf-1]area 0
    [R5-ospf-1-area-0.0.0.0]authentication-mode md5 1 huawei3
    [R6]ospf 1
    [R6-ospf-1]area 0
    [R6-ospf-1-area-0.0.0.0]authentication-mode md5 1 huawei3
    ```

3. 配置 OSPF 链路认证

    ```cmd
    [R2]interface g0/0/1
    [R2-g0/0/1]ospf authentication-mode md5 1 huawei5
    [R2]dis ospf peer brief
    [R4]interface g0/0/0
    [R4-g0/0/0]ospf authentication-mode md5 1 huawei5
    ```

### OSPF 被动接口配置

```cmd
[R4]ospf 1
[R4-ospf-1]silent-interface g0/0/1
# 如果 R4 上有多个接口需要设置为被动接口，只有 g0/0/1 接口保持活动状态，可以通过以下命令简化配置
[R4]ospf 1
[R4-ospf-1]silent-interface all
[R4-ospf-1]undo silent-interface g0/0/1
```

### OSPF 开销值、协议优先级及计时器的修改

1. 配置协议优先级

    ```cmd
    [R1]ospf 1
    [R1-ospf-1]preference 110
    [R4]ospf 1
    [R4-ospf-1]preference 110
    [R5]ospf 1
    [R5-ospf-1]preference 110
    ```

2. 配置 OSPF 开销值

    ```cmd
    [R1]interface g0/0/1
    [R1-g0/0/1]ospf cost 1000 OSPF 链路开销值是基于接口修改的，一定要在路由更新的入接口修改才生效
    <R1>dis ip routing-table 10.0.2.0
    ```

3. 配置 OSPF 计时器

    ```cmd
    [R1]int g0/0/1
    [R1-g0/0/1]ospf timer hello 20
    [R1-g0/0/1]ospf timer dead 80
    [R3]int g0/0/0
    [R3-g0/0/0]ospf timer hello 20
    [R3-g0/0/0]ospf timer dead 80
    ```

## VRRP

### VRRP 基本配置

1. 配置 VRRP 协议

```cmd
[]interface Ethernet 1/0/1
[Ethernet1/0/1]vrrp vrid 1 virtual-ip 172.16.1.254
[Ethernet1/0/1]vrrp vrid 1 priority 120
[]dis vrrp
[]dis vrrp brief
[]dis vrrp interface ethernet1/0/1
```

### 配置 VRRP 多备份组

1. 配置 VRRP 双备份组

    ```cmd
    [R2]interface e1/0/1
    [R2-e1/0/1]vrrp vrid 1 virtual-ip 172.16.1.254
    [R2-e1/0/1]vrrp vrid 1 priority 120
    [R2-e1/0/1]vrrp vrid 2 virtual-ip 172.16.1.253
    [R3]interface e1/0/1
    [R3-e1/0/1]vrrp vrid 1 virtual-ip 172.16.1.254
    [R3-e1/0/1]vrrp vrid 2 virtual-ip 172.16.1.253
    [R3-e1/0/1]vrrp vrid 2 priority 120
    []dis vrrp brief
    ```

2. 验证 VRRP 抢占特性

    ```cmd
    [R2]interface e1/0/1
    [R2-e1/0/1]vrrp vrid 2 preempt-mode disable
    [R2-e1/0/1]vrrp vrid 2 priority 200
    ```

3. 配置虚拟 IP 拥有者

    ```cmd
    [R2]interface e1/0/1
    [R2-e1/0/1]ip add 172.16.1.254 24
    [R3]interface e1/0/1
    [R3-e1/0/1]vrrp vrid 1 priority 254
    ```

### 配置 VRRP 的跟踪接口及认证

1. 配置上行接口监视

    ```cmd
    [R2]interface Ethernet1/0/1
    [R2-Ethernet1/0/1]vrrp vrid 1 track interface g0/0/0 reduced 50
    ```

2. 在 Ｒ 2 和 Ｒ 3 上配置 VRRP 认证

    ```cmd
    [R2-e1/0/1]vrrp vrid 1 authentication-mode md5 huawei
    [R3-e1/0/1]vrrp vrid 1 authentication-mode md5 huawei
    []dis vrrp
    ```

## 基础过滤工具

### 配置基本的访问控制列表

- 分为基本的访问控制列表和高级的访问控制列表
- 基本 ACL 编号范围：2000 ～ 2999

1. 配置基本 ACL 控制访问

    ```cmd
    []acl 2000
    [acl-basic-2000]rule 5 permit source 1.1.1.1 0 反掩码为全 0，即精确匹配
    [acl-basic-2000]rule 10 deny source any
    []user-interface vty 0 4
    [ui-vty0-4]acl 2000 inbound
    ```

2. 基本 ACL 的语法规则

    ```cmd
    # ACL 的执行是有顺序性的，如果规则 ID 小的规则已经被命中，并且执行了允许或者拒绝的动作，那么后续的规则就不再继续匹配。
    []dis acl all
    []acl 2000
    [acl-basic-2000]undo rule 15
    [acl-basic-2000]rule 8 permit source 3.3.3.3 0
    ```

### 配置高级的访问控制列表

- 高级 ACL 编号范围：3000 ～ 3999
- 可使用报文的源 IP，目的 IP，IP 优先级，IP 协议类型，ICMP 类型，TCP 源端口/目的端口，UDP 源端口/目的端口等信息来定义规则。

1. 配置高级 ACL 控制访问

```cmd
[]acl 3000
[acl-adv-3000]rule permit ip source 1.1.1.1 0 destination 4.4.4.4 0
[acl-adv-3000]dis acl all
[]user-interface vty 0 4
[ui-vty0-4]acl 3000 inbound
```

### 配置前缀列表

1. 配置 ACL 过滤路由

    ```cmd
    []acl number 2000
    [acl-basic-2000]rule 5 deny source 11.1.1.0 0.0.0.0
    [acl-basic-2000]rule 10 permit source any
    []rip 1
    [rip-1]filter-policy 2000 import
    <>dis ip routing-table
    ```

2. 配置前缀列表过滤路由

    ```cmd
    []ip ip-prefix 1 deny 11.1.1.0 25 greater-equal 25 less-equal 25
    []ip ip-prefix 1 deny 11.1.1.0 25 上一条简写
    []ip ip-prefix 1 permit 0.0.0.0 0 less-equal 32
    [rip-1]filter-policy ip-prefix 1 import
    <>dis ip routing-table
    ```

## 广域网

### WAN 接入配置

1. 配置 PPP

```cmd
[]int s1/0/1
[s1/0/1]link-protocol hdlc
```

### PPP 的认证

1. 配置 PPP 的 PAP 认证

    ```cmd
    [R3]interface s4/0/0
    [R3-s4/0/0]ppp authentication-mode pap domain huawei
    [R3]aaa
    [R3-aaa]authentication-scheme huawei_1
    [R3-aaa-authen-huawei_1]authentication-mode local
    [R3-aaa]domain huaweiyu
    [R3-aaa-domain-huaweiyu]authentication-scheme huawei_1
    [R3-aaa]local-user R1@huaweiyu password cipher Huawei
    [R3-aaa[local-user R1@huaweiyu service-type ppp
    [R1]int s4/0/0
    [R1-s4/0/0]ppp pap local-user R1@huaweiyu password cipher Huawei
    ```

2. 配置 PPP 的 CHAP 认证

    ```cmd
    [R3]int s4/0/0
    [R3-s4/0/0]undo ppp authentication-mode
    [R1]int s4/0/0
    [R1-s4/0/0]undo ppp pap local-user
    [R3]int s4/0/0
    [R3-s4/0/0]ppp authentication-mode CHAP
    [R3]aaa
    [R3-aaa]local-user R1 password cipher huawei
    [R3-aaa]local-user service-type ppp
    [R1]int s4/0/0
    [R1-s4/0/0]ppp chap user R1
    [R1-s4/0/0]ppp chap password huawei
    ```

## DHCP

### 配置基于接口地址池的 DHCP

1. 基本配置

    ```cmd
    [R1]int g0/0/0
    [R1-g0/0/0]ip add 192.168.1.254 24
    [R1-g0/0/0]int g0/0/1
    [R1-g0/0/1]ip add 192.168.2.254 24
    ```

2. 基于接口配置 DHCP Server 功能

    ```cmd
    [R1]dhcp enable
    [R1]int g0/0/0
    [R1-g0/0/0]dhcp select interface
    [R1-g0/0/0]int g0/0/1
    [R1-g0/0/1]dhcp select interface
    ```

3. 配置基于接口的 DHCP Server 租期/DNS 服务器地址

    ```cmd
    [R1]int g0/0/0
    [R1-g0/0/0]dhcp server lease day 2
    [R1-g0/0/0]dhcp server excluded-ip-address 192.168.1.1 192.168.1.10
    [R1-g0/0/0]int g0/0/1
    [R1-g0/0/1]dhcp server dns-list 8.8.8.8
    [R1]dis ip pool
    ```

### 配置基于全局地址池的 DHCP

1. 基本配置

    ```cmd
    [R1]int g0/0/0
    [R1-g0/0/0]ip add 192.168.1.254 24
    [R1-g0/0/0]int g0/0/1
    [R1-g0/0/1]ip add 192.168.2.254 24
    ```

2. 配置基于全局地址池的 DHCP Server

    ```cmd
    [R1]dhcp enable
    [R1]ip pool huawei1
    [R1-ip-pool-huawei1]network 192.168.1.0
    [R1-ip-pool-huawei1]lease day 2
    [R1-ip-pool-huawei1]gateway-list 192.168.1.254
    [R1-ip-pool-huawei1]excluded-ip-address 192.168.1.250 192.168.1.253
    [R1-ip-pool-huawei1]dns-list 8.8.8.8
    [R1]int g0/0/0
    [R1-g0/0/0]dhcp select global
    [R1]ip pool huawei2
    [R1-ip-pool-huawei2]network 192.168.2.0
    [R1-ip-pool-huawei2]lease day 2
    [R1-ip-pool-huawei2]gateway-list 192.168.2.254
    [R1-ip-pool-huawei2]dns-list 8.8.8.8
    [R1-ip-pool-huawei2]int g0/0/1
    [R1-g0/0/1]dhcp select global
    [R1]dis ip pool
    ```

### 配置 DHCP 中继

1. 配置 DHCP 服务器

    ```cmd
    [R3]dhcp enable
    [R3[ip pool dhcp-pool
    [R3-ip-pool-dhcp-pool]network 10.1.1.0 mask 255.255.255.0
    [R3-ip-pool-dhcp-pool]gateway-list 10.1.1.254
    [R3-ip-pool-dhcp-pool]int g0/0/1
    [R3-g0/0/1]dhcp select global
    [R3]dis ip pool
    ```

2. 配置 DHCP 中继

    ```cmd
    # 第一种配置方法
    [R1]dhcp enable
    [R1]int e1/0/1
    [R1-e1/0/1]dhcp select relay
    [R1-e1/0/1]dhcp relay server-ip 100.1.1.1
    # 第二种配置方法
    [R1]dhcp server group dhcp-group
    [R1-dhcp-server-group-dhcp-group]dhcp-server 100.1.1.1
    [R1-dhcp-server-group-dhcp-group]int e1/0/1
    [R1-e1/0/1]dhcp select relay
    [R1-e1/0/1]dhcp relay server-select dhcp-group
    ```

## 其他特性

### SNMP 基础配置

1. 开启 Agent 服务

    ```cmd
    [Agent]snmp-agent
    [Agent]dis snmp-agent sys-info
    ```

2. 配置 SNMP 版本

    ```cmd
    [Agent]snmp-agent sys-info version v3
    [Agent]dis snmp-agent sys-info version
    [Agent]dis snmp-agent sys-info version
    ```

3. 配置 NMS 管理权限

    ```cmd
    [Agent]acl 2000
    [Agent-acl-basic-2000]rule 5 permit source 10.1.1.2 0.0.0.255
    [Agent-acl-basic-2000]rule 10 deny source 10.1.1.1 0.0.0.255
    [Agent]snmp-agent usm-user v3 user group acl 2000
    [Agent]dis snmp-agent usm-user
    ```

4. 配置向 SNMP Agent 输出 Trap 信息

    ```cmd
    [Agent]snmp-agent target-host trap-hostname adminNMS2 address 10.1.1.2 udp-port 9991 trap-paramsname trapNMS2
    [Agent]snmp-agent trap enable
    [Agent]snmp-agent trap queue-size 200
    [Agent]snmp-agent trap life 240
    [Agent]snmp-agent syes-info contact call admin 400-822-9999
    [Agent]snmp-agent sys-info location ShenZhen China
    [Agent]dis snmp-agent sys-info
    [Agent]dis snmp-agent target-host
    ```

### GRE 协议基础配置

1. 配置 GRE Tunnel

    ```cmd
    [R1]interface t 0/0/0
    [R1-t0/0/0]tunnel-protocol gre
    [R1-t0/0/0]source 10.1.12.1
    [R1-t0/0/0]destination 10.1.23.1
    [R1-t0/0/0]ip add 172.16.1.1 24
    [R3]interface tunnel 0/0/0
    [R3-t0/0/0]tunnel-protocol gre
    [R3-t0/0/0]source 10.1.23.1
    [R3-t0/0/0]destination 10.1.12.1
    [R3-t0/0/0]ip add 172.16.1.2 24
    [R1]dis int t0/0/0
    [R3]dis int t0/0/0
    ```

2. 配置基于 GRE 接口的动态路由协议

### 配置 NAT

- NAT 有 3 种类型：静态 NAT、动态地址 NAT 以及网络地址端口转换 NAPT。

1. 配置静态 NAT

    ```cmd
    [R1]ip route-static 0.0.0.0 0.0.0.0 202.169.10.2
    [R1]int g0/0/0
    [g0/0/0]nat static global 202.169.10.5 inside 172.16.1.1
    []dis nat static
    ```

2. 配置 NAT outbound

    ```cmd
    [R1]nat address-group 1 202.169.10.50 202.169.10.60
    [R1]acl 2001
    [R1-acl-basic-2001]rule 5 permit source 172.17.1.0 0.0.0.255
    [R1]int g0/0/0
    [g0/0/0]nat outbound 2001 address-group 1 no-pat
    [R1]dis nat outbound
    ```

3. 配置 NAT Easy-IP

    ```cmd
    [R1]int g0/0/0
    [R1-g0/0/0]undo nat outbound 2001 address-group 1 no-pat
    [R1-g0/0/0]nat outbound 2001
    [R1]dis nat session protocol udp verbose
    ```

4. 配置 NAT Server

    ```cmd
    [R1]int g0/0/0
    [R1-g0/0/0]nat server protocol tcp global 202.169.10.6 ftp inside 172.16.1.3 ftp
    [R1-g0/0/0]quit
    [R1]nat alg ftp enable
    [R1]dis nat server
    ```
