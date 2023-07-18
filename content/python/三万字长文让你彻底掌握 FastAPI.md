> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s/b7-zb0FygFhiL6kfbNoazw)

**楔子**

随着 Python 的发展，与协程相关的 Web 框架也层出不穷，其中最受欢迎的莫过于 FastAPI。相比其它的协程框架，FastAPI 要更加的成熟，社区也更加的活跃。  

那么 FastAPI 都有哪些特点呢？

*   快速：拥有非常高的性能，归功于 Starlette 和 Pydantic；Starlette 用于路由匹配，Pydantic 用于数据验证；
    
*   开发效率：功能开发效率提升 200% 到 300%；
    
*   减少 bug：减少 40% 的因为开发者粗心导致的错误；
    
*   智能：内部的类型注解非常完善，IDE 可处处自动补全；
    
*   简单：框架易于使用，文档易于阅读；
    
*   简短：使代码重复最小化，通过不同的参数声明实现丰富的功能；
    
*   健壮：可以编写出线上使用的代码，并且会自动生成交互式文档；
    
*   标准化：兼容 API 相关开放标准；
    

FastAPI 最大的特点就是它使用了 Python 的类型注解，我们后面会详细说，下面来安装一下 FastAPI。

> 使用 FastAPI 需要 Python 版本大于等于 3.6

安装很简单，直接 pip install fastapi 即可，并且会自动安装 Starlette 和 Pydantic。然后还要 pip install uvicorn，因为 uvicorn 是运行相关应用程序的服务器。或者一步到位：pip install fastapi[all]，会将所有依赖全部安装。

  

**请求与响应**

我们来使用 FastAPI 编写一个简单的应用程序：  

```
from fastapi import FastAPIimport uvicorn# 类似于 app = Flask(__name__)app = FastAPI()# 绑定路由和视图函数@app.get("/")async def index():    return {"name": "古明地觉"}# 在 Windows 中必须加上 if __name__ == "__main__"# 否则会抛出 RuntimeError: This event loop is already runningif __name__ == "__main__":    # 启动服务，因为我们这个文件叫做 main.py    # 所以需要启动 main.py 里面的 app    # 第一个参数 "main:app" 就表示这个含义    # 然后是 host 和 port 表示监听的 ip 和端口    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

整个过程显然很简单，然后我们在浏览器中输入 localhost:5555 就会显示相应的输出。注意这里的视图函数，里面返回了一个字典，当然除了字典，其它的数据类型也是可以的，举个例子：

```
from fastapi import FastAPIimport uvicornapp = FastAPI()@app.get("/int")async def index1():    return 666@app.get("/str")async def index2():    return "古明地觉"@app.get("/bytes")async def index3():    return b"satori"@app.get("/tuple")async def index4():    return ("古明地觉", "古明地恋", "雾雨魔理沙")@app.get("/list")async def index5():    return [{"name": "古明地觉", "age": 17},             {"name": "古明地恋", "age": 16}]if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

这里我们直接使用 requests 发请求，测试一下。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb20npwvhm5CACPbHM94I7ZWNeFM5GEibOskOORgZ4QeoZBhZErAo0QYibw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

可以看到基本上都是支持的，只不过元组自动转成列表返回了。并且当前的路径是写死的，如果我们想动态声明路径参数该怎么做呢？

```
from fastapi import FastAPIimport uvicornapp = FastAPI()@app.get("/items/{item_id}")async def get_item(item_id):    """    和 Flask 不同，Flask 是使用 <>    而 FastAPI 使用 {}    """    return {"item_id": item_id}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2CtvAdwRy7mEUxkZheKpbVGbNdr94joebcGiav3SNITQgR5pAmz6xTsg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

整体非常简单，路由里面的路径参数可以放任意个，只是 {} 里面的参数必须要在视图函数的参数中出现。但是问题来了，我们好像没有规定类型啊，如果我们希望某个路径参数只能接收指定的类型要怎么做呢？

```
from fastapi import FastAPIimport uvicornapp = FastAPI()@app.get("/items/{item_id}")async def get_item(item_id: int):    """    和 Flask 不同，Flask 定义类型是在路由当中    也就是在 <> 里面，变量和类型通过 : 分隔        而 FastAPI 是使用类型注解的方式    此时的 item_id 要求一个整型    准确的说是一个能够转成整型的字符串    """    return {"item_id": item_id}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2ofLXeKElV8Ly111mKZH5vS6OM32aOxgE7XxZydjwv1iaM7J5HSevTYg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

如果我们传递的值无法转成整型的话，那么会进行提示：告诉我们 value 不是一个有效的整型，可以看到给的提示信息还是非常清晰的。

所以通过 Python 的类型声明，FastAPI 提供了数据校验的功能，当校验不通过的时候会清楚地指出没有通过的原因。在我们开发和调试的时候，这个功能非常有用。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

交互式文档

FastAPI 会自动提供一个类似于 Swagger 的交互式文档，我们输入 localhost:5555/docs 即可进入。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2moKpI5JckdfeGcplLomyyrU3n4crP0ETVlibon6FGIDicGaGTlEY27PA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

注意一下左上角的 /openapi.json，可以点进去，会发现里面包含了我们定义的路由信息。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2XBED7hEERTK8qrmDtuELhJVvVP9E7Z0wwtQJbt1BLO21or7h9N8TiaA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)浏览器的话，由于我这里没有安装解析 JSON 的插件，所以看起来很不舒服。因此推荐大家安装一个 JSON Viewer 插件，查看 JSON 数据时会很方便。

至于 localhost:5555/docs 页面本身，我们也是可以进行设置的：

```
from fastapi import FastAPIimport uvicornapp = FastAPI(title="测试文档",              description="这是一个简单的 demo",              docs_url="/my_docs",              openapi_url="/my_openapi")@app.get("/items/{item_id}")async def get_item(item_id: int):    return {"item_id": item_id}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

然后我们再重新进入，此时在浏览器里就需要输入 localhost:5555/my_docs：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2icpbrrNYQTJTWicg5RMUd5lxGhW3sJV2fDpR9EUvBwtRaWxGR7MqYmlQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

整体没什么难度，我们还可以指定其它参数，比如 version 等等，可以自己试试。该页面主要用来测试自己编写的 API 服务，不过个人更喜欢使用 requests 发请求。  

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

路由顺序

我们在定义路由的时候需要注意一下顺序，举个例子：

```
from fastapi import FastAPIimport uvicornapp = FastAPI()@app.get("/users/me")async def read_user_me():    return {"user_id": "the current user"}@app.get("/users/{user_id}")async def read_user(user_id: int):    return {"user_id": user_id}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

因为路径匹配是按照顺序进行的，所以这里要保证 /users/me 在 /users/{user_id} 的前面，否则的话只会匹配到 /users/{user_id}，这样的话访问 /users/me 就会解析错误，因为字符串 "me" 无法解析成整型。  

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1&retryload=2)

  

使用枚举

我们可以将某个路径参数通过类型注解的方式声明为指定的类型（准确的说是可以转成指定的类型，因为默认都是字符串），但如果我们希望它只能是规定的几个值之一，该怎么做呢？

```
from enum import Enumfrom fastapi import FastAPIimport uvicornapp = FastAPI()class Name(str, Enum):    satori = "古明地觉"    koishi = "古明地恋"    marisa = "雾雨魔理沙"@app.get("/users/{user_name}")async def get_user(user_name: Name):    return {"user_id": user_name}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

通过枚举的方式可以实现这一点，我们来测试一下：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2W5kJsfwqllKsNTwU48VLo6onprdStdFvLa3ykkT7lDqIQYckWubbRg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

结果和我们期望的是一样的，可以再来看看 docs 生成的文档：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2GInAZibEBNibvicvsZyO7qGIXw0wGKWmo8uC9xTFbexIFMicjyxQE3COBw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

可用的值都有哪些，也自动提示给我们了。  

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

路径中包含 /

假设我们有这样一个路由：/files/{file_path}，而用户传递的 file_path 中显然是可以带 / 的。假设 file_path 是 /root/test.py，那么路由就变成了 /files//root/test.py，显然这是有问题的。

那么为了防止解析出错，我们需要做一个类似于 Flask 的操作：

```
from fastapi import FastAPIimport uvicornapp = FastAPI()# 声明 file_path 的类型为 path# 这样它会被当成一个整体@app.get("/files/{file_path:path}")async def get_file(file_path: str):    return {"file_path": file_path}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

然后来访问一下：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb21w1uTS0JhbGgLFGL4K1SXMb7q7MbKa5GavA9zEf3LudIYrtI33c8Vw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

结果没有问题，如果不将 file_path 的格式指定为 path，那么解析的时候就会找不到指定的路由。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

查询参数

查询参数在 FastAPI 中依旧可以通过类型注解的方式进行声明，如果函数中定义了不属于路径参数的参数时，它们将会被解释为查询参数。

```
from fastapi import FastAPIimport uvicornapp = FastAPI()@app.get("/users/{user_id}")async def get_user(user_id: str, name: str, age: int):    """    我们在函数中定义了 user_id、name、age 三个参数    显然 user_id 和 路径参数中的 user_id 对应    然后 name 和 age 会被解释成查询参数    这三个参数的顺序没有要求，但一般都是路径参数在前，查询参数在后    """    return {"user_id": user_id, "name": name, "age": age}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

注意：name 和 age 没有默认值，这意味着它们是必须要传递的，否则报错。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2hOjL9IicPIQvTYuQFfJxibviaWatQWYY2cn4Bee2lDqgHuJLGvtxvibuHg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

我们看到当不传递 name 和 age 的时候，会直接提示你相关的错误信息。如果我们希望用户可以不传递的话，那么必须要指定一个默认值。

```
from fastapi import FastAPIimport uvicornapp = FastAPI()@app.get("/users/{user_id}")async def get_user(user_id: str,                    name: str = "UNKNOWN",                    age: int = 0):    return {"user_id": user_id, "name": name, "age": age}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2rj2XxCf6xWk66SibSb8qBqP5YmvNvTgXuicEDic8PvnFHDib5TRDpmYqVg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

这里使用了默认值，并且对于查询参数，由于它们指定了类型，所以我们也要传递正确类型的数据。假设给这里的 age 传递了一个 "abc"，那么是通不过的，因为它要求的是整型。

另外默认值的类型和指定的类型还可以不相同。

```
from fastapi import FastAPIimport uvicornapp = FastAPI()@app.get("/users/{user_id}")async def get_user(user_id: str,                   name: str = "UNKNOWN",                   age: int = "蛤蛤蛤"):    return {"user_id": user_id, "name": name, "age": age}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

这里的 age 需要接收一个整型，但默认值却是一个字符串，那么此时会有什么情况发生呢？我们来试一下：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2oCjRMcVdJFcISW0jy4leKuoSEWRvrUu9xHFbzF0klDibTTKe97yDcSg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

我们看到，传递的 age 依旧需要整型，只不过在不传的时候会使用字符串类型的默认值。所以指定的类型和默认值类型不相同，也是允许的，只不过这么做显然是不合理的。

此外我们还可以指定多个类型，比如让 user_id 按照整型解析、解析不成功时退化为字符串。

```
from typing import Union, Optionalfrom fastapi import FastAPIimport uvicornapp = FastAPI()@app.get("/users/{user_id}")async def get_user(user_id: Union[int, str],                   name: Optional[str] = None):    """    通过 Union 来声明一个混合类型，int 在前、str 在后    会先按照 int 解析，解析失败再变成 str    然后是 name，它表示字符串类型、但默认值为 None（不是字符串）    那么应该声明为 Optional[str]    """    return {"user_id": user_id, "name": name}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2icruIib2Tv5h8P09ov2NnRsVuZicQJnmiaUqiaLNTdkUwOn0C2EicibYic5ibDg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

所以 FastAPI 的设计还是非常不错的，通过 Python 的类型注解来实现参数类型的限定可以说是非常巧妙的，因此这也需要我们熟练掌握 Python 的类型注解。

这里补充一下，我当前的 Python 版本是 3.8，如果你用的是 3.10，那么类型注解还有不同的写法：

```
>>> from typing import Union, Optional# Optional[str] 和 str | None 等价>>> name: Optional[str] = "古明地觉">>> name: str | None = "古明地觉"# Union[int, str] 和 int | str 等价>>> age: Union[int, str] = 17>>> age: int | str = 17
```

这种写法在 3.10 才开始正式引入，但通过 from __future__ import annotations 也可以在 3.9 里面使用，而 3.8 是不支持的。

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

布尔类型自动转换

  

对于布尔类型，FastAPI 支持自动转换，举个例子：

```
@app.get("/{flag}")async def get_flag(flag: bool):    return {"flag": flag}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2o7MBmdWOYI8Amz7apGuuHsQgMg4hUjic75c7J7dBqhsmEdtxFGGK36A/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

多个路径和查询参数

前面说过，可以定义任意个路径参数，只要动态的路径参数 {} 在函数的参数中都出现即可。当然查询参数也可以是任意个，FastAPI 可以处理的很好。

```
@app.get("/postgres/{schema}/v1/{table}")async def get_data(schema: str,                   table: str,                   select: str = "*",                   where: Optional[str] = None,                   limit: Optional[int] = None,                   offset: Optional[int] = None):    """    标准格式是：路径参数按照顺序在前，查询参数在后    但 FastAPI 对顺序本身是没有什么要求的    """    query = f"select {select} from {schema}.{table}"    if where:        query += f" where {where}"    if limit:        query += f" limit {limit}"    if offset:        query += f" offset {offset}"    return {"query": query}
```

然后使用 requests 测试一下：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2TKQ88Q9kXNgartzhyQqbgzpGqI5RR2mq4pV7gKjzqdWuHQo9NLNzqg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

Depends

这个老铁比较特殊，它是用来做什么的呢？我们来看一下：

```
from typing import Optionalfrom fastapi import FastAPI, Dependsimport uvicornapp = FastAPI()async def common_parameters(        select: str = "*",        skip: int = 0,        limit: int = 100):    return {"select": select, "skip": skip, "limit": limit}@app.get("/items/")async def read_items(        commons: dict = Depends(common_parameters)):    # common_parameters 接收三个参数：select、skip、limit    # 因此会从请求中解析出 select、skip、limit 并传给 common_parameters    # 然后将 common_parameters 的返回值赋给 commons    # 但如果解析不到某个参数，那么会判断函数中参数是否有默认值    # 没有的话就会返回错误    return commons@app.get("/users/")async def read_users(        commons: dict = Depends(common_parameters)):    return commonsif __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

我们来测试一下：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2zNTjpKJwLEeu8FETFzR56miccwT6jpIJIkgYiarB02dV1W7HmEUuZicCg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

所以 Depends 能够很好地实现依赖注入，而且这里特意写了两个路由，就是想表明它们是彼此独立的。因此当有共享的逻辑、或者共享的数据库连接、增强安全性、身份验证、角色权限等需求时，会非常的实用。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

数据校验（针对查询参数）

FastAPI 支持我们进行更加智能的数据校验，比如一个字符串，我们希望用户在传递的时候只能传递长度为 6 到 15 的字符串该怎么做呢？

```
from typing import Optionalfrom fastapi import FastAPI, Queryimport uvicornapp = FastAPI()@app.get("/user")async def check_length(    # 默认值为 None，应该声明为 Optional[str]，当然声明 str 也是可以的    # 只不过声明为 str，那么默认值应该也是 str    # 所以如果允许一个类型的值为空，那么更规范的做法应该是声明为 Optional[类型]    password: Optional[str] = Query(None, min_length=6, max_length=15)):    return {"password": password}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

password 是可选的，但传递的时候必须传字符串、而且还是长度在 6 到 15 之间的字符串。所以在声明默认值的时候 None 和 Query(None) 是等价的，只不过 Query 还支持对参数进行额外的限制。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2zNa0N2Ok0iawaAAEBb5iaB8DxCXlwQ3hzfc4u42ficbf5lHvEanfODcoA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

Query 里面除了限制最小长度和最大长度，还有其它的功能：

```
@app.get("/user")async def check_length(    password: str = Query("satori", min_length=6,                           max_length=15, regex=r"^satori")):    """    此时 password 的默认值为 'satori'，并且传递的时候也必须要以 'satori' 开头    但值得注意的是 password 后面的类型注解是 str，不再是 Optional[str]    因为默认值不是 None 了，当然这里即使写成 Optional[str] 也是没有什么影响的    """    return {"password": password}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2icaINzlj1RkNQLvVa4HCk5ShyUOTP1lcqSghURGsTDDhlc9AWnlIuTQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

声明查询参数为必传参数

如果我们想让某个查询参数为必传参数，只需要不给它默认值就行了。

```
@app.get("/user")async def check_length(password: str):    return {"password": password}
```

函数里面的参数，要么是路径参数、要么是查询参数。显然 password 是一个查询参数，通过不指定默认值，我们即可实现它是一个必传参数。也就是在 URL 中，必须通过 ?password=xxx 的方式进行传递。  

虽然目的很简单，但我们发现此时无法对 password 进行限制了，比如希望它的长度是 6 到 15。那么问题来了，如何才能两者兼顾呢？

```
@app.get("/user")async def check_length(    password: str = Query(..., min_length=6,                          max_length=15)):      # 我们知道 Query 的第一个参数是 password 的默认值    # 但如果将 Query 的第一个参数换成 ...    # 那么 FastAPI 就不会再将它当成是默认值了    # 而是对 password 起一个限定作用，表示它是必传参数    return {"password": password}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2qwsx5Os33KSJQRSZKN6ia5ia0g5AuMibaMqr6z1uoDW9ia9rrCXibYQFbng/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

... 是 Python 的一个特殊的对象，可以了解一下，在 Numpy 里面也可以使用它。

最后再补充一点，我们也可以不使用 Query，将 password 的长度限制逻辑写在函数体里面也是一样的。

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

同时获取多个相同的查询参数

如果我们指定了 a=1&a=2，那么在获取 a 的时候，会得到什么呢？

```
from typing import Listfrom fastapi import FastAPI, Queryimport uvicornapp = FastAPI()@app.get("/items")async def read_items(        a1: str = Query(...),        a2: List[str] = Query(...),        b: List[str] = Query(...)):    return {"a1": a1, "a2": a2, "b": b}
```

我们访问一下，看看结果：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2HJCM72oSrOc2ZURcf8uWAv8VtPPuvJF2A7Z0UG2FAKUoZ795ic5uic4A/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

首先 a2 和 b 都是列表，会获取所有的值，但 a1 只获取了最后一个值。

另外可能有人觉得代码有点啰嗦，在函数声明中可不可以这样写呢？

```
@app.get("/items")async def read_items(        a1: str,        a2: List[str],        b: List[str]):    return {"a1": a1, "a2": a2, "b": b}
```

我们将 Query (...) 去掉了，因为它没有对参数做其它的限制，只是表示参数是一个必传参数。而不指定 Query (...)，那么本身就是一个必传参数，所以完全可以把 Query (...) 去掉。  

这种做法，对于 a1 来说是可行的，但对于 a2 和 b 来说不行。对于类型为 list 的查询参数，我们必须要显式的加上 Query (...) 来表示必传参数。如果允许为 None（或者有默认值）的话，那么应该这么写：

```
@app.get("/items")async def read_items(    a1: str,    a2: Optional[List[str]] = Query(None),    b: List[str] = Query(["1", "嘿嘿"])):    return {"a1": a1, "a2": a2, "b": b}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2Z8RHyRibtw5TTbksaHa56pwEibGx3icnbfao1OHYWExtL0tTib84vVVzwA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

给参数起别名

问题来了，假设我们定义的查询参数名叫 item-query，那么由于它要体现在函数参数中，而这显然不符合 Python 变量的命名规范，这个时候要怎么做呢？

```
@app.get("/items")async def read_items(    # 三个查询参数，分别是 item-query、@@@@、$$$$    # 但它们不符合 Python 变量的命名规范    # 于是要为它们起别名    item1: Optional[str] = Query(None, alias="item-query"),    item2: str = Query("哈哈", alias="@@@@"),    # item3 是必传的    item3: str = Query(..., alias="$$$$")  ):    return {"item-query": item1, "@@@@": item2, "$$$$": item3}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2kWrOZKpicG9Miaibj5iaTDEnwXAyFYFkZK6ZibygKd3mLJB3HK9R52sBDkA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

数值检测

Query 不仅仅支持对字符串的校验，还支持对数值的校验，里面可以传递 gt, ge, lt, le 等参数，相信这几个参数不用说你也知道是干什么的，我们举例说明：

```
@app.get("/items")async def read_items(    # item1 必须大于 5    item1: int = Query(..., gt=5),    # item2 必须小于等于 7    item2: int = Query(..., le=7),    # item3 必须等于 10    item3: int = Query(..., ge=10, le=10)):    return {"item1": item1,             "item2": item2,             "item3": item3}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2YVECDoYbhvK0LU2hOjpEDV8UUyv0Vr0uOibS931zMicxdEn3q5JKLiaQA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

Query 还是比较强大的 ，当然内部还有一些其它的参数是针对 docs 交互文档的，有兴趣可以自己了解一下。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

数据校验（针对路径参数）

对查询参数进行数据校验使用的是 Query，对路径参数进行数据校验使用的是 Path，两者的使用方式一模一样，没有任何区别。

```
from fastapi import FastAPI, Pathimport uvicornapp = FastAPI()@app.get("/items/{item-id}")async def read_items(    item_id: int = Path(..., alias="item-id")):    return {"item-id": item_id}
```

路径参数是必须的，它是路径的一部分，所以我们应该使用 ... 将其标记为必传参数。当然即使不标记也无所谓，就算指定了默认值也用不上，因为路径参数不指定压根就匹配不到相应的路由。至于一些其它的校验，和查询参数一模一样，所以这里不再赘述了。

不过我们之前说过，路径参数应该在查询参数的前面，尽管 FastAPI 没有这个要求，但是这样写明显更舒服一些。不过问题来了，如果路径参数需要指定别名，但是某一个查询参数不需要，这个时候就会出现问题：

```
@app.get("/items/{item-id}")async def read_items(    q: str,    item_id: int = Path(..., alias="item-id")):    return {"item_id": item_id, "q": q}
```

显然此时 Python 的语法就决定了 item_id 必须放在 q 的后面，当然这么做是完全没有问题的，FastAPI 对参数的先后顺序没有任何要求，因为它是通过参数的名称、类型和默认值声明来检测参数，而不在乎参数的顺序。但如果我们就要让 item_id 在 q 的前面要怎么做呢？

```
@app.get("/items/{item-id}")async def read_items(    *,    item_id: int = Path(..., alias="item-id"),    q: str,):    return {"item_id": item_id, "q": q}
```

此时就没有问题了，通过将第一个参数设置为 *，使得 item_id 和 q 都必须通过关键字参数传递，所以此时默认参数在非默认参数之前也是允许的。当然我们也不需要担心 FastAPI 传参的问题，你可以认为它所有的参数都是通过关键字参数的方式传递的。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

请求的载体：Request 对象

任何一个请求都对应一个 Request 对象，请求的所有信息都在这个 Request 对象中，FastAPI 也不例外。

```
from fastapi import FastAPI, Requestimport uvicornapp = FastAPI()@app.get("/girl/{user_id}")async def read_info(user_id: str,                    request: Request):    """    路径参数必须要体现在函数参数中    但是查询参数可以不写了    因为我们定义了 request: Request    那么请求相关的所有信息都会进入到这个 Request 对象中    """    header = request.headers  # 请求头    method = request.method  # 请求方法    cookies = request.cookies  # cookies    query_params = request.query_params  # 查询参数    return {"name": query_params.get("name"),             "age": query_params.get("age"),             "hobby": query_params.getlist("hobby")}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

通过 Request 对象可以获取请求相关的所有信息，我们之前参数传递不对的时候，FastAPI 会自动帮我们返回错误信息。但通过 Request 我们就可以自己进行解析、自己指定返回的错误信息了。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2nmNtvPHhsHSCC5OBam8PXL2p6Y7Uo0w77yQT7zHzfTWcN8uR10aREw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

FastAPI 重度依赖 Python 的类型注解，假设 request 参数的类型是 str，那么 FastAPI 就会认为 request 是一个普通的查询参数。但这里 request 的类型是 Request，那么 FastAPI 就知道它代表整个请求，于是会自动将请求的载体 Request 对象赋值给参数 request。

而通过 request，我们可以拿到所有的请求参数，非常方便。只是数据校验这一步就必须由我们手动做了，比如这里 name 没有做校验，客户端传递任何值都是合法的，并且不传递的话也会返回 None。但手动校验的好处就是自由程度要更高一些，当参数不合法时，我们可以自定制返回的错误信息，之前的错误信息都是 FastAPI 内部预定义好的。  

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

响应的载体：Response 对象

既然有 Request，那么必然会有 Response，虽然我们之前都是直接返回一个字典，但 FastAPI 实际上会帮我们转成一个 Response 对象。

Response 内部接收如下参数：

*   content：返回的数据；
    
*   status_code：状态码；
    
*   headers：返回的响应头；
    
*   media_type：响应类型（就是响应头里面的 Content-Type，这里单独作为一个参数出现了，其实通过 headers 参数设置也是可以的）；
    
*   background：接收一个任务，Response 在返回之后会自动异步执行（这里先不做介绍，后面会说）；
    

举个例子：

```
from fastapi import FastAPI, Request, Responseimport uvicornimport orjsonapp = FastAPI()@app.get("/girl/{user_id}")async def read_info(user_id: str,                    request: Request):    # 查询参数    query_params = request.query_params    data = {"name": query_params.get("name"),            "age": query_params.get("age"),            "hobby": query_params.getlist("hobby")}    # 实例化一个 Response 对象    response = Response(        # content，手动转成 json        orjson.dumps(data),        # status_code，状态码        201,        # headers，响应头        {"Token": "xxx"},        # media_type，就是 HTML 中的 Content-Type        # content 只是一坨字节流，需要告诉客户端响应类型        # 这样客户端才能正确的解析        "application/json",    )    # 拿到 response 的时候，还可以单独对响应头和 cookie进行设置    response.headers["ping"] = "pong"    # 设置 cookie 的话，通过 response.set_cookie    response.set_cookie("SessionID", "abc123456")    # 也可以通过 response.delete_cookie 删除 cookie    return response
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2kH57LbD87yNKiaicibibicq0D4qCvXsqUcUicCGdvT8ww5na3ONvxl8neqyQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

通过 Response 我们可以实现请求头、状态码、cookie 的自定义。另外除了 Response 之外还有很多其它类型的响应，比如：

*   FileResponse：用于返回文件；
    
*   HTMLResponse：用于返回 HTML；
    
*   PlainTextResponse：用于返回纯文本；
    
*   JSONResponse：用于返回 JSON；
    
*   RedirectResponse：用于重定向；
    
*   StreamingResponse：用于返回二进制流；
    

它们都继承了 Response，只不过会自动帮你设置响应类型，举个例子：

```
from fastapi import FastAPIfrom fastapi.responses import Response, HTMLResponseimport uvicornapp = FastAPI()@app.get("/index")async def index():    response1 = HTMLResponse("<h1>你好呀</h1>")    response2 = Response("<h1>你好呀</h1>",                          media_type="text/html")    # 以上两者是等价的，在 HTMLResponse 里面    # 会自动将 media_type 设置成 text/html    return response1
```

另外我们在开头说过，FastAPI 的请求与响应相关的功能，实际上是基于 starlette。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2BzJaGS7XWJmK0H0UP2KQGRoFsibwSpK6RI5HwaCN8hsexPeVrAZ2tmA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

请求载体 Request 和响应载体 Response 都是直接从 starlette 里面导入的。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

其它类型的请求与响应

FastAPI 除了 GET 请求之外，还支持其它类型，比如：POST, PUT, DELETE, OPTIONS, HEAD, PATCH, TRACE 等等。而常见的也就 GET, POST, PUT, DELETE，介绍完了 GET，我们来说一说其它类型的请求。

显然对于 POST、PUT 等类型的请求，我们必须要能够解析出请求体。

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

Model

在 FastAPI 中，请求体可以看成是 Model 对象，举个例子：

```
from typing import Optionalfrom fastapi import FastAPI, Responsefrom pydantic import BaseModelimport orjsonimport uvicornapp = FastAPI()class Girl(BaseModel):    """    数据验证是通过 pydantic 实现的    我们需要从中导入 BaseModel，然后继承它    """    name: str    age: Optional[str] = None    length: float@app.post("/girl")async def read_info(girl: Girl):    # girl 就是我们接收的请求体，它需要通过 json 来传递    # 并且这个 json 要有上面的三个字段（age 可以没有）    # 通过 girl.xxx 的方式我们可以获取和修改内部的所有属性    data = {"姓名": girl.name, "年龄": girl.age,            "身高": girl.length}    return Response(        orjson.dumps(data),        media_type="application/json"    )if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

我们访问一下：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2MYqE4MKSXg14OpFoIdITCucaEkJSVeO9z7VJeo4dI9FtGOmptI1VmA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

除了使用 pydantic，我们还可以手动验证：

```
@app.post("/girl")async def read_info(request: Request):    # 是一个协程，所以需要 await    data = await request.body()
```

我们说过 Request 对象是请求的载体，它包含了请求的所有信息，代码中的 data 便是请求体，并且是最原始的字节流形式。而它长什么样子呢？

首先在使用 requests 模块发送 post 请求的时候，数据可以通过 data 参数传递、也可以通过 json 参数传输。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2V8UjRAmRsmUmaXIFSXgZIHLahibQyhAFBVmkcfvr3w0k4XQHPQ9dMvA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

所以 await request.body() 得到的就是最原始的字节流，除了它之外还有 await request.json()，它在内部依旧会获取字节流，只不过获取之后会自动 loads 成字典。

因此使用 await request.json() 也侧面要求，我们在发送请求的时候必须使用 json 参数传递，否则无法正确解析。

```
@app.post("/girl")async def read_info(request: Request):    data = await request.body()    try:        # 解析成字典        data = orjson.loads(data)    except orjson.JSONDecodeError:        result = {"error": "请传递 JSON"}        return Response(            orjson.dumps(result),            status_code=404,            media_type="application/json"        )    result = {"name": data.get("name"),              "age": data.get("age"),              "length": data.get("length")}    return Response(        orjson.dumps(result),        media_type="Application/json"    )
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb26jaaLBcqrl6mXQhibPGmGr5C0Pa0q5Dhnnb5xSTgq22UpxoC7BdBEGw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

从 Request 对象解析出请求体之后，我们手动转成了字典，如果你对字段有要求的话，那么可以再单独进行判断。

就我个人而言，基本很少使用 pydantic 做数据验证，一般都是手动解析数据、进行验证。当数据不合法时，返回自定义的错误信息。

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

路径参数、查询参数、请求体

这几种不同的参数，我们可以混合在一起：

```
from typing import Optionalfrom fastapi import FastAPIfrom pydantic import BaseModelimport uvicornapp = FastAPI()class Girl(BaseModel):    name: str    age: Optional[str] = None    length: float@app.post("/girl/{user_id}")async def read_info(user_id,                    q: str,                    girl: Girl):    # user_id：路径参数，q：查询参数，girl：请求体     return {"user_id": user_id,            "q": q,             **dict(girl)}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2p565XEjGeZcLTwSNn5q3V11OHJElibebhhxW7Xs3eN4ta84LZicCJlsA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

里面同时指定了路径参数、查询参数和请求体，FastAPI 依然是可以正确区分的，当然我们也可以使用 Request 对象。

```
@app.post("/girl/{user_id}")async def read_info(user_id,                    request: Request):    # user_id 是路径参数，它一定要出现在视图函数中    # 并且没有限制类型，那么 user_id 可以是任意类型    # 然后查询参数和请求体，可以通过 request 获取    q = request.query_params.get("q")    # 请求体应该是一个 JSON    data = await request.json()    return {"user_id": user_id, "q": q, **data}
```

发请求的话，返回的内容是一样的。  

所以对于服务端而言，解析有两种方式。一种是体现在函数参数中，如果参数不对，FastAPI 会自动检测到，然后抛出预定义错误；而另一种则是使用 Request 对象，此时请求相关的全部信息都会被封装到这个对象中，然后我们手动解析，当参数不合法时，可以自定义返回的错误信息，可控性更高。

特别是当 JSON 的字段非常多的时候，定义 Model 比较麻烦，用 Request 对象会方便一些。举个例子：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2VXz081oPebspW1KR3Sfo6eWVGRb2psVFTr9AoOLiblJ1LMaKO5ej8CQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

如果发送的 JSON 里面有很多字段，每个字段的值的类型还不同，以及还包含 JSON 的嵌套等等。那么再通过定义 Model 的方式就很麻烦了，而通过 Request 拿到字节流之后再解析，就会方便很多。

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

Form 表单

我们调用 requests.post，如果参数通过 data 传递的话，则相当于提交了一个 form 表单，那么在 FastAPI 中可以通过 await request.form() 进行获取，注意：内部同样会先调用 await request.body()。

```
@app.post("/girl")async def read_info(request: Request):    form = await request.form()    return {"name": form.get("name"),            "age": form.getlist("age")}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb21lDtq5nDbC7OicLUH3ZnCkicpXxuJkeYogkWseAZCUTbNM8Ify4XQeIQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

而对于表单提交，FastAPI 还提供了另一种方式。

```
from fastapi import FastAPI, Formimport uvicornapp = FastAPI()@app.post("/user")async def get_user(username: str = Form(...),                   password: str = Form(...)):    return {"username": username,             "password": password}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2dy73O5LRztaFcqxZKrL3LIQvromqH3uW1icbdnLgpEmPsmZSuNJ5GVw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

像 Form 表单，查询参数、路径参数等等，都可以和 Request 对象一起使用，像上面的例子。如果再多定义一个参数 request: Request，那么仍然可以通过 await request.form() 拿到相关的表单信息。

```
@app.post("/user")async def get_user(*,                   username: str = Form(...),                   password: str = Form(...),                   request: Request):    form = await request.form()    return {"username": username,            "password": password}    # 两个 return 是等价的    return {"username": form.get("username"),            "password": form.get("password")}
```

所以如果你觉得某个参数不适合类型注解，那么可以单独通过 Request 对象进行解析，因为它是请求的载体，请求相关的一切信息都在里面。

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

文件上传

然后是文件上传功能，FastAPI 如何接收用户的文件上传呢？首先如果想支持文件上传，必须要安装一个包 python-multipart，直接用 pip 安装即可。

```
from fastapi import FastAPI, File, UploadFileimport uvicornapp = FastAPI()@app.post("/file1")async def file1(file: bytes = File(...)):    # 此时会以字节流的形式拿到文件的具体内容    return {"文件长度": len(file)}@app.post("/file2")async def file2(file: UploadFile = File(...)):    # 会拿到文件句柄    # 通过 await file.read() 可拿到文件内容    return {"文件名": file.filename,            "文件长度": len(await file.read())}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb2XWEMibicgIfKkCBlcynicn7ahHUcuXQlGgdxkGcMDSOdpry0FCtFKAPug/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

所以我们可以直接获取字节流，或者获取文件句柄。但如果是多个文件上传要怎么做呢？

```
from typing import Listfrom fastapi import FastAPI, UploadFile, Fileimport uvicornapp = FastAPI()@app.post("/file")async def file(files: List[UploadFile] = File(...)):    """    指定类型为列表即可    """    return [{"文件名": f.filename,             "文件长度": len(await f.read())}            for f in files]if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGND4UqmjdF3T9bHRibUOGb27ibPbDEwV1uHrMpgUh5wD1b2OGP7a0BYNcOiaDTvN4KMcgZXWnRSVmbg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

此时我们就实现了 FastAPI 文件上传，当然文件上传并不影响我们处理表单，可以自己试一下同时处理文件和表单。  

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

返回静态资源

再来看看 FastAPI 如何返回静态资源，首先我们需要安装 aiofiles，直接 pip 安装即可。

```
from fastapi import FastAPIfrom fastapi.staticfiles import StaticFilesimport uvicornapp = FastAPI()# name 参数只是起一个名字，FastAPI 内部使用app.mount("/static",          StaticFiles(directory=r"/Users/satori/Downloads/pics"),          , port=5555)
```

浏览器输入：localhost:5555/static/1.png，那么会返回指定目录下的 1.png 文件。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

APIRouter

APIRouter 类似于 Flask 的蓝图，可以更好地组织大型项目，举个例子：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGU2ZiaOf4ymjJeZqSuzvsymqSeU5ibiaQLRwwnNxg6PpJibO1epsbxL93e7fVaSL5B99lc4xRAXFQsfQ/640?wx_fmt=png)

在当前的工程目录中有一个 app 目录和一个 main.py，其中 app 目录里面有一个 app01.py，然后来看看它们是如何组织的。

```
# app/app01.pyfrom fastapi import APIRouterrouter = APIRouter(prefix="/router")# 以后访问的时候要通过 /router/v1 来访问@router.get("/v1")async def v1():    return {"message": "hello world"}# main.pyfrom fastapi import FastAPIfrom app.app01 import routerimport uvicornapp = FastAPI()# 将 router 注册到 app 中# 相当于 Flask 里面的 register_blueprintapp.include_router(router)if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

然后在外界便可以通过 /router/v1 的方式来访问。

**错误处理**

错误处理也是一个不可忽视的点，错误有很多种，比如：  

*   客户端没有足够的权限执行此操作；
    
*   客户端没有访问某个资源的权限；
    
*   客户端尝试访问一个不存在的资源；
    
*   ······
    

这个时候我们应该将错误通知给相应的客户端，这个客户端可以浏览器、代码程序、IoT 设备等等。

但是就我个人而言，更倾向于使用 Response 对象，将里面的 status_code 设置为 404，然后在返回的 json 中指定错误信息。不过 FastAPI 内部也提供了一些异常类：

```
from fastapi import FastAPI, HTTPExceptionimport uvicornapp = FastAPI()@app.get("/items/{item_id}")async def read_item(item_id: str):    if item_id != "foo":        # 里面还可以传入 headers 设置响应头        raise HTTPException(status_code=404,                             detail="item 没有发现")    return {"item": "bar"}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJ8Lnia8bpMFoL2P5iacicbqwQhCqbg1IxEmEKkkG1XWlfddJMRkfXQNs3g/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

HTTPException 是一个普通的 Python 异常类（继承了 Exception），它携带了 API 的相关信息。并且既然是异常，那么我们不能 return、而是要 raise。

个人觉得这个不是很常用，至少我本人很少用这种方式返回错误，因为它能够携带的信息太少了。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

自定义异常

上面使用的 HTTPException 是 FastAPI 内部提供的异常类，我们也可以自定义，但是定义完异常之后，还要定义一个 handler，将异常和 handler 绑定在一起，然后引发该异常的时候就会触发相应的 handler。

```
from fastapi import FastAPI, Requestfrom fastapi.responses import Responseimport uvicornimport orjsonapp = FastAPI()class ASCIIException(Exception):    """什么也不做"""# 通过装饰器的方式# 将 ASCIIException 和 ascii_exception_handler 绑定在一起@app.exception_handler(ASCIIException)async def ascii_exception_handler(request: Request,                                   exc: ASCIIException):    """    当引发 ASCIIException 的时候，    会触发 ascii_exception_handler 的执行    同时会将 request 和 exception 传过去    """    return Response(        orjson.dumps({"code": 404,                       "message": "必须传递 ascii 字符串"}),        status_code=404    )@app.get("/items/{item_id}")async def read_item(item_id: str):    if not item_id.isascii():        raise ASCIIException    return {"item": f"get {item_id}"}
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJAsib1UicjJRlPmbRnD3icKStRiaMUl9vFZtNVUAuYYYdiaOiajY9TmiaReVMA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

还是很简单的，另外关于 Request 和 Response，我们除了可以通过 fastapi 导入，还可以通过 starlette 导入，因为 fastapi 的路由映射是通过 starlette 来实现的。当然我们直接从 fastapi 里面导入即可。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

自定义 404

当访问一个不存在的 URL，我们应该提示用户，比如：您要找到页面去火星了。

```
from fastapi import FastAPIfrom fastapi.responses import Responsefrom fastapi.exceptions import StarletteHTTPExceptionimport uvicornimport orjsonapp = FastAPI()@app.exception_handler(StarletteHTTPException)async def not_found(request, exc):    return Response(        orjson.dumps(            {"code": 404,             "message": f"您要找的页面 {request.url} 去火星了。。。"}),        status_code=404    )
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJIuAYL5tKicQWsuVLt8iakHruicarILp5j3Ww0libY8EtIm1DoPASn8J5Xg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

此时访问一个不存在的 URL 时，就会返回我们自定义的 JSON 字符串。而参数 request，就是请求对应的 Request 对象，为了方便 IDE 提示，定义的时候可以加上一个类型注解。

**后台任务**

如果处理请求的时候需要执行一个耗时任务，那么可以将其放在后台执行，而 FastAPI 已经帮我们做好了这一步。来看一下：

```
import timefrom fastapi import FastAPI, BackgroundTasksfrom fastapi.responses import Responseimport uvicornimport orjsonapp = FastAPI()def send_email(email: str, message: str = ""):    """发送邮件，假设耗时三秒"""    time.sleep(3)    print(f"三秒之后邮件发送给 {email!r}, "          f"邮件信息: {message!r}")@app.get("/user/{email}")async def order(email: str, bg_tasks: BackgroundTasks):    """    这里需要多定义一个参数    此时任务就被添加到后台，当 Response 对象返回之后触发    """    # 可以添加任意多个任务    bg_tasks.add_task(send_email, email, message="这是一封邮件")    return Response(        orjson.dumps({"message": "邮件发送成功"})    )    # 我们在之前介绍 Response 的时候说过，里面有一个参数 background    # 所以我们还可以这么做    """    bg_tasks = BackgroundTasks() # 不在参数中定义 bg_tasks    bg_tasks.add_task(send_email, email, message="这是一封邮件")    return Response(        orjson.dumps({"message": "邮件发送成功"}),        background=bg_tasks    )    """
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJLcmS5gNSzic64pvFJxpWAmfoxuV4UKGPHl8FfBibujz0U9YibUFsH2NlQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

调用之后会立刻返回，然后我们看一下终端，会打印出如下信息：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJV09cuxHUGNz5hiax1NsmN08CEicZicxl9gWsDQqU92hzQXdqiaGGibGH7Ig/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

所以此时任务是被后台执行了的，注意：任务是在响应返回之后才后台执行。

而后台任务的实现原理也很简单，FastAPI 会将我们添加的任务依次丢到线程池里面运行，看一下源码就知道了，实现比想象中要简单很多。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJ3g4YWA9ozrJS6tLGwWzhichy850qdcbKSmFE8Sicpfzbd8ZNbu41lavg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

所以有些设计用起来感觉挺神奇的，但是看具体实现的话，会发现简单到不行。

**中间件**

中间件在 web 开发中可以说是非常常见了，说白了中间件就是一个函数或者一个类。

在请求进入视图函数之前，会先经过中间件（被称为请求中间件），在里面我们可以对请求进行一些预处理，或者实现一个拦截器等等；同理当视图函数返回响应之后，也会经过中间件（被称为响应中间件），在里面我们也可以对响应进行一些润色。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

自定义中间件

FastAPI 也支持像 Flask 一样自定义中间件，在 Flask 里面有请求中间件和响应中间件，但在 FastAPI 里面这两者合二为一了，我们看一下用法。

```
from fastapi import FastAPI, Request, Responseimport uvicornimport orjsonapp = FastAPI()@app.get("/")async def view_func(request: Request):    return {"name": "古明地觉"}@app.middleware("http")async def middleware(request: Request, call_next):    """    定义一个协程函数，然后使用 @app.middleware("http") 装饰    即可得到中间件    """    # 请求到来时会先经过这里的中间件    if request.headers.get("ping", "") != "pong":        response = Response(            content=orjson.dumps({"error": "请求头中缺少指定字段"}),            media_type="application/json",            status_code=404)        # 当请求头中缺少 "ping": "pong"        # 在中间件这一步就直接返回了，就不会再往下走了        # 所以此时相当于实现了一个拦截器        return response    # 如果条件满足，则执行await call_next(request)，关键是这里的 call_next    # 如果该中间件后面还有中间件，那么 call_next 就是下一个中间件；    # 如果没有，那么 call_next 就是对应的视图函数    # 这里显然是视图函数，因此执行之后会拿到视图函数返回的 Response 对象    response: Response = await call_next(request)    # 我们对 response 做一些润色，比如设置一个响应头    # 所以我们看到在 FastAPI 中，请求中间件和响应中间件合在一起了    response.headers["status"] = "success"    return response
```

我们可以测试一下：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJVkydQgeibs9eiaGgjgr1gcR2jscl98XS7yxia2caCgS2FibUW7KWGSSZ2g/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

测试结果也印证了我们的结论。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

内置的中间件

通过自定义中间件，我们可以在不修改视图函数的情况下，实现功能的扩展。但是除了自定义中间件之外，FastAPI 还提供了很多内置的中间件。

```
from fastapi import FastAPIfrom starlette.middleware.httpsredirect import HTTPSRedirectMiddlewarefrom starlette.middleware.trustedhost import TrustedHostMiddlewarefrom starlette.middleware.gzip import GZipMiddlewareimport uvicornapp = FastAPI()# 要求请求协议必须是 https 或者 wss，如果不是，则自动跳转app.add_middleware(HTTPSRedirectMiddleware)# 请求中必须包含 Host 字段，为防止 HTTP 主机报头攻击# 并且添加中间件的时候，还可以指定一个 allowed_hosts，那么它是干什么的呢？# 假设我们有服务 a.example.com, b.example.com, c.example.com# 但我们不希望用户访问 c.example.com，就可以像下面这么设置app.add_middleware(TrustedHostMiddleware,                   # 如果指定为 ["*"]，或者不指定 allow_hosts，则表示无限制                   allowed_hosts=["a.example.com", "b.example.com"])# 如果用户的请求头的 Accept-Encoding 字段包含 gzip# 那么 FastAPI 会使用 GZip 算法压缩# minimum_size=1000 表示当大小不超过 1000 字节的时候就不压缩了app.add_middleware(GZipMiddleware, minimum_size=1000)
```

除了这些，还有其它的一些内置的中间件，可以自己查看一下，不过不是很常用。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

CORS

CORS（跨域资源共享）过于重要，我们需要单独拿出来说。

随着前后端分离的流行，后端程序员和前端程序员的分工变得更加明确，后端只需要提供相应的接口、返回指定的 JSON 数据，剩下的交给前端去做。因此数据接入变得更加方便，但也涉及到了安全问题。

所以浏览器为了安全起见，设置了同源策略，要求前端和后端必须是同源的。而协议、域名以及端口，只要有一个不同，那么就是不同源的。比如下面都是不同的源：

*   http://localhost
    
*   https://localhost
    
*   http://localhost:8080
    

即使它们都是 localhost，但是它们使用了不同的协议或端口，所以它们是不同的源。如果前端和后端不同源，那么前端里面的 JavaScript 代码将无法和后端通信，此时我们就说出现了跨域。而 CORS 则是专门负责解决跨域的，让前后端即使不同源，也能进行数据访问。

假设你的前端运行在 localhost:8080，并且尝试与 localhost:5555 进行通信。然后浏览器会向后端发送一个 HTTP OPTIONS 请求，后端会返回适当的 headers 来对这个源进行授权。所以后端必须有一个「允许的源」列表，如果前端对应的源是被允许的，浏览器才会允许前端向后端发请求，否则就会出现跨域失败。

```
from fastapi import FastAPIfrom fastapi.middleware.cors import CORSMiddlewareimport uvicornapp = FastAPI()app.add_middleware(    CORSMiddleware,    # 允许跨域的源列表，例如 ["http://localhost:8080"]    # ["*"] 表示允许任何源    allow_origins=["*"],    # 跨域请求是否支持 cookie，默认是 False    # 如果为 True，allow_origins 必须为具体的源，不可以是 ["*"]    allow_credentials=False,    # 允许跨域请求的 HTTP 方法列表，默认是 ["GET"]    allow_methods=["*"],    # 允许跨域请求的 HTTP 请求头列表，默认是 []    # 可以使用 ["*"] 表示允许所有的请求头    # 当然下面几个请求头总是被允许的    # Accept、Accept-Language、Content-Language、Content-Type    allow_headers=["*"],    # 可以被浏览器访问的响应头, 默认是 []，一般很少指定    # expose_headers=["*"]    # 设定浏览器缓存 CORS 响应的最长时间，单位是秒    # 默认为 600，一般也很少指定    # max_age=1000)
```

以上即可解决跨域问题。

所以过程很简单，就是浏览器检测到前后端不同源时，会先向后端发送一个 OPTIONS 请求。然后从后端返回的响应的 headers 里面，获取上述几个字段，判断前端所在的源是否被允许，如果允许则发请求，如果不允许则跨域失败。

**FastAPI 的其它操作**

下面看一些 FastAPI 的其它操作，相当于是对前面内容的一个补充。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

其它种类的响应

我们前面介绍了如何返回不同格式的响应数据：

```
# 返回 JSON 数据（返回字典会自动转成 JSON）Response(orjson.dumps({"k": "v"}),         media_type="application/json",         status_code=200,         headers={"k": "v"})# 返回 HTMLResponse("<h1>古明地觉</h1>",         media_type="text/html",         status_code=200,         headers={"k": "v"})# 返回纯文本（此时 <h1> 不再是标签）Response("<h1>古明地觉</h1>",         media_type="text/plain",         status_code=200,         headers={"k": "v"})
```

但还剩下几种响应，我们再单独说一下。

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

返回重定向

  

```
from fastapi import FastAPIfrom fastapi.responses import RedirectResponseimport uvicornapp = FastAPI()@app.get("/index")async def index():    return RedirectResponse("https://www.bilibili.com")
```

页面访问 /index 会跳转到 bilibili。

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

返回字节流

  

```
from fastapi import FastAPIfrom fastapi.responses import StreamingResponseimport uvicornapp = FastAPI()async def some_video():    for i in range(5):        yield f"video {i} bytes ".encode("utf-8")@app.get("/index")async def index():    return StreamingResponse(some_video())
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJ4s10NzJQNoibMGjIbPyzq497J9X6AuzK6Zs4ppiaHfJwiceh5BIV3icpVA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

如果有文件对象，那么也是可以直接返回的。

```
from fastapi import FastAPIfrom fastapi.responses import StreamingResponseimport uvicornapp = FastAPI()@app.get("/index")async def index():    return StreamingResponse(open("main.py", encoding="utf-8"))if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJgjiayy2T0vB4WxP0dETrgMQWS0vcbh70Z9qUhZibChBeqBXJGcdCicRtQ/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

![](https://mmbiz.qpic.cn/mmbiz_gif/AibH5t526Kx33CC6gLCn4TAhK0epFVyGp66Gh8ibjqTc96S7dwgkjdJ4FkPQar6AyasopbcAh0xfyFpMeV5PX06w/640?wx_fmt=gif&wxfrom=5&wx_lazy=1)

返回文件

返回文件的话，可以通过 FileResponse，但介绍 FileResponse 之前，我们先额外补充一些内容。我们知道 Chrome 可以显示图片、音频、视频，但它们本质上都是字节流，Chrome 在拿到字节流的时候，怎么知道字节流是哪种类型呢？不用想，显然要通过 Content-Type。

```
# 我们可以返回图片、音频、视频，以字节流的形式# 但光有字节流还不够，我们还要告诉 Chrome# 拿到这坨字节流之后，应该要如何解析# 此时需要通过响应头里面的 Content-Type 指定Response(    b"picture | audio | video bytes data",    # png 图片："image/png"    # mp3 音频："audio/mp3"    # mp4 视频："video/mp4"    media_type="image/png")
```

通过 Content-Type，Chrome 就知道该如何解析了，至于不同格式的文件会对应哪一种 Content-Type，标准库也提供了一个模块帮我们进行判断。

```
from mimetypes import guess_type# 根据文件后缀进行判断print(guess_type("1.png")[0])print(guess_type("1.jpg")[0])print(guess_type("1.mp3")[0])print(guess_type("1.mp4")[0])print(guess_type("1.wav")[0])print(guess_type("1.flv")[0])print(guess_type("1.pdf")[0])"""image/pngimage/jpegaudio/mpegvideo/mp4audio/x-wavvideo/x-flvapplication/pdf"""
```

只要是 Chrome 支持的文件格式，通过返回文件的字节流，然后指定正确的 Content-Type，都可以正常显示在页面上。然后不知道你是否留意过，Chrome 有时候获取完数据之后，并没有显示在页面上，而是直接下载下来了。

那这是怎么做到的呢？

```
@app.get("/file1")async def get_file1():    # 读取字节流（任何类型的文件都可以）    with open("/Users/satori/Downloads/1.jpg", "rb") as f:        data = f.read()    # 返回的时候通过 Content-Type 告诉 Chrome 文件类型    # 尽管 Chrome 比较智能，会自动判断，但最好还是指定一下    return Response(data,                    # 返回的字节流是 jpg 格式                    media_type="image/jpeg")    # Chrome 在拿到字节流时会直接将图片渲染在页面上@app.get("/file2")async def get_file2():    with open("main.py", "rb") as f:        data = f.read()    # 在响应头中指定 Content-Disposition    # 意思就是告诉 Chrome，你不要解析了，直接下载下来    # filename 后面跟的就是文件下载之后的文件名    return Response(        data,        # 既然都下载下来了，也就不需要 Chrome 解析了        # 将响应类型指定为 application/octet-stream        # 表示让 Chrome 以二进制格式直接下载        media_type="application/octet-stream",        headers={"Content-Disposition": "attachment; file})
```

访问 localhost:5555/file1 会获取图片并展示在页面上；

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJQ6NMZ3mAx88Hsg0hmicJMKeky9t2sdzdxdoZpvFjpOheSFzXzclkMbw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

访问 localhost:5555/file2 会获取 main.py 的内容，并以文件的形式下载下来；

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJ20nIjaDnfbsN2VuJqdibGIreEK4oNOFO2tElPgnk3cqVsa5m87ERW9g/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

所以即使返回的内容是纯文本，也是可以下载下来的。

了解完上述内容之后，再看 FileResponse 就简单多了。  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJ8G45MdSHkyIWjHUFlNynBjzYdFoibGcTgCLRom4DtdplSlsDeutXNRA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

它默认是将文件下载下来，path 是文件路径，filename 是下载之后的文件名。如果你不想文件下载下来，而是直接显示在页面上，那么推荐使用 Response。  

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

HTTP 验证

如果当用户访问某个请求的时候，我们希望其输入用户名和密码来确认身份的话该怎么做呢？

```
from fastapi import FastAPI, Dependsfrom fastapi.security import HTTPBasic, HTTPBasicCredentialsimport uvicornapp = FastAPI()security = HTTPBasic()@app.get("/index")async def index(    credentials: HTTPBasicCredentials = Depends(security)):    username = credentials.username    password = credentials.password    if username != "satori" or password != "123456":        return {"error": "用户名密码错误"}    return {"username": credentials.username,             "password": credentials.password}if __name__ == "__main__":    uvicorn.run("main:app", host="0.0.0.0", port=5555)
```

访问 /index 页面之后，会提示输入用户名密码。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJKXKYLl4UHjic1jAmDIPPXibxN1RBoia3G3xBiaxM2oibcWO2D1libPRnpggg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

我们也可以用 requests 发请求。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJnORBPdHFvDicqHYohKx2UeqSDkrf0GsB2u3qc8qPNHhJkSISEoPeQ4g/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

输入完毕之后，用户名密码会保存在 credentials 里面，我们可以通过 username 和 password 字段取出来进行验证。

![](https://mmbiz.qpic.cn/mmbiz_png/HlNkQjetfwiaeG2eibibS4RBQY8AFicia9q36jicvERnwdOiatCCicr8H3m5do4ZANHLuqF8yiawknQEaR6LFmL7e97iazfA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

  

WebSocket

然后再来看看 FastAPI 如何实现 websocket：

```
from fastapi import FastAPIfrom fastapi.websockets import WebSocketimport uvicornapp = FastAPI()@app.websocket("/ws")async def ws(websocket: WebSocket):    await websocket.accept() # 等待建立连接    while True:        # websocket.receive_bytes()        # websocket.receive_json()        data = await websocket.receive_text()        await websocket.send_text(f"收到来自客户端的回复: {data}")
```

我们通过浏览器进行通信：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJfqIIoA93pK2IpibToETiak07Bv9VopXQErlZqlx3K4QGbCatvicCw4IAA/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

**FastAPI 的部署**

目前的话，我们算是介绍了 FastAPI 的绝大部分内容，最后再来看看 FastAPI 服务的部署。其实部署很简单，直接 uvicorn.run 即可，但是这里面有很多的参数，我主要是想要介绍这些参数。

```
def run(app, **kwargs):    config = Config(app, **kwargs)    server = Server(config=config)    ...    ...
```

我们看到 app 和 **kwargs 都传递给了 Config，所以我们只需要看 Config 里面都有哪些参数即可。这里选出一部分：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/ib8ibwulXslsGppCzvtHQ8bLCapEl5c6BJ13kicJoXHVyuTZ9NMp16sDKSnSJN1pW9LF8ianfXVoPPGod6icYala2Cw/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

有兴趣可以试一下这些参数，看看将参数设置为不同的值，FastAPI 会有什么表现。  

**小结**

总的来说，FastAPI 是一款非常成熟的协程框架，完全可以放在生产上使用。另外我们也清楚，性能的瓶颈基本不在框架上面，而是取决于数据库，所以在使用 FastAPI 的时候，还要搭配一个支持协程的驱动以及 ORM。

驱动的话推荐 asyncmy, asyncpg 等等，而 ORM 这里我推荐 SQLAlchemy（1.4 版本开始支持协程）。  

最后 FastAPI 还有一些第三方组件，比如后台管理、接口限流等等，有兴趣可以了解一下。