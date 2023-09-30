> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650932047&idx=1&sn=1c3effc1588143983442fc663dd78f92&chksm=84aa28f5b3dda1e3966966235ec595455f90b38742ab86ec1e75e0b0bbfb884f8ffab60f71a1&scene=178&cur_album_id=2209804829378543621#rd)

**一、在 aardio 中定义 Python 全局变量**  

```
import console;
import py3; 

//设置 __main__ 模块变量
py3.main.gVar = "这样指定 Python 全局变量";
 
//执行Python3 的代码
py3.exec( `
def func(): 
    return gVar 
` ); 

//调用 Python __main__ 模块内的函数
console.log( py3.main.func() );

console.pause();
```

注意上面用反引号（ 键盘左上方的  ESC 下面那个键）包含 Python 代码。在 aardio 中反引号的作用与双引号一样都是包含原始字符串（ 单引号里才支持转义符）。  

**二、将任何 aardio 对象导出到 Python 环境**  

Python 调用 COM 对象不是很方便，这很容易解决，在 aardio 用一句 py3.export (com) 就可以把 com 库提供给 Python，在 Python 调用 aardio  对象 —— 真的太简单了 。  

```
import com;  
import winex; 
import py3;

//导出 aardio 中 com 库到 Python 环境
py3.main.com = py3.export(com); 
 
var pyCode = /** 
def testPy(winex): 
    wsh = com.CreateObject("wscript.shell")
    wsh.exec("notepad")  
    
    winex.wait(None,None,"Notepad","Edit"); 
**/

//执行Python代码
py3.exec( pyCode ); 
 
//调用 Python 函数
py3.main.testPy(  
  py3.export(winex) //也可以通过参数将 aardio 对象导出给 Python
);   
```

在 aardio 中可以将注释赋值给一个字符串，aardio 的多行注释如同所有类 C 语言放在 /* ..... */ 标记内部，但 aardio 里这个标记的首尾 * 号数目要匹配 —— 利用这一特性，我们可以任意嵌套这个标记而不会发生冲突（ 所以用注释包含其他类 C 语言的源代码就非常方便）。  
**三、aardio 对象传入 Python 是传值， Python 对象传入 aardio 传址。**  
这个一定要牢记，例如你在 aardio 中创建 Python 对象 py3.int (123) 你得到的一定不是一个 aardio 数值，而是一个 py.object 对象。当你执行下面的代码时你会看到控制台输出了 123：

```
console.log( py3.int(123) );
```

这是因为 console.log 会自动调用 tostring () 函数将所有参数转换为字符串，所以上面的代码等价于：  

```
console.log( tostring(py3.int(123)) );
```

而上面的代码又会被转换为下面的调用：  

```
console.log( py3.int(123).toString() );
```

如果你想把这个 Python 数值转换为 aardio 数值要这样写：  

```
console.log( py3.int(123).toNumber() );
```

或者这样写：  

```
console.log( tonumber(py3.int(123)) );
```

aardio 总是引用原始的 Python 对象 —— 而不是去复制这些对象的值。  

但如果 aardio 对象传入 Python 则是传值，例如你在 aardio 里调用 Python 函数，然后传一个 aardio 字符串、或 aardio 数组给 Python ，Python 里收到的一定是重新创建的 Python 对象。

那么我们前面讲的 py.export () 是如何实现在 Python 中引用 aardio 对象的呢？！py.export () 其实返回的是一个 Python 对象 —— 但是这个 Python 对象里记录了 aardio 对象的地址，具体实现请参考这个库的开源代码。

**四、aardio 里怎么执行 *.py 文件**  

我们在范例里基本都是执行放在字符串里的 Python 代码，这只是为了方便复制粘贴。一般我们写程序需要先创建一个 Python 工程：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBMLkOPh1LF90g4Tpg1epYl07AvAibpfhxQns82VHGZicLbCvYP92TuGFxPuRqTADBpqIuy75JgBGUlA/640?wx_fmt=png)

在 Python 工程里默认有 2 个的目录：

1、/res/ 目录，这个目录是一个嵌入资源目录，该目录下的文件发布后会嵌入 EXE  内。aardio 中的很多函数都自动兼容这种资源目录路径（必须以斜杆或反斜杆为首字符以表示工程根目录），例如用 string.load ("/res/test.txt") 可以读取资源文件内容，用

```
py3.exec("/res/test.py")
```

可以执行资源目录下的 Python 代码。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBMLkOPh1LF90g4Tpg1epYl0RzDB121IvLytu6T60xiaKOlJjbhNALNAZ3icYzAxibvrvKr9hkVR4hgTQ/640?wx_fmt=png)

  
2、/py/ 目录，这个目录不需要设为嵌入资源目录，Python 可加载这个目录下的 Python 模块文件。例如：

```
py3.import("pyMain")
```

就可以导入 /py/pyMain.py 文件，当然也可以在 Python 代码里导入这些模块。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBMLkOPh1LF90g4Tpg1epYl0I7QbRXy8s1Uz2XyNMdIdZQGuv0kSpYibdkMI4I0Dsl8KU2gIqV8rJxw/640?wx_fmt=png)

要注意只有添加到工程中的文件才会被发布，可以右键点工程目录，然后点击「同步本地目录」自动添加该目录下的所有文件：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBMLkOPh1LF90g4Tpg1epYl0SXJ7HP5lAZ31fJybgU1vmYa9PAlESiauPahicEmunNY4TIwzM7Bb6nyA/640?wx_fmt=png)

**五、如何安装更多 Python 模块**  

aardio 中几乎不需要自己动手去安装扩展库，运行代码就会自动分析引用 —— 缺少的库会自动安装，而且几乎不会遇到版本冲突、或者各种依赖模块问题。  

Python 这一块其实是略有些麻烦的，但是只要你在 Python 里知道怎么安装模块，在 aardio 中并不会更麻烦多少。唯一记住的就是系统安装的 Python 开发环境使用的 Python 版本要与你在 aardio 中使用的 Python 版本完全相同，在 aardio 中可以这样查看 py3 扩展库使用的 Python 版本信息（ 注意是 32 位环境 ）：

```
import console;
console.open();

import py3;  
py3.run();
```

然后在系统安装的相同版本 Python 环境下用 pip 安装模块，要注意看 pip 的提示安装了哪些依赖模块，在 Python 安装目录下打开 \Lib\site-packages 目录找到安装好的模块文件以及依赖模块文件 —— 打开目录你就能看懂。 

把你所需要的全部模块文件复制出来，放到 aardio 里就可以了。可以把添加的模块放到工程目录下面的 /py/ 目录下，也可以放到扩展库目录下，例如 py3 扩展库可以在 "~\lib\py3\.res\DLLs" 目录下添加模块。  
当然也可以放到其他目录下，  
然后在 aardio 里用下面的代码添加该模块所在目录：

```
py3.appendPath("模块的父目录路径");
```

我们还可以在 aardio 里添加扩展库自动做这些事，用 aardio 扩展库做这事有一个极大的好处  —— 在 aardio 库目录下可以添加一个 

```
\.build\main.aardio
```

 「发布触发器」文件。在发布生成 EXE 以后 aardio 会检测程序引用的所有库，并在该库目录下查找上述的「发布触发器」，如果找到「发布触发器」就会执行该触发器。所以我们可以利用这个文件写上几句代码 —— 在发布时把 Python 模块复制到发布目录下正确的位置。  
我写了一个安装 Python 模块的 aardio 扩展库作为范例，先演示一下用法：  

```
import py3;
import py3.lib.jsonrpclib;

thread.create("~\codes\范例程序\8) Web 应用\2) JSON\rpcServer.aardio")
thread.delay(1000);

var pyCode = /**
def testRpc():
  import jsonrpclib
  server = jsonrpclib.Server('http://127.0.0.1:8610/jsonrpc')
  return server.hello("jacen" ) 
**/
 
py3.exec(pyCode);

import console;
console.log( py3.main.testRpc() )
console.pause()
```

jsonrpclib 是一个 Python 3 模块，用于实现 JSON-RPC 服务端或客户端。py3.lib.jsonrpclib 扩展库就是用来自动安装这个模块。  
这个 py3.lib.jsonrpclib  扩展库的主要源代码其实就一句：  

```
py3.appendPath("~\lib\py3\lib\jsonrpclib\.py")
```

建议大家看一下这个扩展库的源代码，以及这个扩展库目录下面的「发布触发器」，代码很少，我写了很多注释。  
不要认为直接用 pip 安装多简单 —— 那个装了只能你自己用。而在 aardio 里配置好 Python 模块以后，那么你发布的软件可以给任何用户用了，他们不需要再去下载、配置、安装额外的 Python 环境或模块。

**六、在 aardio 中如何选择 Python 版本**

aardio 几乎为所有主要 Python 版本都编写了扩展库：  

```
import py2; //导入 Python 2.7 扩展库，支持 XP 及 XP 以上系统
import py3; //导入 Python 3.8 扩展库，支持 Win7 及 Win7 以上系统
import py3.10; //导入 Python 3.10 扩展库，支持 Win10 及 Win10 以上系统
import py3.6; //导入 Python 3.6 扩展库，支持 Win7 及 Win7 以上系统
import py3.4; //导入 Python 3.4 扩展库，支持 XP 及 XP 以上系统
```

在一个程序中，不应同时导入多个不同版本的 Python 扩展库，aardio 中所有 Python 扩展库都自带绿色 Python 运行时。

注意 py3 扩展库导入后使用时应去掉副版本号，例如：

```
import py3.4;

import console;
console.log( py3.version );
console.pause();
```

大家可能会问为什么其他编程语言的扩展库都只有一个版本，为什么 Python 要搞这么多版本呢？！这就一言难尽不多说了。

**七、快速掌握 aardio 需要看哪些教程**  

如果有 Python 基础，这里推荐一些不会消耗太多时间，又非常重要的教程：

1、aardio 之特殊符号用法大全

> aardio 之特殊符号用法大全
> 
> https://bbs.aardio.com/forum.php?mod=viewthread&tid=11257

2、系列教程：使用 plus 控件制作精美界面

> 系列教程：使用 plus 控件制作精美界面
> 
> https://bbs.aardio.com/forum.php?mod=viewthread&tid=11486​

3、aardio 多线程开发入门  

> aardio 多线程开发入门
> 
> https://bbs.aardio.com/forum.php?mod=viewthread&tid=13625

4、模式匹配快速入门

> 模式匹配快速入门
> 
> https://bbs.aardio.com/forum.php?mod=viewthread&tid=172

5、使用 web.rest 实现 REST-RPC

> 使用 web.rest 实现 REST-RPC
> 
> https://bbs.aardio.com/forum.php?mod=viewthread&tid=11218

6、aardio 入门系列教程

> aardio 入门系列教程
> 
> https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzA3Njc1MDU0OQ==&action=getalbum&album_id=2209804829378543621&scene=173&from_msgid=2650931928&from_itemidx=1&count=3&nolastread=1#wechat_redirect

7、几个重要的范例一定要看

  
「aardio 范例 / Windows 窗口 / 入门 」  
「aardio 范例 / 调用其他语言 / Python 语言 」  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBMLkOPh1LF90g4Tpg1epYl0ztQMgUgFmVHOu2CbOBG5uDljCibjoMbEIGiarRUB0NIsXjia67PfjkGvg/640?wx_fmt=png)

**七、 aardio 与 Python 语法规则等简单对比**

在「 aardio 范例 / 调用其他语言 / Python 」目录下有更多内容，这里说几个最基本的：  

aardio 以 // 开始行注释

Python3 以 # 符号开始行注释。

aardio 以 /* ...... */ 包含允许多行的大段注释，要求首尾标记星号数目匹配。可用于赋值语句将注释赋值为字符串。

Python 以 """......""" 包含允许多行的大段注释。

aardio 转义字符串可以放在单引号里，原始字符串放在双引号或反引号里（字符串内可用两个引号表示原来的引号）

而 Python 双引号、单引号内都是转义字符串，在双引号字符串前加 r 表示原始字符串。

aardio 在引号内的字符串可以任意换行。

Python 在引号内的字符串要在行尾添加续行符 \ 才能换行。

aardio 中使用 {} 包含语句块。  

Python 使用缩进包含语句块，同一语句块内代码缩进使用的空格、制表符、重复次数要完全一致。

aardio 使用 var 语句定义局部变量，否则默认为全局变量。

Python 使用 global 定义全局变量，否则默认为局部变量。

aardio 使用 ... 表示不定参数。

Python 在参数名字前加 * 号表示不定参数。

aardio 关键字首字符都是小写，例如 true,false,null。只有全局常量，外部 API, 外部 COM 函数等会首字符大写。

Python 有些关键字首字符大写，例如 True,False,None。

aardio 中空值为 null。  
Python 中空值为 None。  

aardio 下划线开始的成员变量、属性是只读保护变量，只能设置一次非 null 值。

Python 变量名前后的下划线有特殊用途，但规则更复杂一些：__名字__  为系统保留，__名字 为私有属性，_名字 为保护类型属性。

aardio 可以将任何不存在的变量、属性作为表达式直接判断 null 值。

Python 中访问不存在的变量会抛出 NameError 异常，而访问对象不存在的属性会抛出 AttributeError,KeyError 异常。

aardio 中一个函数失败惯例多会返回两个返回值，即 null, 错误信息。不会轻易抛出异常，很少使用 try 语句。

Python 中抛异常比较常见，try 语句用得多一些。

aardio 是标识符大小写敏感的语言。

Python 同样是标识符大小写敏感的语言。

aardio 的代码文件是 UTF8 编码。

Python3 的代码文件也是 UTF8 编码。

aardio 字符串默认使用 UTF-8 编码，兼容二进制字符串，支持 UTF-16 编码的 Unicode 字符串，aardio 字符串拥有 UTF 自动标记功能.

Python3 字符串为 Unicode 编码，而 aardio 与 Python 接口交互统一使用的是 UTF-8 编码。

> 关于 UTF 标记
> 
> ​Jacen He，公众号：aardio [神奇的 UTF 标记](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650931841&idx=1&sn=160e3af4c53e43fdd78e8e16f2520175&chksm=84aa293bb3dda02d9cff36cfbb3529614d3b39da5548b4f39bdd81c9e64b2b2df5b4106a1c53&token=1442005477&lang=zh_CN#rd)

aardio 中的二进制字节数组为 buffer 类型。

Python3 中的二进制字节数组为 bytes 类型。

aardio 中定义一个字典（表）：  

```
var dic = {  键 = "值"; 键2 = "值2"; test = 123;}
```

Python 中定义一个字典：  

```
dic = {  "键" : "值","键2" : "值2", "test" : 123 }
```

有趣的是在 aardio 中也允许使用上面的语法定义表对象。  

Python 遍历字典是这样写：  

```
for k in dic:
    print(k)
    print(dic[k])
```

aardio 遍历字典 (表) 这样写：  

```
for k,v in dic{
  io.print(k,v)
}
```

Python 中删除一个字典成员:

```
del dic["test"]
```

aardio 中删除一个表成员：  

```
dic["test"] = null
```

Python 中定义列表：  

```
list =[1,2,34,56]
```

aardio 中定义数组：  

```
list = {1,2,34,56 }
```

aardio 数组原来只允许用分号分隔，为了让大家少学新语法现在允许用逗号分隔了。

Python 中循环遍历列表：

```
for i in list:
    print( i )
```

aardio 中循环遍历数组：  

```
for(i=1;#list){
    io.print(list[i]) 
}
```

Python 中定义一个类：  

```
class Stack(object): 
    def __init__(self): 
        self.stack = [ ] 

    def push(self,object): 
        self.stack.append(object)
```

aardio 中定义一个类：

```
class stack {

    ctor(){
        this.stack = {}; 
    };
    push = function(object){
        ..table.push(this.stack ,object);
    }
}
```

Python 中构造函数叫 __init__，aardio 中构造函数叫 ctor。Python 中当前对象实例叫 self，aardio 中当前对象实例叫 this，self 在 aardio 中表示当前名字空间，注意 aardio 类有独立的静态名字空间 - 在类内访问全局名字空间的变量要在前面加两个点，例如 ..table 。