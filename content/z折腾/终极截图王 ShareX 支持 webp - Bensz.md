> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blognas.hwb0307.com](https://blognas.hwb0307.com/skill/993)

> 终极截图王 ShareX 支持 webp - 在生产力环境中，一款称手的 截图 工具是必不可少的。

本文最后更新于 123 天前，如有失效请评论区留言。

> 内容更新情况请见底部[日志](#日志)。

首先，我们前面已经学习过自建 Chevereto、EasyImage2.0、Nextcloud 等图床。在实际使用中，**一款称手的截图工具在生产力环境中是必不可少的**。经过一番调查，除了 Fastone Capture、Snipaste 外，`ShareX`也是一个免费的、功能强大的截图工具，所以想详细地了解它并推荐给大家。

此外，肃正大佬反映《[DN 宝鉴](https://blognas.hwb0307.com/test/873)》的图片加载速度太慢。`DN宝鉴`主要用于展示 DN 常用表格，是一个拥有大量图片的页面。小伙伴的提醒让我意识到，**个人博客应该对 Web 图片进行优化以提升访问速度和节省流量**。如果你的网站没什么人访问，是很难发现这个问题的；然而，如果你的网站长期经营且 VPS 流量有限，图片优化是一个要摆上日程的任务（特别是网站没有 CDN 的情况下）。

经了解，`WebP`格式是博客图片优化的一种性价比较高的方案。为了将 WebP 融入我的日常创作，我对本地 Typora 使用 WebP 的流程进行了一定的探索。大致原理是：**基于 ShareX，通过通过 imagemagick 软件将本地 png 或 jpg 截图转化为 WebP 格式**。这样做的话，服务器本身不用承担 WebP 转换的工作，而且由于 WebP 转换发生在本地，对于 WebP 转换的参数控制也可以更加随心所欲。这样的话，我们只需要有一个支持 WebP 的图床（如 Chevereto 或 Easyimage2.0）即可。

下面我们来看看如何对 ShareX 这个截图工具进行设置吧！

WebP 类似于 JPG/PNG，是一种图片格式。根据 Google 的说法：

> WebP 可为 Web 上的图像提供卓越的**无损和有损**压缩。使用 WebP，网站管理员和 Web 开发人员可以创建更小、更丰富的图像，从而使 Web 更快。与 PNG 相比，WebP 无损图像的大小要小 26% 。在同等 SSIM 质量指数下， WebP 有损图像比可比较的 JPEG 图像小 25-34% 。
> 
> 无损 WebP 支持透明度（也称为 alpha 通道），成本仅为 22% 额外字节。对于可以接受有损 RGB 压缩的情况，有损 WebP 还支持透明度，通常提供比 PNG 小 3 倍的文件大小。

这里我列举几个例子：

jpg 文件：1022kb

![](https://chevereto.hwb0307.com/images/2022/05/04/aafbf9c9410648f6eb21ad59d11ea0cb-hd2.jpg)

jpg 文件对应的 WebP 文件：大小 181kb

![](https://chevereto.hwb0307.com/images/2022/05/23/aafbf9c9410648f6eb21ad59d11ea0cb-hd2.webp)

png 原图：4.97MB

![](https://chevereto.hwb0307.com/images/2022/05/23/91226205_p18.png)

png 原图对应的 WebP：495kb

![](https://chevereto.hwb0307.com/images/2022/05/23/91226205_p1801edaf4f395e0df3.webp)

肉眼没有明显的画质损伤，但图片大小却明显下降了。所以，在日常在 typora 插入图片时，可以使用 WebP 格式而不是 png 或 jpg，这样在推送至博客后，他人访问多图片的博文时速度会更快；从更长期的时间来考量，对于节省图床空间也是很有利的。

> 安装 ShareX 的过程中如果打开了 360 安全卫士，会导致某些权限失败，比如无法在 windows 启动时自动开启软件。临时关闭 360 安全卫士即可生效。

考察了多种流程，最后我的选择是**通过 ShareX+chevereto 构建 WebP 图片的生成和托管**。

`ShareX`是一款十分有名的开源、免费的截图工具，其官方网站是：[https://getsharex.com](https://getsharex.com/ "https://getsharex.com")。其 [Github Repo](https://github.com/ShareX/ShareX "Github Repo") 有 19.7k 的 Star。我选择`ShareX`的原因如下：

*   使用广泛，文字和视频教程多
*   优雅的截图和上传功能
*   强大的动作设置
*   活跃的社区

本文不介绍怎么安装 ShareX，和一般的 exe 软件一样的。我想介绍的是一些实用的或和 WebP 相关的初始化设置。

chevereto 是一款图床。如果你没有安装过 chevereto，请移步至我的 chevereto 教程：《[Docker 系列 搭建个人图床 chevereto](https://blognas.hwb0307.com/linux/docker/485)》、《[Docker 系列 在 markdown 中使用 chevereto](https://blognas.hwb0307.com/linux/docker/526)》进行学习。

ShareX 是在 Microsoft Windows 10 企业版上测试的。

Chevereto 安装的 VPS 环境如下：

```
uname -a # Linux VM-12-8-ubuntu 5.4.0-42-generic #46-Ubuntu SMP Fri Jul 10 00:24:02 UTC 2020 x86_64 x86_64 x86_64 GNU/Linuxdocker --version # Docker version 20.10.5, build 55c4c88docker-compose --version # docker-compose version 1.28.6, build 5db8d86f
```

如下图所示，一般 WebP 在 chevereto 不是默认支持的，所以你要在图片上传中将 WebP 选上。

![](https://chevereto.hwb0307.com/images/2022/05/23/chrome_stIlht18Co.webp)

在 ShareX 中，**imagemagick 可作为第 3 方插件用于将截图 png/jpg 格式自动转化为 WebP 格式**。官方下载是地址：[https://imagemagick.org/script/download.php](https://imagemagick.org/script/download.php "https://imagemagick.org/script/download.php")。页面内容有点长，请在网页里搜索`Windows Binary Release`:

![](https://chevereto.hwb0307.com/images/2022/05/23/NVIDIA_Share_gWzHXQStes.webp)

我们就下载这个`ImageMagick-7.1.0-35-Q16-HDRI-x64-dll.exe`。自己安装好。比如，我最后的安装目录是：`C:\research\ImageMagick-7.1.0-Q16-HDRI`，那么应用的地址是`C:\research\ImageMagick-7.1.0-Q16-HDRI\magick.exe`。记住这个地址，后面有用！

ShareX 的工作界面大致如下。

![](https://chevereto.hwb0307.com/images/2022/05/23/ShareX_v5GTQpm9KM.webp)

改主题色：

![](https://chevereto.hwb0307.com/images/2022/05/23/ShareX_539tmvI9bh.webp)

自定义快捷键：

![](https://chevereto.hwb0307.com/images/2022/05/23/HsphIKjAqQ.webp)

从`动作设置`这里可以进去。你可以将图像设置为 PNG 默认。

![](https://chevereto.hwb0307.com/images/2022/05/23/Typora_jNg9Vtd25v.webp)

可以设置多区域截图模式，这样截图时比较方便。试过都说好！

![](https://chevereto.hwb0307.com/images/2022/05/23/Typora_ZZ7FeaTazr.webp)

如果你要让 ShareX 的截图都使用 WebP 格式还需要一些设置。

首先，在动作里添加一个动作：

![](https://chevereto.hwb0307.com/images/2022/05/23/NVIDIA_Share_9hzh1LuphG.webp)

这个动作的参数如下：

*   名称：你随便起得喜欢的名字
*   文件路径：`C:\research\ImageMagick-7.1.0-Q16-HDRI\magick.exe`。与上面你的安装文件一一对应。
*   参数：`"$input" -quality 50 -define WebP:lossless=true "$output"`。你可以在[这里](https://imagemagick.org/script/WebP.php "这里")查看参数含义。你可以试调整`quality`参数，我觉得 50 差不多。如果是无损压缩，就设置 100；当然，WebP 文件体积相应地也是最大的（这样是不是就违背使用 WebP 的初衷了）。
*   输出文件的扩展名：WebP
*   扩展名过滤：png
*   隐藏窗口（必勾）：不然会一闪一闪地。
*   删除输入文件（选勾）：如果你想保留 png 文件，可以不选；如果只想保留 WebP，则选上。我个人不建议你选上。

在实际使用中，我会分别给 jpg 和 png 各设置一个动作。因为这两个格式均十分常见！

![](https://chevereto.hwb0307.com/images/2022/05/23/NVIDIA_Share_HDn9LLpHTf.webp)

不过，jpg 的设置和 png 的略有不同。如果你设置的和 png 一样的参数，最后 WebP 的体积会比 jpg 大！

![](https://chevereto.hwb0307.com/images/2022/05/24/NVIDIA_Share_wl0Og7ab7b.webp)

最后，在主界面的`截图后的动作`设置这几项：

![](https://chevereto.hwb0307.com/images/2022/05/23/NHZRK23RQf.webp)

你可以试试截图。按 Enter 进入下一步，最后成功的时候会有提示音，右下角也有一个缩略图提示，此时 WebP 图像文件已经 copy 到剪贴板。你在 typora 中直接`Ctrl+v`就可以自动上传到 chevereto 了。

ShareX 由于内置了 ffmpeg，因此天然地支持 GIF 录制。其基本原理是先录制为 mp4，然后依据某些参数的设定转化为 GIF。

首先，建议更换一个合乎自己习惯的 GIF 录制快捷键：

![](https://chevereto.hwb0307.com/images/2023/03/06/NyWb9oiWFA.webp)

然后，可以按需修改相关的参数，这样可以在质量和图像大小间取得较好的平衡。我自己使用的是默认配置：

![](https://chevereto.hwb0307.com/images/2023/03/06/ShareX_QMD34n8cJI.webp)

在本实例中，按`Ctrl+Alt+g`即可选择一个窗口进行录制。要插入 Typora 也很容易，直接`Ctrl+v`粘贴即可。是不是十分方便呀 (ฅ´ω`ฅ)

这里不得不吐槽一下，Telegram 是完美支持 WebP 的；而**微信、QQ 作为国内最先进的社交软件不支持 WebP**，WebP 会被当作一个文件发送。如果你要在 QQ 或微信聊天框里粘贴图片，还是不建议使用 WebP 格式的图片。

正确设置是：

*   在编辑器中设置`任务中自动关闭编辑器`。按需要也可以设置`编辑器启动模式`，我个人推荐`先前状态`：

![](https://chevereto.hwb0307.com/images/2022/07/30/DQFs9j8yjS.webp)

*   **截图并编辑好后，直接用`Ctrl+Shift+c`快捷键复制当前截图至剪贴板，然后在聊天框里`Ctrl+v`粘贴**。这个快捷键在 ShareX 英文界面中才会提示，中文界面是不提示的，所以这个功能卡了我好久 (￣△￣；)。

ShareX 也可以直接直接拖到主界面进行图片的上传：

![](https://chevereto.hwb0307.com/images/2022/05/23/ShareX_3yyrcN2ujQ.webp)

ShareX 完美支持 chevereto。不过，要先设置好 chevereto 图床的 api：

![](https://chevereto.hwb0307.com/images/2022/05/23/QeNvxgsOhu.webp)

![](https://chevereto.hwb0307.com/images/2022/05/23/Typora_9xaAeYhfvi.webp)

我一般习惯截好图直接在 typora 里粘贴上传，这个功能就有点鸡肋；再加上 Chevereto 不支持 Animated WebP，所以有时候上传是失败的；再者这种上传功能比较粗糙，也无法指定相册。种种原因，在实际使用中，**我倾向于禁用 ShareX 的上传功能**，只要设置`DisableUpload=True`即可：

![](https://chevereto.hwb0307.com/images/2022/06/23/NVIDIA_Share_hpbsGldweo.webp)

如果你有编辑多图片的习惯，建议先设置为 “自动尺寸”：

![](https://chevereto.hwb0307.com/images/2023/03/02/JTCpnR7ERx.webp)

假设你有 A、B 两个图片。你可以先在 B 的窗口完成相应的修饰，按 Ctrl+Shift+c 复制到剪切板：

![](https://chevereto.hwb0307.com/images/2023/03/02/ShareX_0usmJpEB4x.webp)

然后，`Ctrl+v`粘贴到 A 窗口：

![](https://chevereto.hwb0307.com/images/2023/03/02/LYJFxS00LW.webp)

可以调大窗口，按`Ctrl+鼠标滚轮`调节相对大小，满意后按 Enter 保存并自动生成 webp 格式图片即可：

![](https://chevereto.hwb0307.com/images/2023/03/02/se4KzKeQ1C.webp)

*   双击任务栏的应用图标：打开主界面
*   单击任务栏的应用图标：开始截图。这个设定在开始使用时很不习惯！
*   **截图时隐藏鼠标指针**：强迫症看着真的难受！可以按下面方法改为自动隐藏指针。

![](https://chevereto.hwb0307.com/images/2022/07/05/Typora_XfYHOpclMA.webp)

ShareX 是一个十分强大的截图工具，不过刚刚开始使用的时候有点难用。慢慢习惯就好。如果你不用 WebP，单纯使用 png 格式我觉得也不错的，不需要设置动作。

值得一提的是，**Docker 版 Chevereto 目前仅支持 static WebP 而不支持 animated WebP**。如果介意的小伙伴，可以看看其它图床。由于我的工作流一般是静态截图，所以 Chevereto 足够了。

有任何问题欢迎留言喔！

*   [ShareX 同时录制系统声音和麦克风声音 – 知乎](https://zhuanlan.zhihu.com/p/494722071 "ShareX 同时录制系统声音和麦克风声音 – 知乎")
*   An image format for the Web: [https://developers.google.com/speed/WebP](https://developers.google.com/speed/WebP "https://developers.google.com/speed/WebP")
*   WebP Server 的 Github 项目地址：[https://github.com/WebP-sh/WebP_server_go](https://github.com/WebP-sh/WebP_server_go "https://github.com/WebP-sh/WebP_server_go")
*   imagemagick——png 转 WebP：[https://imagemagick.org/script/WebP.php](https://imagemagick.org/script/WebP.php "https://imagemagick.org/script/WebP.php")
*   [使 Sharex 支持 WebP 格式](https://www.uzz5.com/post/f782.html "使 Sharex 支持 WebP 格式")
*   [Sharex 截图压缩并转换成 WebP 格式](https://www.uzz5.com/post/j9hs.html "Sharex 截图压缩并转换成 WebP格式")

*   补充 GIF 录制的操作建议。详见`支持GIF`。

*   补充多图片同时编辑并融合的技巧

*   弃用 cWebP 作为 action 器，转而使用 imagemagic。效果很好，多区域截图不再表示为 animated WebP。
*   通过 ShareX 与 FastStone Capture 互补达到最佳截图应用场景的覆盖。

基于 [m2w](https://blognas.hwb0307.com/linux/docker/2813 "m2w") 创作。版权声明：除特殊说明，博客文章均为 Bensz 原创，依据 [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/ "CC BY-SA 4.0") 许可证进行授权，转载请附上出处链接及本声明。**VIP 内容严禁转载**！由于可能会成为 AI 模型（如 chatGPT）的训练样本，**本博客禁止将 AI 自动生成内容作为文章上传（特别声明时除外）**。如有需要，请至[学习地图](https://blognas.hwb0307.com/other/447)系统学习本博客的教程。加 [Telegram 群](https://t.me/benszhub "Telegram群")可获得更多帮助喔！ | 博客订阅：[RSS](https://blognas.hwb0307.com/feed "RSS") | 广告招租请[留言](https://blognas.hwb0307.com/lyb "留言") | [博客 VPS](https://blognas.hwb0307.com/ad "博客VPS") | 致谢[渺软公益 CDN](https://cdn.onmicrosoft.cn/ "渺软公益CDN") |