> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650931699&idx=1&sn=f14084f25284d3d04cdbb3f349bc6372&chksm=84aa2a49b3dda35f3186360d1c06ff907d5558caa80f1d1d68d1a5e1c62ef86caacb245d79ed&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

aardio 中最强大的控件是 plus 控件，但最重要的控件是 custom 控件。不会用 plus 控件可能只是界面没那么好看，而不会用 custom 控件，你在 aardio 中将寸步难行。

  
在 aardio 新版本中增加了多个 custom 控件的使用范例，范例中包含了详细的使用步骤与要点的说明。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOaPNEeibM2RZqFFSoW6gUlXKxaaZsBHhnKEJATcU8nmn7J8wVcibBr7MVicCY2x2IREcWLGMj8oEJGA/640?wx_fmt=png)

建议大家阅读一下范例，custom 控件用法其实很简洁，范例都没几句代码，一看就能懂。  
下面我再补几张图：  
一、「界面控件」工具条里最后一个控件就是自定义控件（ custom 控件）  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOaPNEeibM2RZqFFSoW6gUlXkDfd6Kc68Hk1jKBbPnLclNSuqPsDaYMIrybdC8r3lLyYicQFAGicicvRg/640?wx_fmt=png)

二、custom 控件与其他控件的区别是：控件的类名可以修改为任意 win.ui.ctrl 名字空间下的类名。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOaPNEeibM2RZqFFSoW6gUlXTmGCyDTdO1anvN7SctTbgqDDyQFJdNr3TpiahoMUlao3kXtXEfrKdvA/640?wx_fmt=png)

  
三、custom 控件的类名还可以指定任何普通创建窗体的代码文件的路径。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOaPNEeibM2RZqFFSoW6gUlXEQ1vaq6afXiblibRvnk3Uicq6OmwjCM59OfoWlLS01qFLgicY9OPZXNibRw/640?wx_fmt=png)

  
上面的文件路径 \res\frmChild1.aardio 从哪里来呢？其实可以在工程里直接右键点击窗体「复制路径」，如下图：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOaPNEeibM2RZqFFSoW6gUlXregJuDxbT2sHywcOmO8OFRYLAyc52jticicUK1JkVcM11APmoPGC7Zew/640?wx_fmt=png)

  
四、我们还可以调用 custom 控件的 loadForm 函数动态加载一个或多个子窗体。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOaPNEeibM2RZqFFSoW6gUlXlJYzfePwXox5cn3ibnhuKYX40j39JbOPiat9BBTVyoFyGFKkv8gNhJUg/640?wx_fmt=png)

  
标准库中的高级选项卡（ win.ui.tabs ） 就是使用 custom 控件作为子窗口容器。  
五、我们还可以利用 custom 控件加载扩展控件，例如浏览器控件。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOaPNEeibM2RZqFFSoW6gUlXmjKxKGIJOGgqiaERKRFEPjtXekvPZQJI0xfw8icl5CQiaOiaf2R3S4rxuQ/640?wx_fmt=png)