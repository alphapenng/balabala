> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [segmentfault.com](https://segmentfault.com/a/1190000015942599)

> 有时候我们经常会碰到这些场景：玩掘金、知乎的时候复制一段文字，总是会在内容后面加上一些版权信息，以及像小说网站等都有禁止选中，禁止复制这种功能，还...

![](https://segmentfault.com/img/remote/1460000015942602?w=1280&h=720)

前言
--

有时候我们经常会碰到这些场景：玩掘金、知乎的时候复制一段文字，总是会在内容后面加上一些版权信息，以及像小说网站等都有禁止选中，禁止复制这种功能，还有点击自动复制账号的功能。

我也经常遇到这些场景，有时候会去想这后面到底是怎么做，周末趁着有空去研究了一下，然后发现这些都跟操作剪贴板有关系，并且都不难，了解一下基本都知道怎么做了，整理分享一波给大家。

> 个人博客了解一下：[obkoro1.com](https://link.segmentfault.com/?enc=0P61kBIGYC36Mn8smErsDQ%3D%3D.ofuaUjKgDRO9ZRFIzeuYJ8%2F9j19KySF31s3f8rBQAlE%3D)

目录：
---

*   API 介绍
*   实现类知乎 / 掘金复制大段文本添加版权信息
*   实现类起点网的防复制功能
*   破解防复制
*   点击复制功能

### API 介绍:

#### 复制、剪切、粘贴事件：

1.  `copy` 发生复制操作时触发；
2.  `cut` 发生剪切操作时触发；
3.  `paste` 发生粘贴操作时触发；
4.  每个事件都有一个 before 事件对应：`beforecopy`、`beforecut`、`beforepaste`;

这几个 before 一般不怎么用，所以我们把注意力放在另外三个事件就可以了。

**触发条件:**

1.  鼠标右键菜单的`复制`、`粘贴`、`剪切` ;
2.  使用了相应的键盘组合键，比如:`command+c`、`command+v`;
    
    **就算你是随便按的，也会触发事件**。高程中介绍在 `Chorme`、`Firefox` 和 `Safari` 中，这几个 before 事件只会在真实会发生剪贴板事件的情况下触发，IE 上则可以触发 before。我实际测试的时候最新版 `chorme` 也会乱按也会触发，所以限制应该是在早一点的版本上。
    
    so 想说的是：before 这几个事件最好不要用，有关于剪切板的处理最好放在 `copy`、`cut`、`paste` 上面。
    

**使用姿势：**

以 copy 为例:

```
document.body.oncopy = e => {
        // 监听全局复制 做点什么
    }
    // 还有这种写法：
    document.addEventListener("copy", e => {
        // 监听全局复制 做点什么
    });
```

上面是在 `document.body` 上全局监听的，然而很多人不知道的是，我们还可以为某些 dom 单独添加剪切板事件：

```
// html结构
    <div id="test1"></div>
    <div id="test2"></div>
    // 写法一样：
    let test1 = document.querySelector('#test1');
    test1.oncopy = e => {
        // 监听test1发生的复制事件 做点什么
        // test1发生的复制事件会触发回调，其他地方不会触发回调
    }
```

其他事件也是一样的，这里就不赘述了。

#### clipboardData 对象：用于访问以及修改剪贴板中的数据

**兼容：**

**不同浏览器，所属的对象不同**：在 IE 中这个对象是 `window` 对象的属性，在 `Chrome`、`Safari` 和 `Firefox` 中，这个对象是相应的 `event` 对象的属性。所以我们在使用的时候，需要做一下如下兼容:

```
document.body.oncopy = e => {
        let clipboardData = (e.clipboardData || window.clipboardData); 
        // 获取clipboardData对象 + do something
    }
```

**对象方法：**

对象有三个方法: `getData()`、`setData()`、`clearData()`

*   `getData()` 访问剪切板中的数据
    
    参数： `getData()` 接受一个`'text'` 参数，即要取得的数据的格式。
    
    **在复制、剪切、粘贴触发的事件的数据：**
    
    实际上在 chorme 上测试只有 `paste` 粘贴的时候才能用 `getData()` 访问到数据，用法如下：
    
    **要粘贴的数据：**
    
    ```
    document.body.onpaste = e => {
         let clipboardData = (e.clipboardData || window.clipboardData); // 兼容处理
         console.log('要粘贴的数据', clipboardData.getData('text'));
     }
    ```
    
    **被复制 / 剪切的数据：**
    
    在复制和剪切中的数据，需要通过 `window.getSelection(0).toString()` 来访问:
    
    ```
    document.body.oncopy = e => {
         console.log('被复制的数据:', window.getSelection(0).toString());
     }
    ```
    
*   `setData():` 修改剪切板中的数据
    
    参数：第一个参数也是`'text'`，第二个参数是要放在剪切板中的文本。
    
    剩下的留在下面仿知乎 / 掘金复制大段文本添加版权信息那里再说。
    
*   `clearData()` :
    
    这个方法就不太知道了，试了好久不知道怎么用 (如果有大佬知道，可以在评论区指点一下)。
    
    如果只是为了禁止复制，或者禁止粘贴，在下面还有另外的方法可以做到，并且可以细粒化操作。
    

应用:
---

如果学习不是为了装 X，那么一切将毫无意义，来看这个东西可以在哪些场景使用：

### 实现类知乎 / 掘金复制大段文本添加版权信息:

实现很简单：取消默认复制之后，主要是在被复制的内容后面添加信息，然后根据 clipboardData 的 setData () 方法将信息写入剪贴板。

可以直接复制这段代码到本地去试试。

```
// 掘金这里不是全局监听，应该只是监听文章的dom范围内。
    document.body.oncopy = event => {
        event.preventDefault(); // 取消默认的复制事件 
        let textFont, copyFont = window.getSelection(0).toString(); // 被复制的文字 等下插入
        // 防知乎掘金 复制一两个字则不添加版权信息 超过一定长度的文字 就添加版权信息
        if (copyFont.length > 10) {
            textFont = copyFont + '\n'
                + '作者：OBKoro1\n'
                + '链接：https://juejin.im/user/58714f0eb123db4a2eb95372/posts\n'
                + '来源：掘金\n'
                + '著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。';
        } else {
            textFont = copyFont; // 没超过十个字 则采用被复制的内容。
        }
        if (event.clipboardData) {
            return event.clipboardData.setData('text', textFont); // 将信息写入粘贴板
        } else {
            // 兼容IE
            return window.clipboardData.setData("text", textFont);
        }
    }
```

然后 command+c、command+v，输出:

```
你复制的内容
作者：OBKoro1
链接：https://juejin.im/user/58714f0eb123db4a2eb95372/posts
来源：掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```

### 实现类起点网的防复制功能:

*   禁止复制 + 剪切
*   禁止右键，右键某些选项：全选，复制，粘贴等。
*   禁用文字选择，能选择却不能复制，体验很差。
*   user-select 用 css 禁止选择文本。

可以把代码拷到本地玩一玩：

```
// 禁止右键菜单
    document.body.oncontextmenu = e => {
        console.log(e, '右键');
        return false;
        // e.preventDefault();
    };
    // 禁止文字选择。
    document.body.onselectstart = e => {
        console.log(e, '文字选择');
        return false;
        // e.preventDefault();
    };
    // 禁止复制
    document.body.oncopy = e => {
        console.log(e, 'copy');
        return false; 
        // e.preventDefault();
    }
    // 禁止剪切
    document.body.oncut = e => {
        console.log(e, 'cut');
        return false;
        // e.preventDefault();
    };
    // 禁止粘贴
    document.body.onpaste = e => {
        console.log(e, 'paste');
        return false;
        // e.preventDefault();
    };
    // css 禁止文本选择 这样不会触发js
    body {
        user-select: none;
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }
```

PS：

*   使用 `e.preventDefault()` 也可以禁用，但建议使用 `return false` 这样就不用去访问 `e` 和 `e` 的方法了。
*   示例中 `document.body` 全局都禁用了，也可以对 dom (某些区域) 进行禁用。

**破解防复制**：

上面的防复制方法通过 `js`+`css` 实现的，所以**思路就是**：禁用 `js`+ 取消 `user-select` 样式。

`Chrome` 浏览器的话：打开浏览器控制台，按 `F1` 进入 `Setting`，勾选 `Disable JavaScript`(禁止 js)。

![](https://segmentfault.com/img/remote/1460000015942603)

此时如果还不能复制的话，就要去找 `user-select` 样式，取消这个样式就可以了。

![](https://segmentfault.com/img/remote/1460000015942604)

所以那些盗版小说手打的，我真的不太能理解，Excuse me？？？

### 点击复制功能：

**不能使用 clipboardData：**

在 IE 中可以用 `window.clipboardData.setData('text','内容')` 实现。

上文提到过，在 IE 中 `clipboardData` 是 `window` 的属性。

而其他浏览器则是相应的 `event` 对象的属性，这实际上是一种安全措施，防止未经授权的访问，为了兼容其他浏览器，所以我们不能通过 `clipboardData` 来实现这种操作。

**具体做法：**

*   创建一个隐藏的 `input` 框
*   点击的时候，将要复制的内容放进 `input` 框中
*   选择文本内容 `input.select()`
    
    这里只能用 `input` 或者 `textarea` 才能选择文本。
    
*   document.execCommand ("copy")，执行浏览器的复制命令。
    
    ```
    function copyText() {
      var text = document.getElementById("text").innerText; // 获取要复制的内容也可以传进来
      var input = document.getElementById("input"); // 获取隐藏input的dom
      input.value = text; // 修改文本框的内容
      input.select(); // 选中文本
      document.execCommand("copy"); // 执行浏览器复制命令
      alert("复制成功");
    }
    ```
    

[点击复制内容](https://codepen.io/OBKoro1/pen/mjjEGa)的 demo 在这里，可以点进去看看。点击预览

结语
--

工作之余了解一下这些东西还是很有趣的，也可以扩宽你的知识面。

事实上只要监听了这些事件，我们就可以对要剪切的内容进行各种各样的操作，比如：复制的时候更换文本，粘贴的时候查找有没有图片 (上传图片)，或者文本的长度进行剪切等等，唯一限制你的

### 希望看完的朋友可以点个喜欢 / 关注，您的支持是对我最大的鼓励。

**[个人 blog](https://link.segmentfault.com/?enc=drxIbcWQAGOS8AvubbToLw%3D%3D.j43WuPipfdXJskNY3%2FsNdVu574kBKA%2BHK7xkM%2F960kU%3D)** and **[掘金个人主页](https://link.segmentfault.com/?enc=YwDsvAWI45N8c7fHES2qYw%3D%3D.Vn%2BkWqbJ%2BXe4l9vDNeD%2FUXZzRrD5pCSMrAeFapj4U05y%2F1r9NZSffRBTUouAkInI)**，如需转载，请放上原文链接并署名。码字不易，**感谢**支持！

如果喜欢本文的话，欢迎关注我的订阅号，漫漫技术路，期待未来共同学习成长。

![](https://segmentfault.com/img/remote/1460000014694068?w=344&h=344)

以上 2018.8.8

参考资料：

js 高程 14.2.2 操作剪贴板

[网页上如何实现禁止复制粘贴以及如何破解](https://link.segmentfault.com/?enc=SP%2BecikaOurJjd0RYhgoBw%3D%3D.kNX2pRKflpCcDItUGJefAJ%2F9y3c%2BGSn6%2B71rmpHkNznKH8%2B80sAqDLD50N1nrseh3y9n6AfsLTdlvMsWSIQ1AA%3D%3D)

[原生 js 实现点击按钮复制文本](https://link.segmentfault.com/?enc=5vZoJvuynco91r7Oo9vRTA%3D%3D.vqtyxrQUZ8T9wRoRKWlcEjznNuIUzl3%2BdUlEnhFvq6WngrvOk1CrNAuI5habiBgsSOGC9Q2mFe41sZrQjbok2w%3D%3D)