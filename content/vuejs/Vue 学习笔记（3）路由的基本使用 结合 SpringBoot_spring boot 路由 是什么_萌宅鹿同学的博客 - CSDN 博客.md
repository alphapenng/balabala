> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/106983288)

### Vue 中的路由（VueRouter）

*   [路由的基本使用](#_16)
*   [router-link 使用](#routerlink__68)
*   [默认路由](#_82)
*   [路由中参数的传递](#_95)
*   *   [传统方式传递参数](#_96)
    *   [restful 方式传递参数](#restful__112)
    *   [完整示例](#_135)
*   [嵌套路由](#_188)
*   [路由结合 SpringBoot 案例](#_SpringBoot__252)
*   *   [后台控制器](#_253)
    *   [前端页面](#_272)

> [Vue 笔记目录](https://blog.csdn.net/weixin_43734095/article/details/106910854)

路由：根据请求的路径按照一定的路由规则进行请求的转发从而实现统一请求的管理；

路由的作用：用来在 Vue 中实现 **组件之间的动态切换**；

在项目中使用路由：

```
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router@3.3.4/dist/vue-router.js"></script>
```

路由的基本使用
=======

1.  创建组件对象；
2.  定义路由对象的规则；
3.  将路由对象注册到 vue 实例；
4.  在页面中显示路由的组件；
5.  根据链接切换路由；

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>路由的基本使用</title>
</head>
<body>
<div id="app">
    <!--4、在页面中显示路由的组件-->
    <router-view></router-view>
    <!--5、根据链接切换路由组件-->
    <a href="#/login">点我登录</a>
    <a href="#/register">点我注册</a>
</div>
</body>
</html>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router@3.3.4/dist/vue-router.js"></script>
<script>

    // 1、创建组件对象
    const login = {
        template: "<h1>登录</h1>"
    };
    const register = {
        template: "<h1>注册</h1>"
    };

    // 2、创建路由对象
    const router = new VueRouter({
        routes: [ // 定义路由对象的规则
            // path:设置路由的路径, component:路径对应的组件
            {path: "/login", component: login},
            {path: "/register", component: register}
        ]
    });
    
    const app = new Vue({
        el: "#app",
        data: {},
        methods: {},
        router: router // 3、在vue实例中注册路由对象
    });
</script>
```

router-link 使用
==============

作用：在切换路由时可以自动给路由路径加入`#`不需要手动加入。

使用 **a 标签** 切换路由： 需要在路径前面加 `#`；

```
<a href="#/login">点我登录</a>
<a href="#/register">点我注册</a>
```

使用 **router-link** 切换路由：

*   `to` 属性书写路由路径；`tag` 属性将 router-link 渲染成指定的标签；

```
<router-link to="/login" tag="a">我要登录</router-link>
<router-link to="/register" tag="button">点我注册</router-link>
```

默认路由
====

作用：用来在第一次进入界面是显示一个默认的组件；

```
const router = new VueRouter({
    routes: [
        // {path: "/", component: login},
        {path: "/", redirect:"/login"}, // redirect:当访问的是默认路由"/"时, 跳转到指定的路由展示[推荐]
        {path: "/login", component: login},
        {path: "/register", component: register}
    ]
});
```

路由中参数的传递
========

传统方式传递参数
--------

1.  URL 中通过 `?` 拼接参数：

```
<router-link to="/login?user>我要登陆</router-link>
```

2.  在组件中获取参数：通过 `this.$route.query.xxx` 来获取参数；

```
const login = {
    template: "<h1>用户登录</h1>",
    data() {return{}},
    methods: {},
    created() {
        console.log(" + this.$route.query.pwd)
    }
};
```

[restful](https://so.csdn.net/so/search?q=restful&spm=1001.2101.3001.7020) 方式传递参数
---------------------------------------------------------------------------------

1.  通过使用路径方式传递参数：

```
const router = new VueRouter({
    routes: [
        {path: "/register/:name/:pwd", component: register}
    ]
});
```

```
<router-link to="/register/zhenyu/12345" tag="a">我要注册</router-link>
```

2.  在组件中获取参数：通过 `this.$route.params.xxx` 来获取参数；

```
const register = {
    template: "<h1>用户注册</h1>",
    data() {return{}},
    methods: {},
    created() {
        console.log(" + this.$route.params.pwd);
    }
};
```

完整示例
----

```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>路由中传递参数</title>
</head>

<body>
<div id="app">
    <router-view></router-view>
    <router-link to="/login?>我要登陆</router-link>
    <router-link to="/register/zhenyu/12345" tag="a">我要注册</router-link>
</div>
</body>
</html>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router@3.3.4/dist/vue-router.js"></script>
<script>
    const login = {
        template: "<h1>用户登录 {{this.$route.query.name}}</h1>",
        data() {return{}},
        methods: {},
        created() {
            console.log(" + this.$route.query.pwd);
        }
    };
    const register = {
        template: "<h1>用户注册 {{this.$route.params.name}} </h1>",
        data() {return{}},
        methods: {},
        created() {
            console.log(" + this.$route.params.pwd);
        }
    };
    const router = new VueRouter({
        routes: [
            {path: "/", redirect: "/login"},
            {path: "/login", component: login},
            {path: "/register/:name/:pwd", component: register}
        ]
    });
    const app = new Vue({
        el: "#app",
        data: {},
        methods: {},
        router // 注册路由
    });
</script>
```

![](https://img-blog.csdnimg.cn/20200627205654495.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

嵌套路由
====

1.  声明最外层和内层组件对象；
2.  创建含有路由对象的路由对象 (嵌套路由)，通过 `chidren` 嵌套；
3.  注册与使用路由；

```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>路由中传递参数</title>
</head>

<body>
<div id="app">
    <router-link to="/product">商品管理</router-link>
    <router-view></router-view>
</div>
<template id="product">
    <div>
        <h1>商品管理</h1>
        <router-link to="/product/add">商品添加</router-link>
        <router-link to="/product/edit">商品编辑</router-link>
        <router-view></router-view>
    </div>
</template>
</body>
</html>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router@3.3.4/dist/vue-router.js"></script>
<script>
    // 声明最外层和内层组件对象
    const product = {
        template: '#product'
    };
    const add = {
        template: "<h4>商品添加</h4>"
    };
    const edit = {
        template: "<h4>商品编辑</h4>"
    };
    // 创建含有路由对象的路由对象(嵌套路由), 通过children嵌套
    const router = new VueRouter({
        routes: [
            {
                path: "/product",
                component: product,
                children: [
                    {path: "add", component: add},
                    {path: "edit", component: edit},
                ]
            },
        ]
    });

    const app = new Vue({
        el: "#app",
        data: {},
        methods: {},
        router // 注册路由
    });
</script>
```

路由结合 SpringBoot 案例
==================

后台控制器
-----

这是一个简单的演示性的小项目，后台控制器返回一串 Json 字符串。

```
@RestController
@RequestMapping("user")
@CrossOrigin
public class UserController {
    @GetMapping("findAll")
    public List<User> findAll() {
        List<User> list = Arrays.asList(
                new User("21", "zhenyu", 21, new Date()),
                new User("22", "小三", 24, new Date()),
                new User("23", "小明", 25, new Date())
        );
        return list;
    }
}
```

![](https://img-blog.csdnimg.cn/20200627231703625.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

前端页面
----

前端页面通过 Axios 获取后端传递的 Json 字符串。

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>使用vue开发简单页面</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
</head>
<body>

<div id="app">
    <div class="container">
        <div class="row" style="margin-top: 70px;">
            <div class="col-md-10 col-md-offset-1">
                <ul class="nav nav-pills nav-justified">
                    <li role="presentation" :class="showAtice=='home'?'active':''"><a href="#/home" @click="changActive('home')">主页</a></li>
                    <li role="presentation" :class="showAtice=='user'?'active':''"><a href="#/user" @click="changActive('user')" >用户管理</a></li>
                    <li role="presentation" :class="showAtice=='student'?'active':''"><a href="#/student" @click="changActive('student')">学生管理</a></li>
                </ul>
            </div>
        </div>
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <!--显示路由组件内容-->
                <router-view></router-view>
            </div>
        </div>
    </div>
</div>

<template id="home">
    <div>
        <div class="jumbotron" style="margin-top: 100px;">
            <h1>Hello, world!</h1>
            <p>This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
            <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
        </div>
    </div>
</template>

<template id="user">
    <div>
        <table class="table table-strip" style="margin-top: 100px;">
            <tr>
                <th>id</th>
                <th>姓名</th>
                <th>年龄</th>
                <th>生日</th>
                <th>操作</th>
            </tr>
            <tr v-for="user in users">
                <td>{{user.id}}</td>
                <td>{{user.name}}</td>
                <td>{{user.age}}</td>
                <td>{{user.bir}}</td>
                <td><a href="" class="btn btn-default">修改</a>
                    <a href="" class="btn btn-danger">删除</a>
                </td>
            </tr>

        </table>
    </div>
</template>

<template id="student">
    <div>
        <table class="table table-strip" style="margin-top: 100px;">
            <tr>
                <th>id</th>
                <th>学生姓名</th>
                <th>学历</th>
                <th>邮箱</th>
                <th>操作</th>
            </tr>
            <tr>
                <td>1</td>
                <td>张三</td>
                <td>23</td>
                <td>2012-12-12</td>
                <td><a href="" class="btn btn-default">修改</a>
                    <a href="" class="btn btn-danger">删除</a>
                </td>
            </tr>
        </table>
    </div>
</template>

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    // 1. 主页组件配置对象
    const home = {
        template : "#home",
    }
    // 2.用户管理组件配置对象
    const user = {
        template: "#user",
        data(){
            return {
                users:[],
            }
        },
        methods: {},
        created() {
            //发送查询所有用户信息
            _this = this;
            axios.get("http://localhost:8080/user/findAll").then((res)=>{
                console.log(res.data);
                _this.users = res.data;
            });
        }
    }
    // 3.学生管理组件的配置对象
    const student = {
        template: "#student",
    }

    // 路由对象
    const router = new VueRouter({
        routes: [
            {path: '/', redirect: '/home'},
            {path: '/home', component: home},
            {path: '/user', component: user},
            {path: '/student', component: student},
        ]
    });

    const app = new Vue({
        el: "#app",
        data: {
            showAtice: 'home',
        },
        methods: {
            changActive(value) {
                console.log(value);
                this.showAtice = value;
                console.log(this.showAtice);
            }
        },
        router: router // 注册路由
    });
</script>
</body>
</html>
```

![](https://img-blog.csdnimg.cn/2020062723182850.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
![](https://img-blog.csdnimg.cn/20200627231833561.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
![](https://img-blog.csdnimg.cn/20200627231839662.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)