> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [huangwang.github.io](https://huangwang.github.io/2018/05/10/%E7%A6%BB%E7%BA%BF%E7%8E%AF%E5%A2%83%E4%B8%8BNode-js%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E6%96%B9%E6%B3%95/)

> 离线环境下 Node.js 应用部署时需要解决以下三个基本问题： Node.js 应用的进程管理，如性能监控、自动重启、负载均衡等 Node.js 应用开机如何自启动 离线环境下如何部署 Node.js 应用 ......

离线环境下 Node.js 应用部署方法
--------------------

发表于 2018-05-10 | 更新于 2019-12-17 | [评论数： 0](https://huangwang.github.io/2018/05/10/%E7%A6%BB%E7%BA%BF%E7%8E%AF%E5%A2%83%E4%B8%8BNode-js%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E6%96%B9%E6%B3%95/#comments) | 阅读次数：

离线环境下 Node.js 应用部署时需要解决以下三个基本问题：

1.  Node.js 应用的进程管理，如性能监控、自动重启、负载均衡等
2.  Node.js 应用开机如何自启动
3.  离线环境下如何部署 Node.js 应用

下面以在 Windows Server 2012 上离线部署 Node.js 应用为例，记录上述问题的解决方案：

在生产环境中运行 Express 应用程序时，使用进程管理器对于完成以下任务很有帮助 [1]：

*   在应用程序崩溃后将其重新启动。
*   获得对运行时性能和资源消耗的洞察。
*   动态修改设置以改善性能。
*   控制集群。

进程管理器有点类似于应用程序服务器：它是应用程序的 “容器”，可促进部署，提供高可用性并使您可以在运行时管理应用程序。

用于 Express 和其他 Node.js 应用程序的最流行的进程管理器包括：

*   StrongLoop Process Manager
*   PM2
*   Forever

上述三种工具的比较请参阅 [http://strong-pm.io/compare/](http://strong-pm.io/compare/)。其中，StrongLoop Process Manager 无法在 Windows 平台工作，再综合比较 PM2 和 Forever，由于 Forever 没有操作系统自启动的脚本，故选择 PM2 作为 Windows 平台 Node.js 应用的进程管理器。

选择 PM2 作为 Node.js 应用的进程管理器后，Node.js 应用开机自启动的问题就变为如何开机自启动 PM2。Windows 平台存在两个自启动 PM2 的脚本：

*   pm2-windows-service
*   pm2-windows-startup

pm2-windows-service 基于 node-windows 将 PM2 注册为 Windows 服务，从而实现自启动。pm2-windows-startup 则基于 start-on-windows-boot 在注册表中将 PM2 设为自启动程序，从而实现自启动。两种方案经测试，只有 pm2-windows-startup 在 Windows Server 2012 上可行，故选择 pm2-windows-startup 作为解决 Node.js 应用开机自启动的方案。

PM2 和 pm2-windows-startup 必须全局安装，如何简单方便地在离线环境下全局安装这两个模块是一个问题。网上搜到的方法有：

*   npm link
*   npm-bundle

npm link[2] 是 npm 的一个命令，可将本地包链接成全局包，但实际测试过程中，无法解决 PM2 包的依赖问题，故放弃。而 npm-bundle[3] 则能很好的解决 PM2 的依赖问题。具体过程为：

```
\\在线环境下全局安装
npm install -g pm2
npm install -g pm2-windows-startup
npm install -g npm-bundle
npm-bundle pm2
npm-bundle pm2-windows-startup
```

[](#离线部署Nodejs-Express应用 "离线部署Nodejs Express应用")离线部署 Nodejs Express 应用
----------------------------------------------------------------------

```
@echo off
SET NODE_ENV=production
call npm install .\pm2-2.10.3.tgz -g 
call npm install .\pm2-windows-startup-1.0.3.tgz -g
call pm2-startup install 
call pm2 start ./bin/www -i 0
call pm2 save
```

[](#离线卸载Nodejs-Express应用 "离线卸载Nodejs Express应用")离线卸载 Nodejs Express 应用
----------------------------------------------------------------------

```
@echo off
call pm2 stop all
call pm2-startup uninstall
call npm uninstall pm2 -g
call npm uninstall pm2-windows-startup -g
```

[](#参考链接 "参考链接")参考链接
--------------------

1.  [Express 应用程序的进程管理器](http://expressjs.com/zh-cn/advanced/pm.html), by Express
2.  [npm 离线安装全局包, 内网安装 npm 中的包](https://blog.csdn.net/fay462298322/article/details/53432691), by 爱死费崇政
3.  [What exact command is to install pm2 on offline RHEL](https://stackoverflow.com/questions/41156556/what-exact-command-is-to-install-pm2-on-offline-rhel), by stackoverflow.
4.  [NodeJS: PM2 Startup on Windows](https://blog.cloudboost.io/nodejs-pm2-startup-on-windows-db0906328d75),by Walter Accantelli.
5.  [bat 脚本 %cd% 和 %~dp0 获取当前目录区别](https://blog.csdn.net/u010889616/article/details/78058006),by dmfrm