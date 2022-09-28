---
2022-09-27 22:48:28
---

# hugo+github_action

[toc]{type: "ul", level: [2,3,4]}

## 使用 Hugo 搭建博客

### 安装 Hugo

```bash
# macos homebrew install hugo
brew install hugo
# 验证安装
hugo version
```

### 创建 Hugo 网站

```bash
hugo new site balabala
```

### 配置主题

#### 关联主题仓库

```bash
cd balabala
git init
git submodule add https://github.com/alphapenng/hugo-theme-den themes/hugo-theme-den
```

#### 更新主题

如果是 clone 了其他人的博客项目进行修改，则需要用以下命令进行初始化：

```bash
git submodule update --init --recursive
```

如果需要同步主题仓库的最新修改，需要运行以下命令：

```bash
git submodule update --remote
```

#### 初始化主题配置及发布

```bash
cp -rf themes/hugo-theme-den/exampleSite/* ./
```

初始化主题基础配置后，我们可以在 `config.toml` 文件中进行站点细节配置，具体配置项参考各主题说明文档。

完成后，可以通过 hugo new 命令发布新文章。

```bash
hugo new posts/blog-test.md
```

#### 本地调试站点

```bash
hugo server
```

### 使用 GitHub Pages 前期准备

#### GitHub Pages 仓库

GitHub Pages 项目需要符合 `username.github.io` 的特殊命名格式，仓库建立完成后，可以在设置中配置自己注册的自定义域名来指向 GitHub Pages 生成的网址。此外，需要将博客站点配置文件 `config.toml` 中的 `baseURL` 改为自己的自定义域名，格式为 `"https://www.alphapenng.com/"`，这样博客站点才能正常访问 GitHub Pages 生成的网站服务。

#### 域名解析

### GitHub Pages 发布博客

#### 手动发布

当我们编辑博客内容并通过 `hugo server` 本地调试后，就可以通过 `hugo` 命令生成静态网页文件了。

```bash
hugo
cd public/
```

Hugo 默认会将生成的静态网页文件存放在 `public/` 目录下，我们可以通过将 `public/` 目录初始化为 git 仓库并关联我们的 `alphapenng/alphapenng.github.io` 远程仓库来推送我们的网页静态文件。

```bash
git init
git remote add origin git@github.com:alphapenng/alphapenng.github.io
git add .
git commit -m "add test"
```

核对文件修改后，即可通过 `git push origin main` 推送到 GitHub Pages 仓库，稍等几分钟即可通过我们的自定义域名来访问我们的博客站点了，和我们 `hugo server` 本地调试完全一致。

#### 自动发布

通过上述命令我们可以手动发布我们的静态文件，但还是有以下弊端：

1. 发布步骤还是比较繁琐，本地调试后还需要切换到 `public/` 目录进行上传
2. 无法对博客 `.md` 源文件进行备份与版本管理

因此，我们需要简单顺滑的方式来进行博客发布，首先我们初始化博客源文件的仓库，如我的仓库为 `alphapenng/balabala`。

因为我们的博客基于 GitHub 与 GitHub Pages，可以通过官方提供的 GitHub Action 进行 CI 自动发布，下面我会进行详细讲解。GitHub Action 是一个持续集成和持续交付 (CI/CD) 平台，可用于自动执行构建、测试和部署管道，目前已经有很多开发好的工作流，可以通过简单的配置即可直接使用。

配置在仓库目录 `.github/workflows` 下，以 `.yml` 为后缀。我的 GitHub Action 配置为 `alphapenng/balabala deploy.yml`，自动发布示例配置如下：

```
name: deploy

on:
    push:
    workflow_dispatch:
    schedule:
        # Runs everyday at 8:00 AM
        - cron: "0 0 * * *"

jobs:
    build:
        runs-on: ubuntu-latest
        steps:
            - name: Checkout
              uses: actions/checkout@v2
              with:
                  submodules: true
                  fetch-depth: 0

            - name: Setup Hugo
              uses: peaceiris/actions-hugo@v2
              with:
                hugo-version: latest
                extended: true

            - name: Build Web
              run: hugo --minify

            - name: Deploy Web
              uses: peaceiris/actions-gh-pages@v3
              with:
                  PERSONAL_TOKEN: ${{ secrets.PERSONAL_TOKEN }}
                  EXTERNAL_REPOSITORY: alphapenng/alphapenng.github.io
                  PUBLISH_BRANCH: main
                  PUBLISH_DIR: ./public
                  commit_message: ${{ github.event.head_commit.message }}
```

## 总结

以上就是我通过 Hugo 与 GitHub Action 实现的免费博客自动部署系统，我自己的实现仓库在 `alphapenng/balabala` 仓库中，我定制化的主题仓库在 `alphapenng/hugo-theme-den` 中。
