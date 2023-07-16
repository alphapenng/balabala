> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/106043517)

### [Vue](https://so.csdn.net/so/search?q=Vue&spm=1001.2101.3001.7020)

*   [Vue 简介](#Vue__3)
*   *   [下载 Vue](#_Vue_12)
*   [{{}}：插值表达式](#_24)
*   [v-text：显示文本](#vtext_64)
*   [v-html：显示解析 html 标签的文本](#vhtmlhtml_138)
*   [v-on：事件绑定](#von_169)
*   [v-show：控制页面元素隐藏与显示 (display 控制)](#vshowdisplay_213)
*   [v-if：控制页面元素隐藏与显示 (dom 操作)](#vifdom_267)
*   [v-bind：绑定标签的属性](#vbind_303)
*   [v-show、v-if、v-bind 综合](#vshowvifvbind__352)
*   [v-for：遍历对象](#vfor_407)
*   [v-model：实现双向绑定](#vmodel_469)
*   [【项目】记事本案例](#_515)
*   [事件修饰符](#_588)
*   [按键修饰符](#_657)
*   [Axios 基本使用](#Axios__720)
*   *   [GET 方式的请求](#GET_725)
    *   [POST 方式的请求](#POST_757)
    *   [Axios 并发请求](#Axios__795)

> [Vue 笔记目录](https://blog.csdn.net/weixin_43734095/article/details/106910854)

Vue 简介
======

**渐进式 JavaScript 框架**

*   易用 html css javascript
*   高效 开发前端页面 非常高效
*   灵活 开发灵活 多样性

Vue 是渐进式 javascript 框架：让我们通过操作很少的 DOM，甚至不需要操作页面中任何 DOM 元素，就很容易的完成 **数据和视图绑定**、**双向绑定 MVVM**。

注意：日后在使用 Vue 过程中页面中不需要再引入 Jquery 框架。

下载 Vue
------

开发版本：

```
<!-- 开发环境版本，包含了有帮助的命令行警告 -->
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
```

生产版本：

```
<!-- 生产环境版本，优化了尺寸和速度 -->
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
```

{{}}：插值表达式
==========

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vue 入门</title>
</head>
<body>

    <div id="app">
        <span> I am {{name}} ! </span>
        <br>
        <span>
            {{ msg }}
        </span>
    </div>

    <!--引入vue.js-->
	    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script>
        const app = new Vue({
            el : "#app", // element 用来给 Vue 实例定义一个作用范围
            data : {     // 用来给 Vue 定义一些相关数据
                msg : "Hello Vue.js !",
                name : "zhenyu"
            }
        });
    </script>

</body>
</html>
```

![](https://img-blog.csdnimg.cn/20200511002943192.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
总结：

*   Vue 实例对象中 `el` 属性：代表 Vue 的作用范围，在 Vue 的作用范围内都可以使用 Vue 的语法。
*   Vue 实例对象中 `data` 属性：用来给 Vue 实例绑定一些相关数据，绑定的数据可以通过 `{{ xx }}` 在 Vue 作用范围内取出。
*   在使用 `{{ xx }}` 进行获取 `data` 中数据时，可以在 `{{ }}` 中书写表达式、运算符、调用相关方法以及逻辑运算等。
*   `el` 属性中可以书写任意的 CSS 选择器 [jquery 选择器]，但是在使用 Vue 开发**推荐使用 id 选择器**。

v-text：显示文本
===========

`v-text`：用来获取 data 中数据将数据以文本的形式渲染到指定标签内部，类似于 javascript 中 `innerText`。

使用 `v-text`：

```
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <title>v-text</title>
</head>
<body>
  <div id="app">
    <h3 v-text="msg"></h3>
    <h3>姓名：<span v-text="user.name"/></h3>
    <h3>年龄: <span v-text="user.age"/></h3>
    <h3>{{lists[0]}}---{{lists[1]}}---{{lists[2]}}</h3>
    <h3 v-text="users[0].name"></h3>
  </div>
  <!--引入vue.js-->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        msg: "Hello Vue.js !",
        user: { name: "zhenyu", age: 20 },
        age: 23,
        lists: ["北", "南", "西", "东"],
        users: [{ name: "zhangsan", age: 20 }, { name: "lisi", age: 19 }]
      }
    });
  </script>
</body>
</html>
```

使用 `{{}}`：

```
<body>

    <div id="app">
        <h3>{{ msg }}</h3>

        <h3>名称: {{ user.name }}</h3>

        <h3>年龄: {{ user.age }}</h3>

        <h3>{{ lists[0] }} --- {{ lists[1] }} --- {{ lists[2] }} </h3>

        <h3>{{ users[0].name }}</h3>
    </div>

    <!--引入vue.js-->
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script>
        const app = new Vue({
            el: "#app",
            data: {
                msg: "Hello Vue.js !",
                user: {name: "zhenyu", age: 20},
                age: 23,
                lists: ["北", "南", "西", "东"],
                users: [{name: "zhangsan", age: 20}, {name: "lisi", age: 19}]
            }
        });
    </script>

</body>
```

![](https://img-blog.csdnimg.cn/20200510223147370.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
`{{ xx }}`（插值表达式）和 `v-text` 获取数据的区别在于：

*   使用 `v-text` 取值会**将标签中原有的数据覆盖**，  
    插值表达式的形式不会覆盖标签原有的数据。
*   使用 `v-text` 可以避免在网络环境较差的情况下出现插值闪烁。（已修复）

v-html：显示解析 html 标签的文本
======================

`v-html`：用来获取 data 中数据将数据中含有的 html 标签先解析在渲染到指定标签的内部，类似于 javascript 中 `innerHTML`。

```
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <title>v-text</title>
</head>
<body>
  <div id="app">
    <span> {{ message }} xxxxxxxxxx</span> <!--不会解析-->
    <br>
    <span v-text="message">xxxxxxxxxx</span> <!--不会解析-->
    <br>
    <span v-html="message">xxxxxxxxxx</span> <!--会解析html-->
</div>
  <!--引入vue.js-->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el : "#app",
      data : {
        message: "<a href=''>hello Vue.js</a>"
      }
    })
  </script>
</body>
</html>
```

![](https://img-blog.csdnimg.cn/20200510223232538.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

v-on：事件绑定
=========

`v-on`：事件绑定

*   `v-on:click` 可以简化成 `@click`
*   事件函数可以简写，`dowork: function() {}` 可以简写成 `dowork() {}`

```
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <title>v-on</title>
</head>
<body>
  <div id="app">
    <h2>鼠标点击次数: {{count}}</h2>
    <h2>年龄: {{age}}</h2>
    <input type="button" value="通过v-on事件修改年龄每次+1" v-on:click="changeage">
    <input type="button" value="通过@绑定事件修改年龄每次-1" @click="editage">
    <input type="button" value="统计点击次数" @click="clickcount">
  </div>
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el : "#app",
      data : {
        age: 23,
        count: 0,
      },
      methods : {
        changeage : function() {
          this.age++;
        },
        editage() {
          this.age--;
        },
        clickcount() {
          this.count++;
        }
      } 
    });
  </script>
</body>
</html>
```

![](https://img-blog.csdnimg.cn/20200510223454523.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

v-show：控制页面元素隐藏与显示 (display 控制)
===============================

`v-show`：用来控制页面中某个标签元素是否展示，底层通过控制元素的 `display` 属性来进行标签的显示和不显示控制。

*   在 `v-show` 中可以直接书写 `boolean` 值控制元素展示
*   在 `v-show` 中可以通过 **变量** 控制标签展示和隐藏。
*   在 `v-show` 中可以通过 **boolean 表达式** 控制标签的展示和隐藏。

```
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>v-html</title>
</head>

<body>
  <div id="app">
    <h2 v-show="false">hello Vue.j</h2>
    <!--直接书写boolean隐藏标签-->
    <h2> 年龄: {{ age }} </h2>
    <h2 v-show="show">恭喜你发现了隐藏内容！</h2>
    <!--利用变量show控制是否显示, 只有show为true才会显示-->
    <input type="button" value="展示隐藏标签" @click="showmsg">
    <!--利用表达式控制隐藏与显示, age>=30才会显示-->
    <h2 v-show="age >= 30">年龄达到了30，显示该内容！</h2>
    <input type="button" @click="changeAge" value="age>=30显示标签">
  </div>
  <!--引入vue.js-->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        show: false,
        age: 23,
      },
      methods: {
        showmsg() {
          this.show = !this.show;
        },
        changeAge() {
          this.age++;
          console.log(this.age);
        }
      }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200511004059534.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
点击 `展示隐藏标签` 后会显示内容。  
点击 `增加年龄` 将年龄增大到 30 后会显示内容。  
![](https://img-blog.csdnimg.cn/20200511004050339.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

v-if：控制页面元素隐藏与显示 (dom 操作)
=========================

`v-if`：用来控制页面中的标签元素是否展示，底层通过对 dom 树节点进行添加和删除来控制展示和隐藏。

与 `v-show` 的用法一模一样，参考 `v-show` 即可。

```
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>v-if</title>
</head>

<body>
<div id="app">
  <h2 v-if="false">hello Vue.js!</h2>
  <!--隐藏-->
  <h2 v-if="show">hello Vue.js!</h2>
  <!--隐藏-->
</div>
<!--引入vue.js-->
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>
  const app = new Vue({
    el: "#app",
    data: {
      show: true
    },
    methods: {}
  });
</script>
</body>

</html>
```

v-bind：绑定标签的属性
==============

`v-bind`：用来绑定 **标签的属性** 从而通过 vue 动态修改标签的属性。

*   `v-bind : 属性` 可以简写成 `: 属性`

```
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>v-bind</title>
  <style>
    .aa {
      border: 10px red solid;
    }
  </style>
</head>

<body>
  <div id="app">
    <img width="300" v-bind:title="msg" v-bind:class="{aa:showCss}" :src="src" alt="">
    <input type="button" value="动态控制加入样式" @click="addCss">
    <input type="button" value="改变图片" @click="changeSrc">
  </div>
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        msg: "这是一个logo!!!!",
        showCss: false,
        src: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583490365568&di=52a82bd614cd4030f97ada9441bb2d0e&imgtype=0&src=http%3A%2F%2Fimg.kanzhun.com%2Fimages%2Flogo%2F20160714%2F820a68f65b4e4a3634085055779c000c.jpg"
      },
      methods: {
        addCss() {
          this.showCss = !this.showCss;
        },
        changeSrc() {
          this.src = "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1925088662,1336364220&fm=26&gp=0.jpg";
        }
      }
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200511005326993.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
点击 `动态控制加入样式` 和 `改变图片`：  
![](https://img-blog.csdnimg.cn/20200511005355241.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

v-show、v-if、v-bind 综合
=====================

```
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>v-show、v-if、v-bind综合</title>
</head>

<body>
  <div id="app">
    <h1 v-show="true">hello Vue.js!</h1>
    <h1 v-show="isShow">hello Vue.js!</h1>

    <input type="button" value="点我显示隐藏" @click="showHide">

    <hr>
    <h1 v-if="false">这个是不会显示的, 除非前面是true</h1>
    <hr>

    <img width="300px" :title="title" :src="src">

    <input type="button" value="点我改变title属性" @click="changeTitle('这是改变之后的title')">
    <input type="button" value="点我改变src属性" @click="changeSrc('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1664551187,1969969469&fm=26&gp=0.jpg')">
  </div>
  <!-- 开发环境版本，包含了有帮助的命令行警告 -->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        isShow: false,
        title: "这时候title还没有改变",
        src: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2808071861,2141871492&fm=26&gp=0.jpg"
      },
      methods: { //用来定义事件函数
        showHide() {
          this.isShow = !this.isShow;
        },
        changeTitle(value) {
          console.log(value);
          this.title = value;
        },
        changeSrc(src) {
          this.src = src;
        }
      }
    });
  </script>
</body>

</html>
```

v-for：遍历对象
==========

`v-for`：用来对 **对象** 进行遍历的（JavaScript 中数组也是对象的一种）

*   在使用 `v-for` 的时候一定要注意加入`:key` 用来给 Vue 内部提供重用和排序的唯一 key
*   遍历时可以获取 索引 `index`、…

```
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>v-for</title>
</head>

<body>
  <div id="app">
    <span> {{ user.name }} {{ user.age }} </span>
    <br>
    <!--通过 v-for 遍历对象-->
    <span v-for="(value, key, index) in user">
      {{index}} : {{key}} : {{value}} <br>
    </span>
    <!--通过 v-for 遍历数组-->
    <ul>
      <li v-for="(a, index) in array">
        {{index + 1}} : {{a}}
      </li>
    </ul>
    <!--
     通过 v-for 遍历数组中对象
     :key 便于vue内部做重用和排序
    -->
    <ul>
      <li v-for="user, index in users" :key="user.id">
        {{index + 1}}<br>
        name: {{user.name}}<br>
        age: {{user.age}}<br>
        hobby: {{user.hobby}}
      </li>
    </ul>
  </div>
  <!--引入vue.js-->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        user: { name: 'zhenyu', age: 20 },
        array: ["North", "South", "West", "East"],
        users: [
          { id: 1, name: "zhangsan", age: 18, hobby: "html、css、javascript" },
          { id: 2, name: "lisi", age: 122, hobby: "java、python、c++" },
          { id: 3, name: "wangwu", age: 20, hobby: "go、rust、Ruby" }
        ]
      },
      methods: {}
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/2020062223510097.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

v-model：实现双向绑定
==============

`v-model`：用来绑定 **标签元素的值** 与 **vue 实例对象中 data 数据** 保持一致，从而实现 **双向的数据绑定机制**。

*   所谓双向绑定，就是表单中数据变化导致 vue 实例 data 数据变化，vue 实例中 data 数据的变化导致表单中数据变化。

> MVVM 架构 双向绑定机制  
> Model：数据 Vue 实例中绑定数据  
> View：页面 页面展示的数据  
> VM：ViewModel 监听器

```
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>v-model</title>
</head>

<body>
  <div id="app">
    <input type="text" v-model="message">
    <span> {{ message }} </span>
    <hr>
    <input type="button" value="改变data中的值" @click="changeValue">
  </div>
  <!-- 引入Vue-->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        message: ""
      },
      methods: {
        changeValue() {
          this.message = "hello Vue.js!"
        }
      },
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200510233816916.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
![](https://img-blog.csdnimg.cn/20200510233824809.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

【项目】记事本案例
=========

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>记事本综合案例</title>
</head>

<body>
  <div id="app">
    <input type="text" v-model="msg">
    <input type="button" value="添加到记事本" @click="save"><br><br>
    【记事本内容】:
    <ul v-for="item,index in lists">
      <li>
        {{ index + 1}} : {{ item }} <a href="javascript:;" @click="delRow(index)">删除</a>
      </li>
    </ul>
    <br>
    <span>总数量: {{ lists.length }} 条</span>
    <input type="button" v-show="lists.length != 0" value="删除所有" @click="deleteAll">
  </div>

  <!--
     1.完成记事本的查询所有思路: 
      1).将所有数据绑定为vue实例 
      2).遍历vue实例中数据到页面
    2.添加 
      1).添加按钮绑定事件中 
      2).在事件中获取输入框中数据 
      3).将获取的数据放入到lists里面
     1.完成记事本的查询所有思路: 
      1).将所有数据绑定为vue实例 
      2).遍历vue实例中数据到页面
    2.添加 
      1).添加按钮绑定事件中 
      2).在事件中获取输入框中数据 
      3).将获取的数据放入到lists里面
    3.删除  
      1).删除所有  
      2).总数量
    -->
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        lists: ["这是一个记事本的小案例！"],
        msg: ''
      },
      methods: {
        save() {
          this.lists.push(this.msg)
          this.msg = ''
        },
        delRow(index) { // 删除一条记录
          // 根据下标删除数组中某个元素
          this.lists.splice(index)
        },
        deleteAll() { // 删除所有数据
          this.lists = []
        },
      },
    });
  </script>
</body>

</html>
```

![](https://img-blog.csdnimg.cn/20200511001350325.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

事件修饰符
=====

修饰符作用：用来和事件连用，决定事件触发条件或者是阻止事件的触发机制。

常用的事件修饰符：

*   `.stop`：用来阻止事件冒泡。
*   `.prevent`：用来阻止标签的默认行为。
*   `.capture`
*   `.self`：只触发自己标签的上特定动作的事件，不监听事件冒泡。
*   `.once`：让指定事件只触发一次。
*   `.passive`

```
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>vue中事件修饰符使用</title>
  <style>
    .aa {
      background: red;
      width: 300px;
      height: 300px;
    }
  </style>
</head>

<body>
  <div id="app">
    <!--self事件修饰符, 只出发标签自身的事件-->
    <div class="aa" @click.self="divClick">
      <!--stop事件修饰符, 用来阻止事件冒泡-->
      <input type="button" value="按钮" @click.stop="btnClick">
      <input type="button" value="按钮1" @click="btnClick1">
    </div>
    <hr>
    <!--prevent事件修饰符, 用来阻止标签的默认行为-->
    <!--a标签的默认行为就是跳转, prevent阻止了跳转-->
    <!--.once: 用来只执行一次特定的事件-->
    <a href="http://hlzy.xyz/" @click.prevent.once="aClick">所愿皆所得, 所行化坦途</a>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {},
      methods: {
        // 事件冒泡, 点击了按钮, 然后会触发父元素(div)的事件
        // 用stop事件修饰符, 可以阻止事件冒泡
        btnClick() {
          alert("按钮被点击了。");
        },
        divClick() {
          alert("div被点击了。");
        },
        aClick() {
          alert("a标签被点击了。");
        },
        btnClick1() {
          alert("btn1被点击了。");
        }
      }
    });
  </script>
</body>

</html>
```

按键修饰符
=====

作用：用来与键盘中按键事件绑定在一起，用来修饰特定的按键事件的修饰符。

常用按键修饰符：`@keyup.xxx="function "`

```
.enter
.tab （捕捉通过tab跳转到当前按标签）
.delete (捕获“删除”和“退格”键)
.esc
.space
.up
.down
.left
.right
```

```
<!DOCTYPE html>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="UTF-8">
  <title>02.按键修饰符</title>
</head>

<body>
  <div id="app">
    <!--enter按键修饰符, 在回车之后触发事件-->
    <input type="text" v-model="msg" @keyup.enter="keyups" placeholder="enter"><br>
    <!--当使用tab键切换到这个标签时触发-->
    <input type="text" @keyup.tab="tabups" placeholder="tab"><br>
    <input type="text" @keyup.delete="deleteups" placeholder="delete"><br>
    <input type="text" @keyup.esc="escups" placeholder="esc"><br>
    <input type="text" @keyup.space="spaceups" placeholder="space"><br>
    <input type="text" @keyup.up="ups" placeholder="up"><br>
    <input type="text" @keyup.left="lefts" placeholder="left"><br>
    <input type="text" @keyup.right="rights" placeholder="right"><br>
    <input type="text" @keyup.down="downs" placeholder="down"><br>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script>
    const app = new Vue({
      el: "#app",
      data: {
        msg: '',
      },
      methods: {
        keyups() { alert(this.msg); },
        tabups() { alert("tab键触发") },
        deleteups() { alert("delete键触发") },
        escups() { alert("esc键触发") },
        spaceups() { alert("space键触发") },
        ups() { alert("↑") },
        lefts() { alert("←") },
        rights() { alert("→") },
        downs() { alert("↓") },
      },
    });
</script>
</body>

</html>
```

[Axios](https://so.csdn.net/so/search?q=Axios&spm=1001.2101.3001.7020) 基本使用
===========================================================================

中文网站：[https://www.kancloud.cn/yunye/axios/234845](https://www.kancloud.cn/yunye/axios/234845)

安装：[https://unpkg.com/axios/dist/axios.min.js](https://unpkg.com/axios/dist/axios.min.js)

GET 方式的请求
---------

```
<!--引入Axios-->
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>Axios - Get</title>
</head>

<body>
  <!--引入Axios-->
  <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
  <script>
    // 发送GET方式的请求
    axios.get('http://localhost:8989/user/findAll?name=zhangsan')
      .then(function (response) {
        console.log(response.data);
      }).catch(function (err) {
        console.log(err);
      })
    const app = new Vue({
      el: "#app",
      data: {},
      methods: {},
    });
  </script>
</body>

</html>
```

POST 方式的请求
----------

```
<!--引入Axios-->
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>Axios - Get</title>
</head>

<body>
  <!--引入Axios-->
  <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
  <script>
    // 发送POST方式的请求
    axios.post("http://localhost:8989/user/save", {
      id: "996",
      username: "zhenyu",
      age: 20,
      email: "zhenyu@123.com",
      phone: "123456789"
    }).then(function (response) {
      console.log(response.data);
    }).catch(function (err) {
      console.log(err);
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

Axios 并发请求
----------

**并发请求**：将多个请求在同一时刻发送到后端服务接口，最后在集中处理每个请求的响应结果。

```
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>Axios - Get</title>
</head>

<body>
  <!--引入Axios-->
  <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

  <script>
    // 1.创建一个擦汗寻所有的请求
    function findAll() {
      return axios.get("http://localhost:8989/user/findAll?);
    }
    // 2.创建一个保存的请求
    function save() {
      return axios.post("http://localhost:8989/user/save", {
        id: "996",
        username: "zhenyu",
        age: 20,
        email: "zhenyu@123.com",
        phone: "123456789"
      });
    }
    // 3.并发执行
    axios.all([findAll(), save()]).then(
      axios.spread(function (res1, res2) { // 用来将一组函数的响应结果汇总处理
        console.log(res1.data);
        console.log(res2.data);
      })); // 发送一组并发请求

    const app = new Vue({
      el: "#app",
      data: {},
      methods: {},
    });
  </script>
</body>

</html>
```