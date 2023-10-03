> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650933048&idx=1&sn=e8296d5ebc594a301ef50b8588fc6162&chksm=84aa2c82b3dda59400e86628c0c34dab2db3444245d89f88c1b86b123eec4a9674759e9a4a59&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

请先阅读上一篇教程：[《 表 》](http://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650933020&idx=1&sn=7cdc36249e59d7b72096c02f743c603e&chksm=84aa2ca6b3dda5b0dfa4ef1be44d60a26137220b7a9f3917ebd8996fcc6b90634a4022ddba64&scene=21#wechat_redirect)。 

我做了一个扩展库 string.words 。这是一个更大的英语单词表，『键』是单词，『值』为对应的中文释义。

查询表的方法我们已经学会了，小试一下：

```
import console; import string.words; var exp = string.words["aardio"];console.log( exp );console.pause(true);
```

下面我们增加难度，在单词表中找出所有 "aar" 开头的词：  

```
import console; import string.words; for(k,v in string.words){        //查找 "aar" 开头的词    if( string.startWith(k,"aar",true) ){        console.log(k,v);     }}console.pause(true);
```

  
有没有发现查询结果里 aar 开头的词都是「名字」，这些名字有朝圣之地、神话人物、光明神圣仪式、美丽城市、漂亮女人 …… 

string.startWith 用于判断参数 @1 指定的字符串开始部分是否为参数 @2 指定的字符串，如果参数 @3 为 true 则忽略大小写。

我们写代码输入函数的时候，这些函数用法说明会自动显示。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPCtR6ic4NKiaqFzAnB49rJk0EEDxrmjOClUk3zLeJqEGVVmIGn15khmtic2O6kK6mwFSo03QXeHzBfw/640?wx_fmt=png)

或者在参数列表中按一下逗号，上面的函数说明会再次显示。  

也许您注意到了，这些函数说明都很简洁。aardio 是一个做减法不做加法的编程语言，我们力争用最少的文字说明一个函数的用法，并努力将每一个函数的用法做得尽可能简洁。

下面我们用模式匹配实现相同的功能：  

```
import console; import string.words; for(k,v in string.words){        //查找 "aar" 开头的词    if( string.find(k,"^aar") ){        console.log(k,v);     }}console.pause(true);
```

  
下面我们再增加一点难度：查出所有 r 开头的名词，并且释义与『人』有关。

实现代码如下：

```
import console; import string.words;for(k,v in string.words){        //查找 r 开头，与“人”有关的名词    if( string.find(k,"^r")        && string.find(v,"!\wn\..*人.*")     ){        console.log(k,v);     }}console.pause(true);
```

  
我们简单解释一下上面的模式表达式：  

*   **"^r"**  
    查找 r 开头的单词，**"^"** 符号用于限制匹配字符串的开始位置。
    
*   **"\w"**  
    匹配字母和数字、以及下划线，如果是大写的 **"\W"** 则取反义 —— 用于匹配不是字母、数字、下划线的字符。
    
*   **"!\w"**  
    这是边界断言，不消耗任何字符。边界断言起始于一个感叹号，后面紧跟一个模式元 —— 表示从不匹配该模式元，转换到匹配该模式元的边界。 **"!\w"** 表示的就是单词的边界。
    
*   **"!\wn\."**  
    这匹配的是单词边界后面紧跟 **"n."** ，因为 **"."** 表示任意字符，所以我们要在前面加上转义的反斜杆，用 **"\."** 表示真正的 **"." 。**
    
*   **".* 人.*"**  
    上面的 "." 表示任意字符，而 **"*"** 表示它修饰的字符可以出现任意次数。**".*"** 表示任意字符出现任意次数。所以 **".* 人.*"** 表示的就是字符串包含『人』字，且『人』前『人』后都可以有任意次数的任意字符。