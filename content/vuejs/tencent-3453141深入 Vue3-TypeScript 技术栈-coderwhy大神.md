<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-12-03 06:52:42
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-12-07 13:08:13
 * @FilePath: /balabala/content/vuejs/tencent-3453141深入 Vue3-TypeScript 技术栈-coderwhy大神.md
-->
# tencent-3453141深入 Vue3-TypeScript 技术栈-coderwhy大神

- [tencent-3453141深入 Vue3-TypeScript 技术栈-coderwhy大神](#tencent-3453141深入-vue3-typescript-技术栈-coderwhy大神)
  - [开篇](#开篇)
    - [系统学习Vue3+TypeScript](#系统学习vue3typescript)
    - [课程的内容](#课程的内容)
  - [邂逅 Vue3 开发](#邂逅-vue3-开发)
    - [如何使用 Vue呢？](#如何使用-vue呢)

## 开篇

### 系统学习Vue3+TypeScript

![vue3-typescript](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202312031609395.webp)

### 课程的内容

- Vue3核心知识深入解析
- Vue-Router4.x、Vuex4.x、Composition-API等详细解析
- 基于 Webpack5、Vite2分别搭建Vue3项目
- TypeScript基础、高级语法解析、应用、实战
- 项目实战中的高级组件拆分、封装，项目架构设计等
- Vue3项目的打包、优化、自动化部署等
- Vue3相关的原理、源码解读等

## 邂逅 Vue3 开发

### 如何使用 Vue呢？

- 安装和使用 Vue 这个 JavaScript 库有哪些方式呢？
  - 方式一：在页面中通过 CDN 的方式来引入；
  - 方式二：下载Vue的JavaScript文件，并且自己手动引入；
  - 方式三：通过 npm包管理工具安装使用它（webpack再讲）；
  - 方式四：直接通过Vue CLI创建项目，并且使用它；

- 声明式和命令
  - 命令式编程和声明式编程；
  - 命令式编程关注的是 "how to do"，声明式编程关注的是 "what to do"，由框架（机器）完成 "how" 的过程；

- template 属性
  - 在使用 createApp 的时候，我们传入了**一个对象**，接下来详细解析一下之前传入的属性分别代表什么含义。
  - **template属性**：表示的是 Vue 需要帮助我们渲染的模板信息：
    - 会**替换掉**我们挂载到的元素（比如id为app的div）的innerHTML；
    - 如果 template 以 # 开头，那么它将被用作 querySelector，并且使用匹配元素的 innerHTML 作为模板字符串。

- data属性
  - data 中返回的对象会被 **Vue 的响应式系统劫持**，之后对该**对象的修改或者访问**都会在劫持中被处理：
    - 所以我们在template中通过 {{counter}} 访问 counter，可以从对象中获取到数据
    - 所以我们修改counter的值时，template中的 {{counter}} 也会发生改变

