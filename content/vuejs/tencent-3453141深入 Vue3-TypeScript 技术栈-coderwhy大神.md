<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-12-03 06:52:42
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-12-16 17:27:40
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
    - [Webpack](#webpack)

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

### Webpack

- Webpack 的使用前提
  - webpack 的官方文档是 <https://webpack.js.org/>
  - webpack 的中文官方文档是 <https://webpack.docschina.org/>
  - DOCUMENTATION：文档详情，也是我们最关注的

- Webpack 的运行是依赖 **Node环境**的，所以我们电脑上必须有 Node 环境
  - 所以我们需要先安装 Node.js，并且同时会安装 npm；
  - 当前电脑上的 node 版本是 v14.15.5,npm 版本是 v6.14.11（你也可以使用 nvm 或者 n 来管理 Node 版本）；
  - Node 官方网站：<https://nodejs.org/>
