> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/w958796636/article/details/53611133)

写完代码后，我们一般这样

git add . // 添加所有文件

git [commit](https://so.csdn.net/so/search?q=commit&spm=1001.2101.3001.7020) -m "本功能全部完成"

执行完 commit 后，想撤回 commit，怎么办？

这样凉拌：

**git reset --soft HEAD^**

这样就成功的撤销了你的 commit

注意，仅仅是撤回 commit 操作，您写的代码仍然保留。  

说一下个人理解：
--------

HEAD^ 的意思是上一个版本，也可以写成 HEAD~1

如果你进行了 2 次 commit，想都撤回，可以使用 HEAD~2

至于这几个参数：
--------

--mixed 
--------

意思是：不删除工作空间改动代码，撤销 commit，并且撤销 git add . 操作

这个为默认参数，git reset --mixed HEAD^ 和 git reset HEAD^ 效果是一样的。  

--soft  
--------

不删除工作空间改动代码，撤销 commit，不撤销 git add . 

  

--hard
------

删除工作空间改动代码，撤销 commit，撤销 git add . 

注意完成这个操作后，就恢复到了上一次的 commit 状态。

### 顺便说一下，如果 commit 注释写错了，只是想改一下注释，只需要：

git commit --amend

此时会进入默认 vim 编辑器，修改注释完毕后保存就好了。