> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [1024.day](https://1024.day/d/2846)

> Debian 下面是 dd Debian12 命令，自己改一下 root 密码，如果需要 Debian10 或者 11，把命令里的 12 改成你需要的版本就行了： bash <(wget --no-check-ce......

### Debian

下面是 dd Debian12 命令，自己改一下 root 密码，如果需要 Debian10 或者 11，把命令里的 12 改成你需要的版本就行了：

```
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 12 -v 64 -p 密码 -port 22
```

### Ubuntu

下面是 dd Ubuntu20.04 的命令，自己改一下 root 密码，如果需要 Ubuntu 18.04 或者更低版本，改一下版本号就行了（目前脚本还未支持 22.04）：

```
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -u 20.04 -v 64 -p 密码 -port 22
```