> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/w958796636/article/details/53609589)

### 最近在学习 Git，如有说的不正确地方，请大神门指正。

一个很不错的学习 git 网站：

http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000  

  

可以用 github 练习 git

  

  

  

正在拼命的写代码，突然线上出现了一个 bug，需要立刻解决，但是目前的工作空间代码改动挺大的，怎么解决？方法如下：

### 方法 1：在当前主分支修改 bug

暂存当前的改动的代码，目的是让工作空间和远程代码一致：

git stash

修改完 bug 后提交修改：

git add .

git [commit](https://so.csdn.net/so/search?q=commit&spm=1001.2101.3001.7020) -m "fix bug 1"

git push

从暂存区把之前的修改恢复，这样就和之前改动一样了

git stash pop

这时可能会出现冲突，因为你之前修改的文件，可能和 bug 是同一个文件，如果有冲突会提示：

Auto-merging xxx.java

CONFLICT (content): Merge conflict in xxx.java  

前往 xxx.java 解决冲突

注意 stash pop 意思是从暂存区恢复到工作空间，同时删除此条暂存记录。

### 方式 2：拉一个新分支，老司机都推荐这样做，充分利用了 git 特性

先暂存一下工作空间改动：

git stash

新建一个分支，并且换到这个新分支

git branch fix_bug // 新建分支

git checkout fix_bug // 切换分支

这时候就可以安心的在这个 fix_bug 分支改 bug 了，改完之后：

git add .  

git commit -m "fix a bug"

切换到 master 主分支

git checkout master

从 fix_bug 合并到 master 分支

git merge fix_bug

提交代码

git push

然后从暂存区恢复代码

git stash pop

此时如有冲突，需要解决冲突

哈哈，工作空间又恢复到了原状