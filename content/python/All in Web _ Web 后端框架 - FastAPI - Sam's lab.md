> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.samliu.tech](https://blog.samliu.tech/2021/11/20/all-in-web-web%e5%90%8e%e7%ab%af%e6%a1%86%e6%9e%b6-fastapi/)

> 有一个家用需求： 以 rest api 的形式发布一个服务（函数）访问这个服务需要验证，确切说是 token（JWT）认证访问这个服务的 request/response 数据需要被校验自带如何使用这个 api 的文档简单点官方文档详细丰富性能最不重要 python 实现的 就功能实现上，任何一个主流 web 后端框架都具备，但自动生成 api 使用文档，对数据校验方便直观，整体使用简单等，FastAPI 就具备这些. FastAPI 是一个基于 python 的 web 后端框架，使用起来开发效率高，更少的代码量；开发完毕后，会自动生成 API 使用文档，扔给对方就可以了；基于 pydantic，方便的对数据校验；更高的性能，支持 ASGI 规范，也就是支持异步，支持 WebSocket. 等等还有一些其他 web 后端框架，例如 Django: 重型 web 框架，功能强大，官方文档丰富，很适合开发正儿八经的 web 应用 Flask：中型 web 框架，web 应用，rest api 用途，都可以 Bottle: 微型 web 框架，用来做个 rest api 用途，再合适不过了，这个框架本身就一个单文件，没有任何其他依赖，也就是说在安装了 python 解释器的环境，把这个单文件拷贝过来就可以使用了，在一些 Network OS 里面，就是使用的这个框架对外提供简单的服务。

有一个家用需求：

*   以 rest api 的形式发布一个服务（函数）
*   访问这个服务需要验证，确切说是 token（JWT）认证
*   访问这个服务的 request/response 数据需要被校验
*   自带如何使用这个 api 的文档
*   简单点
*   官方文档详细丰富
*   性能最不重要
*   python 实现的

就功能实现上，任何一个主流 web 后端框架都具备，但自动生成 api 使用文档，对数据校验方便直观，整体使用简单等，FastAPI 就具备这些.

FastAPI 是一个基于 python 的 web 后端框架，使用起来开发效率高，更少的代码量；开发完毕后，会**自动生成 API 使用文档**，扔给对方就可以了；基于 pydantic，方便的对**数据校验**；更高的性能，**支持 ASGI 规范**，也就是支持异步，**支持 WebSocket**.

等等还有一些其他 web 后端框架，例如

Django: 重型 web 框架，功能强大，官方文档丰富，很适合开发正儿八经的 web 应用

Flask：中型 web 框架，web 应用，rest api 用途，都可以

Bottle: 微型 web 框架，用来做个 rest api 用途，再合适不过了，这个框架本身就一个单文件，没有任何其他依赖，也就是说在安装了 python 解释器的环境，把这个单文件拷贝过来就可以使用了，在一些 Network OS 里面，就是使用的这个框架对外提供简单的服务。

下面给出在官方的 demo 的基础上完善的代码，有需要拿过去再改改就可以跑生产：

```
from datetime import datetime, timedelta
from typing import Optional

from fastapi import Depends, FastAPI, HTTPException, status, Body
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt

from passlib.context import CryptContext

from pydantic import BaseModel

# https://fastapi.tiangolo.com/tutorial/security/oauth2-jwt/
# to get a string like this run in linux:
# openssl rand -hex 32
SECRET_KEY = "c4af8692b37bcf2d575c5958254eee21a049cf01925207beb8e4f02a5c0c9593"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# secret01
fake_users_db = {
    "johndoe": {
        "username": "johndoe",
        "full_name": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password": "$2b$12$X8w2pubd67dP8JsAijamkejzK1LIiY.JMTh7qAgscb9TVkSHkT0sy",
        "disabled": False,
    }
}

class Test01_data_model(BaseModel):
    infor: Optional[str] = None

class Test02_data_model(BaseModel):
    username: str
    MFAtoken: str
    addtion: Optional[str] = None

class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: Optional[str] = None


class User(BaseModel):
    username: str
    email: Optional[str] = None
    full_name: Optional[str] = None
    disabled: Optional[bool] = None


class UserInDB(User):
    hashed_password: str



pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# state this url-"\token" is used for get token only
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

app = FastAPI()



def verify_password(plain_password, hashed_password):

    return pwd_context.verify(plain_password, hashed_password)



# used for generating hash_password by plain_password
def get_password_hash(password):

    return pwd_context.hash(password)



def get_user(db, username: str):
    if username in db:
        user_dict = db[username]
        return UserInDB(**user_dict)



def authenticate_user(fake_db, username: str, password: str):

    user = get_user(fake_db, username)

    if not user:

        return False

    if not verify_password(password, user.hashed_password): # the former password is a plain,yes!!

        return False

    return user



def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(token: str = Depends(oauth2_scheme)):
    '''
    this function is used for verifying the token's expire time and get the user's infor
    '''
    print(token)
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM]) 
        '''
        # A token can be decode to be as the data was encoded before
        if the token has expired then it can not be decode and raise a 
        'ExpiredSignatureError('Signature has expired.')' error.
        payload = {'sub': 'johndoe', 'exp': 1634789405}
        '''
        print(payload)
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
        token_data = TokenData(username=username)
    except Exception as e:
        print(repr(e))
        raise credentials_exception
    user = get_user(fake_users_db, username=token_data.username)
    if user is None:
        raise credentials_exception
    return user


async def get_current_active_user(current_user: User = Depends(get_current_user)):
    if current_user.disabled:
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user




@app.post("/token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(fake_users_db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.username}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}


@app.get("/users/me/", response_model=User)
async def read_users_me(current_user: User = Depends(get_current_active_user)):
    return current_user


@app.get("/users/me/items/")
async def read_own_items(current_user: User = Depends(get_current_active_user)):
    return [{"item_id": "Foo", "owner": current_user.username}]


@app.get("/test01/", response_model=Test01_data_model, dependencies=[Depends(get_current_active_user)])
async def test01_app():
    return {"infor": "tokenttttttttt" }


@app.post("/test02/", dependencies=[Depends(get_current_active_user)])
async def test02_app(user_infor: Test02_data_model = Body(...)):
    print(user_infor.dict())
    return {"infor": user_infor }


if __name__ == '__main__':
    pass
    #import uvicorn
    #uvicorn.run(app='fastapi_token_demo:app', host="127.0.0.1", port=8000, reload=True, debug=True)
    #python -m uvicorn fastapi_token_demo:app --host '127.0.0.1' --port 8000 --reload
```

**一些说明如下:**

关于 Token 认证的流程：

当去访问一些服务时，如果直接使用用户凭据，当凭据泄露时，攻击者便可以登录你主页，拥有全部控制权，token 认证是指先用用户凭据认证一次，获取到一个字符串，其中被**编码了用户信息 sub** 和该字符串**超时信息 exp**，后续访问服务时，只需携带 token 即可，即使 token 泄露，影响是可控的，不同服务类别，获取不同的 token，并且 token 超时会自动失效，这个也是目前对 API 类应用访问的主流认证方式。

需要安装的库

```
pip install fastapi
pip install "uvicorn[standard]"  //work as the ASGI server that runs your code
pip install python-multipart  //get values from html form data
pip install "python-jose[cryptography]"  //generate and verify the JWT tokens
pip install "passlib[bcrypt]"  //handle password hashes
```

*   生成一个随机字符串，SECRET_KEY ，用于后续 JWT 的 encode 和 decode

*   关于 ACCESS_TOKEN_EXPIRE_MINUTES ，由于 JWT 没有回收机制，每次生成 token 后，只有等待超时才能过期，实际使用许谨慎设置过长的 token 超期时间，当然可以更改 SECRET_KEY 强制所有 token 报废。
*   fake_users_db ，实际使用可以从数据库 select 用户表信息
*   关于用户的 hashed_password，可以由下面定义的 get_password_hash 函数生产
*   get_current_user 函数中，调用了 jwt.decode 方法，用于解码 JWT 字符串，如果不是由同一个实例，jwt.encode 方法产生的，或者 exp 超时，会 raise 错误，这个 decode 的过程实际是完成了对 JWT 的认证过程。
*   关于 oauth2_scheme = OAuth2PasswordBearer(tokenUrl=”token”)，当被调用时，会检查 request 的`Authorization`header，如果该头部值是 Bearer+str（token），会取出该值，如果不符合条件，会向客户端返回 404error 和 UNAUTHORIZED 信息， oauth2_scheme 是包含 token 的字符串值，可以被其他需要 JWT 的函数 Depends。
*   fastapi 中引入 Depends()，让函数之间的依赖更直观，逻辑清晰；当 A 函数被声明依赖另一个 B 函数，A 运行时，会先运行 B，只有当 B 成功执行，为 True 时，A 函数才会继续，那么在所有需要 token 认证的函数下，声明依赖 get_current_active_user 即可，也即是依赖 get_current_user 函数的 jwt.decode 方法。
*   dependencies=[B,C] 用于声明多个依赖的语法
*   关于 async， 如果你定义的函数下有 IO 的操作，并且你**不清楚是否支持异步，请不要用 async 关键字**，没有 async，fastapi 会自动判断是否函数阻塞，如果阻塞，会调用线程池，但是如果在 async 函数下，引入了不支持异步的第三方 IO 库，妥妥变成同步！！

关于 request 传参，如果同时存在 fastapi 会依据以下特点判断对应关系

路径参数：url 路径，函数通过 参数名字识别，对应

查询参数：例如 get 方法，声明为 **singular type（**`int`,`float`,`str`,`bool`**）**的都为查询参数**，**

request Body: 对该参数定义了 **Pydantic model** 的，为 Body 数据，送到事先定义好的数据模型校验和转换，转成 json 后赋值给参数，不满足数据模型校验会返回客户端错误

```
openssl rand -hex 32
```

再给个[例子](https://link.zhihu.com/?target=https%3A//fastapi.tiangolo.com/tutorial/body-multiple-params/)：

```
from typing import Optional

from fastapi import FastAPI
from pydantic import BaseModel


class Item(BaseModel):
    name: str
    description: Optional[str] = None
    price: float
    tax: Optional[float] = None


app = FastAPI()


@app.put("/items/{item_id}")

async def create_item(item_id: int, item: Item, q: Optional[str] = None):

    result = {"item_id": item_id, **item.dict()}
    if q:
        result.update({"q": q})
    return result
```

需要传入的 json 格式

```
from typing import Optional

from fastapi import Body, FastAPI
from pydantic import BaseModel

app = FastAPI()


class Item(BaseModel):
    name: str
    description: Optional[str] = None
    price: float
    tax: Optional[float] = None


class User(BaseModel):
    username: str
    full_name: Optional[str] = None


@app.put("/items/{item_id}")
async def update_item(

    item_id: int, item: Item, user: User, importance: int = Body(...)

):
    results = {"item_id": item_id, "item": item, "user": user, "importance": importance}
    return results
```

**部署 + 测试**

```
{
    "item": {
        "name": "Foo",
        "description": "The pretender",
        "price": 42.0,
        "tax": 3.2
    },
    "user": {
        "username": "dave",
        "full_name": "Dave Grohl"
    },
    "importance": 5
}
```

启动后，会自动生成 API 相关文档

[http://x.x.x.x:8000/docs](https://link.zhihu.com/?target=http%3A//x.x.x.x%3A8000/docs)

这里使用用 Talend(postman) 测试

向 [http://x.x.x.x/token](https://link.zhihu.com/?target=http%3A//x.x.x.x/token) 发 post 请求，表单数据为

username:johndoe

password:secret01 // 取决你实际的 hashed_password 的明文

认证成功后会返回你一个 json，如下：

[![](https://blog-samliu-tech-1300751433.cos.ap-shanghai.myqcloud.com/wp-content/uploads/2022/07/v2-1701797d1c8d38f3a88ecf055024a687_r-1024x595.jpg)](https://blog-samliu-tech-1300751433.cos.ap-shanghai.myqcloud.com/wp-content/uploads/2022/07/v2-1701797d1c8d38f3a88ecf055024a687_r.jpg)Talend(postman) 工具

在后续的 request 中添加 HTTP 认证头部，带上 JTW

Authorization : Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJqb2huZG9lIiwiZXhwIjoxNjM3Mzk4MTEwfQ.apcFjARS2StEnOum3fCJOKWZ02vvaNzE-tsOQgz0pMU

通过 JWT 认证如下，get [http://x.x.x.x/users/me/](https://link.zhihu.com/?target=http%3A//x.x.x.x/users/me/)

[![](https://blog-samliu-tech-1300751433.cos.ap-shanghai.myqcloud.com/wp-content/uploads/2022/07/v2-b7a715bedfab1977df5959e50a160ebd_r-1024x558.jpg)](https://blog-samliu-tech-1300751433.cos.ap-shanghai.myqcloud.com/wp-content/uploads/2022/07/v2-b7a715bedfab1977df5959e50a160ebd_r.jpg)

**one more things:**

这部分谈谈完整的部署架构

web 后端框架—–WSGI/ASGI——-Ngnix/Apache——–Brower

这里区分下 Ngnix/Apache 和 uWSGI（Web Server Gateway Interface）的作用：

**web 框架只负责处理各种业务逻辑，uWSGI 负责接收 client 的网络请求**，调用（函数调用）web 框架处理请求，接收 web 框架的数据响应，返回数据给 client，uWSGI 和 web 框架间按照一定规则调用和被调用，共同完成对 client 的请求，这个规则的集合就是 WSGI，具体的实现之一是 uWSGI，由于标准化，**uWSGI 可以对接多种 web 框架**

![](https://pic4.zhimg.com/80/v2-8bf1d953da4ec02cae8fb8237cce4aa3_720w.jpg)

ASGI（_Asynchronous Server Gateway Interface_）是对 WSGI 标准的扩展，包含 WSGI 的全部特性，新增加了，websocket 协议，异步 的支持，具体的实现有 _Uvicorn，_

那么好像对于一个完整的访问，没有 Ngnix/Apache 这些组件的什么事，确实是！

在实际生产部署中，Ngnix/Apache 这类的组件可以算是对 uWSGI 和 _Uvicorn 一个助力，_

例如 对 uWSGI 和 Uvicorn server 的负载；接管来自 client 的请求中包含的静态资源的访问；实现 SSL offload；对 Client 请求的 URL 的拦截等等，其他‘动态’的资源，计算处理啊，数据库查询等请求会转发到 uWSGI 和 Uvicorn server。

![](https://pic4.zhimg.com/80/v2-0e5281b28bbeab3e070d0ba78b58ab0f_720w.jpg) ![](https://pic4.zhimg.com/80/v2-474306c46ef4fa4f9ea18c8b98bc0557_720w.jpg)

**fastapi 高性能部署架构：**

对于 WSGI web 框架，以上就是实际的部署架构了，但是对于 ASGI web 框架，如果要充分发挥高性能，高并发，就有一些改变了，GitHub 有一个项目，把该架构整体打包，作为一个 docker 镜像发布，方便大家使用

[https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker​github.com/tiangolo/uvicorn-gunicorn-fastapi-docker](https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker%E2%80%8Bgithub.com/tiangolo/uvicorn-gunicorn-fastapi-docker)

[![](https://blog-samliu-tech-1300751433.cos.ap-shanghai.myqcloud.com/wp-content/uploads/2022/08/image-14.png)](https://blog-samliu-tech-1300751433.cos.ap-shanghai.myqcloud.com/wp-content/uploads/2022/08/image-14.png) ![](https://pic1.zhimg.com/80/v2-0633bcc0c060d7f91b543e447ed9a574_720w.jpg)

fastapi—-ASGI——-WSGI—–Ngnix/Apache——–Brower

增加一层 WSGI 组件，使用的是 Gunicorn，另外一个 WSGI 的实现，ASGI 的实现是使用的 _Uvicorn，_

Gunicorn 的作用是当作一个进程管理器，管理多个 _Uvicorn 进程，提高并发，_

_说起来很复杂，但借助_ [tiangolo](https://link.zhihu.com/?target=https%3A//github.com/tiangolo)/[uvicorn-gunicorn-fastapi-docker](https://link.zhihu.com/?target=https%3A//github.com/tiangolo/uvicorn-gunicorn-fastapi-docker) 这个开源项目，部署和使用起来都非常简单

来试试看，假设你的业务代码已经准备好，放在本地 app 文件夹下

官方 GitHub 上提供了基于各个 python 版本的 docker 镜像，这次我选择 uvicorn+gunicorn+fastapi+python3.8 docker 镜像，剩下的只需要在把 app 文件夹和代码需要的第三方 python 库加入，重新 docker build 即可

假如我用 fastapi 发布了一个基于 selenium 库的 web 自动化功能，并且这个功能需要 fastapi token 认证，那么我的

**requirements.txt 文件如下：**

```
python -m uvicorn fastapi_token_demo:app --host '127.0.0.1' --port 8000 --reload
```

**Dockerfile 文件如下：**

```
selenium==3.141.0
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4
python-multipart==0.0.5
```

**我的文件目录如下：**

```
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8

LABEL maintainer="Sebastian Ramirez <tiangolo@gmail.com>"

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY ./app /app
```

_务必把 fastapi 主文件更改为 main.py_

```
.
|-- app
|   |-- main.py
|   |-- selenium_timesheet.py
|   `-- stealth.min.js
|-- Dockerfile
|-- README.md
`-- requirements.txt
```

以上。

Post Views: 162