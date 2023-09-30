> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650930999&idx=1&sn=1b8354469f3b488b016f215ae21e37a0&chksm=84a9d48db3de5d9bdbb6f6b934615a26d470606efb36a217b280e1a4312620004b69f28fe7f6&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

很多时候我们类似资源管理器在软件上显示本地文件的目录结构，例如 Sciter 范例浏览器。为了把事情变简单，新版 aardio 标准库里提供了 win.ui.explorer，请确认你更新 aardio 到了最新版本以使用最新的 win.ui.explorer。

win.ui.explorer 的作用是用 treeview 树形视图控件显示硬盘上的文件目录结构，并且会自动获取文件的图标（类似资源管理器那种效果），让我们首先在窗体上拖放一个 treeview 控件：  

![](https://mmbiz.qpic.cn/mmbiz_gif/8Bia8Vd22gBPIibhDMc4uvpOWUNWcBbnUbaqibiaQCU777vZkeLFuIlQCcLRrlJQ9nuCAZMOFvfuMjTINNe6HjgAXw/640?wx_fmt=gif)

  
然后我们切换到代码视图并编写代码：

![](https://mmbiz.qpic.cn/mmbiz_gif/8Bia8Vd22gBPIibhDMc4uvpOWUNWcBbnUbfWFNj05FqTfibuIcmZsFHhMmkTEPjmEIibc7wIDKIzbKesic1eC7clciaA/640?wx_fmt=gif)

添加的代码如下：  

> import win.ui.explorer;  
> var explorer = win.ui.explorer(winform.treeview);  
> explorer.loadFile("~/")

winform.treeview 是树形视图控件，**explorer 则是对树形视图的进行包装增加功能的一个新对象**（ aardio 中类似这种用法很多，动态语言擅于实践一个设计原则：多用组合少用继承会写出更简洁的代码 ）  
explorer.loadFile () 函数用来加载硬盘上的目录，如果不指定任何参数就会打开 “我的电脑” 列出所有驱动器根目录，这个函数还可以指定模式匹配、或者后缀名通配符等等以显示指定类型的文件，例如 

> explorer.loadFile("~/",{ "*.aardio"; "*.html"})

指定后缀名通配符的参数可以如上是一个数组（以指定多个后缀名），也可以仅仅用一个字符串指定后缀名。注意通配符仅用于限定文件而不会限制目录，无论如何所有子目录总会显示出来。

大家可能注意到了一件事，我在写函数名的时候，哪怕就是在文档里总会在函数后面加上括号，例如 explorer.loadFile ()，这是一个原则，aardio 函数在任何时候不可以省略后面的括号。现代的编程语言已经被各种语法糖玩坏了，例如函数后面不用写括号，的确这看起来似乎很酷：

> withtest {  
>     ...  
> }

这种令人迷惑的语法其实就是一个简单的函数调用，或者有不少语言可以省略 function 关键字，或者用更短的 func 或者某个标点符号来代替，甚至允许你省略不用写 return, 所以我们现在看到这些时尚拉风的代码迷惑不止时 - 其实他也是一个简单的函数调用。添加这些语法糖非常的容易，我也曾经被诱惑过，但 aardio 坚持了最简单的语法，定义函数你就必须写 function ，调用函数你就必须写括号，没有一大堆的时尚花式写法以及花式语法糖，实用和简单才是 aardio 所坚持的原则。

回到正题，explorer 对象提供一些事件用于响应用户的操作，示例代码如下：

> import win.ui.explorer;  
> var explorer = win.ui.explorer(winform.treeview);  
> explorer.loadFile("~/")  
> // 用户用鼠标单节点  
> explorer.onClick = function(filePath,hItem){  
>       
> }  
> // 用户用鼠标双击节点  
> explorer.onDoubleClick = function(filePath,hItem){  
>     winform.text = filePath  
> }  
> // 用户鼠标右键点击节点  
> explorer.onRightClick = function(filePath,hItem,x,y){  
>           
> }

所有回调参数中 filePath 参数是一个字符串 - 也是用户当前点击的节点所对应的文件路径，而 hItem 是 treeview 控件的节点句柄（可用于 treeview 操作节点的函数作为参数 ）

如果我们希望用户右键点击节点时弹出右键菜单，可以这样写

> // 用户鼠标右键点击节点  
> import win.ui.menu;  
> explorer.onRightClick = function(filePath,hItem,x,y){  
>     var hItem,tvht = winform.treeview.hitTest(x,y,true);  
>     var menu = win.ui.popmenu(winform)  
>     menu.add("浏览...",  
>         function(){  
>             process.exploreSelect(filePath)  
>         }  
>     )  
>     menu.popup(x,y,true);     
> }

你也许希望再在我们的资源管理器上添加一个列表视图，当然你可以用 listview，一个更简单的方法是使用 web.form 浏览器控件，浏览器控件可以直接显示文件列表 - 可以省掉很多代码，要创建浏览器控件我们首先要添加一个 static 控件（或者 custom 控件也可以 ）

![](https://mmbiz.qpic.cn/mmbiz_gif/8Bia8Vd22gBPIibhDMc4uvpOWUNWcBbnUb2987cO1x7CicKYhhslekpAAKia3yqPyyVHsC8picVbUOwWia7icSbfL5oUg/640?wx_fmt=gif)

 然后我们切换到代码视图，编写代码如下：

![](https://mmbiz.qpic.cn/mmbiz_gif/8Bia8Vd22gBPIibhDMc4uvpOWUNWcBbnUblXO2icfd41pvelDkjy5niaSN9zg5kgLE5I572NRHvvT6VM9Yz3yTCtrg/640?wx_fmt=gif)

增加的代码如下：

import web.form;  
var wb = web.form(winform.static);  

web.form 实际上是 IE 内核的浏览器组件，**上面的 wb 变量是在 static 静态控件上进行包装并增加浏览器功能的浏览器对象**，我们最常用的一个函数是 wb.go () ，例如打开一个网址就写 wb.go ("http://www.aardio.com")，这个函数的参数也可以是一个硬盘目录的路径 - 这时候会显示文件列表视图（就像资源管理器那样）。  

我们也可以使用 wb.goDirectory () 函数打开目录，这个函数仍然是调用 wb.go () 函数，但是他会自动获取 ShellFolderView 对象，并且为浏览器组件添加一个事件 wb.shellFolderSelectionChanged () ，在这个事件里我们可以知道用户点击了哪个具体的文件，也许我们可以添加一个文本框来显示用户点选的文件路径：  

![](https://mmbiz.qpic.cn/mmbiz_gif/8Bia8Vd22gBPIibhDMc4uvpOWUNWcBbnUbhVH7z5teWZYPfGsRkSdfngkHzwbyFzFfian0m5YIVuibRygB7qY6vuaA/640?wx_fmt=gif)

下面切换到代码视图继续添加代码如下：

![](https://mmbiz.qpic.cn/mmbiz_gif/8Bia8Vd22gBPIibhDMc4uvpOWUNWcBbnUbvcPaJ4lmgPoew3Eb3F8yvZsNsibsvWq1786sATJMyjaeWh92NibILVuA/640?wx_fmt=gif)

我们希望用户单击目录时，在列表视图中打开，则需要添加下面的代码：

![](https://mmbiz.qpic.cn/mmbiz_gif/8Bia8Vd22gBPIibhDMc4uvpOWUNWcBbnUb5TwhSjj651ZDGlIZ8V6CtOpm6Dr85nehD8RZn5FmrMiaTEmNZ9A3T9Q/640?wx_fmt=gif)

上面我们用了一个 if 语句调用  fsys.isDir (filePath) 判断参数中指定的文件路径是否一个目录，如果是目录我们用 wb.goDirectory ( filePath ) 打开并显示文件列表。   

最后附上完整的代码：

> import win.ui;  
> /*DSG{{*/  
> var winform = win.form(text="仿资源管理器树形目录";right=719;bottom=414)  
> winform.add(  
> edit2={cls="edit";text="edit2";left=31;top=380;right=707;bottom=404;edge=1;z=3};  
> static={cls="static";text="static";left=253;top=20;right=695;bottom=363;transparent=1;z=2};  
> treeview={cls="treeview";left=27;top=15;right=236;bottom=369;asel=false;bgcolor=16777215;edge=1;z=1}  
> )  
> /*}}*/  
> import win.ui.explorer;  
> var explorer = win.ui.explorer(winform.treeview);  
> explorer.loadFile("~/")  
> import web.form;  
> var wb = web.form(winform.static);  
> // 用户点选了列表视图中的文件  
> wb.shellFolderSelectionChanged = function(filePath) {   
>     winform.edit2.text = filePath;  
> }  
> // 用户用鼠标单节点  
> explorer.onClick = function(filePath,hItem){  
>     if(fsys.isDir( filePath) ){  
>         wb.goDirectory(filePath);  
>     }  
>     else {  
>         winform.edit2.text = io.fullpath(filePath);   
>     }  
> }  
> // 用户鼠标右键点击节点  
> import process;  
> import win.ui.menu;  
> explorer.onRightClick = function(filePath,hItem,x,y){  
>     var hItem,tvht = winform.treeview.hitTest(x,y,true);  
>     var menu = win.ui.popmenu(winform)  
>     menu.add("浏览...",  
>         function(){  
>             process.exploreSelect(filePath)  
>         }  
>     )  
>     menu.popup(x,y,true);     
> }  
> winform.show()   
> win.loopMessage();  

如果对本教程有任何疑问，可以在下面留言。