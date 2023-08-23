> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blognas.hwb0307.com](https://blognas.hwb0307.com/skill/1734)

> Typora 地表最强 Markdown 编辑器之一 - 在我的日常工作、学习和创作的流程中，markdown 和 typora 非常底层。

本文最后更新于 6 天前，如有失效请评论区留言。

*   **2023-04-30**：新增基于 HTML 的 markdown 表格。优化 HTML 在 Markdown 中的使用。
*   **2023-04-27**：新增基于主题文件的自定义 CSS（以改变加粗字体的颜色为例）。
*   **2023-04-01**：新增链接的使用和插入技巧；新增基于 css 的目录自动编号教程。
*   **2023-03-08**：新增嵌入视频的技巧，其适用于本地或 m2w 上传（因为基于 HTML）。
*   **2022-12-20**：新增 Markdown 表情和 HTML 语法的 Demo。

前几天与小伙伴交流时，发现一个怪事：自己好像没有专门地讲过`Markdown`和一款常用的 Markdown 编辑器`Typora`。

对于为什么要选择 Markdown，我在《[Linux 基础 学习 Linux 前要准备什么](https://blognas.hwb0307.com/linux/linux-basic/379)》一文中已经略作介绍。在我的日常工作、学习和创作的流程中，`Markdown`和`Typora`非常底层。平时，我只用 Markdown 来记录笔记，没有使用其它效率工具；但也没有觉得很不方便。毕竟，**工作流程越简单越好**，这样我就不需要花费许多精力学习和维护它。此外，我在博客中创作文章的过程也是用 Markdown。至于 LaTeX 和 Word，我只在某些正式的场合才使用它们。

了解了 Markdown 的好处后，下一步就是选一个称手的编辑器。[Typora](https://typora.io/ "Typora") 其实是在我一开始接触 Markdown 时就知道的一款编辑器，那时候它还是开发中的项目，现在已经是个收费项目了。免费的测试版还是可以用的，不过它会经常跳出让你付费的窗口 (*▔＾▔*) ，有点烦人。官网价是 89 元 3 次永久激活。听说是可以破解的，自己想办法，我是支持 Typora 开源工作吧，大家都不容易。买软件和买饭、买衣服是一样的，都是花钱满足需求。特别是生产力工具，我觉得是要高于生活基本需要的，所以从不吝啬。价格也不是很贵（最主要原因）(～￣▽￣)～ 除了 Typora，还有一款免费 Markdown 编辑器 [Obsidian](https://obsidian.md/ "Obsidian") 在业界也是十分有名，其扩展性不输 Typora，感兴趣的小伙伴可以自行了解下！

这期，我准备向大家水一下 Typora 编辑器，然后简单讲讲小白专用的 Markdown 的语法。此外，**在正式使用 Markdown 之前，希望大家有一个可以稳定使用的图床**。如果你没有自己的图床，可以先看看《**[学习地图](https://blognas.hwb0307.com/other/447)**》中的 “**图床**” 系列。毕竟，Markdown 要配合图床使用，才是真正的生产力工具！

我工作状态时的 Typora 界面如下（GIF 截图工具是 [ShareX](https://blognas.hwb0307.com/skill/993)），有编辑界面和源代码界面，通过`Ctrl+/`互相切换：

![](https://chevereto.hwb0307.com/images/2022/06/22/Typora_ncZi3ompWL.gif)

这个源代码就是纯文本，你直接粘贴到任何一个 Markdown 编辑器里都可以正常地解析（前提是你使用的是标准的 Markdown 语法）。不过，**上面的演示并不是 Typora 的默认样式**，我使用了自定义主题`Vue`。下面我和大家讲一些比较实用的 Typora 设置。

作为颜控，拥有 Typora 的第一件事就是要**找个好看的主题**。就像 WordPress 博客一样，Typora 也是有主题的喔！Typora 官网提供了一些主题：[https://theme.typora.io](https://theme.typora.io/ "https://theme.typora.io")。我自己用的这个主题叫 [typora-vue-theme](https://github.com/blinkfox/typora-vue-theme "typora-vue-theme")，是在 Github 里下载的。你也可以在 Github 里找一下别的 Typora 主题，估计开源的主题不少。**总有一款适合你**！我觉得`Vue`主题界面简洁清爽，颜色搭配也很协调，几经周转最终还是选择了它作为默认主题。下面，我以安装`typora-vue-theme`示范 Typora 主题的一般安装和使用方法！

首先，我们先进入`偏好设置`：

![](https://chevereto.hwb0307.com/images/2022/06/22/Jrml5erQkl.webp)

打开`主题文件夹`：

![](https://chevereto.hwb0307.com/images/2022/06/22/NVIDIA_Share_xi4mFNxfk0.webp)

最后，将主题 css 文件和对应的字体文件夹复制到 themes 目录下，重启 Typora 即可：

![](https://chevereto.hwb0307.com/images/2022/06/22/NVIDIA_Share_FAsQdSnd7k.webp)

如果成功，可以在主界面的`主题`选项中找到`Vue`主题，选中它就生效了：

![](https://chevereto.hwb0307.com/images/2022/06/22/YEBeK3DP2M.webp)

一般主题的 README 文档会说明如何安装。有些主题的安装就会复杂一些，比如 [VLOOK 主题](https://github.com/MadMaxChow/VLOOK "VLOOK主题")。但总体上，我觉得即便是技术小白也可以轻松地 hold 住给 Typora 安装自定义主题的操作。

下面，我们还讲一下**如何调整编辑器宽度**，这对于大多数人而言可以改善阅读和写作体验。

如果你对`typora-vue-theme`略作了解，就会发现它其实就是定义了一堆 CSS 样式而已嘛！所以，**我们也可以在原主题的基础上自定义一些样式**。

比如，我发现原生主题中加粗字体的颜色是纯黑，这与非加粗字体的对比不够强烈。我希望换一个颜色，这样看上去会比较明显，比如符合加粗强调的含义：

我们打开主题对应的 CSS 文件`vue.css`，找到`#write strong`参数，改为：

```
#write strong {    padding: 0 1px;    color: #CE7777;}
```

这样，加粗文字的颜色就会发生变化：

![](https://chevereto.hwb0307.com/images/2023/04/27/Typora_xQrPLv689l.webp)

关于如何选择好看的颜色，我已经在《[如何优雅地选择配色？](https://blognas.hwb0307.com/skill/2858)》一文中讲述过，这里不再赘述 ヾ (≧∇≦*) ゝ 我个人觉得`\#A7727D`之类的颜色都还行。

大家可以用 Everything 之类的检索软件快速定位`base-control.css`文件。

![](https://chevereto.hwb0307.com/images/2022/06/22/image-20220622195046489.png)

找到 `#typora-source` 下的 `.CodeMirror-lines` 中的 `max-width`（搜索时用`#typora-source .CodeMirror-lines`可以快速定位）。比如下图是`800`px，你可以改`1200`px 之类的，保存后重启 Typora 生效。自己看看效果如何吧！

![](https://chevereto.hwb0307.com/images/2022/06/22/NVIDIA_Share_aW6BFpIDgz.webp)

我们去刚刚安装主题的文件夹里：**文件–偏好设置–外观–主题文件夹**。然后，编辑你目前使用的主题 css 文件，比如我这里是`vue.css`。搜索 `#write` ，找到下面类似的代码，修改其中的`max-width`参数即可。保存文件重启 Typora 生效。

![](https://chevereto.hwb0307.com/images/2022/06/22/NVIDIA_Share_GUbEdYnBCy.webp)

一般来说，常用的快捷操作主要集中在`视图`和`格式`选项中。

在视图中，`显示/隐藏侧边栏`、`源代码模式`比较常用。

![](https://chevereto.hwb0307.com/images/2022/06/22/6o3kOrCL5t.webp)

在格式中，`加粗`、`超链接`比较实用，这两个快捷键用得好，在 Typora 里用 Markdown 是很舒服的。其它快捷键，比如上标、下标那些，我也只是偶尔用用。

![](https://chevereto.hwb0307.com/images/2022/06/22/image-20220622194007550.png)

还有`Ctrl+c`是复制、`Ctrl+v`是粘贴、`Ctrl+f`是搜索，基本所有 Windows 软件都通用的。`Ctrl+Shift+v`是无格式粘贴，这个也很实用，可能有小伙伴不知道这个 (～￣▽￣)～ 至于在实际中还有哪些快捷键好用，要靠你自己摸索喽！总体上，在 Typora 中使用快捷键还是蛮简单的。

你可以按自己的习惯修改快捷键。修改快捷键的地方在：`文件--偏好设置--通用--高级设置--conf.user.json`，可以用`Notepad++`打开。修改完保存并重启 Typora 即可生效：

![](https://chevereto.hwb0307.com/images/2022/06/22/NVIDIA_Share_RJsaSxQHlt.webp)

> 参考 [lipengzhou/typora-theme-auto-numbering: Typora 主题自动编号](https://github.com/lipengzhou/typora-theme-auto-numbering "lipengzhou/typora-theme-auto-numbering: Typora 主题自动编号")

从`偏好设置——外观`中打开`主题文件夹`，将仓库的`base.user.css`和`github.user.css`放入主题文件夹即可：

![](https://chevereto.hwb0307.com/images/2023/04/01/msedge_o4SAUFdKNY.webp)

效果就是从 h2 开始按层级计数：

![](https://chevereto.hwb0307.com/images/2023/04/01/Typora_iBUQQi6iA5.webp)

**我日常频繁使用的 Markdown 语法并不多**。下面我进行几个基础的 Markdown 语法示范。百度上找一下，教程很多！我平时基本上也只运用了下面少数技巧，就可以写出层次分明的博客文章。在下面的 GIF 动图中，Typora **所见即所得**的特性真的是表现得淋漓尽致呢！也许，这就是 Markdown 爱好者喜欢用 Typora 的原因之一吧！

一般是用`#`来写。一级标题是`#`，二级标题是`##`。以此类推。

![](https://chevereto.hwb0307.com/images/2022/06/22/Typora_6MPv9JsFu6.gif)

一般是`+`号或者是`-`号。我个人比较喜欢用`+`号：

![](https://chevereto.hwb0307.com/images/2022/06/22/Typora_rfIGTqdalO.gif)

打个`>`，按空格键即可产生备注效果。如图：

![](https://chevereto.hwb0307.com/images/2022/06/22/Typora_aHUKs9CS8z.gif)

除了加粗，高亮也是一种比较常用的强调效果。一般是用 ` 内容 ` 来产生。比如：

![](https://chevereto.hwb0307.com/images/2022/06/22/Typora_H59nA8s8dW.gif)

一般是用 ` ` ` 来表示。一般还可以指定所有的编辑语言，比如 ` ` `bash 之类的。**拥有漂亮的代码高亮是 Markdown 最令人心动的特性之一呢**！在下图的示范中，我先打出 ` ` `bash，然后按`Enter`键，它就会自动地生成一个代码框。请看图：

![](https://chevereto.hwb0307.com/images/2022/06/22/Typora_ENfeNDf0gs.gif)

比如，链接 “[学习地图](https://blognas.hwb0307.com/map)” 的实际代码是：

```
[学习地图](https://blognas.hwb0307.com/map)
```

除了 “快捷键” 中介绍的插入链接的技巧，实际工作时有一种十分常用的操作，即**保存某个网页的网站名及其链接为 markdown 格式**。这时，我们可以使用一个叫 [Copy as Markdown](https://chrome.google.com/webstore/detail/copy-as-markdown/fkeaekngjflipcockcnpobkpbbfbhmdn "Copy as Markdown") 的 Chrome 插件（Microsoft Edge 同样适用），此时在网页右键即可复制排版优美的 markdown 链接。

比如，在我博客的主页复制链接：

![](https://chevereto.hwb0307.com/images/2023/04/01/msedge_GGkMsORu9T.gif)

链接内容为：

```
[Bensz - 苯苯](https://blognas.hwb0307.com/)
```

感觉是挺好用的！

> 示范时网速有点抓急 (～￣▽￣)～ ，毕竟 Chevereto 部署在国外 VPS 里。使用 Proxy 可大大改善 picgo 上传图片的表现，具体见《[Docker 系列 在 markdown 中使用 chevereto](https://blognas.hwb0307.com/linux/docker/526)》。

按我的[教程](https://blognas.hwb0307.com/linux/docker/526)设置好图床后，在别处 Copy 图片过来，`Ctrl+v`就可以粘贴图片并自动上传：

![](https://chevereto.hwb0307.com/images/2022/06/22/Typora_PnCeJmbzie.gif)

一般图片的格式就是`![](图片链接)`。所以在 Markdown 里，只保存图片的链接，不保存图片本身。这与 Word 等文档很不相同。

> 可以参考 [markdown 表情包](https://www.webfx.com/tools/emoji-cheat-sheet/ "markdown表情包")

比如 🙂 、 ![](https://blognas.hwb0307.com/wp-content/plugins/wp-githuber-md/assets/vendor/emojify/images/cold_sweat.png) 、 ![](https://blognas.hwb0307.com/wp-content/plugins/wp-githuber-md/assets/vendor/emojify/images/thumbsup.png) 、 ![](https://blognas.hwb0307.com/wp-content/plugins/wp-githuber-md/assets/vendor/emojify/images/sunny.png) ，挺有趣的！由于在使用 Ajax 的 Argon 主题时其显示并不正常（即表情显示为字符串），因此我并不是很常用。大家可以试试看！

Markdown 对 HTML 的兼容性不错。 字体、图片、表格、视频等，自定义程度更强！

写一些奇怪的字：

```
<font face="黑体" color="#009688" size=10>只是因为在人群中多看了你一眼</font>
```

只是因为在人群中多看了你一眼

插入一个图片：

```
<img src="https://chevereto.hwb0307.com/images/2022/12/12/FjyI7K4akAEBT7h.jpg" alt="FjyI7K4akAEBT7h.jpg" border="0" />
```

![](https://chevereto.hwb0307.com/images/2022/12/12/FjyI7K4akAEBT7h.jpg)

我强烈建议使用 html 代码进行表格的表述，这样对 HTML 的兼容性会更好。 比如：

```
<table style="border:1px solid black; margin-left:auto; margin-right:auto;"><tr><td> </td><td>API</td><td>Access Token</td></tr><tr><td>基本要求</td><td>OpenAI帐号+ 绑定国外的虚拟信用卡</td><td>仅OpenAI帐号</td></tr><tr><td>收费情况</td><td>使用收费</td><td>免费</td></tr><tr><td>基础Prompt</td><td>支持</td><td>不支持</td></tr><tr><td>超参数支持</td><td>Temprature/Top_p</td><td>不支持</td></tr><tr><td>单位时间请求数</td><td>较高，适合多人使用</td><td>较低，适合个人使用</td></tr><tr><td>响应速度</td><td>较快</td><td>较慢</td></tr><tr><td>绕过Cloudflare的反向代理</td><td>不需要</td><td>需要</td></tr><tr><td>Cloudflare WARP</td><td>不需要</td><td>部分需要</td></tr></table>
```

效果如下：

<table><tbody><tr><td></td><td>API</td><td>Access Token</td></tr><tr><td>基本要求</td><td>OpenAI 帐号 + 绑定国外的虚拟信用卡</td><td>仅 OpenAI 帐号</td></tr><tr><td>收费情况</td><td>使用收费</td><td>免费</td></tr><tr><td>基础 Prompt</td><td>支持</td><td>不支持</td></tr><tr><td>超参数支持</td><td>Temprature/Top_p</td><td>不支持</td></tr><tr><td>单位时间请求数</td><td>较高，适合多人使用</td><td>较低，适合个人使用</td></tr><tr><td>响应速度</td><td>较快</td><td>较慢</td></tr><tr><td>绕过 Cloudflare 的反向代理</td><td>不需要</td><td>需要</td></tr><tr><td>Cloudflare WARP</td><td>不需要</td><td>部分需要</td></tr></tbody></table>

我们可以在 [Markdown 表格 转换为 HTML 表格 – 在线表格转换工具](https://tableconvert.com/zh-cn/markdown-to-html "Markdown 表格 转换为 HTML 表格 – 在线表格转换工具")中对表格进行各种格式的转换，建议转换为压缩 HTML：

![](https://chevereto.hwb0307.com/images/2023/04/30/msedge_nxy7oRzvfT.webp)

一般地，我们还需要使用 CSS 定义表格样式。比如，在本例中，我使用了`style="border:1px solid black; margin-left:auto; margin-right:auto;"`，其定义了边宽和表格居中。

markdown 里甚至可以嵌入视频！比如，嵌入一个 B 站视频：

```
<div style="position: relative; padding: 30% 45%;"><iframe src="//player.bilibili.com/player.html?aid=248179775&bvid=BV1ov41157UQ&cid=342169071&page=1&as_wide=1&high_quality=1&danmaku=0&autoplay=0" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true" style="position: absolute; width: 100%; height: 100%; left: 0; top: 0;"> </iframe></div><br>
```

嵌入一个 Youtube 视频：

```
<div style="position: relative; padding: 30% 45%;"><iframe src="https://www.youtube-nocookie.com/embed/wrmwTKqSUnk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen style="position: absolute; width: 100%; height: 100%; left: 0; top: 0;"></iframe></div><br>
```

链接可以在视频的分享图标里获得：

![](https://chevereto.hwb0307.com/images/2023/04/26/msedge_2Ik513fY7C.webp)

甚至还可以内嵌一个 Nextcloud 视频（详见《[Docker 系列 深度使用 nextcloud（六）在博客中嵌入视频](https://blognas.hwb0307.com/linux/docker/778)》）：

上述代码在 PC 端 / 移动端进行了优化，效果不错。大家可以试试看！

简单地介绍了 Markdown 和 Typora，希望对小白们有所帮助呀！Markdown 其实有更高级的用法，比如写数学公式、Mermaid 之类；还支持 html 语法！按需学习即可。多写多用，慢慢的，Markdown 就变成一种生活中的普通语言了。加油喔！

*   [typora 快捷键如何修改？](https://www.zhihu.com/question/263846748 "typora快捷键如何修改？")
*   [Typora 更改编辑器、源代码模式的宽度、块代码的颜色](https://blog.csdn.net/xiaojin21cen/article/details/90292315 "Typora 更改编辑器、源代码模式的宽度、块代码的颜色")
*   [关于博客园内嵌入 bilibili 视频 – 王陸 – 博客园](https://www.cnblogs.com/wkfvawl/p/12268980.html "关于博客园内嵌入bilibili视频 – 王陸 – 博客园")
*   [HTML 插入 Youtube 视频 – 以深 – 博客园](https://www.cnblogs.com/71yishen/p/13490602.html "HTML插入Youtube视频 – 以深 – 博客园")
*   https://www.youtube.com/embed/d-3cEQ1d1E4

基于 [m2w](https://blognas.hwb0307.com/linux/docker/2813 "m2w") 创作。版权声明：除特殊说明，博客文章均为 Bensz 原创，依据 [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/ "CC BY-SA 4.0") 许可证进行授权，转载请附上出处链接及本声明。**VIP 内容严禁转载**！由于可能会成为 AI 模型（如 chatGPT）的训练样本，**本博客禁止将 AI 自动生成内容作为文章上传（特别声明时除外）**。如有需要，请至[学习地图](https://blognas.hwb0307.com/other/447)系统学习本博客的教程。加 [Telegram 群](https://t.me/benszhub "Telegram群")可获得更多帮助喔！ | 博客订阅：[RSS](https://blognas.hwb0307.com/feed "RSS") | 广告招租请[留言](https://blognas.hwb0307.com/lyb "留言") | [博客 VPS](https://blognas.hwb0307.com/ad "博客VPS") | 致谢[渺软公益 CDN](https://cdn.onmicrosoft.cn/ "渺软公益CDN") |