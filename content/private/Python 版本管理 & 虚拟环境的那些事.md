<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2021-11-16 18:58:09
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-02-06 08:54:35
 * @FilePath: /balabala/content/private/Python 版本管理 & 虚拟环境的那些事.md
-->

# Python 版本管理 & 虚拟环境的那些事

- [Python 版本管理 \& 虚拟环境的那些事](#python-版本管理--虚拟环境的那些事)
  - [Python 版本管理](#python-版本管理)
    - [pyenv](#pyenv)
  - [虚拟环境管理](#虚拟环境管理)
  - [注意事项](#注意事项)

## Python 版本管理

### pyenv

**项目主页：** <https://github.com/pyenv/pyenv>
**核心定位：** 在一台电脑上同时管理多个 Python 版本。

下面摘录了一些个人觉得比较重要的信息。

1. **Understanding PATH**

    > /usr/local/bin:/usr/bin:/bin
    > In this example, the /usr/local/bin directory will be searched first, then /usr/bin, then /bin.

    首先用上面这个例子理解 `$PATH` 的作用：在终端中可以执行的命令，都可以在这个环境变量指定的多个目录中，找到对应的可执行文件。并且搜索的规则为最先匹配。

    ```bash
    ➜  zblog git:(master) ✗ which mkdir
    /bin/mkdir
    ➜  zblog git:(master) ✗
    ```

2. **执行过程**
    1. Search your PATH for an executable file named pip
    2. Find the pyenv shim named pip at the beginning of your PATH
    3. Run the shim named pip, which in turn passes the command along to pyenv

    `pyenv` 的原理就是在 PATH 的最前面加了一层 shims (垫片)，所以当你在执行 python 命令时会自动切换至对应的版本。

3. **切换 python 版本**
   优先级：shell > local > global 

      1. `pyenv shell`：`$PYENV_VERSION` 环境变量，**代表 current shell session!** 
      2. `pyenv local`： local `.python-version` 文件 (向上搜索 recursively), **代表 current directory (project)** 
      3. `pyenv global`：`$(pyenv root)/version`, **代表系统默认的 python 版本**

4. **Demo**

```bash
➜  unswco git:(develope) ✗ pyenv -v
➜  unswco git:(develope) ✗ pyenv install -l
➜  unswco git:(develope) ✗ pyenv install 3.7.0
➜  unswco git:(develope) ✗ pyenv versions
➜  unswco git:(develope) ✗ pyenv global 3.7.0
➜  unswco git:(develope) ✗ pyenv which python
➜  unswco git:(develope) ✗ pyenv uninstall 3.7.0
/Users/henry/.pyenv/versions/3.7.0/bin/python
```

![](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_11_16_FmrbBX.jpg)

## 虚拟环境管理

但区分 python 版本还不够，我们希望一个 python 版本可以对应多个虚拟环境 (分别对应一个 pip 和各种第三方包)，实现物理隔离。

1. **virtualenv**
    每个 pythoner 入门时都会学习的 virtualenv, 就不多做解释了。

2. **virtualenv-wrapper**
    定位为 `virtualenv` 的扩展插件，例如使用 `workon` 即可快速切换不同的 `virtualenv` 目录。

3. **venv**
    Python 3.3 之后官方自带的虚拟环境管理，与 `virtualenv` 在实现上有一定不同，但看不到使用上有什么不同。
    ![](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_11_16_0mlNQX.jpg)

4. **Pipenv**
    `Pipenv` 在项目的依赖管理 (application dependencies) 做的还不错，比如它用了 hash 保证说你开发环境和线上的第三方包依赖是完全一致的。但个人尝试用过两次，确实体验不是很好。

    发现网上有很多争论，感兴趣可以看下，还挺有意思的🍉

    1. <https://chriswarrick.com/blog/2018/07/17/pipenv-promises-a-lot-delivers-very-little/>
    2. <https://github.com/pypa/pipenv/commit/6d77e4a0551528d5d72d81e8a15da4722ad82f26>
    3. <https://np.reddit.com/r/Python/comments/8jd6aq/why_is_pipenv_the_recommended_packaging_tool_by/>

## 注意事项

![使用举例](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_11_16_%E6%9C%AA%E5%91%BD%E5%90%8D.png)
![使用举例](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_11_16_An%20Effective%20Python%20Environment%20Making%20Yourself%20at%20Home.png)
![虚拟环境迁移](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_11_16_Linux%20%E4%B8%8A%20python%E8%99%9A%E6%8B%9F%E7%8E%AF%E5%A2%83%E8%BF%81%E7%A7%BB%E6%96%B9%E6%B3%95.png)
![Cannot switch python with pyenv](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2021_11_16_Clipboard%20-%202021-11-09%2022.45.29.png)
