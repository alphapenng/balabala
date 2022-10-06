---
title: "红米 AX6 解锁 SSH 安装 ShellClash 及刷机 Openwrt 教程"
date: 2022-10-06T08:13:14+08:00
draft: false
tags: ["geek","homelab"]
categories: ["geek"]
authors:
- alphapenng
---

红米 AX6 和小米 AX3600 配置基本相同，只是缺少一根智能家居的天线，性价比高的离谱，刷机做软路由转发流量毫无压力，为了在有限的预算内提升家庭网络的体验，前段时间在闲鱼 300 掏了一台红米 AX6，趁着假期跟着别人的教程折腾了一遍所有的刷机方法，也踩了不少坑，记录下来给自己也给别人有个参考，折腾了一遍之后，本人还是采用了直接安装 ShellClash 的方案，目前也就代理流量一个需求，考虑未来可能会根据需求再刷 openwrt。小米路由器目前解锁刷机的方案都已经比较模式了，网上的教程也很多，把它作为家中的主路由刷机再跑软路由是不错的，能够和 AX1800 组 mesh，覆盖和性能都不是问题。

> 本教程是根据 👨‍🎨[卡卡的捣鼓日记](https://b23.tv/OwpIJ7j) 1️⃣ [红米 AX6 Openwrt 刷机教程（解锁步骤 AX6000、AX9000 通用）-哔哩哔哩](https://b23.tv/d1HIfhW) 2️⃣ [玩透红米 AX6 OPENWRT 扩容刷机及 Uboot 刷机-哔哩哔哩](https://b23.tv/iDfgYTq) 👨‍💻 [酱紫表](https://qust.me) 3️⃣ [红米 AX6 解锁 SSH 安装使用 ShellClash 教程](https://qust.me/post/hong-mi-ax6-jie-suo-ssh-an-zhuang-shi-yong-shellclash-jiao-cheng/)学习记录而成

## 前言

红米 AX6 刷 Openwrt 一直有一个十分头疼的问题，由于解锁 SSH 权限是基于 WIFI 中继来实现的，需要使用一台具备无线功能的 OP 路由器作为小米路由器的扩展 WIFI，这意味着刷机前先要准备一台已经刷好 OP 系统的无线路由器。这个要求恐怕会劝退不少人！其实我们可以通过其他方式来变相实现这个需求。今天就给大家介绍一种新方法，仅需一台笔记本电脑或是具备无线网卡的台式机就可以完成刷机工作。

## 刷机类型

小米 AX 系列路由器刷机类型主要分为两类：`不扩容刷机`和`扩容刷机`。

刷个机为什么还要扩容呢？
**这是因为小米 AX 系列路由器分区机制所导致的。**

我们以闪存大小为 128 兆红米 AX6 为例进行讲解，128 兆空间被分为多个分区，其中 `mtd12` 和 `mtd13` 这两个分区存储路由器的固件，对应分区名为 `root_fs` 和 `root_fs1`。不管是小米官方固件还是 OP 固件都只能刷入这两个分区。为什么会有两个分区存放固件呢？这应该是一种安全备份机制，类似于我们主板的双 BIOS。比如原固件在 mtd12 分区，当我们更新固件时，会更新到 mtd13 分区，更新完毕路由器重启后会读取 mtd13 分区的系统文件，以此类推每次更新都会刷入到另一个分区里。极大提高了更新固件的安全性。

凡事都有两面性，双分区可以提高了安全性，但每个分区的容量就变小了，两个分区均只有 `36` 兆大小，而刷入的固件大小更是要控制在 `30` 兆以内。`30` 兆对于小米官方固件来说够用了，但对于 OP 系统而言有些捉襟见肘。如果插件不多勉强够用；如果插件较多则无法满足需求。这时候我们就要对分区进行扩容操作，所以就有了扩容刷机。到此为止大家应该对两种刷机类型有所了解，那他们各自有什么优缺点呢？

**不扩容刷机优点：**

1. 刷机简单省去了扩容的操作步骤。
2. 可实现双系统，由于刷入的 OP 固件大小在 30 兆以内，我们可以把一个分区刷入 OP 固件，一个分区保留官方固件，通过手动设置轻松进行系统切换。
3. 不扩容刷机没有改变分区表，刷机出现问题我们可以使用小米官方修复工具进行修复。

**不扩容刷机缺点：**

1. 刷入 OP 固件必须控制在 `30` 兆以内，无法安装太多插件可玩性一般。

**扩容刷机优点：**

1. 对固件的容量限制小，可玩性更高。
2. 还可以通过刷入 Uboot 更安全快捷进行刷机。

**扩容刷机缺点：**

1. 就是刷机步骤复杂一些，用回官方固件或实现双系统需要重新刷机，
2. 无法使用官方修复工具恢复。

## 准备工作

刷机需要准备的软硬件：

-   硬件方面：
    -   需要准备笔记本电脑或带有无线网卡的台式机一台
    -   网线一根用于连接路由器和电脑
-   软件方面：
    分软件和固件两部分介绍
    -   软件部分
        -   虚拟机软件 virtualbox
        -   文件传输工具 winscp
        -   远程登录工具使用系统自带的 CMD
    -   固件部分
        -   解锁 SSH 用到的官方固件
        -   要刷入的 OP 固件

上面提到的所有软件、部分固件以及刷机文档的[下载链接](https://pan.baidu.com/s/168UqNdURVfcmsewKY4swmg)，提取码：02ba。

为保证刷机安全，在进行操作前，请务必使用网线将电脑与路由器相连。

## 解锁 SSH

解锁 SSH 需要三步：

1. 降级固件
2. 通过虚拟机实现一台 OP 系统的无线路由器
3. 解锁 SSH

### 1 降级固件

AX6 可解锁 SSH 的固件版本为 `1.0.16`或`1.0.18`。我们以`1.0.18`为例。降级固件操作步骤很简单，登录 AX6 的后台，点击右上角的`系统状态`，点击`系统升级`，`选择固件`，系统建议选择`清除当前所有用户配置`，点击确定即可刷新固件，⚠️ 重启后初始化设置请务必取消勾选路由空闲时为您自动升级固件版本 ⚠️，除非你进行了 `SSH 固化`操作，具体操作见[后文介绍](#5-固化-ssh-（可选）)。
![登录 AX6 后台](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_hGCnSV.png)
![点击系统状态](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_h6hwUP.png)
![点击手动升级](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_vy8KGX.png)
![点击选择文件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_y2nym9.png)
![选择固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_RVAMyF.png)
![勾选清除当前所有用户配置](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_LfZooC.png)
![取消勾选路由空闲时自动升级](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_Qvsxo4.png)

### 2 通过虚拟机实现一台 OP 系统的无线路由器

小米 AX 系列路由器解锁 SSH 需要一台具有无线功能的 OP 路由器配合，下面我们通过虚拟机安装 OP 系统配合笔记本的无线网卡来模拟一台带无线功能的 OP 路由器。使用的虚拟机软件为 VirtualBox。安装过程全部默认设置即可，安装完成后打开虚拟机软件。点击新建，在名称处填写虚拟机的名称，可以选择虚拟机使用的目录，类型选择`Linux`，版本选择`Other Linux（64bit）`，点击下一步，内存大小默认即可，虚拟硬盘选择“使用已有的虚拟硬盘文件”，点击右侧的文件夹图标，选择提供的镜像文件，点击创建。到此为止 OP 系统的虚拟机就已经创建完毕了。
![新建虚拟机1️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_JAfbcB.png)
![新建虚拟机2️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_5dSV8Z.png)
![新建虚拟机3️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_PI0CmV.png)
![新建虚拟机4️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_PtMELx.png)
![新建虚拟机5️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_Z8H45p.png)

下面进行一下网络设置，让其能够正常访问。点击`设置`，选择`网络`，在网卡 1 选项卡的连接方式中，选择`“仅主机网络”`，界面名称会自动选择安装 virtualbox 时创建的虚拟网卡。确保`“启用网络连接”`为选中状态后点击 OK。我们启动虚拟机，OP 系统默认登录 IP 地址为`192.168.5.1`，所以我们要到 windows 网络设置中将 virtualbox 虚拟网卡的 ip 地址设置为同网段地址。输入 `192.168.5.2`，子网掩码为 `255.255.255.0`。等待系统启动完毕后，就可通过 ip 地址访问 OP 啦！我们打开浏览器输入 `192.168.5.1`，用户名 `root`，密码默认为 `password`。OK！正常登录！到此为止我们制作好了一台 OP 系统的有线路由器。
![网络设置1️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_1BpVrm.png)
![网络设置2️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_X9Ph7D.png)
![网络设置3️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_OPfgK6.png)

下面我们要对它进行一些初始化工作，设置内容很简单，就是更改 ip 地址，设置 AP 模式等相关操作。不用我们亲自设置，执行一个文件即可。
我们需要使用 `winscp` 将文件上传到 OP 路由器中。将软件进行默认设置安装后，打开软件会弹出登录界面，文件协议选择 `SCP`，主机名输入虚拟机的地址 `192.168.5.1`，用户名 `root`、密码 `password`，点击登录。弹出警告点击`是`即可打开主界面，整个界面的右半部分是 OP 的文件系统；左半部分的是我们电脑的文件系统，我们把 `wireless.sh` 文件上传到 `root` 目录下。然后在 windows 搜索栏中输入 `CMD`，打开 `CMD`。输入下面这行命令 `ssh root@192.168.5.1` 通过 SSH 登录 OP。如果弹出这个警告，我们按照提示删除警告中 `.ssh` 文件夹后重新登录，输入`“yes”`，再输入 OP 登录默认密码 `password`，即可登录 OP 的 SSH 后台。输入下面这行命令 `sh /root/wireless.sh` 点击回车，会弹出注意事项，再次点击回车即可。初始化设置完毕后，会弹出 `restart network`，重启网卡的提示，上面有一个[链接](http://192.168.31.1/cgi-bin/luci/;stok=<STOK>/api/xqsystem/extendwifi_connect_inited_router?ssid=MEDIATEK-ARM-IS-GREAT&password=ARE-YOU-OK&admin_username=root&admin_password=admin&admin_nonce=xxx)，我们把它复制下来后面会用到。到此为止 OP 路由器初始化设置也完成了。
![初始化工作1️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_WrDNZT.png)
![初始化工作2️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_bgAGQh.png)
![初始化工作3️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_ageqvi.png)
![初始化工作4️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_xAKZEi.png)
![初始化工作5️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_a3DZVY.png)
![初始化工作6️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_q95gyU.png)

下面我们要给他装上无线网卡，让它变成一台具有无线功能的 OP 路由器，我们需要利用 windows 的移动热点来实现。开启移动热点有个前提条件，确保电脑可访问 internet。我们先使用 wifi 连接家里可正常用网的路由器，之后在搜索栏中输入移动热点，打开设置界面，开启移动热点后点击编辑按钮，设置移动热点的 `ssid` 和`密码`，网络频段选择 `2.4G`。注意关闭`节能选项`，避免发生无连接设备时热点自动关闭的情况。由于移动热点要以`桥接的方式`连接到 OP 路由器，所以需要关闭移动热点的 `DHCP` 功能。在网络设置中`找到移动热点的连接双击打开`，`点击属性`，`关闭 internet 协议版本 4`，`点击确定`！到此为止，移动热点的设置工作就完成了。下面我们将其接入 OP 系统中。先`关闭虚拟机`，`点击设置`，`选择网络`，在网卡 1 的选项卡中将连接方式改为`桥接网卡`，`界面名称选择这个 Microsoft 开头的选项`，这就是我们建立的移动热点。`点击 OK`！`启动 OP`！到此为止一台带有无线功能的 OP 路由器就设置完毕了！
![无线功能1️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_9HuXxK.png)
![无线功能2️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_2a9ffs.png)
![无线功能3️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_HpzXOy.png)
![无线功能4️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_xZiPLG.png)

### 3 解锁 SSH

下面我们就可以利它来解锁 AX6 的 SSH 了。打开 AX6 的后台并登录，将“stock=”后面的字符串`7e633591ff0e2b8ac3d73846fb354297`拷贝下来，
![Img](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_XtkR0S.png)
打开我们初始化设置 OP 时候保存的网址，把字符串粘贴并覆盖`<stok>`的字样。将 `ssid` 和 `password` 改为移动热点的名称和密码，`admin_username` 和 `admin_password` 改为 Openwrt 的用户名和密码。修改完成后我们先简单看一下这个链接 `http://192.168.31.1/cgi-bin/luci/;stok=ee9d9cea23fc167cddf2b5543110d3b3/api/xqsystem/extendwifi_connect_inited_router?ssid=op&password=12345678&admin_username=root&admin_password=password&admin_nonce=xxx`，实际上前半部分是小米路由器的地址，使用了一个 extendwifi 的接口，extendwifi 顾名思义就是扩展 wifi，然后把我们做好的 OP 系统的 wifi 信息及登录信息填入，原理因该就是把 OP 当作扩展 wifi 实现解锁，以上都是我猜的。修改完成后，将连接复制到浏览器中点击回车。大概 20 秒后会弹出这串字符，

```json
{
    "token": "; nvram set ssh_en=1; nvram set uart_en=1; nvram set boot_wait=on; nvram commit; uci set wireless.@wifi-iface[0].key=`mkxqimage -I`; uci commit; sed -i 's/channel=.*/channel=\"debug\"/g' /etc/init.d/dropbear; /etc/init.d/dropbear start;",
    "code": 0
}
```

证明解锁成功。此时我们登录 AX6 的后台，5G 频段 wifi 的密码应该已经改为 SSH 密码了。
![ssh密码](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_pg58Oo.png)
我们也可以通过这个网址 [www.oxygen7.cn/miwifi](www.oxygen7.cn/miwifi) 获取 SSH 密码，在小米路由器后台复制 SN 码，点击 Go，即可弹出密码。

### 4 验证 SSH 并备份

我们打开 CMD，通过 SSH 登录 AX6 `ssh root@192.168.31.1`，输入我们刚刚获取的密码，即可正常登录。到此为止，解锁 SSH 的全部操作就结束了，经测试使用此方法可以成功解锁 AX6、AX3600、AX6000 以及 AX9000，通用性和传统方式没有区别。

链接成功后进行备份

```bash
mkdir /tmp/syslogbackup/
dd if=/dev/mtd9 of=/tmp/syslogbackup/mtd9
```

浏览器请求该地址下载备份 http://192.168.31.1/backup/log/mtd9

### 5 固化 SSH （可选）

默认情况下，当路由器恢复出厂设置或者升级后，相关权限将会丢失，因此我们需要额外的操作以保留它们通过 SSH 连接 AX6。在电脑上将下载好的[脚本](https://github.com/shell-script/unlock-redmi-ax3000/archive/refs/heads/master.zip)上传到红米 AX6，可以通过命令行操作，在 Windows 电脑上打开终端，切换到脚本所在目录，输入以下命令

```bash
scp ax3000.sh root@192.168.31.1:/etc/ax3000.sh
scp fuckax3000 root@192.168.31.1:/etc/fuckax3000
```

![命令行传输脚本](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_HcClrR.png)

也可以通过 `winscp`，文件协议选择 `scp`，输入 AX6 的 IP 地址 `192.168.31.1` ，用户名为 `root`，密码 `SSH 密码`。登录后在右侧路由器的文件系统中选择 `/etc` 文件夹，左侧电脑的文件系统中选择要上传的脚本文件 `ax3000.sh` 和 `fuckax3000`，选中文件，右键单击，选择上传即可。

![winscp上传传输脚本](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_6wm6Ks.png)

然后在红米 AX6 上执行

```bash
sh /etc/ax3000.sh unlock
```

系统会自动重启，路由器会自行重启，重启后执行

```bash
sh /etc/ax3000.sh hack
```

重启完成后你可以联网升级，升级最新的固件可以

💁 **备注：升级固件后丢失 SSH 权限，你也可以 telnet 连接上 AX6 后执行以下命令，即可恢复 SSH。**

```bash
sed -i 's/channel=.*/channel="debug"/g' /etc/init.d/dropbear
/etc/init.d/dropbear start
exit
```

`telnet 192.168.31.1` （用户名是 `root`，密码是`解锁 SSH 得出的密码`）

Windows 和 Mac 默认都没有开启 `telnet` 功能，Windows 可以搜索打开 `telnet` 功能，Mac 可以搜索先安装 `brew`，再通过 `brew` 安装 `telnet`。

## 安装使用 ShellClash

-   重新通过 SSH 连接上红米 AX6 执行安装（请不要使用 telnet 连接安装 ShellClash，否则会乱码；如果执行提示 ssh 连接不上请检查上一步是否执行了）

    ```bash
    sh -c "$(curl -kfsSl https://cdn.jsdelivr.net/gh/juewuy/ShellClash@master/install.sh)" && source /etc/profile &> /dev/null
    ```

    ![执行脚本](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_3Fsft6.png)

-   选择 1 安装到 `/data`，然后再选择 1 确认安装。

    ![步骤1️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_DpSFpP.png)

-   安装好就能使用 `clash` 命令了 ，输入 `clash` 就能进入配置。这里选择 1 让局域网设备都能走代理。

    ![步骤2️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_iLhaPB.png)

-   推荐选择不代理 UDP 也就是 1，然后安装 DashBoard 面板也就能网页直接控制了也就是 1 。

    ![步骤3️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_BOigNj.png)

-   推荐选择 Yacd 面板，界面很好看。选择 3，然后安装目录选择 1 即可。

    ![步骤4️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_cyDEka.png)

    ![步骤5️⃣](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_BqKQUv.png)

-   选择导入配置文件。如果你没有 Clash 的配置文件而是 v2ray、ss、trojan 的订阅链接（你的机场会提供），你可以再选择 1 进行「在线生成 Clash 配置文件」；如果有的话可以选择 2 直接导入配置文件。

-   然后粘贴上你的订阅链接（url 链接），再选择 1 开始生成配置文件。生成配置文件后按 0 返回上层菜单即可。

-   再按 1 选择立即开启 Clash 的服务即可。

-   启动后你可以通过 http://192.168.31.1:9999/ui ，进行节点的切换和规则的选择。当然你再按 4 选择开机启动也可以。

## 不扩容刷入 openwrt 固件

与解锁 SSH 不同，刷 OP 系统不同型号的路由器在操作上有所区别。因为闪存容量不同等原因，导致分区数量和大小也不尽相同，存放固件的系统分区也会有区别，所以下面的刷机方法仅针对红米 AX6。

在刷入固件之前，我们先来查看一下当前系统使用的分区，也就是我们降级固件时刷入的 1.0.18 版本固件所在分区。输入这条命令 `nvram get flag_last_success` 即可查看当前分区，`如果返回数字 0，表示当前系统分区为 mtd12`，`返回数字 1，则表示当前系统分区为 mtd13`。我们点击回车来看一下结果。返回的是数字 0！
![查看当前分区](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_gpePCp.png)
这里有一点需要说明一下，以下刷机操作及切换分区的步骤，`仅针对当前分区的查询结果返回数字 0 的情况`，如果你的查询结果返回 1，刷机操作的相关语句会稍有区别，请到附件的步骤详解中查看，不再单作演示了。返回数字 0，也就是当前系统使用分区为 12 分区，同时也意味着降级前的 1.1.4 版本官方固件在 13 分区。我们的理想方式是`保留 13 分区的固件将 OP 刷入到 12 分区替换 1.0.18 版固件`。实现新版官方固件和 OP 双系统并存。但由于 12 分区正在使用，无法刷入固件。所以我们先要手动切换系统分区。输入这四条命令，

```
nvram set flag_last_success=1
nvram set flag_boot_rootfs=1
nvram commit
reboot
```

切换系统分区为 13 分区并提交修改重启路由器。重启完成后我们可以看到固件版本为 1.1.4，已经切换为 13 分区。
![切换固件版本](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_XHOxio.png)
下面就可以将要刷入的 OP 固件上传到路由器了，打开 `winscp`，文件协议选择 `scp`，输入 AX6 的 IP 地址 `192.168.31.1` ，用户名为 `root`，密码 `SSH 密码`。登录后在右侧路由器的文件系统中选择 `/tmp` 文件夹，左侧电脑的文件系统中选择要上传的 `openwrt 固件`，[下载链接](https://pan.baidu.com/s/1zBtzdk1ERG4SYeTHu-b2lw)，提取码为：`2333`。我们上传 `factory 结尾的固件`即可，`sysupgrade` 为升级固件，一般可在页面端进行升级。
![上传固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_PnWBZt.png)
刷新固件操作很简单。登录 ssh 后，输入这条命令 `ubiformat /dev/mtd12 -y -f /tmp/openwrt-ipq807x-generic-redmi_ax6-squas hfs-nand-factory.ubi` 即可将上传的固件刷入到 12 分区。之后我们输入下面四条命令，

```
nvram set flag_last_success=0
nvram set flag_boot_rootfs=0
nvram commit
reboot
```

切换启动分区为 12 分区并提交重启。
![刷新固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_9nfywQ.png)
重启完成后我们即可登录 OP 系统了。恩山固件默认的 ip 地址为 `192.168.123.1`，用户名为 `root`，密码默认为 `password`。进入系统后我们先进行一下系统升级，选择 `sysupgrade` 文件进行升级，
![系统升级](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_73zUA0.png)
重启后登录系统即可进行初始化设置，硬路由刷 OP 后初始化设置很简单，基本和普通路由器一样！我们先来`设置登录密码`，然后`设置拨号上网`，再`修改一些 wifi 名称和密码设置`，`保存并应用`！等待修改生效后，即可正常使用了！
![设置拨号上网](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_Ogzy2c.png)
![设置 wifi](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_vLLyAG.png)
如果我们用 OP 系统不太顺手，可以随时切换回官方固件。打开终端，输入 openwrt 的 IP 地址 `192.168.123.1` ，用户名为 `root`，密码 `password` 登录 SSH 后，输入下面的三行命令即可。

```
fw_setenv flag_last_success 1
fw_setenv flag_boot_rootfs 1
reboot
```

![切换官方固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_WoG4ym.png)
切换回官方固件分区的命令和刚才切换到 OP 分区命令很像，但又有所区别！这是由于当前所使用的系统不同导致的，`openwrt 切换到小米固件时，使用 fw_setenv`，`从小米固件切换回 openwrt 固件时使用 nvram set`！⚠️ 还有一点需要注意，使用官方固件时，如果未来还想使用 OP 系统，一定关闭自动升级功能，自动升级后会覆盖 OP 系统的分区。⚠️

## 扩容刷入 openwrt 固件

### 扩容刷机原理

所谓扩容就是将多个分区合并为一个分区。AX6 的两个系统分区分别为 `mtd12` 和 `mtd13`，对应的分区名为 `rootfs` 和 `rootfs1`。扩容操作是不是将这两个分区进行合并呢？答案是否定的！实际上扩容操作是将名为 `overlay` 的 `14分区` 并入到 `13分区`，`13分区` 的空间大小约为 `36兆`，`14分区` 的空间大小约为 `31兆`，合并后的空间为共计 `68兆` 左右。相比于扩容前多出近一倍。为我们刷入更大的 OP 固件留有了余地。并且合并后分区名依然为 `rootfs1`。至于为什么不将原有两个系统分区 `12分区` 和 `13分区` 进行合并，我们会在后面讲到！由于扩容操作需要合并分区，合并分区会涉及到修改分区表，我们需要在 `mtd1` 分区刷入扩容分区表，但是官方固件是锁分区的，导致我们没有权限进行扩容操作，所以我们要刷入一个临时的 op 固件，通过它来完成扩容操作。我们刚刚提到过 AX6 的系统分区为 `12分区`和 `13分区`，这意味着无论是官方固件还是 OP 固件，都只能刷入到两个系统分区中，我们将过度固件刷入到 `mtd12分区`，再通过它完成扩容操作。这就是保留 `12分区` 的原因。

**所以扩容刷机共分为三步：**

1. 刷入合并分区使用的临时 OP 固件
2. 合并分区
3. 最后再将 OP 固件刷入到合并分区中

### 扩容刷机实操

首先我们先要刷入临时 OP 固件。刷 OP 固件第一步就是解锁 SSH，有关解锁 SSH 的操作步骤，请阅读[解锁 SSH](#解锁-ssh) 部分。刷机前我们先要将临时 OP 固件上传到路由器的 tmp 文件夹，打开 `winscp`，文件协议选择 `scp`，主机名输入小米路由器 ip 地址 `192.168.31.1`，用户名为 `root`，密码为`解锁 SSH 获取的密码`。登录后我们在右侧的路由器文件系统中选择 `/tmp` 目录，在左侧 windows 文件系统中，选择要上传的临时 OP 固件进行上传。
![上传临时 op 固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_98JaAN.png)
上传完毕后，我们打开 cmd，输入`ssh root@192.168.31.1`这行命令登录 SSH，密码为解锁 SSH 获取的密码，登录完成后输入以下两行命令，

```
nvram set flag_last_success=0
nvram set flag_boot_rootfs=0
nvram commit
```

其中数字 0 代表 12 分区，
这两行命令的含义为`下次启动时将 12 分区作为系统分区`，也就是从 12 分区启动。设置好启动分区了，我们输入这行命令 `mtd write /tmp/xiaomimtd12.bin rootfs`，将上传的临时 op 固件刷入到 `12 分区`。完成后输入 `reboot` 重启路由器。
![刷入临时 op 固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_aWIvXG.png)
稍等片刻后在浏览器中输入临时 OP 固件的默认登录地址 `192.168.1.1`，如果正常打开登录页面表示系统启动完毕。⚠️ 不要通过路由器指示灯判断是否启动完毕，刷入临时 op 固件后指示灯一直处于熄灭状态。⚠️ 临时 op 固件启动完成后，我们就可以进行合并分区的操作了，我们先把合并分区需要用到的分区表文件上传到路由器的 `tmp` 文件夹，打开 `winscp`，文件协议选择 `scp`，ip 地址输入临时 op 固件的默认地址 `192.168.1.1`，默认密码为空。登录成功后，在路由器文件系统选择 `tmp` 目录，在 windows 系统中选择`扩容使用的分区表文件`并将其上传。
![上传分区表文件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_hhOvxq.png)
上传完毕后，打开 cmd，登录 SSH，密码为空。登录完成后依次输入下面两行命令，

```bash
. /lib/upgrade/platform.sh（注意. /之间有个空格）
switch_layout boot; do_flash_failsafe_partition a6minbib "0:MIBIB"
```

由于分区信息存储在 `mtd1` 分区，所以`这两行命令的作用就是解锁 1 分区`，并刷入上传的扩容分区表文件。
![解锁 1 分区刷入上传的扩容分区表文件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_b6JgjC.png)
⚠️ **操作完成后我们一定要将路由器断电重启，也就是重新插拔电源。这里有一点要特别注意，只要是涉及分区表的操作，操作完成后一定要断电重启，否则会导致路由器变砖。** ⚠️ 重启后，我们登录临时 OP 固件的后台，如果能正常打开登录页面表示重启完毕。到此为止扩容操作就完成啦！下面我们来看一下扩容后分区表的变化。我们重新登录 SSH `ssh root@192.168.1.1`，如果出现公钥报错，删除报错提示的.ssh 目录之后再重新登录，输入 yes 即可登录。登录成功后，输入下面这行命令 `cat /proc/mtd` 来查看一下分区表，我们可以看到原先的名为 `overlay` 的 `14 分区` 不见了，
![查看分区表](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_KiYNhJ.png)
我们再输入这条命令 `cat /proc/partitions` 来看看分区大小，我们可以看到名为`rootfs1`的`13 分区` 变为 `68 兆`，和我们在扩容原理中讲解的合并分区的大小一致，此时两根分区已经合并成功！
![查看分区大小](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_EZHJZ0.png)

下面我们将 OP 系统刷入到 `13 分区`就可以完成扩容刷机的操作了！首先我们要上传要刷入的 OP 固件。打开 `winscp`，文件协议选择 `scp`，ip 地址为 `192.168.1.1`，密码为空，登陆成功后，我们在右侧路由器文件系统中选择 `tmp` 文件夹，windows 系统选择要刷入的 OP 固件后进行上传。我们可以看到这次上传的 OP 固件大小为 50 兆，远远超过不扩容刷机固件小于 30 兆的限制，并且距离 68 兆的系统分区大小也还有余量，方便后期安装插件。
![上传 op 固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_Ckzds0.png)
上传完毕后，我们打开 SSH，输入这条命令 `ubiformat /dev/mtd13 -y -f /tmp/openwrt-ipq807x-generic-xiaomi_ax6-squashfs-nand-factory.bin`，将上传的 OP 固件刷入到 13 分区。完成后，我们输入下面三条命令，

```bash
fw_setenv flag_last_success 1
fw_setenv flag_boot_rootfs 1
reboot
```

将启动分区切换为 13 分区后重启。
![Img](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_0zN0G4.png)
如果您刷入是我在附件中提供的 OP 固件，默认登录地址 `192.168.1.1`，打开登录页面后，点击登录按钮即可进入 OP 系统的后台。到此为止扩容刷机的所有步骤就完成了。

### 刷回官方固件原理

如果您使用 OP 不太顺手，想刷回官方固件也是可行的。我们需要进行两步操作：

-   首先刷入官方固件到 12 分区
-   然后在 1 分区刷回官方分区表（将合并后 13 分区恢复为原始的 13 分区和 14 分区！）

### 刷回官方固件实操

我们先打开 `winscp`，文件协议选择 `SCP`，地址为我们刷入 op 固件的登录地址 `192.168.1.1`，用户名 `root`，密码为空。登陆成功后，在路由器的文件系统中选择 `tmp` 文件夹，在 windows 的系统中上传 ax6 的官方固件以及官方分区文件。
![上传 ax6 官方固件和官方分区文件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_GyzJPQ.png)
上传完毕后我们登录 ssh `ssh root@192.168.1.1` 进行刷机操作，如果出现公钥报错，如法炮制，删除 .ssh 文件夹后从重新进行登录。登录完成后，输入这条命令 `ubiformat /dev/mtd12 -y -f /tmp/AX6_1.1.4.ubi` 将刚刚上传的官方固件刷入到 12 分区。之后输入这条命令 `mtd write /tmp/ybmibib.bin /dev/mtd1`，将分区表文件刷入 1 分区。操作完成后，输入下面两条命令，

```
fw_setenv flag_last_success 0
fw_setenv flag_boot_rootfs 0
```

将启动分区改为 12 分区。
![刷回官方固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_zbXJRR.png)
完成后重启路由器即可！
⚠️ 此处要特别注意，由于我们刚刚修改了分区表，所以一定进行断电重启。⚠️ 重启完成后我们打开浏览器输入 `192.168.31.1`，即可打开小米路由器官方固件的初始化页面。到此为止，刷回官方固件的操作就完成了。

### Uboot 刷机原理

如果扩容刷机的分区容量依然无法满足需求，那么你可以考虑 Uboot 刷机！Uboot 刷机属于扩容刷机的一种，同样涉及修改分区表，所以我们同样先要刷入 OP 系统，在 OP 系统下才能进行 uboot 刷机的相关操作。刷入 OP 系统的方法使用刷入临时 OP 的方法即可。

Uboot 刷机操作分为两步：

-   合并分区
-   刷入引导程序

合并分区通过将扩容分区表刷入到 mtd1 分区，从而把 12、13、14 分区进行合并，合并后的系统分区可达 `104 兆`，这已经是 AX6 128 兆闪存的极限了。

刷入引导程序是在 mtd7 分区刷入改版的 uboot 引导程序替换官方 uboot 引导程序。

刷入改版引导程序有两点好处：

-   第一点 改版引导程序具有图形化界面，`可以让我们在 web 端实现刷机操作`，相比前面讲解的命令行刷机方式，大大简化了刷机步骤！
-   第二点 由于引导程序是先于路由器固件启动的，所以在路由器固件出现任何问题时，我们都可以通过引导程序的图形化界面重新刷机，`基本避免了固件原因导致路由器变砖的风险`！

当然 uboot 刷机的缺点也是有的:

-   经过实验目前只能通过 ttl 的方式刷回官方固件。对于小白用户来说并不友好，希望未来会有更简便的刷回官方固件的方法。

### Uboot 刷机实操（谨慎尝试）

[刷机文件购买链接](https://mianbaoduo.com/o/anyun/work)

首先上传要刷入的文件，打开 `winscp`，文件协议选择 `scp`，主机名为 `192.168.1.1`，用户名 `root`，密码为空，成功登录后在路由器系统选择 `tmp` 文件夹，在 windows 系统中选择扩容分区表文件和改版 uboot 文件进行上传。

上传完毕后，打开 cmd 登录 ssh，输入下面两行命令，

```bash
mtd erase /dev/mtd1
mtd write /tmp/ax6-mibib.bin /dev/mtd1
```

擦除 `mtd1` 分区，再写入刚上传的扩容分区表文件。完成后再输入下面两行命令，

```
mtd erase /dev/mtd7
mtd write /tmp/uboot-redmi-ax6.bin /dev/mtd7
```

擦除 `mtd7` 分区并写入刚上传的改版 uboot 引导程序。⚠️ 我们刚刚修改了分区表，写入完成后一定要记得断电重启！⚠️

由于我们把两个系统分区和 overlay 分区进行了合并，当前路由器中是没有安装系统的，所以我们先要登录改版 uboot 的图形化界面刷入 OP 固件。启动 uboot 图形化界面的方式很简单，使用网线将电脑与路由器相连后先按住 `reset` 按钮再接通电源，大概五秒钟后松开 `reset` 按钮即可。图形化界面的登录地址为 `192.168.1.1`，所以我们要在网络设置中，将连接 ax6 的网卡 ip 地址设置为`192.168.1` 网段的任一地址。修改完成后，打开浏览器输入 `192.168.1.1` 即可进入 uboot 图形化界面。点击选择文件，在电脑中选取我们要刷入的 OP 固件后，点击 `update firmware` 即可刷入固件。刷入完成后路由器会自动重启。等待过程中，我们先把 ip 地址改回自动获取。如果您刷入的是附件中提供的 op 固件，重启成功后，在浏览器中输入 `192.168.1.1` 即可打开 OP 登录页面。uboot 刷机的所有操作就完成了。

### 总结

红米 AX6 基本就这些刷机方法，得益于红米 AX6 超强的 CPU + NPU 组合，跑代理速度是真不错。ShellClash 这种方案虽然没有图形化 UI 操作方便，但好在不需要刷麻烦也不稳定的 openwrt 固件，直接小米官方固件也能享受到网络「加速」的福利。所以推荐部署 ShellClash 方案。如果你还有其他更多的需求，那还是得安装 openwrt。

红米 AX6 目前解锁 SSH 稍微有点麻烦，不过胜在性价比高。如果你动手能力强，喜欢折腾，我还是更推荐你购买 AX6， 如果想省点精力也可以看看其他的小米路由器，解锁 SSH 没有 AX6 复杂，性价比也都不错。
