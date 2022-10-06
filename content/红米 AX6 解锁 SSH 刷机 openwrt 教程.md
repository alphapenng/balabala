---
2022-10-05 15:32:45
---

# 红米 AX6 解锁 SSH 刷机 openwrt 教程

[toc]{type: "ul", level: [2,3]}

> 本教程是根据 B 站 UP 主 [卡卡的捣鼓日记](https://b23.tv/OwpIJ7j) > [红米 AX6 Openwrt 刷机教程（解锁步骤 AX6000、AX9000 通用）-哔哩哔哩](https://b23.tv/d1HIfhW)学习记录而成

{{< bilibili BV1sz4y197L8 10 >}}

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

AX6 可解锁 SSH 的固件版本为 `1.0.16`或`1.0.18`。我们以`1.0.18`为例。降级固件操作步骤很简单，登录 AX6 的后台，点击右上角的`系统状态`，点击`系统升级`，`选择固件`，系统建议选择`清除当前所有用户配置`，点击确定即可刷新固件。
![登录 AX6 后台](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_hGCnSV.png)
![点击系统状态](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_h6hwUP.png)
![点击手动升级](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_vy8KGX.png)
![点击选择文件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_y2nym9.png)
![选择固件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_RVAMyF.png)
![勾选清除当前所有用户配置](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_05_LfZooC.png)

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
打开我们初始化设置 OP 时候保存的网址，把字符串粘贴并覆盖`<stok>`的字样。将 `ssid` 和 `password` 改为移动热点的名称和密码，`admin_username` 和 `admin_password` 改为 Openwrt 的用户名和密码。修改完成后我们先简单看一下这个链接 `http://192.168.31.1/cgi-bin/luci/;stok=7e633591ff0e2b8ac3d73846fb354297/api/xqsystem/extendwifi_connect_inited_router?ssid=op&password=12345678&admin_username=root&admin_password=password&admin_nonce=xxx`，实际上前半部分是小米路由器的地址，使用了一个 extendwifi 的接口，extendwifi 顾名思义就是扩展 wifi，然后把我们做好的 OP 系统的 wifi 信息及登录信息填入，原理因该就是把 OP 当作扩展 wifi 实现解锁，以上都是我猜的。修改完成后，将连接复制到浏览器中点击回车。大概 20 秒后会弹出这串字符，

```json
{
    "token": "; nvram set ssh_en=1; nvram set uart_en=1; nvram set boot_wait=on; nvram commit; uci set wireless.@wifi-iface[0].key=`mkxqimage -I`; uci commit; sed -i 's/channel=.*/channel=\"debug\"/g' /etc/init.d/dropbear; /etc/init.d/dropbear start;",
    "code": 0
}
```

证明解锁成功。此时我们登录 AX6 的后台，5G 频段 wifi 的密码应该已经改为 SSH 密码了。
![ssh密码](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_10_06_pg58Oo.png)
我们也可以通过这个网址 [www.oxygen7.cn/miwifi](www.oxygen7.cn/miwifi) 获取 SSH 密码，在小米路由器后台复制 SN 码，点击 Go，即可弹出密码。我们打开 CMD，通过 SSH 登录 AX6，输入我们刚刚获取的密码，即可正常登录。到此为止，解锁 SSH 的全部操作就结束了，经测试使用此方法可以成功解锁 AX6、AX3600、AX6000 以及 AX9000，通用性和传统方式没有区别。

## 不扩容刷入 openwrt 固件

与解锁 SSH 不同，刷 OP 系统不同型号的路由器在操作上有所区别。因为闪存容量不同等原因，导致分区数量和大小也不尽相同，存放固件的系统分区也会有区别，所以下面的刷机方法仅针对红米 AX6。

在刷入固件之前，我们先来查看一下当前系统使用的分区，也就是我们降级固件时刷入的 1.0.18 版本固件所在分区。输入这条命令 ``即可查看当前分区，`如果返回数字 0，表示当前系统分区为 mtd12`，`返回数字 1，则表示当前系统分区为 mtd13`。我们点击回车来看一下结果。返回的是数字1！这里有一点需要说明一下，以下刷机操作及切换分区的步骤，`仅针对当前分区的查询结果返回数字 1 的情况`，如果你的查询结果返回 0，刷机操作的相关语句会稍有区别，请到附件的步骤详解中查看，不再单作演示了。返回数字 1，也就是当前系统使用分区为 13 分区，同时也意味着降级前的 1.1.10 版本官方固件在 12 分区。我们的理想方式是`保留 12 分区的固件将 OP 刷入到 13 分区替换 1.0.18 版固件`。实现新版官方固件和 OP 双系统并存。但由于 13 分区正在使用，无法刷入固件。所以我们先要手动切换系统分区。输入这四条命令，切换系统分区为 12 分区并提交修改重启路由器。重启完成后我们可以看到固件版本为 1.1.10，已经切换为 12 分区。

下面就可以将要刷入的 OP 固件上传到路由器了，打开 winscp，文件协议选择 scp，输入 AX6 的 IP 地址 ，用户名为 root，密码 SSH 密码。登录后在右侧路由器的文件系统中选择/tmp 文件夹，左侧电脑的文件系统中选择要上传的 openwrt 固件，我们上传 factory 结尾的固件即可，sysupgrade 为升级固件，一般可在页面端进行升级。刷新固件操作很简单。登录 ssh 后，输入这条命令即可将上传的固件刷入到 13 分区。之后我们输入下面四条命令，切换启动分区为 13 分区并提交重启。

重启完成后我们即可登录 OP 系统了。Lean 固件默认的 ip 地址为 192.168.1.1，用户名为 root，没有设置密码。进入系统后我们先进行一下系统升级，选择 sysupgrade 文件进行升级，重启后登录系统即可进行初始化设置，硬路由刷 OP 后初始化设置很简单，基本和普通路由器一样！我们先来设置登录密码，然后设置拨号上网，再修改一些 wifi 名称和密码设置，保存并应用！等待修改生效后，即可正常使用了！

如果我们用 OP 系统不太顺手，可以随时切换回官方固件。登录 SSH 后，输入下面的三行命令即可。细心的小伙伴会发现，切换回官方固件分区的两条命令和刚才切换到 OP 分区命令很像，但又有所区别！这是由于当前所使用的系统不同导致的，openwrt 切换到小米固件时，使用 fw_setenv，从小米固件切换回 openwrt 固件时使用 nvram set，小伙伴们不要搞错了哦！还有一点需要注意，使用官方固件时，如果未来还想使用 OP 系统，一定关闭自动升级功能，自动升级后会覆盖 OP 系统的分区。
