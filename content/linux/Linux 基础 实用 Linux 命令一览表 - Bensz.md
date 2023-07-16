> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blognas.hwb0307.com](https://blognas.hwb0307.com/linux/linux-basic/445)

> Linux 基础 实用 Linux 命令一览表

本文最后更新于 53 天前，如有失效请评论区留言。

> 有需要可加**[电报群](https://t.me/benszhub "电报群")**获得更多帮助。本博客用什么 **[VPS](https://blognas.hwb0307.com/ad "VPS")**？创作不易，请**[支持](https://blognas.hwb0307.com/thankyou "支持")**苯苯！推荐购买本博客的 **[VIP](https://blognas.hwb0307.com/subscribe "VIP")** 喔，10 元 / 年即可畅享所有 VIP 专属内容！也欢迎大佬对本文进行**[慈善承包](https://blognas.hwb0307.com/enterprise "慈善承包")** (ฅ´ω`ฅ)

*   **2023-05-13**：优化 “SSH 之 VPS 相互信任” 的相关教程。
*   **2023-05-10**：更新 rsync 相关教程。
*   **2023-04-08**：新增 SSH 防自动断开的教程。
*   **2023-03-30**：更新`SSH之登陆黑/白名单`的相关设置。
*   **2023-02-16**：新增 tree 用法；改良其它，如目录结构。
*   **2022-11-13**：改良了 SSH 相关的教程并增强其可读性；更新部分代码以增强可读性！

经过前面一系列学习，相信你已经对 Linux 的很多基本操作都很了解了，比如`cd`、`ls`；使用 Vim 编辑器也越来越顺；还会用一些简单的高级工具，比如`htop`和`ncdu`；了解了一些目录管理的实践方案；甚至已经安装了第一个 Docker 应用`Ward`面板。

我觉得，现在你基本已经入门 Linux 了。以后的路要自己走了。记得好好地利用 [Google](https://www.google.com/ "Google") 和 [Github](https://www.github.com/ "Github")!

这里再助攻一波，发一个我玩 Linux 以来，我觉得比较实用的命令。你在学习 Linux 的时候，也应该**专门建立一个 markdown 文件记录一些你常用的命令**，然后时常回顾和复习。

值得一说的是，如果你用的是自己的主机搭配 Ubuntu 等，其实还有很多可能会用到的比较复杂的设置，比如修改镜像源、设置本地静态 ip、安装无线网卡驱动、禁止更新 Linux 内核啥的。考虑到我们都用的 VPS，就不细说了。有空再补充。

另外，这一页面就不包括咱们此前学习的`cd`、`ls`之类的常用命令了，只包括一些实用但比较少用的 tips。此页面会动态更新。

话不多说，咱们上车！

> [Ubuntu 将 var 目录挂载到新硬盘](https://blog.csdn.net/xzl9811wl/article/details/108189839 "Ubuntu将var目录挂载到新硬盘")

如果你的 VPS 运行时间很久的话，日志管理对于节省空间是很重要的。这里有个[文章](https://blog.csdn.net/ithomer/article/details/89530790 "文章")可以简单参考一下。Docker 的日志管理可见：《[Docker 系列 配置 Docker 全局环境](https://blognas.hwb0307.com/linux/docker/474)》。

```
# 删除目前所有的系统日志sudo rm -rf /var/log/journal/* # 查看日志管理软件是否存在which journalctl # /bin/journalctl # 日志保存的最长时间是1周sudo journalctl --vacuum-time=1w # 日志保存的最大容量是300Msudo journalctl --vacuum-size=300M
```

> 可将 Linux 系统日志所占空间控制到一个较低的水平。Debian/Ubuntu 均适用（日志保存在 / var/log 里的系统原则上均适用），CentOS 未测试。

先检查一下依赖：

```
# 检查依赖，没有的话要自己用apt-get安装which xargs # /usr/bin/xargswhich tee # /usr/bin/tee
```

新建一个文件，比如`clean_system_log.sh`:

```
vim ~/clean_system_log.sh
```

添加以下内容（按需注释某些内容即可）：

```
#! /bin/bash # 清除遗留在/var/cache中的已取回的包文件的本地仓库。它清除的目录是 /var/cache/apt/archives/ 和 /var/cache/apt/archives/partial/apt-get clean # clean journalsrm -rf /var/log/journal/* # clean .gz logs# ls -hlS /var/log/ | grep -E '.gz'ls /var/log/ | grep -E '.gz' | xargs -i rm -r /var/log/{} # Echo nothing to logs# 这里并未将所有的log去除，只是将那些体积比较大的log去除。强迫症患者可以自己添加一些项目进去，比如tallylog/faillog之类的。另外，auth可以查看登陆记录，在意的话可以不删除。ls /var/log/ | grep -E 'syslog|messages|user|daemon|btmp|auth|mail' | xargs -i tee /var/log/{} # Mail ls /var/mail | xargs -i tee /var/mail/{} # Reportecho 'Clean all system logs!'
```

进行权限和软链接映射：

```
sudo chmod +x ~/clean_system_log.sh && sudo ln -s `echo ~`/clean_system_log.sh /usr/bin/clean_system_log
```

最后检查一下是否成功添加为环境变量：

```
which clean_system_log  # /usr/bin/clean_system_log
```

输出`/usr/bin/clean_system_log`的字样说明已经成功。

使用时，只要运行`sudo clean_system_log`即可。你也可以添加到 root 用户的`cron`任务里自动地定期清理系统日志，比如：

```
# clean system logs every 10-day* * */10 * * root /usr/bin/clean_system_log >/dev/null 2>&1
```

中国用户一般是使用北京时间，所以我们最好修改一下时间以适应自己的习惯。

查看时间：

```
# 查看时间date
```

如果要修改时区，可运行下面命令：

```
# 为当前用户tzselect
```

按提示操作即可。如果为当前用户设置选定时区，可用：

```
sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

如果要为所有用户设置选定时区，则编辑下面文件：

```
# 为所有用户sudo vim /etc/profile
```

添加以下记录：

```
TZ='Asia/Shanghai'; export TZsource /etc/profile && source ~/.bashrc
```

如果想修改默认显示语言，可以修改下面文件：

```
# 修改文件sudo vim /etc/default/locale
```

英文一般填写以下内容：

```
# 英文LANG="en_US.UTF-8"LANGUAGE="en_US:en"
```

中文一般填写以下内容：

```
# 中文LANG="zh_CN.UTF-8"LANGUAGE="zh_CN:zh"
```

重启系统生效。

一般还是建议英文吧，慢慢就会习惯了。查 bug 也方便一些不是？

非常重要！非常重要！非常重要！

我们之前也有了解过一些了，就是类似这种`-rw-r--r--`。

**强烈推荐学习参考资料 [Linux chmod 命令](https://www.runoob.com/linux/linux-comm-chmod.html "Linux chmod命令")!**

你也会知道`1,2,4`和`x,w,r`的关系以及他们的排列组合 / 和在改变文件权限上的灵活运用。自己创建一个文件来试玩吧！这个必须要掌握！

这里给一些常用的用户名（组）:

*   `www-data:www-data`的 id 是`33:33`
*   `root:root`的 id 是`0:0`

参考资料：

*   [Linux chmod 命令](https://www.runoob.com/linux/linux-comm-chmod.html "Linux chmod命令")

> 更多细节请参考 [Linux tree 命令 | 菜鸟教程 (runoob.com)](https://www.runoob.com/linux/linux-comm-tree.html "Linux tree命令 | 菜鸟教程 (runoob.com)") 或运行`tree --help`查看。

tree 是非常好用的文件层级结构查看命令。除了`tree -h`，比较实用的形式有:

*   形式 1：`tree -h -L 2`

```
├── [   4]  private│   ├── [   3]  backup│   └── [   5]  lucky-huangwb8└── [   8]  share    ├── [   8]  docker    ├── [   5]  dump    ├── [   2]  images    ├── [   2]  private    ├── [   2]  snippets    └── [   4]  template
```

*   形式 2：`tree -augfCD -L 2`

```
.├── [bensz    bensz    Feb 14 13:56]  ./private│   ├── [bensz    users    Feb 14 13:56]  ./private/backup│   └── [bensz    users    Feb 17 23:39]  ./private/lucky-huangwb8└── [bensz    bensz    Feb 17 19:56]  ./share    ├── [bensz    bensz    Feb 17 23:14]  ./share/docker    ├── [bensz    bensz    Feb 18 07:50]  ./share/dump    ├── [bensz    bensz    Feb 14 12:24]  ./share/images    ├── [bensz    bensz    Feb 14 12:24]  ./share/private    ├── [bensz    bensz    Feb 14 12:24]  ./share/snippets    ├── [bensz    bensz    Feb 17 23:13]  ./share/softwares    └── [bensz    bensz    Feb 14 12:24]  ./share/template
```

> [SSH 登录 Linux 长时间不操作就会自动断开问题 – 腾讯云开发者社区 - 腾讯云](https://cloud.tencent.com/developer/article/1788071 "SSH登录Linux长时间不操作就会自动断开问题 – 腾讯云开发者社区-腾讯云")
> 
> 因为 RackNerd 的机器线路不好，开这个可以大大降低日常使用时的断线概率，推荐使用！

有时候，连接 ssh 时如果没有活动（比如打代码或开 htop 监测），ssh 连接很快就断开，这种现象经常会给我们带来困扰。它在《[Linux 基础 个人 VPS 安全](https://blognas.hwb0307.com/linux/linux-basic/412)》的禁 Ping 操作后更加常见。因此，我**建议将 ssh 的默认连接时间延长**，以防连接中的 Shell 频繁掉线。具体作法如下：

在该 VPS 的 Shell 里输入：

```
vi /etc/ssh/sshd_config
```

找到下面 2 个参数：

```
#ClientAliveInterval 0#ClientAliveCountMax 3
```

去掉前面的注释，并修改值为：

```
ClientAliveInterval 15ClientAliveCountMax 6
```

`ClientAliveInterval`指定了服务器端向客户端请求响应的时间间隔, 默认是 0, 不发送请求；改为 15 秒，则 15 秒发送一次请求，客户端自动响应，这样就保持长连接不会自动断开了。你也可以改一个比 15 更小的正整数。

`ClientAliveCountMax`：指定了服务器发出请求后客户端没有响应的次数达到一定值, 就会自动断开。默认值为 3，这里使用 6 次，以阻碍 ssh 过早地断开。

重启 sshd 服务，使配置生效：

```
service sshd restart
```

通过 ssh 访问另一台主机。不过我们平时都有 MobaXterm、FinalShell 之类的管理软件，感觉这个功能不是很需要。

```
# ssh访问另一台主机ssh alvin@192.168.0.116 # ssh根据特定的端口访问，比如1234ssh alvin@192.168.0.116 -p 1234
```

参考资料：

*   [Linux 下你所不知道的 7 个 SSH 命令用法](https://cloud.tencent.com/developer/article/1548993 "Linux 下你所不知道的 7 个 SSH 命令用法")

**ssh 公私钥**是一个非常实用的功能，特别是你的 VPS 有很多用户时。建议基于 [bitwarden](https://blognas.hwb0307.com/linux/docker/236) 来管理 VPS 和公私钥（即附件功能）。

基本的原理，就是把你的本地主机用户的 **ssh 公匙**文件复制到远程主机用户的`~/.ssh/authorized_keys`文件中。

比如，对于某用户，在本地 VPS 运行此命令：

```
ssh-keygen -t rsa
```

会有三提示输入，第一次是生成的文件名字，第二次和第三次是输入密码，可以直接回车三次则不设置密码。我觉得**家用级别可以不用专门设置密码**，直接空白即可。最后，用户目录`~/.ssh/`会产生两个文件：`id_rsa`（私钥）和`id_rsa.pub`（公钥）。

当然，一种更成熟的做法是：

```
ssh-keygen -t rsa -C "VPS1.Pubkey-to-VPS2"
```

这样产生的公钥和私钥就会有名字。这种做法建议在多人使用 VPS 的情况下使用，这样你就知道该 VPS 信任的公钥对应哪一个用户。

之后，你可以通过这个命令**将本地公钥添加到远程服务器**：

```
# ssh-copy-id -p <远程服务器ssh端口> <远程服务器用户名>@<远程服务器IP或域名>ssh-copy-id -p 22 root@192.168.1.5
```

按提示输入密码即可。之后，你也可以连接到远程服务器里看看公钥是否存在：

```
# ssh -p <port> <远程服务器用户名>@<远程服务器IP或域名>ssh -p 22 root@192.168.1.5cat ~/.ssh/authorized_keys # 内容会包括本地服务器的公钥
```

当然，你也可以直接登陆远程主机，然后在远程主机的 root 用户主目录下的`.ssh`目录内新建（比如通过 Vim）一个名为`authorized_keys`的文件。将本地主机上的`id_rsa.pub`的内容拷贝到该文件内。这样在本地主机上使用`scp`命令复制文件到远程主机上将不提示输入密码了，可以直接复制；该本地主机登陆该远程主机时也不需要密码。

你也可以为 VPS **配置多个 ssh 公钥**。很简单，直接在该 VPS 的`.ssh`目录中的`authorized_keys`文件中添加你想要信任的主机的`id_rsa.pub`的内容即可！

我觉得`ssh-keygen`可以好好的利用，比如**为特定主机设定一定期限的公钥**。自己`ssh-keygen --help`摸索吧！

这个功能在 VSCode 作为终端工具的时候很常用，可以看一下我的博文《[VSCode 作为终端工具替代 FinalShell 和 MobaXterm](https://blognas.hwb0307.com/skill/1248)》。

参考资料：

*   [配置多个 SSH 公钥流程](https://blog.csdn.net/qq_37547964/article/details/120144149 "配置多个SSH公钥流程")
*   [ubuntu 添加多个 ssh 公钥和私钥](https://www.jianshu.com/p/fe215c52c534 "ubuntu 添加多个ssh公钥和私钥")
*   [使用公钥 + 私钥：MobaXterm 设置无密码登录](https://blog.csdn.net/xjp_xujiping/article/details/120291721 "使用公钥+私钥：MobaXterm设置无密码登录")：使用 MobaXterm 的小伙伴可以按此教程设置，实测可行。

> 参考《[使用 hosts.allow 和 hosts.deny 实现简单的防火墙](https://www.cnblogs.com/EasonJim/p/8338931.html "使用hosts.allow和hosts.deny实现简单的防火墙")》。

如果你用登陆 ssh 的 ip 比较固定（比如仅在某局域网内），可以设置一个关于登陆 IP 的白名单，减少安全问题。

对于 Ubuntu/Debian 系统，可以这样查看 ssh 登陆信息：

```
# 检查最近失败登陆次数tail -f -n 30 /var/log/auth.log | grep -E 'sshd' | grep -E 'preauth|error|invalid'
```

如果你的服务器正在被攻击，结果类似这样：

![](https://chevereto.hwb0307.com/images/2023/03/30/MobaXterm1_CHS_RDoEZNZZhz.gif)

你也可以查看历史攻击记录：

```
# 查看异常状态cat /var/log/auth.log | grep -E 'sshd' | grep -E 'preauth|error|invalid' | less
```

那么应该如何应对这种 ssh 暴力破解攻击呢？以下是几点建议：

*   可以根据《[Linux 基础 基于密钥对的 SSH 远程登陆](https://blognas.hwb0307.com/linux/linux-basic/3020)》教程设置禁用 root 密码登陆。
*   对于普通用户，也可以`禁用密码验证`，或者根据《[Docker 系列 搭建密码管理应用 bitwarden](https://blognas.hwb0307.com/linux/docker/236)》教程进行强密码设置和记录。
*   基于`hosts.deny`封禁特定 IP。用 root 权限编辑一个文件：

```
vim /etc/hosts.deny
```

添加某些规则，基本格式是：`daemon, daemon, ...: client, client, ...: option`。比如：

```
#允许192.168.1.18通过SSH登录sshd:192.168.1.18:allow # 禁止可用deny #允许192.168.1.*通过SSH登录sshd:192.168.1.:allow #ALL表示除了上面设置的IP。其他全部拒绝SSH登录sshd:ALL
```

这是我遇到的一些 SSH 暴力破解黑名单有：

```
# 非常恶意，存在用户名试探和暴力破解sshd:46.101.190.103:denysshd:128.199.135.7:denysshd:143.42.58.165:denysshd:139.144.183.199:denysshd:133.242.173.204:denysshd:75.119.139.181:deny
```

最后，用 root 权限重启 ssh 服务：

```
service sshd restart
```

注意，这时不要关闭旧的 Shell。重新登陆，确定自己现在的设备可以成功登陆后，再关掉旧的 Shell。

> Beta 版本，暂未实现。

```
# 确定文件/etc/pam.d/sshd是否存在ls /etc/pam.d/sshd                                                                     # /etc/pam.d/sshd # 确定pam_tally2.so是否存在find /lib* -iname "pam_tally2.so"# /lib/x86_64-linux-gnu/security/pam_tally2.so
```

编辑系统`vim /etc/pam.d/common-auth` （有些系统是 system-auth）文件，在 auth 字段所在的那一部分策 略下面添加如下策略参数：

```
# 普通帐户和root的帐户登录连续5次失败，就统一锁定300秒， 300秒后可以解锁。如果不想限制root 帐户，可以把 even_deny_root、root_unlock_time这两个参数去掉auth required pam_tally2.so  onerr=fail  deny=5  unlock_time=300 even_deny_root root_unlock_time=300
```

故意输错密码，`tail -f /var/log/auth.log`（有些系统是`/var/log/secure`）会有以下信息：

```
Oct 31 07:30:01 openmediavault sshd[1573140]: error: maximum authentication attempts exceeded for XXX from 192.168.1.1 port 51655 ssh2 [preauth]Oct 31 07:30:01 openmediavault sshd[1573140]: Disconnecting authenticating user XXX 192.168.1.1 port 51655: Too many authentication failures [preauth]Oct 31 07:30:01 openmediavault sshd[1573140]: PAM 4 more authentication failures; logname= uid=0 euid=0 tty=ssh ruser= rhost=192.168.1.1  user=XXXOct 31 07:30:01 openmediavault sshd[1573140]: PAM service(sshd) ignoring max retries; 5 > 3
```

上面只是限制了从终端登陆，如果想限制 ssh 远程的话， 要改的是`vim /etc/pam.d/sshd`这个文件，添加的内容跟上面一样！

```
# 检查最近失败登陆次数tail -f -n 30 /var/log/auth.log | grep -E 'sshd' | grep -E 'preauth|error|invalid' # 查看异常状态cat /var/log/auth.log | grep -E 'sshd' | grep -E 'preauth|error|invalid' | less# tail -f /var/log/auth.log | grep -E 'sshd' | grep -E 'preauth|error' # 显示已登录的是连接到服务器的最大数量的IP的列表# netstat -anp |grep -E 'tcp|udp' |awk '{print $20}' |cut -d: -f1 |sort uniq -c |sort -n  # 检查当前你的服务器活跃的连接信息# netstat -n | grep :80 | wc -l
```

参考：

*   [Linux 登录失败处理功能](https://www.cnblogs.com/dadonggg/p/7977099.html "Linux登录失败处理功能")
    
*   [设置 Linux 用户连续 N 次输入错误密码进行登陆时，自动锁定 X 分钟](
    

> 速度比较快、稳定。推荐！ 建议先完成 “**SSH 之 VPS 相互信任**” 的相关设置。

我个人推荐通过 rsync 将本地文件单向复制到远程主机。需要两台主机都带有 rsync。一般都是默认有的，可以用 rsync –version 检查两台主机。 这里是一些 rsync 的用法，大家可以尝试一下：

```
# 方法1nohup rsync -av -P -e --partial 'ssh -p <远程主机的ssh端口号>' <本地文件> <远程主机的用户名>@<远程主机ip>:<远程主机目录> > ~/rsync.log 2>&1 & # 方法2nohup rsync -av -P -e --partial 'ssh -p <远程主机的ssh端口号>' <本地文件> <远程主机的用户名>@<远程主机ip>:<远程主机目录># Ctrl+z 悬挂bg # 放入后台disown %1# 忽略第1个作业的HUP信号 # 方法3：基于screenscreen -dmS rsync_task rsync -av -P -e --partial 'ssh -p <远程主机的ssh端口号>' <本地文件> <远程主机的用户名>@<远程主机ip>:<远程主机目录> > ~/rsync.log
```

参数说明如下：

*   `-a`：这是 `--archive` 的简写形式，用于执行归档模式的复制。归档模式会保留文件的所有属性，包括**所有权、权限、时间戳**等。它还会递归地复制目录，并保持目录结构的完整性。
*   `-v`：这是 `--verbose` 的简写形式，用于显示详细的输出信息。当使用 `-v` 选项时，rsync 会在复制过程中输出更多的信息，以便你可以看到正在进行的操作。
*   `-P`：这是 `--progress` 的简写形式，用于显示复制进度。当使用 `-P` 选项时，rsync 会在复制过程中显示进度条和估计剩余时间。
*   `--partial`：保证断点续传。

当我们将某目录从服务器 A 转移至 B 时，某些应用（比如 wordpress）文件可能会很多，一直开着窗口转移是比较危险的；最好是**让备份命令在后台运行**，即便关闭当前窗口也不影响进程。

文件夹的格式要多加注意。比如，我的 chevereto 的 docker 根目录是`/docker/chevereto`。我建议，根目录和目标目录都要写`/docker/chevereto/`，最后的`/`不要忘记。这样可以实现精确的拷贝。

我之前曾多次使用方法 2，挺稳的；其它方法大家感兴趣可以探索一下。由于认证问题，nohup 或 screen 可能会失败。因此，最好先做好 “SSH 之 VPS 相互信任” 的准备工作。小伙伴们有什么好的经验，也欢迎在评论区留言喔！

> 可行但不推荐

`scp`这个命令用于在两台 VPS 间通过 ssh 协议传输文件（夹）。比如你要备份本地 docker 目录到新主机，就很管用了！苯苯最近就操作过。如果你的远程主机通过公钥信任了本地主机，你传输的时候还不需要密码！

```
# 远程复制文件夹scp -r -p -P <远程主机的ssh端口号> <本地目录> <远程主机的用户名>@<远程主机ip>:<远程主机目录> # 远程复制文件。不用-rscp -p -P <远程主机的ssh端口号> <本地文件> <远程主机的用户名>@<远程主机ip>:<远程主机目录> # 远程主机用的22端口，还不用指定-Pscp -p <本地文件> <远程主机的用户名>@<远程主机ip>:<远程主机目录>
```

参考资料：

*   [scp 在 Linux 主机之间复制文件 / 目录不用输入密码](https://blog.51cto.com/andyzhao/188718 "scp在Linux主机之间复制文件/目录不用输入密码")
    
*   https://blog.csdn.net/m0_37886429/article/details/79641551
    

通过`apt-get`就可以安装了

```
sudo apt-get install trash-cli
```

自己试试看：

```
# 删除文件和目录（仅放入回收站中），也可以trashtrash-put  # 列出被删除了的文件和目录trash-list  # 从回收站中恢复文件或目录 trash.trash-restore # 删除回收站中的文件trash-rm # 清空回收站trash-empty
```

还蛮好用的。不过我平时还是直接`rm`的。习惯了 (～￣▽￣)～

参考资料：

*   [Linux 下设置回收站 Trash](https://www.jianshu.com/p/1f79f41f0e4d "Linux下设置回收站Trash")

如果你想看某个命令的持续变化状态，可以这样

```
watch -n2 <你的命令>
```

这个操作在 NAS 管理里就特别常用，VPS 中用得不多。比如，我想每 2 秒钟查看`zpool status -v nas`这个命令的输出变化，可以这样：

```
watch -n2 zpool status -v nas
```

输出结果如下（`01:56:08 to go`的部分是有变化的）：

![](https://chevereto.hwb0307.com/images/2022/06/13/MobaXterm1_CHS_U9oNkzee4Q.gif)

`watch`对于那种想实时了解运行状态的强迫症患者来说是简直就是个神器，自己体会吧 (～￣▽￣)～

```
# 基本命令ps # 观察当前用户所有进程ps ux ps aux # a-包括其它用户的进程；u-进程的详细内容；x-不是通过终端控制的进程top # 动态观察CPU和内存占用比较高的进程。通过q退出kill PID # 通过进程的PID关闭。不要随便结束以root身份启动的进程kill -9 PID # 用kill无法进行的时候，强行终止
```

这里有个我觉得比较好用的`ps`：

```
ps -ef | grep -E 'multiqc|stats'
```

使用时，将`multiqc|stats`换成你要找的程序的名字。

这里有个我觉得比较好用的`kill`:

```
kill -9 `ps -ef | grep -E 'java' | awk '{print $2}'`
```

使用时，将这个`java`改成你要结束的进程名字（某段特征也行）

```
ifconfig|less
```

大多数情况下，`docker0`和`echXXX`这两个网络的信息对我们比较重要。

```
# 查看自己的网卡ifconfig|grep eth # 很多人都是eth0 # 安装nethogssudo apt-get install nethogs
```

通过 nethogs 可以实时查看流量消耗：

```
# 查看网速sudo nethogs eth0
```

它是一个动态页面：

![](https://chevereto.hwb0307.com/images/2022/04/21/image-20220421084114639.png)

之前我们学习的`neofetch`也可以看。这里介绍其它的一些命令：

```
# 查看基本信息lshw -short|less  # 查看详细信息lshw|less  #查看系统信息uname -a  sudo dmidecode | grep "System Information" -A9 | egrep "Manufacturer|Product|Serial"  # 查看服务器型号、序列号 # 查看BIOS信息sudo dmidecode -t bios  # # 查看内存槽及内存条sudo dmidecode -t memory | head -45 | tail -23  # 查看网卡信息sudo dmesg | grep -i Ethernet # 查看pci信息，即主板所有硬件槽信息lspci | head -10  # 查看显卡 sudo lspci  | grep -i vga
```

这里还可以推荐一个工具，叫做`hardinfo`。你可以用`apt-get`来安装它：

```
sudo apt-get install hardinfo
```

然后使用方法也蛮简单的，就是：

```
sudo hardinfo | less
```

之所以用`less`，是因为它会输出一大堆东西，用`less`命令观察会比较方便。`f`向前翻页，`b`向后翻页，`q`退出。

扩展阅读：

*   [Linux 基础 - 查看 cpu、内存和环境等信息](https://www.cnblogs.com/armcvai/p/16921527.html "Linux 基础-查看 cpu、内存和环境等信息")

```
curl ifconfig.me
```

编辑文件内容：

```
# 另一种比较流行的命令是： crontab -evim /etc/crontab
```

具体用法我不多说了。自己看参考资料吧！口诀：`分时日月周`。

一种比较快捷的方法是直接在 Shell 里输入类似命令：

```
echo -e "\n# 关于这条cron记录的说明\n0 */1 * * * root /usr/bin/bash /root/disk_warning.sh" >> /etc/crontab
```

结果类似于：

![](https://chevereto.hwb0307.com/images/2023/02/14/NVIDIA_Share_1ZmNKIOLy3.webp)

cron 还可以用于开机自启。比如，如果开机想要执行`cd /var/www/node/ && npm run start`，可以这样：

```
# 开机启动@reboot cd /var/www/node/ && npm run start # 延迟10秒启动@reboot sleep 10 &&  cd /var/www/node/ && npm run start
```

参考资料：

*   [Linux crontab 命令](https://www.runoob.com/linux/linux-comm-crontab.html "Linux crontab 命令")
*   [第七星尘的独立博客 | linux 利用 cron 定时服务来实现开机启动某些应用](https://blog.star7th.com/2023/02/2546.html "第七星尘的独立博客 | linux利用cron定时服务来实现开机启动某些应用")

```
# 压缩为tar.gztar zvfc test.tar.gz ~/test/ # 解压为tar.gztar zvfx test.tar.gz # 解压zipunzip test.zip # 直接查看文本类的tar.gzzcat text.tar.gz|less
```

一般这几个比较常用。还有一些`gzip`啥，你用到的时候自己 Google 一下。

如果你不知道什么是`conda`或者`anaconda`，你百度一下`Ubuntu安装conda`。

它是一个软件版本控制的平台。**利用 conda，你可以在同一台电脑中配置无数个不同的环境（多个软件不同版本的搭配）。**你可能不知道我在说什么。总之，你知道它是一个生产力工具就行了。

**你在玩`Docker`的时候并不需要`conda`。**你只要知道它，以后有需要的话就使用它吧！

如果你是生物信息学、人工智能或者是 Python 的学习者，这个东西我不说你也知道。如果你了解过`python2`和`python3`那些事，相信你也会不由自主地喜欢上`conda`的。

言尽于此，自己体会！

这一回写完，我们的 Linux 基础也觉得差不多了。以后要精进，还是要靠多查书、多检索、多试错。苯苯也在慢慢地学习中呢！

而且有了这些基础，相信你已经迫不及待地想要了解 docker 怎么使用了！我也是呀！

在本博客中，我会介绍那些最经典的 Docker 应用。毫不夸张地说，**这些 Docker 应用彻底地改变了我的生活**。相信你以后也会有同感的！

*   [将 conda 虚拟环境设置为电脑默认的 python 环境](https://blog.csdn.net/zsc201825/article/details/106792350 "将conda虚拟环境设置为电脑默认的python环境")

---------------  
_完结，撒花！如果您点一下广告，可以养活苯苯_😍😍😍

基于 [m2w](https://blognas.hwb0307.com/linux/docker/2813 "m2w") 创作。版权声明：除特殊说明，博客文章均为 Bensz 原创，依据 [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/ "CC BY-SA 4.0") 许可证进行授权，转载请附上出处链接及本声明。**VIP 内容严禁转载**！由于可能会成为 AI 模型（如 chatGPT）的训练样本，**本博客禁止将 AI 自动生成内容作为文章上传（特别声明时除外）**。如有需要，请至[学习地图](https://blognas.hwb0307.com/other/447)系统学习本博客的教程。加 [Telegram 群](https://t.me/benszhub "Telegram群")可获得更多帮助喔！ | 博客订阅：[RSS](https://blognas.hwb0307.com/feed "RSS") | 广告招租请[留言](https://blognas.hwb0307.com/lyb "留言") | [博客 VPS](https://blognas.hwb0307.com/ad "博客VPS") | 致谢[渺软公益 CDN](https://cdn.onmicrosoft.cn/ "渺软公益CDN") |