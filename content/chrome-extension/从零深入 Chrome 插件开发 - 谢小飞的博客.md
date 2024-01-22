> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [xieyufei.com](https://xieyufei.com/2021/11/09/Chrome-Plugin.html)

> 使用 Chrome 插件可以为 Chrome 浏览器带来一些功能性的扩展，进而提高使用体验；俗话说的好 Chrome 没插件，香味少一半，Chrome 最大的优势还是其支持众多强大好用的扩展程序；今天我们就来了解一下插件是如何开发的，和我们普通的浏览器页面开发有什么区别，以及安利一些功能强大的插件。

　　使用 Chrome 插件可以为 Chrome 浏览器带来一些功能性的扩展，进而提高使用体验；俗话说的好 Chrome 没插件，香味少一半，Chrome 最大的优势还是其支持众多强大好用的扩展程序；今天我们就来了解一下插件是如何开发的，和我们普通的浏览器页面开发有什么区别，以及安利一些功能强大的插件。

　　Chrome 插件，官方名称 extensions（扩展程序）；为了方便理解，以下都称为 Chrome 插件，或者简称插件，那么什么是 Chrome 插件呢？

> 扩展程序是自定义浏览体验的小型软件程序。它们让用户可以通过多种方式定制`Chrome`的功能和行为。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　插件程序提供了以下几个功能：

*   生产力工具：

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

*   网页内容丰富
*   信息聚合
*   乐趣和游戏

　　我们可以通过点击`更多工具 -> 扩展程序`来查看我们所有安装的插件，或者直接打开[插件标签页](chrome://extensions/)。

[![](https://xieyufei.com/images/Chrome-Plugin/where.png)](https://xieyufei.com/images/Chrome-Plugin/where.png "查看插件标签页")

[查看插件标签页](https://xieyufei.com/images/Chrome-Plugin/where.png "查看插件标签页")

　　那么学习开发插件有什么意义呢？我们为什么要来学习插件开发呢？个人总结下，有以下几方面的意义：

*   增强浏览器功能，实现属于自己的定制插件功能
*   了解现有的插件，对其功能进行优化改进

[](#获取插件 "获取插件")获取插件[](#获取插件)
-----------------------------

　　大多数 Chrome 用户从 [Chrome 网上应用店](https://chrome.google.com/webstore)获得插件程序。世界各地的开发人员会在 Chrome 网上应用店中发布他们的插件，经过 Chrome 的审查并向最终用户提供。

　　但是由于一些众所周知的原因，我们并不能访问网上应用店，但同时 Chrome 又要求插件必须从它的 Chrome 应用商店下载安装，这仿佛是一个绕不开的死循环，不过俗话说`魔高一尺道高一尺一`，下面我们会讲解如何从本地加载插件，绕开网上应用店的限制。

[](#插件如何工作？ "插件如何工作？")插件如何工作？[](#插件如何工作？)
-----------------------------------------

　　插件是基于 Web 技术构建的，例如 HTML、JavaScript 和 CSS。它们在单独的沙盒执行环境中运行并与 Chrome 浏览器进行交互。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　插件允许我们通过使用 API 修改浏览器行为和访问 Web 内容来扩展和增强浏览器的功能。插件通过最终用户 UI 和开发人员 API 进行操作：

*   扩展用户界面，这为用户提供了一种一致的方式来管理他们的扩展。
*   扩展的 API 允许浏览器本身的扩展的代码访问功能：激活标签，修改网络请求等等。

　　要创建插件程序，我们需要组合构成插件程序的一些资源清单，例如 JS 文件和 HTML 文件、图像等。对于开发和测试，可以使用扩展开发者模式将这些 “解压” 加载到 Chrome 中。如果我们对自己开发出来的插件程序感到满意，就可以通过网上商店将其打包并分享给其他的用户。

[](#插件的原则 "插件的原则")插件的原则[](#插件的原则)
---------------------------------

　　我们编写的插件想要发布到`Chrome网上应用店`中，就必须遵守网上应用店政策，它规定了以下几点：

*   插件必须满足一个定义狭窄且易于理解的单一目的。单个插件可以包含多个组件和一系列功能，只要一切都有助于实现一个共同的目的。
*   用户界面应该是最小的并且有意图。它们的范围可以从简单的图标到打开一个带有表单的新窗口。

　　Chrome 插件并没有很严格的项目结构要求，比如 src、public、components 等等，因此我们如果去看很多插件的源码，会发现每个插件的项目结构，甚至项目下的文件名称都大相径庭；但是在根目录下我们都会找到一个`manifest.json`文件，这是插件的配置文件，说明了插件的各种信息；它的作用等同于小程序的 app.json 和前端项目的 package.json。

　　我们在项目中创建一个最简单的`manifest.json`配置文件：

<table><tbody><tr><td></td><td><pre>{
    
    "name": "Hello Extensions",
    
    "description" : "Base Level Extension",
    
    "version": "1.0",
    
    "manifest_version": 2
}

</pre></td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　我们经常会点击右上角插件图标时弹出一个小窗口的页面，焦点离开时就关闭了，一般做一些临时性的交互操作；在配置文件中新增`browser_action`字段，配置 popup 弹框：

<table><tbody><tr><td></td><td><pre>{
    "name": "Hello Extensions",
    "description" : "Base Level Extension",
    "version": "1.0",
    "manifest_version": 2,
    
    "browser_action": {
      "default_popup": "popup.html",
      "default_icon": "popup.png"
    }
}

</pre></td></tr></tbody></table>

　　然后创建我们的弹框页面 popup.html：

<table><tbody><tr><td></td><td><pre>&lt;html&gt;
  &lt;body&gt;
    &lt;h1&gt;Hello Extensions&lt;/h1&gt;
  &lt;/body&gt;
&lt;/html&gt;

</pre></td></tr></tbody></table>

　　点击图标后，插件显示 popup.html。

[![](https://xieyufei.com/images/Chrome-Plugin/load3.png)](https://xieyufei.com/images/Chrome-Plugin/load3.png "弹框页面")

[弹框页面](https://xieyufei.com/images/Chrome-Plugin/load3.png "弹框页面")

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　为了用户方便点击，我们还可以在 manifest.json 中设置一个键盘快捷键的命令，通过快捷键来弹出 popup 页面：

```
{
  "name": "Hello Extensions",
  "description" : "Base Level Extension",
  "version": "1.0",
  "manifest_version": 2,
  "browser_action": {
    "default_popup": "popup.html",
    "default_icon": "popup.png"
  },
  
  "commands": {
    "_execute_browser_action": {
      "suggested_key": {
        "default": "Ctrl+Shift+F",
        "mac": "MacCtrl+Shift+F"
      },
      "description": "Opens popup.html"
    }
  }
}
```

　　这样我们的插件就可以通过按键盘上的`Ctrl+Shift+F`来弹出。

[](#加载及调试插件 "加载及调试插件")加载及调试插件[](#加载及调试插件)
-----------------------------------------

　　我们开发的插件需要在浏览器里面运行，打开`插件标签页`，打开`开发者模式`，点击`加载已解压的扩展程序`，选择项目文件夹，就可将开发中的插件加载进来。

[![](https://xieyufei.com/images/Chrome-Plugin/load1.png)](https://xieyufei.com/images/Chrome-Plugin/load1.png "加载插件")

[加载插件](https://xieyufei.com/images/Chrome-Plugin/load1.png "加载插件")

> 开发中更改了代码，点击插件右下角刷新按钮即可重新加载

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　如果我们的代码中有错误，加载插件后，会显示红色的`错误按钮`：

[![](https://xieyufei.com/images/Chrome-Plugin/load-error.png)](https://xieyufei.com/images/Chrome-Plugin/load-error.png "插件加载错误")

[插件加载错误](https://xieyufei.com/images/Chrome-Plugin/load-error.png "插件加载错误")

　　点击错误按钮以查看错误的日志：

[![](https://xieyufei.com/images/Chrome-Plugin/error-detail.png)](https://xieyufei.com/images/Chrome-Plugin/error-detail.png "错误日志")

[错误日志](https://xieyufei.com/images/Chrome-Plugin/error-detail.png "错误日志")

　　我们上面说过 Chrome 插件只能从网上应用店中下载安装，但是第三方平台也提供了下载的渠道，下载下来的文件后缀是`.crx`的压缩包，现在的问题就是如何将 crx 文件进行安装了。

　　从 Chrome 73 版本开始，谷歌修改了插件策略，不可以随意安装 crx 文件：如果直接将 crx 文件拖拽安装可能会提示一下报错：

<table><tbody><tr><td></td><td><pre>程序包无效："CRX_HEADER_INVALID"

</pre></td></tr></tbody></table>

　　我们可以尝试以下几种方法，第一种方法：将 crx 后缀改为 zip，解压后`加载已解压的扩展程序`的方式，将插件用开发者模式进行加载。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　第二种办法，通过`Chrome插件伴侣`，将 crx 提取到桌面，然后还是用开发者模式进行加载。

[![](https://xieyufei.com/images/Chrome-Plugin/partner.png)](https://xieyufei.com/images/Chrome-Plugin/partner.png "Chrome插件伴侣")

[Chrome 插件伴侣](https://xieyufei.com/images/Chrome-Plugin/partner.png "Chrome插件伴侣")

　　使用插件伴侣提取插件后，插件内容默认会被放在你的电脑桌面上，可以把它剪切 / 复制到任意位置；加载插件选择的文件夹路径时，一定要包含 manifest.json 文件；加载后请勿删除提取的文件夹。

　　第三种方法就是用梯子了，直接去网上应用店下载，没有梯子的同学可以使用插件伴侣进行代理，插件伴侣的获取方式下文会给出。

[](#后台background "后台background")后台 background[](#后台background)
--------------------------------------------------------------

　　我们的插件安装后，popup 页面也运行了；但是我们也发现了，popup 页面只能做临时性的交互操作，用完就关了，不能存储信息或者和其他标签页进行交互等等；这时就需要用到 background（后台），它是一个常驻的页面，它的生命周期是插件中所有类型页面中最长的；它随着浏览器的打开而打开，随着浏览器的关闭而关闭，所以通常把需要一直运行的、启动就运行的、全局的代码放在 background 里面。

　　background 也是需要在`manifest.json`中进行配置，可以通过`page`指定一张网页，或者通过`scripts`直接指定一个 js 数组，Chrome 会自动为 js 生成默认网页：

<table><tbody><tr><td></td><td><pre>{
  "background": {
    
    "scripts": ["background.js"],
    "persistent": true
  }
}

</pre></td></tr></tbody></table>

　　**需要注意**的是，page 属性和 scripts 属性只需要配置一个即可，如果两个同时配置，则会报以下错误信息：

<table><tbody><tr><td></td><td><pre>Only one of 'background.page', 'background.scripts', and 'background.service_worker' can be specified.

</pre></td></tr></tbody></table>

　　我们给 background 设置一个监听事件，当插件安装时打印日志：

<table><tbody><tr><td></td><td><pre>chrome.runtime.onInstalled.addListener(function () {
  console.log("插件已被安装");
});

</pre></td></tr></tbody></table>

　　点击`查看视图`旁边的`背景页`，看到我们设置的 background：

[![](https://xieyufei.com/images/Chrome-Plugin/background.png)](https://xieyufei.com/images/Chrome-Plugin/background.png "背景页")

[背景页](https://xieyufei.com/images/Chrome-Plugin/background.png "背景页")

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[](#storage存储 "storage存储")storage 存储[](#storage存储)
--------------------------------------------------

　　我们在插件安装时在 storage 中设置一个值，这将允许多个插件组件访问该值并进行更新操作：

```
chrome.runtime.onInstalled.addListener(function () {
  
  chrome.storage.sync.set({ color: "#3aa757" }, function () {
    console.log("storage init color value");
  });
  
  chrome.declarativeContent.onPageChanged.removeRules(undefined, function () {
    chrome.declarativeContent.onPageChanged.addRules([
      {
        conditions: [
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { hostEquals: "baidu.com" },
          }),
        ],
        actions: [new chrome.declarativeContent.ShowPageAction()],
      },
    ]);
  });
});
```

　　`chrome.declarativeContent`用于精确地控制什么时候显示我们的页面按钮，或者需要在用户单击它之前更改它的外观以匹配当前标签页。

　　这里调用的 chrome.storage 和我们常用的 localStorage 和 sessionStorage 不是一个东西；由于调用到了 storage 和 declarativeContent 的 API，因此我们需要在 manifest 中给插件注册使用的权限：

<table><tbody><tr><td></td><td><pre>{
  
  "permissions": ["storage", "declarativeContent"],
  "background": {
    "scripts": ["background.js"],
    "persistent": true
  }
}

</pre></td></tr></tbody></table>

　　再次查看背景页的视图，我们就能看到打印的日志了；既然可以存储，那也能取出来，我们在 popup 中添加事件进行获取，首先我们新增一个触发的 button：

<table><tbody><tr><td></td><td><pre>&lt;html&gt;
  &lt;head&gt;
    &lt;style&gt;
      button {
        width: 60px;
        height: 30px;
        outline: none;
      }
    &lt;/style&gt;
  &lt;/head&gt;
  &lt;body&gt;
    &lt;button&gt;change&lt;/button&gt;
    &lt;script src="popup.js"&gt;&lt;/script&gt;
  &lt;/body&gt;
&lt;/html&gt;

</pre></td></tr></tbody></table>

　　我们再创建一个`popup.js`的文件，用来从 storage 存储中拿到颜色值，并将此颜色作为按钮的背景色：

<table><tbody><tr><td></td><td><pre>let changeColor = document.getElementById("changeColor");

changeColor.onclick = function (el) {
  chrome.storage.sync.get("color", function (data) {
    changeColor.style.backgroundColor = data.color;
  });
};
</pre></td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

> 如果需要调试 popup 页面，可以在弹框中右击 => 检查，在 DevTools 中进行调试查看。

　　我们多次打开 popup 页面，发现页面每次点开按钮都会恢复最开始的默认状态。

[![](https://xieyufei.com/images/Chrome-Plugin/storage.gif)](https://xieyufei.com/images/Chrome-Plugin/storage.gif "storage存储值")

[storage 存储值](https://xieyufei.com/images/Chrome-Plugin/storage.gif "storage存储值")

[](#获取浏览器tabs "获取浏览器tabs")获取浏览器 tabs[](#获取浏览器tabs)
--------------------------------------------------

　　现在，我们获取到了 storage 中的值，需要逻辑来进一步与用户交互；更新 popup.js 中的交互代码：

<table><tbody><tr><td></td><td><pre>changeColor.onclick = function (el) {
  chrome.storage.sync.get("color", function (data) {
    let { color } = data;
    chrome.tabs.query({ active: true, currentWindow: true }, function (tabs) {
      chrome.tabs.executeScript(tabs[0].id, {
        code: 'document.body.style.backgroundColor = "' + color + '";',
      });
    });
  });
};

</pre></td></tr></tbody></table>

　　`chrome.tabs`的 API 主要是和浏览器的标签页进行交互，通过`query`找到当前的激活中的 tab，然后使用`executeScript`向标签页注入脚本内容。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　manifest 同样需要`activeTab`的权限，来允许我们的插件使用`tabs`的 API。

<table><tbody><tr><td></td><td><pre>{
  "name": "Hello Extensions",
  
  "permissions": ["storage", "declarativeContent", "activeTab"],
}

</pre></td></tr></tbody></table>

　　重新加载插件，我们点击按钮，会发现当前页面的背景颜色已经变成 storage 中设置的色值了；但是某些用户可能希望使用不同的色值，我们给用户提供选择的机会。

[](#颜色选项页面 "颜色选项页面")颜色选项页面[](#颜色选项页面)
-------------------------------------

　　现在我们的插件功能还比较单一，只能让用户选择唯一的颜色；我们可以在插件中加入选项页面，以便用户更好的自定义插件的功能。

　　在程序目录新增一个 options.html 文件：

```
<!DOCTYPE html>
<html>
  <head>
    <style>
      button {
        height: 30px;
        width: 30px;
        outline: none;
        margin: 10px;
      }
    </style>
  </head>
  <body>
    <div></div>
    <div>
      <p>选择一个不同的颜色</p>
    </div>
  </body>
  <script src="options.js"></script>
</html>
```

　　然后添加选择页面的逻辑代码`options.js`：

<table><tbody><tr><td></td><td><pre>let page = document.getElementById("buttonDiv");
const kButtonColors = ["#3aa757", "#e8453c", "#f9bb2d", "#4688f1"];
function constructOptions(kButtonColors) {
  for (let item of kButtonColors) {
    let button = document.createElement("button");
    button.style.backgroundColor = item;
    button.addEventListener("click", function () {
      chrome.storage.sync.set({ color: item }, function () {
        console.log("color is " + item);
      });
    });
    page.appendChild(button);
  }
}
constructOptions(kButtonColors);

</pre></td></tr></tbody></table>

　　上面代码中预设了四个颜色选项，通过 onclick 事件监听，生成页面上的按钮；当用户单击按钮时，将更新 storage 中存储的颜色值。

　　options 页面完成后，我们可以将其在 manifest 的`options_page`进行注册：

<table><tbody><tr><td></td><td><pre>{
  "name": "Hello Extensions",
  
  "options_page": "options.html",
  
  "manifest_version": 2
}

</pre></td></tr></tbody></table>

　　重新加载我们的插件，点击详情，滚动到底部，点击`扩展程序选项`来查看选项页面。

[![](https://xieyufei.com/images/Chrome-Plugin/options.png)](https://xieyufei.com/images/Chrome-Plugin/options.png "选项页面")

[选项页面](https://xieyufei.com/images/Chrome-Plugin/options.png "选项页面")

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　或者可以在浏览器右上角插件图标上`右击 => 选项`。

　　通过上面一个简单的小插件，相信大家对插件的功能和组件都有了一个大致的了解，知道了每个组件在其中发挥的作用；但这还只是插件的一小部分功能，下面我们对插件每个部分的功能以及组件做一个更深入的了解。

[](#使用background管理事件 "使用background管理事件")使用 background 管理事件[](#使用background管理事件)
-------------------------------------------------------------------------------

　　background 是插件的事件处理程序，它包含对插件很重要的浏览器事件的监听器。background 处于休眠状态，直到触发事件，然后执行指示的逻辑；一个好的 background 仅在需要时加载，并在空闲时卸载。

[![](https://xieyufei.com/images/Chrome-Plugin/background-action.png)](https://xieyufei.com/images/Chrome-Plugin/background-action.png "background和popup交互")

[background 和 popup 交互](https://xieyufei.com/images/Chrome-Plugin/background-action.png "background和popup交互")

　　background 监听的一些浏览器事件包括：

*   插件程序首次安装或更新为新版本。
*   后台页面正在监听事件，并且已调度该事件
*   内容脚本或其他插件发送消息
*   插件中的另一个视图（例如弹出窗口）调用 runtime.getBackgroundPage

　　加载完成后，只要触发某个事件，background 就会保持运行状态；在上面 manifest 中，我们还指定了一个`persistent`属性：

<table><tbody><tr><td></td><td><pre>{
  "background": {
    "scripts": ["background.js"],
    "persistent": true
  }
}

</pre></td></tr></tbody></table>

　　`persistent`属性定义了插件常驻后台的方式；当其值为 true 时，表示插件将一直在后台运行，无论其是否正在工作；当其值为 false 时，表示插件在后台按需运行，这就是 Chrome 后来提出的`Event Page`（非持久性后台）。`Event Page`是基于事件驱动运行的，只有在事件发生的时候才可以访问；这样做的目的是为了能够有效减小插件对内存的消耗，如非必要，请将 persistent 设置为 false。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

> persistent 属性的默认值为 true

### [](#alarms "alarms")alarms[](#alarms)

　　一些基于 DOM 页面的计时器（例如 window.setTimeout 或 window.setInterval），如果在非持久后台休眠时进行了触发，可能不会按照预定的时间运行：

<table><tbody><tr><td></td><td><pre>let timeout = 1000 * 60 * 3;  
window.setTimeout(function() {
  alert('Hello, world!');
}, timeout);

</pre></td></tr></tbody></table>

　　Chrome 提供了另外的 API，alarms：

<table><tbody><tr><td></td><td><pre>chrome.alarms.create({delayInMinutes: 3.0})

chrome.alarms.onAlarm.addListener(function() {
  alert("Hello, world!")
});
</pre></td></tr></tbody></table>

[](#browserAction "browserAction")browserAction[](#browserAction)
-----------------------------------------------------------------

　　我们知道了 browser_action 字段用来配置 popup 的页面，在其他的一些文档中还给出了`page_action`字段的配置，不过 page_action 并不是所有的页面都能够使用；不过随着 Chrome 的版本更新，这两者的功能也越来越相近；在 Chrome 48 版本之后，page_action 也从原来的地址栏中移出来，和插件放在一起；笔者在配置`page_action`的时候没有发现有什么比较大的区别，因此下面以 browser_action 为主。

　　在 browserAction 的配置中，我们可以提供多种尺寸的图标，Chrome 会选择最接近的图标并将其缩放到适当的大小来填充；如果没有提供确切的大小，这种缩放会导致图标丢失细节或看起来模糊。

<table><tbody><tr><td></td><td><pre>{
  
  "browser_action": {
    "default_icon": {                
      "16": "images/icon16.png",     
      "24": "images/icon24.png",     
      "32": "images/icon32.png"      
    },
    "default_title": "hello popup",  
    "default_popup": "popup.html"    
  },
}

</pre></td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　也可以通过调用`browserAction.setPopup`动态设置弹出窗口。

<table><tbody><tr><td></td><td><pre>chrome.browserAction.setPopup({popup: 'popup_new.html'});

</pre></td></tr></tbody></table>

### [](#Tooltip "Tooltip")Tooltip[](#Tooltip)

　　要设置提示文案，使用 default_title 字段，或者调用`browserAction.setTitle`函数。

<table><tbody><tr><td></td><td><pre>chrome.browserAction.setTitle({ title: "New Tooltip" });

</pre></td></tr></tbody></table>

[![](https://xieyufei.com/images/Chrome-Plugin/tooltip.png)](https://xieyufei.com/images/Chrome-Plugin/tooltip.png "Tooltip")

[Tooltip](https://xieyufei.com/images/Chrome-Plugin/tooltip.png "Tooltip")

### [](#Badge "Badge")Badge[](#Badge)

　　Badge（徽章）就是在图标上显示的一些文本内容，用来详细显示插件的提示信息；由于 Bage 的空间有限，因此最多显示 4 个英文字符或者 2 个函数；badge 无法通过配置文件来指定，必须通过代码实现，设置 badge 文字和颜色可以分别使用`browserAction.setBadgeText()`和`browserAction.setBadgeBackgroundColor()`：

<table><tbody><tr><td></td><td><pre>chrome.browserAction.setBadgeText({ text: "new" });
chrome.browserAction.setBadgeBackgroundColor({ color: [255, 0, 0, 255] });



</pre></td></tr></tbody></table>

[![](https://xieyufei.com/images/Chrome-Plugin/badge.png)](https://xieyufei.com/images/Chrome-Plugin/badge.png "Badge")

[Badge](https://xieyufei.com/images/Chrome-Plugin/badge.png "Badge")

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[](#content-scripts "content-scripts")content-scripts[](#content-scripts)
-------------------------------------------------------------------------

　　content-scripts（内容脚本）是在网页上下文中运行的文件。通过使用标准的文档对象模型 (DOM)，它能够读取浏览器访问的网页的详细信息，对其进行更改，并将信息传递给其父级插件。内容脚本相对于 background 还是有一些访问 API 上的限制，它可以直接访问以下 chrome 的 API：

*   i18n
*   storage
*   runtime:
    *   connect
    *   getManifest
    *   getURL
    *   id
    *   onConnect
    *   onMessage
    *   sendMessage

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　内容脚本运行于一个独立、隔离的环境，它不会和`主页面的脚本`或者`其他插件的内容脚本`发生冲突，当然也不能调用其上下文和变量。假设我们在主页面中定义了变量和函数：

<table><tbody><tr><td></td><td><pre>&lt;html lang="en"&gt;
  &lt;head&gt;
    &lt;title&gt;Document&lt;/title&gt;
  &lt;/head&gt;
  &lt;body&gt;
    &lt;script&gt;
      const a = { a: 1, b: "2" };
      const b = { a: 1, b: "2", c: [] };
      function add(a, b){ return a + b };
    &lt;/script&gt;
  &lt;/body&gt;
&lt;/html&gt;

</pre></td></tr></tbody></table>

　　由于隔离的机制，在内容脚本中调用 add 函数会报错：Uncaught ReferenceError: add is not defined。

　　内容脚本分为以代码方式或声明方式注入。

### [](#代码方式注入 "代码方式注入")代码方式注入[](#代码方式注入)

　　对于需要在特定情况下运行的代码，我们需要使用代码注入的方式；在上面的 popup 页面中，我们就是将内容脚本以代码的方式进行注入到页面中：

<table><tbody><tr><td></td><td><pre>chrome.tabs.executeScript(tabs[0].id, {
  code: 'document.body.style.backgroundColor = "red";',
});

</pre></td></tr></tbody></table>

　　或者可以注入整个文件。

<table><tbody><tr><td></td><td><pre>chrome.tabs.executeScript(tabs[0].id, {
  file: "contentScript.js",
});

</pre></td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

### [](#声明式注入 "声明式注入")声明式注入[](#声明式注入)

　　在指定页面上自动运行的内容脚本，我们可使用声明式注入的方式；以声明方式注入的脚本需注册在 manifest 文件的`content_scripts`属性下。它们可以包括 JS 文件或 CSS 文件。

<table><tbody><tr><td></td><td><pre>{
  "content_scripts": [
    {
      
      "matches": ["https://*.xieyufei.com/*"],
      "css": ["myStyles.css"],
      "js": ["contentScript.js"]
    }
  ]
}

</pre></td></tr></tbody></table>

　　声明式注入除了 matches 必须外，还可以包含以下字段，来自定义指定页面匹配：

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

<table><thead><tr><th>Name</th><th>Type</th><th>Description</th></tr></thead><tbody><tr><td>exclude_matches</td><td>字符串数组</td><td>可选。排除此内容脚本将被注入的页面。</td></tr><tr><td>include_globs</td><td>字符串数组</td><td>可选。 在 matches 后应用，以匹配与此 glob 匹配的 URL。旨在模拟 @exclude 油猴关键字。</td></tr><tr><td>exclude_globs</td><td>字符串数组</td><td>可选。 在 matches 后应用，以排除与此 glob 匹配的 URL。旨在模拟 @exclude 油猴关键字。</td></tr></tbody></table>

　　声明匹配 URL 可以使用 Glob 属性，Glob 属性遵循更灵活的语法。可接受的 Glob 字符串可能包含 “通配符” 星号和问号的 URL。星号`*`匹配任意长度的字符串，包括空字符串，而问号`？`匹配任何单个字符。

<table><tbody><tr><td></td><td><pre>{
  "content_scripts": [
    {
      "matches": ["https://*.xieyufei.com/*"],
      "exclude_matches": ["*://*/*business*"],
      "include_globs": ["*xieyufei.com/???s/*"],
      "exclude_globs": ["*science*"],
      "js": ["contentScript.js"]
    }
  ]
}

</pre></td></tr></tbody></table>

　　将 JS 文件注入网页时，还需要控制文件注入的时机，由`run_at`字段控制；首选的默认字段是`document_idle`，但如果需要，也可以指定为 “document_start” 或 “document_end”。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

<table><tbody><tr><td></td><td><pre>{
  "content_scripts": [
    {
      "matches": ["https://*.xieyufei.com/*"],
      "run_at": "document_idle",
      "js": ["contentScript.js"]
    }
  ]
}

</pre></td></tr></tbody></table>

　　三个字段注入的时机区别如下：

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

<table><thead><tr><th>Name</th><th>Type</th><th>Description</th></tr></thead><tbody><tr><td>document_idle</td><td>string</td><td>首选。 尽可能使用 “document_idle”。浏览器选择一个时间在 “document_end” 和 window.onload 事件触发后立即注入脚本。 注入的确切时间取决于文档的复杂程度以及加载所需的时间，并且已针对页面加载速度进行了优化。在 “document_idle” 上运行的内容脚本不需要监听 window.onload 事件，因此可以确保它们在 DOM 完成之后运行。如果确实需要在 window.onload 之后运行脚本，则扩展可以使用 document.readyState 属性检查 onload 是否已触发。</td></tr><tr><td>document_start</td><td>string</td><td>在 css 文件之后，但在构造其他 DOM 或运行其他脚本前注入。</td></tr><tr><td>document_end</td><td>string</td><td>在 DOM 创建完成后，但在加载子资源（例如 images 和 frames ）之前，立即注入脚本。</td></tr></tbody></table>

### [](#消息通信 "消息通信")消息通信[](#消息通信)

　　尽管内容脚本的执行环境和托管它们的页面是相互隔离的，但是它们共享对页面 DOM 的访问；如果内容脚本想要和插件通信，可以通过`onMessage`和`sendMessage`

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

<table><tbody><tr><td></td><td><pre>chrome.runtime.onMessage.addListener(function (message, sender, sendResponse) {
  console.log("content-script收到的消息", message);
  sendResponse("我收到了你的消息！");
});

chrome.runtime.sendMessage(
  { greeting: "我是content-script呀，我主动发消息给后台！" },
  function (response) {
    console.log("收到来自后台的回复：" + response);
  }
);
</pre></td></tr></tbody></table>

　　更多消息通信的在后面我们会进行详细的总结。

　　contextMenus 可以自定义浏览器的右键菜单（也有叫上下文菜单的），主要是通过`chrome.contextMenus`API 实现；在 manifest 中添加权限来开启菜单权限：

<table><tbody><tr><td></td><td><pre>{
  
  "permissions": ["contextMenus"],
  "icons": {
    "16": "contextMenus16.png",
    "48": "contextMenus48.png",
    "128": "contextMenus128.png"
   }
}

</pre></td></tr></tbody></table>

　　通过`icons`字段配置 contextMenus 菜单旁边的图标：

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[![](https://xieyufei.com/images/Chrome-Plugin/context-menu.png)](https://xieyufei.com/images/Chrome-Plugin/context-menu.png "ContextMenu")

[ContextMenu](https://xieyufei.com/images/Chrome-Plugin/context-menu.png "ContextMenu")

　　我们可以在 background 中调用`contextMenus.create`来创建菜单，这个操作应该在`runtime.onInstalled`监听回调执行：

```
chrome.contextMenus.create({
  id: "1",
  title: "Test Context Menu",
  contexts: ["all"],
});

chrome.contextMenus.create({
  type: "separator",
});

chrome.contextMenus.create({
  id: "2",
  title: "Parent Context Menu",
  contexts: ["all"],
});
chrome.contextMenus.create({
  id: "21",
  parentId: "2",
  title: "Child Context Menu1",
  contexts: ["all"],
});
```

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　如果我们的插件创建多个右键菜单，则 Chrome 会自动将其折叠为一个父菜单。

[![](https://xieyufei.com/images/Chrome-Plugin/multi-context-menu.png)](https://xieyufei.com/images/Chrome-Plugin/multi-context-menu.png "多级右键菜单")

[多级右键菜单](https://xieyufei.com/images/Chrome-Plugin/multi-context-menu.png "多级右键菜单")

　　contextMenus 创建对象的属性可以在附录里面找到；我们看到在 title 属性中有一个`%s`的标识符，当 contexts 为 selection，使用`%s`来表示选中的文字；我们通过这个功能可以实现一个选中文字调用百度搜索的小功能：

<table><tbody><tr><td></td><td><pre>chrome.contextMenus.create({
  id: "1",
  title: "使用百度搜索：%s",
  contexts: ["selection"],
  onclick: function (params) {
    chrome.tabs.create({
      url:
        "https://www.baidu.com/s?ie=utf-8&amp;wd=" +
        encodeURI(params.selectionText),
    });
  },
});

</pre></td></tr></tbody></table>

　　效果如下：

[![](https://xieyufei.com/images/Chrome-Plugin/search.png)](https://xieyufei.com/images/Chrome-Plugin/search.png "百度搜索小功能")

[百度搜索小功能](https://xieyufei.com/images/Chrome-Plugin/search.png "百度搜索小功能")

　　contextMenus 还有一些 API 可以调用：

<table><tbody><tr><td></td><td><pre>chrome.contextMenus.remove(menuItemId)；

chrome.contextMenus.removeAll();

chrome.contextMenus.update(menuItemId, updateProperties);

chrome.contextMenus.onClicked.addListener(function(OnClickData info, tabs.Tab tab) {...});

</pre></td></tr></tbody></table>

[](#override "override")override[](#override)
---------------------------------------------

　　覆盖页面（override）是一种将 Chrome 默认的特定页面替换为插件程序中的 HTML 文件。除了 HTML 之外，覆盖页面通常还有 CSS 和 JS 代码；插件可以替换以下 Chrome 的页面。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

*   书签管理器
    *   当用户从 Chrome 菜单中选择书签管理器菜单项或在 Mac 上从书签菜单中选择书签管理器项时出现的页面。您也可以通过输入 URL chrome://bookmarks 来访问此页面。
*   历史记录
    *   当用户从 Chrome 菜单中选择历史记录菜单项或在 Mac 上从历史记录菜单中选择显示完整历史记录项时出现的页面。您也可以通过输入 URL chrome://history 来访问此页面。
*   新标签
    *   当用户创建新标签或窗口时出现的页面。您也可以通过输入 URL chrome://newtab 来访问此页面。

　　PS：像我们熟知的 Momentum 插件，就是覆盖了新标签页面。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

> 需要注意的是：单个插件只能覆盖某一个页面。例如，插件程序不能同时覆盖书签管理器和历史记录页面。

　　在 manifest 进行如下配置：

<table><tbody><tr><td></td><td><pre>{
  "chrome_url_overrides": {
    "newtab": "newtab.html",
    
    
  }
}

</pre></td></tr></tbody></table>

　　覆盖 newtab 效果如下：

[![](https://xieyufei.com/images/Chrome-Plugin/override.png)](https://xieyufei.com/images/Chrome-Plugin/override.png "覆盖newtab")

[覆盖 newtab](https://xieyufei.com/images/Chrome-Plugin/override.png "覆盖newtab")

　　如果我们覆盖多个特定页面，Chrome 加载插件时会直接报错：

[![](https://xieyufei.com/images/Chrome-Plugin/override-more.png)](https://xieyufei.com/images/Chrome-Plugin/override-more.png "覆盖多个页面报错")

[覆盖多个页面报错](https://xieyufei.com/images/Chrome-Plugin/override-more.png "覆盖多个页面报错")

[](#storage "storage")storage[](#storage)
-----------------------------------------

　　用户在操作时，会产生一些用户数据，插件需要在本地存储这些数据，在需要调用的时候再拿出来；Chrome 推荐使用`chrome.storage`的 API，该 API 经过优化，提供和 localStorage 相同的存储功能；不推荐直接存在`localStorage`中，两者主要有以下区别：

*   用户数据使用 chrome.storage 存储可以和 Chrome 的同步功能自动同步。
*   插件的内容脚本可以直接访问用户数据，而无需 background。
*   chrome.storage 可以直接存储对象，而 localStorage 是存储字符串，需要再次转换

　　如果要使用 storage 的自动同步，我们可以使用`storage.sync`：

<table><tbody><tr><td></td><td><pre>chrome.storage.sync.set({key: value}, function() {
  console.log('Value is set to ' + value);
});

chrome.storage.sync.get(['key'], function(result) {
  console.log('Value currently is ' + result.key);
});
</pre></td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　当 Chrome 离线时，Chrome 会将数据存储在本地。下次浏览器在线时，Chrome 会同步数据。即使用户禁用同步，storage.sync 仍将工作。

　　不需要同步的数据可以用`storage.local`进行存储：

<table><tbody><tr><td></td><td><pre>chrome.storage.local.set({key: value}, function() {
  console.log('Value is set to ' + value);
});

chrome.storage.local.get(['key'], function(result) {
  console.log('Value currently is ' + result.key);
});
</pre></td></tr></tbody></table>

　　如果我们想要监听 storage 中的数据变化，可以用`onChanged`添加监听事件；每当存储中的数据发生变化时，就会触发该事件：

<table><tbody><tr><td></td><td><pre>chrome.storage.onChanged.addListener(function (changes, namespace) {
  for (let [key, { oldValue, newValue }] of Object.entries(changes)) {
    console.log(
      `Storage key "${key}" in namespace "${namespace}" changed.`,
      `Old value was "${oldValue}", new value is "${newValue}".`
    );
  }
});
</pre></td></tr></tbody></table>

　　用过 Vue 或者 React 的 devtools 的童鞋应该见过这样新增的扩展面板：

[![](https://xieyufei.com/images/Chrome-Plugin/dev-vue.png)](https://xieyufei.com/images/Chrome-Plugin/dev-vue.png "Vue Panel")

[Vue Panel](https://xieyufei.com/images/Chrome-Plugin/dev-vue.png "Vue Panel")

　　DevTools 可以为 Chrome 的 DevTools 添加功能，它可以添加新的 UI 面板和侧边栏，与检查的页面交互，获取有关网络请求的信息等等；它可以访问以下特定的 API：

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

*   devtools.inspectedWindow
*   devtools.network
*   devtools.panels

　　DevTools 扩展的结构与任何其他扩展一样：它可以有一个背景页面、内容脚本和其他项目。此外，每个 DevTools 扩展都有一个 DevTools 页面，可以访问 DevTools 的 API。

[![](https://xieyufei.com/images/Chrome-Plugin/devtools.png)](https://xieyufei.com/images/Chrome-Plugin/devtools.png "DevTools扩展")

[DevTools 扩展](https://xieyufei.com/images/Chrome-Plugin/devtools.png "DevTools扩展")

　　配置 devtools 不需要权限，只要在 manifest 中配置一个`devtools.html`：

<table><tbody><tr><td></td><td><pre>{
  "devtools_page": "devtools.html",
}

</pre></td></tr></tbody></table>

　　devtools.html 中只引用了 devtools.js，如果写了其他内容也不会展示：

<table><tbody><tr><td></td><td><pre>&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;
  &lt;head&gt; &lt;/head&gt;
  &lt;body&gt;
    &lt;script type="text/javascript" src="./devtools.js"&gt;&lt;/script&gt;
  &lt;/body&gt;
&lt;/html&gt;

</pre></td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　在项目中新建`devtools.js`：

```
chrome.devtools.panels.create(
  
  "DevPanel",
  
  "panel.png",
  
  "Panel.html",
  function (panel) {
    console.log("自定义面板创建成功！");
  }
);


chrome.devtools.panels.elements.createSidebarPane(
  "Sidebar",
  function (sidebar) {
    sidebar.setPage("sidebar.html");
  }
);
```

　　这里调用 create 创建扩展面板，createSidebarPane 创建侧边栏，每个扩展面板和侧边栏都是一个单独的 HTML 页面，其中可以包含其他资源（JavaScript、CSS、图像等）。

### [](#DevPanel "DevPanel")DevPanel[](#DevPanel)

　　DevPanel 面板是一个顶级标签，和 Element、Source、Network 等是同一级，在一个 devtools.js 可以创建多个；在`Panel.html`中我们先设置 2 个按钮：

<table><tbody><tr><td></td><td><pre>&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;
  &lt;head&gt;&lt;/head&gt;
  &lt;body&gt;
    &lt;div&gt;dev panel&lt;/div&gt;
    &lt;button&gt;检查jquery&lt;/button&gt;
    &lt;button&gt;获取所有资源&lt;/button&gt;
    &lt;script src="panel.js"&gt;&lt;/script&gt;
  &lt;/body&gt;
&lt;/html&gt;

</pre></td></tr></tbody></table>

　　panel.js 中我们使用`devtools.inspectedWindow`的 API 来和被检查窗口进行交互：

```
document.getElementById("check_jquery").addEventListener("click", function () {
  chrome.devtools.inspectedWindow.eval(
    "jQuery.fn.jquery",
    function (result, isException) {
      if (isException) {
        console.log("the page is not using jQuery");
      } else {
        console.log("The page is using jQuery v" + result);
      }
    }
  );
});

document
  .getElementById("get_all_resources")
  .addEventListener("click", function () {
    chrome.devtools.inspectedWindow.getResources(function (resources) {
      console.log(resources);
    });
  });
```

　　`eval`函数为插件提供了在被检查页面的上下文中执行 JS 代码的能力，而`getResources`获取页面上所有加载的资源；我们找到一个页面，然后右击检查打开调试工具，发现在最右侧多了一个`DevPanel`的 tab 页，点击我们的调试按钮，那么日志在哪里能看到呢？

　　我们在调试工具上右击检查，再开一个调试工具，这个就是调试工具的调试工具。。。。

[![](https://xieyufei.com/images/Chrome-Plugin/dolls.jpg)](https://xieyufei.com/images/Chrome-Plugin/dolls.jpg "禁止套娃")

[禁止套娃](https://xieyufei.com/images/Chrome-Plugin/dolls.jpg "禁止套娃")

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　最终两个调试工具的效果如下：

[![](https://xieyufei.com/images/Chrome-Plugin/dev-panel.png)](https://xieyufei.com/images/Chrome-Plugin/dev-panel.png "DevTools面板")

[DevTools 面板](https://xieyufei.com/images/Chrome-Plugin/dev-panel.png "DevTools面板")

　　回到 devtools.js，我们使用`createSidebarPane`创建了侧边栏面板，并且设置为`sidebar.html`，最终呈现在`Element`面板的最右侧：

[![](https://xieyufei.com/images/Chrome-Plugin/sidebar.png)](https://xieyufei.com/images/Chrome-Plugin/sidebar.png "侧边栏面板")

[侧边栏面板](https://xieyufei.com/images/Chrome-Plugin/sidebar.png "侧边栏面板")

　　有几种方法可以在侧边栏中显示内容：

*   HTML 内容。调用 setPage 以指定要在窗格中显示的 HTML 页面。
*   JSON 数据。将 JSON 对象传递给 setObject.
*   JavaScript 表达式。将表达式传递给 setExpression

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　通过 JS 表达式，我们可以很方便进行页面查询，比如，查询页面上所有的 img 元素：

<table><tbody><tr><td></td><td><pre>chrome.devtools.panels.elements.createSidebarPane(
  "All Images",
  function (sidebar) {
    sidebar.setExpression('document.querySelectorAll("img")', "All Images");
  }
);

</pre></td></tr></tbody></table>

[![](https://xieyufei.com/images/Chrome-Plugin/sidebar-img.png)](https://xieyufei.com/images/Chrome-Plugin/sidebar-img.png "展示所有图片")

[展示所有图片](https://xieyufei.com/images/Chrome-Plugin/sidebar-img.png "展示所有图片")

　　另外，我们可以通过`elements.onSelectionChanged`监听事件，在 Element 面板选中元素更改后，更新侧边栏面板的状态；例如，可以将我们关心的一些元素的样式进行实时展示在侧边面板，方面查看：

```
var page_getProperties = function () {
  if ($0 instanceof HTMLElement) {
    return {
      tag: $0.tagName.toLocaleLowerCase(),
      class: $0.classList,
      width: window.getComputedStyle($0)["width"],
      height: window.getComputedStyle($0)["height"],
      margin: window.getComputedStyle($0)["margin"],
      padding: window.getComputedStyle($0)["padding"],
      color: window.getComputedStyle($0)["color"],
      fontSize: window.getComputedStyle($0)["fontSize"],
    };
  } else {
    return {};
  }
};

chrome.devtools.panels.elements.createSidebarPane(
  "Select Element",
  function (sidebar) {
    function updateElementProperties() {
      sidebar.setExpression(
        "(" + page_getProperties.toString() + ")()",
        "select element"
      );
    }
    updateElementProperties();
    chrome.devtools.panels.elements.onSelectionChanged.addListener(
      updateElementProperties
    );
  }
);
```

[![](https://xieyufei.com/images/Chrome-Plugin/siderbar-select.gif)](https://xieyufei.com/images/Chrome-Plugin/siderbar-select.gif "元素样式实时展示")

[元素样式实时展示](https://xieyufei.com/images/Chrome-Plugin/siderbar-select.gif "元素样式实时展示")

[](#notifications "notifications")notifications[](#notifications)
-----------------------------------------------------------------

　　Chrome 提供`chrome.notifications`的 API 来推送桌面通知；同样也需要现在 manifest 中注册权限：

<table><tbody><tr><td></td><td><pre>{
  "permissions": [
    "notifications"
  ],
}

</pre></td></tr></tbody></table>

　　在 background 调用创建即可

<table><tbody><tr><td></td><td><pre>chrome.notifications.create(null, {
  type: "basic",
  iconUrl: "drink.png",
  title: "喝水小助手",
  message: "看到此消息的人可以和我一起来喝一杯水",
});

</pre></td></tr></tbody></table>

　　效果如下：

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[![](https://xieyufei.com/images/Chrome-Plugin/notifications.png)](https://xieyufei.com/images/Chrome-Plugin/notifications.png "消息推送")

[消息推送](https://xieyufei.com/images/Chrome-Plugin/notifications.png "消息推送")

　　根据 chrome.notifications 的 API，笔者做了一个[喝水小助手](https://github.com/acexyf/drink-helper)，和我一起成为一天八杯水的人吧！

> chrome.notifications 支持更多的属性详见附录。

[](#webRequest "webRequest")webRequest[](#webRequest)
-----------------------------------------------------

　　通过 webRequest 的 API 可以对浏览器发出的任何 HTTP 请求进行拦截、组织或者修改；可以拦截的请求还包括脚本、样式的 GET 请求以及图片的链接；我们也需要在 manifest 中配置权限才能使用 API：

<table><tbody><tr><td></td><td><pre>{
  
  "permissions": [
    "webRequest",
    "webRequestBlocking",
    "*://*.xieyufei.com/"
  ],
}

</pre></td></tr></tbody></table>

　　权限中还需要声明拦截请求的 URL，如果你想拦截所有的 URL，可以使用`*://*/*`（不过不推荐这么做，数据会非常多），如果我们想以阻塞方式使用 Web 请求 API，则需要用到`webRequestBlocking`权限。

　　比如我们可以对拦截的请求进行取消：

<table><tbody><tr><td></td><td><pre>chrome.webRequest.onBeforeRequest.addListener(
  function (detail) {
    return {cancel: details.url.indexOf("example.com") != -1};;
  },
  { urls: ["&lt;all_urls&gt;"] },
  ["blocking"]
);

</pre></td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　不同组件之间经常需要进行消息通信来进行数据的传递，我们来看下他们之间是如何进行通信的：

　　background 和 popup 之间的通信比较简单，在 popup 中，我们可以通过`extension.getBackgroundPage`直接获取到 background 对象，直接调用对象上的方法即可：

<table><tbody><tr><td></td><td><pre>var bg = chrome.extension.getBackgroundPage();
bg.someMethods()

</pre></td></tr></tbody></table>

　　而 background 访问 popup 上则通过`extension.getViews`来访问，不过前提是 popup 弹框已经展示，否则获取到的 views 是空数组：

<table><tbody><tr><td></td><td><pre>var views = chrome.extension.getViews({type:'popup'});
if(views.length &gt; 0) {
  
	console.log(views[0].location.href);
}

</pre></td></tr></tbody></table>

[](#background和内容脚本通信 "background和内容脚本通信")background 和内容脚本通信[](#background和内容脚本通信)
----------------------------------------------------------------------------------

　　在 background 和内容脚本通信，我们可以使用简单直接的`runtime.sendMessage`或者`tabs.sendMessage`发送消息，消息内容可以是 JSON 数据

　　从内容脚本发送消息如下：

<table><tbody><tr><td></td><td><pre>chrome.runtime.sendMessage(
  { greeting: "hello，我是content-script，主动发消息给后台！" },
  function (response) {
    console.log("收到来自后台的回复：" + response);
  }
);

</pre></td></tr></tbody></table>

　　而从后台发送消息到内容脚本时，由于有多个标签页，我们需要指定发送到某个标签页：

<table><tbody><tr><td></td><td><pre>chrome.tabs.query({ active: true, currentWindow: true }, function (tabs) {
  chrome.tabs.sendMessage(
    tabs[0].id,
    { greeting: "hello，我是后台，主动发消息给content-script" },
    function (response) {
      console.log(response.farewell);
    }
  );
});

</pre></td></tr></tbody></table>

　　而不管是在后台，还是在内容脚本中，我们都使用`runtime.onMessage`监听消息的接收事件，不同的是回调函数中的`sender`，标识不同的发送方：

<table><tbody><tr><td></td><td><pre>chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    console.log(sender.tab ?
      "from a content script:" + sender.tab.url :
      "from the extension");
    if (request.greeting.indexOf("hello") !== -1){
      sendResponse({farewell: "goodbye"});
    }
  });

</pre></td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[](#长链接 "长链接")长链接[](#长链接)
-------------------------

　　上面的`runtime.sendMessage`和`tabs.sendMessage`都属于短链接，所谓的短连接，就是类似于 HTTP 请求，如果接收方不在线，就会出现请求失败的情况；但有些情况下，需要持续对话，这时候就需要用到长链接，类似于 websocket，可以在通信双方之间进行持久链接。

　　长链接使用`runtime.connect`或`tabs.connect`来打开长生命周期通道，通道可以有一个名称，以便区分不同类型的连接。

<table><tbody><tr><td></td><td><pre>var port = chrome.runtime.connect({name: "knockknock"});
port.postMessage({joke: "Knock knock"});
port.onMessage.addListener(function(msg) {
  if (msg.question == "Who's there?")
    port.postMessage({answer: "Madame"});
  else if (msg.question == "Madame who?")
    port.postMessage({answer: "Madame... Bovary"});
});

</pre></td></tr></tbody></table>

　　从 background 向内容脚本发送消息也类似，不同之处在于需要指定连接的 tab 页，将`runtime.connect`改为`tabs.connect`。

　　在接收端，我们需要设置`onConnect`的事件监听器，当发送端调用`connect`进行连接时触发该事件，以及通过连接发送和接收消息的`port`对象：

<table><tbody><tr><td></td><td><pre>chrome.runtime.onConnect.addListener(function(port) {
  console.assert(port.name == "knockknock");
  port.onMessage.addListener(function(msg) {
    if (msg.joke == "Knock knock")
      port.postMessage({question: "Who's there?"});
    else if (msg.answer == "Madame")
      port.postMessage({question: "Madame who?"});
    else if (msg.answer == "Madame... Bovary")
      port.postMessage({question: "I don't get it."});
  });
});

</pre></td></tr></tbody></table>

　　介绍了这么多插件的开发，我们来介绍一下应用市场上的优秀插件，这些插件能够帮助我们在平时的开发中提高生产效率。

[](#Adblock-Plus "Adblock Plus")Adblock Plus[](#Adblock-Plus)
-------------------------------------------------------------

　　Adblock Plus 是一款可以屏蔽广告以及任何你想屏蔽元素的软件；它不仅内置了一些过滤规则，可以自动屏蔽广告，还可以自行添加屏蔽内容。

[![](https://xieyufei.com/images/Chrome-Plugin/adblock.png)](https://xieyufei.com/images/Chrome-Plugin/adblock.png "屏蔽效果")

[屏蔽效果](https://xieyufei.com/images/Chrome-Plugin/adblock.png "屏蔽效果")

　　选择拦截元素，淡黄色框住的内容就是拦截的内容

[![](https://xieyufei.com/images/Chrome-Plugin/select.png)](https://xieyufei.com/images/Chrome-Plugin/select.png "自定义拦截内容")

[自定义拦截内容](https://xieyufei.com/images/Chrome-Plugin/select.png "自定义拦截内容")

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[](#Axure-RP-Extension-for-Chrome "Axure RP Extension for Chrome")Axure RP Extension for Chrome[](#Axure-RP-Extension-for-Chrome)
---------------------------------------------------------------------------------------------------------------------------------

　　Axure RP Extension for Chrome 是原型设计工具 Axure RP 的 Chrome 浏览器插件，chrome 浏览器打开 axure 生成的 HTML 静态文件页面预览打开如下报错，这是因为 chrome 浏览器没有安装 Axure 插件导致的。

[![](https://xieyufei.com/images/Chrome-Plugin/axure.png)](https://xieyufei.com/images/Chrome-Plugin/axure.png "Axure")

[Axure](https://xieyufei.com/images/Chrome-Plugin/axure.png "Axure")

[](#FeHelper前端助手 "FeHelper前端助手")FeHelper 前端助手[](#FeHelper前端助手)
--------------------------------------------------------------

　　FE 助手是由国人开发的一款前端工具集合的小插件，插件功能比较全面：包括字符串编解码、代码压缩、美化、JSON 格式化、正则表达式、时间转换工具、二维码生成与解码、编码规范检测、页面性能检测、页面取色、Ajax 接口调试。

[![](https://xieyufei.com/images/Chrome-Plugin/fe1.png)](https://xieyufei.com/images/Chrome-Plugin/fe1.png "FE助手")

[FE 助手](https://xieyufei.com/images/Chrome-Plugin/fe1.png "FE助手")

[](#Momentum "Momentum")Momentum[](#Momentum)
---------------------------------------------

　　Momentum 插件是一款自动更换壁纸，自带时钟，任务日历和工作清单的 chrome 浏览器插件。官方的解释就是：替换你 Chrome 浏览器默认的 “标签页”。里面的图片全部来自 500PX 里面的高清图，无广告，无弹窗，非常适合笔记本使用，让装逼再上新台阶。让我来感受下出自细节，触及心灵的美。

[![](https://xieyufei.com/images/Chrome-Plugin/momentum.png)](https://xieyufei.com/images/Chrome-Plugin/momentum.png "Momentum")

[Momentum](https://xieyufei.com/images/Chrome-Plugin/momentum.png "Momentum")

[](#Octotree "Octotree")Octotree[](#Octotree)
---------------------------------------------

　　在 Github 上查看源代码的体验十分糟糕，尤其是从一个目录跳转到另一个目录的时候，非常麻烦。Octotree 是一款 chrome 插件，用于将 Github 项目代码以树形格式展示，而且在展示的列表中，我们可以下载指定的文件，而不需要下载整个项目。

[![](https://xieyufei.com/images/Chrome-Plugin/octotree.jpg)](https://xieyufei.com/images/Chrome-Plugin/octotree.jpg "Octotree")

[Octotree](https://xieyufei.com/images/Chrome-Plugin/octotree.jpg "Octotree")

[](#OneTab "OneTab")OneTab[](#OneTab)
-------------------------------------

　　Chrome 浏览器很好用，这是我们不得不承认的；但是人无完人，何况一个浏览器呢？一直以来，Chrome 占用内存这样的 “吃相” 就很让人头疼。

[![](https://xieyufei.com/images/Chrome-Plugin/eat.gif)](https://xieyufei.com/images/Chrome-Plugin/eat.gif "占用内存")

[占用内存](https://xieyufei.com/images/Chrome-Plugin/eat.gif "占用内存")

　　OneTab 是一款可以在用户打开过多 Chrome 标签页而 “不知所措” 的时候点击 OneTab 插件一键释放 Chrome 标签页内存的谷歌浏览器插件，OneTab 插件并不是像关闭浏览器那样直接把所有的标签页都关闭掉，它会先把现有的标签页都缓存起来，然后使用一键关闭所有标签页的功能弹出只有一个恢复窗口的新标签页，在这个 OneTab 插件的标签页中用户可以选择恢复其中有用的 Chrome 标签页而放弃其他应该关闭的标签页。

[![](https://xieyufei.com/images/Chrome-Plugin/onetab.jpg)](https://xieyufei.com/images/Chrome-Plugin/onetab.jpg "OneTab")

[OneTab](https://xieyufei.com/images/Chrome-Plugin/onetab.jpg "OneTab")

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

　　在恢复标签页的时候，OneTab 插件会以新标签页的方式去恢复，所以用户可以简单地点击几次鼠标都可以把有用的标签都找出来一起恢复，当用户打开的 Chrome 标签页过多的时候使用 OneTab 插件大约能够节省用户 95% 的系统内存，还可以让用户在标签页变小的情况下更加清晰地关注自己应该关注的 Chrome 标签页。

[](#Tampermonkey "Tampermonkey")Tampermonkey[](#Tampermonkey)
-------------------------------------------------------------

　　Tampermonkey（俗称油猴）是一款免费的浏览器扩展和最为流行的用户脚本管理器。虽然有些受支持的浏览器拥有原生的用户脚本支持，但 Tampermonkey 将在您的用户脚本管理方面提供更多的便利。 它提供了诸如便捷脚本安装、自动更新检查、标签中的脚本运行状况速览、内置的编辑器等众多功能， 同时 Tampermonkey 还有可能正常运行原本并不兼容的脚本。

[![](https://xieyufei.com/images/Chrome-Plugin/tampermonkey.png)](https://xieyufei.com/images/Chrome-Plugin/tampermonkey.png "Tampermonkey")

[Tampermonkey](https://xieyufei.com/images/Chrome-Plugin/tampermonkey.png "Tampermonkey")

　　通过给管理器安装各类脚本，可以让大部分 HTML 为主的网页更方便易用，比如：全速下载网盘文件、去广告、悬停显示大图、Flash/HTML5 播放器转换、阅读模式等。有点像给 Chrome 的插件装上插件（这里又是一个套娃）。

[](#Web-Vitals "Web Vitals")Web Vitals[](#Web-Vitals)
-----------------------------------------------------

　　多年来，Google 提供了很多工具：Lighthouse, Chrome DevTools, PageSpeed Insights, Search Console’s Speed Report 等来衡量和报告性能。而其中的衡量标准都很难学习和使用，Web Vitals 计划的目的就是简化场景，降低学习成本，并帮助站点关注最重要的指标

　　Web Vitals 是 Google 发起的，旨在提供各种质量信号的统一指南，其可获取三个关键指标（CLS、FID、LCP）：

[![](https://xieyufei.com/images/Chrome-Plugin/web-vitals1.png)](https://xieyufei.com/images/Chrome-Plugin/web-vitals1.png "Web Vitals")

[Web Vitals](https://xieyufei.com/images/Chrome-Plugin/web-vitals1.png "Web Vitals")

　　通过在浏览器安装 Web Vitals 插件，我们就可以在页面加载完成后很方便的查看这三个指标的情况。

[![](https://xieyufei.com/images/Chrome-Plugin/web-vitals.png)](https://xieyufei.com/images/Chrome-Plugin/web-vitals.png "Web Vitals插件")

[Web Vitals 插件](https://xieyufei.com/images/Chrome-Plugin/web-vitals.png "Web Vitals插件")

[](#Allow-CORS "Allow CORS")Allow CORS[](#Allow-CORS)
-----------------------------------------------------

　　我们开发过程中经常会遇到接口跨域的问题，通过 Allow CORS: Access-Control-Allow-Origin 这个插件，可以允许我们在接口的响应头轻松执行跨域请求，只需要激活插件并且执行。

[![](https://xieyufei.com/images/Chrome-Plugin/allow-cors.jpg)](https://xieyufei.com/images/Chrome-Plugin/allow-cors.jpg "Allow CORS插件")

[Allow CORS 插件](https://xieyufei.com/images/Chrome-Plugin/allow-cors.jpg "Allow CORS插件")

　　安装插件后，默认是不会添加跨域响应头的，点击插件弹框的 C 字母按钮，按钮变成橙色插件激活。

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[](#Window-Resizer "Window Resizer")Window Resizer[](#Window-Resizer)
---------------------------------------------------------------------

　　Window Resizer 是一款可以设置浏览器窗口大小的 Chrome 扩展，用户安装了 window resizer 插件后可以快速调节 chrome 的窗口大小，用户可以将窗口调节为 320x480、480x800、1024x768 等大小，也可以选择自定义浏览器窗口的尺寸。

[![](https://xieyufei.com/images/Chrome-Plugin/window-resizer.png)](https://xieyufei.com/images/Chrome-Plugin/window-resizer.png "Window Resizer")

[Window Resizer](https://xieyufei.com/images/Chrome-Plugin/window-resizer.png "Window Resizer")

> 以上所有插件和工具敬请关注公众号：`前端壹读`后，回复关键字`Chrome插件`即可获取。

[](#notifications对象属性 "notifications对象属性")notifications 对象属性[](#notifications对象属性)
----------------------------------------------------------------------------------

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

<table><thead><tr><th>Name</th><th>Type</th><th>Description</th></tr></thead><tbody><tr><td>type</td><td>string</td><td>显示的通知类型，”basic”, “image”, “list”, or “progress”</td></tr><tr><td>title</td><td>string</td><td>通知的标题</td></tr><tr><td>message</td><td>string</td><td>通知的主体内容</td></tr><tr><td>contextMessage</td><td>string</td><td>通知的备选内容</td></tr><tr><td>buttons</td><td>array of object</td><td>最多两个通知操作按钮的文本和图标。</td></tr><tr><td>iconUrl</td><td>string</td><td>图标的 URL</td></tr><tr><td>imageUrl</td><td>string</td><td>“image” 类型的通知的图片的 URL</td></tr><tr><td>eventTime</td><td>double</td><td>通知的时间戳，单位 ms</td></tr><tr><td>items</td><td>array of object</td><td>多项目通知的项目。Mac OS X 上的用户只能看到第一项。</td></tr><tr><td>progress</td><td>integer</td><td>当前的进度，有效范围 0~100</td></tr><tr><td>isClickable</td><td>boolean</td><td>通知窗口是否响应点击事件</td></tr></tbody></table>

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

<table><thead><tr><th>Name</th><th>Type</th><th>Description</th></tr></thead><tbody><tr><td>type</td><td>string [“normal”, “checkbox”, “radio”, “separator”]</td><td>菜单项的类型。如果没有指定则默认为’normal’（普通）</td></tr><tr><td>id</td><td>string</td><td>唯一标志符，对于事件页面来说必须存在，不能与同一扩展程序中的其它标志符相同。</td></tr><tr><td>title</td><td>string</td><td>显示在菜单项中的文字，除非类型是’separator’（分隔符）该参数是必选的。 当上下文为’selection’（选定内容）时，您可以在字符串中使用 %s 来显示选中的文本。</td></tr><tr><td>checked</td><td>boolean</td><td>单选或复选菜单项的初始状态</td></tr><tr><td>contexts</td><td>enumerated string [“all”, “page”, “frame”, “selection”, “link”, “editable”, “image”, “video”, “audio”]</td><td>列出该菜单项将会出现在哪些上下文中，包括”all”（全部）、”page”（页面）、”frame”（框架）、”selection”（选定内容）、”link”（链接）、”editable”（可编辑内容）、”image”（图片）、”video”（视频）、”audio”（音频），如果没有指定则默认为 page（页面）</td></tr><tr><td>onclick</td><td>function</td><td>菜单项单击时的回调函数</td></tr><tr><td>parentId</td><td>integer or string</td><td>父菜单项标识符</td></tr><tr><td>documentUrlPatterns</td><td>array of string</td><td>将该菜单项限制在 URL 匹配给定表达式的文档中显示</td></tr><tr><td>targetUrlPatterns</td><td>array of string</td><td>允许您基于 img/audio/video 标签的 src 属性以及 a 标签的 href 属性过滤</td></tr><tr><td>enabled</td><td>boolean</td><td>该右键菜单项是否启用或禁用</td></tr></tbody></table>

[](#插件权限列表 "插件权限列表")插件权限列表[](#插件权限列表)
-------------------------------------

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

[谢小飞博客专用防爬虫链接，想要看最新的前端博客请点这里](https://www.xieyufei.com/)

<table><thead><tr><th>权限名称</th><th>描述</th></tr></thead><tbody><tr><td>activeTab</td><td>请求根据 activeTab 规范向扩展授予权限。</td></tr><tr><td>alarms</td><td>授予您的扩展程序访问 chrome.alarms API 的权限。</td></tr><tr><td>background</td><td>使 Chrome 早启动晚关闭，从而延长扩展程序的使用寿命。</td></tr><tr><td>bookmarks</td><td>授予您的扩展程序访问 chrome.bookmarks API 的权限。</td></tr><tr><td>browsingData</td><td>授予您的扩展程序访问 chrome.browsingData API 的权限。</td></tr><tr><td>certificateProvider</td><td>授予您的扩展程序访问 chrome.certificateProvider API 的权限。</td></tr><tr><td>clipboardRead</td><td>如果扩展使用 document.execCommand(‘paste’).</td></tr><tr><td>clipboardWrite</td><td>表示扩展使用 document.execCommand(‘copy’) 或 document.execCommand(‘cut’)。</td></tr><tr><td>contentSettings</td><td>授予您的扩展程序访问 chrome.contentSettings API 的权限。</td></tr><tr><td>contextMenus</td><td>使您的扩展程序可以访问 chrome.contextMenus API。</td></tr><tr><td>cookies</td><td>允许您的扩展程序访问 chrome.cookies API。</td></tr><tr><td>debugger</td><td>授予您的扩展程序访问 chrome.debugger API 的权限。</td></tr><tr><td>declarativeContent</td><td>授予您的扩展程序访问 chrome.declarativeContent API 的权限。</td></tr><tr><td>declarativeNetRequest</td><td>使您的扩展程序可以访问 chrome.declarativeNetRequest API。</td></tr><tr><td>declarativeNetRequestFeedback</td><td>授予扩展访问 chrome.declarativeNetRequest API 中的事件和方法的权限，这些事件和方法返回有关匹配的声明性规则的信息。</td></tr><tr><td>declarativeWebRequest</td><td>授予您的扩展程序访问 chrome.declarativeWebRequest API 的权限。</td></tr><tr><td>desktopCapture</td><td>授予您的扩展程序访问 chrome.desktopCapture API 的权限。</td></tr><tr><td>documentScan</td><td>授予您的扩展程序访问 chrome.documentScan API 的权限。</td></tr><tr><td>downloads</td><td>授予您的扩展程序访问 chrome.downloads API 的权限。</td></tr><tr><td>enterprise.deviceAttributes</td><td>授予您的扩展程序访问 chrome.enterprise.deviceAttributes API 的权限。</td></tr><tr><td>enterprise.hardwarePlatform</td><td>使您的扩展程序可以访问 chrome.enterprise.hardwarePlatform API。</td></tr><tr><td>enterprise.networkingAttributes</td><td>授予您的扩展程序访问 chrome.enterprise.networkingAttributes API 的权限。</td></tr><tr><td>enterprise.platformKeys</td><td>授予您的扩展程序访问 chrome.enterprise.platformKeys API 的权限。</td></tr><tr><td>experimental</td><td>如果扩展程序使用任何 chrome.experimental.* APIs 则是必需的。</td></tr><tr><td>fileBrowserHandler</td><td>授予您的扩展程序访问 chrome.fileBrowserHandler API 的权限。</td></tr><tr><td>fileSystemProvider</td><td>授予您的扩展程序访问 chrome.fileSystemProvider API 的权限。</td></tr><tr><td>fontSettings</td><td>授予您的扩展程序访问 chrome.fontSettings API 的权限。</td></tr><tr><td>gcm</td><td>使您的扩展程序可以访问 chrome.gcm API。</td></tr><tr><td>geolocation</td><td>允许扩展程序在不提示用户许可的情况下使用地理定位 API。</td></tr><tr><td>history</td><td>授予您的扩展程序访问 chrome.history API 的权限。</td></tr><tr><td>identity</td><td>授予您的扩展程序访问 chrome.identity API 的权限。</td></tr><tr><td>idle</td><td>授予您的扩展程序访问 chrome.idle API 的权限。</td></tr><tr><td>loginState</td><td>授予您的扩展程序访问 chrome.loginState API 的权限。</td></tr><tr><td>management</td><td>授予您的扩展程序访问 chrome.management API 的权限。</td></tr><tr><td>nativeMessaging</td><td>使您的扩展程序可以访问本机消息传递 API。</td></tr><tr><td>notifications</td><td>授予您的扩展程序访问 chrome.notifications API 的权限。</td></tr><tr><td>pageCapture</td><td>授予您的扩展程序访问 chrome.pageCapture API 的权限。</td></tr><tr><td>platformKeys</td><td>授予您的扩展程序访问 chrome.platformKeys API 的权限。</td></tr><tr><td>power</td><td>授予您的扩展程序访问 chrome.power API 的权限。</td></tr><tr><td>printerProvider</td><td>授予您的扩展程序访问 chrome.printerProvider API 的权限。</td></tr><tr><td>printing</td><td>授予您的扩展程序访问 chrome.printing API 的权限。</td></tr><tr><td>printingMetrics</td><td>授予您的扩展程序访问 chrome.printingMetrics API 的权限。</td></tr><tr><td>privacy</td><td>授予您的扩展程序访问 chrome.privacy API 的权限。</td></tr><tr><td>processes</td><td>授予您的扩展程序访问 chrome.processes API 的权限。</td></tr><tr><td>proxy</td><td>授予您的扩展程序访问 chrome.proxy API 的权限。</td></tr><tr><td>scripting</td><td>授予您的扩展程序访问 chrome.scripting API 的权限。</td></tr><tr><td>search</td><td>授予您的扩展程序访问 chrome.search API 的权限。</td></tr><tr><td>sessions</td><td>授予您的扩展程序访问 chrome.sessions API 的权限。</td></tr><tr><td>signedInDevices</td><td>授予您的扩展程序访问 chrome.signedInDevices API 的权限。</td></tr><tr><td>storage</td><td>授予您的扩展程序访问 chrome.storage API 的权限。</td></tr><tr><td>system.cpu</td><td>授予您的扩展程序访问 chrome.system.cpu API 的权限。</td></tr><tr><td>system.display</td><td>使您的扩展程序可以访问 chrome.system.display API。</td></tr><tr><td>system.memory</td><td>使您的扩展程序可以访问 chrome.system.memory API。</td></tr><tr><td>system.storage</td><td>授予您的扩展程序访问 chrome.system.storage API 的权限。</td></tr><tr><td>tabCapture</td><td>授予您的扩展程序访问 chrome.tabCapture API 的权限。</td></tr><tr><td>tabGroups</td><td>授予您的扩展程序访问 chrome.tabGroups API 的权限。</td></tr><tr><td>tabs</td><td>使您的扩展程序可以访问 Tab 多个 API 使用的对象的特权字段，包括 chrome.tabs 和 chrome.windows。在许多情况下，您的扩展程序不需要声明’tabs’使用这些 API 的权限。</td></tr><tr><td>topSites</td><td>授予您的扩展程序访问 chrome.topSites API 的权限。</td></tr><tr><td>tts</td><td>授予您的扩展程序访问 chrome.tts API 的权限。</td></tr><tr><td>ttsEngine</td><td>授予您的扩展程序访问 chrome.ttsEngine API 的权限。</td></tr><tr><td>unlimitedStorage</td><td>为存储客户端数据提供无限配额，例如数据库和本地存储文件。没有此权限，扩展程序仅限于 5 MB 的本地存储空间。</td></tr><tr><td>vpnProvider</td><td>授予您的扩展程序访问 chrome.vpnProvider API 的权限。</td></tr><tr><td>wallpaper</td><td>使您的扩展程序可以访问 chrome.wallpaper API。</td></tr><tr><td>webNavigation</td><td>授予您的扩展程序访问 chrome.webNavigation API 的权限。</td></tr><tr><td>webRequest</td><td>授予您的扩展程序访问 chrome.webRequest API 的权限。</td></tr><tr><td>webRequestBlocking</td><td>如果扩展以阻塞方式使用 chrome.webRequest API，则为必需。</td></tr></tbody></table>