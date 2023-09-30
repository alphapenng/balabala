> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650931928&idx=1&sn=88fba31f6607ec09800a11a7e18b8e17&chksm=84aa2962b3dda0745a829350032de2d1f1e9001d9c3cef95aa58ce3fb3388cdc17009b46fd97&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

1、拖一个按钮到窗口上

2、鼠标双击按钮，切换到代码视图，在 winform.button.oncommand 事件中添加下面的代码：  

```
winform.button.disabledText = {
  "✶";"✸";"✹";"✺";"✹";"✷";text="稍候"
}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPXxAzU7cPpI3Db5cKEP4IruquMHDSIFZOCsYE8d2D9laI4OQ7yHftOg8aLzka2pWC7ouicTdCQqeg/640?wx_fmt=gif)  

然后按 F5 运行程序，点击按钮就可以看到动画了。  
winform.button.disabledText 可以指定一个字符串，其作用是让按钮变成禁用状态，并临时显示禁用提示，例如：

```
winform.button.disabledText = "已禁用"
```

这个属性也如果指定一个字符串数组，就会以动画方式循环显示数组中的字符串，也就是上面的：

```
winform.button.disabledText = {
  "✶";"✸";"✹";"✺";"✹";"✷";text="稍候"
} 
```

用下面的代码可以停止动画并取消禁用状态：  

```
winform.button.disabledText = null;
```

下面我们用多线程演示一下在线程函数中如何结束动画：

```
import win.ui;
/*DSG{{*/
var winform = win.form(text="aardio form")
winform.add(
button={cls="button";text="启 动";left=102;top=117;right=293;bottom=162;z=1}
)
/*}}*/

winform.button.oncommand = function(id,event){
  winform.button.disabledText = {"✶";"✸";"✹";"✺";"✹";"✷";text="稍候"} 
  
  //创建多线程
  thread.invoke( 
    function(winform){
      
      //等待 3 秒
      sleep(3000)
      
      //取消动画
      winform.button.disabledText = null;
      
    },winform/*将窗口对象作为参数传给线程函数*/
  )
}

winform.show();
win.loopMessage();
```

也可以用图标字体来显示动画，首先在按钮的字体属性中指定 FontAwesome 字体，然后在源码开始用以下的代码引入 FontAwesome 字体：

```
import fonts.fontAwesome
```

就可以在代码中使用 FontAwesome 字体动画了，代码如下：  

```
winform.button.disabledText = {'\uF254';'\uF251';'\uF252';'\uF253';'\uF250'};
```

  
更多请参考下面的范例：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPXxAzU7cPpI3Db5cKEP4IrO8S859kxSLOSDe2HHydEVicqeVg1YmGUcyMvA3v8CcE5NrwyYUeeyuQ/640?wx_fmt=png)

  
运行效果：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPXxAzU7cPpI3Db5cKEP4Irhcb5QNfhG4vzCRu66wQBfvUA5X4yqSuBic2owwky9WCOBuuNQpUQOkg/640?wx_fmt=gif)