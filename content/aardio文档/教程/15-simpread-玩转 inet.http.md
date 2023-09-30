> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650932255&idx=1&sn=d8d6055dac486d0d2c827f5ce543fb3d&chksm=84aa2fa5b3dda6b3ce67731de3a19576aabb385b675c87259a6591a19cdcd4410132e6fde7fa&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

**一、快速入门**

标准库中的 inet.http 用于创建 HTTP  客户端，用法其实非常简单，先来个最简单的例子：  

```
//导入 inet.http
import inet.http;

//创建 HTTP 客户端对象
var http = inet.http(); 

//发送 GET 请求
var data = http.get("http://eu.httpbin.org/get?user);

//发送 POST 请求
var data = http.post("http://eu.httpbin.org/post",{
  username = "user"; password = "pwd";
});
```

更多例子请参考「**aardio 自带范例 / 网络应用 /inet/http**」。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBNjIE971zFZuDfM5egJ9U7oGgDQPpBvLLstZwo49yvRD2WrBCeELEkPO6Crlic7zgyxZrpiay0vSSrw/640?wx_fmt=gif)

**二、分步请求**

  
inet.http 还提供「分步请求」的写法，可以更灵活地控制请求，例如读取 HTTP 响应头：  

```
import inet.http;

//首先创建 HTTP 客户端对象
var http = inet.http();

//创建 HTTP 请求，参数 @2指定请求方法，更多参数请查看函数说明
http.beginRequest("http://www.aardio.com","GET");

//发送请求
http.send();

//读取 HTTP 响应头（要在发送请求头后才能读取 ）。
var headers = http.readHeader();
```

注意要在发送请求以后，请求结束以前读取 HTTP 响应头。这就像电话接通以后、挂断以前你才能听到对方的声音 —— 不难理解吧？！  
这种方法看起来代码多了一点点，但是可以更灵活地控制细节。如果想把这些代码简化，只要封装一个库函数就可以了。aardio 做这些事特别简单，来个动画演示一下：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBNjIE971zFZuDfM5egJ9U7odXSibuVrcrowk56GAWriaAXlgqY1blibvm4qJq9icUIOfUtTjwLz0voyjQ/640?wx_fmt=gif)  
用起来就简单了：  

```
import httpUtil;
var ret = httpUtil.getHeader("http://www.aardio.com")
```

另外 inet.http 也提供了直接读取 HTTP 响应头的 http.head () 函数：  

```
import inet.http;

var http = inet.http();
http.head("http://www.aardio.com");
var headers = http.readHeader();
```

只要调用 http.head () 发送 HEAD 请求，那么 inet.http 就会把全部 HTTP 响应头缓存起来，在请求结束后仍然可以使用 http.readHeader () 。

**三、HTTP 方法**

GET,POST,HEAD,PUT,DELETE,PATCH …… 这些都是 HTTP 方法 (HTTP method)，如果将 HTTP 服务器比作银行，那么 GET 就相当于去银行取款，POST 就相当于去银行存款，HEAD 就相当于去银行咨询一下 —— 但什么也不干。  
我们可以用 TCP 客户端模拟一下 HTTP 协议的 HEAD 请求，代码如下：  

```
import wsock.tcp.client; 
var tcp = wsock.tcp.client() 
tcp.connect("www.aardio.com",80) 

sendData =/***********
HEAD /  HTTP/1.1
Host: www.aardio.com 
Connection: close
User-Agent: Mozilla/5.0  
Accept: */*;   
***********/

tcp.write( sendData,'\r\n\r\n' );
headers = tcp.readTo('\r\n\r\n');//HTTP头以两个回车换行结束
tcp.close() ;

import console;
console.log( headers  )
console.pause();
```

**四、在请求结束后读取 HTTP 响应头**

那么如果说不想写扩展库，也不想发送 HEAD 请求，也不想分步请求 …… 就是想要在 http.get () 或 http.post () 结束请求以后还能继续读取 HTTP 响应头行不行？！其实也是可以的，代码如下：  

```
import inet.http;

//创建 HTTP 对象
var http = inet.http();

//发送请求后会自动读取所有 HTTP 响应头
http.afterSend = lambda() http.readHeader(); 

//发送 POST 请求
var data = http.post("http://eu.httpbin.org/post",{
  username = "user"; password = "pwd";
});

/*
只要请求结束前读取过全部 HTTP 响应头，
aardio 就会缓存起来，请求结束后可以继续读取 HTTP 响应头
*/
var contentType = http.readHeader("Content-Type:")
```

只要请求结束前读取过全部 HTTP 响应头，

aardio 就会缓存起来，请求结束后可以继续读取 HTTP 响应头。

**五、扩展库而不是修改库**  

那么如果不想多写一句 http.afterSend …… 该怎么办？！要不要打开 inet.http 修改一下源代码，让所有 HTTP 请求都读取所有 HTTP 请求头并缓存起来呢？！  
其实大多数 HTTP 请求不需要也不应该执行这个多余的步骤，这时候我们就要思考一下了：  
1、某一时刻的单点需求，并不等于任何人任何时候都需要。  

2、把所有需求都盲目地塞进一个库，这会让一个库渐渐变得笨拙、复杂且难以扩展。

“扩展而不是修改库” —— 通常是更好的选择。如果你不想多写这句 http.afterSend … ，只要简单地写一个新库扩展一下 inet.http 就可以，代码非常简单，例如：  

```
import inet.http;

class myHttp{
  ctor( ... ){
    this = ..inet.http( ... );
    this.afterSend = lambda() this.readHeader(); 
  }; 
}
```

web.rest.client 就是一个基于 inet.http 而封装的上层库。而基于 web.rest.client 又扩展了更多的库，如下：  

```
web.rest.jsonClient
web.rest.jsonLiteClient
web.rest.xmlClient 
web.rest.htmlClient
```

基于上面这些库再次扩展出来的库就更多了……   
aardio 基于 inet.http 扩展的库非常多，足见 inet.http 有良好的扩展能力。可以设想一下，如果 inet.http 不是把更多的机会留给其他库去发挥，而是什么事都抢着干，提前干，不管别人需不需要的功能都强行干了 —— 这多么可怕？！  
inet.http 有个自动解压 gzip 压缩数据的功能，同样需要需要多写一句代码，先看例子：  

```
import zlib;
import inet.http;

var http = inet.http();
var str = http.get("http://eu.httpbin.org/gzip","Accept-Encoding:gzip");
```

只有提前多写一句 import zlib ，inet.http 才会支持 gzip 自动解压。其实我们写 HTTP 请求不像在浏览器里看网页，大多时候我们不需要 gzip 压缩传输。仅仅因为个例需要什么东西，就强制所有人在所有时候都带上它 —— 这不是好习惯。  
所以很多时候，我们不要害怕多写了一两句代码。**代码简洁是好习惯，但害怕多写了一两句代码是坏习惯。不写代码我们还学编程干什么呢？！** 

****六、POST 用法****

现在我们回到本文开始的代码：  

```
import inet.http;
var http = inet.http(); 
 
//发送 POST 请求
var data = http.post("http://eu.httpbin.org/post",{
    username = "user"; password = "pwd";
});
```

上面 http.post 的第 2 个参数如果是一个表对象，会自动转换为如下的调用：  

```
http.post("http://eu.httpbin.org/post"
   ,"user);
```

如果要向服务器提交 JSON ，代码需要修改如下：  

```
import web.json;
import inet.http;
 
//发送 POST 请求 
var http = inet.http(); 
var data = http.post("http://eu.httpbin.org/post",
  web.json.stringify({ username = "user"; password = "pwd" })
);
```

上面我们使用 web.json.stringify () 函数将表对象转换为了 JSON 字符串，http.post 如果检测到 POST 数据是 JSON ，并且 HTTP 请求头中不包含 Content-Type 的定义，就会自动添加以下请求头：  

```
Content-Type: application/json; charset=utf-8
```

其实 inet.http 已经默默的做了很多事，以简化我们的调用代码，但仍然要注意这种简化是有底线和边界的。

****七、web.rest**** 

如果我们希望更好地支持 JSON，使用基于 inet.http 的 web.rest.jsonClient 会更简单：  

```
import web.rest.jsonClient;
var http = web.rest.jsonClient();

var data = http.post("http://eu.httpbin.org/post"
    ,{ username = "user"; password = "pwd" });
```

web.rest.jsonClient 会将参数表自动转换为 JSON，并将服务器返回的 JSON 自动解析为表对象。  
如果 HTTP 请求不需要发送 JSON，而服务器响应数据是 JSON，这时候只要把上面的  web.rest.jsonClient 替换为 web.rest.jsonLiteClient 就可以了。  

  
web.rest 非常重要，请参考「aardio 范例 / Web 应用 / REST」  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBNjIE971zFZuDfM5egJ9U7oXnlQMCc6d2iaQMWicq6NB5h8kAWEQj4j0rQBgyB0XIkMSjhhW2Nu2UQA/640?wx_fmt=gif)  
强烈推荐大家仔细看看 aardio 开始页的教程：《使用 web.rest 实现 REST-RPC》 。不过还是先看完这篇文章再去看会更好。 

****八、HTTP 请求返回值****  

实际上 inet.http 对象发送请求的函数基本都有 3 个返回值：响应数据，错误信息，错误代码。我们前面的示例都只使用了第 1 个返回值。接收所有返回值的示例：  

```
import console;  
import inet.http;

//创建 HTTP 对象
var http = inet.http();

//3 个返回值：响应数据,错误信息,错误代码
var data,err,errCode = http.post( "http://eu.httpbin.org/post" 
  ,"user );

if( data ){ 
  console.log(data);
}
else {
  if( http.statusCode ){
    //服务端返回错误信息
    console.log( http.lastResponse(), "HTTP错误代码:" + http.statusCode )
  }
  else{
    //本地内部错误
    console.log( err,errCode );
  }
}

http.close();
console.pause();
```

可以使用「 **aardio 工具 / 网络 / HTTP 状态码检测**」查询 HTTP 错误代码（  上面的 errCode ）与 HTTP 状态码（ http.statusCode ）的详细信息：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBNjIE971zFZuDfM5egJ9U7oee5vumWylUoNf6AaBh2zyQucocnzVyKic25WXLrXkZsInywA9jLmZoA/640?wx_fmt=gif)

****九、指定 HTTP 请求头****

前面我们讲了如何获取 HTTP 响应头，下面我们讲一下如何自定义 HTTP 请求头。其实 inet.http 已经默认设置好了必要的 HTTP 请求头，一般并不需要自己指定 HTTP 请求头参数。**我发现很多人在写这类 HTTP 请求代码时，都喜欢复制粘贴一大堆根本就没用的 HTTP 请求头 —— 这又多写一大堆代码不嫌累。有时候明明没问题还因为这些多余的请求头搞出问题。** 例如  inet.http，inet.whttp  都提供了专用的 referer 属性（ 自动设置值，一般不应修改 ），发送请求的 get,post 等函数也都可以指定 referer 参数 ，很明显通过 HTTP 头去指定 referer 既不必要也会错乱。

   
inet.http 其实已经帮我们做好了很多事，并不需要每一个 HTTP 头都去写一遍。所以大家看前面我写的代码都没有自定义任何 HTTP 请求头，这没有任何问题。  

inet.http 对象的所有 HTTP 请求头属性、参数都会经过 web.joinHeaders () 函数处理并转化。这些 HTTP 请求头都允许传入字符串、表（键值对或数组）。先看个例子：  

```
import inet.http;
var http = inet.http(); 
 
//设置所有请求默认添加的 HTTP 头，请求结束不清空 
http.addHeaders = "Name1:value1\r\nName2:value2";
```

也可以使用表（键值对）指定 HTTP 头，例如：

```
http.addHeaders = {
  "Name1":"value1", "Name2":"value2"
}
```

也可以在 beforeSend 事件回调内写 HTTP 请求头。  

```
http.beforeSend = function(){  
  http.writeHeader("Name2:value2"); //写 HTTP 请求头 
}
```

也可以通过 http.get () , http.post () 等函数的参数指定 HTTP 请求头：  

```
var data = http.post("http://www.httpbin.org/post", ,{ 
  "Accept-Language":"zh-CN,zh";  
});
```

****十、多线程与界面  
****  
如果在界面线程中调用 inet.http ，要注意 inet.http 执行请求属于耗时操作 —— 会阻塞界面线程。不过  aardio 创建多线程非常方便，将 HTTP 请求放到工作线程里就不会卡界面了，示例如下：  

```
import win.ui;
/*DSG{{*/
var winform = win.form(text="获取 HTML";right=759;bottom=469)
winform.add(
btnGetUrl={cls="button";text="获取 HTML";left=481;top=376;right=713;bottom=432;color=14120960;db=1;dr=1;font=LOGFONT(h=-14);note="创建工作线程请求目标网址";z=2};
editHtml={cls="edit";left=29;top=24;right=735;bottom=361;db=1;dl=1;dr=1;dt=1;edge=1;hscroll=1;multiline=1;vscroll=1;z=1};
editUrl={cls="edit";text="http://www.aardio.com";left=33;top=385;right=453;bottom=413;db=1;dl=1;dr=1;edge=1;multiline=1;z=3}
)
/*}}*/

winform.btnGetUrl.oncommand = function(id,event){
  winform.btnGetUrl.disabled = true;
  
  //创建工作线程
  thread.invoke( 
    function(winform){
      import inet.http;
      var http = inet.http();
      var data  = http.get(winform.editUrl.text);
      
      //显示抓取结果
      winform.editHtml.text = data;
      
      //启用按钮
      winform.btnGetUrl.disabled = false;
    },winform /*将窗口对象作为参数传入线程函数*/
  )
}

winform.show();
win.loopMessage();
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBNjIE971zFZuDfM5egJ9U7oqhSQSPZk38gZZ5GMLCGVhbicftphJiaGUH4icRKmTtDIF7KAhozLOrgpg/640?wx_fmt=png)

  
在界面线程中简单地请求一个网址也可以使用 inet.http.get (url) ，这个函数也会创建线程执行 HTTP 请求，不卡界面且代码更少一些。

****十一、断点续传  
****  
如果需要下载文件并支持断点续传，可以使用基于 inet.http 实现的 inet.httpFile，来个断点续传下载的例子：  

```
import console;
import console.progress;
import inet.httpFile;

var remoteFile = inet.httpFile(
  "http://wubi.aardio.com/update/wubiLex.7z" ,"/.download/"
)

var progress = console.progress();
remoteFile.onReceive = function(data,downSize,contentLength){
  progress.addProgress((downSize/contentLength)*100
    ,"正在下载 文件大小：" + math.size64(contentLength).format() )   
}

//下载文件
if(remoteFile.download()  ){
  console.log("下载成功")
}
console.pause();
```

如果还想给下载点加个窗口界面什么的，我们不必改动  inet.httpFile ，使用基于 inet.httpFile 的 inet.downBox 就可以方便地创建下载对话框：  

```
import inet.downBox;

var downBox = inet.downBox(winform,"下载测试网页...",true )
if( downBox.download( "http://download.aardio.com/v10.files/exlibs/tcc.tar.lzma" 
  , "~/download/lib/tcc.tar.lzma" ) ){
  win.msgbox("download complete");
}
```

****十二、下载并解压远程压缩包****

如果我们不但要下载对话框，还想下载压缩包，顺带解压缩 …… 或者顺带安装程序 —— 同样不必修改  inet.downBox ，有很多基于  inet.downBox 的库可以实现这些功能：

```
zlib.httpFile //下载 + zip 解压缩
sevenZip.lzma.httpFile //下载 + lzma 解压缩
sevenZip.decoder2.httpFile //下载 + 7z 解压缩
inet.installer //下载  + 自动安装程序
```

标准库还有一个 inet.whttp，用法与接口与 inet.http 基本相同，一般可相互替代。inet.http 基于 WinINet，而 inet.whttp 基于 WinHTTP。一般普通桌面客户端软件 (非 NT 服务) 应当使用 inet.http。

****十三、HTML 解析****

对于服务器返回的 HTML ，我们可以使用 web.mshtml 或者 string.html 解析，调用 string.html 示例：  

```
import console;
import string.html;

var html =  /* 
<!doctype html>
<html>
<head></head>
<body>
<table id="container">
<tr><td rowspan="1" class="tab_time tab_time102540630">06:30</td></tr>
</table>
</body>
*/

var htmlDoc = string.html( html )
 
//获取 body 节点
var body = htmlDoc.queryEles( tagName = "body"); 

//遍历 body 节点的所有子节点
for(index,tagName,childCount,xNode in body[1].eachChild() ){
  console.log( index,tagName,childCount,xNode.outerXml() ) 
}

console.pause()
```

string.html 的更多用法请参考「范例 / Web 应用 / HTML 」  
当然我们也可以使用 web.rest.htmlClient，一个简单的例子：  

```
import console; 
import web.rest.htmlClient;
var http = web.rest.htmlClient();

var google = http.api("https://translate.*****.cn/m?hl=zh-CN");

var htmlDoc = google.get(q="hello",sl="en",tl="zh-CN");
if(htmlDoc){
  var resultContainer = htmlDoc.queryEle({"class":"result-container"})
  if(resultContainer){
    console.log(resultContainer.innerText());
  }
}  

console.pause(true);
```