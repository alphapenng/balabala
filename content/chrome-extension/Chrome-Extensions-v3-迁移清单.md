> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.cnblogs.com](https://www.cnblogs.com/echolun/p/17753958.html) ![](https://img2023.cnblogs.com/blog/1213309/202310/1213309-20231010102237370-1717634619.jpg)

一、前置问题
======

### 1.1 为什么需要迁移 v3？

Chrome 计划完全停止 v2 版本维护，后续 v2 版本将无法上架谷歌插件商店，除此之外，未来新版本 Chrome 对于 v2 版本插件的限制会越来越大，比如安全性限制 iframe 嵌套只能通过沙盒模式数据通信传递而不能直接获取数据等等，因此 v2 迁移 v3 是必要的。

### 1.2 v3 版本带来了什么新特性？

* 更强的隐私性，这一点在权限配置上会有所体现，权限划分更细腻。
* 更强的安全性，比如废弃 eval 方法，禁止加载运行远程仓库代码
* 更佳的性能，比如 background 被替换为 service workers，它不会持久运行
* 整合和调整了部分 API ，更符合未来的发展等等。

### 1.3 v2 迁移 V3 我需要做什么？

主要是四个方向的改动：

* manifest 配置更新
* background 迁移 Service Worker
* API 变更
* 安全调整

以下是具体需要做的事情。

二、manifest 更新清单
===============

### 2.1 manifest.json 版本号

manifest 版本号需要改为 3。

```json
// v2
{
  ...
  "manifest_version": 2
  ...
}
// v3
{
  ...
  "manifest_version": 3
  ...
}
```

### 2.2 废弃 persistent

persistent 用于决定 Chrome extensions 是否开启常驻后台，由于 v3 版本 background 迁移 service worker 后后台已经做不到常驻，此属性只能作废，删掉就好。

### 2.3 更新主机权限

在 Manifest V2 中，有两种方法为你的 api 或任何主机获得权限，要么在 `permissions` 数组或 `optional_permissions` 数组。

而 v3 的权限粒度划分会更细腻，不会像之前权限一把梭，所以像主机访问权限配置需要单独添加到 `host_permissions` 中：

```json
// v2
{
  "permissions": [
    "tabs",
    "bookmarks",
    "https://www.blogger.com/", // 之前主机权限都在 permissions
  ],
  "optional_permissions": [
    "unlimitedStorage",
    "*://*/*",
  ]
}
// v3
{
  "permissions": [
    "tabs",
    "bookmarks"
  ],
  "optional_permissions": [ // 单独配置主机权限
    "unlimitedStorage"
  ],
  "host_permissions": [
    "https://www.blogger.com/",
  ],
  "optional_host_permissions": [// 单独配置主机权限
    "*://*/*",
  ]
}
```

### 2.4 Background 迁移 Service Worker

V3 使用 Service Worker 取代了 Background，这里包含两个层面的意思，第一是配置字段变了（见下方代码），第二是 Service Worker 不再像之前的 Background 能做到一直在后台运行，这点我们后面细说。

```json
// v2
{
    ...,
    "background": {
        "scripts": ["background.js"],
        "persistent": false
      },
    ...
}
// v3
{
    ...,
    "background": {
        "service_worker": "background.js" // 字段变了
       // 删了 persistent
      },
    ...
}
```

### 2.5 更新 web_accessible_resources 字段

`web_accessible_resources` 用于指定哪些资源文件可以被 web 页面访问和加载，但在 v2 时也是一把梭，基本一次配置哪哪的网页都能访问，同样在 v3 此字段改为资源与匹配的对象形式，看代码就懂了：

```json
// v2
{
  ...
  "web_accessible_resources": [
    "images/*",
    "style/extension.css",
    "script/extension.js"
  ],
  ...
}
// v3
{
  ...
    "web_accessible_resources": [
    {
      "resources": [
        "images/*"
      ],
      "matches": [
        "*://*/*"
      ]
    },
    {
      "resources": [ // 指定资源
        "style/extension.css",
        "script/extension.js"
      ],
      "matches": [ // 谁可以访问
        "https://example.com/*"
      ]
    }
  ],
  ...
}
```

### 2.6 合并 browser_action 与 page_action 为 action

```json
// v2
{
  "browser_action": { … },
  "page_action": { … }
}

// v3 直接合并成一个即可
{
  "action": { … }
}
```

### 2.7 content_security_policy 需要从 string 改为对象配置

`content_security_policy` 用于定义加载和执行内容的安全策略，在 v3 版本你需要通过对象的形式来做配置：

```json
// v2
"content_security_policy": "script-src 'self' 'unsafe-eval' https://cdn.lr-in-prod.com; object-src 'self'"

// v3
"content_security_policy": {
  "extension_pages": "script-src 'self'; object-src 'self'",
  "sandbox": "sandbox allow-same-origin",
  "web_accessible_resources": "https://cdn.lr-in-prod.com"
}
```

需要注意的是，v3 处于安全考虑，不再允许执行 eval，所以上方代码中 `unsafe-eval` 在 v3 就没什么意义了。

三、 background 迁移 Service Worker
===============================

我们在 manifest 更新提到 background 迁移 Service Worker 需要更新 manifest 中的字段名，当然除了 key 变了之外， Service Worker 还会有一些本质的区别。避免大家混淆，Service Worker 和 v2 的 background 还是同一个文件，只是现在定义，使用场景都存在部分差异，接下来细说变化。

### 3.1 Service Worker 不再支持 DOM 访问

之前写在 background 的关于 dom 操作代码需要移出此文件，现有的 Service Worker 更适合用于做消息推送，时间监听之类的活。

当然，如果你非要在 Service Worker 使用 DOM ，你可以将消息从 Service Worker 发送到页面脚本，然后在页面脚本中执行相应的 DOM 操作。

第二种办法就是通过 `Offscreen API` 创建离屏文档，在离屏文档中进行 DOM 的操作。简单理解就是插件单独开辟一个虚拟环境用于你来操作 DOM， 比如：

```json
// manifest.json
"permissions": ["offscreen"]

// offscreen.html
<script src="offscreen.js"></script>

// offscreen.js
let textEl = document.querySelector('#text');
textEl.value = data;
textEl.select();
document.execCommand('copy');

// 在 Service Worker 中创建离屏文档
chrome.offscreen.createDocument({
  url: chrome.runtime.getURL('offscreen.html'),
  reasons: ['YOUR_REASON'],
  justification: 'YOUR_JUSTIFICATION',
});
```

但需要注意的是离屏文档使用插件自身 API 又有不少限制，具体可以查看文档 [chrome.offscreen](https://developer.chrome.com/docs/extensions/reference/offscreen/)

### 3.2 Service Worker 不支持 Window 调用

v3 的 Service Worker 不支持调用 Window，因此 localStorage 直接用不了，注意只是在 Service Worker 中，其它文件你想用还是正常用，对应的我们需要更换为 [chrome.storage.local](https://developer.chrome.com/docs/extensions/reference/storage/#property-local) 或者其它存储方式。

### 3.3 Service Worker 不再支持后台常驻运行

在 v2 版本由于 background 支持后台持久运行，我们可能直接在 background 定义持久变量，如下代码你希望统计事件派发次数：

```javascript
let num = 0;
chrome.runtime.onMessage.addListener((message) => {
    num++;
    console.log(count);
});
```

但由于 v3 不再持久运行，那么上述代逻每次被激活 num 会不断被重置为 0，如果你还需要达到上述效果得结合本地缓存：

```javascript
chrome.runtime.onMessage.addListener((message) => {
  const count = await chrome.storage.local.get(['num']);
    num++;
    chrome.storage.local.set({'num': num})
});
```

### 3.4 保证 Service Worker 同步注册事件监听

在 Manifest V3 中，背景页面已被替换为 Service Worker。与 Manifest V2 不同，Service Worker 是事件驱动的，并且在事件被派发时会重新初始化。这意味着在 Service Worker 中异步注册事件监听器的方式可能无法保证正常工作，因为在事件派发时，监听器可能尚未注册完毕。

比如在 v2：

```javascript
chrome.storage.local.get(["badgeText"], ({ badgeText }) => {
  chrome.browserAction.setBadgeText({ text: badgeText });
  // 异步注册
  chrome.browserAction.onClicked.addListener(handleActionClick);
});
```

在 v3 请保证注册同步：

```javascript
chrome.action.onClicked.addListener(handleActionClick);

chrome.storage.local.get(["badgeText"], ({ badgeText }) => {
  chrome.action.setBadgeText({ text: badgeText });
});
```

### 3.5 v3 Service Worker 以及整个插件都不再建议 XMLHttpRequest

在 Manifest V3 中，由于安全性和隔离性的考虑， Service Worker 禁止使用 `XMLHttpRequest()`，其它地方不建议使用 XMLHttpRequest。总体来讲，建议将后台脚本中对 `XMLHttpRequest()` 的调用替换为使用全局的 `fetch()` 来执行网络请求。

```javascript
const xhr = new XMLHttpRequest();
console.log('UNSENT', xhr.readyState); 

xhr.open('GET', '/api', true);
console.log('OPENED', xhr.readyState);

xhr.onload = () => {
    console.log('DONE', xhr.readyState);
};
xhr.send(null);
```

V3 替换为 fetch:

```javascript
const response = await fetch('https://www.example.com/greeting.json'');
console.log(response.statusText);
```

说直白点，如果你之前插件在 background 使用了 axios（基于 `XMLHttpRequest` 的封装），那么此时你必须把 background 的请求替换成 fetch，考虑到 fetch 与 XMLHttpRequest 存在部分差异，比如 fetch 会认为 404 500 错误码都不是 reject，以及 fetch 不会像 axios 直接集成请求响应拦截，所以如果你要替换一个使用上等价于 axios 的库，这里我推荐 [ky](https://github.com/sindresorhus/ky)，它解决了上述我说的对于错误码的处理，retry 封装，请求响应拦截封装等等。

（关于 axios 与 ky 的使用差异，后续我单独提供一篇文档）

### 3.6 使用 Alarms API 代替定时器

同理，由于 Service Worker 不再常驻执行，以前我们可能通过定时器异步来更改插件图标或其它操作，这都可能因为 Service Worker 释放导致定时器无法按预期执行，使用 Alarms 代替定时器；需要注意的除 Service Worker 外定时器还是随便你使用。

```json
// v2
const TIMEOUT = 3 * 60 * 1000; 
setTimeout(() => {
  chrome.action.setIcon({
    path: getRandomIconPath(),
  });
}, TIMEOUT);

// v3
async function startAlarm(name, duration) {
  await chrome.alarms.create(name, { delayInMinutes: 3 });
}

chrome.alarms.onAlarm.addListener(() => {
  chrome.action.setIcon({
    path: getRandomIconPath(),
  });
});
```

四、API 更新
========

### 4.1 tabs.executeScript () 替换为 scripting.executeScript ()

使用 `scripting.executeScript()` 需要在 manifest 配置权限

```json
"permissions": ["activeTab", "scripting"],
```

注入脚本方式代码层面的代码变化，比如 tabID 不再单独作为参数，files 支持传递多个文件，格式也变成了一个数组：

```javascript
// v2
async function getCurrentTab() {/* ... */}
let tab = await getCurrentTab();

chrome.tabs.executeScript(
  tab.id,
  {
    file: 'content-script.js'
  }
);

// v3
async function getCurrentTab()
let tab = await getCurrentTab();

chrome.scripting.executeScript({
  target: {tabId: tab.id},
  files: ['content-script.js']
});
```

如果是直接执行代码，变化如下：

```javascript
// v2
chrome.tabs.executeScript(
  tab.id,
 {
   code: alert("Hello, World!")
 }
);

// v3
chrome.scripting.executeScript({
  target: { tabId: tab.id },
  function: () => {
    alert("Hello, World!");
  },
});
```

### 4.2 tabs.insertCSS () tabs.removeCSS () 替换为 scripting.insertCSS () scripting.removeCSS ()

在 Manifest V2 中，我们使用 `chrome.tabs.insertCSS` 方法来向标签页注入 CSS 样式，而在 Manifest V3 中，这些方法已经从 `tabs` API 移到了 `scripting` API。这个迁移需要更新清单文件中的权限，以及修改代码。

同理，使用 scripting.insertCSS 也需要配置权限

```json
"permissions": [
  "activeTab", // 如果你只需要在当前激活的标签页中注入 CSS
  "scripting"  // 添加 scripting 权限
],
```

注入样式文件前后对比：

```javascript
// v2
chrome.tabs.insertCSS(tabId, injectDetails, () => {
  file: 'style.css'
});

// v3
const insertPromise = await chrome.scripting.insertCSS({
  files: ["style.css"],
  target: { tabId: tab.id }
});
// 剩余的代码
```

注入字符串的前后对比：

```javascript
// v2
chrome.tabs.insertCSS(tabId, {
  code: 'body { background-color: lightblue; }'
}, () => {
  // 在注入样式后执行的回调
});

// v3 支持 promise 取代回调的写法，当然你也能继续用回调
const insertPromise = chrome.scripting.insertCSS({
  target: { tabId: tab.id },
  css: 'body { background-color: lightblue; }'
});
```

### 4.3 更推荐 promise 回调用法取代回调

上方例子在注入样式文件 v2 采用回调形式处理注入之后的行为，v3 更建议 promise 用法，当然这只是建议并不是硬性要求，保留原有回调并不会出错。

### 4.4 合并 Browser Actions and Page Actions 为 Actions

这个在 manifest 迁移已经提了一次，除了配置合并外，这两个 API 也被合并为 actions

```javascript
// v2
chrome.browserAction.onClicked.addListener(tab => { ... });
chrome.pageAction.onClicked.addListener(tab => { ... });
                                                
// v3
chrome.action.onClicked.addListener(tab => { ... });
```

### 4.5 替换 v2 background 上下文获取的函数

在 Manifest V3 中，不同的扩展上下文只能通过消息传递与 service worker 进行交互。因此，你需要替换那些期望与后台上下文交互的调用，具体包括以下几个：

1. `chrome.runtime.getBackgroundPage()`: 这个函数通常用于获取后台页（background page）的引用，以便与后台页通信。在 Manifest V3 中，由于没有后台页的概念，你需要使用消息传递来与 service worker 通信，而不是直接获取后台页的引用。
2. `chrome.extension.getBackgroundPage()`: 类似于 `chrome.runtime.getBackgroundPage()`，这个函数也用于获取后台页的引用，而在 Manifest V3 中，同样需要改用消息传递来实现与 service worker 通信。
3. `chrome.extension.getExtensionTabs()`: 这个函数用于获取扩展的标签页信息。在 Manifest V3 中，标签页的概念发生了变化，因此需要采用不同的方法来获取相关信息。

第一和第二点好理解，毕竟 service worker 不再常驻，不能直接获取 background 直接用里面的变量，需要改为通信的形式。

关于第三点，因为 Manifest V3 引入了一些重大的更改，包括对标签页（tabs）的管理方式。如果你需要获取有关标签页的信息，你可以使用 `chrome.tabs` API。

```javascript
// 获取当前标签页信息：
chrome.tabs.query({ active: true, currentWindow: true }, function(tabs) {
  // tabs[0] 包含了当前标签页的信息
  console.log(tabs[0]);
});

// 获取所有标签页信息：
chrome.tabs.query({}, function(tabs) {
  // tabs 包含了所有标签页的信息
  console.log(tabs);
});

// 更新标签页的URL：
chrome.tabs.update(tabId, { url: 'https://new-url.com' });

// 打开一个新的标签页：
chrome.tabs.create({ url: 'https://example.com' });
```

### 4.6 替换不再支持的 API（需要全局搜索对应替换）

以下方法或者属性需要在 v3 进行替换：

<table><thead><tr><th>v2 属性或方法</th><th>需要替换为</th></tr></thead><tbody><tr><td>chrome.extension.connect()</td><td>chrome.runtime.connect()</td></tr><tr><td>chrome.extension.connectNative()</td><td>chrome.runtime.connectNative()</td></tr><tr><td>chrome.extension.getExtensionTabs()</td><td>chrome.extension.getViews()</td></tr><tr><td>chrome.extension.getURL()</td><td>chrome.runtime.getURL()</td></tr><tr><td>chrome.extension.lastError</td><td>当方法返回 promise 使用 promise.catch ()</td></tr><tr><td>chrome.extension.onConnect</td><td>chrome.runtime.onConnect</td></tr><tr><td>chrome.extension.onConnectExternal</td><td>chrome.runtime.onConnectExternal</td></tr><tr><td>chrome.extension.onMessage</td><td>chrome.runtime.onMessage</td></tr><tr><td>chrome.extension.onRequest</td><td>chrome.runtime.onRequest</td></tr><tr><td>chrome.extension.onRequestExternal</td><td>chrome.runtime.onMessageExternal</td></tr><tr><td>chrome.extension.sendMessage()</td><td>chrome.runtime.sendMessage()</td></tr><tr><td>chrome.extension.sendNativeMessage()</td><td>chrome.runtime.sendNativeMessage()</td></tr><tr><td>chrome.extension.sendRequest()</td><td>chrome.runtime.sendMessage()</td></tr><tr><td>chrome.runtime.onSuspend（background 中使用）</td><td>不再支持在 service worker 使用，请用 beforeunload 代替</td></tr><tr><td>chrome.tabs.getAllInWindow()</td><td>chrome.tabs.query()</td></tr><tr><td>chrome.tabs.getSelected()</td><td>chrome.tabs.query()</td></tr><tr><td>chrome.tabs.onActiveChanged</td><td>chrome.tabs.onActivated</td></tr><tr><td>chrome.tabs.onHighlightChanged</td><td>chrome.tabs.onHighlighted</td></tr><tr><td>chrome.tabs.onSelectionChanged</td><td>chrome.tabs.onActivated</td></tr><tr><td>chrome.tabs.sendRequest()</td><td>chrome.runtime.sendMessage()</td></tr><tr><td>chrome.tabs.Tab.selected</td><td>chrome.tabs.Tab.highlighted</td></tr></tbody></table>

五、安全改进
======

### 5.1 禁用 evel 等字符串执行方法

V3 出于安全考虑，不再允许执行一些危险的 JavaScript 操作，比如字符相关的方法 `executeScript`、`eval()` 以及 `new Function` 等方法。

`eval()` 方法大家走知道能强制执行字符串，这里不过多解释，关于 `new Function` 创建函数同样能以字符串的形式定义函数体，同理也被禁止。

关于 `executeScript` 其实上文 `scripting.executeScript` 我们已经给了例子，这里再贴个例子：

```javascript
// v2 不再推荐
chrome.tabs.executeScript(
  tab.id,
 {
   code: alert("Hello, World!")
 }
);

// 不允许使用 eval
chrome.scripting.executeScript({
  target: { tabId: tab.id },
  function: () => {
    eval('alert("This is unsafe!")');
  }
});

// v3 正确用法
chrome.scripting.executeScript({
  target: { tabId: tab.id },
  function: () => {
    alert("Hello, World!");
  },
});

// 或者把代码部分单独定义方法
const fn = () => alert("Hello, World!");
chrome.scripting.executeScript({
  target: { tabId: tab.id },
  function: fn,
});
```

当然有版本绕过 v3 报错强制使用 eval，比如开启沙盒模式，在沙盒中使用 eval，再通过与外界通信，但是非必要不建议这么做。

### 5.2 不再支持加载和执行远程托管代码（这个很头疼）

v3 出于安全考虑，不能直接引用或执行托管在远程服务器上的 JavaScript 代码，防止恶意代码的执行，比如：

* 不允许从服务器上动态拉取 JavaScript 文件并执行。
* 不允许通过 CDN 远程加载代码。

说通俗点，你需要执行的代码都应该属于插件代码自身的一部分，假设插件使用到了 react，一种解决办法是我们本地开发 npm react 后，再打包插件时应该将 react 源码也一起打包进去。

另一种办法，就是直接将 cdn 代码直接拷贝到本地，然后全局通过 `scripting.executeScript` 注入。

### 5.3 安全策略配置值调整

这一点在 manifest 提过一次，除了 `content_security_policy` 由 v2 字符串变成 v3 对象之外，"script-src"、"object-src" 和 "worker-src" 指令，只有以下四个值是被允许的：

1. `self`: 这表示只允许从与扩展自身相关的源加载脚本、对象或 Worker 脚本。
2. `none`: 这表示不允许加载任何脚本、对象或 Worker 脚本。
3. `wasm-unsafe-eval`: 这表示允许加载 WebAssembly 模块，但禁止执行不安全的 eval 操作。
4. 仅适用于未打包的扩展：`localhost` 源，包括 `http://localhost`、`http://127.0.0.1` 或这些域上的任何端口。

所以在 manifest 我们强调了像 `unsafe-eval` 这种直接废弃了，毕竟不支持 eval 执行了。
