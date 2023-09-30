> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650932219&idx=1&sn=88c817bd86e0b15c168121763a50af40&chksm=84aa2841b3dda1576ec57dcdd9b61e4fca5ef7e34db78a2028948462951a44601c022471834d&scene=178&cur_album_id=2209804829378543621#rd)

以下**动画演示** 8 年前写的一个范例：

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJ4bM0XOJTZ86aHzAjP7VMGm5AhxhfxFvThT3LeM3FsMYMI0lGhO9dmg/640?wx_fmt=gif)  

8 年前的 aardio 已经这么溜了，上图的界面要不了几下就能做出来，而且是可视化设计，所见即所得。不需要什么复杂的 DirectUI —— 界面丝滑流畅不闪烁。  
更重要的是 aardio 编写的界面支持自适应布局，高分屏自动缩放，一键九宫格缩放：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJHFIOXEIP6vuuAKXgRibHsH8fjdcTkaESicaOFBQgwJsa9uMXZmtORvuA/640?wx_fmt=gif)

一起来练一下吧，aardio 真的很简单，分分钟可以学会。  
首先新建一个窗口：

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJ7PlLP81GjjbKQB8wITZA1jia79guCH9QgyUBX8jia3nVz6yxnWiaEYZoA/640?wx_fmt=gif)

  
点选「 plus 控件 」：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJ3I4hyr2TG4KiaRmUWsXbibKV6RMEHQOTTRZ4epXxia5ToPicuicCBXo6N3A/640?wx_fmt=png)

在窗口上按住鼠标左键画出 plus 控件。  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJ0s2gVOrcCMv87VA3qA8PHicXUYtVhC6wwWaMenDWYia9qOh2zKf4EWJg/640?wx_fmt=gif)  

鼠标双击并打开 「aardio 工具 /plus 控件配色工具」：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJU1RP9tTDRicp61q1rnv1WjlWoowMeFicTXyLZvbzAsicHPy40hW8ibiawXA/640?wx_fmt=gif)

配置好颜色样式，或者点击预设的范例样式，然后点击「导出到窗体设计器选中控件」就可以了：

![](https://mmbiz.qpic.cn/sz_mmbiz_jpg/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJdgYz57ndScySJAB0cknw1onrTjZEHMAxibyrrM2w3XThadtsHyORBdQ/640?wx_fmt=jpeg)

我们也可以先拖一个 plus 控件到界面上，然后打开「工具 / 滑尺配色工具」：  
![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJ2lFibgJEmcDFAzzB5qhnI5mSONrO3BMa9Nib0MXZqNgwIsxiaWkIwsyuA/640?wx_fmt=png)

配置好外观与样式，然后「导出到窗体设计器选中控件」就行了：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJR2GiaQkHf6gr54bSiaU4OSwVTc5IiaVU62Bp58NQDgskjqHvybIcqjk1g/640?wx_fmt=png)

下面看运行效果：

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJWo3lb95V5TSAc3NxTOBLSib1QmNJMknpCWbGodXwuuFoRFoxx7ovFZA/640?wx_fmt=gif)

注意 plus 控件可以指定两个文本属性，一个是普通「文本」属性，一个是「图标文本」属性。如果「图标文本」为空，则「图标字体」属性被忽略。普通文本的「字体」属性也可以指定为图标字体，但如果普通文本的「字体」属性选择适合文本的 Tahoma 字体，而「图标文本」使用 FontAwesome 等图标字体效果会更好一些：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJv7jBaSpKKL6pjQX3qcCHvoFH5ELjsWEImYGAElL5cDL5JMM9jdLaBQ/640?wx_fmt=png)

为 plus 控件指定图标字体是非常简单的：

1、选中 plus 控件。

2、点击 aardio 工具 / 界面 / 字体图标，选中需要的字体图标，然后点击字体图标就可以了。

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJ9cHYhoyb0fDHsHsRpSIOcOfibF5pAd2mEBflhpOKKbvRjr8EA8QzV6g/640?wx_fmt=gif)

  
上图的图标工具是用  web.form - 也就是古老的 IE 控件做的。完美支持 XP，Vista，Win7，Win8，Win10，Win11...... 等所有操作系统。我没遇到任何 IE 兼容性问题。IE 再不济 - 那也是一代霸主。用的人太多了，有时候缺点就会被无限放大。  
aardio 有一个非常有趣的 orphanWindow 功能：调用控件的 orphanWindow 函数，就可以让控件突出到窗口外部显示。效果演示：  
![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJKKJc8JIfIrRy244vIbkDdvsktUz3Xdq7mFpnZnxFicgFCL1wJe5cnwg/640?wx_fmt=png)

Gif123 就用到了这个功能：  
![](https://mmbiz.qpic.cn/sz_mmbiz_jpg/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJcXcZibo0CG2YRYlhgyDTluxyIov9WRZp9iaCeIfBMbETG8aia8yyLKvFQ/640?wx_fmt=jpeg)

下面这个界面是 9 年前斌哥用 aardio 写的开源项目，斌哥不是一个程序员而是一个医生，学了 aardio 没几天就写出了这个作品：  
![](https://mmbiz.qpic.cn/sz_mmbiz_jpg/8Bia8Vd22gBPjInufsbwFDsmDQPAHFrQJ1oib8YSKT9HH3oicw8UVy3NLLpVAP9PErjSiahW4lrygiaY6w4WiaGnR8sQ/640?wx_fmt=jpeg)  
记得当时有个用户说在他眼里国产开发工具都是老破小，难以置信这么惊艳的软件是用一个国产开发工具写出来的，更不相信作者学了没多久。  
至于用 aardio 编写的闭源软件，界面更炫的就更多了。当然使用 aardio 而不声明 —— 这是我们允许并支持的行为。