> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650932366&idx=1&sn=36e845da4fc885130efe8dfba9ea2335&chksm=84aa2f34b3dda622675148bc02c023e0ed66e21b84882c40edb58e06ebb23254d0a8a090cb45&scene=178&cur_album_id=2209804829378543621#rd)

本文仅供有编程基础的用户快速了解常用语法。如果『没有编程基础』 ，那么你可以通过学习任何一门编程语言去弥补你的编程基础，不同编程语言虽然语法不同 —— 编程基础与经验都是可以互通的。我经常看到一些新手说自己没有编程基础或经验，然后过了三年、五年，我看到他还是在说自己没有编程基础或经验。**仅仅是掌握编程基础知识或者积累基本的编程经验 —— 通过任何你喜欢的编程语言都不难做到。编程真正困难的并不是怎么拿到入场券 —— 而是如何写出优秀的软件**。

有的新手跟我说：“我没有编程基础，学了几个小时，都没有掌握编程基础 …… 你的文档是怎么写的，你的教程是怎么写的 …… 你们这些做编程语言的人到底是怎么想的 ……”。其实零基础前提下只想花几个小时就能学会一门新编程语言 ——  这只有百年不遇的天才能做到。**aardio 很小也很简单。编写 aardio 程序也很简单，几句代码就可以写一个可运行的程序，没有任何复杂的操作。aardio 的文档和教程对很多基础知识都有讲解，也提供了大量可直接运行与使用的范例 —— 很适合新手。**不止一次有用户向我反馈，下载 aardio 只是简单地看了一下教程就把程序写出来了。也有不少用户向我反馈，尝试学习过很多编程语言都没有成功 —— 但是学习 aardio 只用了很短的时间就找到感觉了。  

****▶** 第一个控制台程序**

```
//导入库
import console; 

//加载动画
console.showLoading("加载动画测试");
sleep(1000); //暂停 1 秒

//输出字符串
console.log('测试字符串');

//输出变量
console.dump({a=123;b=456});

//以 JSON 格式输出变量
console.dumpJson({a=123;b=456});

//暂停并等待按键
console.pause(true);
```

****▶** 第一个窗口程序**  

```
import win.ui;
/*DSG{{*/
var winform = win.form(text="aardio form")
winform.add(
button={cls="button";text="测试";left=435;top=395;right=680;bottom=450;color=14120960;font=LOGFONT(h=-14);note="点这里";z=2};
edit={cls="edit";left=18;top=16;right=741;bottom=361;edge=1;multiline=1;z=1}
)
/*}}*/

//按钮回调事件
winform.button.oncommand = function(){
    winform.edit.text = "测试"; //修改控件属性
}

//显示窗口
winform.show();

//启动界面消息循环，保持窗口显示，并响应用户操作
win.loopMessage();
```

****▶** 调用静态 API**

```
//加载 DLL
var dll = raw.loadDll("user32.dll");

//调用 API 函数
dll.MessageBox(0,"测试","标题",0);
```

aardio 已经默认加载了一些常用的系统 DLL 对象，例如 ::User32, ::Kernel32, ::Shell32，::Ntdll 等。  

所以上面的代码可以简化为：

```
::User32.MessageBox(0,"测试","标题",0);
```

****▶** 静态结构体**

```
var info = {
    INT size = 8;
    INT time;
}
::User32.GetLastInputInfo( info )
```

因为 aardio 函数支持多返回值，且结构体默认为传址输出参数 —— 会添加到返回值中，所以上面的代码也可以这样写：

```
var ok,info = ::User32.GetLastInputInfo( {
    INT size = 8;
    INT time;
} );
```

****▶** 注释语句**

```
// 单行注释

/*  
多行注释，首尾星号数目必须相同。
*/
```

****▶** 变量、赋值**

```
var n = null;
var str = "字符串";
```

aardio 中的变量默认为当前名字空间变量，使用 var 语句可以定义局部变量。  

****▶** 语句、语句块**

```
{
    var n = null;
    var str = "字符串";
}
```

语句尾部可以加分号也可以不加。

语句块首尾加 { } 标记，var 语句支持语句块作用域。

****▶** 数值**

```
var num = 123.01; //10 进制数值
var hex = 0xEFEF; //16 进制数值
var num2 = 123_456; //可用下划线作为分隔符
var num3 = 2#010; //可在 # 号前自定义进制
```

****▶** 算术运算**

```
var num = 3 + 2; //加，值为 5
var num = 3 - 2; //减，值为 1
var num = 3 * 2; //乘，值为 6
var num = 3 / 2; //除，值为 1.5
var num = 3 % 2; //取模，值为 1
var num = 3 ** 2; //乘方，值为 9
```

****▶** 位运算**

```
import console;

//按位取反
var n = ~2#101;
//显示2#11111111111111111111111111111010
console.printf("2#%b", n)

//按位与
var n = 2#101 & 2#100;
//显示2#100
console.printf("2#%b", n)

//按位或
var n = 2#101 | 2#110;
//显示2#111
console.printf("2#%b", n)

//按位异或
var n = 2#101 ^ 2#110;
//显示2#011
console.printf("2#%b", n);

//按位左移
var n = 2#101 << 1;
//显示2#1010
console.printf("2#%b", n);

//按位右移
var n = 2#101 >> 1;
//显示2#10
console.printf("2#%b", n);

//按位无符号右移
var n = -2 >>> 18;
//显示 16383
console.log(n);

console.pause();
```

****▶** 字符串**

```
var str = "普通字符串。
可直接包含换行符，不能包含回车符。
可以用 "" 表示一个双引号。";

var str2 = `反引号的作用与双引号一样。
可直接包含换行符，不能包含回车符。
可以用 `` 表示一个反引号。`;

var str3 = '转义字符串
忽略回车换行，反斜杆作为转义符使用
例如 \r\n 表示回车换行';

var str4 = /*
段注释可以赋值为字符串。
首尾星号数目必须配对。
忽略首尾紧邻星号的第一个空行（如果有的话）,
其他换行总是会规范化为回车换行符，
也就是 '\r\n'。
*/

var str5 = //行注释也可赋值为字符串，不含回车换行
//在文件路径前加 $ 符号，可将该文件编译为字符串

var str6 = $"~/aardio.exe"
```

****▶** 二进制字符串、文本编码**

```
var bin = '字符串可以包含任意二进制数据，例如 \0'

var utf8 = "字符串可以包含文本，默认为 UTF-8 编码"

var utf16 = '转义字符串后加 u 字符表示 UTF-16 编码字符串'u
```

aardio 在很多地方都支持自动编码转换，例如调用 Unicode (UTF-16) 版本的 API 函数时，UTF-8 字符串可自动转换为 UTF-16 编码字符串（ 支持双向自动转换），例如以下两句代码的作用是相同的：

```
::User32.MessageBox(0,"内容","标题",0);

::User32.MessageBox(0,'内容'u,'标题'u,0);
```

在调用 ::User32.MessageBox 时，aardio 会自动检测并优先使用 Unicode 版本的 ::User32.MessageBoxW（） 函数。当然，也可以主动在 API 函数名后加上大写的 W 尾标声明这是 Unicode 版本函数（即使该函数名尾部并没有 W，也可以添加 W 尾标）。

****▶** 字符串连接**

```
//使用 ++ 操作符连接字符串
var str = "字符串1" ++ "字符串2";

//如果 ++ 前后有引号，可省略一个 + 号。
var str = "字符串1" + "字符串2";

//用 string.concat() 函数连接支持多参数，支持 null 值
var str = string.concat("字符串1","字符串2")
```

****▶** 读写文件**

```
//写文件
string.save("/test.txt","要保存在文件的字符串");

//读文件
var str = string.load("/test.txt");
```

****▶** 文件路径**

```
/*
文件路径开始可用单个斜杠（或反斜杠）表示应用程序根目录。
应用程序根目录在开发时指工程目录，发布后指 exe 目录。
*/
var str = string.load("\res\test.txt");

//文件路径中正斜杠可自动转换为反斜杠
var str = string.load("/res/test.txt");

/*
文件路径开始用波浪线表示 exe 所在目录。
aardio 不需要生成 exe 就可以运行调试，此时波浪线表示 aardio.exe 所在目录。
*/
var str = string.load("~/res/test.txt");

/*
aardio 很多读文件的函数都兼容工程内嵌资源目录。
不需要修改代码，所以 "\res\test.txt" 可以是资源目录。
如果读取文件失败，string.load() 会返回 null 值（不报错）。
*/
var str = string.load("\res\test.txt");

/*
将文件转换为完整路径。
将路径传给第三方组件时，建议这样转换一下。
*/
var path = io.fullpath("\res\test.txt");
```

注意在 aardio 中双引号内不需要转义反斜杠。所以不用写为 “\\res\\test.txt”，单引号内才需要这样写。

在 aardio 中一般不必要使用 “./dir/test.txt” 这样的相对当前目录路径。因为当前目录可以任意更改，你不知道什么时候某个第三方组件是不是悄悄帮你改了当前目录。

****▶** 嵌入文件到字符串**

在文件路径前加上 $ 操作符可将该文件编译为字符串对象。

在编译该代码时文件必须存在，程序发布后就不再需要这个文件了。

示例：

```
var str = $"\dir\test.txt";
```

不要用这个方法包含资源目录下的资源文件，  

因为这等于将同一个文件重复包含了多次，会不必要地增加发布体积。

****▶** 名字空间**

```
//导入其他库文件，同时也导入该库创建的名字空间
import console;

//打开名字空间
namespace test.a.b{
   
    //定义当前名字空间变量
    console = 123;
   
    //..console 等价于 global.console
    ..console.log(console);
}

console.pause(true);
```

默认名字空间为全局名字空间，也就是 global 名字空间。在其他名字空间访问 global 名字空间必须在变量前加上两点（ .. ） 。例如 global.console 等价于 ..console 。

在 aardio 中使用 import 导入其他库文件，同时也导入该库创建的名字空间。导入名字空间只是引入模块，访问该名字空间仍然要写完整的名字空间路径。

****▶** 表 (table)**

table（表）是 aardio 中唯一的复合数据类型，除了非复合的基础数据类型以外，aardio 中几乎所有的复合对象都是表，即使是变量的命名空间也是表。表的本质是一个集合，可以用于容纳其他的数据成员，并且表也可以嵌套的包含其他的表（table），在 aardio 里表几乎可以容纳一切其他对象。

表可以包含键值对:

```
tab = {
     a = 123;
     str = "字符串";
     [123] = "不符合变量命名规则的键应放在下标内。";
     ["键 名"] = "不符合变量命名规则的键应放在下标内。";
     键名 = {
         test = "表也可以包含表";
     }
 }
```

表也可以包含数组：

```
//在表中创建数组
var array = {
     [1] = 123;
     [2] = "数组的值可以是任何其他对象";
     [3] = { "也可以嵌套包含其他表或数组"}
 }
 
//数组的键可以省略，下面这样写也可以（并且建议省略）
var array = {
     123;
     "数组的值可以是任何其他对象";
     { "也可以嵌套包含其他表或数组"}
}
```

在表中允许使用类 JavaScript 语法，用冒号代替等号分隔键值，用逗号代替分号分隔元素，并可用引号包含键名。

示例：

```
var tag ={"name1":123,"name2":456}
```

 注意如果键名以下划线开始，则为常量字段（值为 非 null 值时不可修改） —— 可通过元属性 _readonly 禁用此规则（参考语法手册）。

****▶** 成员操作符**

```
var tab = {a = 123; b = 456};

/*
用点号访问表成员，点号后面必须跟合法的标识符
*/
var item = tab.a;

/*
用下标操符符 [] 访问表成员，[] 里可以放任何表达式。
*/
var item = tab["a"];

/*
用直接下标操符符 [[]] 访问表成员，[[]] 里可以放任何表达式。
直接下标不会触发元方法，用于 null 值也会返回 null 而不是报错。
*/
var item = tab[["a"]];
```

****▶** null 值**  

未定义的变量值默认为 null 。  
获取表对象不存在的成员值时也会返回 null 而不会报错。如果对象本身是 null 值，使用点号、普通下标获取成员值会报错，改用直接下标 [[]] 则不会报错，而是会返回 null 值。

用 # 操作符获取 null 值长度返回 0 而不是报错。

将表对象的成员赋值为 null 就可以删除该成员。

在逻辑运算中，null 值为 false。

****▶** 取数组或字符串长度**

```
import console;

var array = {123;456};
console.log("数组长度",#array);

var str  = "abcd";
console.log("字符串长度",#str);

var n  = null;
console.log("null 值长度为 0",#n);

console.pause();
```

使用 # 操作取数组或字符串的值，也可以取 null 值的长度（ 返回 0 ）。

  
****▶** if 语句**

```
import console;
var enabled = true;

if (enabled) {
  console.log('enabled 的值为 true');
}
console.pause(true);
```

注意在逻辑运算中，非 0、非 null、非 false 为 true，反之为 false。

如果要准确判断一个变量的值是否为 true 或 false ，则应使用恒等操作符，如下：

```
import console;
var enabled = false;

if (enabled === false ) {
  console.log('enabled 的值为 false，不是 0，也不是 null');
}
elseif( enabled ){
  console.log('enabled 的值为真');
}
else{
  console.log('enabled 值为：',enabled);
}
console.pause(true);
```

上面的 elseif 也可以改为 else if。

****▶** 逻辑操作符**

逻辑非 既可以用 not 也可以用！。

逻辑与 既可以用 and  也可以用 && 或者？。

逻辑与 既可以用 or  也可以用 || 或者 :  。

aardio 语句在设计时试图兼容其他语言的一些基本语法，所以很多语法有类似上面的替代写法，例如可以用 begin end 替代 { } 包含语句块。

****▶** 三元运算符**

```
var n = 1;

// ret 值为 true
var ret = n ? true : 0;
```

要特别注意？实际上是逻辑与操作符，: 实际上是逻辑或操作符。如果 a ? b : c 这个表达式里 b 为 false，则该表达式总是返回 c。这与其他类 C 语言的三元操作符不同，请注意区分。

****▶** 定义函数**

```
//定义函数:
add = function(a, b) {
  return a + b,"支持多个返回值";
}

//调用函数
var num,str = add(1, 2);

/*
要特别注意，函数可以返回多个值。
可以用 () 将多个返回值转换为单个调用参数。
*/
var str = tostring( ( add(1, 2) )  );
```

****▶** for 循环语句**

```
import console;

for(i=1;10;1){
    console.log(i);
}

console.pause();
```

****▶** for in 循环语句**

```
import console;

var tab = {
    a = 123;
    b = 456;
}

for(k,v in tab){
    console.log(k,v)
}

console.pause();
```

****▶** while 循环语句**

```
import console;

var i = 0;
while (i < 100) {  
    i++;
         
    console.log(i);
   
    if(i==10){
        break; //中止循环
    }
}
 
console.pause();
```

****▶** while var 语句**

```
import console;

//用法1，while条件中使用一个var语句
while(
    var i =  console.getNumber( "请输入数值,输入0退出:" )
    ) {
    console.log( i )
}

//用法2，while条件中使用var语句、循环前执行语句、条件判断语句
while(
    var i;
    i =  console.getNumber( "请输入数值,输入100退出:" );
    i != 100  ) {
    console.log( i )
}

//用法3，省略var语句，仅使用循环前执行语句、条件判断语句
var i = 0;
while( ;i++; i<10 ) {
    console.log(i)
}

//用法4，省略var语句，循环前执行语句，仅使用条件判断语句
while(i>0){
    i--;
    console.log(i);
}

console.pause(true);
```

****▶** while var 模拟 for 循环**

```
import console;

while( var i = 0; i++ ; i < 5  ) {
    console.log( i )
}

console.pause(true);
```

****▶** break label, continue label, break N, continue N 语句**

break 语句中断并退出当前循环语句。

continue 语句跳过当前循环体剩下的部分，继续执行下一次循环。

break label,continue label 通过为循环指定一个标号以中断指定的循环。

break N,continue N 通过指定循环语句的嵌套层次以中断指定的循环。

```
import console;

var i, j;
for (i = 0; 2; 1 ) { loop1:

   for (j = 0; 2; 1) { loop2:
   
      if (i == 1 && j == 1) {
         continue loop1;
      }
      else {
         console.log("i = " + i + ", j = " + j);
      }
   }
}
console.pause(true);
```

注意循环标号写在循环体内部开始处。

****▶** 类**

```
//定义类
class cls{
   
    //构造函数
    ctor(name,...){
        this.name = name;
        this.args = {...}
    };
   
    //属性
    value = staticNum;
   
    //成员函数
    add = function(v){
        this.value = this.value + v;
        return this.value;
    }
}


//打开类的名字空间
namespace cls{
    staticVar = "类的静态变量值";
    staticNum = 2;
}
 
//调用类创建对象
var obj = cls();

//调用对象函数
var v = obj.add(5);
```

类内部可以用 this 访问当前创建的实例对象。

类总是先调用构造函数 ctor 才会初始化其他成员。

每个类都有自己的名字空间。

类创建的所有实例共享同一名字空间。

类名字空间的成员也就是类的静态成员。

**▶** **self,this,owner**

self 表示当前名字空间。

this 在类内部表示当前创建的实例对象。

每个函数都有自己的 owner 参数（ 无法使用外部函数的 owner 参数 ）。如果用点号作为成员操作符获取并调用对象的成员函数，则点号前面的对象是被调用成员函数的 owner 参数，否则被调用函数的 owner 参数为 null。例如 obj.func () 调用 obj 的成员函数 func，则 obj 是 obj.func 的 owner 参数。

注意一个独立的 aardio 代码文件编译后也相当于一个匿名的函数。独立运行的 aardio 代码文件 owner 参数默认为 null ，使用 import 语句加载的库文件，owner 参数为加载路径、或资源文件数据。

owner 在元方法中表示左操作数。

在迭代器函数中，owner 表示迭代目标对象。

aardio 允许用 call, callex, invoke 等函数调用其他函数并改变 owner 参数的值。