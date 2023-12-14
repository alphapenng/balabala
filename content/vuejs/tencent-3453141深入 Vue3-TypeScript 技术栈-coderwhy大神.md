<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-12-03 06:52:42
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-12-14 14:38:17
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
    - [computed 计算属性](#computed-计算属性)

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
  - 用法： **动态地绑定一个或多个 attribute**，或者**向另一个组件传递 props**；

- 绑定 class 介绍
  - **绑定 class 有两种方式：**
    - 对象语法 `<div :class="{'active': true}">呵呵</div>`
    - 数组语法 `<div :class="['abc', title]">哈哈</div>`

- 绑定 style 介绍
  - 利用 **v-bind:style**来绑定一些 **CSS内联样式**；
    - 因为某些样式我们需要根据**数据**动态来决定；
    - 比如某段文字的**颜色**，**大小**等等；
  - CSS property 名可以用 **驼峰式（camelCase）** 或 **短横线分隔（kebab-case，记得用引号括起来）** 来命名；
  - **绑定 class 有两种方式：**
    - 对象语法 `<div :style="{color: 'red', fontSize: '20px'}">呵呵</div>`
    - 数组语法 `<div :style="[{color: 'red'}, {fontSize: '30px'}]">哈哈</div>`
  
- 动态绑定属性
  - 在某些情况下，我们**属性的名称**可能也不是固定的：
  - 如果**属性名称不是固定**的，我们可以使用 **:[属性名]="值"** 的格式来定义；
  - 这种绑定的方式，我们称之为 **动态绑定属性**；

- 绑定一个对象
  - 将一个"对象的所有属性"，绑定到"元素上的所有属性"，应该怎么做呢？
    - 直接使用 **v-bind绑定一个对象**；

      ```html
      <div v-bind="{id: 123, class: 'abc'}">呵呵</div>
      ```

### v-on 绑定事件

- **在前端开发中，我们需要经常和用户进行各种各样的交互：**
  - 我们必须监听用户发生的事件，比如**点击、拖拽、键盘事件**等等
  - 在 Vue 中如何监听事件呢？使用 **v-on指令**

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
  - 当通过 methods 中定义方法，以供 @click 调用时，需要 **注意参数问题**：
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
    - key 属性主要用在 Vue 的 **虚拟DOM算法**，在 **新旧nodes** 对比时辨识 **VNodes**；
    - 如果不使用 key， Vue 会使用一种最大限度减少动态元素并且尽可能的尝试就地 **修改/复用相同类型元素** 的算法；
    - 而 **使用 key** 时，它会基于 key 的变化 **重新排列元素顺序**，并且会 **移除/销毁key** 不存在的元素；

- 插入 F 的案例

  ![insert_f](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202312142139061.webp)

## Vue3 的 Options-API

### computed 计算属性

- 复杂 data 的处理方式
  - 我们可能需要对 **数据进行一些转化后** 再显示，或者需要 **将多个数据结合起来** 进行显示；
    - 比如需要对 **多个 data 数据进行运算、三元运算符来决定结果、数据进行某种转化** 后显示；
    - 在模板中使用 **表达式**，可以非常方便的实现，但是设计它们的初衷是用于 **简单的运算**；
    - 在模板中放入太多的逻辑会让 **模板过重和难以维护**；
    - 并且如果多个地方都使用到，那么会有大量重复的代码；