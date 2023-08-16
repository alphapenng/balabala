> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [molunerfinn.com](https://molunerfinn.com/electron-vue-1/#%E6%80%BB%E7%BB%93)

> Electron-vue 开发实战 0——Electron-vue 入门

[](#前言 "前言")前言
--------------

前段时间，我用 [electron-vue](https://github.com/SimulatedGREG/electron-vue) 开发了一款跨平台（目前支持 Mac 和 Windows）的免费开源的图床上传应用 ——[PicGo](https://github.com/Molunerfinn/PicGo)，在开发过程中踩了不少的坑，不仅来自应用的业务逻辑本身，也来自 electron 本身。在开发这个应用过程中，我学了不少的东西。因为我也是从 0 开始学习 electron，所以很多经历应该也能给初学、想学 electron 开发的同学们一些启发和指示。故而写一份 Electron 的开发实战经历，用最贴近实际工程项目开发的角度来阐述。希望能帮助到大家。

预计将会从几篇系列文章或方面来展开：

1.  [electron-vue 入门](https://molunerfinn.com/electron-vue-1/)
2.  [Main 进程和 Renderer 进程的简单开发](https://molunerfinn.com/electron-vue-2/)
3.  [引入基于 Lodash 的 JSON database——lowdb](https://molunerfinn.com/electron-vue-3/)
4.  [跨平台的一些兼容措施](https://molunerfinn.com/electron-vue-4/)
5.  [通过 CI 发布以及更新的方式](https://molunerfinn.com/electron-vue-5/)
6.  [开发插件系统 ——CLI 部分](https://molunerfinn.com/electron-vue-6/)
7.  [开发插件系统 ——GUI 部分](https://molunerfinn.com/electron-vue-7/)
8.  想到再写…

[](#说明 "说明")说明
--------------

`PicGo` 是采用 `electron-vue` 开发的，所以如果你会 `vue`，那么跟着一起来学习将会比较快。如果你的技术栈是其他的诸如 `react`、`angular`，那么纯按照本教程虽然在 render 端（可以理解为页面）的构建可能学习到的东西不多，不过在 main 端（electron 的主进程）应该还是能学习到相应的知识的。

[](#Electron简要介绍 "Electron简要介绍")Electron 简要介绍
---------------------------------------------

一开始学习 electron 的时候，我被官网文档密密麻麻的概念所镇住了：

[![](https://blog-1251750343.cos.ap-beijing.myqcloud.com/8700af19ly1fncsj44xlhj21xy3e8x1g)](https://blog-1251750343.cos.ap-beijing.myqcloud.com/8700af19ly1fncsj44xlhj21xy3e8x1g)

概念太多，没有办法一下子接受。所以我自己学习完 electron 开发后，做了一张图。来看看图理解一下什么是 `electron`，以及它包括了啥：

[![](https://blog-1251750343.cos.ap-beijing.myqcloud.com/8700af19ly1fncq342rk8j20cs0d63zd)](https://blog-1251750343.cos.ap-beijing.myqcloud.com/8700af19ly1fncq342rk8j20cs0d63zd)

### [](#图解 "图解")图解

electron 由 Node.js+Chromium+Native APIs 构成。你可以理解成，它是一个得到了 Node.js 和基于不同平台的 Native APIs 加强的 Chromium 浏览器，可以用来开发跨平台的桌面级应用。

它的开发主要涉及到两个进程的协作 ——Main（主）进程和 Renderer（渲染）进程。简单的理解两个进程的作用：

1.  Main 进程主要通过 Node.js、Chromium 和 Native APIs 来实现一些系统以及底层的操作，比如创建系统级别的菜单，操作剪贴板，创建 APP 的窗口等。
2.  Renderer 进程主要通过 Chromium 来实现 APP 的图形界面 —— 就是平时我们熟悉的前端开发的部分，不过得到了 electron 给予的加强，一些 Node 的模块（比如 fs）和一些在 Main 进程里能用的东西（比如 Clipboard）也能在 Render 进程里使用。
3.  Main 进程和 Renderer 进程通过 `ipcMain` 和 `ipcRenderer` 来进行通信。通过事件监听和事件派发来实现两个进程通信，从而实现 Main 或者 Renderer 进程里不能实现的某些功能。

### [](#进一步介绍 "进一步介绍")进一步介绍

说完了 electron 的组成和需要我们开发的部分，来说说它的优缺点。

优点：

1.  从上述介绍可以发现，除了不同平台 Native APIs 不同以外，Node.js 和 Chromium 都是跨平台的工具，这也为 electron 生来就能做跨平台的应用开发打下基础。
2.  开发图形界面前所未有的容易 —— 比起 C#\QT\MFC 等传统图形界面开发技术，通过前端的图形化界面开发明显更加容易和方便。得益于 Chromium，这种开发模式得以实现。
3.  成熟的社区、活跃的核心团队，大部分 electron 相关的问题你可以在社区、github issues、Stack Overflow 里得到答案。开发的障碍进一步降低。

缺点：

1.  应用体积过大。由于内部包装了 Chromium 和 Node.js，使得打包体积（使用 `electron-builder`）在 mac 上至少是 45M + 起步，在 windows 上稍微好一点，不过也要 35M + 起步。不过相比早期打包体积 100M + 起步来说，已经好了不少。不过解压后安装依然是 100M + 起步。
2.  受限于 Node.js 和 Native APIs 的一些支持度的问题，它依然有所局限。一些功能依然无法实现。比如无法获取在系统文件夹里选中的文件，而必须调用 web 的 File 或者 node 的 fs 接口才可以访问系统文件。
3.  应用性能依旧是个问题。所以做轻量级应用没问题，重量级应用尤其是 CPU 密集型应用的话很是问题。

[](#electron-vue的简要介绍 "electron-vue的简要介绍")electron-vue 的简要介绍
------------------------------------------------------------

由于我自己是 Vue 的技术栈，所以就想在 electron 里使用 vue。而 vue 只是在 renderer 进程里使用的框架，不涉及到 main 进程。如下图：

[![](https://blog-1251750343.cos.ap-beijing.myqcloud.com/8700af19ly1fncpxesazgj20dy08kwf1)](https://blog-1251750343.cos.ap-beijing.myqcloud.com/8700af19ly1fncpxesazgj20dy08kwf1)

> 因此 react、angluar 以及其他的前端开发框架同样适用。

不过想要做到把 vue 和 electron 结合起来并不是一件特别容易的事。为了方便开发，我使用的是 [electron-vue](https://github.com/SimulatedGREG/electron-vue)，这个是开发者 [SimulatedGREG](https://github.com/SimulatedGREG) 参考 vue-cli 的 webpack 模板骨架搭建的 electron 和 vue 结合的开发脚手架。由于我对于 `vue-cli` 非常熟悉，所以上手 `electron-vue` 非常容易。相比很多其他的教程或者其他 electron + 前端开发框架的组装方案，`electron-vue` 给我感觉最好的是如下：

1.  只有一个 `package.json`。而大部分其他的项目结构依然在使用两个 `package.json` 来应对 main 进程和 renderer 进程的依赖库。
2.  内建完整的 vue 全家桶，省去再次配置 vue-router 和 vuex 的一些初期操作。
3.  内建完整的 webpack 开发、生产等配置，开发环境舒适。
4.  内建完整的开发、构建等 `npm scripts`，使用非常方便。
5.  内建完整的 Travis-ci、Appveyor 配置脚本，只需少数修改就能做到利用 CI 自动构建的应用发布。
6.  完善的文档，清晰的项目结构。

大体的项目结构如下，根据选择的不同设置结构会有所不同：

bash

```
my-project
├─ .electron-vue
│  └─ <build/development>.js files
├─ build
│  └─ icons/
├─ dist
│  ├─ electron/
│  └─ web/
├─ node_modules/
├─ src
│  ├─ main 
│  │  ├─ index.dev.js
│  │  └─ index.js
│  ├─ renderer 
│  │  ├─ components/
│  │  ├─ router/
│  │  ├─ store/
│  │  ├─ App.vue
│  │  └─ main.js
│  └─ index.ejs
├─ static/
├─ test
│  ├─ e2e
│  │  ├─ specs/
│  │  ├─ index.js
│  │  └─ utils.js
│  ├─ unit
│  │  ├─ specs/
│  │  ├─ index.js
│  │  └─ karma.config.js
│  └─ .eslintrc
├─ .babelrc
├─ .eslintignore
├─ .eslintrc.js
├─ .gitignore
├─ package.json
└─ README.md
```

可以看到我们主要关注的两个文件夹：`src/main` 和 `src/renderer` 分别对应的是 main 进程和 renderer 进程。我们的开发大体上也是围绕这两个文件夹展开。

[](#electron-vue安装 "electron-vue安装")electron-vue 安装
---------------------------------------------------

参考 [electron-vue](https://github.com/SimulatedGREG/electron-vue) 官方的文档给出的说明，搭建 electron-vue 的脚手架非常方便，使用 vue-cli 来安装它的模板即可：

bash

```
npm install -g vue-cli

vue init simulatedgreg/electron-vue my-project


cd my-project
yarn 

yarn run dev
```

如果你是 windows 用户，在安装期间遇到了关于 `node-gyp`、C++ 库等方面的问题的话，请参考官方文档给出的[解决办法](https://simulatedgreg.gitbooks.io/electron-vue/content/en/getting_started.html#a-note-for-windows-users)。

如果上述都没有问题，那么你将会看到如下界面：

[![](https://blog-1251750343.cos.ap-beijing.myqcloud.com/8700af19ly1fncs5yv0qdj21jk0wi44h)](https://blog-1251750343.cos.ap-beijing.myqcloud.com/8700af19ly1fncs5yv0qdj21jk0wi44h)

[](#总结 "总结")总结
--------------

作为开篇，内容不多。不过把东西说清楚是必须的。对于 electron 开发其实是有两种声音的：

1.  很简单，不过就是 web 开发换了个壳
2.  很难，需要了解很多原生的概念，不知道要怎么入手

其实从本文介绍完，你应该要有一个粗略的认识。electron 的开发其实包括了两个部分，一个是 main 进程的相关开发，一个是 renderer 进程的相关开发。对于 renderer 进程的开发对于大多数前端开发人员来说不难。main 进程的相关开发，如果你想要把 electron 的 main 进程的所以特性都学一遍、都用一遍，确实是需要不少时间的。不过如果是从需求出发，从工程本身的需要出发，那么只需要用到的时候再去学习即可。不过要对 Node.js 能做到的事有个概念 —— 它并不是万能的。

下一篇文章将会正式开启 electron 的开发，如果你对此有兴趣不妨关注我的博客的进展。

Copyright Notice: All articles in this blog are licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) unless stating additionally.