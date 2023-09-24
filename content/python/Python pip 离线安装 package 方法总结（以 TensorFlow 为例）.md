> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [imshuai.com](https://imshuai.com/python-pip-install-package-offline-tensorflow)

> Python 环境安装 package，一般采用 pip 命令在线从 PyPI 是安装，这也是最方便的途径。

Python 环境安装 package，一般采用`pip`命令在线从 PyPI 是安装，这也是最方便的途径。但在某些情况下，**要为一台离线的机器（比如在内网运行的一台生产服务器）安装 package**，根本就连不上 PyPI。当然，大厂一般都有内网 PyPI 代理，只要改一下`--index-url`参数即可；但若代理也没有，只能**手工将所有依赖到的 package 离线下载下来，放到 offline 的机器上安装**。

下面是说明了整个探索过程。最终总结的方法，直接看文末的 “推荐方法” 即可。

之前我只是傻了吧唧，将要安装的 package（比如 tensorflow）从 PyPI 网站手工下载下来，放到内网机器直接安装，当然立马就会报 xxx 依赖不存在导致安装失败；根据报错提示再到 PyPI 上再下载这个 xxx 的 package 安装。而这个 xxx 可能又依赖另外一个 yyy。如此反复，整个过程有 30 个左右的多层依赖，搞了一下午，痛苦不堪。

后来，我发现这些 package 里面都有 requirements 的声明文件，于是我就先解压出来看 requirement，这样至少直接依赖的 package 一下子都知道了。总比根据报错再一个一个下载快了。

但这还是不行，诉诸网络，发现了`pip download`可以解决这个问题，不过实际操作中还是有不少问题，下面以 TensorFlow 的离线安装为例说明。

总的思路是:

1.  在 online 机器，通过`pip download tensorflow`命令（与`pip install`的区别就是，前者只下载不安装），将要安装的 xxx_package 以及所有依赖都下载到本地
2.  然后拷贝到目标 offline 机器的某个目录（比如 / offline_package_dir），并通过如下命令安装：
    
    ```
    pip install --no-index --find-links=file:/offline_package_dir tensorflow
    ```
    

看起来很美好，但如果两台机器架构不一样，则十分痛苦。 根据 online 和 offline 机器的架构是否相同（即 OS 是否一样，Python 版本是否一样），分别如下：

这种情况比较简单：

1.  直接在 online 机器执行如下命令，下载所有依赖 package 到当前目录：
2.  将目录内容拷贝到目标 offline 机器（比如 / offline_package_dir），并目标 offline 机器执行
    
    ```
    pip download tensorflow
    ```
    

由于两个机器架构完全一样，因此 download 的 package 在目标机器一定可以安装。

这种情况比较复杂，**因为机器架构不同，直接用`pip download tensorflow`下载的 package 在目标机器很可能不适用**。

以 [TensorFlow](https://pypi.org/project/tensorflow/#files) 为例，PyPI 上看到的 wheel 文件，至少根据 OS、Python 版本以及 CPU 架构做了区分：

![](https://cdn.imshuai.com/images/2018/06/Screen-Shot-2018-06-13-at-22.05.38.jpg)

PyPI 上 package 有好几种格式：

1.  源文件（一般是`.tar.gz`或`.zip`文件，用`pip`安装，与机器架构无关，但某些 package 可能涉及到 C/C++ 编译）
2.  wheel 文件（二进制文件，拓展名为`.whl`，用`pip`安装，无需编译，但与机器架构相关）
3.  `.egg`文件（二进制文件，用`easy_install`安装，无需编译，但与机器架构相关）

**不幸的是 PiPY 并没有规定一个 package 必须提供的安装格式，有的只有 wheel 没有源文件，有的只有源文件没有 wheel 或 egg。** 这也是导致下文`pip download`失败的原因。

首先，根据 [pip 官方 Reference Guide](https://pip.pypa.io/en/stable/reference/pip_download/)，可以在执行`download`命令时，添加参数，指明要下载 package 对应的架构：

> pip download with the `--platform`, `--python-version`, `--implementation`, and `--abi` options provides the ability to fetch dependencies for an interpreter and system other than the ones that pip is running on. `--only-binary=:all:` or `--no-deps` is required when using any of these options. It is important to note that these options all default to the current system/interpreter, and not to the most restrictive constraints (e.g. platform any, abi none, etc). To avoid fetching dependencies that happen to match the constraint of the current interpreter (but not your target one), it is recommended to specify all of these options if you are specifying one of them. Generic dependencies (e.g. universal wheels, or dependencies with no platform, abi, or implementation constraints) will still match an over- constrained download requirement.

看起来，只要指定`--platform`, `--python-version`, `--implementation`, and `--abi`即可，比如我在 macOS 上，为 offline 的 suse linux 下载 TensorFlow，目标机器安装了 Python 2.7， 64 位机器，则这样：

```
pip install --no-index --find-links=file:/offline_package_dir tensorflow
```

这些参数含义和可能的值，可参考：[PEP 425 – Compatibility Tags for Built Distributions](https://www.python.org/dev/peps/pep-0425/)

刚开始都正常，但下载到一半的时候就报错：

```
pip download \
    --only-binary=:all: \ # 只下载二进制package（即wheel或egg）
    --platform linux_x86_64 \ # 说明是linux 64位架构
    --python-version 27 \ # Python 2.7
    --implementation cp \ # cpython，一般都是这个
    --abi cp27mu
    tensorflow # 要下载的package名
```

这是因为参数`--only-binary=:all:`只下载二进制版，而 tensorflow 依赖的 absl-py 在 PyPI 中只有. tar.gz 的源码版，没有二进制版。 ![](https://cdn.imshuai.com/images/2018/06/Screen-Shot-2018-06-14-at-16.02.10.jpg)

那能不能不限制`--only-binary=:all:`？不行，一旦指定具体的架构，就必须设置`--only-binary=:all:`，或者不下载依赖，这是 pip install 用法的规定，可参考官方 Reference： https://pip.pypa.io/en/stable/reference/pip_download/

> ` –only-binary=:all: `or` –no-deps` is required when using any of these options.

这真蛋疼！

那就干脆不下载二进制 package，用`pip download --only-binary=:none: tensorflow`，但坑爹是 tensorflow 只提供二进制包，或者说就算 tensorflow 提供了源码版 package，你也无法保证所有依赖的包都有源码版。**所以这条路也行不通，进入了一个死胡同**。

这个时候，怎么办呢？那手工将这个包下载下来吧： `pip download --no-deps "absl-py>=0.1.6"` 这里要注意，加上–no-deps，即不下载 absl-py 的依赖。因为即便你下载的依赖也可能是不符合目标架构的。

问题是，重新执行 tensorflow 的下载，还是阻塞在 absl-py 上。所以后面没有下载的 package 都要回退到手工模式。

**归根结底，是 pip install 命令，一旦指定了平台相关的参数，就只能下载二进制 package，我很奇怪为什么不能同时下载源代码，至少 install 命令，都是优先选择二进制，没有二进制的时候也能用源代码版。**

网上很多办法是，使用 virtualenv 做一个干净的 Python 环境，然后 install 再用`pip freeze > require.txt`导出 requirement 依赖清单，然后再用`pip download -r require.txt`下载。但这个方法还是逃脱不了目标平台架构不一样的问题。

**到这个地步，若不想手工做，只有一条路：保证 online 和 offline 机器架构一样。** 所谓架构一样，其实就是四个参数一样：`--platform`, `--python-version`, `--implementation`, and `--abi`

*   platform 即操作系统，这个可以通过虚拟机或 docker 解决
*   python-version，可以通过 pipenv 解决
*   implementation，目前一般只考虑 cpython
*   abi，通过虚拟机或 docker 吧

经过上面的分析总结，首先需要让 online 和 offline 机器架构一样。

1.  如果 online 和 offline 的机器架构完全一样：OS 一样、Python 版本一样，非常简单：
    1.  现在 online 机器执行 download，下载所有依赖 package 到当前目录：
    2.  将目录内容拷贝到目标 offline 机器（比如 / offline_package_dir），并目标 offline 机器执行
        
        ```
        Could not find a version that satisfies the requirement absl-py>=0.1.6 (from tensorflow) (from versions: )
        No matching distribution found for absl-py>=0.1.6 (from tensorflow)
        ```
        
2.  如果 online 和 offline 架构不一样 可以先尝试用 download 指定参数试一下是否能成功下载，如果不能再考虑下面的做法。 具体分为两种情况：
    1.  仅 Python 版本不一样
        1.  通过 pyenv 安装指定版本的 python 2.7.13 `curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash` `pyenv install 2.7.13`
        2.  切换 Python 版本 `pyenv global 2.7.13`
        3.  接下来同第 1 中情况的步骤
    2.  OS 不一样 使用 docker 创建一个和目标机器架构相同的容器，在容器内安装和目标机器一样的 Python 版本，然后在容器内按第 1 种情况处理。 以我的例子:
        1.  先启动目标系统的 docker 镜像（这里以 Ubuntu 为例），并映射 package 下载目录 `docker run -it -v /offline_tensorflow_py3:/package ubuntu /bin/bash`
        2.  在容器内安装 python `apt-get update && apt-get install python python-pip`
        3.  接下来同 2.1 步骤一样

-------------------------

本文采用 [知识共享署名 4.0 国际许可协议](http://creativecommons.org/licenses/by/4.0/)（CC-BY 4.0）进行许可。转载请注明来源：[https://imshuai.com/python-pip-install-package-offline-tensorflow](https://imshuai.com/python-pip-install-package-offline-tensorflow) 欢迎指正或在下方评论。