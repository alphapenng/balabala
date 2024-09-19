> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [shenzilong.cn](https://shenzilong.cn/record/%E5%A6%82%E4%BD%95%E5%AE%9E%E7%8E%B0%E4%B8%80%E4%B8%AA%E5%B0%8F%E4%BD%93%E7%A7%AF%E7%9A%84js%20docker%E9%95%9C%E5%83%8F)

> 在服务端一般使用 node 来运行 js ，除了 node 外流行的还有 bun/deno。

在服务端一般使用 node 来运行 js ，除了 node 外流行的还有 bun/deno。

但这三个运行时的打包体积都不小，在精简的情况下也在 50 mb 以上，我在这里记录一下我是如何将一个原来使用 node 开发的服务迁移为 3.78MB 的 docker 镜像。

​ ![](https://shenzilong.cn/assets/image-20240831145324-mzsh9nq.png) ​

选择 js 运行时 （[llrt](https://github.com/awslabs/llrt)）
---------------------------------------------------

要实现这么小的镜像肯定不能再使用 node 这种等级的 js 运行时了，现在最流行的轻量级 js 运行时可以锁定为 [QuickJS](https://github.com/quickjs-zh/QuickJS)

我要迁移的项目是我之前写的一个字体裁剪工具 [web-font](https://github.com/2234839/web-font) , 它除了纯 js 的部分外还涉及到文件读写和 http server 部分的 api ，QuickJS 作为纯粹的解释器是没有这方面的 api 的。

现有的比较成熟的基于 QuickJS 实现的微型 js 运行时有 [txiki.js](https://github.com/saghul/txiki.js) 和 [llrt](https://github.com/awslabs/llrt) , 经过实践发现 llrt 可以完美运行在 docker 中 ，txiki.js 则没那么方便 （按照文档编译出来的 tjs 还会依赖其他库）

迁移遇到的问题
-------

主要问题是 llrt 没有提供 http 模块（tixiki.js 也是）, 幸运的是它提供了 net 模块

打包微小体积的 docker 镜像
-----------------

### 1. 代码打包

这方面我使用的是 tsup 将 ts 源码打包为一个 js 文件。

然后使用 llrt compile 命令将 js 文件编译为 .lrt 文件（这一步也能减少差不多 30% 的体积）

### 2. Dockerfile

得益于 llrt ，可以不用依赖任何环境，直接使用 FROM scratch​ 来得到最小的 docker 镜像体积

dockerfile

FROM scratch WORKDIR /home/ COPY dist_backend/app.lrt /home/app.lrt COPY llrt /home/llrt COPY dist/ /home/dist/ CMD ["/home/llrt", "/home/app.lrt"]

再经过 docker 的压缩后就得到了 3.78MB 这个数字。

使用情况
----

llrt 的运行速度比 node 还是慢了许多，在我这个场景下它比 node 要慢上两倍，gc 的运行速度也要慢许多。

由于运行时还不是特别完善的问题，很容易踩坑，所以除非你急需压缩 js 的运行内存占用 / 冷启动速度或者和我一样就是想要这么做，还是建议直接使用 node 吧。