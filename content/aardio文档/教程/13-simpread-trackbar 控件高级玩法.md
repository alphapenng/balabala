> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650931907&idx=1&sn=2543aee4c3e32393c8361f0dd43d8667&chksm=84aa2979b3dda06fcb8c590caba5b11eeb3eebcec5608fdb7944dc792566ea417a5ab3b64996&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

创建 trackbar 控件（跟踪条、滑尺控件） 非常简单，从控件工具条拖到界面上就可以了：  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBO49Ywt29SeInrGCg5yY0l0RHkoAWMRqw7wcybrtictc2zM9QLmjpDJ8c419Woabq9C3qtVsvtGfZw/640?wx_fmt=gif)

  
再切换到代码视图：  
  

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBO49Ywt29SeInrGCg5yY0l09bk7rujYNOgXHh9tnwfia51Nd8lEbQaNRquktvIdt9xUX5ibQRvjg8iaQ/640?wx_fmt=gif)

  
添加代码 

```
winform.trackbar.setRange(1,100)
```

指定滑块最小值、最大值就可以了。我们可以用 winform.trackbar.pos 随时获取到当前刻度，也可以添加事件回调函数 —— 这些大家可以看「范例 / Windows 窗口 / 窗口控件 / 滑尺控件 」，代码很简单不多讲。  
我们可能发现 trackbar 的刻度是整数，如果我们希望使用小数刻度，可以换算后再显示或使用，例如 「范例 / Windows 窗口 / 窗口控件 / 滑尺控件 」里就是这样写的：  
  

```
winform.trackbar.setRange(1,100)

winform.trackbar.oncommand = function(id,event,pos){  
  var pos = winform.trackbar.pos;
  winform.editTrackbar.text = pos / 10; 
  winform.trackbar.tooltip = pos / 10; 
}
```

有时候我们可能希望 trackbar  有透明的背景，这很简单，在窗体设计器中点选 trackbar 控件，然后把「浮动透明」属性设为 true 就可以了：|  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBO49Ywt29SeInrGCg5yY0l0BTLyuRwnW2P1lWSvw7uXV9iaia9dMcldrZ4154DcY6rFDK1KdAuzYzAg/640?wx_fmt=png)  
这种系统提供的 trackbar 控件有一个奇葩的功能，点击以后周围会显示一个虚线框，而且没办法简单地取消或关掉，下面提供一个方法干掉这个虚线框：  

```
winform.trackbar.onnotify = function(id,code,ptr){ 
  if( code == 0xFFFFFFF4/*_NM_CUSTOMDRAW*/ ){
    var lvcd = winform.trackbar.getNotifyCustomDraw(code,ptr);
    if( lvcd.dwDrawStage == 1/*_CDDS_PREPAINT*/ ){
      lvcd.uItemState = lvcd.uItemState &  ~0x10/*_CDIS_FOCUS*/;
      lvcd.update();
    }
  }
}
```

如果我们想让 trackbar 变得更漂亮一些，用系统 trackbar 就比较为难了。我们可以用 aardio 中最强大的控件 —— plus 控件来绘制 trackbar 控件。方法很简单，先拖一个 plus 控件到界面上，然后打开「工具 / 滑尺配色工具」  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBO49Ywt29SeInrGCg5yY0l0uOTFjaiaicdt4gNGCiaZ7j2xCVphuWLtf1iczgKiblQwFGkBNoDbE3J9KPg/640?wx_fmt=png)  
配置好外观与样式，然后「导出到窗体设计器选中控件」就行了：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBO49Ywt29SeInrGCg5yY0l0kR7sXlpwB6CzMHlqdUs2GeLXoicaPU6PSjlxu7cSAT0o5mGiaibp2V8KQ/640?wx_fmt=png)

下面看自动生成的范例，运行效果：

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBO49Ywt29SeInrGCg5yY0l007wKKOv0NHWWWWdCvF1puNvdXKlVVibpjKrQRH2cmeSkicHjZKHu3LoA/640?wx_fmt=gif)  
范例代码很简单：  

```
import win.ui;
/*DSG{{*/
var winform = win.form(text="滑尺控件")
winform.add(
trackbar={cls="plus";left=225;top=266;right=667;bottom=281;bgcolor=14265123;border={radius=-1};foreRight=15;forecolor=1865727;paddingBottom=5;paddingTop=5;z=1}
)
/*}}*/

//设置滑尺范围,切换到滑迟模式
winform.trackbar.setTrackbarRange(1,100);

//设置外观
winform.trackbar.skin({
  background={
    default=0xFF23ABD9;
  };
  foreground={
    default=0xFFFF771C;
    hover=0xFFFF6600;
  };
  color={
    default=0xFFFF5C00;
    hover=0xFFFF6600;
  }
})

winform.show() 
win.loopMessage();
```

如果希望在拖动滑块时显示提示，可添加以下代码：  

```
//鼠标放开关闭提示
winform.trackbar.onMouseUp = function(wParam,lParam){
  toolinfo.trackPopup(false);
}

//鼠标按下拖动时显示提示
winform.trackbar.onPosChanged = function( pos,thumbTrack ){
  if(thumbTrack){  
    var x,_ = win.getMessagePos();
    var _,y,cx,cy = winform.trackbar.getPos(true)
    
    /*
    注意刻度最小单位总是1,
    如果要改为其他单位,只要修改显示数值就可以,
    例如下面显示的 pos 修除以 10,对于用户来说就实现了最小单位 0.1 相同的效果。
    */
    toolinfo.setText(pos / 10).trackPopup(true,x,y+cy); 
  }
}
```

  
以上所有范例都已经添加到新版 aardio 中。