> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/w958796636/article/details/56667670)

本地代码修改完毕，该提交了，开始准备提交

【看一眼当前状态，命令：git status】

B000000095605B:test baidu$ git status

On branch master

Your branch is up-to-date with 'origin/master'.

Changes not staged for commit:

(use "git add <file>..." to update what will be committed)

(use "git checkout -- <file>..." to discard changes in working directory)

modified:   gradle.properties

no changes added to commit (use "git add" and/or "git commit -a")

【看到了自己只修改了一个文件，好的，执行 add】

B000000095605B:test baidu$ git add .

【执行 commit】

B000000095605B:test baidu$ git commit -m "我修复了一个 bug"

[master 8e1d5bb] 我修复了一个 bug

 1 file changed, 1 insertion(+)

【执行 push 到远程】

B000000095605B:test baidu$ git push

To https://github.com/yiwowang/test.git

! [rejected]        master -> master (fetch first)

error: failed to push some refs to 'https://github.com/yiwowang/test.git'

hint: Updates were rejected because the remote contains work that you do

hint: not have locally. This is usually caused by another repository pushing

hint: to the same ref. You may want to first integrate the remote changes

hint: (e.g., 'git pull ...') before pushing again.

hint: See the 'Note about fast-forwards' in 'git push --help' for details.

【我靠，什么情况？没有 push 成功，咋被服务器拒绝了呢。原来是这个文件有冲突，也就是远程仓库的此文件被另一个人改了，好吧，我把远程代码拉下来吧】

B000000095605B:test baidu$ git pull --rebase

remote: Counting objects: 3, done.

remote: Total 3 (delta 1), reused 1 (delta 1), pack-reused 2

Unpacking objects: 100% (3/3), done.

From https://github.com/yiwowang/test

d239d59..f4b4a74  master     -> origin/master

First, rewinding head to replay your work on top of it...

Applying: 我修复了一个 bug

Using index info to reconstruct a base tree...

M

gradle.properties

Falling back to patching base and 3-way merge...

Auto-merging gradle.properties

CONFLICT (content): Merge conflict in gradle.properties

error: Failed to merge in the changes.

Patch failed at 0001 我修复了一个 bug

The copy of the patch that failed is found in: .git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".

If you prefer to skip this patch, run "git rebase --skip" instead.

To check out the original branch and stop rebasing, run "git rebase --abort".

【可以看到这句话：CONFLICT (content): Merge conflict in gradle.properties，说明这个文件冲突，我就打开这个文件解决冲突】

【冲突解决完毕，然后看一下状态】

B000000095605B:test baidu$ git status

rebase in progress; onto f4b4a74

You are currently rebasing branch 'master' on 'f4b4a74'.

(fix conflicts and then run "git rebase --continue")

(use "git rebase --skip" to skip this patch)

(use "git rebase --abort" to check out the original branch)

Unmerged paths:

(use "git reset HEAD <file>..." to unstage)

(use "git add <file>..." to mark resolution)

both modified:   gradle.properties

no changes added to commit (use "git add" and/or "git commit -a")

【执行 add】

B000000095605B:test baidu$ git add .

【看一下所处于的分支，发现是一个临时分支，还没有 rebase 完成】

B000000095605B:test baidu$ git branch

* (no branch, rebasing master)

dev

  master

【继续 rebase】

B000000095605B:test baidu$ git rebase --continue

Applying: 我尝试提交

【看一下状态，说明可以 push 了】

B000000095605B:test baidu$ git status

On branch master

Your branch is ahead of 'origin/master' by 1 commit.

(use "git push" to publish your local commits)

nothing to commit, working tree clean

【执行 push】

B000000095605B:test baidu$ git push

Counting objects: 3, done.

Delta compression using up to 4 threads.

Compressing objects: 100% (3/3), done.

Writing objects: 100% (3/3), 314 bytes | 0 bytes/s, done.

Total 3 (delta 2), reused 0 (delta 0)

remote: Resolving deltas: 100% (2/2), completed with 2 local objects.

To https://github.com/yiwowang/test.git

   f4b4a74..6e7cf9a  master -> master

【在看一下状态，“没有需要提交的了，工作空间是干净的”】

B000000095605B:test baidu$ git status

On branch master

Your branch is up-to-date with 'origin/master'.

nothing to commit, working tree clean