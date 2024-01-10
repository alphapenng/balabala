> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.cuketest.com](https://www.cuketest.com/zh-cn/shared/npm_offline)

> 在使用 node 时，如要用第三方库，可使用 npm install 命令安装。

在使用 node 时，如要用第三方库，可使用 npm install 命令安装。它会自动从网上的 npm 库中下载对应的包文件，比较方便。 有些情况下，或在有些公司中，开发环境无法直接连接外网, 只能在离线环境下使用开发。就不能直接使用 npm 包管理工具通过网络下载安装依赖库。

这里介绍的方法是将依赖库制作成为一个 tar 文件，然后直接使用 npm install xxxx.tgz，离线安装这个依赖库文件。

制作 tar 包
--------

首先在有互联网连接的环境的情况制作依赖库的 tar 包，步骤如下：

1.  **安装 npm-pack-all 工具**
    
    `npm-pack-all`可以将 npm 库文件打包为一个 tar 文件，访问 [https://www.npmjs.com/package/npm-pack-all](https://www.npmjs.com/package/npm-pack-all) 了解更多。
    
    执行下面命令安装它：
    
    ```
    npm install -g npm-pack-all
    ```
    
2.  **下载你要打包的库**
    
    一个 npm 库通常又会依赖其它的 npm 库。为了离线使用，它和它所有的依赖库都需要打包起来。我们现在以 "selenium-webdriver" 为例介绍在 Windows 操作系统上的打包过程。
    
    这是一个自动化 web 网站常用的库，通常装在自动化脚本所在的本地目录。这里为了打包，需要全局安装。运行下面的命令全局安装这个库：
    
    ```
    npm install -g selenium-webdriver
    ```
    
    使用 -g 参数安装会自动把 selenium-webdriver 依赖的包放在全局目录下，即`%userprofile%\AppData\Roaming\npm`。类似这样:
    
    ![](https://www.cuketest.com/zh-cn/shared/assets/npm_offline_global.png)
    
    从上图中可以看到，全局安装的特点是，这个包的所有依赖包都安装在了自己的目录下的 node_modules 子目录里。
    
3.  **制作 tgz 文件**
    
    *   在命令行下，通过 `cd %appdata%\npm\node_modules\selenium-webdriver`调整当前目录到 selenium-webdriver 目录下。
        
    *   执行 npm-pack-all
        
    *   执行完毕后，会在当前目录下生成 .tgz 文件，这里生成的文件为 selenium-webdriver-4.0.0-alpha.5.tgz。根据你实际安装的 npm 包文件版本不同，这个文件有可能不同。
        

离线安装
----

将上一步生成的 .tgz 文件复制到离线的机器上，在你的项目目录下执行`npm install <your_tgz_file>`命令，安装这个包：

```
npm install selenium-webdriver-4.0.0-alpha.5.tgz
```

即可将库文件安装成功。

有些 npm 包安装时会自动从网上下载更新，这时候离线安装需要带上一定的参数，否则可能会不成功。例如'chromedriver'，如安装离线包可以带上参数：

```
npm install chromedriver --chromedriver_skip_download=true
```

具体参数及意义可参照 npm 包的文档（[https://www.npmjs.com/package/chromedriver](https://www.npmjs.com/package/chromedriver)。