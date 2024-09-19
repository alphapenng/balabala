<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2024-01-27 15:43:56
 * @LastEditors: alphapenng
 * @LastEditTime: 2024-09-19 23:23:19
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
  - [Vue3 基础-模板语法（一）](#vue3-基础-模板语法一)
    - [VSCode 代码片段](#vscode-代码片段)
    - [Mustache 双大括号语法](#mustache-双大括号语法)
    - [v-once 指令](#v-once-指令)
    - [v-text 指令](#v-text-指令)
    - [v-html 指令](#v-html-指令)
    - [v-pre](#v-pre)
    - [v-cloak](#v-cloak)
    - [v-bind 的绑定属性](#v-bind-的绑定属性)
    - [v-on 绑定事件](#v-on-绑定事件)
  - [Vue3 基础-模板语法（二）](#vue3-基础-模板语法二)
    - [条件渲染](#条件渲染)
    - [列表渲染](#列表渲染)
  - [Vue3 的 Options-API](#vue3-的-options-api)
    - [计算属性 computed](#计算属性-computed)
    - [认识侦听器 watch](#认识侦听器-watch)
  - [Vue3 的表单和开发模式](#vue3-的表单和开发模式)
    - [v-model](#v-model)
    - [组件化开发](#组件化开发)
  - [Webpack 基础打包](#webpack-基础打包)
    - [Webpack 到底是什么呢？](#webpack-到底是什么呢)
    - [Vue 项目加载的文件有哪些呢？](#vue-项目加载的文件有哪些呢)
    - [Webpack 的使用前提](#webpack-的使用前提)
    - [Webpack 的安装](#webpack-的安装)
    - [Webpack 的默认打包](#webpack-的默认打包)
    - [创建局部的 webpack](#创建局部的-webpack)
    - [webpack 配置文件](#webpack-配置文件)
    - [css-loader 的使用](#css-loader-的使用)
    - [css-loader 的使用方案](#css-loader-的使用方案)
    - [loader 配置方式](#loader-配置方式)
    - [认识 style-loader](#认识-style-loader)
    - [如何处理 less 文件？](#如何处理-less-文件)
    - [less-loader 处理](#less-loader-处理)
    - [认识 PostCSS 工具](#认识-postcss-工具)
    - [命令行使用 postcss](#命令行使用-postcss)
    - [插件 autoprefixer](#插件-autoprefixer)
    - [postcss-loader](#postcss-loader)
    - [单独的 postcss 配置文件](#单独的-postcss-配置文件)
    - [postcss-preset-env](#postcss-preset-env)
  - [webpack 打包其他资源](#webpack-打包其他资源)
    - [图片资源](#图片资源)
    - [认识 Plugin](#认识-plugin)
    - [Mode 配置](#mode-配置)
  - [Babel 和 dev-server](#babel-和-dev-server)
    - [Babel](#babel)
    - [Vue 源码的打包](#vue-源码的打包)
    - [为什么要搭建本地服务器？](#为什么要搭建本地服务器)
  - [VueCLI 和 Vite](#vuecli-和-vite)
    - [Vue CLI 安装和使用](#vue-cli-安装和使用)
    - [Vite](#vite)
  - [Vue3 组件化开发(一)](#vue3-组件化开发一)
    - [组件的通信](#组件的通信)
  - [Vue3 组件化开发（二）](#vue3-组件化开发二)
    - [非父子组件的通信](#非父子组件的通信)
    - [认识插槽 Slot](#认识插槽-slot)
  - [Vue3 组件化开发（三）](#vue3-组件化开发三)
    - [动态组件](#动态组件)
    - [keep-alive](#keep-alive)
    - [异步组件](#异步组件)
    - [refs](#refs)
    - [`$parent` 和 `$root`](#parent-和-root)
    - [生命周期](#生命周期)
    - [组件的 `v-model`](#组件的-v-model)
    - [混入 Mixin](#混入-mixin)
  - [Vue3 过渡\&动画实现](#vue3-过渡动画实现)
  - [Composition API（一）](#composition-api一)
    - [Options API 的弊端](#options-api-的弊端)
    - [认识 Composition API](#认识-composition-api)
  - [Composition API（二）](#composition-api二)
    - [Reactive 判断的 API](#reactive-判断的-api)
    - [toRefs 与 toRef](#torefs-与-toref)
    - [computed](#computed)
    - [watchEffect 与 watch](#watcheffect-与-watch)
  - [Composition API（三）高级语法补充](#composition-api三高级语法补充)
    - [生命周期钩子](#生命周期钩子)
    - [Provide 和 Inject 函数](#provide-和-inject-函数)
    - [Composition API 举例](#composition-api-举例)
    - [setup 顶层编写方式（实验性api）](#setup-顶层编写方式实验性api)
    - [认识 h 函数](#认识-h-函数)
    - [jsx](#jsx)
  - [Vue3 高级语法补充](#vue3-高级语法补充)
    - [认识自定义指令](#认识自定义指令)
    - [认识 Teleport](#认识-teleport)
    - [认识 Vue 插件](#认识-vue-插件)
  - [Vue3 源码学习](#vue3-源码学习)

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
  - data 中返回的对象会被**Vue 的响应式系统劫持**，之后对该**对象的修改或者访问**都会在劫持中被处理：
    - 所以我们在template中通过 {{counter}} 访问 counter，可以从对象中获取到数据
    - 所以我们修改counter的值时，template中的 {{counter}} 也会发生改变

- methods属性
  - methods 属性是一个对象，通常我们会在这个对象中定义很多的方法：
    - 这些方法可以**被绑定到 template 模板**中；
    - 在该方法中，我们可以**使用 this关键字**来直接访问到data中返回的对象的属性；
    - ⚠️注意：**不应该使用箭头函数来定义method函数**（例如 `plus: () => this.a++`）。理由是箭头函数绑定了父级作用域的上下文，所以 `this` 将不会按照期望指向组件实例，`this.a` 将是 `undefined`。
      - 问题一：不能使用箭头函数？
        - 我们在 methods 中要使用 data 返回对象中的数据：
          - 那么这个**this是必须有值**的，并且应该可以**通过this获取到data返回对象中的数据**。
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

## Vue3 基础-模板语法（一）

### VSCode 代码片段

- 第一步，复制自己需要生成代码片段的代码；
- 第二步，<https://snippet-generator.app/> 在该网站中生成代码片段；
- 第三步，在 VSCode 中配置代码片段；

### Mustache 双大括号语法

- 不仅仅可以是 data 中的属性，也可以是一个 JavaScript 的表达式。

### v-once 指令

- **用于指定元素或者组件只渲染一次：**
  - 当数据发生变化时，**元素或者组件以及其所有的子元素**将视为**静态内容**并且跳过；
  - 该指令可以用于**性能优化**；

### v-text 指令

- 用于更新元素的 textContent；

### v-html 指令

- 内容想被 Vue 解析出来， 用 v-html 来展示；

### v-pre

- 用于跳过元素和它的子元素的编译过程，显示原始的 Mustache 标签
- 跳过不需要编译的节点，加快编译的速度；

### v-cloak

- 这个指令保持在元素上直到关联组件实例结束编译。
- 和 CSS 规则如 `[v-cloak]{display:none}` 一起用时，这个指令可以隐藏未编译的 Mustache 标签直到组件实例准备完毕。

### v-bind 的绑定属性

- **绑定属性我们使用v-bind：**
  - 缩写：`:`
  - 预期：any(with argument)|Object(without argument)
  - 参数：attrOrProp(optional)
  - 修饰符： 将 kebab-case attribute 名转换为 camelCase；
  - 用法：**动态地绑定一个或多个 attribute**，或者**向另一个组件传递 props**；

- 绑定 class 介绍
  - **绑定 class 有两种方式：**
    - 对象语法 `<div :class="{'active': true}">呵呵</div>`
    - 数组语法 `<div :class="['abc', title]">哈哈</div>`

- 绑定 style 介绍
  - 利用**v-bind:style**来绑定一些**CSS内联样式**；
    - 因为某些样式我们需要根据**数据**动态来决定；
    - 比如某段文字的**颜色**，**大小**等等；
  - CSS property 名可以用**驼峰式（camelCase）** 或 **短横线分隔（kebab-case，记得用引号括起来）** 来命名；
  - **绑定 class 有两种方式：**
    - 对象语法 `<div :style="{color: 'red', fontSize: '20px'}">呵呵</div>`
    - 数组语法 `<div :style="[{color: 'red'}, {fontSize: '30px'}]">哈哈</div>`
  
- 动态绑定属性
  - 在某些情况下，我们**属性的名称**可能也不是固定的：
  - 如果**属性名称不是固定**的，我们可以使用 **:[属性名]="值"** 的格式来定义；
  - 这种绑定的方式，我们称之为**动态绑定属性**；

- 绑定一个对象
  - 将一个"对象的所有属性"，绑定到"元素上的所有属性"，应该怎么做呢？
    - 直接使用**v-bind绑定一个对象**；

      ```html
      <div v-bind="{id: 123, class: 'abc'}">呵呵</div>
      ```

### v-on 绑定事件

- **在前端开发中，我们需要经常和用户进行各种各样的交互：**
  - 我们必须监听用户发生的事件，比如**点击、拖拽、键盘事件**等等
  - 在 Vue 中如何监听事件呢？使用**v-on指令**

- v-on 的使用：
  - 缩写：`@`
  - 预期：Function|Inline Statement|Object
  - 参数：event
  - 修饰符：
    - .stop - 调用 event.stopPropagation()
    - .prevent - 调用 event.preventDefault()
    - .capture - 事件在捕获阶段被触发
    - .self - 只有当 event.target 是当前元素本身时，事件才会被触发
    - .{keyAlias} - 仅当事件是从特定键触发时才触发回调
    - .once - 事件只触发一次
    - .left - 只当点击鼠标左键时触发
    - .right - 只当点击鼠标右键时触发
    - .middle - 只当点击鼠标中键时触发
    - .passive - {passive: true} 模式添加侦听器
  - 用法：绑定事件监听

- v-on 的参数传递：
  - 当通过 methods 中定义方法，以供 @click 调用时，需要**注意参数问题**：
  - 情况一：如果该方法不需要额外参数，那么方法后的（）可以不添加。
  - 情况二：如果需要同时传入某个参数，同时需要event是，可以通过 $event 传入事件。

## Vue3 基础-模板语法（二）

### 条件渲染

- 在某些情况下，我们需要根据当前的条件决定某些元素或组件是否渲染，这个时候我们就需要进行条件判断了。
- Vue 提供了下面的指令来进行条件判断：
  - v-if
  - v-else
  - v-else-if
  - v-show
- v-if 的渲染原理：
  - v-if 是惰性的；
  - 当条件为 false 时，其判断的内容完全不会被渲染或者会被销毁掉；
  - 当条件为 true 时，才会真正渲染条件块中的内容；
- template 元素
  - 因为 v-if 是一个指令，所以必须将其添加到一个元素上：
    - 如果我们希望切换的是多个元素呢？
    - 我们**渲染div**，但是我们**并不希望div这种元素被渲染**；
    - 我们可以选择使用 **template**；
  - template 元素可以当做不可见的包裹元素，并且在 v-if 上使用，但是最终 template 不会被渲染出来：
    - 有点类似于小程序中的block
- v-show 和 v-if 的区别
  - 首先，在用法上的区别：
    - v-show 是不支持 template；
    - v-show 不可以和 v-else 一起使用；

### 列表渲染

- 在真实开发中，我们往往会从服务器拿到一组数据，并且需要对其进行渲染。
  - 这个时候我么可以使用 **v-for** 指令；
- v-for 基本使用
  - v-for 的基本格式是 "item in 数组"；
    - 数组通常是来组 **data后者prop**，也可以是其他方式；
    - item 是我们给每项元素起的一个**别名**，这个别名可以自己来定义；
- template 元素
  - 类似于 v-if，你可以使用 template 元素来循环渲染一段包含多个元素的内容；
    - 我们使用template 来对多个元素进行包裹，而不是使用 div 来完成；
- 数组更新检测
  - Vue 将被侦听的数组的变更方法进行了包裹，所以它们也将会触发视图更新。这些被包裹过的方法包括：
    - push()
    - pop()
    - shift()
    - unshift()
    - splice()
    - sort()
    - reverse()
  - **替换数组的方法**
    - 上面的方法会直接修改原来的数组，但是某些方法不会替换原来的数组，而是会生成新的数组，比如 filter()、concat()和 slice()。
- v-for中的key是什么作用？
  - 在使用 v-for 进行列表渲染时，我们通常会给元素或者组件绑定一个 **key属性**。
  - 这个 key 属性有什么作用呢？
    - key 属性主要用在 Vue 的**虚拟DOM算法**，在**新旧nodes**对比时辨识 **VNodes**；
    - 如果不使用 key， Vue 会使用一种最大限度减少动态元素并且尽可能的尝试就地**修改/复用相同类型元素**的算法；
    - 而**使用 key**时，它会基于 key 的变化**重新排列元素顺序**，并且会**移除/销毁key**不存在的元素；

- 插入 F 的案例

  ![insert_f](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202312142139061.webp)

## Vue3 的 Options-API

### 计算属性 computed

- 复杂 data 的处理方式
  - 我们可能需要对**数据进行一些转化后**再显示，或者需要**将多个数据结合起来**进行显示；
    - 比如需要对**多个 data 数据进行运算、三元运算符来决定结果、数据进行某种转化**后显示；
    - 在模板中使用**表达式**，可以非常方便的实现，但是设计它们的初衷是用于**简单的运算**；
    - 在模板中放入太多的逻辑会让**模板过重和难以维护**；
    - 并且如果多个地方都使用到，那么会有大量重复的代码；
  - 有没有什么方法可以将逻辑抽离出去呢？
    - 其中一种方式就是将逻辑抽取到一个 **method** 中，放到 methods 的 options 中；
    - 这种做法有一个直观的弊端，就是所有的 data 使用过程都会变成了一个**方法的调用**；
    - 另外一种方式就是使用计算属性**computed**；
- 认识计算属性 computed
  - 什么是计算属性呢？
    - 对于任何包含响应式数据的复杂逻辑，都应该使用 **computed**；
    - **计算属性**将被混入到组件实例中，所有 getter 和 setter 的 this 上下文自动地绑定为组件实例；
  - 计算属性的用法：
    - 选项：computed
    - 类型：{[key:string]:Function|{get: Function,set:Function}}
- 计算属性 vs methods
  - 计算属性是**有缓存的**。
    - 计算属性会基于它们的**依赖关系进行缓存**；
    - 在**数据不发生变化**时，计算属性是**不需要重新计算**的；
    - 如果**依赖的数据发生变化**，在使用时，计算属性依然**会重新进行计算**；
- 计算属性的 setter 和 getter
  - 计算属性在大多数情况下，只需要一个**getter方法**即可，所以我们会将计算属性直接**写成一个函数**。

### 认识侦听器 watch

- 什么是侦听器呢？
  - 我们在 data 返回的对象中定义了数据，这个数据通过**插值语法等方式绑定到 template**中；
  - 当数据变化时，template 会自动进行更新来显示最新的数据；
  - 在某些情况下，我们希望在**代码逻辑** 中监听某个数据的变化，这个时候就需要**侦听器 watch**来完成了；
- 侦听器的用法如下：
  - 选项：watch
  - 类型：{[key:string]:string|Function|Object|Array}
- 侦听器 watch 的配置选项
  - 默认情况下，**watch只是在侦听 info 的引用变化**，对于**内部属性的变化是不会做出响应**的；
    - 可以使用一个**选项deep**进行更深层的侦听；
  - 还有另外一个属性，是**希望一开始的就会立即执行一次**：
    - 可以使用**immediate选项**；
    - 这个时候无论后面数据是否有变化，侦听的函数都会有限执行一次；
- 侦听器 watch 的其他方式
  - **使用 $watch 的 API**：
  - 我们可以在 created 的生命周期中，使用 this.$watch 来侦听；
    - 第一个参数是要侦听的源；
    - 第二个参数是侦听的回调函数 callback；
    - 第三个参数是额外的其他选项，比如 deep、immediate；

## Vue3 的表单和开发模式

### v-model

- v-model 的基本使用
  - **表单提交**是开发中非常常见的功能，也是和用户交互的重要手段：
    - 比如用户在**登录、注册**时需要提交账号密码；
    - 比如用户在**检索、创建、更新**信息时，需要提交一些数据；
  - 这些都是要求我们可以在**代码逻辑中获取到用户提交的数据**，我们通常会使用 **v-model 指令** 来完成：
    - **v-model指令**可以在表单 input、textarea 以及 select 元素上创建 **双向数据绑定**；
    - 它会根据 **控件类型** 自动选取正确的方法来更新元素；
    - 尽管有些神奇，**但 v-model 本质上不过是语法糖**，它**负责监听用户的输入时间来更新数据**，并在某种极端场景下进行一些特殊处理；
- v-model 的原理
  - **v-model 的原理**其实是背后有两个操作：
    - v-bind 绑定 value 属性的值；
    - v-on 绑定 input 事件监听到函数中，函数会获取最新的值赋值到绑定的属性中；

      ```html
      <input v-model="searchText" />
      ```

      等价于

      ```html
      <input :value="searchText" @input="searchText = $event.target.value" />
      ```

- v-model 的值绑定
  - 在真实开发中，我们的**数据可能是来自服务器**的，那么我们就可以先将值**请求下来，绑定到data返回的对象**中，再**通过v-bind 来进行值** 的绑定，这个过程就是 **值绑定**。
- v-model 修饰符 - lazy  
  - 默认情况下，v-model 在进行双向绑定时，绑定的值是 **input事件**，那么会在每次内容输入后就将最新的值和绑定的属性进行同步；
  - 如果我们在 v-model 后跟上 lazy 修饰符，那么会将绑定的事件切换为 **change 事件**，只有在提交时（比如回车）才会触发；
- v-model 修饰符 - number
  - v-model 绑定后的值总是 **string 类型**，即使我们 **设置 type 为 number 也是 string 类型**
- v-model 修饰符 - trim
  - 如果要自动过滤用户输入的空格，则可以使用 **trim 修饰符**;

### 组件化开发

- Vue 的组件化
  - 我们的 creatApp 函数传入了一个 **对象App**，这个对象其实本质上就是**一个组件**，也是我们应用程序的**根组件**；
  - 组件化提供了一种抽象，让我们可以开发出**一个个独立可复用的小组件**来构造我们的应用；
  - 任何的应用都会被抽象成一颗**组件树**；
- 注册组件的方式
- 组件的名称
  - 在通过 app.component 注册一个组件的时候，第一个参数是组件的名称，定义组件名的方式有两种：
  - **方式一：使用 kebeb-case（短横线分隔符）**
  - **方式二：使用 PascalCase（驼峰命名）**
- 注册局部组件
  - 全局组件往往是在应用程序一开始就会**全局组件**完成，那么就意味着如果**某些组件我们并没有用到，也会一起被注册：**
    - 比如我们注册了**三个全局组件：** ComponentA、ComponentB、ComponentC；
    - 在开发中我们只使用了**ComponentA、ComponentB**，如果**ComponentC 没有用到**但是我们依然在全局进行了注册，那么就意味着**类似与webpack这种打包工具在打包我们的项目**时，我们依然会**对其进行打包**；
    - 这样最终打包出的 JavaScript 包就会有**关于 ComponentC 的内容**，用户在下载对应的 JavaScript 时也会 **增加包的大小**；
  - **所以在开发中我们通常使用组件的时候采用的都是局部注册：**
    - **局部注册**是在我们需要使用到的组件中，通过 **components 属性选项** 来进行注册；
    - 比如之前的 App 组件中，我们有 data、computed、methods 等选项了，事实上还可以有一个 **components选项**；
    - 该 components 选项对应的 **是一个对象**，对象中的键值对是**组件的名称：组件对象**；
- Vue 的开发模式
  - 在真实开发中，我们可以通过一个**后缀名为.vue**的 **single-file components 的单文件组件**来解决，并且可以使用 webpack 或者 vite 或者 rollup 等构建工具来对其进行处理。
  - 如果我们想要使用这一的 SFC 的 .vue 文件，比较**常见的是两种方式：**
    - 方式一：**使用 Vue CLI 来创建项目**，项目会默认帮助我们配置好所有的配置选项，可以在其中直接使用 .vue 文件；
    - 方式二：自己**使用 Webpack 或者 rollup 或者 vite 等构建工具来处理** .vue 文件。

## Webpack 基础打包

### Webpack 到底是什么呢？

- webpack 是一个静态的模块化打包工具，为现代的 JavaScript 应用程序；

- 对上面的解释进行拆解：
  - **打包 bundler：** webpack 可以将帮助我们进行打包，所以它是一个打包工具
  - **静态的static：** 这样表述的原因是我们最终可以将代码打包成最终的静态资源（部署到静态服务器）；
  - **模块化 module：** webpack 默认支持各种模块化开发， ES Module、CommonJS、 AMD 等；
  - **现代的 modern：** 我们前面说过，正是因为现代前端开发面临各种各样的问题，才催生了 webpack 的出现和发展；

### Vue 项目加载的文件有哪些呢？

- JavaScript 的打包：
  - 将 ES6 转换成 ES5 的语法；
  - TypeScript 的处理，将其转换成 JavaScript；

- Css 的处理：
  - CSS 文件模块的加载、提取；
  - Less、Sass 等预处理器的处理；

- 资源文件 img、font；
  - 图片 img 文件的加载；
  - 字体 font 文件的加载

- HTML 资源的处理：
  - 打包 HTML 资源文件；

- 处理 vue 项目的 SFC 文件.vue文件；

### Webpack 的使用前提

- webpack 的官方文档是 <https://webpack.js.org/>
  - webpack 的中文官方文档是 <https://webpack.docschina.org/>
  - DOCUMENTATION：文档详情，也是我们最关注的

- Webpack 的运行是依赖 **Node环境**的，所以我们电脑上必须有 Node 环境
  - 所以我们需要先安装 Node.js，并且同时会安装 npm；
  - 当前电脑上的 node 版本是 v14.15.5,npm 版本是 v6.14.11（你也可以使用 nvm 或者 n 来管理 Node 版本）；
  - Node 官方网站：<https://nodejs.org/>

### Webpack 的安装

- webpack 的安装目前分为两个： **webpack**、 **webpack-cli**

- **它们是什么关系呢？**
  - 执行 webpack 命令，会执行 node_modules 下的 bin 目录下的 webpack；
  - webpack 在执行时是依赖 webpack-cli 的，如果没有安装就会报错；
  - 而 webpack-cli 中代码执行时，才是真正利用 webpack 进行编译和打包的过程；
  - 所以在安装 webpack 时，我们需要同时安装 webpack-cli （第三方的脚手架事实上是没有使用 webpack-cli 的，而是类似于自己的 vue-service-cli 的东西）

### Webpack 的默认打包

- 我们可以通过 webpack 进行打包，之后运行**打包之后**的代码
  - 在目录下直接执行 webpack 命令
    `webpack`
- **生成一个 dist 文件夹，里面存放一个 main.js 的文件，就是我们打包之后的文件：**
  - 这个文件中的代码被压缩和丑化了；
  - 另外我们发现代码中依然存在 ES6 的语法，比如箭头函数、const 等，这是因为默认情况下 webpack 并不清楚我们打包后的文件是否需要转成 ES5 之前的语法，后续我们需要通过 babel 来进行转换和设置；
- **我们发现是可以正常进行打包的，但是有一个问题，webpack 是如何确定我们的入口的呢？**
  - 事实上，当我们运行 webpack 时，webpack 会查找当前目录下的 src/index.js 作为入口；
  - 所以，如果当前项目中没有存在 src/index.js 文件，那么会报错；
- **当然，我们也可以通过配置来指定入口和出口**
  `npx webpack --entry ./src/main.js --output-path ./build`

### 创建局部的 webpack

- 前面我们直接执行 webpack 命令使用的是全局的 webpack，如果希望使用局部的可以按照下面的步骤来操作。
- 第一步：创建 package.json 文件，用于管理项目的信息、库依赖等
  `npm init`
- 第二步：安装局部的 webpack
  `npm install webpack webpack-cli -D`
- 第三步：使用局部的 webpack
  `npx webpack`
- 第四步：在 package.json 中创建 scripts 脚本，执行脚本打包即可
  `npm run build`

### webpack 配置文件

- 在通常情况下，webpack 需要打包的项目是非常复杂的，并且我们需要一系列的配置来满足要求，默认配置必然是不可以的。
- 我们可以在根目录下创建一个 webpack.config.js 文件，来作为 webpack 的配置文件；
- 继续执行 webpack 命令，依然可以正常打包
  `npm run build`

### css-loader 的使用

- 我们需要一个 loader 来加载这个 css 文件，但是 **loader** 是什么呢？
  - loader 可以用于对**模块的源代码**进行转换；
  - 我们可以**将 css 文件也看成是一个模块**，我们是**通过 import 来加载这个模块** 的；
  - 在加载这个模块时，**webpack 其实并不知道如何对其进行加载**，我们必须指定对应的 loader 来完成这个功能；
- 我们需要一个什么样的 loader 呢？
  - 对于加载 css 文件来说，我们需要一个可以读取 css 文件的 loader；
  - 这个 loader 最常用的是 **css-loader**；
- css-loader 的安装：
  `npm install css-loader -D`

### css-loader 的使用方案

- 如何使用这个 loader 来加载 css 文件呢？ 有三种方式：
  - 内联方式；
  - CLI 方式（webpack5 中不再使用）
  - 配置方式；

### loader 配置方式

- 配置方式表示的意思是在我们的 webpack.config.js 文件中写明配置信息：
  - module.rules 中允许我们配置多个 loader（因为我们也会继续使用其他的 loader，来完成其他文件的加载）；
  - 这种方式可以更好的表示 loader 的配置，也方便后期的维护，同时也让你对各个 Loader 有一个全局的概览；
- **module.rules 的配置如下：**
- rules 属性对应的值是一个数组：[Rule]
- 数组中存放的是一个个的 Rule，Rule 是一个对象，对象中可以设置多个属性：
  - **test 属性**：用于对 resource（资源） 进行匹配的，通常会设置成正则表达式；
  - **use 属性**：对应的值是一个数组：[UseEntry]
    - UseEntry 是一个对象，可以通过对象的属性来设置一些其他属性
      - **loader**：必须有一个 loader 属性，对应的值是一个字符串；
      - **options**：可选的属性，值是一个字符串或者对象，值会被传入到 loader 中；
      - **query**：目前已经使用 options 来替代；
    - **传递字符串**（如：use:['style-loader'] 是 loader 属性的简写方式（如：use[{loader: 'style-loader'}]）；
  - **loader属性**：Rule.use:[{loader}] 的简写。

### 认识 style-loader

- css 在我们的代码中并**没有生效（页面没有效果）**。
  - 因为 css-loader 只是**负责将 .css 文件进行解析**，并不会将解析之后的**css插入到页面**中；
  - 如果我们希望再完成**插入 style 的操作**，那么我们还需要另外一个 loader，就是 **style-loader**；
- 安装 style-loader
  `npm install style-loader -D`

### 如何处理 less 文件？

- 在我们开发中，我们可能会使用**less、sass、stylus 的预处理器**来编写 css 样式，效率会更高。
- 如何可以让我们的**环境支持这些预处理器**呢？
  - less、sass 等编写的 css 需要通过工具转换成普通的 css；
- 我们可以使用 less 工具来完成它的贬义词转换：
  `npm install less -D`
- 执行如下命令
  `npx lessc ./src/css/title.less title.css`

### less-loader 处理

- 我们可以使用 less-loader，来自动使用 less 工具转换 less 到 css；
  `npm install less-loader -D`
- 配置 webpack.config.js

  ```js
  module.exports = {
    module: {
      rules: [
        {
          test: /\.less$/,
          use: [
            'style-loader',
            'css-loader',
            'less-loader'
          ]
        }
      ]
    }
  }
  ```

- 执行 `npm run build`，less 就可以自动转换成 css，并且页面也会生效了。

### 认识 PostCSS 工具

- 什么是 PostCSS 工具呢？
  - PostCSS 是一个通过 JavaScript 来转换样式的工具；
  - 这个工具可以帮助我们进行一些 CSS 的转换和适配，比如自动添加浏览器前缀、css 样式的重置；
  - 但是实现这些功能，我们需要借助于 PostCSS 对应的插件；
- 如何使用 PostCSS 呢？主要就是两个步骤：
  - 第一步：查找 PostCSS 在构建工具中的扩展，比如 webpack 中的 postcss-loader；
  - 第二步：选择可以添加你需要的 PostCSS 相关的插件；

### 命令行使用 postcss

- 直接在终端使用 PostCSS 呢？
  - 单独安装一个工具 postcss-cli；
    `npm install postcss postcss-cli -D`
- 我们编写一个需要添加前缀的 css：
  - <https://autoprefixer.github.io>
  - 我们可以在上面的网站中查询一些添加 css 属性的样式；

### 插件 autoprefixer

- 因为我们需要需要添加前缀，所以我们需要安装一个插件 autoprefixer
  `npm install autoprefixer -D`
- 直接使用 postcss 工具，并且指定使用 autoprefixer 插件
  `npx postcss --use autoprefixer -o end.css ./src/css/style.css`

### postcss-loader

- 真实开发中我们必然不会直接使用命令行工具来对 css 进行处理，而是可以借助于构建工具：
  - 在 webpack 中使用 postcss 就是使用 postcss-loader 来处理的；
  `npm install postcss-loader -D`
- 修改加载 css 的 loader：
  - ⚠️ 注意：因为 postcss 需要有对应的插件才会起效果，所以我们需要配置它的 plugin：

### 单独的 postcss 配置文件

- 我们也可以将这些配置信息放到一个单独的文件中进行管理：
  - 在根目录下创建 postcss.config.js

### postcss-preset-env

- 我们在配置 postcss-loader 时，我们配置插件并不需要使用 autoprefixer。
- 我们可以使用另外一个插件： postcss-preset-env
  - postcss-preset-env 也是一个 postcss 的插件；
  - 它可以帮助我们将一些现代的 CSS 特性，转成大多数浏览器认识的 CSS，并且会根据目标浏览器或者运行时环境添加所需的polyfill；
  - 也包括会自动帮助我们添加 autoprefixer（所以相当于已经内置了 autoprefixer）；
- 安装 postcss-preset-env
  - `npm install postcss-preset-env -D`

## webpack 打包其他资源

### 图片资源

- 加载图片案例准备
  - 在项目中使用图片，比较常见的使用图片的方式是两种：
    - **img 元素**，设置 **src 属性**；
    - **其他元素**（比如 div），设置 **background-image** 的 css 属性；
- file-loader
  - 要处理jpg、png 等格式的图片，我们也需要有对应的 loader： **file-loader**
    - file-loader 的作用就是帮助我们处理 **import/require() 方式** 引入的一个文件资源，并且会将它放到我们**输出的文件夹**中；
  - 安装 file-loader
    - `npm install file-loader -D`
  - 文件的命名规则
    - 我们处理后的**文件名称**按照一定的规则进行显示：
      - 比如保留原来的**文件名、扩展名**，同时为了防止重复，包含一个**hash值**等；
    - 这个时候我们可以使用**PlaceHolders**来完成，webpack 给我们提供了大量的 PlaceHolders 来显示不同的内容；
      - <https://webpack.js.org/loaders/file-loader/#placeholders>
      - 我们可以在文档中查阅自己需要的 placeholder；
    - 介绍几个最常用的 placeholder：
      - **[ext]：** 处理文件的扩展名；
      - **[name]：** 处理文件的名称：
      - **[hash]：** 文件的内容，使用 MD4 的散列函数处理，生成的一个 128 位的 hash 值（32个十六进制）；
      - **[contentHash]：** 在 file-loader 中和 [hash] 结果是一致的（在 webpack 的一些其他地方不一样）；
      - **[hash:<length>]：** 截图 hash 的长度，默认 32 个字符太长了；
      - **[path]：** 文件相对于 webpack 配置文件的路径；
- url-loader
  - **url-loader** 和 **file-loader** 的工作方式是相似的，但是可以将较小的文件，转成 **base64 的 URI**。
  - 安装 url-loader
    - `npm install url-loader -D`
  - 默认情况下 url-loader 会将所有的图片文件转成 base64 编码；
  - url-loader 的 limit
    - 开发中我们往往是**小的图片需要转换**，但是**大的图片直接使用图片**即可
      - 这是因为**小的图片转换 base64**之后可以**和页面一起被请求**，**减少不必要的请求过程**；
      - 而**大的图片也进行转换**，反而会**影响页面的请求速度**；
    - 我们如何可以**限制哪些大小的图片转换和不转换**呢？
      - url-loader 有一个 options 属性 **limit**，可以用于设置转换的限制；
- 认识 asset module type
  - **我们当前使用的 webpack 版本是 webpack5：**
    - 在 webpack5 之前，加载这些资源我们需要**使用一些 loader，比如 raw-loader、url-loader、file-loader**；
    - 在 webpack5 开始，我们可以直接使用 **资源模块类型（asset module type）**，来替代上面的这些 loader；
  - **资源模块类型（asset module type）**，通过添加 4 种新的模块类型，来替换所有这些 loader：
    - **asset/resource** 发送一个单独的文件并导出 URL。之前通过使用 file-loader 实现；
    - **asset/inline** 导出一个资源的 data URI。之前通过使用 url-loader 实现；
    - **asset/source** 导出资源的源代码。之前通过使用 raw-loader 实现；
    - **asset** 在导出一个 data URI 和发送一个单独的文件之间自动选择。之前通过使用 url-loader，并且配置资源体积限制实现；

### 认识 Plugin

- Webpack 的另一个核心是 Plugin：
  - Loader 是用于**特定的模块类型**进行转换；
  - Plugin 可以用于**执行更加广泛的任务**，比如打包优化、资源管理、环境变量注入等； 
- CleanWebpackPlugin
  - 每次重新打包时，都需要**手动删除dist文件夹**：
  - `npm install clean-webpack-plugin -D`
- HtmlWebpackPlugin
  - 还有一个**不太规范**的地方：
    - 我们的 HTML 文件是编写在根目录下的，而最终打包的**dist文件夹中是没有 index.html 文件**的。
    - 在**进行项目部署**时，必然也是需要**有对应的入口文件 index.html**；
    - 所以我们也需要对 **index.html 进行打包处理**；
  - 对 HTML 进行打包处理我们可以使用另外一个插件：**HtmlWebpackPlugin**；
  - `npm install html-webpack-plugin -D`  
  - 在配置 HtmlWebpackPlugin 时，我们可以添加如下配置：
    - **template**：指定我们要使用的模块所在的路径；
    - **title**：在进行 htmlWebpackPlugin.options.title 读取时，就会读到该信息；
- DefinePlugin 的介绍
  - 在我们的模块中还使用到一个 **BASE_URL 的常量** ：
  - DefinePlugin 允许在编译时创建配置的全局常量，是一个 webpack 内置的插件（不需要单独安装）；
- CopyWebpackPlugin
  - 在 vue 的打包过程中，如果我们将一些文件**放到 public 的目录**下，那么这个目录会**被复制到 dist 文件夹**中。
  - 安装 CopyWebpackPlugin 插件：
    - `npm install copy-webpack-plugin -D`
  - **接下来配置 CopyWebpackPlugin 即可：**
    - 复制的规则在 patterns 中设置；
    - **from：** 设置从哪一个源中开始复制；
    - **to：** 复制到的位置，可以省略，会默认复制到打包的目录下；
    - **globOptions：** 设置一些额外的选项，其中可以编写需要忽略的文件：
      - .DS_Store: mac 目录下会自动生成的一个文件；
      - index.html：也不需要复制，因为我们已经通过 HtmlWebpackPlugin 完成了 index.html 的生成；

### Mode 配置

- `development`：会将 `DefinePlugin` 中 `process.env.NODE_ENV` 的值设置为 `development` 为模块和 chunk 启用有效的名。
- `production`：会将 `DefinePlugin` 中 `process.env.NODE_ENV` 的值设置为 `production` 为模块和 chunk 启用确定性的混淆名称，`FlagDependencyUsagePlagin` 和 `FlagIncludedChunksPlugin` ，`ModuleConcatenationPlugin` ，`NoEmitOnErrorsPlugin` ，`TerserPlugin`。
- `none`：不使用任何默认优化选项。

## Babel 和 dev-server

### Babel

- 为什么需要 babel ？
  - Babel 是一个**工具链**，主要用于旧浏览器或者环境中将 ECMAScript 2015+ 代码转换为向后兼容版本的 JavaScript；
  - 包括：语法转换、源代码转换等；
- Babel 命令行使用
  - babel 本身可以作为**一个独立的工具**（和 postcss 一样），不和 webpack 等构建工具配置来单独使用。 
  - 如果我们希望在命令行尝试使用 babel，需要安装如下库：
    - **@babel/core**：babel 的核心代码，必须安装；
    - **babel/cli**：可以让我们在命令行使用 babel；
      `npm install @babel/core @babel/cli -D`
  - 使用 babel 来处理我们的源代码：
    - src：是源文件的目录；
    - --out-dir：指定要输出的文件夹 dist；
  - 插件的使用
    - 比如我们需要转换箭头函数，那么我们就可以使用**箭头函数转换相关的插件**；
    - `npm install @babel/plugin-transform-arrow-functions -D`
    - `npx babel src --out-dir dist --plugins=@babel/plugin-transform-arrow-functions`
    - const 转成 var
    - `npm install @babel/plugin-transform-block-scoping -D`
    - `npx babel src --out-dir dist --plugins=@babel/plugin-transform-arrow-functions,@babel/plugin-transform-block-scoping`
- Babel 的预设 preset
  - 但是如果要转换的内容过多，一个个设置是比较麻烦的，我们可以使用预设（preset）：
  - 安装 @babel/preset-env 预设：
  - `npm install @babel/preset-env -D`
  - 执行如下命令：
  - `npx babel src --out-dir dist --presets=@babel/preset-env`
- Babel 的底层原理
  - babel 是如何做到将我们的**一段代码（ES6、TypeScript、React）**转成**另外一段代码（ES5）**的呢？
    - 从一种**源代码（原生语言）**转换成**另一种源代码（目标语言）**，这是什么的动作呢？
    - 就是**编译器**，事实上我们可以将 babel 看成就是一个编译器。
    - Babel 编译器的作用就是**将我们的源代码**，转换成浏览器可以直接识别的**另外一段源代码**；
  - **Babel 也拥有编译器的工作流程：**
    - 解析阶段（Parsing）；
    - 转换阶段（Transformation）；
    - 生成阶段（Code Generation）；
  - <https://github.com/jamiebuilds/the-super-tiny-compiler>
- babel-loader
  - 在实际开发中，我们通常会在构建工具中通过配置 babel 来对其进行使用的，比如在 webpack 中。
  - 那么我们就需要去安装相关的依赖：
    - 如果之前已经安装了 @babel/core，那么这里不需要再次安装；
      - `npm install babel-loader @babel/core -D`
- babel-preset
  - 如果我们一个个去安装使用插件，那么需要手动来管理大量的 babel 插件，我们可以直接给 webpack 提供一个 preset，webpack 会根据我们的预设来加载对应的插件列表，并且将其传递给 babel。
  - 比如常见的预设有三个：
    - env
    - react
    - typescript
  - 安装 preset-env：
    - `npm install @babel/preset-env -D`
- Babel 的配置文件
  - 像之前一样，我们可以将 babel 的配置信息放到一个独立的文件中，babel 给我们提供了两种配置文件的编写：
    - babel.config.json（或者 .js，.cjs, .mjs）文件；
    - .babelrc.json（或者 .babelrc.js，.babelrc.cjs, .babelrc.mjs）文件；

### Vue 源码的打包

- Vue 打包后不同版本解析
  - vue(.runtime).global(.prod).js:
    - 通过浏览器中的 `<script src= "..."></script>` 直接使用；
    - 我们之前通过 CDN 引入和下载的 Vue 版本就是这个版本
    - 会暴露一个全局的 Vue 来使用；
  - vue(.runtime).esm-browser(.prod).js:
    - 用于通过原生 ES 模块导入使用（在浏览器中通过 `<script type="module"></script>` 来使用）。
  - vue(.runtime).esm-bundler.js:
    - 用于 webpack、rollup 和 parcel 等构建工具；
    - 构建工具中默认是 vue.runtime.esm-bundler.js;
    - 如果我们需要解析模版 template，那么需要手动指定 vue.esm-bundler.js；
  - vue.cjs(.prod).js:
    - 服务器端渲染使用；
    - 通过 require() 在 Node.js 中使用；
- 运行时 + 编译器 vs 仅运行时
  - 在 Vue 的开发过程中我们有**三种方式**来编写 DOM 元素：
    - 方式一：**template模版**的方式（之前经常使用的方式）；
    - 方式二：**render函数**的方式，使用 h 函数来编写渲染的内容；
    - 方式三：通过 **.vue文件**中的 template 来编写模版；
  - **它们的模板分别是如何处理的呢？**
    - 方式二中的 h 函数可以直接返回一个**虚拟节点**，也就是**Vnode节点**；
    - 方式一和方式三的 template 都需要有 **特定的代码** 来对其进行解析；
      - 方式三 .vue 文件中的 template 可以通过在 **vue-loader** 对其进行编译和处理；
      - 方式一中的 template 我们必须要**通过源码中一部分代码**来进行编译；
  - 所以，Vue 在让我们选择版本的时候分为 **运行时+编译器** vs **仅运行时**
    - **运行时+编译器**包含了对 template 模板的编译代码，更加完整，但是也更大一些；
    - **仅运行时**没有包含对 template 版本的编译代码，相对更小一下； 
- VSCode 对 SFC 文件的支持
  - 真实开发中多数情况下我们都是使用 SFC （**single-file components（单文件组件）**）。
  - 我们先说一下 VSCode 对 SFC 的支持：
    - 插件一：Vetur，从 Vue2 开发就一直在使用的 VSCode 支持 Vue 的插件；
    - 插件二：Volar，官方推荐的插件（后续会基于 Volar 开发官方的 VSCode 插件）；
- 编写 App.vue 代码
  - 编写自己的 App.vue 代码：

    ![app-vue](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20231224231055_kgp50Q.png)

    ![index](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20231224231417_BFWgO4.png)
- App.vue 的打包过程
  - 使用 vue-loader：
    - `npm install vue-loader -D`
  - 在 webpack 的模板中进行配置：

    ```js
    module.exports = {
      module: {
        rules: [
          {
            test: /\.vue$/,
            loader: 'vue-loader'
          }
        ]
      }
    }
    ```

  - 添加 @vue/compiler-sfc 来对 template 进行解析：
    - `npm install @vue/compiler-sfc -D`
  - 另外我们需要配置对应的 Vue 插件：
  
    ```js
    const { VueLoaderPlugin } = require('vue-loader/dist/index')
    module.exports = {
      module: {
        rules: [
          {
            test: /\.vue$/,
            loader: 'vue-loader'
          }
        ],
        plugins: [
          new VueLoaderPlugin()
        ]
      }
    }
    ```
  
  - 重新打包即可支持 App.vue 的写法
  - 另外，我们也可以编写其他的 .vue 文件来编写自己的组件；

### 为什么要搭建本地服务器？

- **为了完成自动编译，webpack 提供了几种可选的方式：**
  - webpack watch mode；
  - webpack-dev-server（常用）；
  - webpack-dev-middleware；
- webpack watch
  - webpack 给我们提供了 watch 模式：
    - 在该模式下，webpack 依赖图中的所有文件，只要有一个**发生了更新**，那么代码将**被重新编译**；
    - 我们**不需要手动**去运行 npm run build 指令了；
  - 如何开启 watch 呢？两种方式：
    - 方式一：在导出的配置中，添加 **watch:true**；
    - 方式二：在启动 webpack 的命令中，添加 **--watch 的标识**；
- webpack-dev-server
  - 上面的方式**可以见听到文件的变化**，但是事实上它本身是**没有自动刷新浏览器的功能**的；
    - 当然，目前我们可以在 VSCode 中使用 live-server 来完成这样的功能；
    - 但是，我们希望在**不使用 live-server** 的情况下，可以具备 **live reloading （实时重新加载）** 的功能；
  - **安装 webpack-dev-server**
    - `npm install webpack-dev-server -D`
  - **修改配置文件**，告知 dev server，从什么位置查找文件：

    ```javascript
    devServer: {
      contentBase: "./public"
    },
    ```

    开发阶段：contentBase
    打包阶段：copywebpackplugin

    ```javascript
    target: "web",
    "serve": "webpack serve --config wk.config.js",
    ```

  - webpack-dev-server 在编译之后**不会写入到任何输出文件**，而是将 bundle 文件**保留在内存**中：
    - 事实上 webpack-dev-server 使用了一个库叫 memfs（memory-fs webpack 自己写的）
  - 认识模块热替换（HMR）
    - 什么是 HMR 呢？
      - HMR 的全称是 **Hot Module Replacement**，翻译为**模块热替换**；
      - 模块热替换是指在**应用程序运行过程中，替换、添加、删除模块**，而**无需重新刷新整个页面**；
    - HMR 通过如下几种方式，来提高开发的速度：
      - **不重新加载整个页面**，这样**可以保留某些应用程序的状态不丢失**；
      - 只更新**需要变化的内容**，**节省开发的时间**；
      - 修改了**css、js源代码**，会**立即在浏览器更新**，相当于直接在浏览器的 devtools 中直接修改样式；
    - 如何使用 HMR 呢？
      - 默认情况下，**webpack-dev-server 已经支持 HMR**，我们**只需要开启即可**；
      - 在不开启 HMR 的情况下，当我们修改了源代码之后，整个页面会自动刷新，使用的是 live reloading；
  - 开启 HMR
    - 修改 webpack 的配置：

    ```javascript
    target: "web",
    devServer: {
      hot: true
    },
    ```

    - **当我们修改了某一个模块的代码时，依然是刷新的整个页面：**
      - 这是因为我们需要去**指定哪些模块发生更新**时，进行 HMR；

      ```javascript
      if (module.hot) {
        module.hot.accept("./util.js", () => {
          console.log("util 更新了");
        })
      }
      ```

  - 框架的 HMR
    - 在开发其他项目时，**我们是否需要经常手动去写入 module.hot.accept 相关的 API 呢？**
      - 比如**开发 Vue、React 项目**，我们**修改了组件**，希望**进行热更新**，这个时候**应该如何去操作**呢？
      - vue 开发中，我们使用 **vue-loader**，此 loader 支持 vue 组件的 HMR，提供开箱即用的体验；
      - react 开发中，有 **React Hot Loader**，实时调整 react 组件（目前 React 官方已经弃用了，改成使用 react-refresh）；
  - HMR 的原理
    - HMR 的原理是什么呢？如何可以做到只更新一个模块中的内容呢？
      - webpack-dev-server 会创建两个服务：**提供静态资源的服务（express）**和**Socket 服务（net.Socket）**；
      - express server 负责直接提供**静态资源的服务**（打包后的资源直接被浏览器请求和解析）；
    - HMR Socket Server，是一个 socket 的长连接：
      - 长连接有一个最好的好处是**建立连接后双方可以通信**（服务器可以直接发送文件到客户端）；
      - 当服务器**监听到对应的模块发生变化**时，会生成**两个文件 .json（manifest描述文件）和.js文件（update chunk）**；
      - 通过长连接，可以直接**将这两个文件主动发送给客户端**（浏览器）；
      - 浏览器**拿到两个新的文件**后，通过 HMR runtime 机制，**加载这两个文件**，并且**针对修改的模块进行更新**； 

      ![HMR](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20231231142809_IMG_0660.PNG)

  - hotOnly、host 配置
    - **host 设置主机地址：**
      - 默认值是 localhost；
      - 如何希望其他地方也可以访问，可以设置为 0.0.0.0；
  - port、open、compress
    - **port 设置监听的端口，默认情况下是 8080**
    - **open 是否打开浏览器：**
      - 默认值是 false，设置为 true 会打开浏览器；
      - 也可以设置为类似于 Google Chrome 等值；
    - **compress 是否为静态文件开启 gzip compression：**
      - 默认值是 false，可以设置为 true；
  - Proxy
    - **proxy 是我们开发中非常常用的一个配置选项，它的目的设置代理来解决跨域访问的问题：**
      - 比如我们的**一个 api 请求是 <http://localhost:8888>**, 但是**本地启动服务器的域名是 <http://localhost：8000>**，这个时候发送网络请求就会**出现跨域的问题**；
      - 那么我们可以将请求**先发送到一个代理服务器，代理服务器和 API 服务器没有跨域的问题**，就可以**解决我们的跨域问题**了；
    - **我们可以进行如下的设置：**
      - **target：** 表示的是代理到的目标地址，比如 /api-hy/moment 会被代理到 http://localhost:8888/api-hy/moment；
      - **pathRewrite：** 默认情况下，我们的 /api-hy 也会被写入到 URL 种，如果希望删除，可以使用 pathRewrite；
      - **secure：** 默认情况下不接收转发到 https 的服务器上，如果希望支持，可以设置为 false；
      - **changeOrigin：** 它表示是否更新代理后请求的 headers 中 host 地址；
  - historyApiFallback
    - **historyApiFallback** 是开发中一个非常常见的属性，它主要的作用是解决 SPA 页面在路由跳转之后，进行页面刷新时，返回 404 的错误。
    - boolean值：默认是 false
      - 如果设置为 true，那么在刷新时，返回 404 错误时，会自动返回 index.html 的内容；
    - object 类型的值，可以配置 rewrites 属性（了解）：
      - 可以配置 from 来匹配路径，决定要跳转到哪一个页面；
    - 事实上 devServer 中实现 historyApiFallback 功能是通过 connect-history-api-fallback 库的：
      - 可以查看 **connect-history-api-fallback** 文档 
- resolve 模块解析
  - resolve 用于设置模块如何被解析：
    - 在开发中我们会有各种各样的模块依赖，这些模块可能来自于自己编写的代码，也可能来自第三方库；
    - resolve 可以帮助 webpack 从每个 require/import 语句中，找到需要引入到合适的模块代码；
    - webpack 使用 **enhanced-resolve** 来解析文件路径；
  - **webpack 能解析三种文件路径：**
    - 绝对路径
      - 由于已经获得文件的绝对路径，因此不需要再做进一步解析
    - 相对路径
      - 在这种情况下，使用 import 或 require 的资源文件所处的目录，被认为是上下文目录；
      - 在 import/require 中给定的相对路径，会拼接此上下文路径，来生成模块的绝对路径；
    - 模块路径
      - 在 resolve.modules 中指定的所有目录检索模块；
        - 默认值是 ['node_modules']，所以默认会从 node_modules 中查找文件；
      - 我们可以通过设置别名的方式来替换初始模块路径，具体看 alias 的配置；
  - 确定文件还是文件夹
    - 如果是一个文件：
      - 如果文件具有扩展名，则直接打包文件；
      - 否则，将使用 resolve.extensions 选项作为文件扩展名解析；
    - 如果是一个文件夹：
      - 会在文件夹中根据 resolve.mainFiles 配置选项中指定的文件顺序查找：
        - resolve.mainFiles 的默认值是 ['index']；
        - 再根据 resolve.extensions 来解析扩展名；
  - extensions 和 alias 配置
    - extensions 是解析到文件时自动添加扩展名：
      - 默认值是 ['.wasm', '.mjs', '.js', '.json']；
      - 所以如果我们代码中想要添加加载 .vue 或者 jsx 或者 ts 等文件时，我们必须自己写上扩展名；
    - 另一个非常好用的功能是配置别名 alias：
      - 特别是当我们项目的目录结构比较深的时候，或者一个文件的路径可能需要 ../../../ 这种路径片段；
      - 我们可以给某些常见的路径起一个别名；

## VueCLI 和 Vite

### Vue CLI 安装和使用

- 安装 Vue CLI
  - 全局安装，这样在任何时候都可以通过 vue 的命令来创建项目；
    - `npm install @vue/cli -g`
  - 升级 Vue CLI：
    - 如果是比较旧的版本，可以通过下面的命令来升级：
      - `npm update @vue/cli -g`
  - 通过 Vue 的命令来创建项目
    - `vue create 项目的名称`
- Vue CLI 的运行原理

  ![运行原理](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240106091708_IMG_0665.PNG)

### Vite

- Vite 的构造
  - 它主要由两部分组成：
    - 一个开发服务器，它基于原生 ES 模块提供了丰富的内建功能，HMR 的速度非常快速；
    - 一套构建指令，它使用 rollup 打开我们的代码，并且它是预配置的，可以输出生成环境的优化过的静态资源；
- Vite 的安装和使用
  - 注意：Vite 本身也是依赖 Node 的，所以也需要安装好 Node 环境
    - 并且 Vite 要求 Node 版本是大于 12 版本的；
  - 首先，我们安装一下 vite 工具：

    ```javascript
    npm install vite -g # 全局安装
    npm install vite -D # 局部安装
    ```

  - 通过 vite 来启动项目：

    `npx vite`

- Vite 对 css 的支持
  - vite 可以直接支持 css 的处理
    - 直接导入 css 即可；
  - vite 可以直接支持 css 预处理器，比如 less
    - 直接导入 less；
    - 之后安装 less 编译器； `npm install less -D`
  - vite 直接支持 postcss 的转换；
    - 只需要安装 postcss，并且配置 postcss.config.js 的配置文件即可；
      `npm install postcss postcss-preset-env -D`
- Vite 对 TypeScript 的支持
  - vite 对 TypeScript 是原生支持的，它会直接使用 ESBuild 来完成编译：
    - 只需要直接导入即可；
  - 如果我们查看浏览器中的请求，会发现请求的依然是 ts 的代码：
    - 这是因为 vite 中的服务器 Connect 会对我们的请求进行转发；
    - 获取 ts 编译后的代码，给浏览器返回，浏览器可以直接进行解析；
  - 注意：在 vite2 中，已经不再使用 Koa 了，而是使用 Connect 来搭建的服务器
    > 由于大多数逻辑应该通过插件钩子而不是中间件来完成，因此对中间件的需求大大减少，内部服务器应用现在是一个很好的旧版的 connect 实例，而不是 Koa。
- Vite 对 Vue 的支持
  - vite 对 vue 提供第一优先级支持：
    - Vue 3 单文件组件支持：**@vitejs/plugin-vue**
    - Vue 3 JSX 支持：**@vitejs/plugin-vue-jsx**
    - Vue 2 支持：**underfin/vite-plugin-vue2**
  - 安装支持 vue 的插件：
    `npm install @vitejs/plugin-vue -D`
  - 在 vite.config.js 中配置插件：

    ```javascript
    import vue from '@vitejs/plugin-vue';

    module.exports = {
      plugins: [
        vue()
      ]
    }
    ```

- Vite 打包项目
  - 我们可以直接通过 vite build 来完成对当前项目的打包工具：`npx vite build`
  - 我们可以通过 preview 的方式，开启一个本地服务来预览打包后的效果：`npx vite preview`
- ESBuild 解析
  - ESBuild 的特点：
    - 超快的构建速度，并且不需要缓存；
    - 支持 ES6 和 CommonJS 的模块化；
    - 支持 ES6 的 Tree Shaking；
    - 支持 Go、JavaScript 的 API；
    - 支持 TypeScript、JSX 等语法编译；
    - 支持 SourceMap；
    - 支持代码压缩；
    - 支持扩展其他插件；
- Vite 脚手架工具
  - 在开发中，我们不可能所有的项目都使用 vite 从零去搭建，比如一个 react 项目，Vue 项目；
    - 这个时候 vite 还给我们提供了对应的脚手架工具；
  - 所以 Vite 实际上是有两个工具的：
    - vite：相当于是一个构建工具，类似于 webpack、rollup；
    - @vitejs/create-app：类似 vue-cli、create-react-app；
  - 如果使用脚手架工具呢？**`npm init @vitejs/app`**
  - 上面的做法相当于省略了安装脚手架的过程：

    ```powershell
    npm install @vitejs/create-app -g
    create-app
    ```

## Vue3 组件化开发(一)

### 组件的通信

- 在开发过程中，我们会经常遇到需要**组件之间相互进行通信**：
  - 比如**App 可能使用了多个 Header**，每个地方的 **Header展示的内容不同**，那么我们就需要使用者**传递给 Header 一些数据**，让其进行展示；
  - 又比如我们在 Main 中一次性 **请求了 Banner 数据和 ProductList数据**，那么就需要**传递给它们**来进行展示；
  - 也可能是**子组件中发生了事件**，需要**由父组件来完成某些操作**，那就需要**子组件向父组件传递事件**；
- 父子组件之间通信的方式
  - 父子组件之间如何进行通信呢？
    - 父组件传递给子组件：**通过 props 属性**；
    - 子组件传递给父组件：**通过 $emit 触发事件**；
  - 父组件传递给子组件
    - 什么是 props 呢？
      - props 是你可以在组件上**注册一些自定义的 attribute**；
      - 父组件给**这些 attribute 赋值**，**子组件通过 attribute 的名称获取到对应的值**；
    - props 有两种常见的用法：
      - **方式一：字符串数组**，数组中的字符串就是 attribute 的名称；
      - **方式二：对象类型**，对象类型我们可以在指定 attribute 名称的同时，指定它需要传递的类型，是否是必须的，默认值等等；
    - props 的对象用法
      - 数组用法中我们**只能说明传入的 attribute 的名称**，并**不能对其进行任何形式的限制**，我们来看一下**对象的写法**是如何让我们的 props 变得更加完善的。
      - 当使用对象语法的时候，我们可以对传入的内容限制更多：
        - 比如指定传入的 **attribute 的类型**；
        - 比如指定传入的 **attribute 是否是必传的**；
        - 比如指定没有传入时，**attribute 的默认值**；
      - **细节一：那么 type 的类型都可以是哪些呢？**
        - String
        - Number
        - Boolean
        - Array
        - Object
        - Date
        - Function
        - Symbol
      - **细节二：对象类型的其他写法**
        ![props](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240107125420_IMG_0667.PNG)
      - **细节三：props 的大小写命名**
        - HTML 中的 **attribute 名是大小写不敏感**的，所以**浏览器会把所有大写字符解释为小写字符**；
        - 这意味着当你**使用 DOM 中的模板**时，**camelCase（驼峰命名法）的 prop 名需要使用其等价的 kebab-case（短横线分隔命名）命名**；
    - 非 prop 的 attribute
      - 当我们**传递给一个组件某个属性**，但是**该属性并没有定义对应的 props 或者 emits** 时，就称之为 **非 prop 的 attribute**；
      - 常见的包括 **class、style、id 属性**等；
      - **attribute 继承**
        - 当**组件有单个根节点**时，非**prop 的 attribute 将自动添加到根节点的 attribute 中**；
      - 如果我们**不希望组件的根元素继承 attribute**，可以在组件中设置 **inheritAttrs: false**；
        - 禁用 attribute 继承的**常见情况**是**需要将attribute应用于根元素之外的其他元素**；
        - 我们可以通过`$attrs` **来访问所有的非 props 的 attribute**；
      - 多个根节点的 attribute
        - **多个根节点的 attribute 如果没有显式的绑定**，那么会报警告的，我们**必须手动的指定要绑定到哪一个属性**上；
  - 子组件传递给父组件
    - 什么情况下子组件需要传递内容到父组件呢？
      - 当**子组件有一些事件发生**的时候，比如在组件中发生了点击，父组件需要切换内容；
      - 子组件**有一些内容想要传递给父组件**的时候；
    - 我们如何完成上面的操作呢？
      - 首先，我们需要在**子组件中定义好在某些情况下触发的事件名称**；
      - 其次，在**父组件以 v-on 的方式传入要监听的事件名称**，并且绑定到对应的方法中；
      - 最后，在子组件中发生某个事件的时候，**根据事件名称触发对应的事件**；

## Vue3 组件化开发（二）

### 非父子组件的通信

- 在开发中，我们构建了组件树之后，除了**父子组件之间的通信**之外，还会有**非父子组件之间**的通信。
- **这里我们主要讲两种方式：**
  - **Provide/Inject**；
  - **Mitt全局事件总线**；
- Provide 和 Inject
  - Provide/Inject 用于**非父子组件之间共享数据**：
    - 比如有**一些深度嵌套的组件**，**子组件想要获取父组件的部分内容**；
    - 在这种情况下，如果我们仍然**将props沿着组件链逐级传递**下去，就会非常的麻烦；
  - 对于这种情况下，**我们可以使用 Provide 和 Inject**：
    - 无论层级结构有多深，父组件都可以作为其子组件的**依赖提供者**；
    - 父组件有一个 **provide 选项**来提供数据；
    - 子组件有一个 **inject 选项**来开始使用这些数据； 
  - 实际上，你可以将依赖注入看作是 "long range props"，除了：
    - 父组件不需要知道哪些子组件使用它 provide 的 property
    - 子组件不需要知道 inject 的 property 来自哪里
  - 我们开发一个这样的结构：
    `App.vue`➡️`Home.vue`➡️`HomeContent.vue`
- 全局事件总线 mitt 库
  - Vue3 从实例中移除了 $on、$off 和 $once 方法，所以我们如果希望**继续使用全局事件总线，要通过第三方库**：
    - Vue3 官方有推荐一些库，**例如 mitt 或 tiny-emitter**；
    - 这里我们主要讲解一下 **mitt库** 的使用；
  - 首先，我们需要先安装这个库：
    - `npm install mitt`
  - 其次，我们可以封装一个工具 eventbus.js：

    ```javascript
    import mitt from 'mitt';
    const emitter = mitt();
    export default emitter;
    ```

  - mitt 的事件的取消
    - 在某些情况下我们可能希望**取消掉之前注册的函数监听：**

      ```javascript
      // 取消 emitter 中所有的监听
      emitter.all.clear()

      // 定义一个函数
      function onFoo() {}
      emitter.on('foo', onFoo) // 监听
      emitter.off('foo', onFoo) // 取消监听
      ```

### 认识插槽 Slot

- **在开发中，我们会经常封装一个个可复用的组件：**
  - 前面我们会**通过 props 传递**给组件一些数据，让组件来进行展示：
  - 但是为了让这个组件具备**更强的通用性**，我们**不能将组件中的内容限制为固定的div、span**等这些元素；
  - 比如某种情况下我们使用组件，希望组件显示的是**一个按钮**，某种情况下我们使用组件希望显示的是**一张图片**；
  - 我们应该让使用者可以决定**某一块区域到底存放什么内容和元素**；
- 举个例子：假如我们定制一个通用的导航组件 - NavBar
  - 这个组件分成三块区域：**左边-中间-右边**，每块区域的内容是不固定；
  - 左边区域可能显示一个菜单图标，也可能显示一个返回按钮，可能什么都不显示；
  - 中间区域可能显示一个搜索框，也可能是一个列表，也可能是一个标题，等等；
  - 右边可能是一个文字，也可能是一个图标，也可能什么都不显示；
- 如何使用插槽 slot？
  - 这个时候我们就可以来定义插槽 slot：
    - 插槽的使用过程其实是**抽取共性、预留不同**；
    - 我们会将**共同的元素、内容依然在组件内**进行封装；
    - 同时会将**不同的元素使用 slot 作为占位**，让外部决定到底显示什么样的元素；
  - 如何使用 slot 呢？
    - Vue 中将 **`<slot>` 元素作为承载分发内容**的出口；
    - 在封装组件中，使用**特殊的元素`<slot>`**就可以封装组件**开启一个插槽**；
    - 该插槽**插入什么内容取决于父组件**如何使用；
- 插槽的基本使用
- 插槽的默认内容
- 多个插槽的效果
  - 如果一个组件中**含有多个插槽，我们插入多个内容时是什么效果？**
    - 我们会发现默认情况下每个插槽都会获取到我们插入的内容来显示；
- 具名插槽的使用
  - 事实上，我们希望达到的效果是插槽对应的显示，这个时候我们就可以使用**具名插槽**：
    - 具名插槽顾名思义就是给**插槽起一个名字**，`<slot>` 元素有一个**特殊的 attribute：name**；
    - 一个**不带 name 的 slot，会带有隐含的名字 default**；
- 动态插槽名
  - **什么是动态插槽名？**
    - 可以通过 **v-slot:[dynamicSlotName]** 方式动态绑定一个名称；
- **具名插槽使用的时候缩写：**
  - **v-slot 也有缩写**；
  - 将 `v-slot:` 替换为字符 `#`；
- 渲染作用域
  - **在 Vue 中有渲染作用域的概念：**
    - 父级模板里的所有内容都是**在父级作用域中编译**的；
    - 子模板里的所有内容都是**在子作用域中编译**的；
  - 如何理解这句话呢？我们来看一个案例：
    - 在我们的案例中 ChildCpn 自然是可以访问自己作用域中的 title 内容的；
    - 但是在 App 中，是访问不了 ChildCpn 中的内容的，因为它们是跨作用域的访问；
- 认识作用域插槽
  - 有时候我们希望插槽**可以访问到子组件中的内容**是非常重要的：
    - 当一个组件被用来渲染一个**数组元素**时，我们**使用插槽**，并且**希望插槽中没有显示每项的内容**；
    - 这个 Vue 给我们提供了**作用域插槽**；
  - **我们来看下面的一个案例**：
    1. 在 App.vue 中定义好数据
    2. 传递给 ShowNames 组件中
    3. ShowNames 组件中遍历 names 数据
    4. 定义插槽的 prop
    5. 通过 v-slot:default 的方式获取到 slot 的 props
    6. 使用 slotProps 中的 item 和 index
- 作用域插槽的案例

  ![slot-scope](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240110212744_IMG_0672.PNG)

- 独占默认插槽的缩写
  - 如果我们的插槽是默认插槽 default，那么在使用的时候 `v-slot:default="slotProps"` 可以简写为 `v-slot="slotProps"`：
  - 并且如果我们的插槽只有默认插槽时，组件的标签可以被当作插槽的模板来使用，这样，我们就可以将 v-slot 直接用在组件上：

    ```javascript
    <show-names :names=names v-slot="slotProps">
      <button>{{slotProps.item}}-{{slotProps.index}}</button>
    </show-names>
    ```

- 默认插槽和具名插槽混合
  - 但是，如果我们有默认插槽和具名插槽，那么按照完整的 template 来编写；
  - 只要出现多个插槽，请始终为所有的插槽使用完整的基于 `<template>` 的语法；

## Vue3 组件化开发（三）

### 动态组件

- 点击一个 tab-bar，切换不同的组件显示；
  - **方式一：** 通过 v-if 来判断，显示不同的组件；
  - **方式二：** 动态组件的方式；
- 动态组件的实现
  - 动态组件是使用 **component 组件**，通过一个 **特殊的 attribute is** 来实现：
  - **这个 currentTab 的值需要是什么内容呢？**
    - 可以是通过 **component 函数注册** 的组件；
    - 在一个**组件对象的components对象中注册的组件**；

### keep-alive

- 默认情况下，我们在**切换组件后**，**about组件会被销毁掉**，再次回来时**会重新创建组件**；
- 但是，在开发中某些情况下我们希望继续保持组件的状态，而不是销毁掉，这个时候我们就可以**使用一个内置组件：keep-alive**
- keep-alive 有一些属性：
  - **include** - string｜RegExp｜Array，只有名称匹配的组件会被缓存；
  - **exclude** - string｜RegExp｜Array，任何名称匹配组件都不会被缓存；
  - **max** - number｜string，最多可以缓存多少组件实例，一旦达到这个数字，那么缓存组件中最近没有被访问的实例会被销毁；
- **include 和 exclude prop 允许组件有条件地缓存：**
  - 二者都可以用**逗号分隔字符串、正则表达式或一个数组**来表示；
  - 匹配首先检查组件自身的 **name 选项**；
- 缓存组件的生命周期
  - 对于缓存的组件来说，再次进入时，我们是**不会执行 created 或者 mounted 等生命周期函数** 的；
    - 但是有时候我们确实希望监听到何时重新进入到了组件，何时离开了组件；
    - 这个时候我们可以使用 **activated 和 deactivated** 这两个生命周期钩子函数来监听；

### 异步组件

- Webpack 的代码分包
  - 默认的打包过程：
    - 默认情况下，在构建整个组件树的过程中，因为组件和组件之间是**通过模块化直接依赖**的，那么**webpack 在打包时就会将组件模块打包到一起**（比如一个 app.js 文件中）；
    - 这个时候随着**项目的不断扩大**，**app.js 文件的内容过大**，会造成**首屏的渲染速度变慢**；
  - 打包时，代码的分包：
    - 所以，对于一些**不需要立即使用的组件**，我们可以**单独对它们进行拆分**，拆分成一些**小的代码块 chunk.js**；
    - 这些 chunk.js 会在需要时 **从服务器加载下来**，并且 **运行代码**，显示对应的内容；
- Vue 中实现异步组件
  - 如果我们的项目过大了，对于**某些组件**我们希望**通过异步的方式来进行加载**（目的是可以对其进行分包处理），那么 Vue 中给我们提供了一个函数：**defineAsyncComponent**。
  - **defineAsyncComponent 接受两种类型的参数：**
    - **类型一**：工厂函数，该工厂函数需要返回一个 Promise 对象；
    - **类型二**：接受一个对象类型，对异步函数进行配置；
- 异步组件 和 Suspense
  - Suspense 是一个内置的全局组件，该组件有两个插槽：
    - **default**：如果 default 可以显示，那么显示 default 的内容；
    - **fallback**：如果 default 无法显示，那么会显示 fallback 插槽的内容；

### refs

- 某些情况下，我们在组件中想要**直接获取到元素对象或者子组件实例**：
  - 在 Vue 开发中我们是**不推荐进行 DOM 操作**的；
  - 这个时候，我们可以**给元素或者组件绑定一个 ref 的 attribute 属性**；
  - **组件实例有一个 $refs 属性：**
    - 它是一个对象 Object，持有**注册过 ref attribute** 的所有 DOM 元素和组件实例。
  
### `$parent` 和 `$root`

- **我们可以通过 $parent 来访问父元素。**
- **通过 $root 来访问根元素。**
- ⚠️ 注意：在 Vue3 中已经**移除了 $children 的属性**，所以不可以使用了。

### 生命周期

- 什么是生命周期呢？
  - 每个组件都可能会经历从**创建、挂载、更新、卸载**等一系列的过程；
  - 在这个过程中的**某一个阶段**，用于可能会想要**添加一些属于自己的代码逻辑**（比如组件创建完后就请求一些服务器数据）；
  - 但是我们**如何可以知道目前组件正在哪一个过程**呢？Vue 给我们提供了 **组件的生命周期函数**；
- 生命周期函数：
  - 生命周期函数是**一些钩子函数**，在**某个时间会被 Vue 源码内部进行回调**；
  - 通过对生命周期函数的回调，我们可以**知道目前组件正在经历什么阶段**；
  - 那么我们就可以在**该生命周期中编写属于自己的逻辑代码**了；
- 生命周期的流程

  ![vue生命周期](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240114183816_IMG_0677.PNG)

### 组件的 `v-model`

- 前面我们在 **input** 中可以使用 **v-model** 来完成双向绑定：
  - 这个时候往往会非常方便，因为 v-model 默认帮助我们完成了两件事；
  - **v-bind：value 的数据绑定** 和 **@input 的事件监听**；
- 如果我们现在**封装了一个组件**，其他地方在使用这个组件时，是否也可以**使用 v-model 来同时完成这两个功能**呢？
  - 也是可以的，vue也支持**在组件上使用 v-model**；
- **当我们在组件上使用的时候，等价于如下的操作：**
  - 我们会发现和**input元素不同的只是属性的名称和事件触发的名称**而已；

    ```html
    <my-input v-model="message"/>
    <!-- 相当于 -->
    <my-input :model-value="message" @update:model-value="message = $event"></my-input>
    ```

### 混入 Mixin

- 认识 Mixin
  - 目前我们是使用组件化的方式在开发整个 Vue 的应用程序，但是**组件和组件之间有时候会存在相同的代码逻辑**，我们希望对**相同的代码逻辑进行抽取**。
  - 在 Vue2 和 Vue3 中都支持的一种方式就是**使用 Mixin 来完成**：
    - Mixin 提供了一种非常灵活的方式，来**分发 Vue 组件中的可复用功能**；
    - 一个 Mixin 对象可以包含**任何组件选项**；
    - 当组件使用 Mixin 对象时，所有 **Mixin 对象的选项将被混合进入该组件本身的选项中**；
    ![Mixin的使用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240915224158_28f2ms.png)
- Mixin 的合并规则
  - 如果 Mixin 对象中的选项和组件对象中的选项发生了冲突，那么 Vue 会如何操作呢？
    - 这里**分成不同的情况**来进行处理；
  - **情况一：如果是 data 函数的返回值对象**
    - 返回值对象默认情况下会**进行合并**；
    - 如果 data 返回值对象的属性发生了冲突，那么会**保留组件自身的数据**；
  - **情况二：如何生命周期钩子函数**
    - 生命周期的钩子函数**会被合并到数组**中，都会被调用；
  - **情况三：值为对象的选项，例如 methods、components 和 directives，将被合并为同一个对象。**
    - 比如都有 **methods 选项**，并且都定义了方法，那么**它们都会生效**；
    - 但是如果**对象的key相同**，那么**会取组件对象的键值对**；
- 全局混入 Mixin
  - 如果组件中的某些选项，是所有的组件都需要拥有的，那么这个时候我们可以使用**全局的mixin**：
    - 全局的 Mixin 可以使用**应用app的方法mixin**来完成注册；
    - 一旦注册，那么**全局混入的选项将会影响每一个组件**；
    ![全局混入Mixin](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917105247_mYBlq0.png)
- extends
  - 另外一个类似于 Mixin 的方式是**通过extends属性**：
    - 允许声明扩展另外一个组件，**类似于 Mixins**;
    ![extends](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917111019_2nrkWC.png)

## Vue3 过渡&动画实现

- 认识动画
  - 在开发中，我们想要给一个组件的**显示和消失添加某种过渡动画**，可以很好的**增加用户体验**：
    - React 框架本身并**没有提供任何动画相关的 API**， 所以在 React 中使用过渡动画我们需要使用一个**第三方库 react-transition-group**；
    - Vue 中为我们提供**一些内置组件和对应的API**来完成动画，利用它们我们可以**方便的实现过渡动画效果**；
    - 如果我们希望给**单元素或者组件实现过渡动画**，可以**使用 transition 内置组件**来完成动画；
- Vue 的 transition 动画
  - Vue **提供了 transition 的封装组件**，在下列情形中，可以给任何元素和组件添加进入/离开过渡：
    - **条件渲染（使用 v-if）条件展示（使用 v-show）**
    - **动态组件**
    - **组件根节点**
- Transition 组件的原理
  - **当插入或删除包含在 transition 组件中的元素时，Vue 将会做以下处理：**
    1. 自动嗅探**目标元素是否应用了CSS过渡或者动画**，如果有，那么**在恰当的时机添加/删除CSS类名**；
    2. 如果 transition 组件提供了**JavaScript钩子函数**，这些钩子函数将在恰当的时机被调用；
    3. 如果**没有找到JavaScript钩子并且也没有检测到CSS过渡/动画**，**DOM插入、删除操作将会立即执行**；
- 过渡动画 class
  - **我们会发现上面提到了很多个class，事实上Vue就是帮助我们在这些class之间来回切换完成的动画：**
  - **v-enter-from：** 定义进入过渡的开始状态。在元素被插入之前生效，在元素被插入之后的下一帧移除。
  - **v-enter-active：** 定义进入过渡生效时的状态。在整个进入过渡的阶段中应用，在元素被插入之前生效，在过渡/动画完成之后移除。这个类可以被用来定义进入过渡的过程时间，延迟和曲线函数。
  - **v-enter-to：** 定义进入过渡的结束状态。在元素被插入之后下一帧生效（与此同时 v-enter-from 被移除），在过渡/动画完成之后移除。
  - **v-leave-from：** 定义离开过渡的开始状态。在离开过渡被触发时立刻生效，下一帧被移除。
  - **v-leave-active：** 定义离开过渡生效时的状态。在整个离开过渡的阶段中应用，在离开过渡被触发时立刻生效，在过渡/动画完成之后移除。这个类可以被用来定义离开过渡的过程时间，延迟和曲线函数。
  - **v-leave-to：** 定义离开过渡的结束状态。在离开过渡被触发之后下一帧生效（与此同时 v-leave-from 被移除），在过渡/动画完成之后移除。
- class 添加的时机和命名规则

  ![transition_class](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240115223955_IMG_0678.PNG)

  - **class 的 name 命名规则如下：**
    - 如果我们使用的是一个没有 name 的 transition，那么所有的 class 是以 v- 作为默认前缀；
    - 如果我们添加了一个 name 属性，比如 `<transition name="why">`，那么所有的 class 会以 why- 开头；

- 过渡 css 动画
  - 前面我们是**通过 transition 来实现的动画效果**，另外我们也**可以通过 animation 来实现**。
- 同时设置过渡和动画
  - Vue 为了**知道过渡的完成**，内部是**在监听 transitionend 或 animationend**，到底使用哪一个取决于元素应用的CSS规则：
    - 如果我们**只是使用了其中的一个**，那么**Vue能自动识别类型并设置监听**；
  - **但是如果我们同时使用了过渡和动画呢？**
    - 并且在这个情况下可能**某一个动画执行结束时，另外一个动画还没有结束**；
    - 在这种情况下，我们可以**设置 type 属性为 animation 或者 transition** 来明确的告知 Vue 监听的类型；
- 显式的指定动画时间
  - 我们也可以显式的来**指定过渡的时间**，通过**duration 属性**；
  - **duration 可以设置两种类型的值：**
    - **number类型**：同时设置进入和离开的过渡时间；
    - **object类型**：分别设置进入和离开的过渡时间；
- 过渡的模式 mode
  - 默认情况下**进入和离开动画**是同时发生的；
  - 如果确实我们希望达到这个的效果，那么是没有问题；
- appear 初次渲染
  - 默认情况下，**首次渲染的时候是没有动画的**，如果我们**希望给他添加上去动画，那么就可以增加另外一个属性 appear**：
- 认识 animate.css
  - 如果我们手动一个个来编写这些动画，那么效率是比较低的，所以在开发中我们可能会引用一些**第三方库的动画库，比如 animate.css**
  - **什么是 animate.css 呢？**
    - animate.css 是一个已经**准备好的、跨平台的动画**库为我们的 web 项目，对于强调、主页、滑动、注意力引导非常有用；
  - **如何使用 animate 库呢？**
    - 第一步：需要**安装 animate.css**库；
      `npm install animate.css`
    - 第二步：在 main.js 中导入**animate.css库**的样式；
      `import "animate.css";`
    - 第三步：使用**animation动画或者animate提供的类**；
      - 用法一：直接使用**animate库中定义的 keyframes 动画**；
      - 用法二：直接使用**animate库提供给我们的类**；
  - 自定义过渡 class
    - **我们可以通过以下 attribute 来自定义过渡类名：**
      - enter-from-class
      - enter-active-class
      - enter-to-class
      - leave-from-class
      - leave-active-class
      - leave-to-class
    - 他们的优先级高于普通的类名，这对于**Vue的过渡系统和其他第三方 CSS 动画库**，如 animate.css 结合使用十分有用。
- 认识 gsap 库
  - 某些情况下我们希望通过**JavaScript来实现一些动画的效果**，这个时候我们可以选择使用**gsap库**来完成。
  - **什么是 gsap 呢？**
    - GSAP 是 The GreenSock Animation Platform（GreenSock 动画平台）的缩写；
    - 它可以**通过 JavaScript 为 CSS 属性、SVG、Canvas**等设置动画，并且是浏览器兼容的；
    - **这个库应该如何使用呢？**
      - 第一步：需要**安装gasp**库；
      - 第二步：导入**gsap**库；
      - 第三步：使用**对应的api**即可；
- JavaScript 钩子
  - 在使用动画之前，我们先来看一下**transition组件给我们提供的JavaScript钩子**，这些钩子可以帮助我们监听动画执行到什么阶段了。

    ```html
    <transition
      @before-enter="beforeEnter"
      @enter="enter"
      @after-enter="afterEnter"
      @enter-cancelled="enterCancelled"
      @before-leave="beforeLeave"
      @leave="leave"
      @after-leave="afterLeave"
      @leave-cancelled="leaveCancelled"
      :css="false"
    >
      <!--...-->
    </transition>
    ```
  
  - 当我们使用JavaScript来执行过渡动画时，需要**进行done回调**，否则它们将会被同步调用，过渡会立即完成。
  - 添加`:css="false"`，也会让 Vue 会**跳过 CSS 的检测**，除了性能略高之外，这可以避免过渡过程中 CSS 规则的影响。
- gsap 实现数字变化
  - 在一些项目中，我们会见到**数字快速变化的动画效果**，这个**动画可以很容易通过gsap来实现**
- 认识列表的过渡
  - 目前为止，过渡动画我们只要是**针对单个元素或者组件**的：
    - 要么是**单个节点**；
    - 要么是**同一时间渲染多个节点中的一个**；
  - 那么如果希望渲染的是**一个列表**，并且**该列表中添加删除数据也希望有动画执行**呢？
    - 这个时候我们要**使用 <transition-group> 组件**来完成；
  - **使用 <transition-group> 有如下的特点：**
    - 默认情况下，它**不会渲染一个元素的包裹器**，但是你可以**指定一个元素并以 tag attribute 进行渲染**；
    - **过渡模式不可用**，因为我们不再相互切换特有的元素；
    - 内部元素总是**需要提供唯一的 key attribute 的值**；
    - **CSS 过渡的类将会应用在内部的元素**中，而**不是这个组/容器本身**；
- 列表过渡的基本使用
- 列表过渡的移动动画
  - **虽然新增的或者删除的节点是有动画**的，但是**对于那些其他需要移动的节点是没有动画**的；
    - 我们可以通过使用一个**新增的 v-move 的 class**来完成动画；
    - 它会**在元素改变位置的过程**中应用；
    - 像之前的名字一样，我们可以**通过 name 来自定义前缀**；
- 列表的交错过渡案例
  - 我们来通过 gsap 的延迟 delay 属性，做一个交替消失的动画：

## Composition API（一）

### Options API 的弊端

- Options API 的弊端
  - 在 Vue2 中，我们**编写组件的方式是 Options API**：
    - Options API 的一大特点就是在**对应的属性**中编写**对应的功能模块**；
    - 比如**data定义数据**、**methods中定义方法**、**computed中定义计算属性**、**watch中定义监听**，也包括**生命周期钩子**；
- 但是这种代码有一个很大的弊端：  
  - 当我们**实现某一个功能**时，这个功能**对应的代码逻辑**会被**拆分到各个属性**中；
  - 当我们**组件变得更大、更复杂**时，**逻辑关注点的列表**就会增长，那么**同一个功能的逻辑就会被拆分的很分散**；
  - 尤其对于哪些一开始**没有编写这些组件的人**来说，这个组件的代码是**难以阅读和理解的**（阅读组件的其他人）；
- 下面我们来看一个非常大的组件，其中的逻辑功能按照颜色进行了划分：
  - 这种**碎片化的代码**使用**理解和维护这个复杂的组件**变得异常困难，并且**隐藏了潜在的逻辑问题**；
  - 并且当我们**处理单个逻辑关注点**时，需要不断的**跳到相应的代码**块中；
  - 如果我们能将**同一个逻辑关注点相关的代码**收集**在一起**会更好。**这就是 Composition API 想要做的事情，以及可以帮助我们完成的事情。** 也有人把 Vue Composition API 简称为 **VCA**。

### 认识 Composition API

- 认识 Composition API
  - 那么既然知道 Composition API 想要帮助我们做什么事情，接下来看一下**到底是怎么做**呢？
    - 为了开始使用 Composition API，我们需要有一个可以实际使用它**（编写代码）的地方**；
    - 在 Vue 组件中，这个位置就是 **setup 函数**；
  - **setup 其实就是组件的另外一个选项：**
    - 只不过这个选项强大到我们可以**用它来替代之前所编写的大部分其他选项**；
    - 比如 **methods、computed、watch、data、生命周期**等等；
  - setup 函数的参数
    - 它主要**有两个参数**：
      - 第一个参数：**props**
      - 第二个参数：**context**
    - props 非常好理解，它其实就是**父组件传递过来的属性**会被**放到 props 对象**中，我们在**setup中如果需要使用**，那么就可以直接**通过props参数获取**：
      - 对于**定义 props 的类型**，我们还是**和之前的规则是一样的，在 props 选项中定义**；
      - 并且**在 template 中**依然是可以**正常去使用props中的属性**，比如 message；
      - 如果我们**在setup函数中想要使用 props**，那么**不可以通过 this 去获取**；
      - 因为 props 有直接**作为参数传递到 setup 函数**中，所以我们可以**直接通过参数**来使用即可；
    - 另外一个参数是 context，我们也称之为是一个 **SetupContext**，它里面**包含三个属性**：
      - **attrs**：**包含了父组件传递过来的所有非 props 的特性**；
      - **slots**：**包含了父组件传递过来的所有插槽（这个在以渲染函数返回时会用作用，后面会讲到）**；
      - **emit**：**当我们组件内部需要发出事件时会用到 emit（因为我们不能访问 this，所以不可以通过 this.$emit 发出事件）**；
      ![setup的context参数](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917194811_dZNGud.png)
      ![setup的context参数解构](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917195124_fUPWjS.png)
  - setup 函数的返回值
    - setup 既然是一个函数，那么它也可以有**返回值**，**它的返回值用来做什么呢？**
      - setup 的返回值可以在**模板 template 中被使用**；
      - 也就是说我们可以**通过setup的返回值来替代 data 选项**；
      ![setup的返回值](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917202453_MovkQ5.png)
  - setup 不可以使用 this
    - 官方关于 this 有这样一段描述（这段描述是我给官方提交了 PR 之后的一段描述）：
      - 表达的含义是**this 并没有指向当前组件实例**；
      - 并且**在 setup 被调用之前，data、computed、methods**等都没有被解析；
      - 所以**无法在 setup 中获取 this**；
      ![官方setup](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917204154_Y6OGit.png)
  - Reactive API
    ![reactive_api_1](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917204550_kooIvc.png)
    ![reactive_api_2](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917205126_QgECQP.png)
    - 为什么就可以变成响应式的呢？
      - 这是因为当我们**使用 reactive 函数处理我们的数据之后**，数据**再次被使用**时就会**进行依赖收集**；
      - 当**数据发生改变**时，所有**收集到的依赖**都是**进行对应的响应式操作**（比如界面更新）；
      - 事实上，我们编写的 **data 选项**，也是在内部 **交给了 reactive 函数**将其编程响应式对象的；
  - Ref API
    - reactive API 对**传入的类型是有限制的**，它要求我们必须传入的是**一个对象或者数组类型**：
      - 如果我们传入一个**基本数据类型（String、Number、Boolean）会报一个警告**；
      - 这个时候 Vue3 给我们提供了**另外一个 API：ref API**
        - ref 会返回一个**可变的响应式对象**，该对象作为一个 **响应式的引用** 维护着它 **内部的值**，这就是 **ref 名称的来源**；
        - 它内部的值是**在 ref 的 value 属性**中被维护的；
        ![ref_api_1](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917210807_fpRVHu.png)
        ![ref_api_2](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240917211017_BkLtTY.png)
    - **这里有两个注意事项：**
      - 在**模板中引入 ref 的值**时，Vue会**自动帮助我们进行解包**操作，所以我们并**不需要在模板中通过 ref.value** 的方式来使用 **（模板中的解包是浅层的解包）**；
      - 但是在 **setup 函数内部**，它依然是一个 **ref引用**，所以对其进行操作时，我们依然需要**使用 ref.value 的方式**；
      ![ref自动解包](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918130235_Screenshot_20240918_085229.jpg)
  - 认识 readonly
    - 我们通过 **reactive 或者 ref 可以获取到一个响应式的对象，但是某些情况下，我们**传入给其他地方（组件）**的这个响应式对象希望**在另一个地方（组件）被使用**，但是**不能被修改**，这个时候**如何防止这种情况的出现**呢？
      - Vue3 为我们提供了 **readonly 的方法**；
      - **readonly 会返回原生对象的只读代理**（也就是它依然是一个 Proxy，这是一个 **proxy 的 set 方法被劫持**，并且不能对其进行修改）；
      ![readonly原理](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918130317_Screenshot_20240918_090558.jpg)
      ![readonly举例](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918130357_Screenshot_20240918_091219.jpg)

## Composition API（二）

### Reactive 判断的 API

- Reactive 判断的 API
  - isProxy
    - 检查对象**是否是由 reactive 或 readonly 创建的 proxy**。
  - isReactive
    - 检查对象**是否是由 reactive 创建的响应式代理**：
    - 如果**该代理是 readonly 建的**，但**包裹了由 reactive 创建的另一个代理**，它也会返回 true；
  - isReadonly
    - 检查对象**是否是由 readonly 创建的只读代理**。
  - toRaw
    - 返回 **reactive 或 readonly 代理的原始对象**（不建议保留对原始对象的持久引用。请谨慎使用）。
  - shallowReactive
    - 创建一个响应式代理，它跟踪其自身 property 的响应性，但**不执行嵌套对象的深层响应式转换**（深层还是原生对象）。
  - shallowReadonly
    - 创建一个 proxy，使其自身的 property 为只读，但**不执行嵌套对象的深度只读转换**（深层还是可读、可写的）。

### toRefs 与 toRef

- toRefs
  - 如果我们使用 **ES6 的结构语法**，对 **reactive 返回的对象进行解构获取值**，那么之后无论是**修改解构后的变量**，还是**修改 reactive 返回的 state 对象**，**数据都不再是响应式**的：
  
    ```javascript
    const state = reactive({
      name: "why",
      age: 18
    })

    const {name, age} = state;
    ```
  
  - 那么有没有办法**让我们解构出来的属性是响应式**的呢？
    - Vue 为我们提供了一个 **toRefs 的函数**，可以将 **reactive 返回的对象中的属性都转成 ref**；
    - 那么我们再次进行解构出来的 **name 和 age 本身都是 ref 的**；

    ```javascript
    // 当我们这样来做的时候，会返回两个 ref 对象，它们都是响应式的
    const {name, age} = toRefs(state);
    ```

  - 这种做法相当于已经在 **state.name 和 ref.value** 之间建立了**链接**，**任何一个修改都会引起另外一个变化**；
- toRef
  - 如果我们只希望转换一个 **reactive 对象中的属性为 ref**，那么可以**使用 toRef 的方法**：
  ![toRefs和toRef](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918130524_Screenshot_20240918_100015.jpg)
- ref 其他的 API
  - unref
    - 如果我们想要**获取一个 ref 引用中的 value**，那么也可以**通过 unref 方法**：
      - 如果**参数是一个 ref**，则**返回内部值**，否则**返回参数本身**；
      - 这是 `val = isRef(val) ? val.value : val` 的语法糖
  - isRef
    - 判断值**是否是一个 ref 对象**。
  - shallowRef
    - 创建一个**浅层的 ref 对象**；
  - triggerRef
    - **手动触发和 shallowRef 相关联的副作用**：
  ![shallowRef和triggerRef举例](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918130707_Screenshot_20240918_102309.jpg)
- customRef
  - 创建一个**自定义的ref**，并**对其依赖项跟踪和更新触发**进行**显示控制**：
    - 它需要**一个工厂函数**，该**函数接受 track 和 trigger 函数**作为参数；
    - 并且应该返回**一个带有 get 和 set 的对象**；
  - 这里我们使用一个案例：
    - 对 **双向绑定的属性进行 debounce（防抖）** 的操作；
    ![自定义ref](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918130801_Screenshot_20240918_104729.jpg)

### computed

- computed
  - 在 Composition API 中，我们可以在 setup 函数中使用 computed 方法来编写一个计算属性；
  - 如何使用 computed 呢？
    - 方式一：接收一个 getter 函数，并为 getter 函数返回的值，返回一个不变的 ref 对象；
    - 方式二：接收一个具有 get 和 set 的对象，返回一个可变的（可读写）ref 对象；
  ![computed举例](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918130830_Screenshot_20240918_105721.jpg)

### watchEffect 与 watch

- 侦听数据的变化
  - 在前面的 Options API 中，我们可以通过 watch 选项来侦听 data 或者 props 的数据变化，当数据变化时执行某一些操作。
  - 在 Composition API 中，我们可以使用 watchEffect 和 watch 来完成响应式数据的侦听；
    - watchEffect 用于自动收集响应式数据的依赖；
    - watch 需要手动指定侦听的数据源；
  - watchEffect
    - 当侦听到某些响应式数据变化时，我们希望执行某些操作，这个时候可以使用 watchEffect。
    - 首先，**watchEffect 传入的函数会被立即执行一次，并且在执行的过程中会收集依赖**；
    - 其次，**只有收集的依赖发生变化时，watchEffect传入的函数才会再次执行**；
    ![watchEffect基本使用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918202525_Screenshot_20240918_150532.jpg)
  - watchEffect 的停止侦听
    ![watchEffect停止侦听](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918202814_Screenshot_20240918_151307.jpg)
  - watchEffect 清除副作用
    - 什么是清除副作用呢？
      - 比如在开发中我们需要在侦听函数中执行网络请求，但是在网络请求还没有达到时候，我们停止了侦听器，或者侦听器侦听函数被再次执行了。
      - 那么上一次的网络请求应该被取消掉，这个时候我们就可以清除上一次的副作用；
    - 在我们给 watchEffect 传入的函数被回调时，其实可以获取到一个参数：onInvalidate
      - 当**副作用即将重新执行**或者**侦听器被停止**时会执行该函数传入的回调函数；
      - 我们可以在传入的回调函数中，执行一些清除工作；

      ```javascript
      const stopWatch = watchEffect((onInvalidate) => {
        console.log("watchEffect执行~", name.value, age.value);
        const timer = setTimeout(() => {
          console.log("2s后执行的操作");
        }, 2000);
        onInvalidate(() => {
          clearTimeout(timer);
        });
      });
      ```

      ![watchEffect清除副作用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918202923_Screenshot_20240918_153915.jpg)
      ![watchEffect清除副作用结果](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918202853_Screenshot_20240918_153824.jpg)
  - setup 中使用 ref
    - 在讲解 watchEffect 执行时机之前，我们先补充一个知识：在 setup 中如何使用 ref 或者元素或者组件？
      - 其实非常简单，我们只需要定义一个 ref 对象，绑定到元素或者组件的 ref 属性上即可；
    ![监听ref变化](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918203021_Screenshot_20240918_154944.jpg)
    ![监听ref变化的结果](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918203046_Screenshot_20240918_154950.jpg)
  - 调整 watchEffect 的执行时机
    ![监听ref dom挂载后的结果](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918203113_Screenshot_20240918_155654.jpg)
  - watch 的使用
    - watch 的 API 完全等同于组件 watch 选项的 Property：
      - watch 需要侦听特定的数据源，并在回调函数中执行副作用；
      - 默认情况下它是惰性的，只有当被侦听的源发生变化时才会执行回调；
    - **与 watchEffect 的比较，watch 允许我们**：
      - **懒执行副作用（第一次不会直接执行）；**
      - **更具体的说明当哪些状态发生变化时，触发侦听器的执行；**
      - **访问侦听状态变化前后的值；**
  - 侦听单个数据源
    - watch 侦听函数的数据源有两种类型：
      - 一个 getter 函数：但是该 getter 函数必须引用可响应式的对象（比如 reactive 或者 ref）；
      - 直接写入一个可响应式的对象，reactive 或者 ref（比较常用的是 ref）；
    ![侦听单个数据源](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918203146_Screenshot_20240918_163145.jpg)
  - 侦听多个数据源
    ![侦听多个数据源](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918203210_Screenshot_20240918_163802.jpg)
  - 侦听响应式对象
    - 如果我们希望侦听一个数组或者对象，那么可以使用一个 getter 函数，并且对可响应对象进行解构：
  - watch 的选项
    - 如果我们希望侦听一个深层的侦听，那么依然需要设置 deep 为 true：
      - 也可以传入 immediate 立即执行；
    ![watch的选项](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918203245_Screenshot_20240918_164505.jpg)

## Composition API（三）高级语法补充

### 生命周期钩子

- 生命周期钩子
  - setup 中如何使用生命周期函数呢？
    - 可以使用直接导入的 onX 函数注册生命周期钩子；
    ![生命周期钩子](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918203324_Screenshot_20240918_170126.jpg)

### Provide 和 Inject 函数

- Provide 和 Inject 函数
  - provide 可以传入两个参数：
    - name：提供的属性名称；
    - value：提供的属性值；
  - inject 可以传入两个参数：
    - 要 inject 的 property 的 name；
    - 默认值；
  - 为了增加 provide 和 inject 值之间的响应性，我们可以在 provide 值时使用 ref 和 reactive。
  ![provide的使用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918214715_Screenshot_20240918_204322.jpg)
  ![inject的使用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215241_Screenshot_20240918_204544.jpg)

### Composition API 举例

- useCounter
  - 我们先来对之前的 counter 逻辑进行抽取：
  ![useCounter](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215319_Screenshot_20240918_210421.jpg)
  ![引入useCounter](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215343_Screenshot_20240918_210639.jpg)
- useTitle
  - 我们编写一个修改title 的 hook；
  ![useTitle](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215545_Screenshot_20240918_211659.jpg)
  ![引入useTitle](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215607_Screenshot_20240918_211739.jpg)
- useScrollPosition
  ![useScrollPosition](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215628_Screenshot_20240918_213244.jpg)
  ![引入useScrollPosition](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215658_Screenshot_20240918_213405.jpg)
- useMousePosition
  - 我们来完成一个监听鼠标位置的 hook：
  ![useMousePosition](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215913_Screenshot_20240918_214023.jpg)
  ![引入useMousePosition](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240918215939_Screenshot_20240918_214243.jpg)
- useLocalStorage
  ![useLocalStorage](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919123753_Screenshot_20240919_082823.jpg)
  ![hooks封装](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919123931_Screenshot_20240919_083228.jpg)
  ![引入useLocalStorage](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124057_Screenshot_20240919_083623.jpg)

### setup 顶层编写方式（实验性api）

- setup 顶层编写方式（实验性api）
  ![defineProps和defineEmit](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124121_Screenshot_20240919_085236.jpg)
  ![父组件使用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124150_Screenshot_20240919_085403.jpg)

### 认识 h 函数

- 认识 h 函数
  - Vue 推荐在绝大多数情况下**使用模板**来创建你的 HTML，然后一些特殊的场景，你真的需要 **JavaScript 的完全编程的能力**，这个时候你可以使用**渲染函数**，它**比模板更接近编译器**；
    - 前面我们讲解过 **VNode 和 VDOM 的改变**
    - Vue 在生成真实的 DOM之前，会将**我们的节点转换成 VNode**，而 VNode 组合在一起形成**一棵树结构**，就是**虚拟 DOM（VDOM）**；
    - 事实上，我们之前编写的 template 中的 HTML 最终也是 **使用渲染函数** 生成 **对应的 VNode**；
    - 那么，如果你想充分的利用 JavaScript 的编程能力，我们可以自己来**编写 createVNode 函数**，生成**对应的 VNode**；
  - 那么我们应该怎么来做呢？**使用 h() 函数**：
    - **h() 函数**是一个用于**创建 vnode 的一个函数**；
    - 其实更准确的命名是 **cerateVNode() 函数**，但是为了简便在 Vue 将之**简化为 h() 函数**；
- h() 函数如何使用呢？
  - h() 函数接受三个参数：
    - {String | Object | Function} tag 一个 html 标签名、一个组件、一个异步组件、或一个函数式组件；
    - {Object} props 与 attribute、 prop 和 事件相对应的对象，我们会在模板中使用；
    - {String | Array | Object} children 子 VNodes，使用 `h()` 构建，或使用字符串获取“文本 VNode”或者有插槽的对象。（可选的）
  - ⚠️ **注意事项：**
    - 如果**没有 props**，那么通常可以**将 children 作为第二个参数传入**；
    - 如果会产生歧义，可以**将 null 作为第二个参数传入**，将 **children 作为第三个参数传入**；
  ![h函数基本使用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124223_Screenshot_20240919_093451.jpg)
  ![setup函数实现计数器](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124244_Screenshot_20240919_093955.jpg)
  ![h函数默认插槽子组件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124319_Screenshot_20240919_102938.jpg)
  ![h函数默认插槽父组件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124342_Screenshot_20240919_102959.jpg)
  ![h函数作用域插槽子组件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124415_Screenshot_20240919_104920.jpg)
  ![h函数作用域插槽父组件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124447_Screenshot_20240919_105223.jpg)

### jsx

- jsx 的 babel 配置
  - 如果我们希望**在项目中使用 jsx**，那么我们**需要添加对 jsx 的支持**：
    - jsx 我们通常会**通过 Babel 来进行转换**（React 编写的 jsx 就是通过 babel 转换的）；
    - 对于 Vue 来说，我们只需要在 **Babel 中配置对应的插件**即可；
  - 安装 **Babel 支持 Vue 的 jsx 插件**：
    - `npm install @vue/babel-plugin-jsx -D`
  - 在 **babel.config.js 配置文件**中配置插件：

    ```javascript
    module.exports = {
      presets: [
        '@vue/cli-plugin-babel/preset'
      ],
      plugins: [
        "@vue/babel-plugin-jsx"
      ]
    }
    ```

  ![jsx的使用父组件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124552_Screenshot_20240919_111238.jpg)
  ![jsx的使用子组件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919124642_Screenshot_20240919_111317.jpg)
  
## Vue3 高级语法补充

### 认识自定义指令

- 认识自定义指令
  - 在 Vue 的模板语法中我们学习过各种各样的指令：v-show、v-for、、v-model 等等，除了使用这些指令之外，**Vue 也允许我们来自定义自己的指令。**
    - 注意：在 Vue 中，**代码的复用和抽象主要还是通过组件**；
    - 通常在某些情况下，你需要**对 DOM 元素进行底层操作**，这个时候就会用到**自定义指令**；
  - 自定义指令分为两种：
    - **自定义局部指令：** 组件中通过 **directives 选项**，只能在当前组件中使用；
    - **自定义全局指令：** app 的 **directive 方法**，可以在任意组件中被使用；
  - 比如我们来做一个非常简单的案例：当某个元素挂载完成后可以自动获取焦点
    - 实现方式一：如果我们使用**默认的的实现方式**；
      ![默认的实现](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919231613_Screenshot_20240919_170526.jpg)
    - 实现方式二：自定义一个 **v-focus 的局部指令**；
      ![局部指令](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919231812_Screenshot_20240919_170951.jpg)
    - 实现方式三：自定义一个 **v-focus 的全局指令**；
      ![全局指令](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919231838_Screenshot_20240919_171237.jpg)
- 指令的生命周期
  - 一个指令定义的对象，Vue 提供了如下的几个钩子函数：
    - **created**：在绑定元素的 attribute 或事件监听器被应用之前调用；
    - **beforeMount**：当指令第一次绑定到元素并且在挂载父组件之前调用；
    - **mounted**：在绑定元素的父组件被挂载后调用；
    - **beforeUpdate**：在更新包含组件的 VNode 之前调用；
    - **updated**：在包含组件的 VNode **及其子组件的 VNode** 更新后调用；
    - **beforeUnmount**：在卸载绑定元素的父组件之前调用；
    - **unmounted**：当指令与元素解除绑定且父组件已卸载时，只调用一次；
  ![生命周期和参数修饰符](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919231856_Screenshot_20240919_214219.jpg)
- 自定义指令练习
  - 自定义指令案例：时间戳的显示需求
    - 在开发中，大多数情况下从**服务器**获取到的都是**时间戳**；
    - 我们需要**将时间戳转换成具体格式化的时间**来展示；
    - 在 Vue2 中我们可以**通过过滤器**来完成；
    - 在 Vue3 中我们可以通过**计算属性（computed）** 或者 **自定义一个方法（methods）** 来完成；
    - 其实我们还可以通过一个**自定义的指令**来完成；
    ![自定义指令案例](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919231937_Screenshot_20240919_220232.jpg)

### 认识 Teleport

- 认识 Telelport
  - 在组件化开发中，我们**封装一个组件A**，在**另外一个组件B中使用**：
    - 那么**组件A中 template 的元素**，会**被挂载到组件B中 template** 的某个位置；
    - 最终我们的应用程序会形成**一颗DOM树结构**；
  - 但是某些情况下，我们希望**组件不是挂载在这个组件树上**，可能是**移动到 Vue app 之外的其他位置**：
    - 比如**移动到 body 元素**上，或者我们**有其他的div#app之外的元素**上；
    - 这个时候我们就可以**通过 teleport 来完成**；
  - **Teleport 是什么呢？**
    - 它是一个 **Vue 提供的内置组件**，类似于 react 的 portals；
    - teleport 翻译过来是心灵传输、远距离运输的意思；
      - 它有两个属性：
        - **to**：指定将其中的内容移动到的目标元素，可以使用选择器；
        - **disabled**：是否禁用 teleport 的功能；
  ![teleport](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919232013_Screenshot_20240919_222942.jpg)

### 认识 Vue 插件

- 认识 Vue 插件
  - 通常我们**向 Vue 全局添加一些功能**时，会采用**插件的模式，它有两种编写方式**：
    - **对象类型**：一个**对象**，但是必须包含一个 **install 的函数**，该**函数会在安装插件时**执行；
    - **函数类型**：一个**function**，这个函数会在**安装插件时自动执行**；
  - 插件可以**完成的功能没有限制**，比如下面的几种都是可以的：
    - **添加全局方法或者 property**，通过把它们添加到 **config.globalProperties** 上实现；
    - **添加全局资源**：**指令/过滤器/过渡**等；
    - 通过**全局 mixin** 来添加**一些组件选项**；
    - **一个库，提供自己的 API**，同时**提供上面提到的一个或多个功能**；
    ![plugins_object](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919232051_Screenshot_20240919_224456.jpg)
    ![main.js引入](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919232136_Screenshot_20240919_224827.jpg)
    ![组件获取全局property](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919232116_Screenshot_20240919_224520.jpg)
    ![plugins_function](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919232204_Screenshot_20240919_224910.jpg)

## Vue3 源码学习

- 真实的 DOM 渲染
  - 我们传统的前端开发中，我们是编写自己 HTML，最终被渲染到浏览器上的，那么它是什么样的过程呢？
  ![传统DOM渲染](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919232233_Screenshot_20240919_225610.jpg)
- 虚拟 DOM 优势
  - 目前框架都会引入虚拟 DOM 来对真实的 DOM 进行抽象，这样做有很多的好处：
  - 首先是可以对真实的元素节点进行抽象，抽象成 VNode（虚拟节点），这样方便后续对其进行各种操作；
    - 因为对于直接操作 DOM 来说是有很多的限制的，比如 diff、clone 等等，但是使用 JavaScript 编程语言来操作这些，就变得非常的简单；
    - 我们可以使用 JavaScript 来表达非常多的逻辑，而对于 DOM 本身来说是非常不方便的；
  - 其次是方便实现跨平台，包括你可以将 VNode 节点渲染成任意你想要的节点
    - 如渲染在 canvas、WebGL、SSR、Native（iOS、Android）上；
    - 并且 Vue 允许你开发属于自己的渲染器（renderer），在其他的平台上渲染；
- 虚拟 DOM 的渲染过程
  ![虚拟DOM的渲染过程](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240919232249_Screenshot_20240919_230917.jpg)