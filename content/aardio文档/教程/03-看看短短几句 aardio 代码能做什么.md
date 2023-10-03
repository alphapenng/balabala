> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650931757&idx=1&sn=f06bcf26da67260f0e2a85785669d40d&chksm=84aa2997b3dda081cf390fdb7a6a2b62d4635b579344708d80bfe8c3a5180360703ef873c2ef&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

有的人说代码少你不就是库多么，你不就是库多么 …… 抱歉，aardio 开发环境加上所有的标准库体积只有几 MB，你可以随便用什么编程语言可以先去找 1TB 的库再来试试。  

  
aardio 几句代码就可以创建一个独立程序，可以发布为体积极小的独立 EXE 文件 (不需要依赖外部运行时)， 因为 aardio 对操作系统的依赖极小 ( aardio 的功能主要由标准库独立实现 )，所以 aardio 生成的软件支持 WinXP，Win7，Win8，Vista，Win10，Win11 …… 你不需要担心会像 Python 那样不支持 XP，很快又不支持 Win7，将来还可能不支持 Win10 ……   
在 aardio 中像下面这样的范例不计其数，几乎每个范例都是一个独立小程序，代码量都非常小，以下只是 aardio 范例中随意复制的几个小代码片段。  

直接调用系统 API 函数：  

```
import console; 

//不需要声明,直接调用原生 API 函数，语法简洁可读性好。
var result = ::User32.PtInRect( ::RECT(2,3,300,500) , 12, 66 );

console.log( result );
console.pause(true);
```

将任何网络 API 甚至是任意普通网址声明为 aardio 对象：‍

```
import web.rest.jsonLiteClient;
var http = web.rest.jsonLiteClient();

//导入远程 API
var countApi = http.api("https://api.countapi.xyz/hit{/domain}{/key}")
 
//服务器 API 已经变成了 aardio 函数对象
var data = countApi["key"].get(); 
```

编译 C 语言代码生成 DLL 执行文件，再调用 DLL  中的 C 函数：  

```
import tcc;  
//编译 DLL
tcc.build( "/start.dll" ).code = /***
#include <windows.h> 
__declspec(dllexport) int Add( int a,int b ) 
{     
  return a + b;
} 
***/

//加载 DLL
var dll = raw.loadDll( "/start.dll",,"cdecl" );
//调用 C函数
var result = dll.Add(12,3);
```

屏幕找字：  

```
import mouse;
import string.ocrLite;
import string.ocrLite.defaultModels;

var ocr = string.ocrLite();
var ocrResult = ocr.detectScreen();
var x,y = ocrResult.findPoint("要查找的按钮文本",0.1);
mouse.moveTo(x,y,true);
```

在 aardio 中调用 Python，简单得就像在 Python 中使用 Python：  

```
import console;
import py3; 

//导入 Python 模块。
var itertools = py3.import("itertools")

//调用 Python 函数，支持纯 aardio 类型参数
var permutations = itertools.permutations({"a","b","c"});

//调用 Python 内置函数 list
var pyList = py3.list(permutations);

//遍历 Python 对象成员
for( item in pyList.each() ){
  console.log(item); //像 aardio 对象一样使用 Python 对象
}

console.pause();
```

播放 GIF 动画：  

```
import win.ui;
/*DSG{{*/
var winform = win.form(text="GIF 动画";bgcolor=0xEDDDD8)
winform.add(
plus={cls="plus";left=0;top=0;right=760;bottom=470;repeat="scale";z=1}
)
/*}}*/

import inet.http;
winform.plus.background = "http://download.aardio.com/v10.files/demo/plus-demo.gif";

winform.show(); 
win.loopMessage();
```

调用微软 WebView2 控件截图：  

```
import win.ui;
/*DSG{{*/
var winform = win.form(text="WebView2 网页截图";right=1108;bottom=759)
/*}}*/

import web.view;
var wb = web.view(winform,,0/*自动调试端口*/);
winform.show();

wb.go("http://www.baidu.com");
wb.wait("baidu");

import web.socket.chrome;
var ws = wb.openRemoteDebugging();
ws.Runtime.enable();//启用 Runtime.executionContextCreated

//截图
import crypt;
import process.imageView;
ws.Page.captureScreenshot().end = function(result,err){
   if(result[["data"]]){ 
       string.save("/screenshot.png",crypt.decodeBin(result[["data"]]) )
       process.imageView("/screenshot.png");
   } 
} 

win.loopMessage();
```

获取系统 TPM 版本信息：  

```
import console; 

import sys.tpmInfo;
var tpmInfo = sys.tpmInfo.get();
 
if(tpmInfo){
  console.log("支持 TPM");
  console.log("TPM 是否启用：",tpmInfo.enabled);
  console.log("TPM 是否激活：",tpmInfo.activated);
  console.log("TPM 支持版本：",tpmInfo.version)
}
else {
  console.log("不支持 TPM");
}
 
console.pause();
```

查看系统安装序列号：  

```
import com.wmi;
import win.reg;

var productKey = com.wmi.get("softwarelicensingservice","OA3xOriginalProductKey");
if(!productKey) {
  productKey = win.reg.queryWow64( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform","BackupProductKeyDefault" )   
}

import console; 
console.log("安装序列号" ,productKey);
console.pause(true);
```

调用 .Net 创建 WebService:  

```
import console;
import dotNet;

//创建应用程序域（无参数创建唯一实例,不必手动释放）
var appDomain = dotNet.appDomain();

//动态创建Web服务
var webService = appDomain.createWebService("http://fy.webxml.com.cn/webservices/EnglishChinese.asmx")  
 
//调用WebService接口创建类
var englishChinese = webService.createInstance("EnglishChinese")  

//调用WebService提供的函数
var ret = englishChinese.TranslatorString("hello" ); 

console.dump(ret);
console.pause();
```

其实不用调用 .Net ，纯 aardio 代码调用 WebService 更简单， 以前研究过 MSSOAP , 要依赖一堆 DLL 文件，不符合 aardio 的风格，所以我自己研究了一下 SOAP 协议写了个 web.soapClient , 几句代码搞定，不依赖任何外部组件:

```
import console;

//导入MSSOAP支持库
import web.soapClient;

//创建SOAP客户端
seviceClient = web.soapClient("http://fy.webxml.com.cn/webservices/EnglishChinese.asmx") 
 
//调用远程Web服务提供的函数 
var transArray,err =  seviceClient.TranslatorString("hello");

//显示返回值
console.dump( string.join( transArray,'\r\n' ) ) ;

//按任意键继续
console.pause();
```

调用 PowerShell :  

```
import console;
import process.popen;

console.showLoading(" 请稍候，正在调用 PowerShell");
var prcs  = process.popen.ps(`-Command "& {Get-Command -Name *Process}"`);
var result = prcs.read(-1);

console.log(result);
console.pause();
```

也可以调用 .Net 然后调用 PowerShell :  

```
import console;
import dotNet.ps;

console.showLoading(" 正在执行PowerShell命令");
console.log(dotNet.ps.command("Get-Command",{}));

console.pause();
```

在 aardio 中嵌入并调用批处理：  

```
import console
import process.batch;

//批处理 for 遍历并拆分字符串
var bat = process.batch(`
@echo off 
for %%i in (abc,def,xyz) do echo %%i
`)
console.log(bat.read(-1))
 
console.pause()
```

调用命令行，并自动触发 Ctrl + C  

```
import console
import process.popen

var prcs = process.popen("ping 127.0.0.1 -n 10 ")
for( all,out,err in prcs.each() ){
    console.log( out,err ); 
    prcs.ctrlEvent(0);
}

console.pause();
```

调用 Rust 语言解析 TOML   

```
import console; 
import string.toml;

var str = string.toml.stringify({abc=123,d={1,2,3}});
console.log( str );

import process.code;
process.code("~\lib\string\toml\.res");
console.pause(true);
```

在 aardio 里嵌入 PHP，以下短短几句代码，包含了 HTTP 服务器，PHP 服务端，嵌入的浏览器组件:  

```
import win.ui;
/*DSG{{*/
var winform = win.form(text="Hello World / PHP_CGI 服务器")
/*}}*/

var code = /*
<html>
<head> 
<meta charset="utf-8">
<title>PHP 测试</title>
</head>
<body>
<?php echo '<p>Hello World / PHP_CGI 服务器</p>'; ?>
</body>
</html>
*/
string.save("/test.php",code);

import php.simpleHttpServer;
var url = php.simpleHttpServer.startUrl("/test.php");

import web.form;
var wb = web.form(winform);
wb.go(url);

winform.show();
win.loopMessage();
```

执行 Ruby 语言代码：  

```
import win.ui;
/*DSG{{*/
var winform = win.form(text="执行Ruby代码")
winform.add(
edit={cls="edit";left=26;top=16;right=737;bottom=435;multiline=1;z=1}
)
/*}}*/

import process.ruby;
var out = process.ruby.exec("puts '测试UTF-8'")
winform.edit.print(out);

var out = process.ruby.eval(`[1, 2, { name: "tanaka", age: 19 }]`)
winform.edit.print(out);

winform.show();
win.loopMessage();
```