---
2022-10-10 15:12:55
---

# axt1800 手动安装 openclash

-   客户端 ipk 下载 [前往下载](https://github.com/vernesong/OpenClash/releases)
-   内核下载，同步开发分支，下载解压后请上传至 `/etc/openclash/core/clash` 并给权限 [前往下载](https://github.com/vernesong/OpenClash/releases/tag/Clash)
-   IPK 文件安装步骤

```bash
#安装依赖
#iptables
opkg update
opkg install coreutils-nohup bash iptables dnsmasq-full curl ca-certificates ipset ip-full iptables-mod-tproxy iptables-mod-extra libcap libcap-bin ruby ruby-yaml kmod-tun kmod-inet-diag unzip luci-compat luci luci-base

#上传IPK文件至您路由器的 /tmp 目录下

#假设安装包名字为
luci-app-openclash_0.33.7-beta_all.ipk

#执行安装命令
opkg install /tmp/luci-app-openclash_0.33.7-beta_all.ipk

#执行卸载命令
#插件在卸载后会自动备份配置文件到 /tmp 目录下，除非路由器重启，在下次安装时将还原您的配置文件
opkg remove luci-app-openclash

安装完成后刷新LUCI页面，在菜单栏 -> 服务 -> OpenClash 进入插件页面
```
