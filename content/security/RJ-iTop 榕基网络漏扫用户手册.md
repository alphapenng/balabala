<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2021-08-09 16:08:54
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-01-15 21:51:40
 * @FilePath: /balabala/content/private/RJ-iTop 榕基网络漏扫用户手册.md
-->

# RJ-iTop 榕基网络漏扫用户手册

- [RJ-iTop 榕基网络漏扫用户手册](#rj-itop-榕基网络漏扫用户手册)
  - [产品功能介绍](#产品功能介绍)
  - [产品部署方式](#产品部署方式)
  - [产品操作使用说明](#产品操作使用说明)

## 产品功能介绍

- 漏洞扫描功能
- 资产管理功能
- 漏洞管理功能
- 安全管理功能
- 策略管理功能
- 统计分析功能

## 产品部署方式

![榕基漏扫产品部署方式](https://i.imgur.com/bTi7u3d.png)

## 产品操作使用说明

- 系统设置
  - 系统初始设置
    - `初始 IP：192.168.14.50，初始用户名：security，密码：security。`
    - 系统开放的各端口号及功能如下：
      - `80 http 协议`
      - `443 https 协议`
      - `10851 分布管理消息传输`
      - 若将机架式产品放置于防火墙之后，为保证系统正常使用，要求在防火墙中设置允许连接机架式产品的以上端口。
  - 控制台使用说明

    ```bash
    # 查看对应网卡的当前网络配置
    ifconfig [eth0/eth1/eth2/eth3,-7]
    # 进行对应网卡的网络配置设置
    netconfig [eth0/eth1/eth2/eth3,-7]
    # 用来检查网络是否连通
    ping 192.168.0.1
    # 初始化机架式 WEB 安全保密管理员账号和密码
    init security
    # 初始化系统管理账户
    init system
    # 初始化审计管理员
    init audit
    # 查看机架式的路由表
    route
    # 跟踪路由
    traceroute 192.168.0.1
    # 备份当前数据库
    stock
    # 恢复备份的数据库
    restore
    # 恢复产品出厂设置
    comeback
    # 推出登录
    logout
    # 清屏
    clear
    ```

- 用户登录
- 资产管理
  - 分组管理
  - 级联管理
- 安全扫描
  - 安全扫描菜单包括六个功能子模块，即：`新建扫描`、`任务管理`、`配置管理`、`策略管理`、`生成报表`和`分险查询`。
- 常用工具
  - 密码猜测
    - 密码破解可对八种常见的服务（`SMB 服务，FTP 服务，TELNET 服务，POP3 服务，SQLSERVER 服务，MYSQL 服务，ORACLE 服务，SYBASE 服务`）畸形账号密码破解。
  - 端口扫描
  - 目标检测
- 系统管理
  - 用户管理
  - 角色管理
  - 数据字典
  - 日志管理
  - 系统升级
  - 数据备份
  - 系统配置
  - 关机重启
