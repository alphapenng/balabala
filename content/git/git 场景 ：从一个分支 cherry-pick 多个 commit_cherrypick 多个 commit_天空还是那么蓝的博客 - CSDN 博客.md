> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/w958796636/article/details/78492017)

场景：

在 branch1 分支上开发，已经产生多个提交，这时需要切换到 branch2，想把之前 branch1 分支提交的 [commit](https://so.csdn.net/so/search?q=commit&spm=1001.2101.3001.7020) 都【复制】过来，怎么办？

首先切换到 branch1 分支，然后查看提交历史记录，也可以用 [sourceTree](https://so.csdn.net/so/search?q=sourceTree&spm=1001.2101.3001.7020) 查看，也可以用命令 git log

例如我的 git log 如下：

commit 023sb6f299849a1fec3bbe72baaf315482522cb6  
Author: sunguowei <me@xx.com>  
Date:   Thu Nov 9 11:01:13 2017 +0800  
    修复 bug 3  
    Change-Id: I30850819d3dcfb8814b5d67124133215a4469374  
commit 5d2c18fsf4b85b4564991963d7c3c3917e951364  
Author: sunguowei <me@xx.com>  
Date:   Wed Nov 8 16:33:58 2017 +0800  
   修复 bug 2  
    Change-Id: I0c94d305a35ef8372afc127b2eab13f4ebb70386  
commit ba51861402b0a18663f2c9ee28ed054b0879b225  
Author: shenjiaqi <other@xx.com>  
Date:   Sun Nov 5 18:50:28 2017 +0800  
修复 bug 1  
    Change-Id: I32a8e29523f709eed59f6044c7a06311e953727e

我想把 bug 2 和 bug3 复制到 branch2 分支里，只需要这样

切换到 branch2 分支，然后执行

git cherry-pick ba51861..023sb6f299849a1f

注意：（1）中间的两个点，表示把两个 commit 区间的所有 commit 多复制过去

          （2）ba51861 这一串字符串，叫做 commit id，可以用完整的 commit id，也可以从头开始截取部分，尽量长一点（才能唯一）。

cherry-pick 用法

单个 commit 只需要 git cherry-pick commitid

多个 commit 只需要 git cherry-pick commitid1..commitid100

**注意，不包含第一个 commitid ， 即  git cherry-pick (commitid1..commitid100]**

**如果 cherry-pick 过程有冲突，先解决冲突，然后 git add.  再执行 git cherry-pick --continue**