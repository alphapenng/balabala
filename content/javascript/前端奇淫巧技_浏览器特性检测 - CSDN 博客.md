> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/kaiyuanheshang/article/details/130982465)

#### 文章目录

*   [调试技巧](#_2)
*   *   [页面自动无限循环刷新](#_4)
    *   [监听某个属性值的变化](#_16)
    *   [沙盒](#_37)
*   [监测浏览器 JS 兼容性](#_JS__56)
*   [鼠标滚轴](#_71)
*   [屏蔽右键 or 禁止复制](#_or__95)
*   *   [基于 Event](#_Event_97)
    *   [基于 CSS](#_CSS_110)

调试技巧
----

### 页面自动无限循环刷新

如果你的页面因未知代码陷入了快速刷新的死循环，可在项目中添加以下以下代码；  
[页面刷新](https://so.csdn.net/so/search?q=%E9%A1%B5%E9%9D%A2%E5%88%B7%E6%96%B0&spm=1001.2101.3001.7020)前会进入 debug 状态，在 devtools 中查看调用堆栈（call stack）即可了解刷新的原因

```
// http 302 属于非代码导致页面跳转，这段代码无法拦截
window.addEventListener('beforeunload', () => {
  debugger;
});
```

### 监听某个属性值的变化

```
// 假设这是要监听的对象，要监听 prop 属性的修改
// debug 状态下任意可访问对象
const obj = { prop: 1 };

// 在 devtools -> console 中执行以下代码
_obj_prop = obj.prop;
Object.defineProperty(obj, 'prop', {
  set: (v) => {
    _obj_prop = v;
    // 每次赋值都会进入 debug 状态
    debugger;
  },
  get: () => _obj_prop,
});
// 试试执行 obj.prop = 2
// 后续可在 console 中随时访问 _obj_prop 的当前值
```

### 沙盒

```
function safeExec(code) {
  const proxyWindow = new Proxy(window, {
    get(target, key, receiver) {
      if (['open', 'location', 'document'].includes(key))
        throw new Error(`禁止访问 key: ${key}`);
      if (key === 'window') return proxyWindow;

      return Reflect.get(target, key, receiver);
    },
    // set() {}
  });
  new Function('window', `with(window) { ${code} }`)(proxyWindow, null);
}
// Error 禁止访问 key: open
safeExec(`window.open('//danger.com')`);
```

监测浏览器 JS 兼容性
------------

```
if (
  function() { try { eval([ 
    'for (const a of []) {}', 
    'let b = { fetch, Proxy }' 
  ].join(';')) } catch (e) { console.log('!!', e); return true } }()
) location.href = "/browser-update"
```

上面的代码可以用来检查浏览器是否兼容自己使用的 API，当不兼容时跳转到升级页面，引导用户下载新版浏览器或者其他操作。

使用 `eval` 可以防止当前线程的崩溃，体验更好。

鼠标滚轴
----

在 Windows 平台的浏览器上，鼠标中键点击，会触发自带的拖动功能。当点击鼠标中键后会进入拖动状态，此时移动鼠标浏览器内容会跟随鼠标滚动。

但这个功能仅限于 Windows 平台，为了保持操作的一致性和便捷性，我们需要写自己的拖动逻辑，此时可以使用以下代码屏蔽掉其自带的功能

```
$(targetScrollElement).on("mousedown", function (event) {
   if (event.button === 1) {
     event.stopPropagation();
     event.preventDefault();
     return false;
   }
 });

 $(targetScrollElement).on("mouseup", function (event) {
   if (event.button === 1) {
     event.stopPropagation();
     event.preventDefault();
     return false;
   }
 });
```

屏蔽右键 or 禁止复制
------------

### 基于 Event

有些内容是作者受保护的内容，会通过一定手段让用户只能看，不能复制。这些手段包括但不限于：禁止右键、禁用 Copy 功能、用[图片展示](https://so.csdn.net/so/search?q=%E5%9B%BE%E7%89%87%E5%B1%95%E7%A4%BA&spm=1001.2101.3001.7020)、用 Canvas/SVG 绘制内容等。

有时我们出于研究和学习的目的（手懒不想重复敲代码）复制网站内容。对于上面提到的前两种方法，可以通过控制台获取到复制权限。对于其他方法实现的禁止复制，可以使用截图，然后 OCR 获取。

以 Chrome 为例。打开浏览器控制台，在 `Element / 元素` 选项卡下找到 `Event Listeners` 选项卡。此时你就可以看到当前页面监听了哪些事件。

![](https://img-blog.csdnimg.cn/5bf8d66523514d61abd826af673ca2ae.png)  
然后，点击那个 `Remove` 按钮，就可以让这段监听代码失效，然后就可以启用右键了。其他功能也是一样。有些网站会在复制的内容后面追加一些内容，如果你不想要，就找到 `Copy` 事件，执行相同的操作就可以了。

### 基于 CSS

除了上面的方式，还可以通过 CSS 禁止用户选择文本，相关属性如下：

```
.no-selection {
  -moz-user-select: none;
  /* -webkit-user-select: none; */
  -ms-user-select: none;
  /* user-select: none; */
  user-select: none;
}
```