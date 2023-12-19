> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [tonybai.com](https://tonybai.com/2023/12/16/understand-oauth2-by-example/)

> 本文永久链接 - https://tonybai.com/2023/12/16/understand-oauth2-by-example 在之前的《通过实例理解 Go

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-1.png)

[本文永久链接](https://tonybai.com/2023/12/16/understand-oauth2-by-example) – https://tonybai.com/2023/12/16/understand-oauth2-by-example

在之前的《[通过实例理解 Go Web 身份认证的几种方式](https://tonybai.com/2023/10/23/understand-go-web-authn-by-example/)》和《[通过实例理解 Web 应用授权的几种方式](https://tonybai.com/2023/11/04/understand-go-web-authz-by-example/)》两篇文章中，我们对 Web 应用身份认证 (AuthN) 和授权 (AuthZ) 的几种方式做了介绍并配以实例增强理解。

在现实世界中，还有一大类的认证与授权是在前面的文章中没有作为重点介绍的，那就是 [OAuth2 授权](https://tools.ietf.org/html/rfc6749)与基于 OAuth2 之上的 [OpenID 身份认证 (OIDC, OpenID Connect)](https://openid.net/specs/openid-connect-core-1_0.html)。

近期接触到开放平台 (Open Platform) 的设计和开发，整个开放平台的授权流程都是基于 OAuth2 打造的，因此在这篇文章中，我就来先来通过实例详细说说 OAuth2，OIDC 将放在后面的文章中说明。

1. OAuth 是什么
------------

OAuth 中的 O 代表了 Open，OAuth 直译过来就是**开放授权**。[OAuth 是一个开放标准](https://en.wikipedia.org/wiki/OAuth)，允许用户让第三方应用访问该用户在某一网站上存储的私密的资源（如照片，视频，联系人列表等），而无需将用户名和密码提供给第三方应用。

OAuth 不是什么新技术了，其原型最早可追溯至 2006 年末，至今也快小 20 年了。但直到 2010 年 4 月，[OAuth 1.0 协议才以 RFC 5849 的形式正式发布](https://www.rfc-editor.org/rfc/rfc5849)。不过 OAuth 1.0 版本存在两个主要问题，一是当初设计时仅是为了 web 浏览器应用，随着应用类型的增多，一套授权机制难以应对现实中的所有场景，比如：Web 应用场景、移动 App 应用场景、官方应用场景等，因为这些场景不是完全相同的，这给使用者带去很多负面体验；二是一些安全性的问题 (这里就不展开了)。

2012 年 10 月，解决 OAuth 1.0 上述问题的 [OAuth 2.0 以 RFC 6749 发布](https://datatracker.ietf.org/doc/html/rfc6749)。OAuth 2.0 是 OAuth 协议的下一版本，但不向后兼容 OAuth 1.0。OAuth 2.0 关注客户端开发者的简易性，同时为 Web 应用、桌面应用、手机和智能设备定义了专门的授权许可流程，包括：授权码许可机制 (Authorization Code)、客户端凭据机制(Client Credentials)、资源拥有者凭据机制(Resource Owner Password Credentials) 和隐式许可机制(Implicit)。如今 OAuth 1.0 已经被废弃，谈到 OAuth 如无特殊说明，指的都是 OAuth2.0 版本。

在 OAuth2.0 的四种授权类型中，最安全的、最广泛使用的也是最常见的就是授权码许可机制 (Authorization Code) 了。本文后续的说明与示例也都是围绕授权码这种类型的。

2. OAuth2 解决了什么问题
-----------------

仅仅凭借上面关于 OAuth 的描述，你可能依然无法对 OAuth 有一个直观和深刻的理解，笔者第一次接触 OAuth 协议时也是花了不少时间才逐渐 “茅塞顿开”，当然本文参考资料中的那些书籍和资料 “功不可没”，尤其是 [OAuth 2.0 的 RFC 协议规范](https://datatracker.ietf.org/doc/html/rfc6749)。

那么 OAuth 到底解决的是什么问题？这里我们就用一个非常典型的示例来系统说说一下。

### 2.1 传统的云盘系统

现在有一个像百度网盘那样的云盘系统 (my-yunpan.com)，用户可以注册云盘系统的账号，然后将自己的个人数据文件，比如照片、音视频、文档等上传到云盘上保存。

假设这里有一个名为 tonybai 的用户注册了云盘，并将个人的一些照片文件上传到云盘上做保存和备份：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-2.png)

这是一个我们都可以理解的场景，用户注册云盘账号，然后登录云盘应用后将个人照片上传到云盘，这里使用的身份认证和授权技术方案没有超出《[通过实例理解 Go Web 身份认证的几种方式](https://tonybai.com/2023/10/23/understand-go-web-authn-by-example/)》和《[通过实例理解 Web 应用授权的几种方式](https://tonybai.com/2023/11/04/understand-go-web-authz-by-example/)》两篇文章的范畴。

针对这个场景，OAuth 定义了三个很容易理解的概念实体：

*   Resource Server：集中存储资源 (如用户照片等) 的服务，这个示例里就是云盘服务；
*   Resource owner：资源的拥有者，这里就是云盘的用户，比如图中的 tonybai；
*   Protected Resource：Resource owner 上传并存储在 Resource Server 中的 Resource，受 Resource Server 保护，这里对应的就是用户上传的照片。

大家先对这三个概念实体有个感性的认识即可，后续备用。

### 2.2 第三方的照片冲印服务

智能手机时代，数字照片 (Digital Photo) 将传统的基于胶卷的照片彻底拉下神坛。数字照片是存储在磁盘、手机中或云盘上的，但依然有很多人有将数字照片像传统照片那样冲印出来放在相册里或房间照片墙上欣赏的需求，于是就有了在线照片冲印服务(my-photo-print.com)。

用户注册在线照片冲印服务后，将自己的数字照片上传，交钱冲印即可，冲印好的照片便会经由快递送至用户家中，非常方便。

### 2.3 Resource Owner 要冲印照片

有一天，云盘用户 tonybai 要挑选一些近期存储在云盘中的照片进行冲印，他搜索到了 my-photo-print.com 这个第三方的照片冲印服务，但他需要在 my-photo-print.com 这个应用上重新注册一个账号，再将云盘上的照片下载后重新上传到 my-photo-print.com 这个服务的空间中才能实现在线冲印。这对于大多数像 tonybai 这样的用户而言并不是一个很 easy 的操作，体验上也是糟糕。tonybai 在思考：**我的照片已经在云盘上了，为什么不可以直接基于云盘上的照片进行冲印呢**？

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-3.png)

### 2.4 增加开放平台 (open.my-yunpan.com)

在 tonybai 萌生出这个困惑的同时，云盘的产品经理也同步感知到了这个需求，是时候给云盘系统增加开放平台了！这样，第三方应用便可以接入云盘系统，方便快捷地为云盘用户提供各种扩展服务，比如照片冲印、云上视听、数据智能管理等，这也是互联网界熟知的**生态建设的套路**。

下面是照片冲印服务 my-photo-print.com 注册和接入开放平台的示意图：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-4.png)

照片冲印服务 my-photo-print.com 注册和接入云盘开放平台后，会得到一个 client_id 和 client_secret，这两个字段是照片冲印服务接入云盘开放平台的凭据，即云盘开放平台对第三方应用进行身份认证的凭据。

不过即使照片冲印服务使用 client_id 和 client_secret 这个凭据通过了云盘系统的认证，照片冲印服务依然拿不到云盘系统上用户的照片数据，这里需要一个授权过程，即**云盘系统用户 (如前文提及的 tonybai) 告诉云盘系统是否允许照片冲印服务访问自己的数据**。

那么问题来了！如何实现云盘系统用户对已接入云盘系统的第三方应用的授权呢？下面我们就来探讨一下。

> 注：这里显然是打了个伏笔，一旦云盘系统建立了开放平台，那么云盘系统的用户对第三方应用的授权流程也就由开放平台规定好了。

### 2.5 云盘系统用户对第三方应用进行授权的方案

#### 2.5.1 凭据共享方案

一个最简单粗暴的方案就是直接用云盘系统用户的凭据代替用户去云盘系统读取该用户的数据，下面是该方案的示意图：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-5.png)

我们看到：照片打印服务想要获取用户的照片，它首先会提示用户输入其云盘系统上的用户名和密码，然后就会拿着用户的这些凭据合法地进入到该用户在云盘系统中的个人空间并拿到想要的数据。这也意味着用户在云盘系统上可以进行的任何操作，照片打印服务也都有权限进行。此外，一旦用户在多个网站应用上使用的是相同的用户名和密码，那么照片打印服务也可以通过拿到的凭据登录这些网站，并 “假扮” 用户获得这些网站上的用户数据。这种通过凭据共享来实现第三方应用访问云盘上的用户数据的方案显然是毫无安全底线可言。

#### 2.5.2 专用密码方案

现在你已经看到，共享用户密码并不是一个好方法，那会授予照片打印服务全局的访问权限，它就能代表由它指定的任何用户并访问云盘系统上的所有照片。那是否可以授予照片打印服务一个权限有限的专用密码来实现照片获取呢？此密码仅用于透露给第三方服务，用户自己并不会使用这个密码来登录，只是将它粘贴到所使用的第三方应用里 (如下图)：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-6.png)

这是一个可行的方案，但这种方案的可用性并不好。它要求用户除了管理自己的主登录密码之外，还要创建 (在云盘系统中)、分发(贴到照片打印服务系统中) 和管理特殊的凭据。并且，用户管理这些凭据时一般不会区分专用凭据与第三方应用的对应关系，往往是建立一个新专用凭据后，贴到所有第三方应用中使用，这使得撤销某个具体第三方应用的访问权限变得很困难。让用户科学管理这些凭据，本身就给用户带来了心智负担，也可理解为一种不好的体验。

不过，相对于凭据共享方案的不安全，专用密码方案已经是有所进步了，但还远非理想。

### 2.6 OAuth2 授权方案

前面无论是共享凭据还是专用密码方案，都绕开了开放平台，这显然是故意为最终理想方案的出炉做铺垫的 — 没有差方案，如何才能体现出理想方案的好呢！– **是时候叫出超级飞侠了**！。

这就是我们提到的 OAuth2 授权方案。OAuth 协议的设计目的是：让用户 (Resource owner，比如 tonybai) 通过 OAuth 协议将他们在受保护资源 (Protected Resource，比如照片) 上的部分权限委托给第三方应用(比如照片冲印服务)，使第三方应用能代表他们执行操作。这个方案既要考虑提升用户的使用体验，也要考虑提升方案整体的安全性。为实现这些，OAuth 在流程中引入了另外一个组件：授权服务器（Authorization Server)。

如果我们将第三方应用 (比如照片冲印服务) 称为 client(客户端应用)，加上授权服务器（Authorization Server)以及前面提到的三个概念：Resource Server、Resource owner 和 Protected Resource，我们就有了 5 个实体。他们究竟是什么关系呢，又是如何交互的呢？这就是 OAuth2.0 协议的核心内容。下图是来自 OAuth2.0 RFC 中的抽象协议流程图，为了好理解，我在图中加入了各个实体对应的示例中的名字：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-7.png)

这是一个抽象图，我们无法从中看出各个流程的细节，但大致可以看出 OAuth2 授权的关键环节：

*   client(客户端应用，如照片冲印服务)需要用户 (Resource owner) 的授权，但这个授权过程，用户不会将密码等凭据暴露给 client；
*   client 凭借授权信息到授权服务器 (Authorization server) 换取 access token；
*   client 凭借 access token 访问用户 (Resource owner) 在 Resource Server(比如云盘系统)上的 Resource 数据(比如照片)。

接下来，我们来看看细节，我们使用 OAuth2 中最广泛使用的授权码方案 (Authorization code) 来展示这个流程，下面是来自 OAuth2.0 RFC 中的授权码方案流程图：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-8.png)

这个流程图依然很抽象，我们用下面的 “分解动作” 来解释。

#### 2.6.1 用户 (Resource Owner) 通过浏览器访问第三方应用(Client，my-photo-print.com)

用户要想使用第三方应用，比如 my-photo-print.com 服务来冲印自己位于云盘上的照片，他首先要访问到这个第三方应用，如下图所示：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-9.png)

用户通过浏览器 (User Agent) 打开 my-photo-print.com 服务的登录页面，这个页面除了提供使用用户名 / 密码登录之外，还提供了 “使用云盘账号” 的按钮。该用户不想重新注册一遍 my-photo-print.com 服务的账号，选择了点击 “使用云盘账号” 按钮。

#### 2.6.2 用户 (Resource Owner) 被引导到云盘开放平台登录并对第三方应用进行授权

当用户点击 “使用云盘账号” 按钮后，对第三方应用进行授权过程便正式开始，下面是一个示意图：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-10.png)

OAuth2.0 的授权码模式的第一步便是第三方应用 (Client) 需要将用户 (Resource Owner) 引导到云盘开放平台 (Authorization Server) 的登录页面 (/oauth/portal)，为用户授权做好准备。在图中第三方应用 my-photo-print.com 通过网页 html 内重定向让用户的浏览器(User Agent) 重定向到云盘开放平台的授权门户页面，在重定向的请求中，Client 带上了自己的一些参数(比如 client_id、scope 等)。

云盘开放平台 (Authorization Server) 返回一个用户登录页面，用户 (tonybai) 输入用户名密码以供 Authorization Server 做身份认证。注意这个过程完全没有 client(照片冲印服务)的参与，用户名和密码不会泄露给第三方。

当用户 (如 tonybai) 点击 submit 提交凭据信息时，可以向服务端请求，也可以像图中简化版那样直接给出授权范围的提示。弹出的框提示“照片冲印服务需要用户授予两个权限”，如果用户点击“授权”，则会向 Authorization Server 发起授权请求，连同用户的登录凭据一起，授权请求的路径与参数如下(也可以使用表单提交的方式提交授权请求)：

```
/oauth/authorize?response_type=code&client_id=my-photo-print&state=xyz123&scope=user_info,read_photos&redirect_uri=http%3A%2F%2Fmy-phone-print.com%3A8080%2Foauth%2Fcb
```

response_type=code 表示用户向授权平台请求一个授权码，再强调一下：**这个授权码是用户 (如 tonybai) 去申请的**，而不是 client(第三方应用)，后续也是由用户将 code 告知 client(第三方应用)。

cilent_id 表示为哪个第三方应用申请的，后续授权平台在发 access_token 时，可以基于该 client_id 进行校验。

scope 是此次授权的权限列表。

redirect_uri 是一个重定向地址，这个地址可以在请求中传递，如果不传递，也可以在 client 注册开放平台账号时，提供给开放平台 (Authorization Server)。

state 是一个随机数，OAuth 2.0 官方建议使用 state 以避免 CSRF 攻击。

#### 2.6.3 用户提供 code，client 用 code 换取 access_token 并读取用户数据

如果 Authorization Server 通过了用户的请求，便会在应答中带上这次分配给用户的授权码 (code)，这个授权码是一次性的，一旦使用便会作废，当然 Code 也会有时效性，一般就是几分钟。

我们继续看下面图示的分解动作吧：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-11.png)

首先，Authorization Server 对用户的请求校验通过后，便会分配授权码，并通过下面这个应答返回给用户 (浏览器)：

```
HTTP/1.1 302 Found
Location: http://my-phone-print.com:8080/oauth/cb?code=SplxlOBeZQQYbYS6WxSbIA&state=xyz123
```

用户的浏览器收到这个应答后便会重定向到 Location 这个地址，这个过程其实是在**模拟用户向 Client(照片冲印服务) 提供 code 的行为**。

当 Client(照片冲印服务)收到收到用户的 code 后，它会立即使用这个 Code 并结合自己的凭据 (client_id 和 client_secert) 向 Authorization Server 申请 access_token：

```
POST /oauth/token HTTP/1.1
Host: open.my-yunpan.com:8081
Authorization: Basic base64(client_id:client_secret)
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code&code=SplxlOBeZQQYbYS6WxSbIA&redirect_uri=http%3A%2F%2Fmy-phone-print.com%3A8080%2Foauth%2Fcb
```

这是一个 client 发向 Authorization Server 的 POST 请求，请求参数中，除了固定的 grant_type=authorization_code 以及 code 之外，还带了 redirect_uri，这个 redirect_uri 是供 Authorization Server 校验使用的。此外这个请求是以 Client 身份申请的，所以在 http header 中带上了 client 自己的凭据信息：client_id 和 client_secert，这里使用的是 http basic auth。

Authorization Server 对请求验证通过后，便会给出 Post 应答，access_token 等信息都放在应答的包体中：

```
{
       "access_token":"2YotnFZFEjr1zCsicMWpAA",
       "token_type":"example",
       "expires_in":3600,
       "refresh_token":"tGzv3JOkF0XG5Qx2TlKWIA",
       "example_parameter":"example_value"
}
```

这里除了包含 access_token，还包含了它的过期时间 (expires_in) 以及一个 refresh_token，client 可以使用 refresh_token 在 access_token 过期前换取一个新的 access_token。但从安全角度考虑，client 不能无限制的换取新 token，所以 refresh_token 也会被过期时间。一旦 refresh_token 过期了，那么 client 就要重新发起一次用户授权过程。

当 client 收到 access_token 后，便可以拿着这个 access_token 到 Resource Server(这里是 my-yunpan.com)去获取用户 (tonybai) 的个人资料与照片数据了：

```
POST /photos HTTP/1.1
Host: my-yunpan.com:8082

method=listall&access_token=2YotnFZFEjr1zCsicMWpAA
```

my-yunpan.com 验证 access_token 后，便会将 tonybai 的照片列表返回给 client，然后 client 会返回重定向应答给用户的浏览器。用户浏览器收到重定向应答后，便会向 client(照片冲印服务) 的 / photos 端点发起请求，之后便可以在浏览器上看到自己的照片列表了。用户选择要冲印的照片后，创建订单冲印即可。

从用户提交 code 给 client，到用户浏览器显示照片列表，这中间用户可能会有短暂的等待，毕竟 client 要与 Authorization Server 和 Resource server 进行多次交互，用户浏览器也要进行重定向操作。

现在将 “分解动作” 与 OAuth2.0 RFC 中的授权码方案流程图结合在一起看，你将会对 OAuth 有更深刻的理解。

> 注：OAuth2 授权流程原则上是要建立在 HTTPS 建立的安全通道之上的，这里仅是示例，我们聚焦的是 OAuth2 流程，所以将使用 HTTP 进行展示。

3. 示例的具体实现
----------

下面我们用 Go 语言编写一个可以简单演示 OAuth2.0 授权流程的示例，该示例与上面描述的 OAuth2 的 “分解动作” 基本是可以对应起来的。

示例由三个服务构成：my-photo-print 照片冲印服务、my-yunpan 云盘服务以及 open-my-yunpan 云盘开放平台 / 授权服务，示例对应的目录结构如下：

```
$tree -L 1 -F oauth2-examples
oauth2-examples
├── my-photo-print/
├── my-yunpan/
└── open-my-yunpan/
```

在开始编写服务前，我们需要修改一下本机 (MacOS 或 Linux) 的 / etc/hosts 文件：

```
127.0.0.1 my-photo-print.com
127.0.0.1 my-yunpan.com
127.0.0.1 open.my-yunpan.com
```

> 注：由于示例中较少使用到 js，且 form action 的地址也是同源的，并且通过重定向来跳转，所以基本不涉及到[跨域问题](https://tonybai.com/2023/11/19/understand-go-web-cross-origin-problem-by-example/)。
> 
> 注：在演示下面步骤前，请先进入到 oauth2-examples 的各个目录下，通过 go run main.go 启动各个服务程序 (每个程序一个终端窗口)。

### 3.1 用户使用 my-photo-print.com 照片冲印服务

按照流程，用户首先通过浏览器打开照片冲印服务的首页：http://my-photo-print.com:8080，如下图：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-12.png)

这个页面是由 homeHandler 提供的：

```
// oauth2-examples/my-photo-print/main.go

// 照片冲印主页，引导用户去授权平台
func homeHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Println("homeHandler:", *r)

    // 渲染首页页面模板
    var state = randString(6)
    mu.Lock()
    stateCache[state] = struct{}{}
    mu.Unlock()
    tmpl := template.Must(template.ParseFiles("home.html"))
    data := map[string]interface{}{
        "State": state,
    }
    tmpl.Execute(w, data)
}
```

这里我们使用了服务端模板渲染，并将渲染的结果作为应答发给浏览器，home.html 模板的内容如下：

```
// oauth2-examples/my-photo-print/home.html

<!DOCTYPE html>
<html>
<head>
  <title>照片冲印服务</title>
</head>
<body>

  <h3>欢迎使用照片冲印服务!</h3>

  <div>
    用户名: <input />
    密码: <input />
    <button>登录</button>
  </div>

  <button id="auth-btn">使用云盘账号登录</button>

  <script>
    var authBtn = document.getElementById('auth-btn');
    authBtn.addEventListener('click', function() {
      var clientId = 'my-photo-print';
      var scope = 'user_info,read_photos';
      var state = '{{.State}}';
      var url = 'http://open.my-yunpan.com:8081/oauth/portal?client_id=' + clientId + '&scope=' + scope+'&state=' + state + '&redirect_uri=http%3A%2F%2Fmy-photo-print.com%3A8080%2Foauth%2Fcb'
      window.location.href = url;
    })
  </script>
</body>
</html>
```

当用户选择并点击 “使用云盘账号登录” 时，浏览器将打开云盘开放平台 / 授权服务的首页(http://open.my-yunpan.com:8081/oauth/portal)。

### 3.2 使用 open.my-yunpan.com 进行授权

下面是云盘开放平台 / 授权服务的首页：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-13.png)

这个页面由 open.my-yunpan.com 的 portalHandler 提供：

```
// oauth2-examples/open-my-yunpan/main.go

func portalHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Println("portalHandler:", *r)

    // 获取请求参数用于渲染应答html页面
    clientID := r.FormValue("client_id")
    scopeTxt := r.FormValue("scope")
    state := r.FormValue("state")
    redirectURI := r.FormValue("redirect_uri")

    // 渲染授权页面模板
    tmpl := template.Must(template.ParseFiles("portal.html"))
    data := map[string]interface{}{
        "AppName":     clientID,
        "Scopes":      strings.Split(scopeTxt, ","),
        "ScopeTxt":    scopeTxt,
        "State":       state,
        "RedirectURI": redirectURI,
    }
    tmpl.Execute(w, data)
}
```

和照片冲印服务首页一样，这里同样使用了模板渲染的应答页面，对应的 portal.html 模板的内容如下：

```
<!DOCTYPE html>
<html>
    <head>
        <title>云盘授权页面</title>
    </head>
    <body>

        <h3>云盘授权页面</h3>

        <p>
            应用{{.AppName}}正在请求获取以下权限:
            <ul>
                {{range .Scopes}}
                <li>{{.}}</li>
                {{end}}
            </ul>
        </p>

        <form id="authorization-form" method="post" action="/oauth/authorize">
            <div>
                用户名:
                <input  />
                密码:
                <input  />
                <input type="hidden"  />
                <input type="hidden" {{.AppName}}" />
                <input type="hidden" {{.ScopeTxt}}" />
                <input type="hidden" {{.State}}" />
                <input type="hidden" {{.RedirectURI}}" />
                <button type="submit">授权</button>
            </div>
        </form>

    </body>
</html>
```

该页面将照片冲印服务要获得的权限以列表形式展示给用户，然后提供了一个表单，用户填写用户名和密码后，点击 “授权”，浏览器便会向开放平台授权服务的”/oauth/authorize” 发起 post 请求以获取 code，post 请求携带了一些 form 参数，像 response_type、client_id、scope、state 等。

“/oauth/authorize” 端点由 authorizeHandler 负责处理：

```
// oauth2-examples/open-my-yunpan/main.go

func authorizeHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Println("authorizeHandler:", *r)

    responsTyp := r.FormValue("response_type")
    if responsTyp != "code" {
        w.WriteHeader(http.StatusBadRequest)
        return
    }

    user := r.FormValue("username")
    password := r.FormValue("password")

    mu.Lock()
    v, ok := validUsers[user]
    if !ok {
        fmt.Println("not found the user:", user)
        mu.Unlock()
        w.WriteHeader(http.StatusNonAuthoritativeInfo)
        return
    }
    mu.Unlock()

    if v != password {
        fmt.Println("invalid password")
        w.WriteHeader(http.StatusNonAuthoritativeInfo)
        return
    }

    clientID := r.FormValue("client_id")
    scopeTxt := r.FormValue("scope")
    state := r.FormValue("state")
    redirectURI := r.FormValue("redirect_uri")

    code := randString(8)
    mu.Lock()
    codeCache[code] = authorizeContext{
        clientID:    clientID,
        scopeTxt:    scopeTxt,
        state:       state,
        redirectURI: redirectURI,
    }
    mu.Unlock()

    unescapeURI, _ := url.QueryUnescape(redirectURI)
    redirectURI = fmt.Sprintf("%s?code=%s&state=%s", unescapeURI, code, state)
    w.Header().Add("Location", redirectURI)
    w.WriteHeader(http.StatusFound)
}
```

authorizeHandler 会对用户进行身份认证，通过后，它会分配 code 并向浏览器返回重定向的应答，重定向的地址就是照片冲印服务的回调地址：http://my-photo-print.com:8080/cb?code=xxx&state=yyy。

### 3.3 换取 access token 并读取用户照片列表

这个重定向相当于用户浏览器向 http://my-photo-print.com:8080/cb?code=xxx&state=yyy 发起请求，为照片冲印服务提供 code，该请求由 my-photo-print 的 oauthCallbackHandler 处理：

```
// oauth2-examples/my-photo-print/main.go

// callback handler，用户拿到code后调用该handler
func oauthCallbackHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Println("oauthCallbackHandler:", *r)

    code := r.FormValue("code")
    state := r.FormValue("state")

    mu.Lock()
    _, ok := stateCache[state]
    if !ok {
        mu.Unlock()
        fmt.Println("not found state:", state)
        w.WriteHeader(http.StatusBadRequest)
        return
    }
    delete(stateCache, state)
    mu.Unlock()

    // fetch access_token with code
    accessToken, err := fetchAccessToken(code)
    if err != nil {
        fmt.Println("fetch access_token error:", err)
        return
    }
    fmt.Println("fetch access_token ok:", accessToken)

    // use access_token to get user's photo list
    user, pl, err := getPhotoList(accessToken)
    if err != nil {
        fmt.Println("get photo list error:", err)
        return
    }
    fmt.Println("get photo list ok:", pl)

    mu.Lock()
    userPhotoList[user] = pl
    mu.Unlock()

    w.Header().Add("Location", "/photos?user="+user)
    w.WriteHeader(http.StatusFound)
}
```

这个 handler 中做了很多工作，包括使用 code 换取 access token，使用 access token 读取用户的照片列表并存储在自己的存储中 (这里用内存模拟，生产环境应该使用数据库服务实现)，最后返回一个重定向应答。

用户浏览器收到重定向应答后，会重定向访问照片冲印服务的 photos 端点: http://my-photo-print.com:8080/photos?user=tonybai，以获取该用户的照片列表。photos 端点的处理 Handler 如下：

```
// oauth2-examples/my-photo-print/main.go

// 待获取到用户照片数据后，让用户浏览器重定向到该页面
func listPhonesHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Println("listPhonesHandler:", *r)

    user := r.FormValue("user")
    mu.Lock()
    pl, ok := userPhotoList[user]
    if !ok {
        mu.Unlock()
        fmt.Println("not found user:", user)
        w.WriteHeader(http.StatusNotFound)
        return
    }
    mu.Unlock()

    // 渲染照片页面模板
    tmpl := template.Must(template.ParseFiles("photolist.html"))
    data := map[string]interface{}{
        "Username":  user,
        "PhotoList": pl,
    }
    tmpl.Execute(w, data)
}
```

这里使用了 photolist.html 并结合用户的照片列表数据一起来渲染照片列表页面，并返回给浏览器：

![](https://tonybai.com/wp-content/uploads/understand-oauth2-by-example-14.png)

到这里示例演示就结束了，用户通过授权让照片冲印服务读取到了照片数据。

这里还有一个服务没有提及，那就是 my-yunpan.com 云盘服务，它的实现较为简单，所以这里就不赘述了。

> 注：生产中，my-yunpan.com 云盘服务是要对照片冲印服务的 access token 进行校验的，这里是演示程序，没有引入数据库或 redis 来共享 access token，因此这里没有校验。

4. 小结
-----

OAuth 是一种广泛使用的开放授权机制。它通过引入授权服务器的概念，实现了用户在不共享自己的用户名密码情况下也能安全地向第三方应用提供特定权限的数据访问授权。

本文通过云盘开放平台和第三方照片打印服务的应用场景详细说明了 OAuth 出现的背景和解决的问题，并结合工作流程图和 Go 示例代码，通俗易懂地介绍了 OAuth2 授权码模式的整体交互流程和实现机制。希望大家通过对这篇文章的阅读，能加深对 OAuth2 工作原理和机制的理解。

文本涉及的源码可以在[这里](https://github.com/bigwhite/experiments/tree/master/oauth2-examples)下载。

> 注：鉴于本人在前端的小白水平，文中涉及的 html 代码部分在大模型的帮助下完成。渲染出来的页面比较丑陋，还望大家不要责怪:)。
> 
> 注：Go 社区提供了很多 OAuth 包可以帮助大家快速构建 OAuth2 的授权服务器，比如：https://github.com/go-oauth2/oauth2 等。

5. 参考资料
-------

*   [OAuth2 Specification](https://tools.ietf.org/html/rfc6749) - https://tools.ietf.org/html/rfc6749
*   《[OAuth2 实战](https://book.douban.com/subject/30487753/)》- https://book.douban.com/subject/30487753/
*   [An Illustrated Guide to OAuth and OpenID Connect](https://developer.okta.com/blog/2019/10/21/illustrated-guide-to-oauth-and-oidc) - https://developer.okta.com/blog/2019/10/21/illustrated-guide-to-oauth-and-oidc
*   《[OAuth2 实战课](https://time.geekbang.org/column/intro/100053901?code=xEq9GQzVQBD0fk2eJ2wRE811l71Ld3NxuFeQg7hN8B0%3D)》
*   [OAuth 和 OpenID Connect 的过去、现在和未来](https://curity.medium.com/the-past-the-present-and-the-future-of-oauth-and-openid-connect-9b3fbf574519) - https://curity.medium.com/the-past-the-present-and-the-future-of-oauth-and-openid-connect-9b3fbf574519

[“Gopher 部落” 知识星球](https://public.zsxq.com/groups/51284458844544)旨在打造一个精品 Go 学习和进阶社群！高品质首发 Go 技术文章，“三天” 首发阅读权，每年两期 Go 语言发展现状分析，每天提前 1 小时阅读到新鲜的 Gopher 日报，网课、技术专栏、图书内容前瞻，六小时内必答保证等满足你关于 Go 语言生态的所有需求！2023 年，Gopher 部落将进一步聚焦于如何编写雅、地道、可读、可测试的 Go 代码，关注代码质量并深入理解 Go 核心技术，并继续加强与星友的互动。欢迎大家加入！

![](http://image.tonybai.com/img/tonybai/gopher-tribe-zsxq-small-card.png)  
![](http://image.tonybai.com/img/tonybai/go-programming-from-beginner-to-master-qr.png)

![](http://image.tonybai.com/img/tonybai/go-first-course-banner.png)  
![](http://image.tonybai.com/img/tonybai/imooc-go-column-pgo-with-qr.jpg)

著名云主机服务厂商 DigitalOcean 发布最新的主机计划，入门级 Droplet 配置升级为：1 core CPU、1G 内存、25G 高速 SSD，价格 5$/ 月。有使用 DigitalOcean 需求的朋友，可以打开这个[链接地址](https://m.do.co/c/bff6eed92687)：https://m.do.co/c/bff6eed92687 开启你的 DO 主机之路。

Gopher Daily(Gopher 每日新闻) - https://gopherdaily.tonybai.com

我的联系方式：

*   微博 (暂不可用)：https://weibo.com/bigwhite20xx
*   微博 2：https://weibo.com/u/6484441286
*   博客：tonybai.com
*   github: https://github.com/bigwhite
*   Gopher Daily 归档 - https://github.com/bigwhite/gopherdaily

![](http://image.tonybai.com/img/tonybai/iamtonybai-wechat-qr.png)

商务合作方式：撰稿、出书、培训、在线课程、合伙创业、咨询、广告合作。

© 2023, [bigwhite](https://tonybai.com/). 版权所有.

Related posts:

1.  [通过实例理解 Go Web 身份认证的几种方式](https://tonybai.com/2023/10/23/understand-go-web-authn-by-example/ "通过实例理解Go Web身份认证的几种方式")
2.  [通过实例理解 Web 应用授权的几种方式](https://tonybai.com/2023/11/04/understand-go-web-authz-by-example/ "通过实例理解Web应用授权的几种方式")
3.  [近期遇到的 3 个 Golang 代码问题](https://tonybai.com/2015/01/23/three-issues-about-go-code/ "近期遇到的3个Golang代码问题")
4.  [通过实例理解 Web 应用用户密码存储方案](https://tonybai.com/2023/10/25/understand-password-storage-of-web-app-by-example/ "通过实例理解Web应用用户密码存储方案")
5.  [defer 函数参数求值简要分析](https://tonybai.com/2018/03/23/the-analysis-of-the-param-evaluation-of-defer-functions/ "defer函数参数求值简要分析")