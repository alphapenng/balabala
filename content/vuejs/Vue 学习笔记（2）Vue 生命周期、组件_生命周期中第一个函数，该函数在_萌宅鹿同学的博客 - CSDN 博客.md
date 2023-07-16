> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/106087863)

### Vue

*   [Vue 生命周期](#Vue__4)
*   [Vue 中组件（Component）](#Vue_Component_75)
*   *   [全局组件的开发](#_78)
    *   [局部组件的开发](#_118)
*   [组件中 props 的使用](#_props__200)
*   *   [在组件上声明静态数据传递给组件内部](#_202)
    *   [在组件上声明动态数据传递给组件内部](#_238)
    *   [props 的单向数据流](#props__277)
*   [组件中定义数据和事件使用](#_282)
*   *   [组件中定义属于组件的数据](#_283)
    *   [组件中定义属于组件的事件](#_324)
    *   [向子组件中传递 Vue 实例 的事件并调用该事件](#_Vue__372)

> [Vue 笔记目录](https://blog.csdn.net/weixin_43734095/article/details/106910854)

Vue [生命周期](https://so.csdn.net/so/search?q=%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F&spm=1001.2101.3001.7020)
========================================================================================================

**生命周期钩子** ====> **生命周期函数**  
![](https://img-blog.csdnimg.cn/20200512142741595.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>vue生命周期函数</title>
</head>

<body>
  <div id="app">
    <span id="sp"> {{ msg }} </span>
    <input type="button" value="改变data的值" @click="changeData">
  </div>
  <!-- 引入Vue  -->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        msg: "hello Vue.js!",
      },
      methods: {
        changeData() {
          // this.msg = "Vue.js niubility!";
          this.msg = Math.random();
        }
      },
      // ====================初始化阶段====================
      // 1.生命周期中第一个函数,该函数在执行时Vue实例仅仅完成了自身事件的绑定和生命周期函数的初始化工作,Vue实例中还没有 Data el methods相关属性
      beforeCreate() {
        console.log("beforeCreate: " + this.msg);
      },
      // 2.生命周期中第二个函数,该函数在执行时Vue实例已经初始化了data属性和methods中相关方法
      created() {
        console.log("created:" + this.msg);
      },
      // 3.生命周期中第三个函数,该函数在执行时Vue将El中指定作用范围作为模板编译
      beforeMount() {
        console.log("beforeMount: " + document.getElementById("sp").innerText);
      },
      // 4.生命周期中第四个函数,该函数在执行过程中,已经将数据渲染到界面中并且已经更新页面
      mounted() {
        console.log("Mounted: " + document.getElementById("sp").innerText);
      },
      // ====================运行阶段====================
      // 5.生命周期中第五个函数,该函数是data中数据发生变化时执行 这个事件执行时仅仅是Vue实例中data数据变化页面显示的依然是原始数据
      beforeUpdate() {
        console.log("beforeUpdate-vue: " + this.msg);
        console.log("beforeUpdate-dom: " + document.getElementById("sp").innerText);
      },
      // 6.生命周期中第六个函数,该函数执行时data中数据发生变化,页面中数据也发生了变化  页面中数据已经和data中数据一致
      updated() {
        console.log("updated-vue: " + this.msg);
        console.log("updated-dom: " + document.getElementById("sp").innerText);
      },
      // ====================销毁阶段====================
      // 7.生命周期第七个函数,该函数执行时,Vue中所有数据 methods componet 都没销毁
      beforeDestory() { },
      // 8.生命周期的第八个函数,该函数执行时,Vue实例彻底销毁
      destoryed() { }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200512143007633.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

Vue 中组件（[Component](https://so.csdn.net/so/search?q=Component&spm=1001.2101.3001.7020)）
=======================================================================================

**组件作用**：用来减少 Vue 实例对象中代码量，日后在使用 Vue 开发过程中，可以根据不同业务功能将页面中划分不同的多个组件，然后由多个组件去完成整个页面的布局，便于日后使用 Vue 进行开发时页面管理，方便开发人员维护。

全局组件的开发
-------

全局组件注册给 Vue 实例，可以在任意 Vue 实例的范围内使用该组件。

全局组件的开发：

```
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <title>全局组件的开发</title>
</head>
<body>
  <div id="app">
    <!-- 使用全局组件 -->
    <login></login>
    <!-- 使用局部组件 -->
    <user-login></user-login>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    // 开发全局组件
    // 参数1: 组件名称
    // 参数2: 组件配置对象 template:用来书写组件的html代码(注意:在template中必须存在一个容器)
    Vue.component('login', {
      template : '<div><h1>用户登录</h1></div>'
    });
    // 驼峰命名法的组件会被特殊处理, userLogin 使用时必须写成 user-login
    Vue.component('userLogin', {
      template : '<div><input type="button" value="登录"></div>'
    });
    const app = new Vue({
      el: "#app",
      data: {},
      methods: {},
    });
  </script>
</body>
</html>
```

![](https://img-blog.csdnimg.cn/20200512233155699.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

局部组件的开发
-------

通过将组件注册给对应 Vue 实例中一个 `components` 属性来完成组件注册，这种方式不会对 Vue 实例造成累加。

第一种开发方式：

```
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>局部组件的开发</title>
</head>

<body>
  <div id="app">
    <login></login>
    <login></login>
    <login></login>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    // 定义变量用来保存模板配置对象
    const login = {
      template: '<div><h2>用户登录</h2></div>'
    };
    const app = new Vue({
      el: "#app",
      data: {},
      methods: {},
      components: { // 局部组件
        login: login // 注册局部组件
      }
    });
  </script>
</body>

</html>
```

第二种开发方式：

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>局部组件的开发2</title>
</head>

<body>
  <div id="app">
    <login></login>
    <login></login>
    <login></login>
  </div>

  <!--声明局部组件模板  template标签 注意:在 Vue 实例作用范围外声明-->
  <template id="loginTemplate">
    <h2>用户登录</h2>
  </template>

  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    // 定义变量用来保存模板配置对象
    const login = { // 具体局部组件名称
      template: '#loginTemplate' // 定义template标签选择器即可
    };
    const app = new Vue({
      el: "#app",
      data: {},
      methods: {},
      components: { // 局部组件
        login: login // 注册局部组件
      }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/2020051223360815.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

组件中 props 的使用
=============

`props` 用来给组件传递相应静态数据或者是动态数据；

在组件上声明静态数据传递给组件内部
-----------------

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>在局部组件中使用props接收静态数据</title>
</head>

<body>
  <div id="app">
    <!--使用组件, 通过组件进行静态数据传递-->
    <login user-></login>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    // 声明一个组件模板配置对象
    let login = {
      template: '<div><h2>欢迎: {{ userName }} 年龄: {{ age }}</h2></div>',
      props: ['userName', 'age'] // props: 用来接收使用组件时通过组件标签传递的数据
    }
    const app = new Vue({
      el: "#app",
      data: {},
      methods: {},
      components: {
        login // 组件注册
      }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200512234739105.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

在组件上声明动态数据传递给组件内部
-----------------

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>在局部组件中使用prop接收动态数据</title>
</head>

<body>
  <div id="app">
    <!--使用组件接收 Vue 实例中的动态数据-->
    <!--使用 v-bind 形式将数据绑定到 Vue 实例中 data 属性, data 属性发生变化, 组件内部数据跟着变化-->
    <login v-bind:></login>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const login = {
      template: '<div><h2>欢迎: {{ name }} 年龄: {{ age }}</h2></div>',
      props: ['name', 'age']
    }
    const app = new Vue({
      el: "#app",
      data: {
        username: "zhenyu",
        userage: 25
      },
      methods: {},
      components: {
        login // 注册组件
      }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200512234733269.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

props 的单向数据流
------------

所有的 props 都使得其父子 props 之间形成了一个**单向下行绑定**：父级 props 的更新会向下流动到子组件中，但是反过来则不行。这样会防止从子组件意外改变父级组件的状态，从而导致你的应用的数据流向难以理解。

额外的，每次父级组件发生更新时，子组件中所有的 props 都将会刷新为最新的值。这意味着你**不应该**在一个子组件内部改变 props。如果你这样做了，Vue 会在浏览器的控制台中发出警告。— 摘自官网

组件中定义数据和事件使用
============

组件中定义属于组件的数据
------------

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>组件中定义自己的data数据</title>
</head>

<body>
  <div id="app">
    <!--组件的使用-->
    <login></login>
  </div>
  <!-- 引入Vue -->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const login = {
      template: '<div><h2>{{ msg }}</h2><ul><li v-for="item,index in lists"> {{index+1}} : {{ item }} </li></ul></div>',
      data() {
        return {
          msg: "hello Vue.js !",
          lists: ['java', 'C++', 'python'],
        }; // 组件内部的数据
      }
    };
    const app = new Vue({
      el: "#app",
      data: {},
      methods: {},
      components: {
        login // 注册组件
      }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200512235001483.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

组件中定义属于组件的事件
------------

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>组件中事件的定义</title>
</head>

<body>
  <div id="app">
    <!--使用组件-->
    <login></login>
  </div>
  <!-- 引入Vue -->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const login = {
      // 组件中定义了属于组件的事件 @click="change"
      template: '<div><h2>{{ hello }}</h2><input type="button" value="点我触发组件的事件" @click="change"></div>',
      data() {
        return {
          hello: 'Hello Vue.js!',
        };
      },
      // 组件中定义的 @click="change" 事件
      methods: {
        change() {
          alert(this.hello);
        }
      }
    }
    const app = new Vue({
      el: "#app",
      data: {},
      methods: {},
      components: {
        login // 注册组件
      }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200512235305364.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

向子组件中传递 Vue 实例 的事件并调用该事件
------------------------

在子组件中调用传递过来的相关事件使用 `this.$emit('函数名')` 方式调用；

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>向组件中传递事件并调用</title>
</head>

<body>
  <div id="app">
    <!--v-bind: 是绑定了Vue实例中的动态数据-->
    <!--@aaa="findAll" 是将Vue实例中的函数绑定给了aaa, 在组件中通过this.$emit('aaa')来调用-->
    <login : @aaa="findAlll"></login>
  </div>

  <!-- 引入Vue -->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    // 组件
    const login = {
      template: '<div><h2>{{ show }}</h2><input type="button" value="点我触发事件" @click="change"></div>',
      data() {
        return {
          show: this.name,
        }
      },
      props: ['name'],
      methods: {
        change() { // 组件自身的函数
          // 调用vue实例中函数
          this.$emit('aaa')
        }
      }
    }
    // Vue实例
    const app = new Vue({
      el: "#app",
      data: {
        msg: 'Hello Vue.js!'
      },
      methods: {
        findAlll() {
          alert('Vue实例中的事件触发了！');
        }
      },
      components: {
        login // 注册组件
      }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/2020051223581226.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)