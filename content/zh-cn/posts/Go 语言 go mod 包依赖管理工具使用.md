---
title: "Go 语言 go mod 包依赖管理工具使用"
date: 2022-12-27T12:51:29+08:00
draft: false
tags: ["programming","golang"]
categories: ["programming"]
authors:
- alphapenng
---

![toc](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230102212930_vYigVu.png)

💁 参考文档：[Go 语言 go mod 包依赖管理工具使用详解](http://c.biancheng.net/view/5712.html)

最早的时候，Go 语言所依赖的所有的第三方库都放在 GOPATH 这个目录下面，这就导致了同一个库只能保存一个版本的代码。如果不同的项目依赖同一个第三方的库的不同版本，应该怎么解决？

go module 是 Go 语言从 1.11 版本之后官方推出的版本管理工具，并且从 Go1.13 版本开始，go module 成为了 Go 语言默认的依赖管理工具。

## 如何使用 Modules

### GO111MODULE

1. 首先需要把 golang 升级到 1.11 版本以上（建议使用最新版本）。
2. 设置 `GO111MODULE`。

    在 Go 语言 1.13 及以后的版本则不再需要设置环境变量。通过 `GO111MODULE` 可以开启或关闭 go module 工具。
    - GO111MODULE=off 禁用 go module，编译时会从 GOPATH 和 vendor 文件夹中查找包；
    - GO111MODULE=on 启用 go module，编译时会忽略 GOPATH 和 vendor 文件夹，只根据 go.mod 下载依赖；
    - GO111MODULE=auto（默认值），当项目在 GOPATH/src 目录之外，并且项目根目录有 go.mod 文件时，开启 go module。

    <br>

    建议都设置成 `GO111MODULE=on`。

    Windows 下开启 GO111MODULE 的命令为：

    ```cmd
    set GO111MODULE=on
    ```

    MacOS 或者 Linux 下开启 GO111MODULE 的命令为：

    ```bash
    export GO111MODULE=on
    ```

    常用的 go mod 命令如下表所示：

    命令 | 作用
    ---------|----------
    go mod download | 下载依赖包到本地（默认为 GOPATH/pkg/mod 目录）
    go mod edit | 编辑 go.mod 文件
    go mod graph | 打印模块依赖图
    go mod init | 初始化当前文件夹，创建 go.mod 文件
    go mod tidy | 增加缺少的包，删除无用的包
    go mod vendor | 将依赖复制到 vendor 目录下
    go mod verify | 校验依赖
    go mod why | 解释为什么需要依赖

### GOPROXY

proxy 顾名思义就是代理服务器的意思。大家都知道，国内的网络有防火墙的存在，这导致有些 Go 语言的第三方包我们无法直接通过 go get 命令获取。GOPROXY 是 Go 语言官方提供的一种通过中间代理商来为用户提供包下载服务的方式。要使用 GOPROXY 只需要设置环境变量 GOPROXY 即可。

目前公开的代理服务器的地址有：

- goproxy.io；
- goproxy.cn：（推荐）由国内的七牛云提供。

Windows 下设置 GOPROXY 的命令为：

```cmd
go env -w GOPROXY=https://goproxy.cn,direct
```

MacOS 或 Linux 下设置 GOPROXY 的命令为：

```bash
export GOPROXY=https://goproxy.cn
```

Go 语言在 1.13 版本之后 GOPROXY 默认值为 <https://proxy.golang.org>，在国内可能会存在下载慢或者无法访问的情况，所以十分建议大家将 GOPROXY 设置为国内的 goproxy.cn。

### 使用 go get 命令下载指定版本的依赖包

执行 `go get` 命令，在下载依赖包的同时还可以指定依赖包的版本。

- 运行 `go get -u` 命令会将项目中的包升级到最新的次要版本或者修订版本；
- 运行 `go get -u=patch` 命令会将项目中的包升级到最新的修订版本；
- 运行 `go get [包名]@[版本号]` 命令会下载对应包的指定版本或者将对应包升级到指定的版本。

💁 `go get [包名]@[版本号]` 命令中版本号可以是 x.y.z 的形式，例如 `go get foo@v1.2.3`，也可以是 git 上的分支或 tag，例如 `go get foo@master`，还可以是 git 提交时的哈希值，例如 `go get foo@e3702bed2`。

## 如何在项目中使用

**【示例 1】创建一个新项目：**

1. 在 GOPATH 目录之外新建一个目录，并使用 `go mod init` 初始化生成 go.mod 文件。

    ```bash
    go mod init hello
    go: creating new go.mod: module hello
    ```

    go.mod 文件一旦创建后，它的内容将会被 go toolchain 全面掌控，go toolchain 会在各类命令执行时，比如 `go get`、`go build`、`go mod` 等修改和维护 go.mod 文件。

    go.mod 提供了 module、require、replace 和 exclude 四个命令：

    - module 语句指定包的名字（路径）
    - require 语句指定的依赖项模块；
    - replace 语句可以替换依赖项模块；
    - exclude 语句可以忽略依赖项模块。

    <br>

    初始化生成的 go.mod 文件如下所示：

    ```bash
    module hello

    go 1.13
    ```

2. 添加依赖。

    新建一个 main.go 文件，写入以下代码：

    ```go
    package main

    import (
        "net/http"
        "github.com/labstack/echo"
    )

    func main() {
        e := echo.New()
        e.GET("/", func(c echo.Context) error {
            return c.String(http.StatusOK, "Hello, World!")
        })
        e.Logger.Fatal(e.Start(":1323"))
    }
    ```

    执行 `go run main.go` 运行代码会发现 go mod 会自动查找依赖自动下载：

    ```bash
    go run main.go
    go: finding github.com/labstack/echo v3.3.10+incompatible
    go: downloading github.com/labstack/echo v3.3.10+incompatible
    go: extracting github.com/labstack/echo v3.3.10+incompatible
    go: finding github.com/labstack/gommon v0.3.0
    ......
    go: finding golang.org/x/text v0.3.0

    ____    __
    / __/___/ /  ___
    / _// __/ _ \/ _ \
    /___/\__/_//_/\___/ v3.3.10-dev
    High performance, minimalist Go web framework
    https://echo.labstack.com
    ____________________________________O/_______
                                                        O\
    ⇨ http server started on [::]:1323
    ```

    现在查看 go.mod 内容：

    ```bash
    module hello

    go 1.13

    require (
        github.com/labstack/echo v3.3.10+incompatible // indirect
        github.com/labstack/gommon v0.3.0 // indirect
        golang.org/x/crypto v0.0.0-20191206172530-e9b2fee46413 // indirect
    )
    ```

    go module 安装 package 的原则是先拉取最新的 release tag，若无 tag 则拉取最新的 commit，详见 [Modules 官方](https://github.com/golang/go/wiki/Modules)介绍。

    go 会自动生成一个 go.sum 文件来记录 dependency tree：

    ```bash
    github.com/davecgh/go-spew v1.1.0/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38=
    github.com/labstack/echo v3.3.10+incompatible h1:pGRcYk231ExFAyoAjAfD85kQzRJCRI8bbnE7CX5OEgg=
    github.com/labstack/echo v3.3.10+incompatible/go.mod h1:0INS7j/VjnFxD4E2wkz67b8cVwCLbBmJyDaka6Cmk1s=
    github.com/labstack/gommon v0.3.0 h1:JEeO0bvc78PKdyHxloTKiF8BD5iGrH8T6MSeGvSgob0=
    github.com/labstack/gommon v0.3.0/go.mod h1:MULnywXg0yavhxWKc+lOruYdAhDwPK9wf0OL7NoOu+k=
    github.com/mattn/go-colorable v0.1.2 h1:/bC9yWikZXAL9uJdulbSfyVNIR3n3trXl+v8+1sx8mU=
    ... 省略很多行
    ```

    再次执行脚本 `go run main.go` 发现跳过了检查并安装依赖的步骤。

    可以使用命令 `go list -m -u all` 来检查可以升级的 package，使用 `go get -u need-upgrade-package` 升级后会将新的依赖版本更新到 go.mod * 也可以使用 `go get -u` 升级所有依赖。

**【示例 2】改造现有项目。**

项目目录结构为：

```bash
├─ main.go
│
└─ api
      └─ apis.go
```

main.go 源码为：

```go
package main
import (
    api "./api"  // 这里使用的是相对路径
    "github.com/labstack/echo"
)
func main() {
    e := echo.New()
    e.GET("/", api.HelloWorld)
    e.Logger.Fatal(e.Start(":1323"))
}
```

api/apis.go 源码为：

```go
package api
import (
    "net/http"
    "github.com/labstack/echo"
)
func HelloWorld(c echo.Context) error {
    return c.JSON(http.StatusOK, "hello world")
}
```

1. 使用 `go mod init ***` 初始化 go.mod。

    ```bash
    go mod init hello
    go: creating new go.mod: module hello
    ```

2. 运行 `go run main.go`。

    ```bash
    go run main.go
    go: finding golang.org/x/crypto latest
    build _/D_/code/src/api: cannot find module for path _/D_/code/src/api
    ```

    首先还是会查找并下载安装依赖，然后运行脚本 main.go，这里会抛出一个错误：

    ```bash
    build _/D_/code/src/api: cannot find module for path _/D_/code/src/api
    ```

    但是 go.mod 已经更新：

    ```bash
    module hello

    go 1.13

    require (
        github.com/labstack/echo v3.3.10+incompatible // indirect
        github.com/labstack/gommon v0.3.0 // indirect
        golang.org/x/crypto v0.0.0-20191206172530-e9b2fee46413 // indirect
    )
    ```

    那为什么会抛出这个错误呢？

    这是因为 main.go 中使用 internal package 的方法跟以前已经不同了，由于 go.mod 会扫描同工作目录下所有 package 并且变更引入方法，必须将 hello 当成路径的前缀，也就是需要写成 import hello/api，以往 GOPATH/dep 模式允许的 import ./api 已经失效。

3. 更新旧的 package import 方式。

    所以 main.go 需要改写成：

    ```go
    package main

    import (
        api "hello/api" // 这里使用的是相对路径
        "github.com/labstack/echo"
    )
    func main() {
        e := echo.New()
        e.GET("/", api.HelloWorld)
        e.Logger.Fatal(e.Start(":1323"))
    }
    ```

4. 到这里就和新创建一个项目没什么区别了。

## 使用 replace 替换无法直接获取的 package

由于某些已知的原因，并不是所有的 package 都能成功下载，比如：golang.org 下的包。

modules 可以通过在 go.mod 文件中使用 replace 指令替换成 github 上对应的库，比如：

```bash
replace (
    golang.org/x/crypto v0.0.0-20190313024323-a1f597ede03a => github.com/golang/crypto v0.0.0-20190313024323-a1f597ede03a
)
```

或者

```bash
replace golang.org/x/crypto v0.0.0-20190313024323-a1f597ede03a => github.com/golang/crypto v0.0.0-20190313024323-a1f597ede03a
```
