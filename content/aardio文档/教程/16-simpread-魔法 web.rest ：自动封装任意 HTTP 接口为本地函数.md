> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650932886&idx=1&sn=94948ed60fd7618e40ab33a190dc9153&chksm=84aa2d2cb3dda43a8d24e89a352946efef08e7025c5583fec72240393567d1f9b6e11a4c7321&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

aardio 里的 web.rest 设计了一种简单的 HTTP 接口描述规则 —— 可将指定的网址（可选指定模板参数）自动转换为本地函数对象。用法极其简单（ web.rest 本身的实现也非常简单 ）。
======================================================================================================

  
web.rest 是一种调用规则，也是 aardio 里的一个名字空间，web.rest 名字空间中的所有类都是 web.rest 的具体实现，所有 web.rest 类都继承自 web.rest.client，用法基本相同。  

=======================================================================================================================

**▶ 简单示例  
**
=============

```
import console;
import web.rest.jsonLiteClient;

//创建 HTTP( REST ) 客户端。
var http = web.rest.jsonLiteClient();

//声明 HTTP 接口对象
var api = http.api("http://httpbin.org/anything/")

/*
调用 HTTP 接口函数（已经自动转换为了本地函数）。
返回 JSON 自动转换为了 aardio 对象。
*/ 
var result = api.object.method({
    name = "用户名";
    data = "其他数据";
});

//输出服务端返回对象 —— 这个接口返回的是 HTTP 请求信息 
console.dumpJson(result);
console.pause();
```

上面的代码可以直接复制粘贴到 aardio 中运行，该接口返回的是 HTTP 请求信息 —— 用于测试学习非常方便。  

我们主要看下面这句发送请求调用 HTTP 接口的代码：  

```
var result = api.object.method({
    name = "用户名";
    data = "其他数据";
});
```

  
上面的函数调用做了几件事：  

1、将 api.object.method 每一个下级成员名字追加到请求网址后面，多个名字自动用 "/" 分开。也就是自动生成下面这样的请求地址：  

```
"http://httpbin.org/anything" + "/object" + "/method",
```

2、将函数参数按网页表单编码规则转换为字符串提交，也就是自动执行下面的转换：

```
inet.url.stringifyParameters({
      name = "用户名";
      data = "其他数据";
})
```

3、解析服务器返回的 JSON ，并作为函数返回值返回。

实际上这句发送请求的代码会被转换为下面的代码执行：  

```
var result = http.post(
  "http://httpbin.org/anything" + "/object" + "/method",
  inet.url.stringifyParameters({
      name = "用户名";
      data = "其他数据";
  })
);
```

上面的 object , method 我们称为『网址模板参数』。  

====================================

**▶ 网址模板参数**

在声明 API 对象时， HTTP 接口网址中可选使用大括号 { } 包含模板参数名，示例：

```
"http://httpbin.org/anything/{org}/{name}/repos"
```

上面的 {org} , {name} 都是『网址模板参数』。

在调用 HTTP 接口时，HTTP API 对象的所有下级成员名称（模板实参）会逐个替换『网址模板参数』。  

例如下面的代码：

```
import console;
import web.rest.jsonLiteClient;
var http = web.rest.jsonLiteClient();

//声明 HTTP 接口对象
var api = http.api("http://httpbin.org/anything/{org}/{name}/repos")

//调用 HTTP 接口函数
var result = api.aardio.jacen({
    name = "ImTip";
    description = "通用输入法状态提示";
});

console.dumpJson(result);
console.pause();
```

上面调用 api.aardio.jacen () 函数的实际请求地址为：

```
"http://httpbin.org/anything/"
  + "aardio" + "/" + "jacen" + "/" + "/repos"
```

模板实参 "aardio" 会替换模板参数  {org} ，模板实参 "jacen" 会替换模板参数 {name} ，依次从前向后替换（忽略模板名 ）。  

也可以把斜杠写到模板变量里面，例如 {/name} ，这表示：如果调用时指定了模板实参则保留斜杠，否则去掉斜杆。

我们也可以在调用时明确指定模板实参的名字，代码如下：

```
import web.rest.jsonLiteClient;
var http = web.rest.jsonLiteClient();

//声明 HTTP 接口对象
var api = http.api("http://httpbin.org/anything/{org}/{name}/repos")

//URL 模板实参，使用名值对指定了参数的名字
var urlParam = { org = "aardio", name = "jacen" } 

//调用 HTTP 接口函数
var result = api[urlParam]({
    name = "ImTip";
    description = "通用输入法状态提示";
});
```

在网址尾部可以用 {...} 指定不定个数的模板参数，例如：

```
import web.rest.jsonLiteClient;
var http = web.rest.jsonLiteClient();

//声明 HTTP 接口对象
var api = http.api("http://httpbin.org/anything/{...}")
```

这个  {...} 可以省略不写，省略仍然支持不定个数模板参数，多个模板实参会自动用 "/" 分隔。

**▶ HTTP 请求方法**

HTTP 协议常用的请求方法有：GET，POST，PUT，DELETE，PATCH，HEAD。

我们可以在调用 HTTP 接口函数时，可以将小写的 HTTP 方法名作为函数名调用 —— 就是以该 HTTP 方法发送请求。

例如：

```
import console; 
import web.rest.jsonLiteClient;
var http = web.rest.jsonLiteClient(); 

//可在参数 @2 指定默认 HTTP 方法，不指定默认为 "POST"
var api = http.api("http://httpbin.org/anything/","POST") 

//发送 GET 请求
var ret = api.name.get( a = 1,b = 2);

//发送 POST 请求
var ret = api.name.post( a = 1,b = 2);

//发送 PATCH 请求
var ret = api.name.patch( a = 1,b = 2);

//发送 PUT 请求
var ret = api.name.put( a = 1,b = 2);

//发送 DELETE 请求
var ret = api.name.delete( a = 1,b = 2);

console.dumpJson(ret); 
console.pause(true);
```

这些 http 方法不仅仅可以作为函数使用，也可以作为转换对象 —— 用于转换后续的请求方法，例如：  

```
var ret = api.get.method( a = 1,b = 2);
```

注意 head, get, post, put, patch, delete 等作为 HTTP 接口函数名时不会视为『网址模板实参』被添加到请求网址中。

如果将这些默认 HTTP  方法名前面添加一个斜杠，就可以视为『网址模板实参』而非 HTTP 方法。例如：  

```
var result = api.get["/get"]()
```

上面的代码可以简写为：

```
var result = api.getGet()
```

类似的还有 postPost (), putPut () …… 等函数。

**▶ web.rest 类**

web.rest 名字空间的类都继承自 web.rest.client，区别在于请求数据格式或服务器响应数据格式不同。  

最常用的 web.rest 类如下：  

1、web.rest.client

请求为网页表单编码，响应数据直接返回。

3、web.rest.jsonClient  

请求与响应数据都是 JSON 。

3、web.rest.jsonLiteClient

请求为网页表单编码，响应数据为 JSON 。

下面我们看一下 web.rest.jsonLiteClient 的主要源码：

```
import web.json;
import web.rest.client;

namespace web.rest; 

class jsonLiteClient{
  ctor( ... ){
    this = ..web.rest.client( ... ); 
   
    //请求数据 MIME 类型
    this.contentType = "application/x-www-form-urlencoded"; 
    
    //自动转换请求参数
    this.stringifyRequestParameters  = function(param,codepage){
      //省略其他代码
      return ..inet.url.stringifyParameters(p,codepage);
    } 
    
    //期望服务端返回的数据 MIME 类型
    this.acceptType = "application/json,text/json,*/*";
     
    //自动转换服务器响应数据
    this.parseResponseResult = function(s){
      //省略其他代码
      return  ..web.json.parse(s,true);
    }
  }; 
}
```

每个不同的 web.rest 类 —— 主要是修改了转换请求参数格式的 this. stringifyRequestParameters 函数，以及修改服务器响应数据格式的 this. parseResponseResult 。

**▶ 获取错误信息**

在调用 HTTP 接口时，成功返回解析后的响应数据，失败则返回 3 个值：null, 错误信息，错误代码（可选） 。

这里要特别注意一下：aardio 中的很多函数都是成功返回非 null 值，失败返回 null 与 错误信息 等多个值，一般不会抛出异常。

例如：  

```
import console; 
import web.rest.client;
var http = web.rest.client(); 

var api = http.api("http://httpbin.org/status/500"); 

//发送 GET 请求
var ret,err = api.get( a = 1,b = 2);

if(!ret){

  //出错了输出错误信息
  console.log("出错了",err)

  //获取原始服务器响应数据
  http.lastResponse()
}
else {
  console.dumpJson(ret); 
}

console.pause(true);
```

可以运行 aardio **「 工具 > 网络 > HTTP 状态码检测」**查看返回状态码的相关信息。

http.lastResponse () 可以获取服务器原始响应数据 —— 如果事先导入了 console 库，则在控制台直接显示。

当然上面的代码一般在调试故障时才需要，一般没必要把错误处理写得这么细，上面的代码可以简化如下：

```
import console;
import web.rest.jsonLiteClient;
var restClient = web.rest.jsonLiteClient();   

var duck = restClient.post("http://httpbin.org/post",{
    用户名 = "用户名";
    密码 = "密码";
} )

//这句相当于 if( duck and duck["翅膀"] ) 
if( duck[["翅膀"]] ){ 
    io.print("不管服务器给我的是什么鸭子，总之有翅膀的都是好鸭子")
}
else {
    //出错了
    console.log("怎么回事没翅膀还能叫鸭子吗？");
}

console.pause();
```

duck [["翅膀"]] 使用了直接下标 —— duck 为 null 时 duck [["翅膀"]] 不会报错，而是返回 null 。

**▶ 自定义 HTTP 请求头**

可使用 http.addHeaders 自定义 HTTP 请求头，示例：

```
import console; 
import web.rest.jsonLiteClient;
var http = web.rest.jsonLiteClient(); 

//如果所有请求都要添加的相同HTTP头，在这里指定
http.addHeaders = {
    ["Test"] = "test"
}

var api = http.api("http://httpbin.org/anything/") 

//发送 GET 请求
var ret = api.name.get( a = 1,b = 2); 

console.dumpJson(ret); 
console.pause(true);
```

  
如果每次请求都要动态修改 HTTP 请求头，可以在 http.  beforeRequestHeaders 函数内返回需要添加的请求头，例如：

```
import crypt; 
import web.rest.jsonLiteClient;
import console; 

var http = web.rest.jsonLiteClient(); 

//每次请求都要动态修改 HTTP 请求头
http.beforeRequestHeaders = function(params){

    var apiKey = "";
    var secretKey = "";
    var authorization = {
        ["apiKey"] = apiKey;
        ["time"] = tonumber(time());
    }

    authorization["sign"] = crypt.md5(apiKey ++ secretKey ++ authorization.time)

    //通过返回值设置本次请求的 HTTP 头, Content-Type 不需要指定（会自动指定）
    return {
        ["Authorization"] = crypt.encodeBin(web.json.stringify(authorization))
    };
}

//声明 API 对象
var api = http.api("http://httpbin.org/anything/") 

//发送 GET 请求
var ret = api.name.get( a = 1,b = 2); 

console.dumpJson(ret); 
console.pause(true);
```

  
▶ multipart/form-data 编码上传文件

示例：

```
import web.rest.client;
var http = web.rest.client();
var api = http.api("https://fontello.com");

//使用文件表单上传文件，可以指定多个字段
var result = api.sendMultipartForm(
    file = "@/test.json"; //上传文件路径前面必须加一个字符 @ ，其他字段不用加
});
```

上面代码也可以写为 api.post.sendMultipartForm () ;

如果需要处理上传进度，可以这样写：  

```
var result = api.sendMultipartForm( {
        file = "@/test.json";
    },function(sendData,sendSize,contentLength,remainSize){
        /*
        sendData 为本次上传数据；
        sendSize 为本次上传字节数；
        contentLength 为要上传的总字节数；
        remainSize 为剩余字节数；
        */
    }
);
```

  
**▶ 上传文件**

直接上传文件示例：

```
import web.rest.jsonLiteClient;
var http = web.rest.jsonLiteClient();
var api = http.api("http://httpbin.org/anything");

//上传文件
var result = api.sendFile("/上传文件路径.txt");
```

  
也可以如下指定上传进度回调函数。

```
var result = api.sendFile( "/上传文件路径.txt"
    ,function(sendData,sendSize,contentLength,remainSize){
        /*
        sendData 为本次上传数据；
        sendSize 为本次上传字节数；
        contentLength 为要上传的总字节数；
        remainSize 为剩余字节数；
        */
    }
);
```

  
**▶ 下载文件**  

下载文件示例：

```
import console;
import web.rest.jsonLiteClient;
var http = web.rest.client();

var aardio = http.api("https://www.aardio.com");

/*
下载文件:
如果创建文件失败 receiveFile 函数会返回 null 及错误信息，否则返回对象自身。
*/
var ok = aardio.receiveFile("/.test.html").get();
```

  
可选如下指定下载进度回调函数：  

```
aardio.receiveFile("/.test.html",function(recvData,recvSize,contentLength){
    /*
    recvData 为当前下载数据。
    recvSize 为当前下载数据字节数。
    contentLength 为需要下载的总字节数。
    */
    console.log(,recvSize,contentLength)
}).get();
```

  
**▶ 自动模式匹配**

在声明 HTTP 接口对象时，还可以指定模式表达式 —— 用于自动匹配服务器响应数据，并返回匹配结果。

示例：

```
import console; 
console.showLoading("获取外网IP");

import web.rest.client;
var http = web.rest.client();

//声明 API，参数 @3 指定的模式表达式用于匹配返回数据
var api = http.api("http://myip.ipip.net",,"(\d+\.\d+\.\d+\.\d+)");

//调用 HTTP 接口 
var ip = api.get();

//显示查询结果
console.log( ip  );

console.pause(true);
```

  
**▶ 普通 HTTP 客户端**

web.rest 基于 inet.http （ [请参考：玩转 inet.http](http://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650932255&idx=1&sn=d8d6055dac486d0d2c827f5ce543fb3d&chksm=84aa2fa5b3dda6b3ce67731de3a19576aabb385b675c87259a6591a19cdcd4410132e6fde7fa&scene=21#wechat_redirect) ），也可以作为增强版的 HTTP 客户端功能，示例：

```
import console;
import web.rest.jsonClient;

//创建 HTTP 客户端
var http = web.rest.jsonClient();

//发送 GET 请求
var ret = http.get("http://httpbin.org/anything",{
    name = "用户名";
    data = "其他数据";
})

//发送 POST 请求
var ret = http.post("http://httpbin.org/anything",{
    name = "用户名";
    data = "其他数据";
})

console.dumpJson(ret);
console.pause();
```

与 inet.http 不同的是，如果服务端返回数据的编码声明不是 UTF-8，web.rest 会自动转换为 UTF-8 。

**▶ 直接提交原始数据**

使用 web.rest 调用 HTTP 接口时，如果提交数据是一个字符串，则不作任何处理 —— 直接提交。

示例：

```
import console;
import web.rest.jsonClient;
var http = web.rest.jsonClient(); 

//示例 JSON
var json = /*
{
    "data":"其他数据",
    "name":"用户名"
}
*/

//如果提交数据是字符串，则不作任何转换直接发送
var ret = http.post("http://httpbin.org/anything",json)

console.dumpJson(ret);
console.pause();
```

  
**▶ 更多范例**

aardio 自带 web.rest 范例：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPxreVQqmTRGFOiciceQyPwCR979G9uXia3ianhHP4ZKbdBvLPib3gz7o2icBbZFfGgM7TvED8icmd9YJCSA/640?wx_fmt=png)