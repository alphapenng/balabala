<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-12-03 06:52:42
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-12-28 19:31:55
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
  - 在真实开发中，我们可以通过一个**后缀名为.vue**的**single-file components（单文件组件）**来解决，并且可以使用 webpack 或者 vite 或者 rollup 等构建工具来对其进行处理。
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
  - **现代的 modern：** 我们前端说过，正是因为现代前端开发面临各种各样的问题，才催生了 webpack 的出现和发展；

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
  - 这个 loader 最常用的是 **css-loader****；
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
    - **传递字符串（如：use:['style-loader'] 是 loader 属性的简写方式（如：use[{loader: 'style-loader'}]）；
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
      - 而**大的图片也逆行转换**，反而会**影响页面的请求速度**；
    - 我们如何可以**限制哪些大小的图片转换和不转换**呢？
      - url-loader 有一个 options 属性 **limit**，可以用于设置转换的限制；
- 认识 asset module type
  - **我们当前使用的 webpack 版本是 webpack5：**
    - 在 webpack5 之前，加载这些资源我们需要**使用一些 loader，比如 raw-loader、url-loader、file-loader**；
    - 在 webpack5 开始，我们可以直接使用 **资源模块类型（asset module type）**，来替代上面的这些 loader；
  - **资源模块类型（asset module type），通过添加 4 种新的模块类型，来替换所有这些 loader：
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
  - **Babe 也拥有编译器的工作流程：**
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
    -  
