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

  ![nodejs架构](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/202309041244609.webp)

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


