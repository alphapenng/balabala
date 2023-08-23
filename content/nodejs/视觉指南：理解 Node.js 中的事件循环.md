> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [juejin.cn](https://juejin.cn/post/7220352362798825509)

> 原文链接：[A Complete Visual Guide to Understanding the Node.js Event Loop](https://link.juejin.cn?target=https%3A%2F%2Fwww.builder.io%2Fblog%2Fvisual-guide-to-nodejs-event-loop "https://www.builder.io/blog/visual-guide-to-nodejs-event-loop")，2023 年 3 月 23 日，by Vishwas Gopinath

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/133de2c4707140429d472db9824d7471~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.image?)

你已经使用 Node.js 一段时间了，构建了一些应用程序，尝试了不同的模块，甚至对异步编程感到很舒适。但是有些事情一直在困扰着你 —— 事件循环（Event Loop）。

如果你像我一样，花费了无数个小时阅读文档和观看视频，试图理解事件循环。但即使作为一个经验丰富的开发者，在完全理解它如何工作方面也可能会遇到困难。这就是为什么我准备了这份视觉指南，帮助您充分理解 Node.js 事件循环。请坐下来，拿杯咖啡，让我们深入探索 Node.js 事件循环的世界吧。

JavaScript 中的异步编程
-----------------

我们将从 JavaScript 中异步编程的复习开始。虽然 JavaScript 在 Web、移动和桌面应用程序中都有使用，但重要的是要记住，本质上，**JavaScript 是一种同步、阻塞、单线程的语言**。让我们通过一个简短的代码片段来理解这句话。

```
// index.js

function A() {
  console.log("A");
}

function B() {
  console.log("B");
}

A()
B()

// Logs A and then B
```

### JavaScript 是同步的

如果我们有两个将消息记录到控制台的函数，那么代码会自上而下执行，每次只执行一行。在上述代码片段中，我们看到 A 在 B 之前被记录。

### JavaScript 是阻塞的

JavaScript 由于其同步性质而被阻塞。无论前一个进程需要多长时间，后续进程都不会启动，直到前者完成为止。在代码片段中，如果函数 A 必须执行大量代码块，则 JavaScript 必须在没有转移到函数 B 的情况下完成该操作。即便这块代码需要耗时 10 秒甚至 1 分钟。

你可能已经在浏览器中遇到过这种情况。当 Web 应用程序在浏览器中运行并且执行一些密集的代码块而不返回控制权给浏览器时，浏览器可能会出现卡死的情况，这就是所谓的阻塞。浏览器被阻止继续处理用户输入和执行其他任务，直到 Web 应用程序将处理器控制权归还给浏览器。

### JavaScript 是单线程的

线程就是你的 JavaScript 程序可以用来运行任务的进程（process）。每个线程一次只能执行一个任务。与其他支持多线程并且可以同时运行多个任务的语言不同，JavaScript 只有一个称为主线程的线程执行代码。

### 等待 JavaScript

如你所想，这种 JavaScript 模型会带来问题，因为我们必须等待数据被获取后才能继续执行代码。这个等待可能需要几秒钟，在此期间我们无法运行任何其他代码。如果 JavaScript 在不等待的情况下继续处理，就会出错。我们需要在 JavaScript 中实现异步行为。我们进到 Node.js 看一下。

Node.js 运行时
-----------

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9b8acf0b94a04feb8724a94c76b27f43~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.image?)

Node.js 运行时是一个环境，你可以在不使用浏览器的情况下使用和运行 JavaScript 程序。核心 ——Node 运行时，由三个主要组件组成。

*   外部依赖项 —— 例如 V8、libuv、crypto 等 —— 是 Node.js 必需的功能
*   C++ 特性提供了文件系统访问和网络等功能。
*   JavaScript 库提供了函数和工具，便于使用 JavaScript 代码调用 C++ 特性。

虽然所有部分都很重要，但异步编程在 Node.js 中的关键组件是 libuv。

### Libuv

[Libuv](https://link.juejin.cn?target=https%3A%2F%2Flibuv.org%2F "https://libuv.org/") 是一个跨平台的开源库，用 C 语言编写。在 Node.js 运行时中，它的作用是提供处理异步操作的支持。我们来看一下它是如何工作的。

### Node.js 运行时中的代码执行

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a0102c7305594268bdaa244d0e71080b~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.image?)

让我们来概括一下代码在 Node 运行时中的执行方式。在执行代码时，位于图片左侧的 V8 引擎负责 JavaScript 代码的执行。该引擎包含一个内存堆（Memory heap）和一个调用栈（Call stack）。

每当声明变量或函数时，都会在堆上分配内存。执行代码时，函数就会被推入调用栈中。当函数返回时，它就从调用栈中弹出了。这是对栈数据结构的简单实现，最后添加的项是第一个被移除。在图片右侧，是负责处理异步方法的 libuv。

每当我们执行异步方法时，libuv 接管任务的执行。然后使用操作系统本地异步机制运行任务。如果本地机制不可用或不足，则利用其线程池来运行任务，并确保主线程不被阻塞。

### 同步代码执行

首先，让我们来看一下同步代码执行。以下代码由三个控制台日志语句组成，依次记录 “First”，“Second” 和 “Third”。我们按照运行时执行顺序来查看代码。

```
// index.js
console.log("First");
console.log("Second");
console.log("Third");
```

以下是 Node 运行时执行同步代码的可视化展示。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/19921cceed5c4a72b00a2baecf800380~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.image?)

执行的主线程始终从全局作用域开始。全局函数（如果我们可以这样称呼它）被推入堆栈中。然后，在第 1 行，我们有一个控制台日志语句。这个函数被推入堆栈中。假设这个发生在 1 毫秒时，“First” 被记录在控制台上。然后，这个函数从堆栈中弹出。

执行到第 2 行时。假设到第 2 毫秒了，log 函数再次被推入堆栈中。“Second” 被记录在控制台上，并弹出该函数。

最后，执行到第 3 行了。第 3 毫秒时，log 函数被推入堆栈，“Third” 将记录在控制台上，并弹出该函数。此时已经没有代码要执行，全局也被弹出。

### 异步代码执行

接下来，让我们看一下异步代码执行。有以下代码片段：包含三个日志语句，但这次第二个日志语句传递给了 `fs.readFile()` 作为回调函数。

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3c735250379e41988ef957d3fcf1013e~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.image?)

执行的主线程始终从全局作用域开始。全局函数被推入堆栈。然后执行到第 1 行，在第 1 毫秒时，“First” 被记录在控制台中，并弹出该函数。然后执行移动到第 2 行，在第 2 毫秒时，`readFile` 方法被推入堆栈。由于 `readFile` 是异步操作，因此它会转移（off-loaded）到 libuv。

JavaScript 从调用堆栈中弹出了 `readFile` 方法，因为就第 2 行的执行而言，它的工作已经完成了。在后台，libuv 开始在单独的线程上读取文件内容。在第 3 毫秒时，JavaScript 继续进行到第 5 行，将 log 函数推入堆栈，“Third” 被记录到控制台中，并将该函数弹出堆栈。

大约在第 4 毫秒左右，假设文件读取任务已经完成，则相关回调函数现在会在调用栈上执行， 在回调函数内部遇到 log 函数。

log 函数推入到到调用栈，“Second” 被记录到控制台并弹出 log 函数 。由于回调函数中没有更多要执行的语句，因此也被弹出 。没有更多代码可运行了 ，所以全局函数也从堆栈中删除 。

控制台输出 “First”，“Third”，然后是 “Second”。

### Libuv 和异步操作

很明显，libuv 用于处理 Node.js 中的异步操作。对于像处理网络请求这样的异步操作，libuv 依赖于操作系统原生机制。对于没有本地 OS 支持的异步读取文件的操作，libuv 则依赖其线程池以确保主线程不被阻塞。然而，这也引发了一些问题。

*   当一个异步任务在 libuv 中完成时，什么时候 Node 会在调用栈上运行相关联的回调函数？
*   Node 是否会等待调用栈为空后再运行回调函数？还是打断正常执行流来运行回调函数？
*   像 `setTimeout` 和 `setInterval` 这类延迟执行回调函数的方法又是何时执行回调函数呢？
*   如果 `setTimeout` 和 `readFile` 这类异步任务同时完成，Node 如何决定哪个回调函数先在调用栈上运行？其中一个会有更多的优先级吗？

所有这些问题都可以通过理解 libuv 核心部分 —— 事件循环来得到答案。

什么是事件循环？
--------

从技术上讲，事件循环只是一个 C 语言程序。但是在 Node.js 中，你可以将其视为一种设计模式，用于协调同步和异步代码的执行。

可视化事件循环
-------

事件循环是一个循环，只要你的 Node.js 应用程序在运行，它就一直运行。每个循环中有六个不同的队列，每个队列都包含一个或多个需要最终在调用堆栈上执行的回调函数。

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/efade16014b14a39b055421227e3c969~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.image?)

*   首先，有一个计时器队列（timer queue。技术上叫最小堆（min-heap）），它保存与 `setTimeout` 和 `setInterval` 相关的回调函数。
*   其次，有一个 I/O 队列（I/O queue），其中包含与所有异步方法相关的回调函数，例如 `fs` 和 `http` 模块中提供的相关方法。
*   第三个是检查队列（check queue），它保存与 `setImmediate` 函数相关的回调函数，这是特定于 Node 的功能。
*   第四个是关闭队列（close queue），它保存与异步任务关闭事件相关联的回调函数。

最后，有两个不同队列组成微任务队列（microtask queue）。

*   nextTick 队列保存了与 `process.nextTick` 函数关联的回调函数。
*   Promise 队列则保存了 JavaScript 中本地 `Promise` 相关联的回调函数。

需要注意的是计时器、I/O、检查和关闭队列都属于 libuv。然而，两个微任务队列并不属于 libuv。尽管如此，它们仍然是 Node 运行时环境中扮演着重要角色，并且在执行回调顺序方面发挥着重要作用。说到这里，让我们来理解一下事件循环是如何工作的。

事件循环是如何工作的？
-----------

图中箭头是一个提示，但可能还不太容易理解。让我来解释一下队列的优先级顺序。首先要知道，所有用户编写的同步 JavaScript 代码都比异步代码优先级更高。这表示只有在调用堆栈为空时，事件循环才会发挥作用。

在事件循环中，执行顺序遵循某些规则。需要掌握的规则还是有一些的，我们逐个的了解一下：

1.  执行微任务队列（microtask queue）中的所有回调函数。首先是 nextTick 队列中的任务，然后是 Promise 队列中的任务。
2.  执行计时器队列（timer queue）内的所有回调函数。
3.  如果微任务队列中存在回调函数，则在**计时器队列内每执行完一次回调函数之后执行微任务队列中的所有回调函数**。首先是 nextTick 队列中的任务，然后是 Promise 队列中的任务。
4.  执行 I/O 队列（I/O queue）内的所有回调函数。
5.  如果微任务队列中存在回调函数，按照先 nextTick 队列后 Promise 队列的顺序依次执行微任务队列中的所有回调函数。
6.  执行检查队列（check queue）内的所有回调函数。
7.  如果微任务队列中存在回调函数，则在**检查队列内每个回调之后执行微任务队列中的所有回调函数** 。首先是 nextTick 队列中的任务，然后是 Promise 队列中的任务。
8.  执行关闭队列（close queue）内的所有回调函数。
9.  在同一循环的最后，再执行一次微任务队列。首先是 nextTick 队列中的任务，然后是 Promise 队列中的任务。

此时，如果还有更多的回调需要处理，那么事件循环再运行一次（译注：事件循环在程序运行期间一直在运行，在当前没有可供处理的任务情况下，会处于等待状态，一旦有新任务就会执行），并重复相同的步骤。另一方面，如果所有回调都已执行并且没有更多代码要处理（译注：也就是程序执行结束），则事件循环退出。

这就是 libuv 事件循环在 Node.js 中执行异步代码的作用。有了这些规则，我们可以重新审视之前提出的问题。

**当一个异步任务在 libuv 中完成时，什么时候 Node 会在调用栈上运行相关联的回调函数？**

答案：_只有当调用栈为空时才执行回调函数。_

**Node 是否会等待调用栈为空后再运行回调函数？还是打断正常执行流来运行回调函数？**

答案：_运行回调函数时不会打断正常执行流。_

**像 `setTimeout` 和 `setInterval` 这类延迟执行回调函数的方法又是何时执行回调函数呢？**

答案：_`setTimeout` 和 `setInterval` 的所有回调函数中第一优先级执行的（不考虑微任务队列）。_

**如果两个异步任务（例如 `setTimeout` 和 `readFile`）同时完成，Node 如何决定那个回调函数先在调用栈中执行？其中一个会比另一个有更高优先权吗？**

答案：_在同时完成的情况下，计时器回调会先于 I/O 回调执行。_

到此为止我们学了很多，但我希望大家可以把下面这张图片展现的执行顺序铭记于心，因为它完整的表现了 Node.js 在幕后是如何执行异步代码的。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e190daee6c5247008ff0957361dfe398~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.image?)

但是，你可能会问：“验证这个可视化的代码在哪里？”。好吧，事件循环中的每个队列都有执行上的细微差别，因此我们最好一个个来讲比较好。本文是 Node.js 事件循环系列文章中的第一篇。请务必查看文末链接，以便了解每个队列中的运行细节，即便你现在在脑海中印象很深了，到具体场景的时候可能还进到一些陷阱。

结论
--

事件循环是 Node.js 的基本组成部分，通过确保主线程不被阻塞来实现异步编程。了解事件循环的工作原理可能具有挑战性，但对于构建高效应用程序至关重要。

这个视觉指南涵盖了 JavaScript 中异步编程、Node.js 运行时和负责处理异步操作的 libuv 的基础知识。有了这些知识，你可以建立一个强大的事件循环模型，在编写利用 Node.js 异步特性的代码时受益。

继续阅读
----

*   第一部分：可视化 Node.js 事件循环（本篇）
*   [第二部分：可视化 Node.js 中的微任务队列](https://juejin.cn/post/7220352362798825509 "https://juejin.cn/post/7220352362798825509")
*   [第三部分：可视化 Node.js 事件循环中的计时器队列](https://juejin.cn/post/7221142199391404091 "https://juejin.cn/post/7221142199391404091")
*   [第四部分：可视化 Node.js 事件循环中的 I/O 队列](https://juejin.cn/post/7224334902325854266 "https://juejin.cn/post/7224334902325854266")
*   [第五部分：可视化 Node.js 事件循环中的 I/O 轮询](https://juejin.cn/post/7225158744782684219 "https://juejin.cn/post/7225158744782684219")
*   [第六部分：可视化 Node.js 事件循环中的检查队列](https://juejin.cn/post/7225803154553258041 "https://juejin.cn/post/7225803154553258041")
*   [第七部分：可视化 Node.js 事件循环中的关闭队列](https://juejin.cn/post/7226193000497348664 "https://juejin.cn/post/7226193000497348664")