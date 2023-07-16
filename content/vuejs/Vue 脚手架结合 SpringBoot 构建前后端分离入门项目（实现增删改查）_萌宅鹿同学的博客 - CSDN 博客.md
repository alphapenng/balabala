> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/107003374)

### Vue 脚手架构建[前后端分离](https://so.csdn.net/so/search?q=%E5%89%8D%E5%90%8E%E7%AB%AF%E5%88%86%E7%A6%BB&spm=1001.2101.3001.7020)项目

*   [项目简介与预览](#_7)
*   [数据库建表](#_20)
*   [主要模块代码](#_33)
*   *   [index.js 路由代码](#indexjs__34)
    *   [User.vue 用户组件](#Uservue__68)
*   [RAP2 创建接口进行测试](#RAP2__143)
*   [切换路由组件的显示: this.$router.push ("/xxx")](#_thisrouterpushxxx_149)
*   [组件中监听路由的变化](#_162)
*   [@RequestBody 的作用](#RequestBody__177)
*   [项目的打包、部署到 SpringBoot](#_SpringBoot_184)
*   *   [Vue 脚手架项目打包](#Vue__185)
    *   [部署到 springboot 项目](#_springboot__195)

> 前端部分源码：[https://github.com/szluyu99/vue-cli-users_1](https://github.com/szluyu99/vue-cli-users_1)  
> 后端部分源码：[https://github.com/szluyu99/vue-cli-users_2](https://github.com/szluyu99/vue-cli-users_2)

> 前端笔记目录：[前端学习笔记](https://blog.csdn.net/weixin_43734095/article/details/106910854)

项目简介与预览
=======

这是一个 Vue 结合 SpringBoot 实现 **前后端分离** 的入门项目；

主要就是实现了简单的增删改查的模板项目；

访问项目：  
![](https://img-blog.csdnimg.cn/20200702004547137.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
点击 **主页**：  
![](https://img-blog.csdnimg.cn/20200702004615332.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
点击 **用户管理**：可以实现简单的增删改查功能。  
![](https://img-blog.csdnimg.cn/20200702004629324.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

数据库建表
=====

建立一个数据库：vue

然后建立数据库表：

```
create table t_user(
  id int(6) primary key auto_increment,
	name varchar(40),
	age int(3),
	bir TIMESTAMP
)
```

主要模块代码
======

index.js 路由代码
-------------

```
import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home";
import User from "../views/User"
import Student from "../views/Student";
import UserAdd from "../components/UserAdd";
import UserEdit from "../components/UserEdit";

Vue.use(VueRouter);

const routes = [
  {path: "/", redirect: "/home"},
  {path: "/home", component: Home},
  {
    path: "/user", component: User,
    children: [ // 嵌套路由
      {path: "add", component: UserAdd},
      {path: "edit", component: UserEdit}
    ]
  },
  {path: "/student", component: Student},
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
```

User.vue 用户组件
-------------

```
<template>
  <div>
    <h1>用户列表</h1>
    <table border="1">
      <tr>
        <td>编号</td>
        <td>姓名</td>
        <td>年龄</td>
        <td>生日</td>
        <td>操作</td>
      </tr>
      <tr v-for="user in users" :key="user.id">
        <td>{{user.id}}</td>
        <td>{{user.name}}</td>
        <td>{{user.age}}</td>
        <td>{{user.bir}}</td>
        <td> <a href="#" @click="delRow(user.id)">删除</a> | 
          <router-link :to="'/user/edit?id=' + user.id" tag="a">修改</router-link> </td>
      </tr>
    </table> 
    <router-link to="/user/add" tag="a">添加</router-link>    
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "User",
  data() {
    return {
      users: []
    }
  },
  methods: {
    findAll() { // 查询所有
      this.$http.get("http://localhost:8989/vue/user/findAll?page=1&rows=4").then((res) => {
        // console.log(this);
        this.users = res.data.results;
        // console.log(res.data.results);
      });
    },
    delRow(id) { // 删除
      //console.log(id);
      this.$http.get("http://localhost:8989/vue/user/delete?id=" + id).then((res) => {
        if (res.data.success) {
          alert(res.data.msg + ",点击确定刷新当前数据!")
          this.findAll(); // 删除完后刷新
        }
      });
    }
  },
  components: {
  },
  created() {
    this.findAll();
  },
  watch: { // 监听路由的变化 
    $route: {
      handler: function (val) {
        // console.log(val);
        if (val.path == "/user") { 
          this.findAll();
        }
      },
      // 深度观察监听
      deep: true
    }
   }
};
</script>
```

RAP2 创建接口进行测试
=============

RAP2 官网：[http://rap2.taobao.org/](http://rap2.taobao.org/)

这个网站很牛逼，可以创建后端接口，自定义请求和响应，可以创建返回 Json 格式数据的 URL，然后拿这个 URL 给前端开发人员进行测试。  
![](https://img-blog.csdnimg.cn/20200628223330498.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

切换路由组件的显示: this.$router.push ("/xxx")
=====================================

使用 `this.$router.push("/user")` 切换路由组件的显示；

```
saveUserInfo() {
  console.log(this.user);
  this.$http.post("http://rap2.taobao.org:38080/app/mock/259261/user/add", this.user).then((res) => {
    if (res.data.success) { // 添加成功
      this.$router.push("/user"); // 切换路由
    }
  });
}
```

组件中监听路由的变化
==========

```
watch: { // 监听路由的变化 
  $route: {
    handler: function (val, oldVal) {
      console.log(val);
      if (val.path == "/user") { 
        // this.findAll();
      }
    },
    // 深度观察监听
    deep: true
  }
 }
```

@RequestBody 的作用
================

`@RequestBody` 作用：将前端传递的 Json 格式数据 转换为 Java 对象。

前端传递 Json 格式数据：  
![](https://img-blog.csdnimg.cn/20200628223903788.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
后台控制器用 `@RequestBody` 将 Json 转为 Java 对象：  
![](https://img-blog.csdnimg.cn/20200628224014885.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)

项目的打包、部署到 SpringBoot
====================

Vue 脚手架项目打包
-----------

在项目根目录中执行如下命令：

```
npm run build
```

注：Vue 脚手架打包的项目必须在服务器上运行，不能直接双击运行；

在打包之后项目中出现 `dist` 目录，`dist` 目录就是 Vue 脚手架项目的生产目录（直接部署目录）。

部署到 springboot 项目
-----------------

打包完后，如何将项目部署到 SpringBoot 项目上呢？

将打包好的 `dist` 目录放到 SpringBoot 项目的 `static` 目录下；  
![](https://img-blog.csdnimg.cn/20200628221838665.png)  
由于我在配置文件中配置了项目路径：（没有访问路径则不需要修改）

```
server.servlet.context-path=/vue
```

所以要修改一下 index.html 中引入资源文件的路径；  
![](https://img-blog.csdnimg.cn/20200628221948822.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzczNDA5NQ==,size_16,color_FFFFFF,t_70)  
通过以下路径访问部署的前端页面：

```
http://localhost:8989/vue/dist/index.html
```