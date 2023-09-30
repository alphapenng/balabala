> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650933009&idx=1&sn=aa3e27416c36135ce27ca89804006e71&chksm=84aa2cabb3dda5bdb43594a0a3b294ae2215357f9063e200c10e222605a7c3976ec3ba6c1da4&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

**先出 3 个题：**

一、列出以下单词的长度，并取出长度最短的单词。

```
"Android" "Arduino" "aardio"
```

二、列出以下单词使用的字母数目（忽略大小写，相同字母不计数），并取出使用字母数目最少的单词。

```
"Android" "Arduino" "aardio"
```

三、列出以下单词使用了哪些相同的字母（忽略大小写）。

```
"Android" "Arduino" "aardio"
```

您可以试试先关掉这个网页去做一下试试，看看需要多长时间。

  
**▶** **字符串数组排序，找出长度最短的单词**

下面我们在 aardio 中写第一个小程序。

首先用 aardio 创建一个窗口，然后拖一个文本框控件上去。

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPeWr7vjHvIe68hlMvngDxCwnBW67n4YVqedWr2e9shaduQdaLSsJuskIbw6rRdicN4FXTvvugDtRQ/640?wx_fmt=gif&wxfrom=5&wx_lazy=1&wx_co=1)

然后愉快地切换到『代码模式』：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBN9iaXPnz9fxqJH83VtDfTdEsxc7Dj5MCFU0Cyjqsnu6dJHdSG3JUI9LS1qoLUic3SbB9ahibgw8YiczA/640?wx_fmt=gif)

输入第一句代码：  

```
var words = "Android" "Arduino" "aardio"
```

您能看出上面代码错在哪里吗？  

太棒了！我们需要把这三个单词用绳子扎起来送给 words 变量。

在代码里，长得最像绳子的就是 { } 了，就它吧，改代码如下：

```
var words = {"Android" "Arduino" "aardio"}
```

再在单词间加上分号（或者逗号）将它们分隔开，改代码如下：  

```
var words = {"Android";"Arduino";"aardio"}
```

这就创建了一个数组。  

下面我们用 for 循环语句遍历数组，并且输出它们的值，修改代码如下：  

```
var words = {"Android";"Arduino";"aardio"}

for(i=1;#words;1){
    var word = words[ i ];
    winform.edit.print(word);
}
```

  
for 循环语句的结构如下：  

```
for(
    循环变量 = 起始数值;
    结束数值;
    步进数值
    ){
   
}
```

  
最初循环变量的值为起始数值，每循环一次增加一个步进数值，达到结束数值后中止循环。  

我们将起始数值设为 1，用  #word 取到数组长度并设为结束数值，这就是指从 1 循环到数组结束了。

我们用 words [i] 取到数组中指定索引的元素。 循环变量 i 的值不断变化，每次就会取出不同的元素。words [1] 就取出第 1 个元素。  

然后点击『运行』按钮测试一下：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBN9iaXPnz9fxqJH83VtDfTdE1rpDbSH4fjTSHZcqiaXJyTc8yfCdcVGAAvt36t8TkhuiazfwWcoiciaD5A/640?wx_fmt=png)

运行后输出了所有单词：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBN9iaXPnz9fxqJH83VtDfTdEwXh6Tic7sUBfkibEnpnkianZQAmOxtfuuwz5rOSQicd5EMN3WQjHMX2eFQ/640?wx_fmt=png)

前面我们已经学习了可以用 # 操作符取对象的长度。

下面我们小改一下代码，输出单词的长度，新的代码如下：  

```
var words = {"Android";"Arduino";"aardio"}

for(i=1;#words;1){
    var word = words[ i ];
    winform.edit.print(word,"长度："+#word);
}
```

  
我们再给数组先排序，将最短的单词放在最前面，代码如下：

```
var words = {"Android";"Arduino";"aardio"}

//排序
table.sort(words,function(next){
    return #owner < #next
})
```

  
aardio 中的数组、对象都是表（ table ），操作数组的函数也都在 table 名字空间。

table.sort 的作用是给数组排序，第 1 个参数指定数组，第 2 个参数指定排序函数，排序函数的 owner 参数指的是当前项，next 指的是下一个项，返回值一个布尔值（true 或 false ）决定谁大谁小，谁在前面谁在后面。

这里再说几个知识点：

1、owner  是函数隐藏传递的参数，很像 JavaScript 中的 this，例如调用 table.sort 的时候 —— 在 sort 函数里的 owner 参数就是函数的所有者 table ，而同一个函数可以被赋值给不同的对象，调用时的 owner 参数也可以被改变。但在有些特殊的函数中，owner 参数有特殊用途，例如在上面的排序回调函数中，owner 表示当前正在比较的元素。  

2、# 操作符可用于取字符串的字节长度（ 汉字有多个字节，取字符数应当用 string.len 函数 ）。  

其实我们还可以将匿名函数写为 lambda 函数，例如：  

```
table.sort(words,lambda(n)#owner<#n);
```

  
这只是省略 return 语句的一个语法糖，运行意义上与前面的匿名 function 没有区别。

我们再次点『运行』按钮：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBN9iaXPnz9fxqJH83VtDfTdEibd0uucKLSWMzyibMOwKezsDuDRKyYCo6eauwSiaFsygkMQsbTb1YcX4A/640?wx_fmt=png)

看一下运行后的效果：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBN9iaXPnz9fxqJH83VtDfTdE2SQUPPM9Y9BjxstRsd1H5AicwDKRNNHIicfXAtG2HSm3wzUISmAI256Q/640?wx_fmt=png)

太好了，您已经学会了。

**▶** **取出使用字母数目最少的单词**

我们先把大问题分解成小问题。

1、将字符串拆分成字符数组。

2、对数组去重。  

我们创建一个控制台测试程序：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBN9iaXPnz9fxqJH83VtDfTdERjtqKicicLicntum5hfslVRQbQL9ibkick8kx84R5hzZdmficLvJhnMfe4lQ/640?wx_fmt=gif)

输入以下代码：

```
import console; 

//定义字符串
var word = "aardio";

//拆分为数组
var letters = string.split(word);

//显示数组
console.dump(letters);
console.pause(true);
```

  
然后点击『运行』，显示效果如下：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBN9iaXPnz9fxqJH83VtDfTdEnmT2s0cmJywEpDusBDGo0KsmpVXrFjOtMFgwRuAslOUAylUw9t3iaIQ/640?wx_fmt=png)

我们成功了！

下面再修改代码，增加去重：

```
//定义字符串
var word = "aardio";

//拆分为数组
var letters = string.split(word);

//数组去重
letters = table.unique(letters);

import win.clip;

//复制数组到剪贴板
win.clip.write(table.tostring(letters))
```

得到数组如下：

```
{
    [1]="a";
    [2]="r";
    [3]="d";
    [4]="i";
    [5]="o"
}
```

  
上面这样写数组也是允许的。  
每个元素都是一个键值对，等号前面为键，等号后面为值。但以数值这样的表达式作为键时 —— 必须放在中括号 [] 内部。

可是我们还有更多字符串要处理，都这样来一遍那就麻烦了。  

所以我们将上面的代码放到一个函数里，以方便重复调用。  

```
//定义局部函数
var getLetters = function(word){
    
    //拆分为数组
    var letters = string.split(word);
    
    //返回去重后的数组
    return table.unique(letters);
}
```

  
然后我们调用上面的函数，将字符串转换为去重后的字符数组：  

```
//定义局部函数
var getLetters = function(word){
    
    //拆分为数组
    var letters = string.split(word);
    
    //返回去重后的数组
    return table.unique(letters);
}

var words = {"Android";"Arduino";"aardio"}

//遍历表的成员
for(i,word in words){ 
    
    //替换为字符数组
    words[ i ] = getLetters(word);
    
    //记录原始单词
    words[ i ].word = word;
}
```

  
for ... in 是遍历表的所有成员。注意表可以包含数组，也可以包含非数组成员。

下面我们再排序，显示在文本框中：  

```
//排序
table.sort(words,lambda(n)#owner<#n);

//输出到文本框
for(i=1;#words;1){
    var word = words[ i ];
    winform.edit.print(words[ i ].word,"字母数目："+#word);
}
```

  
好吧，这里我不给完整代码。  
您试试将上面的代码合并为一个完整的程序，然后运行看看结果。

如果中间碰壁了，那你就成功了，不碰壁你学不到技术，不碰壁你没办法成长。  

回想我自己初学编程的时候，碰壁比你们只多不少，不过我从来没有在网上说过，每次我碰壁我就责备我自己，找我自己的原因 …… 现在回想一下，如果我没这样做，估计现在还是个小白。

**▶ 找出所有单词使用的相同字母**

这次增加难度，我直接发代码，不作任何讲解。  

如果有任何不明白的请直接看 《 aardio 语法与使用手册 》。

aardio 中的文档精心制作了 17 年，公众号上的教程只不过一拍脑袋就写好了，很可惜个别新手拿着真正的宝不识货啊。  

```
import console; 

var words = {"Android";"Arduino";"aardio"}

//全部转换为小写
words = table.map(words,string.lower)

//数组合并为字符串
var strWords = string.join(words);

//拆分字符为数组
var letters = string.split(strWords);

//数组去重
letters = table.unique(letters);

//遍历所有字母
for(i,letter in letters){
    
    //遍历所有单词
    for(k,word in words){
        
        //如果在单词中没有找到当前字母
        if(!string.find(word,letter)){
            
            //跳到下一个 letter
            continue 2;
        }
    }
    
    console.log("所有单词都使用了字母",letter)
}

console.pause(true);
```