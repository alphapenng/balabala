<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-07-23 12:23:35
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-07-23 17:27:02
 * @FilePath: /balabala/content/golang/how_to_start_a_go_project_in_2023.md
-->


# How to start a go project in 2023

[原文链接](https://boyter.org/posts/how-to-start-go-project-2023/)

- [How to start a go project in 2023](#how-to-start-a-go-project-in-2023)
  - [Install/Setup](#installsetup)
    - [Editor](#editor)
  - [Starting a Project](#starting-a-project)
    - [Getting Packages / Dependencies](#getting-packages--dependencies)
    - [Clean / Tidy](#clean--tidy)
  - [Learning Go](#learning-go)
  - [Searching](#searching)
  - [Building/Installing](#buildinginstalling)
    - [Trimming Builds](#trimming-builds)
    - [Packaging / Deploying](#packaging--deploying)
  - [Linting/Static Analysis/Security Scanning](#lintingstatic-analysissecurity-scanning)
  - [Profiling](#profiling)
  - [Unit Testing](#unit-testing)
    - [Mocks](#mocks)
  - [Integration Testing](#integration-testing)
    - [Test Caching](#test-caching)
  - [Community](#community)
  - [Multiple main Entry Points](#multiple-main-entry-points)
  - [OS Specific Code](#os-specific-code)
  - [Docker](#docker)
  - [Useful Tools/Packages](#useful-toolspackages)
    - [Tools](#tools)
    - [Packages](#packages)

## Install/Setup

首先要做的是下载并安装 Go。我建议始终从 Go 网站本身 <https://golang.org/> 安装，并按照您选择的操作系统的说明进行操作。除了 Go 1.18 版本（包括泛型）之外，我在安装最新版本的 Go 并进行编译时从未遇到过任何问题。向后兼容性的承诺是真实的。即使项目的 go.mod 文件显示为 1.20，如果它不使用任何 1.20 功能，您仍然可以使用早期版本来编译它。

较旧的指南会提到设置您的 `$GOPATH`。 2023 年你可以轻松地忽略这一点。如果你好奇的话，请查看我[之前的帖子](https://boyter.org/posts/how-to-start-go-project-2018/)。然而，一切都已经或正在转向模块，所以只需考虑这是你不必学习的东西。

我建议的一件事是更新您的计算机路径以指向默认 $GOPATH 的 bin 目录

```bash
export PATH=$PATH:$(go env GOPATH)/bin
```

以便您可以快速安装您正在处理的任何内容并使其随处可用。例如，在我当前的机器上，它包含以下内容。

```bash
# boyter @ Bens-MacBook-Air in ~/go/bin [10:04:57] 
$ tree
.
├── boltbrowser
├── cs
├── dcd
├── goreleaser
├── gow
├── hashit
├── lc
├── scc
```

我的点文件包含 `export PATH=/Users/boyter/go/bin:$PATH` 来实现上述目的。

使用导出的路径，在为我正在处理的项目首次运行 go install 后，我可以在任何地方运行 scc 、 dcd 和 lc 。在 Windows 上，我比大多数人更进一步，使用 WSL 在 Windows 和 Linux 之间共享 $GOPATH，这样我就可以在两者中使用相同的代码库，因此您会在上面看到 .exe 文件。为此，您只需在 WSL 内创建一个到 Windows 目录的符号链接。

### Editor

根据最新的 Go 调查结果，大多数人在 Visual Studio Code 或 Jetbrains Goland 中编写 Go 代码，这是我要介绍的唯一编辑器。

Goland 几乎开箱即用，是我日常使用的 IDE。只要你安装了 Go，它就应该找到它并开始工作。最大的问题是 Go 新版本何时发布。这可能会导致 Goland 感到困惑，并破坏诸如调试器之类的东西。解决方案是在 Jetbrains 团队更新匹配后一周左右进行升级。

我发现这些更新有时会导致 “clang” 命令需要 macOS 上的命令行开发人员工具的无限循环。我写过对此的修复，但归结为运行 `xcodebuild -runFirstLaunch` 来解决问题。

Visual Studio Code 已经取得了长足的进步，比我第一次开始使用 Go 时要好得多。安装最新版本，然后安装 [Go in Visual Studio Code](https://code.visualstudio.com/docs/languages/go) 扩展。您可以获得所需的智能感知、重新格式化、自动导入 / 删除导入功能。据说调试现在也可以工作，但我无法对此进行报告。

我仍然更喜欢付费和使用 Goland，因为我发现它就像与一位从不睡觉且几乎从不出错的出色工程师配对。它生成表测试并运行单独的测试的能力可以节省大量时间，而且重构工具也很棒。然而，对于这篇文章，我尝试使用 Visual Studio Code 几个小时，给我留下了深刻的印象，现在推荐它没有任何问题。

## Starting a Project

启动项目就像启动一个新目录并运行 `go mod init NAMEHERE` 一样简单，其中 NAMEHERE 是您想要用于项目的包的名称。过去您使用的名称与存储库的位置相匹配，例如 `github.com/boyter/scc` 但现在您可以使用任何您想要的名称。不过，使用完整的存储库 URL 并不是一个坏主意，对于大多数项目我仍然更喜欢它。

### Getting Packages / Dependencies

获取包几乎就像了解其路径并使用 `go get URL` 将其下载到本地系统一样简单。我通常依赖于供应商，因此我在项目中存储了一个副本，以便进行可重复的构建。它还允许我在等待上游修复的同时轻松修补依赖项中的错误。为此，请运行 `go mod vendor` ，这会将所有内容拉入 vendor 目录中。如果您这样做，我建议您设置一个包含 vendor 的 `.ignore` 文件。

如果包维护者已从语义版本 1 转移到语义版本 2 或更高版本，那么获取包可能会令人困惑。在这种情况下，您需要在末尾添加所需的版本以拉入所需的版本。

例如我的项目 scc 版本为 3.1.0。如果我要导入它而不指定版本，

```bash
$ go get github.com/boyter/scc/  
go: added github.com/boyter/scc v2.12.0+incompatible
```

我会得到一个 2.12 版本的包，这可能会让 Go 新手感到困惑。添加最新版本时，

```bash
$ go get github.com/boyter/scc/v3
go: added github.com/boyter/scc/v3 v3.1.0
```

正如你所看到的，它已经拉下了正确的版本，这正是我所期望的。

下面的指南[告诉我如何使用 Go Modules](https://engineering.kablamo.com.au/posts/2018/just-tell-me-how-to-use-go-modules/) 及其 [Hacker News Conversation](https://news.ycombinator.com/item?id=18653225) 很好地涵盖了这一点。

### Clean / Tidy

当您在使用包后尝试运行 go 时，偶尔会出现的一件事是它报告您需要运行 go mod tidy 。不要太担心这一点，只需运行 go mod tidy 以及您尝试执行的任何操作，直到您能够再次取得进展。您可以在 [Go Modules Reference](https://go.dev/ref/mod) 中了解其功能。

来自 Go 构建系统的缓存工件可以存储在本地系统上，并占用相当多的空间（在撰写本文时，我的本地系统大小约为 1GB）。要清理此运行 `go clean -cache` 。

## Learning Go

使用 [go.dev 学习教程](https://go.dev/learn/)，您可以轻松掌握 Go。这将使您快速了解如何编写代码以及需要了解的语法。然而，对于学习如何构建自己的 HTTP 应用程序（这是大多数人正在做的事情），我强烈建议您阅读以下书籍 <https://lets-go.alexedwards.net/> 它确实需要花钱，但它会缩短您的学习过程几个小时。

我有一个示例，我个人用它来设置新的 HTTP 项目，您可以在 github 上找到该示例 <https://github.com/boyter/go-http-template>

然而，我强烈建议阅读的一件事是 [50 Shades of Go](https://devs.cloudimmunity.com/gotchas-and-common-mistakes-in-go-golang/index.html) 帖子。它涵盖了您可能遇到的许多 Go 陷阱。检查这一点是许多公司在招聘时都会筛选的内容，因为接触这些问题可以很好地表明使用 Go 的经验。

## Searching

要在您选择的搜索引擎中搜索有关 Go 的任何内容，请在搜索时使用单词 golang 而不是 go 。例如，要搜索如何打开文件，我会搜索 `golang open file` 。

请注意，最好不要在随意交谈中将该语言称为 golang，因为这会惹恼很多迂腐的人。每个人都知道你在说什么，但希望最终有人能说点什么。

## Building/Installing

对于具有 package main 的命令

```bash
go build   builds the command and leaves the result in the current working directory.
go install builds the command in a temporary directory then moves it to $GOPATH/bin.
```

对于 packages

```bash
go build   builds your package then discards the results.
go install builds then installs the package in your $GOPATH/pkg directory.
```

如果你想交叉编译，即在 Linux 上为 Windows 构建，反之亦然，你可以通过环境变量设置你想要的目标架构和操作系统。您可以在 go env 中查看默认值，但要更改它们，您可以执行以下操作：

```bash
GOOS=darwin GOARCH=amd64 go build
GOOS=darwin GOARCH=arm64 go build
GOOS=windows GOARCH=amd64 go build
GOOS=windows GOARCH=arm64 go build
GOOS=linux GOARCH=amd64 go build
GOOS=linux GOARCH=arm64 go build
```

### Trimming Builds

Go 二进制文件默认是 “胖” 的并且比你想象的要大。有一个简单的方法可以减小尺寸，

```bash
go build -ldflags="-s -w"
```

这会删除调试信息。对于较小的二进制文件，启动时间并不重要，您也可以使用 <https://upx.github.io/> 但我发现在交叉编译时使用它存在问题。请参阅我写的关于使用两者的[另一篇文章](https://boyter.org/posts/trimming-golang-binary-fat/)。

### Packaging / Deploying

虽然您可以使用上面提到的 GOOS 和 GOARCH 来构建您自己的软件包，但我强烈建议使用 [goreleaser](https://goreleaser.com/)。它使部署变得更加容易，并且它的指南可确保您正确标记。

## Linting/Static Analysis/Security Scanning

虽然您可以使用声纳和各种其他工具来实现此目的，但我更喜欢可以在本地运行并轻松集成到 CI/CD 系统中的工具。使用以下工具将为您提供所有重要的审核标记。

用于 linting 和静态分析 <https://github.com/golangci/golangci-lint>

对于安全检查，我喜欢使用 gitleaks <https://github.com/gitleaks/gitleaks> 并通过以下检查运行它。

```bash
gitleaks detect -v -c gitleaks.toml
gitleaks protect -v -c gitleaks.tom
```

请注意，您需要包含 gitleaks toml 文件。[这是我用作基础的文件](https://gist.github.com/boyter/48942e5bcf9eed3cd3ed5f8ad413920f)，其中包含要忽略的供应商目录，因为 AWS SDK 等内容会导致 gitleaks 崩溃。

## Profiling

Go 中的分析具有一流的支持。对于 CPU 分析，您希望分析器在一段时间内针对 HTTP 服务等运行，或者在程序退出时针对短期应用程序运行。

对于短期应用程序，在主函数中添加以下内容，

```golang
f, _ := os.Create("profile.pprof")
pprof.StartCPUProfile(f)
defer pprof.StopCPUProfile()
```

当您运行命令时，这将开始分析，并在程序退出时将结果保存到 profile.pprof。

对于 HTTP 来说，类似下面的工作，

```golang
f, _ := os.Create("profile.pprof")
_ = pprof.StartCPUProfile(f)
go func() {
	time.Sleep(30 * time.Second)
	pprof.StopCPUProfile()
}()
```

它开始收集 CPU 配置文件信息 30 秒，然后将其保存到磁盘。您可以将其放在主函数中或路由后面，甚至可以将其放在某种后台任务中以随着时间的推移收集个人资料信息。

内存分析拍摄堆的快照。我倾向于使用它们主要是为了了解长期存在的 HTTP 服务中发生了什么。

```golang
f, _ := os.Create("memprofile.pprof")
_ = pprof.WriteHeapProfile(f)
```

将上述内容放在简单的路由后面会将堆快照转储到磁盘，然后我可以对其进行分析。

在任何一种情况下，配置文件的分析都是相同的，

```bash
go tool pprof -http=localhost:8090 profile.pprof
```

以上将在端口 8090 上打开一个 http 服务器，然后您可以检查该服务器。这通常是我检查配置文件输出的方式，因为我发现 HTTP 接口易于阅读并且我非常喜欢使用火焰图。您可以在 [pprof 的 go.dev 网站](https://go.dev/blog/pprof)上找到更多详细信息。

## Unit Testing

要运行代码的所有单元测试（使用缓存，没有理由不再运行它们），您应该运行以下命令，它将运行所有单元测试

```bash
go test ./...
```

要运行基准测试，请在基准测试所在的目录中运行以下命令。假设您的项目中有 ./processor/ ，其中有一个基准文件，请转到该目录并运行，

```bash
go test --bench .
```

要运行内置模糊测试，

```bash
go test -fuzz .
```

要创建测试文件，您只需创建一个名称中带有 _test 作为后缀的文件。例如，要为名为 `file.go` 的文件创建测试，您可能需要调用该文件 `file_test.go` 。

如果您想运行单独的测试，您可以这样做，

```bash
go test ./... -run NameOfTest
```

它将尝试在所有名为 NameOfTest 的包中进行任何测试。请记住，参数 NameOfTest 支持正则表达式，因此假设您命名得很好，就可以将测试组作为目标。对于一般运行，您可以使用 . 来匹配所有内容。

如果您发现自己想要或需要忽略缓存来运行测试，您可以执行以下操作，

```bash
GOCACHE=off go test ./...
```

Go 测试的标准做法是将它们放在您正在测试的文件旁边。然而这实际上并不是必需的。只要您可以导入代码（即使用大写前缀公开），您就可以将测试放在您喜欢的任何地方。这当然意味着您无法测试私有代码，无论如何，有些人认为这是反模式。

对于模糊测试，我建议阅读 [bitfield consulting](https://bitfieldconsulting.com/golang/fuzz-tests) 的本指南，其中很好地介绍了内置模糊检测器的使用。请注意，如果您搜索如何在 Go 中进行模糊测试，您可能会遇到有关之前首选 <https://github.com/dvyukov/go-fuzz> 的文章，因此请查找 2022 年中之后编写的指南。

### Mocks

一般来说，Go 中的模拟就像在您想要模拟的事物上定义一个接口一样简单。然而，有些人不喜欢手动方法，并使用 [testify](https://boyter.org/posts/how-to-start-go-project-2023/(https://github.com/stretchr/testify)) 和 [mockery](https://github.com/vektra/mockery) 等工具来实现这一点。

如果您有 Java 背景，请不必费心寻找 Mockito 替代品。 Go 中没有任何东西可以接近它。如果您想创建一个，请告诉我。

我通常采用手动方法，所以我对上述两种方式都没有强烈的感觉。简而言之，坚持 “接受接口，返回结构” 作为您的代码方法，应该没问题。您可以在以下链接中阅读相关内容 <https://medium.com/swlh/golangs-interfaces-explained-with-mocks-886f69eca6f0> <https://bryanftan.medium.com/accept-interfaces-return-structs-in-go-d4cab29a301b> <https://tutorialedge.net/golang/accept-interfaces-return-structs/>

## Integration Testing

如果您最终在 Go 代码中添加集成测试，通常的做法是通过标签拆分它们。您可以将以下内容放在测试文件的顶部

```golang
//go:build integration

package mypackage
```

然后你可以运行它们

```bash
go test --tags=integration ./...
```

这仍将运行未标记的测试。您还可以使用它来将测试分成不同的组。但是您确实需要小心，因为默认情况下，当每个组运行时，它们都在自己的上下文中运行，因此一个测试组中的方法将不可用于其他测试组并导致编译错误。

### Test Caching

默认情况下会缓存测试结果，这可能不适合集成测试。您想要覆盖此 `-count=1` 的位置可以添加到您的运行命令中，以运行测试 1 次，忽略缓存的结果。如果需要，您可以将 1 替换为更高的值。

```bash
go test -count=1 --tags=integration ./...
```

## Community

与其他 “Gophers” 一起出去玩的最佳选择是 [Reddit 子版块](https://www.reddit.com/r/golang/) 或 [Slack](https://gophers.slack.com/)。在这两者中，我发现 slack 更容易适应，也更容易处理。

## Multiple main Entry Points

有时您希望通过在主包中包含多个 main.go 文件来潜在地拥有应用程序的多个入口点。实现这一目标的一种方法是在一个存储库中共享代码，然后将其导入到其他存储库中。然而，当您想要使用供应商导入时，这可能会很麻烦。

一种常见的模式是在应用程序的根目录中有一个目录，并将 `main.go` 文件放置在其中。例如，

```bash
SRC
├── cmd
│   ├── commandline
│   │   └── main.go
│   ├── webhttp
│   │   └── main.go
│   ├── convert1.0-2.0
│   │   └── main.go
```

然后，每个入口点都可以从根包导入，并且您可以编译多个入口点并将其运行到应用程序中。假设您的应用程序位于 http://github.com/name/mycode 中，您需要在每个应用程序中像这样导入，

```golang
package main

import (
	"github.com/name/mycode"
)
```

通过上述内容，您现在可以调用根目录中的存储库包公开的代码。

## OS Specific Code

有时，您需要应用程序中的代码无法在不同操作系统上编译或运行。处理此问题的最常见方法是在应用程序中使用以下结构，

```bash
main_darwin.go
main_linux.go
main_windows.go
```

假设上面仅包含多个操作系统 EG `const LineBreak = "\n\r"` 或 `const LineBreak = "\n"` 上换行符的定义，您可以根据需要导入并引用 `LineBreak` 。同样的技术适用于函数或您希望包含的任何其他内容。

## Docker

使用上述技术，您可以使用多个入口点轻松在 Docker 中运行。下面是使用我们位于 <https://username@bitbucket.code.company-name.com.au/scm/code/random-code.git> 的假设存储库中的代码实现此目的的示例 dockerfile

下面将构建并运行主应用程序，

```dockerfile
FROM golang:1.20

COPY ./ /go/src/bitbucket.code.company-name.com.au/scm/code/
WORKDIR /go/src/bitbucket.code.company-name.com.au/scm/code/

RUN go build main.go

CMD ["./main"]
```

下面将从应用程序的备用入口点之一构建并运行，

```dockerfile
ROM golang:1.20

COPY ./ /go/src/bitbucket.code.company-name.com.au/scm/code/
WORKDIR /go/src/bitbucket.code.company-name.com.au/scm/code/cmd/webhttp/

RUN go build main.go

CMD ["./main"]
```

一些读过这篇文章的人建议使用多阶段 docker 构建 <https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds>，它适用于 Docker 17.05 或更高版本。更多详细信息请参见 <https://medium.com/travis-on-docker/multi-stage-docker-builds-for-creating-tiny-go-images-e0e1867efe5a> 一个例子是，

```dockerfile
FROM golang:1.20
COPY . /go/src/bitbucket.code.company-name.com.au/scm/code
WORKDIR /go/src/bitbucket.code.company-name.com.au/scm/code/
RUN CGO_ENABLED=0 go build main.go

FROM alpine:3.7
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/src/bitbucket.code.company-name.com.au/scm/code/main .
CMD ["./main"]
```

结果是运行代码的图像要小得多，这总是很好的。

## Useful Tools/Packages

我喜欢的与 Go 开发相关的有用工具和我喜欢使用的包的简短列表。请注意，有些不是用 Go 编写的。

### Tools

- gow <https://github.com/mitranim/gow> - 监视模式命令。用你的参数运行它，它会在后台为你重新热编译。对于 HTTP 开发非常有用。例如， `gow -e=go,html,css run .` 将监视对任何 Go、HTML 或 CSS 文件的文件更改，如果发现，则重新运行 `go run .` 命令，为您提供热重载。

- hyperfine <https://github.com/sharkdp/hyperfine> - 命令行基准测试工具。将其视为多次运行 time 并对结果取平均值的替代方法。

- dcd <https://github.com/boyter/dcd> - 重复代码检测器。我自己的项目（所以我犹豫是否添加它），但您可以运行它来查找项目中重复代码的示例。在寻求重构时特别有用。

- gotestsum <https://github.com/gotestyourself/gotestsum> - 备用测试运行程序。提供不同的测试输出以及您可能喜欢的格式选项。可以生成 junit 输出格式以与 CI/CD 系统配合使用。

- json-to-to <https://mholt.github.io/json-to-go/> - JSON到Go生成器。Goland也可以为您完成此操作，但是这个工具非常适合将JSON粘贴进去并获得一个可以保存它的结构体。

- gofumpt <https://github.com/mvdan/gofumpt> - 比 gofmt 更严格的格式化程序。我个人没有使用过这个，但有人向我建议。

- golangcli-lint <https://github.com/golangci/golangci-lint> - 静态类型检查器和代码规范强制执行工具。从项目的第一天开始使用它，将为您节省大量清理工作。它提供的建议总是很好，并且在被问到常见的审计问题时非常有帮助。将其与CI/CD流水线连接起来作为部署门控以获得最佳结果。

- gitleaks <https://github.com/gitleaks/gitleaks> - SAST 工具，用于查找和识别签入的机密、密码等。再次可以很好地帮助通过审核问题。

- BFG Repo-Cleaner <https://rtyley.github.io/bfg-repo-cleaner/> - 从 git 存储库删除大型二进制文件或签入机密的最简单方法。对于解决 gitleaks 发现的问题非常有用。

### Packages

- <https://github.com/tidwall/gjson> - 从JSON文档中快速获取JSON值的方法。您可以直接获取所需的值，而不是反序列化为结构体。在针对自己的端点运行集成测试时特别有用。由于导入您用于编组的结构体无法捕获回归，因此使用这种方式编写非脆弱测试是一种不错的方法。`g := gjson.Get(resp.Body, "response.someValue")`。

- <https://github.com/rs/zerolog/> - 结构化的JSON日志。一种快速获取有意义的结构化日志的方法。我的偏好是使用带有唯一代码 `date | md5 | cut -c 1-8` 的方式，使您能够将错误追踪到确切的行 `log.Error().Str(common.UniqueCode, "9822f401").Err(err).Msg("")`。添加上下文信息以获取调用详细信息，通过日志实现某种程度的可观察性。

- <https://github.com/gorilla/mux> - 一个替代标准Go路由器的解决方案，它有点不稳定。令人恼火的是，这段代码现在已经存档了。虽然代码没有生锈，并且仍然可以工作，但找到一个被维护的替代方案应该是首要任务。以下博文对潜力进行了较好地概述 <https://mariocarrion.com/2022/12/19/gorilla-mux-archived-migration-path.html>。

- <https://github.com/google/go-cmp> - 比 reflect.DeepEqual 更好的用于相等性检查。

- <https://github.com/google/uuid/> - 可能是创建各种版本UUID的事实上的包。
 