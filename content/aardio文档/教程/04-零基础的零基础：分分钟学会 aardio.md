> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650932993&idx=1&sn=5b262c8f07fc4b571744b7606939431f&chksm=84aa2cbbb3dda5adb705502eeb0cabb393846ebd62140316eb023a92213cd72c6c9cd94c4026&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

**▶** **起步**  

先学一个常用单词：**aah**   
这是个语气词，相当于中文里的 『啊』。  
aah 的发音实际上是：**aar**   
aar 的发音实际上是：**ar**

第一个 a 不用发音。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBMpxnwowxEOYpovxKVY2icvOuJT6uTWZ6y8HUOOP7CScjlUa697LgeCqM6tGsplHePO9wPROLM64kg/640?wx_fmt=png)  
看！搜 aar 就找到 aardio 了。

不但好记，也不容易混淆。  

**▶** **入门**
============

  
下面我们在 aardio 中写第一个小程序。

首先用 aardio 创建一个窗口，然后拖一个文本框控件上去。  
![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPeWr7vjHvIe68hlMvngDxCwnBW67n4YVqedWr2e9shaduQdaLSsJuskIbw6rRdicN4FXTvvugDtRQ/640?wx_fmt=gif&wxfrom=5&wx_lazy=1&wx_co=1)

然后愉快地切换到『代码模式』：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBMpxnwowxEOYpovxKVY2icvODxm3icE6UxXaGg4979TZbv8F6VpicJc1kdCypFQ3HLuf1jjkcuV3I5UQ/640?wx_fmt=gif)

输入以下代码：

```
var aardio = "aardio"
```

  
然后点击**『运行』**：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBMpxnwowxEOYpovxKVY2icvOXWDWkLkXQUV9icFkvh4gPPJ3KCEgwooEET8kiaea0qPbzmVW43hwyANA/640?wx_fmt=gif)

**"aar"** 这种放到双引号里的叫字符串。  

**"aar" + "dio"** 用于将两个字符串相加，返回新的字符串 **"aardio"** 。其实 aardio 中要用 ++ 连接字符串（使用两个加号），但是如果 ++ 前后有引号就可以简写为 + 。

**"aar" + "dio"** 称为『表达式』。这里的 + 号被称为『操作符』，而 **"aar","dio"** 都是『操作数』。

而下面的代码则声明了一个『局部变量』：

```
var aardio = "aardio"
```

没有放在引号里的 aardio 是代码，放引号里面的 ****"aardio"**** 是字符串。

aardio 是一个『局部变量』名，它指向内存中的字符串值 "aardio"。『局部变量』就是只能在当前语句块内有效，去掉前面的 var 就是 『全局变量』—— 在整个程序（当前线程）中都有效。

当然，也可以使用别的变量名，例如：

```
var aar = "aardio"
```

  
变量指向的数据可以任意更改，例如：

```
var aardio = "aardio";
aardio = aardio + "aardio";
aardio = aardio + "aardio";

for(i=1;10;1){
  aardio = aardio + "aardio";
}

import win;
win.msgbox(aardio);
```

  
猜猜运行上面的代码会发生什么？如果您猜对了就算没白学。这里我不解释 for 语句是什么作用，我们学编程，不是等着别人告诉我们什么是什么 —— 而是要自己动手去弄明白什么是什么。
===========================================================================================

如果还是学不会 "aardio" 这个词，那我们换个姿势，这样：  

===================================

```
var aardio = "aard" + "io";
```

  
"aard" 是土的意思，"io" 表示输入输出，也挺好记。 

aardio 这个名字的灵感来自 aard，Rapid Development，studio 这几个词，寓意为 “国产可视化快速开发工具”。“土（aard）” 有 “本土” 的寓意，“土” 在五行里为中央之气 —— 也有国产语言的寓意。

**▶** **一小步**
=============

  
人真想学会一个东西，那是什么困难也挡不住我们的。要是不想学一个东西，也总能找到学不会的借口。  

我们再来学一个很简单的常用词：**cardio** 

cardio 指的是 **『有氧运动』**，发音 **['kɑ:diəʊ]**。  

一个愉快的词。

一个健康的词。

如果经常出现**『头皮发麻』**等缺少运动的症状，可多做点有氧运动。  

我们把 cardio 前面的 c 拿掉换成 a 就变成 aardio 了。

回到上面的窗口程序，切换到代码模式：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBMpxnwowxEOYpovxKVY2icvO1lyIZiceJd6hoJgYD0xDvwG8EL5hP1jZgWOuU3m5osicRicF2N9OcbNZQ/640?wx_fmt=gif)

请输入以下代码：

```
var aardio = string.replace("cardio","c","a"); 
winform.edit.text = aardio;
```

  
然后点击**『运行』**就可以看到效果了。

上面代码的作用是使用函数 string.replace 替换字符串 "cardio" 中的字母 "c" 为 "a" 。  

string.replace 支持模式匹配语法。

模式匹配使用了类似正则表达式的基本语法。

我们可以稍微改一下上面的代码，在查找字符串 "c" 前面加上一个 "^" 符号 —— 其作用是限定匹配结果只能出现在源字符串的开始位置，修改后的代码如下：

```
var aardio = string.replace("cardio","^c","a"); 
winform.edit.text = aardio;
```

  
如果第一个参数可能是 "cardio"，也可能是 "Cardio"，那我们可以改成这样：

```
var aardio = string.replace("Cardio","^[Cc]","a"); 
winform.edit.text = aardio;
```

  
在模式语法里，"[Cc]" 表示匹配中括号里的任何一个字符。  

当然，我们还可以用串匹配来忽略一个字串的大小写，例如：

```
string.replace("Cardio","<@@cardio@>","aardio")
```

将一个子串放在尖括号 "<@@子串 @>" 中间，表示忽略大小写去匹配该子串，同时在匹配该子串时禁用模式匹配语法。而少了一个 "@" 的 "<@子串 @>" 则表示禁用模式匹配语法并且不忽略大小写。  

**▶** **aardio 上手真的很快**
=======================

看到这里，您学会 "aardio" 这个词了吗？

昨天又有个用户跟我说，刚接触 aardio 一个星期，以前没有编程基础，就用 aardio 快速开发了 2 个项目。  

相比其他桌面开发工具，三五年才混得入门水平，aardio 上手真的很快。