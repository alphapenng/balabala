> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650932328&idx=1&sn=42bb8dad93bb2aa0af7c65cf91e649f2&chksm=84aa2fd2b3dda6c42c16d40aaa195c5a1ceeb3fd8cb83916d05f32272cfb1fa74cfe05441624&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

很多人可能不知道，Win10/Win11 自带一个强大的 ES6 组件 Chakra.dll （至于过气的 Win7 已经很难找到几个用户了，这里先忽略 ）。Chakra.dll 已经导出了非常方便的动态接口，用起来简洁、省事、方便，不需要带上 DLL 组件，不会增加软件体积。  
  
有趣的是，这个接口知道的人极少，中文网页上没有任何讨论。aardio 最新版的标准库 web.script 已经支持 Chakra。只要简单的指定脚本语言为 "ES6" 就可以调用 Chakra 了，其他的什么也不用做，然后就可以享用 Chakra 的强悍性能，舒服的 ES6、箭头函数、let、const 、类 …… JavaScript 直接调用 aardio ，aardio 直接调用 JavaScript，简单粗暴不麻烦。

  
上代码，看例子：  

```
import web.script;
var chakra = web.script("ES6"); 

//导出 aardio 函数到 JavaScript
chakra.external = {
  log = function(...){ } 
}
 
chakra.script = /**

external.log("JavaScript 调用 aardio 函数");

var test = function(arg){ 
  let result = 0;
  let numbers = [1,2,3];
  
  if(Array.isArray(numbers)){
    numbers.forEach( (value) =>{
      result = result + value; 
    });  
  }  
  
  return arg + result;
}
**/

//调用 JavaScript 函数
var ret = chakra.script.test(1000) ;
```

web.script 基于 COM 对象 ScriptControl 创建脚本解释器，ScriptControl 默认其实并不支持 "ES6" 这个语言名称，这是我自己随手编的一个名字，那么为什么可以调用 Chakra 呢？下面讲原理。  
要想 ScriptControl  支持一个新语言，那么注册表里必须有这个新的 ProgID。但是 Chakra 这个 ProgID 并不存在，一个方法是改注册表，aardio 代码如下：

```
sys.reg.setValue(,"{1b7cd997-e5ff-4932-a7a6-2a9e636da385}","SOFTWARE\Classes\Chakra\CLSID");
```

sys.reg.setValue 默认写的是 HKCU ，所以这句代码不需要请求管理权限，可以静默注册。

但我不想用这个改注册表的方法，自己要怎么玩都可以，尽量别影响别人。那么我们分析一下，为什么非要在注册表里加这一句呢？很明显，ScriptControl  需要在注册表里使用这个 ProgId 查询 CLSID，而干这事需要 调用 WinAPI 函数 CLSIDFromProgID。所以我们只要简单地拦截这个 API 调用 —— 并直接返回 Chakra 的 CLSID 就可以了，主要代码如下：  

```
var apiHook = ..raw.apiHook(
  "Ole32.dll", "CLSIDFromProgID", "int(ustring progId,ptr pClsId)", 
  function( progId,pClsId ){ 
    if(progId == language ) { 
      raw.copy(pClsId,langClsId,#langClsId);
      return 0 ;
    }
    
    return owner.callApi(progid,lpclsid); ;
  }
);

//安装 API 钩子
apiHook.install();

//指定脚本语言为 "ES6"
this.msc.Language = language;

//卸载 API 钩子 
apiHook.unInstall();
```

关键代码就这几句，干净绿色无污染。更多细节可查看 web.script  源代码。  

web.script("ES6") 在 Win7, WinXP 上会自动退化为 web.script("JScript")。所以我们可以做一些有趣的事了，例如我基于这个实现了扩展库 web.script.yaml （基于 js-yaml ），不但全兼容 XP，Win7，Win8，Win10，Win11 ……，而且在 Win10 / Win11 上可以自动切换为使用更快更好的 Chakra。   
这个 web.script.yaml 的体积也非常小，只有几十 KB。我们没必要为了解析个 YAML 就带上十几 MB 的组件，如果这样玩下去，一个小软件很快就会变成几百 MB。反之，如果我们总是优先使用系统自带组件，这里省个 10 MB，那里省个 10 MB，我们就可以用几百 KB 做别人几百 MB 才能做的事。

下面演示一下 web.script.yaml 的用法：  

```
import console;
import web.script.yaml;
var yaml = web.script.yaml;

var yamlText = /*
YAML: YAML Ain't Markup Language™

What It Is:
  YAML is a human-friendly data serialization language.

*/

var object = yaml.loadAll(yamlText)
console.dumpJson(object);

var text = yaml.dump(object);
console.dump(text);

console.pause();
```

如果只能在 WinXP，Win7 上玩耍，我给大家写了一个库 web.script.es5，导入这个库以后，即使在 WinXP，Win7 上至少也可以支持 ES5。来个例子：  

```
import console;
import web.script.es5;

var js = web.script(); 

js.script = /*****
var result = 0;
var numbers = [1,2,3];

if(Array.isArray(numbers)){
  numbers.forEach(function(value) {
    result = result + value; 
  });  
}

*****/

console.dump( js.script.result );
console.pause();
```

看，aardio 中一个小小的 web.script 可以玩出这么多花样。aardio 中还有不计其数这样的库。