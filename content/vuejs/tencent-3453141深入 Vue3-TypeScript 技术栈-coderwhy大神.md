<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-12-03 06:52:42
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-12-12 15:15:55
 * @FilePath: /balabala/content/vuejs/tencent-3453141深入 Vue3-TypeScript 技术栈-coderwhy大神.md
-->
# tencent-3453141深入 Vue3-TypeScript 技术栈-coderwhy大神

- [tencent-3453141深入 Vue3-TypeScript 技术栈-coderwhy大神](#tencent-3453141深入-vue3-typescript-技术栈-coderwhy大神)
  - [开篇](#开篇)
    - [系统学习Vue3+TypeScript](#系统学习vue3typescript)
    - [课程的内容](#课程的内容)
  - [邂逅 Vue3 开发](#邂逅-vue3-开发)
    - [如何使用 Vue呢？](#如何使用-vue呢)
    - [Vue 的源码](#vue-的源码)
  - [Vue3 基础-模板语法](#vue3-基础-模板语法)
    - [VSCode 代码片段](#vscode-代码片段)
    - [Mustache 双大括号语法](#mustache-双大括号语法)
    - [v-once 指令](#v-once-指令)

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

- methods属性
  - methods 属性是一个对象，通常我们会在这个对象中定义很多的方法：
    - 这些方法可以 **被绑定到 template 模板**中；
    - 在该方法中，我们可以**使用 this关键字**来直接访问到data中返回的对象的属性；
    - ⚠️注意：**不应该使用箭头函数来定义method函数**（例如 `plus: () => this.a++`）。理由是箭头函数绑定了父级作用域的上下文，所以 `this` 将不会按照期望指向组件实例，`this.a` 将是 `undefined`。
      - 问题一：不能使用箭头函数？
        - 我们在 methods 中要使用 data 返回对象中的数据：
          - 那么这个 **this是必须有值**的，并且应该可以 **通过this获取到data返回对象中的数据**。
        - 如果我们使用**箭头函数**，那么这个**this就会是window**了。
        - **在箭头函数中是不绑定this**。
      - 问题二：this到底指向什么？
        - 事实上 Vue的源码当中就是对methods中的所有函数进行了遍历，并且通过bind绑定了this：

### Vue 的源码

- 如果想要学习 Vue 的源码，比如看 createApp 的实现过程，应该怎么办呢？
  - 第一步： 在 GitHub 上搜索 vue-next，下载源代码（这里推荐通过 git clone 的方式下载）；
  - 第二步：安装 Vue 源码项目相关的依赖（执行 yarn install）；
  - 第三步： 对项目执行打包操作（执行 yarn dev），执行前修改脚本；

    ```json
    "scripts": {
      "dev": "node scripts/dev.js --sourcemap",
    }
    ```

  - 第四步： 通过 `packages/vue/dist/vue.global.js` 调试代码

## Vue3 基础-模板语法

### VSCode 代码片段

- 第一步，复制自己需要生成代码片段的代码；
- 第二步，<https://snippet-generator.app/> 在该网站中生成代码片段；
- 第三步，在 VSCode 中配置代码片段；

### Mustache 双大括号语法

- 不仅仅可以是 data 中的属性，也可以是一个 JavaScript 的表达式。

### v-once 指令

- **用于指定元素或者组件只渲染一次：**
  - 当数据发生变化时，**元素或者组件以及其所有的子元素**将视为**静态内容**并且跳过；