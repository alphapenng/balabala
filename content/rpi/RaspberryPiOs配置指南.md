<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-02-02 08:46:36
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-02-02 12:57:27
 * @FilePath: /balabala/content/private/RaspberryPiOs配置指南.md
-->

# Raspberry Pi Os 配置指南

- [Raspberry Pi Os 配置指南](#raspberry-pi-os-配置指南)
  - [安装 OS](#安装-os)
  - [更新和升级系统](#更新和升级系统)
    - [通过 APT 更新和升级](#通过-apt-更新和升级)
  - [安装输入法](#安装输入法)
  - [基本配置](#基本配置)
    - [`raspi-config` 工具](#raspi-config-工具)
    - [配置网络](#配置网络)
      - [设置静态 ip](#设置静态-ip)
    - [外部存储配置](#外部存储配置)
      - [挂载外部存储设备](#挂载外部存储设备)
      - [配置自动挂载](#配置自动挂载)
      - [卸载外部存储](#卸载外部存储)
  - [远程接入](#远程接入)

## 安装 OS

打开[镜像下载页面](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit)下载镜像并通过 `balenaEtcher` 写入 SD 卡中，我的树莓派是 `4b 4GB` 版本，下载的镜像版本为：

```bash
Raspberry Pi OS with desktop
Release date: September 22nd 2022
System: 32-bit
Kernel version: 5.15
Debian version: 11 (bullseye)
Size: 894MB
```

## 更新和升级系统

### 通过 APT 更新和升级

软件源列表在系统 `/etc/apt/sources.list` 文件内，在安装软件之前，你应该更新你的软件源列表至最新。通过以下命令更新你的软件源：

```bash
sudo apt update
```

然后，通过以下命令升级你所有已安装的软件至最新版本：

```bash
sudo apt full-upgrade
```

- 搜索软件

    ```bash
    apt-cache search <package-keyword>
    ```

    显示包的详细信息

    ```bash
    apt-cache show <package>
    ```

- 安装软件

    ```bash
    sudo apt install <package>
    ```

- 卸载软件

    ```bash
    sudo apt remove <package>
    ```

    或者通过以下命令连同软件相关配置一并卸载：

    ```bash
    sudo apt purge <package>
    ```

## 安装输入法

```bash
sudo apt update
sudo apt install -y fcitx fcitx-googlepinyin
# 等待安装完成后重启
sudo reboot
```

## 基本配置

### `raspi-config` 工具

命令行环境下通过以下命令打开配置菜单：

```bash
sudo raspi-config
```

### 配置网络

#### 设置静态 ip

编辑系统文件 `/etc/dhcpcd.conf`，例如：

```bash
interface eth0
static ip_address=192.168.0.4/24
static routers=192.168.0.254
static domain_name_servers=192.168.0.254 8.8.8.8
```

### 外部存储配置

#### 挂载外部存储设备

1. 插入外部存储设备
2. 通过以下命令列出所有的磁盘分区：

    ```bash
     sudo lsblk -o UUID,NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL,MODEL
     ```

3. 找到你的外部存储设备，例如 `sda1`
4. `FSTYPE` 列显示你的存储设备文件系统类型。如果你的存储设备文件系统类型是 `exFAT`，请安装 `exFAT` 驱动：

    ```bash
    sudo apt update
    sudo apt install exfat-fuse
    ```

5. 如果你的存储设备文件系统类型是 `NTFS`，请安装 `ntfs-3g` 驱动：

    ```bash
    sudo apt update
    sudo apt install ntfs-3g
    ```

6. 通过以下命令定位到你要挂载的分区，例如 `/dev/sda1`：

    ```bash
    sudo blkid
    ```

7. 新建一个文件夹，用来作为外部存储设备的挂载点：

    ```bash
    sudo mkdir /mnt/mydisk
    ```

8. 挂载外部存储设备

    ```bash
    sudo mount /dev/sda1 /mnt/mydisk
    ```

9. 检查是否挂载成功

    ```bash
    ls /mnt/mydisk
    ```

#### 配置自动挂载

1. 查询磁盘分区的 `UUID`

    ```bash
    sudo blkid
    ```

2. 复制需要自动挂载设备的 `UUID`，例如 `5C24-1453`
3. 编辑 `fstab` 文件

    ```bash
    sudo vim /etc/fstab
    ```

4. 将以下内容添加至 `fstab` 文件，`UUID` 改成你自己的 `UUID`，`fstype` 改成你自己的文件系统类型，例如 `ntfs`

    ```bash
     UUID=5C24-1453 /mnt/mydisk fstype defaults,auto,users,rw,nofail 0 0
    ```

5. 如果文件系统是 `FAT` 或 `NTFS`，在 `nofail` 之后要加上 `,umask=000`，这会允许所有的用户对挂载的设备有读写权限。

:warning: 如果你在系统启动时没有插入自动挂载的外部存储设备，系统会在启动时多花费 90s，如果你想缩短这个时间，请在 `nofail` 后再直接加上 `,x-systemd.device-timeout=30`，这会导致系统只会等待 30s 然后放弃自动挂载操作。:warning:

#### 卸载外部存储

```bash
sudo umount /mnt/mydisk
```

💁 如何处理 `target is busy` 问题：

出现 `target is busy` 提示意味着有程序正在使用目标存储设备中的文件。请按照以下步骤处理：

1. 关闭正在使用目标存储设备中文件的程序。
2. 如果终端打开，确保你不在挂载目标存储设备中的目录或子目录下操作。
3. 如果仍然无法卸载目标存储设备，你可以通过 `lsof` 命令来确认哪些程序正在操作目标存储设备中的文件。首先你需要安装 `lsof` 命令

    ```bash
    sudo apt update
    sudo apt install lsof
    ```

    然后执行 `lsof` 命令，例如：

    ```bash
    lsof /mnt/mydisk
    ```

## 远程接入

