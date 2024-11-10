> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [lq782655835.github.io](https://lq782655835.github.io/blogs/node/node-code-express.html)

> nodejs 使得可以用 javascirpt 语言编写后台应用，但使用原生 nodejs 开发 web 应用非常复杂。

nodejs 使得可以用 javascirpt 语言编写后台应用，但使用原生 nodejs 开发 web 应用非常复杂。Express 是目前最流行的基于 Node.js 的 Web 开发框架，可以快速地搭建一个完整功能的网站。以下结合[开发文档 (opens new window)](https://expressjs.com/en/4x/api.html) 和 [express 源码 (opens new window)](https://github.com/expressjs/express/blob/master/lib/express.js)，整理出常用的一些 API 以及路由机制源码，使得读者理解更加通透。

[#](#express) Express
---------------------

*   static class
    *   `Router()` 创建一个 router 对象
    *   `static()` 设置静态资源根目录，基于 [serve-static (opens new window)](http://www.expressjs.com.cn/en/resources/middleware/serve-static.html) 模块
*   instance
    *   路由相关
        *   `app.use(path, callback)` 主要用来添加非路由中间件,`底层调用router.use()`。
            *   匹配 Path 的方式：
                *   路径: /abcd
                *   路径模式: /abc?d
                *   正则表达式: //abc|/xyz/
                *   数组合集: ['/abcd', '/abc?e', //abc|/xyz/]
        *   `app.all/METHOD(path, callback [, callback ...])` 注册一个 http 请求路由
        *   `app.route(path)` 获得 route 实例
    *   实例方法
        *   `app.get(name)` 获取 app 上定义属性
        *   `app.set(name, value)` 绑定或设置属性到 app 上
        *   `app.listen()` 跟 Node 的 http.Server.listen() 一致

> 大部分情况 app.use() 和 app.all() 使用相似，最大不一样是中间件执行顺序。app.use() 针对主进程，放前面跟放最后不一样；但 app.all 针对应用的路由，放的位置与中间件执行无关。[stackoverflow (opens new window)](https://stackoverflow.com/questions/14125997/difference-between-app-all-and-app-use)

[#](#router) Router
-------------------

跟 express 路由 API 相似：

*   `router.use(path, callback)`
*   `router.all/METHOD(path, [callback])`
*   `router.route()`

[#](#request) Request
---------------------

Express Request 扩展了 node http.IncomingMessage 类, 主要是增强了一些获取请求参数的便捷 API。[源代码在这 (opens new window)](https://github.com/expressjs/express/blob/master/lib/request.js)

*   `req.headers``extend http` 返回 header object 对象
*   `req.url``extend http` 返回除域名外所有字符串
*   `req.method``extend http` 返回请求类型 GET、POST 等
*   `req.get(name)/req.header(name)` 底层调用 node http 模块的 req.headers
*   `req.params` 返回参数对象，对应的属性名由定义路由时确定。比如 app.get('/user/:id') 路由时，可以通过 req。params.id 取得参数
*   `req.query` 返回查询参数 object 对象。等同于 qs.parse(url.parse(req.url,true).query)。
*   `req.path` 返回字符串。等同于 url.parse(req.url).pathname。pathname 跟 req.url 比，不带 query 后缀
*   `req.body` post 请求获取到数据。需要使用 [body-parser (opens new window)](https://www.npmjs.com/package/body-parser) 中间件
*   `req.cookies` 拿到 cookies 值。需要使用 [cookie-parser (opens new window)](https://www.npmjs.com/package/cookie-parser) 中间件

[#](#response) Response
-----------------------

Express Response 扩展了 node http.ServerResponse 类, 主要是增加一些便捷 api 以及返回数据时一些默认参数处理。[源代码在这 (opens new window)](https://github.com/expressjs/express/blob/master/lib/response.js)

*   设置响应头
    *   `res.getHeader(name, value)``extend http`
    *   `res.setHeader(name, value)``extend http`
    *   `res.get(field)` 底层调用 res.getHeader()
    *   `res.set(field [, value])/res.header()` 底层调用 res.setHeader()
    *   `res.status(code)` 底层直接赋值 statusCode 属性
    *   `res.type(type)` 快捷设置 Content-Type, 底层调用 res.set('Content-Type', type)
    *   `res.cookie(name, value, options)` 设置指定 name 的 cookie。该功能 express 提供，而不是 cookie-parser 包实现。
    *   `res.clearCookie(name, options)` 清楚指定 name 的 cookie。
*   发送数据
    *   `res.write(chunk[, encoding][, callback])``extend http` 写入数据
    *   `res.end([data] [, encoding])``extend http`。
    *   `res.send([body])` body 可选：Buffer、object、string、Array。除非之前 set 过 Content-Type, 否则该方法会根据参数类型自动设置 Content-Type，底层写入数据使用 res.end()
    *   `res.json()` 返回 json 对象。底层调用 res.send()
    *   `res.redirect([status,] path)` 302 转发 url
    *   `res.render(view [, locals] [, callback])` 输出对应 html 数据
    *   `res.sendStatus(statusCode)` status 和 send 的快捷键

[#](#路由机制源码解析) 路由机制源码解析
-----------------------

路由机制是 express 精髓。源码中，request、response、view 模块都清晰易懂，可能就是 router 这块容易让人看糊涂。这里对 express 路由机制源码做下个人整理：

### [#](#express与子路由有相同api) **express 与子路由有相同 API**

细心的读者可以发现，express 实例和 new Router() 有一样的 API：

*   `express/router.use(path, callback)`
*   `express/router.all/METHOD(path, callback)`。all 只是 METHOD 的合集，故分为一类
*   `express/router.route(path)`

这是因为 express 实例中保存着一个单例模式的主 Router 对象（下文都叫主路由），这就意味着 Router 有的 API 都可以在 express 实例上。源码在 application.js 的 [137 行 (opens new window)](https://github.com/expressjs/express/blob/master/lib/application.js#L137)：

### [#](#express-router-use-path-callback) **express/router.use(path, callback)**

use 方法一般用于执行中间件。这里为了方便理解，把一些参数处理等干扰代码省略了。我们可以很明显的看到，express.use 使用了主路由 use 方法。`所以简单理解express.use(args) = router.use(args)`

现在去看下 router 中 use 方法，同样去除一些参数处理等干扰代码。最终定义了 Layer 对象把路径和回调函数做了包装，并把 layer 压入 stack 中，方便调用时循环 stack 以执行匹配的回调函数。

### [#](#express-router-route-path) **express/router.route(path)**

该方法返回一个 Route 对象，注意是 Route 对象，不是 Router 对象。代码很简单，还是拿到主路由并调用主路由的 route 方法。

router.route 方法是每次新建一个 Route 对象（存储了定义的路由 METHOD 方法），同样经过 Layer 包装，压入 stack，并最终返回该 Route 实例。`所以简单理解，express.route(path) = new Route(path)`

重点讲下为什么需要 layer.route = route。`路由匹配的两个必备匹配条件：path路径 + method方法`。express.use 这种执行中间件方法只要求有 path 就可以；express.get/post/... 需要同时给到 path 和 method，express.get/post/... 底层都会调用 express.route 以得到一个 Route 实例。Route 实例存储了对应路由上哪些方法被注册，比如只有 get 方式可以匹配到。所以当实际匹配路由时，从 router 的 stack 遍历找到对应 layer 后，如果是中间件就不找了，如果是路由方法则需要通过 layer 找到对应 Route 实例，再继续匹配。

### [#](#express-router-all-method-path-callback) **express/router.all/METHOD(path, callback)**

该方法用于注册一个 get/post/... 路由。从源码中可以看出，先实例化一个 Route 对象，最终执行的是该对象的 METHOD 方法。`简单理解，express.get(args) = new Route().get(args)`

接下来让我们看下 Route 对象下的 METHOD 方法。该方法也对回调函数进行了包装并且也存入 stack 中。由此可知，`凡是路由机制API中有回调函数的，都会经过Layer进行包装。路由匹配到的时候会被调用`。

### [#](#路由匹配调用) **路由匹配调用**

在哪里判断是否匹配呢？从源码看你能得到 app.handle-->Router.handle。以下是抽取的主要代码以及详细注视，以下的代码解释中能理解上面提到的所有内容。随手画了个执行流程图： ![](https://user-images.githubusercontent.com/6310131/50197417-d8888180-0381-11e9-9f84-fdf2642e33db.png)

### [#](#总结) **总结**

*   Route 模块对应的是 route.js，主要是来处理路由信息的，每条路由都会生成一个 Route 实例。
*   Router 模块下可以定义多个路由，也就是说，一个 Router 模块会包含多个 Route 模块。
*   exress 实例化了一个 new Router()，实际上注册和执行路由都是通过调用 Router 实例的方法。类似于中介者模式
*   凡事有回调的都是用 Layer 对象包装，Layer 对象中有 match 函数来检验是否匹配到路由，handle_request 函数来执行回调
*   路由流程总结：当客户端发送一个 http 请求后，会先进入 express 实例对象对应的 router.handle 函数中，router.handle 函数会通过 next() 遍历 stack 中的每一个 layer 进行 match，如果 match 返回 true，则获取 layer.route，执行 route.dispatch 函数，route.dispatch 同样是通过 next() 遍历 stack 中的每一个 layer，然后执行 layer.handle_request，也就是调用中间件函数。直到所有的中间件函数被执行完毕，整个路由处理结束。

[#](#参考文章) 参考文章
---------------

*   [Express 源码学习 - 路由篇 (opens new window)](https://juejin.im/post/5ab545a66fb9a028b92d15e7)
*   [express 源码分析之 Router (opens new window)](https://cnodejs.org/topic/5746cdcf991011691ef17b88)