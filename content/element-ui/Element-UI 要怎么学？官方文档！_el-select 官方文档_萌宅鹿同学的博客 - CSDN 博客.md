> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_43734095/article/details/107014449)

### Element UI

*   [Element UI 介绍](#Element_UI__2)
*   [安装 Element UI](#_Element_UI_11)
*   [Element UI 组件使用](#Element_UI__30)
*   [Basic 组件](#Basic__101)
*   *   [Button 按钮](#Button__102)
    *   [Link 文字链接](#Link__107)
    *   [Layout 布局](#Layout__110)
    *   [Container 布局容器](#Container__120)
*   [Form 组件](#Form__127)
*   *   [Radio 单选框](#Radio__128)
    *   [Checkbox 多选框](#Checkbox__133)
    *   [Input 输入框](#Input__136)
    *   [Select 选择器](#Select__208)
    *   [Switch 开关](#Switch__253)
    *   [DatePicker 日期选择器](#DatePicker__299)
    *   [Upload 上传](#Upload__305)
    *   [Form 表单](#Form__322)
*   [Notice 组件](#Notice__328)
*   *   [Alert 警告](#Alert__329)
    *   [Message 消息提示](#Message__333)
*   [Data 组件](#Data__339)
*   *   [Table 表格](#Table__340)

Element UI 介绍
=============

官网：[https://element.eleme.io/#/zh-CN](https://element.eleme.io/#/zh-CN)

官方定义：**网站快速成型工具** 和 **桌面端组件库**；

简介：Element UI 是 **基于 Vue** 的一个 UI 框架，该框架基于 Vue 开发了很多相关组件，方便我们快速开发页面。（也就是说你必须先学习 [Vue](https://blog.csdn.net/weixin_43734095/article/details/106910854)）

由 **饿了么前端团队** 基于 Vue 进行开发并且进行了开源；Element UI 中提供的全部都是封装好组件。

安装 Element UI
=============

Element UI 的使用一切以官方文档为准，这里简单记录个人笔记。

*   首先通过 Vue 脚手架 创建项目：

```
vue create hello-element
```

*   在 Vue 脚手架项目中安装 Element UI：

```
npm i element-ui -S
```

*   指定项目中使用 Element UI，在 index.js 中添加以下代码：`

```
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI); // 在vue脚手架中使用elementui
```

Element UI 组件使用
===============

官方文档 是最好的参考教程！

难得有官方中文的参考文档，上面写的已经很详细了，例子也很多，基本的开发完全没有问题！

每个组件都有 属性、事件、方法。事件和方法的区别在于：事件是去调用自己写的函数，方法相当于它给你写好的函数，你去调用；

掌握 **属性、事件、方法** 的用法后，所有组件的使用基本都一样。

*   大部分组件都是以 `el-组件名` 开头，比如 `el-button` 是按钮；

```
<el-button>默认按钮</el-button>
```

*   Element UI 中所有组件的 **属性 (Attributes)** 全部写在组件标签上；

```
<el-button type="primary" 属性名=属性值>默认按钮</el-button>
```

*   **事件 (Events)** 也是直接写在对应的组件标签上，使用 Vue 中绑定事件方式 `@change="aa"`；

```
<el-radio v-model="label" @change="aa" >男</el-radio>
<el-radio v-model="label" @change="aa" >女</el-radio>

<script>
    export default {
        name: "Radio",
        data(){
            return{
                label:'男'
            }
        },
        methods:{
            aa(){ //定义的事件处理函数
                console.log(this.label);
            }
        }
    }
</script>
```

*   组件的 **方法 (Methods)**：  
    在对应的组件中加入 `ref="组件别名"`；  
    通过 `this.$refs.组件别名.方法名()` 调用方法；

```
<h1>方法的使用</h1>
<el-input v-model="username" ref="inputs"></el-input>

<el-button @click="focusInputs">focus方法</el-button>
<el-button @click="blurInputs">blur方法</el-button>

<script>
    export default {
        name: "Input",
        data() {
            return{}
        },
        methods:{
            // 调用focus方法
            focusInputs(){
                this.$refs.inputs.focus();
            },
           // 调用失去焦点方法
            blurInputs(){
                this.$refs.inputs.blur();
            }
        }
    }
</script>
```

Basic 组件
========

Button 按钮
---------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/button](https://element.eleme.cn/#/zh-CN/component/button)

*   大部分用法是设置 button 的样式，注意 **按钮组** 的用法；

Link 文字链接
---------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/link](https://element.eleme.cn/#/zh-CN/component/link)

Layout 布局
---------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/layout](https://element.eleme.cn/#/zh-CN/component/layout)

*   Element UI 中是 **24 分栏**，迅速简便地创建布局。
*   一个布局组件由 `el-row` 和 `el-col` 组合构成，使用属性时要区分 **行属性** 与 **列属性**；
*   `<el-row :gutter="20">` 指定每一栏之间的间隔，默认间隔为 0；
*   `<el-col :span="24">` 用来组合一栏的布局，一栏是分为 24 部分；
*   `<el-col :span="6" :offset="6">` 中利用 `offset` 指定分栏偏移的栏数；

Container 布局容器
--------------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/container#container-bu-ju-rong-qi](https://element.eleme.cn/#/zh-CN/component/container#container-bu-ju-rong-qi)

*   Container 是用于布局的容器组件，方便快速搭建页面的基本结构；
*   容器包含 `<el-container>`、`<el-header>`、`<el-aside>`、`<el-main>`、`<el-footer>`；

Form 组件
=======

Radio 单选框
---------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/radio](https://element.eleme.cn/#/zh-CN/component/radio)

*   在使用 Radio 时至少加入 `v-model` 和 `label` 两个属性；
*   注意 Radio 按钮组；

Checkbox 多选框
------------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/checkbox](https://element.eleme.cn/#/zh-CN/component/checkbox)

Input 输入框
---------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/input](https://element.eleme.cn/#/zh-CN/component/input)

*   Input 为受控组件，它总会显示 Vue 绑定值。
    
*   autocomplete 是一个带 **输入建议** 的输入框组件，也可以自定义输入建议显示模板；
    
*   事件的使用：
    

```
<el-input v-model="username" @blur="aaa" @focus="bbb" 
			@clear="clears" clearable @input="ccc">
</el-input>


<script>
    export default {
        name: "Input",
        data() {
            return {
                restaurants: [],
                state1: '',
                state2: '',
                name:'xiaochen',
                price:0.0,
                username:"",
                password:"",
            };
        },
        methods:{
            aaa(){
                console.log('失去焦点');
                ;
            },
            bbb(){
                console.log("获取焦点");
            },
            ccc(value){
                console.log("改变:"+value);
            },
            clears(){
                console.log("清楚");
            }

        }
    }
</script>
```

*   方法的使用：

```
<h1>方法的使用</h1>
<el-input v-model="username" ref="inputs"></el-input>
<el-button @click="focusInputs">focus方法</el-button>
<el-button @click="blurInputs">blur方法</el-button>


<script>
    export default {
        name: "Input",
        data() {
            return{}
        },
        methods:{
            // 调用focus方法
            focusInputs(){
                this.$refs.inputs.focus();
            },
           // 调用失去焦点方法
            blurInputs(){
                this.$refs.inputs.blur();
            }
        }
    }
</script>
```

Select 选择器
----------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/select](https://element.eleme.cn/#/zh-CN/component/select)

*   事件的使用：

```
<el-select v-model="cityId" @change="aaa" multiple clearable>
  <el-option v-for="option in options" :label="option.name" 
  			:value="option.id" :key="option.id">
  </el-option>
</el-select>


<script>
    export default {
        name: "Select",
        data(){
            return{
                options:[
                    {id:'1',name:"研发部"},
                    {id:'2',name:"小卖部"},
                    {id:'3',name:"小米部"},
                ],
                cityId:'',
                cityName:''
            }
        },
        methods:{
            aaa(value){
                console.log(value);
            }
        }
    }
</script>
```

*   方法的使用：

```
1.给组件通过ref起别名并绑定到vue实例中
<el-select ref="selects" v-model="cityId" @change="aaa" multiple clearable>
     ....
</el-select>

2.调用方法
this.$refs.selects.focus(); //方法调用
```

Switch 开关
---------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/switch](https://element.eleme.cn/#/zh-CN/component/switch)

*   事件的使用：

```
<el-switch v-model="value" @change="aaa"></el-switch>

<script>
    export default {
        name: "Switchs",
        data(){
            return{
                value:true
            }
        },
        methods:{
            aaa(value){
                console.log(value);
            }
        }
    }
</script>
```

*   方法的使用：

```
<el-switch v-model="value" ref="sw"></el-switch>
<el-button @click="bbb">调用方法</el-button>

<script>
    export default {
        name: "Switchs",
        data() {
            return {
                value: true
            }
        },
        methods: {
            bbb() {
                alert();
                this.$refs.sw.focus(); //方法调用
            }
        }
    }
</script>
```

DatePicker 日期选择器
----------------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/date-picker](https://element.eleme.cn/#/zh-CN/component/date-picker)

*   **Picker Options**：用来对日期控件做自定义配置；
*   **Shortcuts**：用来增加日期组件的快捷面板；
*   **Picker Options** 用来对日期的选择进行控制；

Upload 上传
---------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/upload](https://element.eleme.cn/#/zh-CN/component/upload)

*   使用 Upload 组件 必须设置 `action` 属性，`action` 属性为必要参数不能省略；
    
*   **Upload 组件 没有 Event 事件，所有事件都是 Attribute 属性**；
    
*   方法的使用：
    

```
<el-upload ref="uploads" ....>........</el-upload>

// 方法调用:
this.$refs.uploads.clearFiles();
this.$refs.uploads.abort();
this.$refs.uploads.submit();
```

Form 表单
-------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/form](https://element.eleme.cn/#/zh-CN/component/form)

*   Form 组件提供了表单验证的功能，只需要通过 `rules` 属性传入约定的验证规则，并将 Form-Item 的 `prop` 属性设置为需校验的字段名即可；
*   **表单验证** 和 **自定义表单验证**，详情参照官方文档；

Notice 组件
=========

Alert 警告
--------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/alert](https://element.eleme.cn/#/zh-CN/component/alert)

*   这个主要就是对描述和样式的控制，比较简单，拿来用即可；

Message 消息提示
------------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/message](https://element.eleme.cn/#/zh-CN/component/message)

*   这个组件的创建无须在页面中书写任何标签，他是一个 JavaScript 插件，在需要展示消息提示的位置直接调用提供的 Js 插件方法即可；

Data 组件
=======

Table 表格
--------

官方文档索引：[https://element.eleme.cn/#/zh-CN/component/table](https://element.eleme.cn/#/zh-CN/component/table)

*   详见官方文档，写的很详细！