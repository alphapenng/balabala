> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [juejin.cn](https://juejin.cn/post/7062733724504293413)

「这是我参与 2022 首次更文挑战的第 2 天，活动详情查看：[2022 首次更文挑战](https://juejin.cn/post/7052884569032392740 "https://juejin.cn/post/7052884569032392740")」。

前言
==

通常情况下，`Node.js` 被认为是单线程。由主线程去按照编码顺序一步步执行程序代码，一旦遇到同步代码阻塞，主线程就会被占用，后续的程序代码的执行都会被卡住。🤔没错 `Node.js` 的单线程指的是主线程是 "单线程"。

为了解决单线程带来的问题，本文的主角 `worker_threads` 出现了。`worker_threads` 首次在 `Node.js v10.5.0` 作为实验性功能出现，需要命令行带上 `--experimental-worker` 才能使用。直到 `v12.11.0` 稳定版才能正式使用。

本文将会介绍 `worker_threads` 的使用方式，以及利用 `worker_threads` 执行[斐波那契数列](https://link.juejin.cn?target=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFibonacci_number "https://en.wikipedia.org/wiki/Fibonacci_number")作为实践例子。

先决条件
====

阅读并食用本文，需要先具备：

*   安装了 `Node.js v12.11.0` 及以上版本
*   掌握 JavaScript 同步和异步编程的基础知识
*   掌握 Node.js 的工作原理

worker_threads 介绍
=================

`worker_threads` 模块允许使用并行执行 JavaScript 的线程。

工作线程对于执行 CPU 密集型的 JavaScript 操作很有用。 它们对 I/O 密集型的工作帮助不大。 Node.js 内置的异步 I/O 操作比工作线程更高效。

与 `child_process` 或 `cluster` 不同，`worker_threads` 可以共享内存。 它们通过传输 `ArrayBuffer` 实例或共享 `SharedArrayBuffer` 实例来实现。

由于以下特性，`worker_threads` 已被证明是充分利用 CPU 性能的最佳解决方案：

1.  它们运行具有多个线程的单个进程。
2.  每个线程执行一个事件循环。
3.  每个线程运行单个 JS 引擎实例。
4.  每个线程执行单个 Node.js 实例。

worker_threads 如何工作
===================

`worker_threads` 通过执行`主线程`指定的`脚本文件`来工作。每个线程都在与其他线程隔离的情况下执行。但是，这些线程可以通过消息通道来回传递消息。

`主线程`使用 `worker.postMessage()` 函数使用消息通道，而`工作线程`使用 `parentPort.postMessage()` 函数。

### 通过官方示例代码加强了解：

```
const {
  Worker, isMainThread, parentPort, workerData
} = require('worker_threads');

if (isMainThread) {
  module.exports = function parseJSAsync(script) {
    return new Promise((resolve, reject) => {
      const worker = new Worker(__filename, {
        workerData: script
      });
      worker.on('message', resolve);
      worker.on('error', reject);
      worker.on('exit', (code) => {
        if (code !== 0)
          reject(new Error(`Worker stopped with exit code ${code}`));
      });
    });
  };
} else {
  const { parse } = require('some-js-parsing-library');
  const script = workerData;
  parentPort.postMessage(parse(script));
}
```

上述代码`主线程`与`工作线程`都使用同一份文件作为执行脚本 (`__filename` 为当前执行文件路径)，通过 `isMainThread` 来区分`主线程`与`工作线程`运行时逻辑。当模块对外暴露方法 `parseJSAsync` 被调用时候，都将会衍生子工作线程去执行调用 `parse` 函数。

worker_threads 具体使用
===================

在本节使用具体例子介绍 `worker_threads` 的使用

创建`工作线程`脚本文件 `workerExample.js`:

```
const { workerData, parentPort } = require('worker_threads')
parentPort.postMessage({ welcome: workerData })
```

创建`主线程`脚本文件 `main.js`:

```
const { Worker } = require('worker_threads')

const runWorker = (workerData) => {
    return new Promise((resolve, reject) => {
        // 引入 workerExample.js `工作线程`脚本文件
        const worker = new Worker('./workerExample.js', { workerData });
        worker.on('message', resolve);
        worker.on('error', reject);
        worker.on('exit', (code) => {
            if (code !== 0)
                reject(new Error(`stopped with  ${code} exit code`));
        })
    })
}

const main = async () => {
    const result = await runWorker('hello worker threads')
    console.log(result);
}

main().catch(err => console.error(err))
```

控制台命令行执行:

```
node main.js
```

输出:

```
{ welcome: 'hello worker threads' }
```

worker_threads 运算斐波那契数列
=======================

在本节中，让我们看一下 CPU 密集型示例，生成[斐波那契数列](https://link.juejin.cn?target=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFibonacci_number "https://en.wikipedia.org/wiki/Fibonacci_number")。

如果在没有工作线程的情况下完成此任务，则会随着 `nth` 期限的增加而阻塞主线程。

创建`工作线程`脚本文件 `worker.js`

```
const {parentPort, workerData} = require("worker_threads");

parentPort.postMessage(getFibonacciNumber(workerData.num))

function getFibonacciNumber(num) {
    if (num === 0) {
        return 0;
    }
    else if (num === 1) {
        return 1;
    }
    else {
        return getFibonacciNumber(num - 1) + getFibonacciNumber(num - 2);
    }
}
```

创建`主线程`脚本文件 `main.js`:

```
const {Worker} = require("worker_threads");

let number = 30;

const worker = new Worker("./worker.js", {workerData: {num: number}});

worker.once("message", result => {
    console.log(`${number}th Fibonacci Result: ${result}`);
});

worker.on("error", error => {
    console.log(error);
});

worker.on("exit", exitCode => {
    console.log(`It exited with code ${exitCode}`);
})

console.log("Execution in main thread");
```

控制台命令行执行:

```
node main.js
```

输出:

```
Execution in main thread
30th Fibonacci Result: 832040
It exited with code 0
```

在 `main.js` 文件中，我们从类的实例创建一个工作线程，`Worker` 正如我们在前面的示例中看到的那样。

为了得到结果，我们监听 3 个事件，

*   `message` 响应`工作线程`发出消息。
*   `exit` 在`工作线程`停止执行的情况下触发的事件。
*   `error` 发生错误时触发。

我们在最后一行 `main.js`，

```
console.log("Execution in main thread");
```

通过控制台的输出可得，`主线程`并没有被[斐波那契数列](https://link.juejin.cn?target=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFibonacci_number "https://en.wikipedia.org/wiki/Fibonacci_number")运算执行而阻塞。

因此，只要在`工作线程`中处理 CPU 密集型任务，我们就可以继续处理其他任务而不必担心阻塞主线程。

结论
==

`Node.js` 在处理 CPU 密集型任务时一直因其性能而受到批评。通过有效地解决这些缺点，工作线程的引入提高了 Node.js 的功能。

有关 `worker_threads` 的更多信息，请[在此处](https://link.juejin.cn?target=https%3A%2F%2Fnodejs.org%2Fapi%2Fworker_threads.html%23worker_threads_worker_threads "https://nodejs.org/api/worker_threads.html#worker_threads_worker_threads")访问其官方文档。

思考
==

文章结束前留下思考，后续会在评论区做补充，欢迎一起讨论👏。

*   `worker_threads` 线程空闲时候会被回收吗？
*   `worker_threads` 共享内存如何使用？
*   既然说到`线程`，那么应该有`线程池` ?