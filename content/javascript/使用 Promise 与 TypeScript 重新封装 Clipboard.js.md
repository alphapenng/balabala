> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [juejin.cn](https://juejin.cn/post/7203886883293626428)

声明：本文首发于我的[简书](https://link.juejin.cn?target=https%3A%2F%2Fwww.jianshu.com%2Fp%2Fb392f406fac7 "https://www.jianshu.com/p/b392f406fac7")主页。

[Clipboard.js 官方示例代码](https://link.juejin.cn?target=https%3A%2F%2Fclipboardjs.com%2F "https://clipboardjs.com/"):

```
var clipboard = new ClipboardJS('.btn');

clipboard.on('success', function(e) {
    console.info('Action:', e.action);
    console.info('Text:', e.text);
    console.info('Trigger:', e.trigger);

    e.clearSelection();
});

clipboard.on('error', function(e) {
    console.error('Action:', e.action);
    console.error('Trigger:', e.trigger);
});
```

但在实践中，官方代码存在如下问题:

1.  伪异步。官方代码使用`.on(event, callback)`，且只有 `success / error` 两种状态，如果说在 2015 年 ES6 发布这前这种写法尚算优雅，那么站在今天只能说一句：这种调用方式远不如 Promise 来的更直观、更优雅；
2.  不销毁实例会导致`.on` 方法中的 `callback`**多次重复执行**，而每次销毁实例会显得非常麻烦。

那么，有没有一种方式，将 `clipboard.js` 封装成不用创建实例的函数式调用呢？从[源码](https://link.juejin.cn?target=https%3A%2F%2Fgitee.com%2Fmirrors_addons%2Fclipboard.js%2Fblob%2Fmaster%2Fsrc%2Fclipboard.js "https://gitee.com/mirrors_addons/clipboard.js/blob/master/src/clipboard.js")可以看出:

```
/**
   * 执行复制动作
   * @param {String|HTMLElement} target 被复制的字符串或DOM元素
   * @param {Object} options 选项，但一般不需要传
   * @returns 被复制后的内容
   */
  static copy(target, options = { container: document.body }) {
    return ClipboardActionCopy(target, options);
  }

  /**
   * 执行剪切动作
   * @param {String|HTMLElement} target 被剪切的字符串或DOM元素
   * @returns 被剪切的内容
   */
  static cut(target) {
    return ClipboardActionCut(target);
  }
```

这意味着 `copy` 与 `cut` 可以被单独导出使用，而不是必须创建实例才能使用，这就意味着**可以使用 `Promise` 对这两个方法重新封装**。

第二个问题是，何时 `resolve`，何时 `reject`？还是看源码:

```
/**
   * Defines a new `ClipboardAction` on each click event.
   * @param {Event} e
   */
  onClick(e) {
    const trigger = e.delegateTarget || e.currentTarget;
    const action = this.action(trigger) || 'copy';
    const text = ClipboardActionDefault({
      action,
      container: this.container,
      target: this.target(trigger),
      text: this.text(trigger),
    });

    // Fires an event based on the copy operation result.
    // 重点: 当text不为空时为 success 状态，否则为error状态
    this.emit(text ? 'success' : 'error', {
      action,
      text,
      trigger,
      clearSelection() {
        if (trigger) {
          trigger.focus();
        }
        window.getSelection().removeAllRanges();
      },
    });
  }
```

不难看出，执行复制动作后若内容不为空，则 `resolve`，否则 `reject`。

在翻源码时还发现这样一段:

```
/**
   * 是否支持clipboard.js
   * @param {String} [action]
   */
  static isSupported(action = ['copy', 'cut']) {
    const actions = typeof action === 'string' ? [action] : action;
    let support = !!document.queryCommandSupported;

    actions.forEach((action) => {
      support = support && !!document.queryCommandSupported(action);
    });

    return support;
  }
```

也就是说，执行复制 / 剪切动作前需先行检查是否支持 `clipboard.js`。

经过如上梳理后，代码也就呼之欲出。

```
import { copy, cut, isSupported } from 'clipboard';

// 得到最终选择的DOM或要复制的文本
const getSelected = (init: string | Element, isDomSelector = true):  string | Element => {
    if (!init) throw new Error('Do not pass an empty value!');
    
    let selected: string | Element;

    /*
     * 只有在init类型为string且是个DOM选择器时执行选择DOM操作
     * 否则直接将init值赋给selected
     */ 
    if (typeof init === 'string' && isDomSelector) {
        const selectedDom = document.querySelector(init);
        if (selectedDom) selected = selectedDom;
        else throw new Error('Expected be an existed DOM');
    } else selected = init;

    return selected;
};

/**
 * 复制动作
 * @param init {string | Element} 可以是字符串或DOM选择器，也可以是DOM元素
 * @param isDomSelector {boolean} 是否为DOM选择器字符串。默认为true，如果只想复制单一文本，可传入false
 * @returns 复制后的内容
 */
export function useCopy (init: string | Element, isDomSelector = true): Promise<string> {
    // 支持检查
    if (!isSupported()) throw new Error('Sorry, your browser does not support Clipboard.js!');

    // 调用上面的函数
    const selected = getSelected(init, isDomSelector);
   
   // Promise封装异步操作
    return new Promise<string>(
        (resolve, reject) => {
            const copied = copy(selected);
            copied ? resolve(copied) : reject('You just have copied something empty! Try once again!');
        }
    );
}

/**
 * 剪切动作
 * @param init {string | Element} 可以是字符串或DOM选择器，也可以是DOM元素
 * @param isDomSelector {boolean} 是否为DOM选择器字符串。默认为true，如果只想复制单一文本，可传入false
 * @returns 复制后的内容
 */
export function useCut (init: string | Element, isDomSelector = true): Promise<string> {
    // 支持检查
    if (!isSupported()) throw new Error('Sorry, your browser does not support Clipboard.js!');

    // 调用上面的函数
    const selected = getSelected(init, isDomSelector);
   
   // Promise封装异步操作
    return new Promise<string>(
        (resolve, reject) => {
            const cutContent = cut(selected);
            cutContent ? resolve(cutContent) : reject('You just have cut something empty! Try once again!');
        }
    );
}
```