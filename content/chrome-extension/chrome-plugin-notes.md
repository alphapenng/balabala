# chrome plugin notes

- [chrome plugin notes](#chrome-plugin-notes)
  - [目录](#目录)
  - [核心介绍](#核心介绍)
    - [manifest.json](#manifestjson)
    - [content-scripts](#content-scripts)
    - [background](#background)
    - [event-pages](#event-pages)
    - [popup](#popup)
    - [injected-script](#injected-script)
    - [homepage\_url](#homepage_url)
  - [Chrome 插件的 8 种展示形式](#chrome-插件的-8-种展示形式)
    - [browserAction (浏览器右上角)](#browseraction-浏览器右上角)
      - [图标](#图标)
    - [pageAction (地址栏右侧)](#pageaction-地址栏右侧)
    - [右键菜单](#右键菜单)
      - [最简单的右键菜单示例](#最简单的右键菜单示例)
      - [添加右键百度搜索](#添加右键百度搜索)
      - [语法说明](#语法说明)
    - [override (覆盖特定页面)](#override-覆盖特定页面)
    - [option（选项页）](#option选项页)
    - [omnibox](#omnibox)
    - [桌面通知](#桌面通知)
  - [5 种类型的 JS 对比](#5-种类型的-js-对比)
    - [权限对比](#权限对比)
    - [调试方法对比](#调试方法对比)
  - [消息通信](#消息通信)
    - [互相通信概览](#互相通信概览)
    - [通信详细介绍](#通信详细介绍)
      - [popup 和 background](#popup-和-background)
      - [popup 或者 bg 向 content 主动发送消息](#popup-或者-bg-向-content-主动发送消息)
      - [content-script 主动发消息给后台](#content-script-主动发消息给后台)
      - [injected script 和 content-script](#injected-script-和-content-script)
    - [长连接和短连接](#长连接和短连接)
  - [其它补充](#其它补充)
    - [动态注入或执行 JS](#动态注入或执行-js)
    - [动态注入 CSS](#动态注入-css)
    - [获取当前窗口 ID](#获取当前窗口-id)
    - [获取当前标签页 ID](#获取当前标签页-id)
    - [本地存储](#本地存储)
    - [webRequest](#webrequest)
    - [国际化](#国际化)
    - [API 总结](#api-总结)

## 目录

![index](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240225090231_epjHKJ.png)

## 核心介绍

### manifest.json

下面给出的是一些常见的配置项，均有中文注释，完整的配置文档请戳[这里](https://developer.chrome.com/extensions/manifest)。

```json
{
 // 清单文件的版本，这个必须写，而且必须是2
 "manifest_version": 2,
 // 插件的名称
 "name": "demo",
 // 插件的版本
 "version": "1.0.0",
 // 插件描述
 "description": "简单的Chrome扩展demo",
 // 图标，一般偷懒全部用一个尺寸的也没问题
 "icons":
 {
  "16": "img/icon.png",
  "48": "img/icon.png",
  "128": "img/icon.png"
 },
 // 会一直常驻的后台JS或后台页面
 "background":
 {
  // 2种指定方式，如果指定JS，那么会自动生成一个背景页
  "page": "background.html"
  //"scripts": ["js/background.js"]
 },
 // 浏览器右上角图标设置，browser_action、page_action、app必须三选一
 "browser_action": 
 {
  "default_icon": "img/icon.png",
  // 图标悬停时的标题，可选
  "default_title": "这是一个示例Chrome插件",
  "default_popup": "popup.html"
 },
 // 当某些特定页面打开才显示的图标
 /*"page_action":
 {
  "default_icon": "img/icon.png",
  "default_title": "我是pageAction",
  "default_popup": "popup.html"
 },*/
 // 需要直接注入页面的JS
 "content_scripts": 
 [
  {
   //"matches": ["http://*/*", "https://*/*"],
   // "<all_urls>" 表示匹配所有地址
   "matches": ["<all_urls>"],
   // 多个JS按顺序注入
   "js": ["js/jquery-1.8.3.js", "js/content-script.js"],
   // JS的注入可以随便一点，但是CSS的注意就要千万小心了，因为一不小心就可能影响全局样式
   "css": ["css/custom.css"],
   // 代码注入的时间，可选值： "document_start", "document_end", or "document_idle"，最后一个表示页面空闲时，默认document_idle
   "run_at": "document_start"
  },
  // 这里仅仅是为了演示content-script可以配置多个规则
  {
   "matches": ["*://*/*.png", "*://*/*.jpg", "*://*/*.gif", "*://*/*.bmp"],
   "js": ["js/show-image-content-size.js"]
  }
 ],
 // 权限申请
 "permissions":
 [
  "contextMenus", // 右键菜单
  "tabs", // 标签
  "notifications", // 通知
  "webRequest", // web请求
  "webRequestBlocking",
  "storage", // 插件本地存储
  "http://*/*", // 可以通过executeScript或者insertCSS访问的网站
  "https://*/*" // 可以通过executeScript或者insertCSS访问的网站
 ],
 // 普通页面能够直接访问的插件资源列表，如果不设置是无法直接访问的
 "web_accessible_resources": ["js/inject.js"],
 // 插件主页，这个很重要，不要浪费了这个免费广告位
 "homepage_url": "https://www.baidu.com",
 // 覆盖浏览器默认页面
 "chrome_url_overrides":
 {
  // 覆盖浏览器默认的新标签页
  "newtab": "newtab.html"
 },
 // Chrome40以前的插件配置页写法
 "options_page": "options.html",
 // Chrome40以后的插件配置页写法，如果2个都写，新版Chrome只认后面这一个
 "options_ui":
 {
  "page": "options.html",
  // 添加一些默认的样式，推荐使用
  "chrome_style": true
 },
 // 向地址栏注册一个关键字以提供搜索建议，只能设置一个关键字
 "omnibox": { "keyword" : "go" },
 // 默认语言
 "default_locale": "zh_CN",
 // devtools页面入口，注意只能指向一个HTML文件，不能是JS文件
 "devtools_page": "devtools.html"
}
```

### content-scripts

⚠️ 特别注意，如果没有主动指定 `run_at` 为 `document_start`（默认为 `document_idle`），下面这种代码是不会生效的：

```javascript
document.addEventListener('DOMContentLoaded', function()
{
 console.log('我被执行了！');
});
```

`content-scripts` 和原始页面共享 DOM，但是不共享 JS，如要访问页面 JS（例如某个 JS 变量），只能通过 `injected.js` 来实现。`content-scripts` 不能访问绝大部分 `chrome.xxx.api`，除了下面这 4 种：

- chrome.extension(getURL , inIncognitoContext , lastError , onRequest , sendRequest)
- chrome.i18n
- chrome.runtime(connect , getManifest , getURL , id , onConnect , onMessage , sendMessage)
- chrome.storage

其实看到这里不要悲观，这些 API 绝大部分时候都够用了，非要调用其它 API 的话，你还可以通过通信来实现让 background 来帮你调用（关于通信，后文有详细介绍）。

### background

后台（姑且这么翻译吧），是一个常驻的页面，它的生命周期是插件中所有类型页面中最长的，它随着浏览器的打开而打开，随着浏览器的关闭而关闭，所以通常把需要一直运行的、启动就运行的、全局的代码放在 background 里面。

background 的权限非常高，几乎可以调用所有的 Chrome 扩展 API（除了 devtools），而且它可以无限制跨域，也就是可以跨域访问任何网站而无需要求对方设置 `CORS`。

> 经过测试，其实不止是 background，所有的直接通过 chrome-extension://id/xx.html 这种方式打开的网页都可以无限制跨域。

### event-pages

这里顺带介绍一下 [event-pages](https://developer.chrome.com/extensions/event_pages)，它是一个什么东西呢？鉴于 background 生命周期太长，长时间挂载后台可能会影响性能，所以 Google 又弄一个 `event-pages`，在配置文件上，它与 background 的唯一区别就是多了一个 `persistent` 参数：

```json
{
 "background":
 {
  "scripts": ["event-page.js"],
  "persistent": false
 },
}
```

它的生命周期是：在被需要时加载，在空闲时被关闭，什么叫被需要时呢？比如第一次安装、插件更新、有 content-script 向它发送消息，等等。

除了配置文件的变化，代码上也有一些细微变化，个人这个简单了解一下就行了，一般情况下 background 也不会很消耗性能的。

### popup

`popup` 是点击 `browser_action` 或者 `page_action` 图标时打开的一个小窗口网页，焦点离开网页就立即关闭，一般用来做一些临时性的交互。

`popup` 可以包含任意你想要的 HTML 内容，并且会自适应大小。可以通过 `default_popup` 字段来指定 popup 页面，也可以调用 `setPopup()` 方法。

在权限上，它和 background 非常类似，它们之间最大的不同是生命周期的不同，popup 中可以直接通过 `chrome.extension.getBackgroundPage()` 获取 background 的 window 对象。

### injected-script

这里的 `injected-script` 是我给它取的，指的是通过 DOM 操作的方式向页面注入的一种 JS。为什么要把这种 JS 单独拿出来讨论呢？又或者说为什么需要通过这种方式注入 JS 呢？

这是因为 `content-script` 有一个很大的 “缺陷”，也就是无法访问页面中的 JS，虽然它可以操作 DOM，但是 DOM 却不能调用它，也就是无法在 DOM 中通过绑定事件的方式调用 `content-script` 中的代码（包括直接写 `onclick` 和 `addEventListener` 2 种方式都不行），但是，“在页面上添加一个按钮并调用插件的扩展 API” 是一个很常见的需求，那该怎么办呢？其实这就是本小节要讲的。

在 `content-script` 中通过 DOM 方式向页面注入 `inject-script` 代码示例：

```javascript
// 向页面注入JS
function injectCustomJs(jsPath)
{
 jsPath = jsPath || 'js/inject.js';
 var temp = document.createElement('script');
 temp.setAttribute('type', 'text/javascript');
 // 获得的地址类似：chrome-extension://ihcokhadfjfchaeagdoclpnjdiokfakg/js/inject.js
 temp.src = chrome.extension.getURL(jsPath);
 temp.onload = function()
 {
  // 放在页面不好看，执行完后移除掉
  this.parentNode.removeChild(this);
 };
 document.head.appendChild(temp);
}
```

你以为这样就行了？执行一下你会看到如下报错：

```bash
Denying load of chrome-extension://efbllncjkjiijkppagepehoekjojdclc/js/inject.js. Resources must be listed in the web_accessible_resources manifest key in order to be loaded by pages outside the extension.
```

意思就是你想要在 web 中直接访问插件中的资源的话必须显示声明才行，配置文件中增加如下：

```json
{
 // 普通页面能够直接访问的插件资源列表，如果不设置是无法直接访问的
 "web_accessible_resources": ["js/inject.js"],
}
```

### homepage_url

开发者或者插件主页设置，一般会在如下 2 个地方显示：

![homepage1](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240225110203_pT1IPM.png)
![homepage2](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240225110116_xyaqcr.png)

## Chrome 插件的 8 种展示形式

### browserAction (浏览器右上角)

#### 图标

`browser_action` 图标推荐使用宽高都为 19 像素的图片，更大的图标会被缩小，格式随意，一般推荐 png，可以通过 manifest 中 `default_icon` 字段配置，也可以调用 `setIcon ()` 方法。

### pageAction (地址栏右侧)

### 右键菜单

通过开发 Chrome 插件可以自定义浏览器的右键菜单，主要是通过 `chrome.contextMenusAPI` 实现，右键菜单可以出现在不同的上下文，比如普通页面、选中的文字、图片、链接，等等，如果有同一个插件里面定义了多个菜单，Chrome 会自动组合放到以插件名字命名的二级菜单里，如下：

![rightClick](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240225111750_CZ0uKC.png)

#### 最简单的右键菜单示例

```json
// manifest.json
{"permissions": ["contextMenus"]}

// background.js
chrome.contextMenus.create({
 title: "测试右键菜单",
 onclick: function(){alert('您点击了右键菜单！');}
});
```

#### 添加右键百度搜索

```javascript
// manifest.json
{"permissions": ["contextMenus"， "tabs"]}

// background.js
chrome.contextMenus.create({
 title: '使用度娘搜索：%s', // %s表示选中的文字
 contexts: ['selection'], // 只有当选中文字时才会出现此右键菜单
 onclick: function(params)
 {
  // 注意不能使用location.href，因为location是属于background的window对象
  chrome.tabs.create({url: 'https://www.baidu.com/s?ie=utf-8&wd=' + encodeURI(params.selectionText)});
 }
});
```

#### 语法说明

这里只是简单列举一些常用的，完整 API 参见：<https://developer.chrome.com/extensions/contextMenus>

```javascript
chrome.contextMenus.create({
 type: 'normal'， // 类型，可选：["normal", "checkbox", "radio", "separator"]，默认 normal
 title: '菜单的名字', // 显示的文字，除非为“separator”类型否则此参数必需，如果类型为“selection”，可以使用%s显示选定的文本
 contexts: ['page'], // 上下文环境，可选：["all", "page", "frame", "selection", "link", "editable", "image", "video", "audio"]，默认page
 onclick: function(){}, // 单击时触发的方法
 parentId: 1, // 右键菜单项的父菜单项ID。指定父菜单项将会使此菜单项成为父菜单项的子菜单
 documentUrlPatterns: 'https://*.baidu.com/*' // 只在某些页面显示此右键菜单
});
// 删除某一个菜单项
chrome.contextMenus.remove(menuItemId)；
// 删除所有自定义右键菜单
chrome.contextMenus.removeAll();
// 更新某一个菜单项
chrome.contextMenus.update(menuItemId, updateProperties);
```

### override (覆盖特定页面)

使用 `override` 页可以将 Chrome 默认的一些特定页面替换掉，改为使用扩展提供的页面。

### option（选项页）

几点注意：

- 为了兼容，建议 2 种都写，如果都写了，Chrome40 以后会默认读取新版的方式；
- 新版 options 中不能使用 alert；
- 数据存储建议用 chrome.storage，因为会随用户自动同步；

### omnibox

### 桌面通知

## 5 种类型的 JS 对比

Chrome 插件的 JS 主要可以分为这 5 类：`injected script`、`content-script`、`popup js`、`background js` 和 `devtools js`，

### 权限对比

JS 种类 | 可访问的 API | DOM 访问情况 | JS 访问情况 | 直接跨域
---------|----------|----------|---------|---------
 injected script | 和普通 JS 无任何差别，不能访问任何扩展 API | 可以访问 | 可以访问 | 不可以
 content script | 只能访问 extension、runtime 等部分 API | 可以访问 | 不可以 | 不可以
 popup js | 可访问绝大部分 API，除了 devtools 系列 | 不可直接访问 | 不可以 | 可以
 background js | 可访问绝大部分 API，除了 devtools 系列 | 不可可以访问 | 不可以 | 可以
 devtools js | 只能访问 devtools、extension、runtime 等部分 API | 可以 | 可以 | 不可以

### 调试方法对比

JS 类型 | 调试方式
---------|----------|
 injected script | 直接普通的 F12 即可
 content-script | 打开 console
 popup-js | popup 页面右键审查元素
 background | 插件管理页点击背景页即可
 devtools-js | 暂未找到有效方法

## 消息通信

通信主页：<https://developer.chrome.com/extensions/messaging>

### 互相通信概览

注：`-` 表示不存在或者无意义，或者待验证。

JS 类型 | injected-script | content-script | popup-js | background-js
---------|----------|---------|---------|---------
 injected-script | - | window.postMessage | - | -
 content-script |window.postMessage | - | chrome.runtime.sendMessage chrome.runtime.connect | chrome.runtime.sendMessage chrome.runtime.connect
 popup-js | - | chrome.tabs.sendMessage chrome.tabs.connect | - | chrome.extension. getBackgroundPage()
 background-js | - | chrome.tabs.sendMessage chrome.tabs.connect | chrome.extension.getViews | -
 devtools-js | chrome.devtools. inspectedWindow.eval | - | chrome.runtime.sendMessage | chrome.runtime.sendMessage

### 通信详细介绍

#### popup 和 background

popup 可以直接调用 background 中的 JS 方法，也可以直接访问 background 的 DOM：

```javascript
// background.js
function test()
{
 alert('我是background！');
}

// popup.js
var bg = chrome.extension.getBackgroundPage();
bg.test(); // 访问bg的函数
alert(bg.document.body.innerHTML); // 访问bg的DOM
```

至于 `background` 访问 `popup` 如下（前提是 `popup` 已经打开）：

```javascript
var views = chrome.extension.getViews({type:'popup'});
if(views.length > 0) {
 console.log(views[0].location.href);
}
```

#### popup 或者 bg 向 content 主动发送消息

background.js 或者 popup.js：

```javascript
function sendMessageToContentScript(message, callback)
{
 chrome.tabs.query({active: true, currentWindow: true}, function(tabs)
 {
  chrome.tabs.sendMessage(tabs[0].id, message, function(response)
  {
   if(callback) callback(response);
  });
 });
}
sendMessageToContentScript({cmd:'test', value:'你好，我是popup！'}, function(response)
{
 console.log('来自content的回复：'+response);
});
```

`content-script.js` 接收：

```javascript
chrome.runtime.onMessage.addListener(function(request, sender, sendResponse)
{
 // console.log(sender.tab ?"from a content script:" + sender.tab.url :"from the extension");
 if(request.cmd == 'test') alert(request.value);
 sendResponse('我收到了你的消息！');
});
```

双方通信直接发送的都是 JSON 对象，不是 JSON 字符串，所以无需解析，很方便（当然也可以直接发送字符串）。

#### content-script 主动发消息给后台

content-script.js：

```javascript
chrome.runtime.sendMessage({greeting: '你好，我是content-script呀，我主动发消息给后台！'}, function(response) {
 console.log('收到来自后台的回复：' + response);
});
```

background.js 或者 popup.js：

```javascript
// 监听来自content-script的消息
chrome.runtime.onMessage.addListener(function(request, sender, sendResponse)
{
 console.log('收到来自content-script的消息：');
 console.log(request, sender, sendResponse);
 sendResponse('我是后台，我已收到你的消息：' + JSON.stringify(request));
});
```

注意事项：

- content_scripts 向 popup 主动发消息的前提是 popup 必须打开！否则需要利用 background 作中转；
- 如果 background 和 popup 同时监听，那么它们都可以同时收到消息，但是只有一个可以 sendResponse，一个先发送了，那么另外一个再发送就无效；

#### injected script 和 content-script

`content-script` 和页面内的脚本（`injected-script` 自然也属于页面内的脚本）之间唯一共享的东西就是页面的 DOM 元素，有 2 种方法可以实现二者通讯：

1. 可以通过 `window.postMessage` 和 `window.addEventListener` 来实现二者消息通讯；
2. 通过自定义 DOM 事件来实现；

第一种方法（推荐）：

`injected-script` 中：

```javascript
window.postMessage({"test": '你好！'}, '*');
```

`content script` 中：

```javascript
window.addEventListener("message", function(e)
{
 console.log(e.data);
}, false);
```

第二种方法：

`injected-script` 中：

```javascript
var customEvent = document.createEvent('Event');
customEvent.initEvent('myCustomEvent', true, true);
function fireCustomEvent(data) {
 hiddenDiv = document.getElementById('myCustomEventDiv');
 hiddenDiv.innerText = data
 hiddenDiv.dispatchEvent(customEvent);
}
fireCustomEvent('你好，我是普通JS！');
```

`content-script.js` 中：

```javascript
var hiddenDiv = document.getElementById('myCustomEventDiv');
if(!hiddenDiv) {
 hiddenDiv = document.createElement('div');
 hiddenDiv.style.display = 'none';
 document.body.appendChild(hiddenDiv);
}
hiddenDiv.addEventListener('myCustomEvent', function() {
 var eventData = document.getElementById('myCustomEventDiv').innerText;
 console.log('收到自定义事件消息：' + eventData);
});
```

### 长连接和短连接

其实上面已经涉及到了，这里再单独说明一下。Chrome 插件中有 2 种通信方式，一个是短连接（`chrome.tabs.sendMessage` 和 `chrome.runtime.sendMessage`），一个是长连接（`chrome.tabs.connect` 和 `chrome.runtime.connect`）。

短连接的话就是挤牙膏一样，我发送一下，你收到了再回复一下，如果对方不回复，你只能重新发，而长连接类似 `WebSocket` 会一直建立连接，双方可以随时互发消息。

短连接上面已经有代码示例了，这里只讲一下长连接。

popup.js：

```javascript
getCurrentTabId((tabId) => {
 var port = chrome.tabs.connect(tabId, {name: 'test-connect'});
 port.postMessage({question: '你是谁啊？'});
 port.onMessage.addListener(function(msg) {
  alert('收到消息：'+msg.answer);
  if(msg.answer && msg.answer.startsWith('我是'))
  {
   port.postMessage({question: '哦，原来是你啊！'});
  }
 });
});
```

content-script.js：

```javascript
// 监听长连接
chrome.runtime.onConnect.addListener(function(port) {
 console.log(port);
 if(port.name == 'test-connect') {
  port.onMessage.addListener(function(msg) {
   console.log('收到长连接消息：', msg);
   if(msg.question == '你是谁啊？') port.postMessage({answer: '我是你爸！'});
  });
 }
});
```

## 其它补充

### 动态注入或执行 JS

虽然在 `background` 和 `popup` 中无法直接访问页面 DOM，但是可以通过 `chrome.tabs.executeScript` 来执行脚本，从而实现访问 web 页面的 DOM（注意，这种方式也不能直接访问页面 JS）。

示例 `manifest.json` 配置：

```json
{
 "name": "动态JS注入演示",
 ...
 "permissions": [
  "tabs", "http://*/*", "https://*/*"
 ],
 ...
}
```

JS：

```javascript
// 动态执行JS代码
chrome.tabs.executeScript(tabId, {code: 'document.body.style.backgroundColor="red"'});
// 动态执行JS文件
chrome.tabs.executeScript(tabId, {file: 'some-script.js'});
```

### 动态注入 CSS

示例 `manifest.json` 配置：

```json
{
 "name": "动态CSS注入演示",
 ...
 "permissions": [
  "tabs", "http://*/*", "https://*/*"
 ],
 ...
}
```

JS 代码：

```javascript
// 动态执行CSS代码，TODO，这里有待验证
chrome.tabs.insertCSS(tabId, {code: 'xxx'});
// 动态执行CSS文件
chrome.tabs.insertCSS(tabId, {file: 'some-style.css'});
```

### 获取当前窗口 ID

```javascript
chrome.windows.getCurrent(function(currentWindow)
{
 console.log('当前窗口ID：' + currentWindow.id);
});
```

### 获取当前标签页 ID

一般有 2 种方法：

```javascript
// 获取当前选项卡ID
function getCurrentTabId(callback)
{
 chrome.tabs.query({active: true, currentWindow: true}, function(tabs)
 {
  if(callback) callback(tabs.length ? tabs[0].id: null);
 });
}
```

获取当前选项卡 id 的另一种方法，大部分时候都类似，只有少部分时候会不一样（例如当窗口最小化时）

```javascript
// 获取当前选项卡ID
function getCurrentTabId2()
{
 chrome.windows.getCurrent(function(currentWindow)
 {
  chrome.tabs.query({active: true, windowId: currentWindow.id}, function(tabs)
  {
   if(callback) callback(tabs.length ? tabs[0].id: null);
  });
 });
}
```

### 本地存储

本地存储建议用 `chrome.storage` 而不是普通的 `localStorage`，区别有好几点，个人认为最重要的 2 点区别是：

- `chrome.storage` 是针对插件全局的，即使你在 `background` 中保存的数据，在 `content-script` 也能获取到；
- `chrome.storage.sync` 可以跟随当前登录用户自动同步，这台电脑修改的设置会自动同步到其它电脑，很方便，如果没有登录或者未联网则先保存到本地，等登录了再同步至网络；

需要声明 `storage` 权限，有 `chrome.storage.sync` 和 `chrome.storage.local` 2 种方式可供选择，使用示例如下：

```javascript
// 读取数据，第一个参数是指定要读取的key以及设置默认值
chrome.storage.sync.get({color: 'red', age: 18}, function(items) {
 console.log(items.color, items.age);
});
// 保存数据
chrome.storage.sync.set({color: 'blue'}, function() {
 console.log('保存成功！');
});
```

### webRequest

通过 webRequest 系列 API 可以对 HTTP 请求进行任性地修改、定制，这里通过 `beforeRequest` 来简单演示一下它的冰山一角：

```javascript
//manifest.json
{
 // 权限申请
 "permissions":
 [
  "webRequest", // web请求
  "webRequestBlocking", // 阻塞式web请求
  "storage", // 插件本地存储
  "http://*/*", // 可以通过executeScript或者insertCSS访问的网站
  "https://*/*" // 可以通过executeScript或者insertCSS访问的网站
 ],
}


// background.js
// 是否显示图片
var showImage;
chrome.storage.sync.get({showImage: true}, function(items) {
 showImage = items.showImage;
});
// web请求监听，最后一个参数表示阻塞式，需单独声明权限：webRequestBlocking
chrome.webRequest.onBeforeRequest.addListener(details => {
 // cancel 表示取消本次请求
 if(!showImage && details.type == 'image') return {cancel: true};
 // 简单的音视频检测
 // 大部分网站视频的type并不是media，且视频做了防下载处理，所以这里仅仅是为了演示效果，无实际意义
 if(details.type == 'media') {
  chrome.notifications.create(null, {
   type: 'basic',
   iconUrl: 'img/icon.png',
   title: '检测到音视频',
   message: '音视频地址：' + details.url,
  });
 }
}, {urls: ["<all_urls>"]}, ["blocking"]);
```

### 国际化

插件根目录新建一个名为 `_locales` 的文件夹，再在下面新建一些语言的文件夹，如 `en`、`zh_CN`、`zh_TW`，然后再在每个文件夹放入一个 `messages.json`，同时必须在清单文件中设置 `default_locale`。

`_locales\en\messages.json` 内容：

```json
{
 "pluginDesc": {"message": "A simple chrome extension demo"},
 "helloWorld": {"message": "Hello World!"}
}
```

`_locales\zh_CN\messages.json` 内容：

```json
{
 "pluginDesc": {"message": "一个简单的Chrome插件demo"},
 "helloWorld": {"message": "你好啊，世界！"}
}
```

在 `manifest.json` 和 `CSS` 文件中通过 `__MSG_messagename__` 引入，如：

```json
{
 "description": "__MSG_pluginDesc__",
 // 默认语言
 "default_locale": "zh_CN",
}
```

JS 中则直接 `chrome.i18n.getMessage("helloWorld")`。

测试时，通过给 chrome 建立一个不同的快捷方式 `chrome.exe --lang=en` 来切换语言，如：

![i18n](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240226214845_yOPjFq.png)

### API 总结

比较常用用的一些 API 系列：

- chrome.tabs
- chrome.runtime
- chrome.webRequest
- chrome.window
- chrome.storage
- chrome.contextMenus
- chrome.devtools
- chrome.extension
