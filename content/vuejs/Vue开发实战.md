# Vue 开发实战

- [Vue 开发实战](#vue-开发实战)
  - [Vue 核心知识点](#vue-核心知识点)
    - [内置指令](#内置指令)
  - [自定义指令](#自定义指令)
  - [大型 Vue 项目所需的周边技术](#大型-vue-项目所需的周边技术)
    - [如何在 Vue 中使用 Vuex](#如何在-vue-中使用-vuex)
    - [Vuex 核心概念和底层原理](#vuex-核心概念和底层原理)
      - [核心概念](#核心概念)
      - [底层原理](#底层原理)
    - [Vuex 最佳实践](#vuex-最佳实践)
    - [提升开发效率和体验的常用工具：Vetur、ESLint、Prettier、vue-devtools](#提升开发效率和体验的常用工具vetureslintprettiervue-devtools)
    - [单元测试的重要性及其使用](#单元测试的重要性及其使用)
  - [开发基于 Vue 的 Ant Design Pro](#开发基于-vue-的-ant-design-pro)
    - [使用 Vue CLI3 快速创建项目](#使用-vue-cli3-快速创建项目)
    - [如何自定义 Webpack 和 Babel 配置](#如何自定义-webpack-和-babel-配置)
    - [如何设计一个高扩展性的路由](#如何设计一个高扩展性的路由)

## Vue 核心知识点

### 内置指令

- v-text
- v-html
- v-show
- v-if
- v-else
- v-else-if
- v-for
- v-on
- v-bind
- v-model
- v-slot
- v-pre
- v-cloak
- v-once

## 自定义指令

- bind
- inserted
- update
- componentUpdated
- unbind

## 大型 Vue 项目所需的周边技术

### 如何在 Vue 中使用 Vuex

- 安装 `npm i vuex`

- 使用
  
  在  `main.js` 中添加

  ```javascript
  import Vuex from 'vuex'
   
  Vue.use(Vuex)

  const store = new Vuex.Store({
    state: {
      count: 0,
    },
    mutations: {
      increment(state) {
        state.count ++
      }
    },
    actions: {
      increment({commit}) {
        setTimeout(() => {
          commit('increment')
        }, 3000)
      }
    },
    getters: {
      doubleCount(state) {
        return state.count * 2
      }
    }
  })
   
  new Vue({
    store,
    render: h => h(App),
  }).$mount('#app')
  ```

  在 `App.vue` 中添加

  ```javascript
  <template>
    <div id="app">
      {{count}}
      <br>
      {{$store.getters.doubleCount}}
      <button @click="$store.commit('increment')">count++</button>
      <button @click="$store.dispatch('increment')">count++</button>
    </div>
  </template>

  <script>
  export default {
    name: 'app',
    computed: {
      count() {
        return this.$store.state.mount
      }
    }
  }
  </script>

  <style>
  </style>
  ```  

> Vuex 的 actions 应该避免直接操作 state，state 的更改应该由 mutations 去修改，不然 vue-devtools 插件记录不到 state 变更，actions 可以根据当前 state 进一步处理数据，计算或请求后端接口，然后通过 commit 的形式提交给 mutations 去处理。

### Vuex 核心概念和底层原理

#### 核心概念

- State —— this.$store.state.xxx —— mapState 取值
- Getter —— this.$store.getters.xxx —— mapGetters 取值
- Mutation —— this.$store.commit("xxx") —— mapMutations 赋值
- Action —— this.$store.disapatch("xxx") —— mapActions 赋值
- Module

#### 底层原理

- State:提供一个响应式数据
- Getter：借助 Vue 的计算属性 computed 来实现缓存
- Mutation：更改 state 方法
- Action：触发 mutation 方法
- Module： Vue.set 动态添加 state 到响应式数据中

### Vuex 最佳实践

**Module**

- 开启命名空间 namespaced: true
- 嵌套模块不要过深，尽量扁平化
- 灵活应用 createNamespacedHelpers

### 提升开发效率和体验的常用工具：Vetur、ESLint、Prettier、vue-devtools

**Vetur**

- 语法高亮
- 标签补全、模板生成
- Lint检查
- 格式化

**ESLint**

- 代码规范
- 错误检查

**Prettier**

- 格式化

**Vue Devtools**

- 集成 Vuex
- 可远程调试
- 性能分析

### 单元测试的重要性及其使用

**使用方式**

- jest 或 mocha
- @vue/test-utils
- sinon

## 开发基于 Vue 的 Ant Design Pro

### 使用 Vue CLI3 快速创建项目

```bash
npm i ant-design-vue@1.7.2 moment
```

### 如何自定义 Webpack 和 Babel 配置

**使用 ant-design-pro**

修改 main.js 入口文件：

```javascript
import Vue from "vue";
import Antd from "ant-design-vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import "ant-design-vue/dist/antd.less";
//import { Button } from "ant-design-vue";
//import { Button } from "ant-design-vue/lib/button";
//import "ant-design-vue/lib/button/style";

Vue.config.productionTip = false;

Vue.use(Antd);
//Vue.use(Button);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
```

修改 vue.config.js：

```javascript
const { defineConfig } = require("@vue/cli-service");
module.exports = defineConfig({
  transpileDependencies: true,
  css: {
    loaderOptions: {
      less: {
        lessOptions: {
          javascriptEnabled: true,
        },
      },
    },
  },
});
```

**按需加载**

`npm i --save-dev babel-plugin-import`

在 `babel.config.js` 中修改：

```javascript
module.exports = {
  presets: ["@vue/cli-plugin-babel/preset"],
  plugins: [
    [
      "import",
      { libraryName: "ant-design-vue", libraryDirectory: "es", style: true },
    ], // `style: true` 会加载 less 文件
  ],
};
```

### 如何设计一个高扩展性的路由

```bash
npm i nprogress
```

在 router/index.js 中使用:

```javascript
import NProgress from "nprogress"
import "nprogress/nprogress.css"

router.beforeEach((to, from, next) => {
  NProgress.start();
  next();
});

router.afterEach(() => {
  NProgress.done();
});
```
