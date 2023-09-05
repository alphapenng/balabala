# nodejs 开发实战

- [nodejs 开发实战](#nodejs-开发实战)
  - [课程介绍](#课程介绍)
    - [Node.js 是什么？](#nodejs-是什么)
  - [技术预研篇](#技术预研篇)
    - [什么是技术预研](#什么是技术预研)
    - [第一个 Node.js 程序：石头剪刀布游戏](#第一个-nodejs-程序石头剪刀布游戏)
    - [模块：CommonJS 规范](#模块commonjs-规范)
    - [模块：使用模块规范改造石头剪刀布游戏](#模块使用模块规范改造石头剪刀布游戏)
    - [模块：npm](#模块npm)
    - [模块：Node.js 内置模块](#模块nodejs-内置模块)
    - [异步：非阻塞I/O](#异步非阻塞io)
    - [异步编程之 callback](#异步编程之-callback)
    - [异步：事件循环](#异步事件循环)
    - [异步：异步编程之 Promise](#异步异步编程之-promise)
    - [异步： 异步编程之 async/await](#异步-异步编程之-asyncawait)
    - [HTTP：简单实现一个 HTTP 服务器](#http简单实现一个-http-服务器)
    - [HTTP：实现网页版石头剪刀布](#http实现网页版石头剪刀布)
    - [HTTP：用express优化石头剪刀布游戏](#http用express优化石头剪刀布游戏)
    - [HTTP：用koa优化石头剪刀布游戏](#http用koa优化石头剪刀布游戏)
    - [RPC 调用：什么是RPC调用](#rpc-调用什么是rpc调用)
    - [RPC 调用：Node.js Buffer 编解码二进制数据包](#rpc-调用nodejs-buffer-编解码二进制数据包)
    - [RPC 调用：Node.js net 建立多路复用的 RPC 通道](#rpc-调用nodejs-net-建立多路复用的-rpc-通道)

## 课程介绍

### Node.js 是什么？

- 官网的话
  - Node.js 是一个基于 **Chrome V8 引擎**的 JavaScript 运行环境
  - Node.js 使用了一个**事件驱动**、**非阻塞式 I/O** 的模型，使其轻量又高效

- 在 Node.js 里运行 JavaScript 跟在 Chrome 里运行 JavaScript 有什么不同？
  - Node.js 没有浏览器 API，即 document， window 等
  - 加了许多 Node.js API

## 技术预研篇

### 什么是技术预研

- BFF 层
  - 对用户侧提供 HTTP 服务
  - 使用后端 RPC 服务

### 第一个 Node.js 程序：石头剪刀布游戏

- Node.js 全局变量

  ```javascript
  console.log(Date);
  console.log(Math);

  console.log(setTimeout);
  console.log(setInterval);
  console.log(setImmediate);

  console.log(__filename);
  console.log(__dirname);

  console.log(process);
  ```

### 模块：CommonJS 规范

- `index.js`

  ```javascript
  console.log("start require");
  const lib = require("./lib.js");
  console.log("end require", lib);
  console.log(lib.add);

  lib.additional = "test";
  ```

- `lib.js`

  ```javascript
  console.log("geekbang");

  exports.hello = "world";

  exports.add = (a, b) => a + b;

  exports.geekbang = { hello: "world" };

  module.exports = function minus(a, b) {
    return a - b;
  };

  setTimeout(() => {
    console.log(exports);
  }, 2000);
  ```

- `node index.js` 输出结果：

  ```powershell
  start require
  geekbang
  end require [Function: minus]
  undefined
  {
    hello: 'world',
    add: [Function (anonymous)],
    geekbang: { hello: 'world' }
  }
  ```

- `webpack --devtool inline-source-map --mode development --target node --entry ./index.js` 输出 `main.js`：

  ```javascript
  /******/ (() => { // webpackBootstrap
  /******/ 	var __webpack_modules__ = ({

  /***/ "./lib.js":
  /*!****************!*\
    !*** ./lib.js ***!
    \****************/
  /***/ ((module, exports) => {

  console.log("geekbang");

  exports.hello = "world";

  exports.add = (a, b) => a + b;

  exports.geekbang = { hello: "world" };

  module.exports = function minus(a, b) {
    return a - b;
  };

  setTimeout(() => {
    console.log(exports);
  }, 2000);


  /***/ })

  /******/ 	});
  /************************************************************************/
  /******/ 	// The module cache
  /******/ 	var __webpack_module_cache__ = {};
  /******/ 	
  /******/ 	// The require function
  /******/ 	function __webpack_require__(moduleId) {
  /******/ 		// Check if module is in cache
  /******/ 		var cachedModule = __webpack_module_cache__[moduleId];
  /******/ 		if (cachedModule !== undefined) {
  /******/ 			return cachedModule.exports;
  /******/ 		}
  /******/ 		// Create a new module (and put it into the cache)
  /******/ 		var module = __webpack_module_cache__[moduleId] = {
  /******/ 			// no module.id needed
  /******/ 			// no module.loaded needed
  /******/ 			exports: {}
  /******/ 		};
  /******/ 	
  /******/ 		// Execute the module function
  /******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
  /******/ 	
  /******/ 		// Return the exports of the module
  /******/ 		return module.exports;
  /******/ 	}
  /******/ 	
  /************************************************************************/
  var __webpack_exports__ = {};
  // This entry need to be wrapped in an IIFE because it need to be isolated against other modules in the chunk.
  (() => {
  /*!******************!*\
    !*** ./index.js ***!
    \******************/
  console.log("start require");
  const lib = __webpack_require__(/*! ./lib.js */ "./lib.js");
  console.log("end require", lib);
  console.log(lib.add);

  lib.additional = "test";

  })();

  /******/ })()
  ;
  //# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWFpbi5qcyIsIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7QUFBQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQSxhQUFhOztBQUViLFdBQVc7O0FBRVgsZ0JBQWdCLEtBQUs7O0FBRXJCO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0EsQ0FBQzs7Ozs7OztVQ3ZCRDtVQUNBOztVQUVBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBOztVQUVBO1VBQ0E7O1VBRUE7VUFDQTtVQUNBOzs7Ozs7Ozs7QUN0QkE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxZQUFZLG1CQUFPLENBQUMsMEJBQVU7QUFDOUI7QUFDQTs7QUFFQSIsInNvdXJjZXMiOlsid2VicGFjazovLy8uL2xpYi5qcyIsIndlYnBhY2s6Ly8vd2VicGFjay9ib290c3RyYXAiLCJ3ZWJwYWNrOi8vLy4vaW5kZXguanMiXSwic291cmNlc0NvbnRlbnQiOlsiLypcbiAqIEBEZXNjcmlwdGlvbjpcbiAqIEBBdXRob3I6IGFscGhhcGVubmdcbiAqIEBHaXRodWI6XG4gKiBARGF0ZTogMjAyMy0wOS0wMyAxNjozMjoxN1xuICogQExhc3RFZGl0b3JzOiBhbHBoYXBlbm5nXG4gKiBATGFzdEVkaXRUaW1lOiAyMDIzLTA5LTAzIDE2OjUxOjQzXG4gKiBARmlsZVBhdGg6IFxcZ2Vlay1ub2RlanMtYWxwaGFwZW5uZ1xcY29tbW9uanNcXGxpYi5qc1xuICovXG5jb25zb2xlLmxvZyhcImdlZWtiYW5nXCIpO1xuXG5leHBvcnRzLmhlbGxvID0gXCJ3b3JsZFwiO1xuXG5leHBvcnRzLmFkZCA9IChhLCBiKSA9PiBhICsgYjtcblxuZXhwb3J0cy5nZWVrYmFuZyA9IHsgaGVsbG86IFwid29ybGRcIiB9O1xuXG5tb2R1bGUuZXhwb3J0cyA9IGZ1bmN0aW9uIG1pbnVzKGEsIGIpIHtcbiAgcmV0dXJuIGEgLSBiO1xufTtcblxuc2V0VGltZW91dCgoKSA9PiB7XG4gIGNvbnNvbGUubG9nKGV4cG9ydHMpO1xufSwgMjAwMCk7XG4iLCIvLyBUaGUgbW9kdWxlIGNhY2hlXG52YXIgX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fID0ge307XG5cbi8vIFRoZSByZXF1aXJlIGZ1bmN0aW9uXG5mdW5jdGlvbiBfX3dlYnBhY2tfcmVxdWlyZV9fKG1vZHVsZUlkKSB7XG5cdC8vIENoZWNrIGlmIG1vZHVsZSBpcyBpbiBjYWNoZVxuXHR2YXIgY2FjaGVkTW9kdWxlID0gX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fW21vZHVsZUlkXTtcblx0aWYgKGNhY2hlZE1vZHVsZSAhPT0gdW5kZWZpbmVkKSB7XG5cdFx0cmV0dXJuIGNhY2hlZE1vZHVsZS5leHBvcnRzO1xuXHR9XG5cdC8vIENyZWF0ZSBhIG5ldyBtb2R1bGUgKGFuZCBwdXQgaXQgaW50byB0aGUgY2FjaGUpXG5cdHZhciBtb2R1bGUgPSBfX3dlYnBhY2tfbW9kdWxlX2NhY2hlX19bbW9kdWxlSWRdID0ge1xuXHRcdC8vIG5vIG1vZHVsZS5pZCBuZWVkZWRcblx0XHQvLyBubyBtb2R1bGUubG9hZGVkIG5lZWRlZFxuXHRcdGV4cG9ydHM6IHt9XG5cdH07XG5cblx0Ly8gRXhlY3V0ZSB0aGUgbW9kdWxlIGZ1bmN0aW9uXG5cdF9fd2VicGFja19tb2R1bGVzX19bbW9kdWxlSWRdKG1vZHVsZSwgbW9kdWxlLmV4cG9ydHMsIF9fd2VicGFja19yZXF1aXJlX18pO1xuXG5cdC8vIFJldHVybiB0aGUgZXhwb3J0cyBvZiB0aGUgbW9kdWxlXG5cdHJldHVybiBtb2R1bGUuZXhwb3J0cztcbn1cblxuIiwiLypcbiAqIEBEZXNjcmlwdGlvbjpcbiAqIEBBdXRob3I6IGFscGhhcGVubmdcbiAqIEBHaXRodWI6XG4gKiBARGF0ZTogMjAyMy0wOS0wMyAxNjozMjoxMlxuICogQExhc3RFZGl0b3JzOiBhbHBoYXBlbm5nXG4gKiBATGFzdEVkaXRUaW1lOiAyMDIzLTA5LTAzIDE2OjUxOjE5XG4gKiBARmlsZVBhdGg6IFxcZ2Vlay1ub2RlanMtYWxwaGFwZW5uZ1xcY29tbW9uanNcXGluZGV4LmpzXG4gKi9cbmNvbnNvbGUubG9nKFwic3RhcnQgcmVxdWlyZVwiKTtcbmNvbnN0IGxpYiA9IHJlcXVpcmUoXCIuL2xpYi5qc1wiKTtcbmNvbnNvbGUubG9nKFwiZW5kIHJlcXVpcmVcIiwgbGliKTtcbmNvbnNvbGUubG9nKGxpYi5hZGQpO1xuXG5saWIuYWRkaXRpb25hbCA9IFwidGVzdFwiO1xuIl0sIm5hbWVzIjpbXSwic291cmNlUm9vdCI6IiJ9
  ```

### 模块：使用模块规范改造石头剪刀布游戏

- `index.js`

  ```javascript
  const game = require("./lib");

  let count = 0;

  process.stdin.on("data", (e) => {
    const playerAction = e.toString().trim();
    const result = game(playerAction);
    console.log(result);
    if (result === -1) {
      count++;
    }
    if (count === 3) {
      console.log("你太厉害了，我不玩儿了");
      process.exit();
    }
  });
  ```

- `lib.js`

  ```javascript
  module.exports = function (playerAction) {
    console.log(`玩家出拳:${playerAction}`);

    let random = Math.random() * 3;
    let computerAction;

    if (random < 1) {
      console.log("电脑出拳:剪刀");
      computerAction = "剪刀";
    } else if (random < 2) {
      console.log("电脑出拳:石頭");
      computerAction = "石頭";
    } else {
      console.log("电脑出拳:布");
      computerAction = "布";
    }

    if (computerAction === playerAction) {
      console.log("平手");
      return 0;
    } else if (
      (computerAction === "剪刀" && playerAction === "石頭") ||
      (computerAction === "石頭" && playerAction === "布") ||
      (computerAction === "布" && playerAction === "剪刀")
    ) {
      console.log("玩家赢");
      return -1;
    } else {
      console.log("玩家输");
      return 1;
    }
  };
  ```

### 模块：npm

- 常用命令

  ```powershell
  npm init
  npm install glob
  rm node_modules
  npm install
  npm i extend
  npm uninstall extend
  ```

- 设置国内镜像

  ```powershell
  npm install -g cnpm --registry=https://registry.npm.taobao.org
  cnpm install gulp --save
  ```

### 模块：Node.js 内置模块

- Node.js 架构

  ![nodejs_arch](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202309041244609.webp)

- EventEmitter
  - 观察者模式
    - addEventListener
    - removeEventListener
  - 调用 VS 抛事件
    - 抛事件关键在于“不知道被通知者存在”
    - 以及 “没有人听还能继续下去”
  - 代码演示

    `lib.js`
    ```javascript
    const { EventEmitter } = require("events");

    class GeekTime extends EventEmitter {
      constructor() {
        super();
        setInterval(() => {
          this.emit("newlesson", { price: Math.random() * 100 });
        }, 3000);
      }
    }

    const geektime = new GeekTime();

    module.exports = geektime;
    ```

    `index.js`
    ```javascript
    const { geektime } = require("./lib");

    geektime.addListener("newlesson", (data) => {
      if (data.price < 80) {
        console.log("buy!", data);
      }
    });
    ```

### 异步：非阻塞I/O

- Node.js 的非阻塞I/O
  - I/O 即 Input/Output，一个系统的输入和输出。
  - **阻塞 I/O 和非阻塞 I/O 的区别就在于系统接收输入再到输出期间，能不能接收其他输入**

- 理解非阻塞 I/O 的要点在于
  - 确定一个进行 Input/Output 的系统
  - 思考在 I/O 过程中，能不能进行其他 I/O

- 代码演示（glob）
  - `index.js`

    ```javascript
    const glob = require("glob");

    let result = null;

    // console.time("glob");
    // result = glob.sync(__dirname + "/**/*");
    // console.timeEnd("glob");
    // console.log(result);

    console.time("glob");
    glob(__dirname + "/**/*", (err, files) => {
      result = files;
      // console.log(result);
      console.log("got result");
    });
    console.timeEnd("glob");
    console.log(1 + 1);   
    ```

![nodejs的非阻塞io](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202309041913612.webp)

### 异步编程之 callback

- 回调函数格式规范
  - error-first callback
  - node-style callback
- 第一个参数是 error，后面的参数才是结果

  ```javascript
  // try {
  interview((res) => {
    if (res instanceof Error) {
      return console.log("cry");
    }
    console.log("smile");
  });
  // } catch (error) {
  //   console.log("cry", error);
  // }

  function interview(callback) {
    setTimeout(() => {
      if (Math.random() < 0.5) {
        callback("success");
      } else {
        // throw new Error("fail");
        callback(new Error("fail"));
      }
    }, 500);
  }
  ```

- 异步流程控制
  - 异步并发
  - 回调地狱

    ```javascript
    //异步并发
    let count = 0;
    interview((err) => {
      if (err) {
        return console.log("cry");
      }
      count++;
    });

    interview((err) => {
      if (err) {
        return console.log("cry");
      }
      count++;
      if (count) {

      }
    });

    // 回调地狱
    interview((err) => {
      if (err) {
        return console.log("cry at 1st round");
      }
      interview((err) => {
        if (err) {
          return console.log("cry at 2nd round");
        }
        interview((err) => {
          if (err) {
            return console.log("cry at 3rd round");
          }
          console.log("smile");
        });
      });
    });

    function interview(callback) {
      setTimeout(() => {
        if (Math.random() < 0.5) {
          callback("success");
        } else {
          // throw new Error("fail");
          callback(new Error("fail"));
        }
      }, 500);
    }
    ```
- npm: async.js
- thunk

### 异步：事件循环

- 代码演示

  ```javascript
  const eventloop = {
    queue: [],
    timeoutqueue: [],
    fsqueue: [],

    loop() {
      while (this.queue.length) {
        let callback = this.queue.shift();
        callback();
      }
      this.fsqueue.forEach((callback) => {
        if (done) {
          callback();
        }
      });

      setTimeout(this.loop.bind(this), 50);
    },

    add(callback) {
      this.queue.push(callback);
    },
  };

  eventloop.loop();

  setTimeout(() => {
    eventloop.add(() => {
      console.log(1);
    });
  }, 500);

  setTimeout(() => {
    eventloop.add(() => {
      console.log(2);
    });
  }, 800);
  ```

### 异步：异步编程之 Promise

- Promise
  - 当前事件循环得不到的结果，但未来的事件循环会给到你结果
  - 是一个状态机
    - pending
    - fulfilled/resolved
    - rejected

  ![Promise](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202309042110426.webp)

- .then 和 .catch
  - resolved 状态的 Promise 会回调后面的第一个 .then
  - rejected 状态的 Promise 会回调后面的第一个 .catch
  - 任何一个rejected 状态且后面没有 .catch 的 Promise，都会造成浏览器/node环境的全局错误

- 执行 then 和 catch 会返回一个新 Promise，该 Promise 最终状态根据 then 和 catch 的回调函数的执行结果决定
  - 如果回调函数最终是 throw，该 Promise 是 rejected 状态
  - 如果回调函数最终是 return，该 Promise 是 resolved 状态
  - 但如果回调函数最终 return 了一个 Promise，该 Promise 会和回调函数 return 的 Promise  状态保持一致

- 解决回调地狱

  ```javascript
  let promise = interview(1)
    .then(() => {
      return interview(2);
    })
    .then(() => {
      return interview(3);
    })
    .then(() => {
      console.log("success");
    })
    .catch((err) => {
      console.log("cry at " + err.round + " round");
    });

  function interview(round) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (Math.random() > 0.2) {
          resolve("success");
        } else {
          let error = new Error("fail");
          error.round = round;
          reject(error);
        }
      }, 500);
    });
  }
  ```

- 解决异步并发

  ```javascript
  // catch 只能捕获第一个 reject 返回的结果
  Promise.all([interview("geekbang"), interview("tencent")])
    .then(() => {
      console.log("smile");
    })
    .catch((err) => {
      console.log("cry for " + err.name);
    });

  function interview(name) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (Math.random() > 0.2) {
          resolve("success");
        } else {
          let error = new Error("fail");
          error.name = name;
          reject(error);
        }
      }, 500);
    });
  }
  ```

### 异步： 异步编程之 async/await

- async/await
  - async function 是 Promise 的语法糖封装
  - 异步编程的终极方案——以同步的方式写异步
    - await 关键字可以 “暂停” async function 的执行
    - await 关键字可以以同步的写法获取 Promise 的执行结果
    - try-catch 可以获取 await 所得到的错误

  ```javascript
  const result = (async () => {
    let content = await new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve(6);
      }, 500);
    });

    console.log(content);
    return 4;
  })();

  setTimeout(() => {
    console.log(result);
  }, 800);

  /* 输出结果
  6
  Promise { 4 }
  */
  ```

  ```javascript
  const result = (async () => {
    let content;
    try {
      content = await new Promise((resolve, reject) => {
        setTimeout(() => {
          reject(new Error("8"));
        }, 500);
      });
    } catch (e) {
      console.log("error", e.message);
    }

    console.log(content);
    return 4;
  })();

  setTimeout(() => {
    console.log(result);
  }, 800);
  
  /*输出结果
  error 8
  undefined
  Promise { 4 }
  */
  ```

  ```javascript
  (async () => {
    try {
      await interview(1);
      await interview(2);
      await interview(3);
    } catch (e) {
      return console.log("cry at " + e.round);
    }
    console.log("smile");
  })();

  function interview(round) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (Math.random() > 0.2) {
          resolve("success");
        } else {
          let error = new Error("fail");
          error.round = round;
          reject(error);
        }
      }, 500);
    });
  }
  ```

  ```javascript
  (async () => {
    try {
      await Promise.all([interview(1), interview(2), interview(3)]);
    } catch (e) {
      return console.log("cry at " + e.round);
    }
    console.log("smile");
  })();

  function interview(round) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (Math.random() > 0.2) {
          resolve("success");
        } else {
          let error = new Error("fail");
          error.round = round;
          reject(error);
        }
      }, 500);
    });
  }
  ```

  - 一个穿越事件循环存在的 function

### HTTP：简单实现一个 HTTP 服务器

- `npm install -g httpserver`

### HTTP：实现网页版石头剪刀布

- `index.html`

  ```html
  <html>

    <head>
        <meta charset="utf-8">
        <style>
            * {
                padding: 0;
                margin: 0;
            }
    
            button {
                display: inline-block
            }
        </style>
    </head>
    
    <body>
        <div id="output" style="height: 400px; width: 600px; background: #eee">
        </div>
        <button id="rock" style="height: 40px; width: 80px">石头</button>
        <button id="scissor" style="height: 40px; width: 80px">剪刀</button>
        <button id="paper" style="height: 40px; width: 80px">布</button>
    </body>
    <script>
        const $button = {
            "石頭": document.getElementById('rock'),
            "剪刀": document.getElementById('scissor'),
            "布": document.getElementById('paper')
        }
    
        const $output = document.getElementById('output')
    
        Object.keys($button).forEach(key => {
            $button[key].addEventListener('click', function () {
                fetch(`http://${location.host}/game?action=${key}`)
                    .then((res) => {
                        return res.text()
                    })
                    .then((text) => {
                        $output.innerHTML += text + '<br/>';
                    })
            })
        })
    </script>
    
  </html>
  ```

- `game.js`

  ```javascript
  module.exports = function (playerAction) {
    if (["石頭", "剪刀", "布"].indexOf(playerAction) === -1) {
      throw new Error("invalid playerAction");
    }

    let random = Math.random() * 3;
    let computerAction;

    if (random < 1) {
      console.log("电脑出拳:剪刀");
      computerAction = "剪刀";
    } else if (random < 2) {
      console.log("电脑出拳:石頭");
      computerAction = "石頭";
    } else {
      console.log("电脑出拳:布");
      computerAction = "布";
    }

    if (computerAction === playerAction) {
      console.log("平手");
      return 0;
    } else if (
      (computerAction === "剪刀" && playerAction === "石頭") ||
      (computerAction === "石頭" && playerAction === "布") ||
      (computerAction === "布" && playerAction === "剪刀")
    ) {
      console.log("玩家赢");
      return -1;
    } else {
      console.log("玩家输");
      return 1;
    }
  };
  ```

- `index.js`

  ```javascript
  const fs = require("fs");
  const http = require("http");
  const url = require("url");
  const queryString = require("querystring");

  const game = require("./game");
  const { log } = require("console");

  let playerWon = 0;
  let playerLastAction = null;
  let sameCount = 0;

  http
    .createServer((req, res) => {
      const parseUrl = url.parse(req.url);

      if (parseUrl.pathname === "/favicon.ico") {
        res.writeHead(200);
        res.end();
        return;
      }

      if (parseUrl.pathname === "/game") {
        const query = queryString.parse(parseUrl.query);
        const playerAction = query.action;

        if (playerWon >= 3 || sameCount === 9) {
          res.writeHead(500);
          res.end("你太厉害了，我不玩儿了");
          return;
        }

        if (playerLastAction && playerLastAction === playerAction) {
          sameCount++;
          if (sameCount >= 3) {
            res.writeHead(400);
            res.end("你作弊");
            sameCount = 9;
            return;
          }
        } else {
          sameCount = 0;
        }

        playerLastAction = playerAction;

        const gameResult = game(playerAction);

        res.writeHead(200);
        if (gameResult === 0) {
          res.end("平手");
        } else if (gameResult === -1) {
          res.end("玩家赢");
          playerWon++;
        } else {
          res.end("玩家输");
        }
      }

      if (parseUrl.pathname === "/") {
        fs.createReadStream(__dirname + "/index.html").pipe(res);
      }
    })
    .listen(3000);
    ```

### HTTP：用express优化石头剪刀布游戏

- Express
  - 核心功能
    - 路由
    - request/response 简化
      - request：pathname、query 等
      - response：sen()、json()、jsonp()等
    - 中间件
      - 更好地组织流程代码
      - 异步会打破 Express 的洋葱模型
  - 代码演示

    ```javascript
    const fs = require("fs");
    const http = require("http");
    const url = require("url");
    const queryString = require("querystring");
    const express = require("express");

    const game = require("./game");

    let playerWonCount = 0;
    let playerLastAction = null;
    let sameCount = 0;

    const app = express();

    app.get("/favicon.ico", (req, res) => {
      res.status(200);
      return;
    });

    app.get(
      "/game",
      (req, res, next) => {
        if (playerWonCount >= 3 || sameCount === 9) {
          res.status(500);
          res.send("你太厉害了，我不玩儿了");
          return;
        }
        next();
        if (res.playerWon) {
          playerWonCount++;
        }
      },
      (req, res, next) => {
        const query = req.query;
        const playerAction = query.action;

        if (!playerAction) {
          response.status(400);
          response.send();
          return;
        }

        if (playerLastAction && playerLastAction === playerAction) {
          sameCount++;
          if (sameCount >= 3) {
            res.status(400);
            res.send("你作弊，我再也不玩了");
            sameCount = 9;
            return;
          }
        } else {
          sameCount = 0;
        }

        playerLastAction = playerAction;
        res.playerAction = playerAction;
        next();
      },
      (req, res) => {
        const playerAction = res.playerAction;
        const gameResult = game(playerAction);

        res.status(200);
        if (gameResult === 0) {
          res.send("平手");
        } else if (gameResult === -1) {
          res.send("玩家赢");
          res.playerWon = true;
        } else {
          res.send("玩家输");
        }
      }
    );

    app.get("/", (req, res) => {
      res.send(fs.readFileSync(__dirname + "/index.html", "utf-8"));
    });

    app.listen(3000);
    ```

### HTTP：用koa优化石头剪刀布游戏

- Koa
  - 核心功能
    - 比 Express 更极致的 request/response 简化
      - ctx.status = 200
      - ctx.body = "hello world"
    - 使用 async function 实现的中间件
      - 有 “暂定执行” 的能力
      - 在异步的情况下也符合洋葱模型
    - 精简内核，所有额外功能都移到中间件里实现
    - 代码演示
      - `npm i koa koa-mount`
      - `index.js` 

      ```javascript
      const fs = require("fs");
      const http = require("http");
      const url = require("url");
      const queryString = require("querystring");
      const koa = require("koa");
      const mount = require("koa-mount");

      const game = require("./game");

      let playerWonCount = 0;
      let playerLastAction = null;
      let sameCount = 0;

      const app = new koa();

      app.use(
        mount("/favicon.ico", (ctx) => {
          ctx.status = 200;
        })
      );

      const gameKoa = new koa();
      gameKoa.use(async (ctx, next) => {
        if (playerWonCount >= 3) {
          ctx.status = 500;
          ctx.body = "你太厉害了，我不玩儿了";
          return;
        }
        await next();
        if (ctx.playerWon) {
          playerWonCount++;
        }
      });

      gameKoa.use(async (ctx, next) => {
        const query = ctx.query;
        const playerAction = query.action;

        if (!playerAction) {
          ctx.status = 400;
          return;
        }

        if (sameCount === 9) {
          ctx.status = 500;
          ctx.body = "你太厉害了，我不玩儿了";
          return;
        }

        if (playerLastAction && playerLastAction === playerAction) {
          sameCount++;
          if (sameCount >= 3) {
            ctx.status = 400;
            ctx.body = "你作弊，我再也不玩了";
            sameCount = 9;
            return;
          }
        } else {
          sameCount = 0;
        }

        playerLastAction = playerAction;
        ctx.playerAction = playerAction;
        await next();
      });

      gameKoa.use(async (ctx, next) => {
        const playerAction = ctx.playerAction;
        const gameResult = game(playerAction);
        await new Promise((resolve) => {
          setTimeout(() => {
            ctx.status = 200;
            if (gameResult === 0) {
              ctx.body = "平手";
            } else if (gameResult === -1) {
              ctx.body = "玩家赢";
              ctx.playerWon = true;
            } else {
              ctx.body = "玩家输";
            }
            resolve();
          }, 500);
        });
      });

      app.use(mount("/game", gameKoa));

      app.use(
        mount("/", (ctx) => {
          ctx.body = fs.readFileSync(__dirname + "/index.html", "utf-8");
        })
      );

      app.listen(3000);
      ```

### RPC 调用：什么是RPC调用

- Remote Procedure Call（远程过程调用）
- 和 Ajax 有什么相同点？
  - 都是两个计算机之间的网络通信
  - 需要双方约定一个数据格式
- 和 Ajax 有什么不同点？
  - 不一定使用 DNS作为寻址服务
  - 应用层协议一般不使用 HTTP
  - 基于 TCP 或 UDP协议
- 寻址/负载均衡
  - Ajax：使用DNS进行寻址
  - RPC：使用特有服务进行寻址
    ![RPC1](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202309052125046.webp)
- TCP 通信方式
  - 单工通信
  - 半双工通信（轮番单工）
  - 全双工通信
- 二进制协议
  - 更小的数据包体积
  - 更快的编解码速率
    ![RPC2](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202309052132923.webp)

### RPC 调用：Node.js Buffer 编解码二进制数据包

- 大小端问题
  - 几个 Byte里，高位与地位的编排顺序不同
  - 代码演示
  
    ```javascript
    const buffer1 = Buffer.from("geekbang");
    const buffer2 = Buffer.from([1, 2, 3, 4]);

    const buffer3 = Buffer.alloc(20);

    console.log(buffer1);
    console.log(buffer2);
    console.log(buffer3);

    buffer2.writeInt8(12, 1);
    console.log(buffer2);
    buffer2.writeInt16BE(512, 2);
    console.log(buffer2);
    buffer2.writeInt16LE(512, 2);
    console.log(buffer2);
    
    /*输出结果：
    <Buffer 67 65 65 6b 62 61 6e 67>
    <Buffer 01 02 03 04>
    <Buffer 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00>
    <Buffer 01 0c 03 04>
    <Buffer 01 0c 02 00>
    <Buffer 01 0c 00 02>
    */
    ```

- 处理方法与 string 接近
  - 使用 concat 而不是 + 来避免 utf-8 字符拼接问题

- Protocol Buffer
  - Google 研发的二进制协议编解码库
  - 通过协议文件控制 Buffer 的格式
    - 更直观
    - 更好维护
    - 更便于合作
  - 代码演示
    - `npm install protocol-buffers`
    
    ```javascript
    const fs = require("fs");
    const protobuf = require("protocol-buffers");
    const schema = protobuf(fs.readFileSync(__dirname + "/test.proto", "utf-8"));

    console.log(schema);

    const buffer = schema.Column.encode({
      id: 1,
      name: "Node.js",
      price: 80.4,
    });

    console.log(schema.Column.decode(buffer));

    /*输出结果：
    Messages {
      Column: {
        type: 2,
        message: true,
        name: 'Column',
        buffer: true,
        encode: [Function: encode] { bytes: 0 },
        decode: [Function: decode] { bytes: 0 },
        encodingLength: [Function: encodingLength],
        dependencies: [ [Object], [Object], [Object] ]
      }
    }
    { id: 1, name: 'Node.js', price: 80.4000015258789 }
    */
    ```

### RPC 调用：Node.js net 建立多路复用的 RPC 通道

- Node.js net 模块
  - 单工/半双工的通信通道搭建
    - 代码演示

    ```javascript
    // server.js
    const net = require("net");

    const server = net.createServer((socket) => {
      socket.on("data", (buffer) => {
        const lessonid = buffer.readInt32BE();
        setTimeout(() => {
          socket.write(Buffer.from(data[lessonid]));
        }, 50);
      });
    });

    server.listen(3000);

    const data = {
      136797: "01 | 课程介绍",
      136798: "02 | 内容综述",
      136799: "03 | Node.js是什么？",
      136800: "04 | Node.js可以用来做什么？",
      136801: "05 | 课程实战项目介绍",
      136803: "06 | 什么是技术预研？",
      136804: "07 | Node.js开发环境安装",
      136806: "08 | 第一个Node.js程序：石头剪刀布游戏",
      136807: "09 | 模块：CommonJS规范",
      136808: "10 | 模块：使用模块规范改造石头剪刀布游戏",
      136809: "11 | 模块：npm",
      141994: "12 | 模块：Node.js内置模块",
      143517: "13 | 异步：非阻塞I/O",
      143557: "14 | 异步：异步编程之callback",
      143564: "15 | 异步：事件循环",
      143644: "16 | 异步：异步编程之Promise",
      146470: "17 | 异步：异步编程之async/await",
      146569: "18 | HTTP：什么是HTTP服务器？",
      146582: "19 | HTTP：简单实现一个HTTP服务器",
    };
    ```

    ```javascript
    //client.js
    const net = require("net");

    const socket = new net.Socket({});

    socket.connect({
      host: "127.0.0.1",
      port: 3000,
    });

    const lessonids = [
      "136797",
      "136798",
      "136799",
      "136800",
      "136801",
      "136803",
      "136804",
      "136806",
      "136807",
      "136808",
      "136809",
      "141994",
      "143517",
      "143557",
      "143564",
      "143644",
      "146470",
      "146569",
      "146582",
    ];

    let id = Math.floor(Math.random() * lessonids.length);
    socket.write(encode(id));

    socket.on("data", (buffer) => {
      console.log(lessonids[id], buffer.toString());

      id = Math.floor(Math.random() * lessonids.length);
      socket.write(encode(id));
    });

    function encode(index) {
      buffer = Buffer.alloc(4);
      buffer.writeInt32BE(lessonids[index]);
      return buffer;
    }
    ```

  - 全双工的通信通道搭建
    - 关键在于应用层协议需要有标记包号的字段

    ```javascript
    //server.js
    const net = require("net");

    const server = net.createServer((socket) => {
      socket.on("data", (buffer) => {
        const seqBuffer = buffer.slice(0, 2);
        const lessonid = buffer.readInt32BE(2);
        setTimeout(() => {
          const buffer = Buffer.concat([seqBuffer, Buffer.from(data[lessonid])]);
          socket.write(buffer);
        }, 10 + Math.random() * 1000);
      });
    });

    server.listen(3000);
    ```

    ```javascript
    //client.js
    const net = require("net");

    const socket = new net.Socket({});

    socket.connect({
      host: "127.0.0.1",
      port: 3000,
    });

    let id;
    let seq = 0;

    socket.on("data", (buffer) => {
      const seqBuffer = buffer.slice(0, 2);
      const titleBuffer = buffer.slice(2);
      console.log(seqBuffer.readInt16BE(), titleBuffer.toString());
    });

    function encode(index) {
      buffer = Buffer.alloc(6);
      buffer.writeInt16BE(seq, 0);
      buffer.writeInt32BE(lessonids[index], 2);
      console.log(seq, lessonids[index]);
      seq++;
      return buffer;
    }

    setInterval(() => {
      id = Math.floor(Math.random() * lessonids.length);
      socket.write(encode(id));
    }, 50);
    ```

    - 处理以下情况，需要有标记包长的字段
      - 粘包
      - 不完整包

    ```javascript
    
    ```
    
    - 错误处理



  
