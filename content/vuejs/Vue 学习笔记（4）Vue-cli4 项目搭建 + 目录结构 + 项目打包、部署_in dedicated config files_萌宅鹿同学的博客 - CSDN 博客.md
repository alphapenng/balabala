> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/106990775)

### VueCLI 脚手架

*   [Vue CLI 介绍](#Vue_CLI__4)
*   [Vue CLI 安装](#Vue_CLI__29)
*   *   [Node.js 环境准备](#Nodejs__30)
    *   [安装 Vue 脚手架](#_Vue__62)
*   [第一个 Vue 脚手架项目](#_Vue__79)
*   *   [命令创建项目](#_84)
    *   [图形化界面创建项目](#_166)
    *   [vue-cli4 目录结构](#vuecli4__172)
    *   [vue-cli 中使用 Axios](#vuecli__Axios_194)
    *   [Vue 脚手架项目打包](#Vue__210)
    *   [Vue 脚手架项目部署到 springboot 项目](#Vue__springboot__220)
*   [vue-cli4 中的 views 和 components 有什么区别？](#vuecli4__views__components__237)
*   [vscode 中书写 .vue 文件无提示](#vscode__vue__241)
*   [修改地址栏是否显示 `#`](#__255)
*   [Windows 下杀死端口](#Windows__286)

> [Vue 笔记目录](https://blog.csdn.net/weixin_43734095/article/details/106910854)

Vue CLI 介绍
==========

> **CLI** 是什么？  
> 命令行界面（英语：command-line interface，缩写：_CLI_）是在图形用户界面得到普及之前使用最为广泛的用户界面，它通常不支持鼠标，用户通过键盘输入指令，计算机接收到指令后，予以执行。也有人称之为字符用户界面（CUI）。

**Vue CLI** 是什么？  
Vue CLI 是一个基于 Vue.js 进行快速开发的完整系统。使用 Vue 脚手架之后我们开发的页面将是一个完整系统 (项目)。

Vue CLI 的优势：

*   通过 `vue-cli` 搭建交互式的项目脚手架。  
    主流前端框架比如 bootstrap、jquery 等可以通过执行命令方式下载相关依赖
*   通过 `@vue/cli` + `@vue/cli-service-global` 快速开始 **零配置原型开发**
*   一个运行时依赖 (`@vue/cli-service`)，该依赖：
    *   可升级（一条命令）；
    *   基于 webpack 构建，并带有合理的默认配置；  
        webpack 是一种项目打包方式：将编译好的项目源码 ===> 部署到服务器上直接使用；
    *   可以通过项目内的配置文件进行配置；  
        通过修改默认配置文件达到自己想要的项目环境。
    *   可以通过插件进行扩展。  
        vue、v-charts、elementui …
*   一个丰富的官方插件集合，集成了前端生态中最好的工具。  
    Nodejs、Vue、VueRouter、Webpack、yarn …
*   一套完全图形化的创建和管理 Vue.js 项目的用户界面；

Vue CLI 安装
==========

Node.js 环境准备
------------

1.  前往这里下载 Node.js：[http://nodejs.cn/download/](http://nodejs.cn/download/)
2.  配置 Node.js 环境变量；（建议百度）
3.  使用 `node -v` 验证 Node.js 是否安装成功

**npm 介绍**：  
nodejs 包管理工具（node package mangager）:

*   npm 对前端主流技术进行统一管理
    
*   可以将 nodejs 想象成 Maven：  
    maven 管理 java 后端依赖 — 远程仓库 (中心仓库) — 阿里云镜像；  
    npm 管理前端系统依赖 — 远程仓库 (中心仓库) — 配置淘宝镜像；
    

Node.js 配置淘宝镜像：

```
npm config set registry https://registry.npm.taobao.org
```

查看 Node.js 配置的远程仓库：

```
npm config get registry
```

Node.js 配置 npm 依赖下载位置：（位置自定义）

```
npm config set cache "D:\CodeTool\nodereps\npm_cache"
npm config set prefix "D:\CodeTool\nodereps\npm_global"
```

验证 Node.js 环境配置：

```
npm config ls
```

安装 Vue 脚手架
----------

Vue CLI 官网：[https://cli.vuejs.org/zh/guide/](https://cli.vuejs.org/zh/guide/)

```
npm uninstall -g @vue/cli  # 卸载3.x版本脚手架
npm uninstall -g vue-cli   # 卸载2.x版本脚手架
```

安装 3.x 版本的 Vue CLI：

```
npm install -g @vue/cli
```

验证安装成功：（如果显示无法识别 “vue”，需要将 vue.cmd 配置到环境变量）

```
vue --version
```

第一个 Vue 脚手架项目
=============

Vue CLI 中项目开发方式：**一切皆组件！**

1.  VueCLI 开发方式是在项目中开发一个一个组件对应一个业务功能模块，日后可以将多个组件组合到一起形成一个前端系统。
2.  日后在使用 Vue CLI 进行开发时不再书写 html，编写的是一个个组件 (.vue 文件)，打包时 Vue CLI 会将组件编译成运行的 html 文件。

命令创建项目
------

（1）使用以下命令来创建一个新项目：

```
vue create hello-world
```

（2）我们选择 **手动配置**：用方向键 ↑ ↓ 操控选项，Enter 确定；

```
Please pick a preset: (Use arrow keys)
> default (babel, eslint) # 默认配置
  Manually select features # 手动配置
```

（3）选择配置，勾选如下即可：方向键 ↑ ↓ 操作，按空格选中，Enter 确定；

```
Vue CLI v4.4.6
Please pick a preset: Manually select features
Check the features needed for your project:
 (*) Babel
 ( ) TypeScript
 ( ) Progressive Web App (PWA) Support
 (*) Router
 (*) Vuex
 (*) CSS Pre-processors
 (*) Linter / Formatter
 ( ) Unit Testing
>( ) E2E Testing
```

（4）首先检查刚才选择的配置；  
然后问我们是否使用 history mode，其实就是页面路由含不含有 `#`；这里我们选择 `Y`

```
Check the features needed for your project: Babel, Router, Vuex, CSS Pre-processors, Linter
Use history mode for router? (Requires proper server setup for index fallback in production) (Y/n) 
y
```

（5）选择 CSS 预编译器，这里我们选择 Less；

```
Pick a CSS pre-processor (PostCSS, Autoprefixer and CSS Modules are supported by default): (Use arrow keys)
> Sass/SCSS (with dart-sass)
  Sass/SCSS (with node-sass)
  Less
  Stylus
```

（6）选择 ESLint 代码校验规则，提供一个插件化的 javascript 代码检测工具，这里我们选择 ESLint + Prettier;

```
Pick a linter / formatter config:
  ESLint with error prevention only
  ESLint + Airbnb config
  ESLint + Standard config
> ESLint + Prettier
```

（7）选择什么时候进行代码校验，Lint on save：保存就检查，  
Lint and fix on commit：fix 或者 commit 的时候检查，这里我们选择第一个；

```
Pick additional lint features: (Press <space> to select, <a> to toggle all, <i> to invert selection)
>(*) Lint on save
 ( ) Lint and fix on commit
```

（8）选择把配置保存到哪个文件中，  
In dedicated config files 存放到独立文件中，In package.json 存放到 package.json 中，  
这里我们选择放到 package.json 中；

```
Where do you prefer placing config for Babel, ESLint, etc.? (Use arrow keys)
  In dedicated config files
> In package.json
```

（9）问我们是否保存刚才的配置，以后的文件可以直接使用，选择 N。

```
Save this as a preset for future projects? (y/N)
N
```

至此项目搭建完毕。

使用如下命令运行项目：

```
cd hello-world # 首先进入项目根路径

npm run serve # 运行项目
```

浏览器输入如下路径来访问项目：

```
http://localhost:8080
```

图形化界面创建项目
---------

使用图形化界面创建和管理项目：

```
vue ui
```

vue-cli4 目录结构
-------------

![](https://img-blog.csdnimg.cn/20200628130933668.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

*   `node_modules`：用于存放我们项目的各种依赖；
*   `public`：用于存放静态资源（不会变动的）；
    *   `public/index.html`：模板文件，作用是生成项目的入口文件。  
        浏览器访问项目的时候就会默认打开的是生成好的 index.html。
*   `src`：是存放各种 .vue 文件的地方。
    *   `src/assets`：用于存放着各种静态文件（可能会变动），比如图片。
    *   `src/components`：存放公共组件（可复用），比如 header.vue、footer.vue 等。
    *   `src/router/index.js`：vue-router 路由文件。  
        需要引入 src/views 文件夹下的 .vue，配置 path、name、component。
    *   `src/store/index.js`：是 vuex 的文件，主要用于项目里边的一些状态保存。  
        比如 state、mutations、actions、getters、modules。
    *   `src/views`，存放页面组件（不可复用），比如 Login.vue，Home.vue。
    *   `src/App.vue`：App.vue 是项目的主组件；  
        App.vue 中使用 router-link 引入其他模块，所有的页面都是在 App.vue 下切换的。
    *   `src/main.js`：入口文件，主要作用是初始化 vue 实例，同时可以在此文件中引用某些组件库或者全局挂载一些变量。
*   `.gitignore`：配置 git 上传想要忽略的文件格式。
*   `babel.config.js`：一个工具链，主要用于在当前和较旧的浏览器或环境中将 ES6 的代码转换向后兼容（低版本 ES）。
*   `package.json`：模块基本信息项目开发所需要的模块，版本，项目名称。
*   `package-lock.json`：是在 npm install 时候生成的一份文件，用于记录当前状态下实际安装的各个 npm package 的具体来源和版本号。

vue-cli 中使用 Axios
-----------------

安装 axios：

```
npm install axios --save-dev
```

配置文件 main.js 中引入 axios：

```
import axios from 'axios';

Vue.prototype.$http=axios;
```

使用 axios：・

```
this.$http.get("url").then((res)=>{});
this.$http.post("url").then((res)=>{});
```

Vue 脚手架项目打包
-----------

在项目根目录中执行如下命令：

```
npm run build
```

注：Vue 脚手架打包的项目必须在服务器上运行，不能直接双击运行；

在打包之后项目中出现 `dist` 目录，`dist` 目录就是 Vue 脚手架项目的生产目录（直接部署目录）。

Vue 脚手架项目部署到 springboot 项目
--------------------------

打包完后，如何将项目部署到 SpringBoot 项目上呢？

将打包好的 `dist` 目录放到 SpringBoot 项目的 `static` 目录下；  
![](https://img-blog.csdnimg.cn/20200628221838665.png)  
由于我在配置文件中配置了项目路径：（没有访问路径则不需要修改）

```
server.servlet.context-path=/vue
```

所以要修改一下 index.html 中引入资源文件的路径；  
![](https://img-blog.csdnimg.cn/20200628221948822.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
通过以下路径访问部署的前端页面：

```
http://localhost:8989/vue/dist/index.html
```

vue-cli4 中的 views 和 components 有什么区别？
=====================================

components 是小组件；views 是页面级组件；  
components 可被引用在 views 中，一般 views 组件不被复用；

vscode 中书写 .vue 文件无提示
=====================

下载 Vetur 插件，然后修改 Settings.json：

```
{
   "emmet.triggerExpansionOnTab": true,
   "emmet.includeLanguages": {
       "vue-html":"html",
       "vue":"html"
    },
    "files.associations": {
       "*.vue": "html"
    }
}
```

修改地址栏是否显示 `#`
=============

在 `src/router/inde.jx` 文件下可以修改：`mode: "history"` 不显示 `#`；

```
const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});
```

这个模式无法通过 `a` 标签来切换组件，需要使用 `router-link` 标签；

```
<router-link to="/user/add" tag="a">添加</router-link>
```

在 `src/router/inde.jx` 文件下可以修改：`mode: "hash"` 会显示 `#`

```
const router = new VueRouter({
  mode: "hash",
  base: process.env.BASE_URL,
  routes
});
```

这个模式可以通过 `a` 标签来切换组件，也可以通过 `router-link` 标签；

```
<a href="#/user/add">添加</a>

<router-link to="/user/add" tag="a">添加</router-link>
```

Windows 下杀死端口
=============

查看端口 8989 被哪个进程占用：

```
netstat -ano | findstr "8989"
```

查看进程号为 3736 对应的进程；由下图可以看出，是被 java.exe 占用了：

```
tasklist | findstr "3736"
```

结束该进程：

```
taskkill /f /t /im java.exe
```