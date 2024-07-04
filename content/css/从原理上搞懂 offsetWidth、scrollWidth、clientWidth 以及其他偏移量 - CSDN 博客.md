> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/wgh295360998/article/details/113769584)

##### 1. 影响以上参数主要有哪些内容

笔者在总结这几个内容之前，也翻了很多书，看了很多帖子，始终没有搞清楚这几个内容的逻辑，每次记住了，没过几天就忘了，下次再被问到完全又分不清楚了。

于是又拿起了《Javascript 权威指南》这本书，认认真真读了两遍，终于发现了一些规律，下面就给大家总结一下。

其实每个人都很清楚，影响以上几个因素的参数，无非就那么几个：我们拿一个 div 来举例。主要包括了：`padding`, `border`, `margin`, `width(height)`，滚动条的距离 `scroll`, 以及`滚动到了视口之外的内容`。

很多时候，我们在记忆这些内容的时候，经常搞混淆，尤其是再在怪异模式和正常模式切换下，就更容易弄错了。

没关系，我们记住几个要点，就很好记忆了。

##### 2. 表格总结以上几个宽度的含义

所以下面先祭上这一张表

<table><thead><tr><th></th><th>margin</th><th>border</th><th>padding</th><th>Width(height)</th><th>scroll (滚动条)</th><th>视口之外的内容</th></tr></thead><tbody><tr><td>offsetWidth</td><td>不包括</td><td>包括</td><td>包括</td><td>包括</td><td>包括</td><td>包括</td></tr><tr><td>clientWidth</td><td>不包括</td><td>不包括</td><td>包括</td><td>包括</td><td>不包括</td><td>不包括</td></tr><tr><td>scrollWidth</td><td>不包括</td><td>不包括</td><td>包括</td><td>包括</td><td>不包括</td><td>包括</td></tr></tbody></table>

根据以上表格，我们可以得出以下几个结论。

`offsetWidth`：除了外边距 (`margin`) 以外，所有的宽度 (高度) 之和（英文翻译是 “抵消、平版印刷”）；

`clientWidth`：**视口尺寸**。只包含本身宽度 **(`width`) 和内边距 (`padding`)；

`scrollWidth`：只包含本身宽度 (`width`) 和内边距 (`padding`)， 如果有滚动的溢出`视口之外的内容`，就加上该距离；

所以我们拿一个 div 为例，分别探讨下，在正常模式下和怪异模式下，该参数的内容：

```
<style>
    .box{
        width:400px; height: 400px; float:left;background-color: antiquewhite;
      	margin: 10px;
        padding: 10px; 
      	border: 5px solid red; 
      	overflow:scroll;
        box-sizing: content-box;
    }
    .overflowBox{
        width: 1000px;
        overflow: scroll;
        box-sizing: content-box;
    }   
    
</style>
<body>
    <div id="box" class="box">
        <div id="overflowBox" class="overflowBox">

        </div>
    </div>
</body>
<script>
    var ele = document.getElementById('box');
          console.log("offsetWidth: ",ele.offsetWidth)
          console.log("clientWidth: ",ele.clientWidth)
          console.log("scrollWidth: ",ele.scrollWidth)
</script>
```

###### 正常模式

我们先来看看【正常模式】，**正常模式下，width 是不包括 padding、border 的，但是包括了滚动条的宽度**。

所以，按照之前的总结：

offsetWidth: 应该是 width (包含了滚动条 [scroll](https://so.csdn.net/so/search?q=scroll&spm=1001.2101.3001.7020) 的 15px) + padding (10*2px) + border (5*2px) = **430px**

clinetWidth: 应该是 width (包含了滚动条 scroll 的 15px) - 滚动条 scroll (15px) + padding (10*2px) = **405px**

scrollWidth: 应该是 width (内部元素溢出的宽度) + padding (10) = **1010px** (由于向右溢出，只有左边的 padding 生效了)

我们来看一下结果：  
![](https://img-blog.csdnimg.cn/20210209134843742.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dnaDI5NTM2MDk5OA==,size_16,color_FFFFFF,t_70)

###### 怪异模式

现在，我们把以上代码中的 box-sizing: content-box; 改成 box-sizing: border-box;

我们先来推测一下结果：

offsetWidth: 应该是 width (包含了滚动条 scroll + padding + border) = **400px**

clinetWidth: 应该是 width - 滚动条 scroll (15px) -border (5*2px)= **375px**

scrollWidth: 应该是 width (内部元素溢出的宽度) + padding (10) = **1010px** (由于向右溢出，只有左边的 padding 生效了)

![](https://img-blog.csdnimg.cn/20210209134843729.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dnaDI5NTM2MDk5OA==,size_16,color_FFFFFF,t_70)

Okay！

##### 3. offsetLeft、clientLeft 以及 scrollLeft 等几个位置的含义

这几个定义相对来说比较独立，我们需要记住它：

`offsetLeft/Top`：元素相对于父窗口的偏移距离，父窗口的 position 没有绝对定位的情况；

`clientLeft/Top`：元素的内外边距距离，**通常就是边框的边距**；

`scrollLfet/Top`：滚动条滚动的距离。

![](https://img-blog.csdnimg.cn/20210209134843869.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dnaDI5NTM2MDk5OA==,size_16,color_FFFFFF,t_70)

如图所示，当我把滚动条拖动到中间位置时，明显 `document.getElementById("box").scrollLeft` 的值发生了变化。

综上所述，几个关键的宽、高、边距就记清楚啦～