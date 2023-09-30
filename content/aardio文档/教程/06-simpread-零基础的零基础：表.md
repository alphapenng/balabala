> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650933020&idx=1&sn=7cdc36249e59d7b72096c02f743c603e&chksm=84aa2ca6b3dda5b0dfa4ef1be44d60a26137220b7a9f3917ebd8996fcc6b90634a4022ddba64&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

首先我们用 aardio 创建一个窗口，然后拖一个文本框控件上去。

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPeWr7vjHvIe68hlMvngDxCwnBW67n4YVqedWr2e9shaduQdaLSsJuskIbw6rRdicN4FXTvvugDtRQ/640?wx_fmt=gif&wxfrom=5&wx_lazy=1&wx_co=1)  

点选文本框控件，在右侧属性面板开启滚动条：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBNG3WWD9J63KwJbGta0MADQ7Qz3QbLMOk4YSyZ4YGsDpaY4XTosFPUVibyk8OZLYmgFHoOibQoRwbKQ/640?wx_fmt=gif)

滚动条的属性值为布尔值，布尔值只有 2 个：true 为真（是），false 为假（否）。  

然后切换到代码视图：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBNG3WWD9J63KwJbGta0MADQ8VP6f1hXgVdJpNOTiceLkaSn1qdtXPicttmHdItKYq1CXjrlTI2iaiarxQ/640?wx_fmt=gif)

输入以下代码：

```
var tab = {        aar="阿勒河";    aaron="亚伦(摩西之兄)";    aardvark="食蚁兽";    aardwolf="土狼";    aarhus="奥尔胡斯，丹麦第二大城市";    aaronic="亚伦的";    aardman="阿德曼动画公司，世界顶尖的定格动画制作者";    aardenburg="亚丁堡，中世纪亚丁堡成为欧洲人朝圣的地方";    aardonyx="地球之爪，食草类恐龙，生活在侏罗纪早期，距今将近1.95亿年，成年地球之爪体重半吨，体长可能达到15米";    aargau="阿尔高州,位于阿勒河的下游,瑞士最大的工业州";    aarau="阿劳,阿尔高州首府";    aarti="《生活大爆炸》女演员 Aarti Mann";    aaru="雅卢，芦苇之地，古埃及神话的天国乐园。雅卢的方位与去处通常是位在东方，那里是太阳升起的地方，并且被描述为一处漫无边的芦苇平原";    aarey="艾瑞森林";}
```

  
上面的代码就创建了一个表 (table)。

表包含在  { } 内 ，表成员用分号隔开（可以用逗号替代）。表的每个成员都是一个键值对，键值对用等号分开，等号前面是键，后面是值。

『键』也可以称为『下标』，『索引』，通过键可以检索到对应的值，或者说用每个键都关联一个对应的值。表用键检索值的速度是极快的，键也具有唯一性，一个表中不会出现两个相同的键。

键名字也可以放在下标操作符中，例如上面的表，也可以这样写：  

```
var tab = {    ["aar"]="阿勒河";    ["aaron"]="亚伦(摩西之兄)";    ["aardvark"]="食蚁兽";    ["aardwolf"]="土狼";    ["aarhus"]="奥尔胡斯，丹麦第二大城市";    ["aaronic"]="亚伦的";    ["aardman"]="阿德曼动画公司，世界顶尖的定格动画制作者";    ["aardenburg"]="亚丁堡，中世纪，亚丁堡成为欧洲人朝圣的地方";    ["aardonyx"]="地球之爪，食草类恐龙，生活在侏罗纪早期，距今将近1.95亿年，成年地球之爪体重半吨，体长可能达到15米";    ["aargau"]="阿尔高州,位于阿勒河的下游,瑞士最大的工业州";    ["aarau"]="阿劳,阿尔高州首府";    ["aarti"]="《生活大爆炸》女演员 Aarti Mann";    ["aaru"]="雅卢，芦苇之地，古埃及神话的天国乐园。雅卢的方位与去处通常是位在东方，那里是太阳升起的地方，并且被描述为一处漫无边的芦苇平原";    ["aarey"]="艾瑞森林";}
```

  
键名如果是合法的标识符，就可以省略下标操作符，也不用放到字符串里。  

下标操作符里可以放任何表达式，键也可以是除了字符串以外的任意类型的值。

表也可以包含数组，只不过数组的索引是整数值，示例：

```
var tab = {    [1]="aar";    [2]="aaron";    [3]="aardvark";    [4]="aardwolf";    [5]="aarhus";}
```

  
可用下标操作符访问表的成员，例如：  

```
var name = tab[1];var value = tab["aar"];
```

  
如果键名是合法标识符，也可以改用成员操作符（圆点）来访问表的成员。

示例：  

```
var value = tab.aar;
```

  
名字空间也是表，例如我们在当前名字空间声明变量：  

```
name = "变量值";
```

  
等价于下面的写法：  

```
self["name"] = "变量值";
```

  
self 表示当前名字空间，也可以这样写：

```
self.name = "变量值";
```

  
这里就不多讲了，《 aardio 语法与使用手册 》讲得更详细。  

我们回到前面的窗口程序：添加循环遍历表，输出表中键值对到文本框的代码：

```
for(k,v in tab){    winform.edit.print(k);    winform.edit.print(v);    winform.edit.print();}
```

  
请点『运行』按钮看一下效果，这里就不截图了。  

表默认是无序的，可以改用 table.eachName () 排序后再输出：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBNG3WWD9J63KwJbGta0MADQw6pnO1cPDd0knqJ4Lk5beo7fE0OySef4Kgt0FeNpU3ic85CequGCVjQ/640?wx_fmt=gif)

下面我们修改代码，将表转转换为 JSON :  

```
var tab = {    aar="阿勒河";    aaron="亚伦(摩西之兄)";    aardvark="食蚁兽";    aardwolf="土狼";    aarhus="奥尔胡斯，丹麦第二大城市";    aaronic="亚伦的";    aardman="阿德曼动画公司，世界顶尖的定格动画制作者";    aardenburg="亚丁堡，中世纪，亚丁堡成为欧洲人朝圣的地方";    aardonyx="地球之爪，食草类恐龙，生活在侏罗纪早期，距今将近1.95亿年，成年地球之爪体重半吨，体长可能达到15米";    aargau="阿尔高州,位于阿勒河的下游,瑞士最大的工业州";    aarau="阿劳,阿尔高州首府";    aarti="《生活大爆炸》女演员 Aarti Mann";    aaru="雅卢，芦苇之地，古埃及神话的天国乐园。雅卢的方位与去处通常是位在东方，那里是太阳升起的地方，并且被描述为一处漫无边的芦苇平原";    aarey="艾瑞森林";}import web.json;var json = web.json.stringify(tab,true);winform.edit.print(json);
```

  
这里我们导入了一个标准库 web.json 。  

然后再点『运行按钮』，在文本框中输出的 JSON 如下：  

```
{    "aar":"阿勒河",    "aarau":"阿劳,阿尔高州首府",    "aardenburg":"亚丁堡，中世纪，亚丁堡成为欧洲人朝圣的地方",    "aardman":"阿德曼动画公司，世界顶尖的定格动画制作者",    "aardonyx":"地球之爪，食草类恐龙，生活在侏罗纪早期，距今将近1.95亿年，成年地球之爪体重半吨，体长可能达到15米",    "aardvark":"食蚁兽",    "aardwolf":"土狼",    "aarey":"艾瑞森林",    "aargau":"阿尔高州,位于阿勒河的下游,瑞士最大的工业州",    "aarhus":"奥尔胡斯，丹麦第二大城市",    "aaron":"亚伦(摩西之兄)",    "aaronic":"亚伦的",    "aarti":"《生活大爆炸》女演员 Aarti Mann",    "aaru":"雅卢，芦苇之地，古埃及神话的天国乐园。雅卢的方位与去处通常是位在东方，那里是太阳升起的地方，并且被描述为一处漫无边的芦苇平原"}
```

  
有趣的是 aardio 也可以用上面的 JSON 代码创建 table，示例：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBNG3WWD9J63KwJbGta0MADQNg933AxvoNlCLebRiaPz7SlTQjwzRhXuPbGcago4W16bHKyrhJJ8BFw/640?wx_fmt=png)

这是因为 aardio 允许用引号包含键名，并允许用「冒号」替代「等号」分隔键值对。

我们可以右键点 web.json.stringify 函数，在弹出菜单中点击『转到定义』查看该函数的源代码。  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBNG3WWD9J63KwJbGta0MADQxzr3Wic6YcjFD6ZPBmJYmqaiaCpmdgZ2hp7cSoK21RFdmibo03gRFQPgA/640?wx_fmt=gif)

aardio 的标准库都是开源的，这个优势要用起来。

输入代码时，编辑器也会自动提示函数的用法：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBNG3WWD9J63KwJbGta0MADQ1miceYTWrajgibC2qwVufBtI5TvT9EWB2DronYcltXNChQqYAiaDGoFvA/640?wx_fmt=png)

如果一个调用函数的传递的唯一的一个参数是表，例如：  

```
winform.edit.print({    name = "aar";    value = "阿勒河";});
```

  
这时可以省略首尾的 { } ，例如：  

```
winform.edit.print(     name = "aar",value = "阿勒河" );
```

  
表的分隔符允许将分号换成逗号，上面这样写就实现了类似命名参数的效果 —— 当然这只是个语法糖，本质上传过去的参数还是一个表。  

我们学编程，一定要有探索精神，要多给自己出难题，要想办法让自己多碰壁，碰壁碰得越多，技术提升就越快。我初学编程的时候，就经常碰壁，我一碰壁就找我自己的原因，我一碰壁就责备我自己，从来没想过到网上去指责他人 …… 现在回想一下，如果我当初不这么做，现在铁定还是个小白。

下面我就为大家准备了一个碰壁的机会。

我小改了一下上面的代码，如果您能完全靠自己整明白，那么您绝对是一个学编程的天才。  

```
import win.ui;/*DSG{{*/var winform = win.form(text="aardio form";right=599;bottom=334)winform.add(edit={cls="edit";left=10;top=9;right=584;bottom=320;edge=1;hscroll=1;multiline=1;vscroll=1;z=1})/*}}*/var tab = {        aar="阿勒河";    aaron="亚伦(摩西之兄)";    aardvark="食蚁兽";    aardwolf="土狼";    aarhus="奥尔胡斯，丹麦第二大城市";    aaronic="亚伦的";    aardman="阿德曼动画公司，世界顶尖的定格动画制作者";    aardenburg="亚丁堡，中世纪，亚丁堡成为欧洲人朝圣的地方";    aardonyx="地球之爪，食草类恐龙，生活在侏罗纪早期，距今将近1.95亿年，成年地球之爪体重半吨，体长可能达到15米";    aargau="阿尔高州,位于阿勒河的下游,瑞士最大的工业州";    aarau="阿劳,阿尔高州首府";    aarti="《生活大爆炸》女演员 Aarti Mann";    aaru="雅卢，芦苇之地，古埃及神话的天国乐园。雅卢的方位与去处通常是位在东方，那里是太阳升起的地方，并且被描述为一处漫无边的芦苇平原";    aarey="艾瑞森林";        print = function(edit){        for k,v in table.eachName(owner){            if(k!="print")edit.print(k,v);        }    }}tab.print( winform.edit );winform.show();win.loopMessage();
```