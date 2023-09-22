> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [juejin.cn](https://juejin.cn/post/7271195040918798396)

前言
--

基于我个人的工作内容和兴趣，想要在家里搞一套服务器集群，用于容器 / K8s 等方案的测试验证。

考虑过使用二手服务器，比如 Dell R730, 还搞了一套配置清单，如下：

*   Dell R730
*   3.5 尺寸规格硬盘
*   CPU: 2686v4*2
*   内存：16g*8
*   存储：480Gintel ssd 系统盘 + 6tsas 希捷 * 2 个数据盘
*   RAID 卡：h730 卡
*   电源：单电 750w
*   盘架满
*   价格大约是 3130 元

再来套服务器机柜。..

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/87e86a83b356718ae914220db7a5efbe-20230825142138.png)

但是考虑到功率和噪音太大了，家里也没有适合放服务器的这么大的地，最终放弃了。😂

也考虑过用单片的 arm 开发板，但是需要搞好几片，然后编译系统、刷机、装合适的壳子、找电源线和网线，再接入家庭网络。.. 一台一台折腾，太耗时间了。

即使最后搞好了，可能家里也没那么多的网口，还得买个交换机接入。..

最后，功夫不负有心人，在闲鱼上找到了结合二者形态，看起来像服务器的 ARM 开发板矩阵 - Firefly Cluster Server. 很适合我的需求👍️, 一起看看吧

Firefly Cluster Server - ARM 开发板矩阵
----------------------------------

### 服务器全貌

我们先来看一下它的全貌：

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/3f57aba82ee3ecde3824e0b0786ec869-firefly_cluster_server.jpg)

就是一个小尺寸的服务器的样子，但是千万不要被它的外形迷惑了。它和 x86 的服务器内部完全不一样。

这个是基于 [Firefly Cluster Server R1](https://wiki.t-firefly.com/zh_CN/Cluster-Server-R1/Firefly_Cluster_server_product_documentation.html "https://wiki.t-firefly.com/zh_CN/Cluster-Server-R1/Firefly_Cluster_server_product_documentation.html") - core-3399-jd4 * 11 那款的定制款，接口会少一些。但是内部构造是完全相同的。

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/44c354a2b0231ec57809e0ee4e9819b0-firefly_cluster_server_backend.jpg)

这个是它的背面，2 个小风扇 + 电源接口。

打开顶盖，让我们一探其内部构造：

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/da0a5e593b2a847a1a2704eefda505e8-firefly_cluster_server_inside.jpg)

也就是说，其散热是：每片 CPU 上覆盖的散热片被动散热 + 整个机箱的主动风扇散热。

除了电源，就是一块主板（底板）, 这个主板挺有意思的，它是由这些部分构成的：

*   11 个金手指接口，用于插入 Firefly core-3399-jd4 的核心板，一个接口插一个。也就是说总共有 11 个核心板。对应的也就有 11 台 arm 服务器，每台服务器配置后面介绍。
    *   其中，1 个是 main core, 用作管理端，类似服务器的 BMC 去管理其余 10 台服务器
    *   另外 10 个是 worker node. 用于实际负载运行。
*   交换机芯片，用于这 11 个核心板的内部以太网通信。
*   4 个以太网接口，其中：
    *   1 个用于 main core
    *   另外 3 个和底板的交换机芯片打通

具体的网络拓扑图如下，通过这幅图就能很直观的了解这台服务器的内部构造了：

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/cb4724d6108154bb34ce69c6e81745ed-R1_netword_topology_diagram.jpeg)

### 服务器核心 - Firefly core-3399-jd4

这是服务器的核心：Firefly core-3399-jd4 的上手图，单手可握，还是很小的：

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/d3c8d4a9dafecdb0165e1a5086e664e1-rk3399jd4_hand.jpg)

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/26b7b4680123a76ab9c7929567be459d-rk3399jd4_info.jpg)

每片 Firefly core-3399-jd4 核心板就是一台 arm 服务器，其配置为：

*   CPU: 瑞芯微 rk3399 六核心 arm64 CPU （这个芯片是 28nm 制程的，发热还不小）
*   内存：LPDDR4, 2G/4G 可选
*   NPU: 选装，我购买的没有该芯片
*   存储：eMMC, 8G - 128G 可选，我的是 32G.

也就是说，这一台服务器，启动后会有：11 台 6 核，2/4G 内存，32G 存储的配置可用。

以 4G/32G 的配置为例，总共有：

*   66 核 CPU
*   44G 内存
*   352G 存储

可用。

刷机
--

这种服务器，本来的应用场景主要是用作：云手机矩阵。所以其默认带的是安卓系统。

根据我的需求全部刷机为 Ubuntu 系统。

具体刷机过程就不详细介绍了，感兴趣的可以参考这里：

[子板固件升级 - 产品介绍 — Firefly Wiki (t-firefly.com)](https://wiki.t-firefly.com/zh_CN/Cluster-Server-R1/Firefly_Cluster_server_product_documentation.html#zi-ban-gu-jian-sheng-ji "https://wiki.t-firefly.com/zh_CN/Cluster-Server-R1/Firefly_Cluster_server_product_documentation.html#zi-ban-gu-jian-sheng-ji")

Maincore - BMC 管理端
------------------

这个服务器的 BMC 管理端也很有意思，功能大致为：

*   设备列表
*   设备监控仪表板
*   Shell 终端窗口
*   子版固件升级

如下图：

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/43bc2b71bca5a29252a7e7e0d6a834f2-wps4.png)

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/15096289dcf2ab90ef4f797f1b73cea0-wps6.png)

这个界面是不是看上去有点熟悉？😄😄😄

其实它这个管理端是基于：Grafana 魔改的。

*   UI 界面就是：Grafana + 一些定制化的 panel
*   监控数据是基于：Prometheus + node exporter
*   Shell 终端窗口是基于 adb 实现的 (📝这个服务器的 11 个核心板，除了通过以太网交换机互联；其余 10 个子版也会作为 USB 设备连接到 maincore)
*   子版固件升级是基于瑞芯微的 Linux 刷机工具实现的

实战
--

这台服务器首次启动效果如下：

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/29c3caf4952a00ef3bda13280d861f92-firefly_cluster_first_running.jpg)

再被我折腾了很多次之后，最终设备坏了 4 个😂😂😂, 只剩下 7 个可用了。

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/e47ee3f322cbf9de06cf30135325fe50-firefly_cluster_server_7.jpg)

心在滴血。..💀💀💀

功率消耗
----

其功率稳定在 30 - 40 W (7 片，每片功率 5 W 左右）, 如下图：

![](https://pic-cdn.ewhisper.cn/img/2023/08/25/b53ccb01fe47c92ecfb29ca93169b2c9-20230825152043.png)

功率还是比较低的。这就是 arm 芯片的优势。

总结
--

基于个人的工作 / 兴趣需求，我想要：

*   多台服务器
*   一直运行
*   噪音小
*   功耗低

这台看起来像服务器，但实际上是由 11 个 arm 开发板组成的矩阵满足了我的需求。

*   被我折腾坏 4 片开发板后，还有 7 片可供使用
*   可以一直运行
*   噪音还是有点大（主要是暴力风扇的原因，后续考虑找个静音风扇安装）
*   功耗低

基本上满足了我的需求。后续我会先用它来搭建 HashiCorp nomad 集群。

敬请期待。

📚️参考文档
-------

*   [CSR1-N10R3399 资料下载 | Firefly | 让科技更简单，让生活更智能 (t-firefly.com)](https://www.t-firefly.com/doc/download/82.html "https://www.t-firefly.com/doc/download/82.html")
*   [Welcome to Cluster-Server-R1 Manual — Firefly Wiki (t-firefly.com)](https://wiki.t-firefly.com/zh_CN/Cluster-Server-R1/index.html "https://wiki.t-firefly.com/zh_CN/Cluster-Server-R1/index.html")
*   [Welcome to Core-3399-JD4 Manual — Firefly Wiki (t-firefly.com)](https://wiki.t-firefly.com/zh_CN/Core-3399-JD4/index.html "https://wiki.t-firefly.com/zh_CN/Core-3399-JD4/index.html")
*   [Core-3399-JD4 资料下载 | Firefly | 让科技更简单，让生活更智能 (t-firefly.com)](https://www.t-firefly.com/doc/download/page/id/66.html "https://www.t-firefly.com/doc/download/page/id/66.html")

> _三人行，必有我师；知识共享，天下为公._ 本文由东风微鸣技术博客 [EWhisper.cn](https://EWhisper.cn "https://EWhisper.cn") 编写.