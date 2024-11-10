> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [cnodejs.org](https://cnodejs.org/topic/5757e80a8316c7cb1ad35bab)

最近公司在使用 node 做前后端分离，采用的 web 框架是 express，所以对 express 框架进行了深入的了解，前段时间写了篇关于 express 路由的文章，但是在那篇文章中貌似少了一个很重要的内容，就是 express 的 next，所以今天单独来说说 express 的 next。

关于 next 主要从三点来进行说明：

1.  next 的作用是什么？
2.  我们应该在何时使用 next？
3.  next 的内部实现机制是什么？

### Next 的作用

我们在定义 express 中间件函数的时候都会将第三个参数定义为 next，这个 next 就是我们今天的主角，next 函数主要负责将控制权交给下一个中间件，如果当前中间件没有终结请求，并且 next 没有被调用，那么请求将被挂起，后边定义的中间件将得不到被执行的机会。

### 何时使用 Next

从上边的描述我们已经知道，next 函数主要是用来确保所有注册的中间件被一个接一个的执行，那么我们就应该在所有的中间件中调用 next 函数，但有一个特例，如果我们定义的中间件终结了本次请求，那就不应该再调用 next 函数，否则就可能会出问题，我们来看段代码

```
app.get('/a', function(req, res, next) {
    res.send('sucess');
    next();
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  console.log(404);
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});
```

发送请求 "/a"，控制台打印日志如下：

```
GET /a 500 6.837 ms - -
Error: Can't set headers after they are sent.
    at ServerResponse.OutgoingMessage.setHeader (_http_outgoing.js:345:11)
```

为什么代码会抛异常呢，就是因为我们在 res.send 之后调用了 next 函数，虽然我们本次的请求已经被终止，但后边的 404 中间件依旧会被执行，而后边的中间件试图去向 res 的 headers 中添加属性值，所以就会抛出上边的异常。

读到这你可能会有个疑问，如果我不在 res.send 后边调用 next 函数，那后边定义的 404 中间件是不是永远都不会被执行到。现在我们删除 res.send 后边 next 函数调用，发送请求 "/xxx"，我们就会发现 404 中间件被执行了，(ㄒ o ㄒ)，这不是和我们之前说的矛盾了吗，我们的自定义中间件没有调用 next，但后边定义的中间件仍旧被执行了，这究竟是为什么呢。看来只能求助源码了～～～

### Next 的内部机制

```
function next(err) {
    ... //此处源码省略
    // find next matching layer
    var layer;
    var match;
    var route;

    while (match !== true && idx < stack.length) {
      layer = stack[idx++];
      match = matchLayer(layer, path);
      route = layer.route;

      if (typeof match !== 'boolean') {
        // hold on to layerError
        layerError = layerError || match;
      }

      if (match !== true) {
        continue;
      }
      ... //此处源码省略
    }
	... //此处源码省略
    // this should be done for the layer
    if (err) {
        layer.handle_error(err, req, res, next);
    } else {
	    layer.handle_request(req, res, next);
    }
  }
```

上边就是 express 中 next 的源码，为了更容易说明问题，对代码进行了删减。从上边的源码可以发现，next 函数内部有个 while 循环，每次循环都会从 stack 中拿出一个 layer，这个 layer 中包含了路由和中间件信息，然后就会用 layer 和请求的 path 就行匹配，如果匹配成功就会执行 layer.handle_request，调用中间件函数。但如果匹配失败，就会循环下一个 layer（即中间件）。

现在我们就能解释上边提出的问题了，为什么我们的自定义中间件中没调用 next 函数，但后边的 404 中间件仍旧会被执行到，因为我们请求的 "/xxx" 匹配不到我们注册的 "/a" 路由中间件，所以 while 循环会继续往下执行，匹配 404 中间件成功，所以会执行 404 中间件。

> 注意：app.use 注册的中间件，如果 path 参数为空，则默认为 "/"，而 path 为 "/" 的中间件默认匹配所有的请求。

有一点需要特别指出，其实我们在定义路由中间件的时候函数的第三个参数 next 和我们定义非路由中间件的函数的第三个参数 next 不是同一个 next，我们在上边看到的是非路由中间件的 next，而路由中间件的 next 函数是这样的

```
function next(err) {
    if (err && err === 'route') {
      return done();
    }

    var layer = stack[idx++];
    if (!layer) {
      return done(err);
    }

    if (layer.method && layer.method !== method) {
      return next(err);
    }

    if (err) {
      layer.handle_error(err, req, res, next);
    } else {
      layer.handle_request(req, res, next);
    }
  }
```

这个 next 比上边的那个 next 要简单很多，它负责同一个路由的多个中间件的控制权的传递，并且它会接收一个参数 "route"，如果调用 next (“route”)，则会跳过当前路由的其它中间件，直接将控制权交给下一个路由。

最后有必要再说一说 next (err)，next (err) 是如何将控制权传递到错误处理中间件的，从前边的代码我们知道，当调用 next (err) 是，express 内部会调用 layer.handle_error，那我们来看看它的源码

```
Layer.prototype.handle_error = function handle_error(error, req, res, next) {
  var fn = this.handle;

  if (fn.length !== 4) {
    // not a standard error handler
    return next(error);
  }

  try {
    fn(error, req, res, next);
  } catch (err) {
    next(err);
  }
};
```

代码中的 fn 就是中间件函数，express 会对 fn 的参数个数进行判断，如果参数个数不等于 4 则认为不是错误处理中间件，则继续调用 next (err)，这样就会进入到下一个中间件函数，继续进行参数个数判断，如此方式一直到某个中间件函数的参数个数是 4，就认为找到了错误处理中间件，然后执行此中间件函数。