> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mona.xlog.app](https://mona.xlog.app/linuxcmd?locale=zh-TW)

> 1. 基本命令 Copy uname -m 显示机器的处理器架构 uname -r 显示正在使用的内核版本 dmidecode -q 显示硬件系统部件 (SMBIOS / DMI) hdparm -i ......

**1. 基本命令**

```
uname -m 显示机器的处理器架构
uname -r 显示正在使用的内核版本
dmidecode -q 显示硬件系统部件
(SMBIOS / DMI) hdparm -i /dev/hda 罗列一个磁盘的架构特性
hdparm -tT /dev/sda 在磁盘上执行测试性读取操作系统信息
arch 显示机器的处理器架构
uname -m 显示机器的处理器架构
uname -r 显示正在使用的内核版本
dmidecode -q 显示硬件系统部件 - (SMBIOS / DMI)
hdparm -i /dev/hda 罗列一个磁盘的架构特性
hdparm -tT /dev/sda 在磁盘上执行测试性读取操作
cat /proc/cpuinfo 显示CPU info的信息
cat /proc/interrupts 显示中断
cat /proc/meminfo 校验内存使用
cat /proc/swaps 显示哪些swap被使用
cat /proc/version 显示内核的版本
cat /proc/net/dev 显示网络适配器及统计
cat /proc/mounts 显示已加载的文件系统
lspci -tv 罗列 PCI 设备
lsusb -tv 显示 USB 设备
date 显示系统日期
cal 2007 显示2007年的日历表
date 041217002007.00 设置日期和时间 - 月日时分年.秒
clock -w 将时间修改保存到 BIOS
```

**2. 关机**

**3. 文件和目录**

```
shutdown -h now 关闭系统(1)
init 0 关闭系统(2)
telinit 0 关闭系统(3)
shutdown -h hours:minutes & 按预定时间关闭系统
shutdown -c 取消按预定时间关闭系统
shutdown -r now 重启(1)
reboot 重启(2)
logout 注销
```

**4. 文件搜索**

**5. 挂载一个文件系统**

```
cd /home 进入 '/ home' 目录'
cd .. 返回上一级目录
cd ../.. 返回上两级目录
cd 进入个人的主目录
cd ~user1 进入个人的主目录
cd - 返回上次所在的目录
pwd 显示工作路径
ls 查看目录中的文件
ls -F 查看目录中的文件
ls -l 显示文件和目录的详细资料
ls -a 显示隐藏文件
ls *[0-9]* 显示包含数字的文件名和目录名
tree 显示文件和目录由根目录开始的树形结构(1)
lstree 显示文件和目录由根目录开始的树形结构(2)
mkdir dir1 创建一个叫做 'dir1' 的目录'
mkdir dir1 dir2 同时创建两个目录
mkdir -p /tmp/dir1/dir2 创建一个目录树
rm -f file1 删除一个叫做 'file1' 的文件'
rmdir dir1 删除一个叫做 'dir1' 的目录'
rm -rf dir1 删除一个叫做 'dir1' 的目录并同时删除其内容
rm -rf dir1 dir2 同时删除两个目录及它们的内容
mv dir1 new_dir 重命名/移动 一个目录
cp file1 file2 复制一个文件
cp dir/* . 复制一个目录下的所有文件到当前工作目录
cp -a /tmp/dir1 . 复制一个目录到当前工作目录
cp -a dir1 dir2 复制一个目录
ln -s file1 lnk1 创建一个指向文件或目录的软链接
ln file1 lnk1 创建一个指向文件或目录的物理链接
touch -t 0712250000 file1 修改一个文件或目录的时间戳 - (YYMMDDhhmm)
file file1 outputs the mime type of the file as text
iconv -l 列出已知的编码
iconv -f fromEncoding -t toEncoding inputFile > outputFile creates a new from the given input file by assuming it is encoded in fromEncoding and converting it to toEncoding.
find . -maxdepth 1 -name *.jpg -print -exec convert "{}" -resize 80x60 "thumbs/{}" \; batch resize files in the current directory and send them to a thumbnails directory (requires convert from Imagemagick)
```

**6. 磁盘空间**

```
find / -name file1 从 '/' 开始进入根文件系统搜索文件和目录
find / -user user1 搜索属于用户 'user1' 的文件和目录
find /home/user1 -name \*.bin 在目录 '/ home/user1' 中搜索带有'.bin' 结尾的文件
find /usr/bin -type f -atime +100 搜索在过去100天内未被使用过的执行文件
find /usr/bin -type f -mtime -10 搜索在10天内被创建或者修改过的文件
find / -name \*.rpm -exec chmod 755 '{}' \; 搜索以 '.rpm' 结尾的文件并定义其权限
find / -xdev -name \*.rpm 搜索以 '.rpm' 结尾的文件，忽略光驱、捷盘等可移动设备
locate \*.ps 寻找以 '.ps' 结尾的文件 - 先运行 'updatedb' 命令
whereis halt 显示一个二进制文件、源码或man的位置
which halt 显示一个二进制文件或可执行文件的完整路径
```

**7. 用户和群组**

**8. 文件的权限，使用 “+” 设置权限，使用 “-” 用于取消**

```
mount /dev/hda2 /mnt/hda2 挂载一个叫做hda2的盘 - 确定目录 '/ mnt/hda2' 已经存在
umount /dev/hda2 卸载一个叫做hda2的盘 - 先从挂载点 '/ mnt/hda2' 退出
fuser -km /mnt/hda2 当设备繁忙时强制卸载
umount -n /mnt/hda2 运行卸载操作而不写入 /etc/mtab 文件- 当文件为只读或当磁盘写满时非常有用
mount /dev/fd0 /mnt/floppy 挂载一个软盘
mount /dev/cdrom /mnt/cdrom 挂载一个cdrom或dvdrom
mount /dev/hdc /mnt/cdrecorder 挂载一个cdrw或dvdrom
mount /dev/hdb /mnt/cdrecorder 挂载一个cdrw或dvdrom
mount -o loop file.iso /mnt/cdrom 挂载一个文件或ISO镜像文件
mount -t vfat /dev/hda5 /mnt/hda5 挂载一个Windows FAT32文件系统
mount /dev/sda1 /mnt/usbdisk 挂载一个usb 捷盘或闪存设备
mount -t smbfs -o username=user,password=pass //WinClient/share /mnt/share 挂载一个windows网络共享
```

**9. 文件的特殊属性 ，使用 “+” 设置权限，使用 “-” 用于取消**

**10. 打包和压缩文件**

**11. RPM 包**

```
df -h 显示已经挂载的分区列表
ls -lSr |more 以尺寸大小排列文件和目录
du -sh dir1 估算目录 'dir1' 已经使用的磁盘空间'
du -sk * | sort -rn 以容量大小为依据依次显示文件和目录的大小
rpm -q -a --qf '%10{SIZE}t%{NAME}n' | sort -k1,1n 以大小为依据依次显示已安装的rpm包所使用的空间 (fedora, redhat类系统)
dpkg-query -W -f='${Installed-Size;10}t${Package}n' | sort -k1,1n 以大小为依据显示已安装的deb包所使用的空间 (ubuntu, debian类系统)
```

**12. YUM 软件包升级器**

**13. deb 包**

```
groupadd group_name 创建一个新用户组
groupdel group_name 删除一个用户组
groupmod -n new_group_name old_group_name 重命名一个用户组
useradd -c "Name Surname " -g admin -d /home/user1 -s /bin/bash user1 创建一个属于 "admin" 用户组的用户
useradd user1 创建一个新用户
userdel -r user1 删除一个用户 ( '-r' 排除主目录)
usermod -c "User FTP" -g system -d /ftp/user1 -s /bin/nologin user1 修改用户属性
passwd 修改口令
passwd user1 修改一个用户的口令 (只允许root执行)
chage -E 2005-12-31 user1 设置用户口令的失效期限
pwck 检查 '/etc/passwd' 的文件格式和语法修正以及存在的用户
grpck 检查 '/etc/passwd' 的文件格式和语法修正以及存在的群组
newgrp group_name 登陆进一个新的群组以改变新创建文件的预设群组
```

**14. 查看文件内容**

**15. 文本处理**

**16. 字符设置和文件格式转换**

**17. 文件系统分析**

**18. 初始化一个文件系统**

**19. SWAP 文件系统**

**20. 备份**

```
ls -lh 显示权限
ls /tmp | pr -T5 -W$COLUMNS 将终端划分成5栏显示
chmod ugo+rwx directory1 设置目录的所有人(u)、群组(g)以及其他人(o)以读（r ）、写(w)和执行(x)的权限
chmod go-rwx directory1 删除群组(g)与其他人(o)对目录的读写执行权限
chown user1 file1 改变一个文件的所有人属性
chown -R user1 directory1 改变一个目录的所有人属性并同时改变改目录下所有文件的属性
chgrp group1 file1 改变文件的群组
chown user1:group1 file1 改变一个文件的所有人和群组属性
find / -perm -u+s 罗列一个系统中所有使用了SUID控制的文件
chmod u+s /bin/file1 设置一个二进制文件的 SUID 位 - 运行该文件的用户也被赋予和所有者同样的权限
chmod u-s /bin/file1 禁用一个二进制文件的 SUID位
chmod g+s /home/public 设置一个目录的SGID 位 - 类似SUID ，不过这是针对目录的
chmod g-s /home/public 禁用一个目录的 SGID 位
chmod o+t /home/public 设置一个文件的 STIKY 位 - 只允许合法所有人删除文件
chmod o-t /home/public 禁用一个目录的 STIKY 位
chmod +x 文件路径 为所有者、所属组和其他用户添加执行的权限
chmod -x 文件路径 为所有者、所属组和其他用户删除执行的权限
chmod u+x 文件路径 为所有者添加执行的权限
chmod g+x 文件路径 为所属组添加执行的权限
chmod o+x 文件路径 为其他用户添加执行的权限
chmod ug+x 文件路径 为所有者、所属组添加执行的权限
chmod =wx 文件路径 为所有者、所属组和其他用户添加写、执行的权限，取消读权限
chmod ug=wx 文件路径 为所有者、所属组添加写、执行的权限，取消读权限
```

**21. 光盘**

**22. 网络（以太网和 WIFI 无线）**

```
chattr +a file1 只允许以追加方式读写文件
chattr +c file1 允许这个文件能被内核自动压缩/解压
chattr +d file1 在进行文件系统备份时，dump程序将忽略这个文件
chattr +i file1 设置成不可变的文件，不能被删除、修改、重命名或者链接
chattr +s file1 允许一个文件被安全地删除
chattr +S file1 一旦应用程序对这个文件执行了写操作，使系统立刻把修改的结果写到磁盘
chattr +u file1 若文件被删除，系统会允许你在以后恢复这个被删除的文件
lsattr 显示特殊的属性
```

**23. 列出目录内容**

**24. 查看文件的类型**

```
bunzip2 file1.bz2 解压一个叫做 'file1.bz2'的文件
bzip2 file1 压缩一个叫做 'file1' 的文件
gunzip file1.gz 解压一个叫做 'file1.gz'的文件
gzip file1 压缩一个叫做 'file1'的文件
gzip -9 file1 最大程度压缩
rar a file1.rar test_file 创建一个叫做 'file1.rar' 的包
rar a file1.rar file1 file2 dir1 同时压缩 'file1', 'file2' 以及目录 'dir1'
rar x file1.rar 解压rar包
unrar x file1.rar 解压rar包
tar -cvf archive.tar file1 创建一个非压缩的 tarball
tar -cvf archive.tar file1 file2 dir1 创建一个包含了 'file1', 'file2' 以及 'dir1'的档案文件
tar -tf archive.tar 显示一个包中的内容
tar -xvf archive.tar 释放一个包
tar -xvf archive.tar -C /tmp 将压缩包释放到 /tmp目录下
tar -cvfj archive.tar.bz2 dir1 创建一个bzip2格式的压缩包
tar -xvfj archive.tar.bz2 解压一个bzip2格式的压缩包
tar -cvfz archive.tar.gz dir1 创建一个gzip格式的压缩包
tar -xvfz archive.tar.gz 解压一个gzip格式的压缩包
zip file1.zip file1 创建一个zip格式的压缩包
zip -r file1.zip file1 file2 dir1 将几个文件和目录同时压缩成一个zip格式的压缩包
unzip file1.zip 解压一个zip格式压缩包
```

**25. 复制文件目录**

1、cp：复制文件和目录 cp 源文件（文件夹）目标文件（文件夹）。

常用参数：-r: 递归复制整个目录树；-v：显示详细信息；

复制文件夹时要在 cp 命令后面加一个 - r 参数：

如：cp -r 源文件夹  目标文件夹。

2、touch + 文件名：当文件不存在的时候，创建相应的文件；当文件存在的时候，修改文件的创建时间。

功能：生成一个空文件或修改文件的存取 / 修改的时间记录值；

touch * ：将当前下的文件时间修改为系统的当前时间；

touch –d 20040210 test：将 test 文件的日期改为 20040210；

touch abc：若 abc 文件存在，则修改为系统的当前时间；若不存在，则生成一个为当前时间的空文件。

3、mv 文件 目标目录：移动或重命名文件或目录（如果指定文件名，则可以重命名文件）。可以将文件及目录移到另一目录下，或更改文件及目录的名称。

格式为：mv [参数]< 源文件或目录 > < 目标文件或目录 >

mva.txt ../：将 a.txt 文件移动上层目录

mv a.txt b.txt：将 a.txt 改名为 b.txt

mvdir2 ../：将 dir2 目录上移一层

4、rm：删除文件

常用参数：-i：交互式   -r：递归的删除包括目录中的所有内容。

5、mkdir + 文件夹名称：创建文件夹

6、rm -r + 文件夹名称：删除文件夹（空文件夹和非空文件夹都可删除）；

rmdir 文件夹名称：删除文件夹（只能删除空文件夹）。

7、mkdir  -p dir1/dir2 ：在当前目录下创建 dir1 目录，并在 dir1 目录下创建 dir2 目录， 也就是连续创建两个目录（dir1 / 和 dir1/dir2）。

8、rmdir –p dir1/dir2：删除 dir1 下的 dir2 目录，若 dir1 目录为空也删除它。

9、rm * ：删除当前目录下的所有文件

10、-f 参数：强迫删除文件 rm –f  *.txt：强迫删除所有以后缀名为 txt 文件。

11、-i 参数：删除文件时询问

rm　–i  * ：删除当前目录下的所有文件会有如下提示：

rm:backup a directory　　　 遇到目录会略过

rm: remove ‘myfiles.txt’ ? Y

删除文件时会询问，可按 Y 或 N 键表示允许或拒绝删除文件。　

12、-r 参数：递归删除（连子目录一同删除，这是一个相当常用的参数）。

rm  -r test ：删除 test 目录（含 test 目录下所有文件和子目录）；

rm  -r  *：删除所有文件（含当前目录所有文件、所有子目录和子目录下的文件） 一般在删除目录时 r 和 f 一起用，避免麻烦；

rm  -rf test ：强行删除、不加询问。

13、grep：功能：在文件中搜索匹配的字符并进行输出。

格式：grep [参数] < 要找的字串 > < 要寻找字 串的源文件 >

greplinux test.txt：搜索 test.txt 文件中字符串 linux 并输出。

14、ln 命令

功能：在文件和目录之间建立链接

格式：ln [参数] < 源文件或目录 > < 目标文件或目录 >

链接分 “软链接” 和 “硬链接”

1.  软链接:

ln–s /usr/share/do  doc ：创建一个链接文件 doc，并指向目录 /usr/share/do

2.  硬链接:

ln  /usr/share/test  hard：创建一个硬链接文件 hard，这时对于 test 文件对应 的存储区域来说，又多了一个文件指向它。

**26. 系统常用命令**

1、显示命令

date: 查看或设置当前系统的时间：格式化显示时间：+% Y--% m--% d；

date -s: 设置当前系统的时间；

hwclock (clock)：显示硬件时钟时间 (需要管理员权限)；

cal：查看日历；

格式 cal [参数] 月年；

cal：显示当月的日历   cal4 2004 ：显示 2004 年 4 月的日历；

cal- y 2003：显示 2003 年的日历；

uptime：查看系统运行时间。

2、输出查看命令

echo：显示输入的内容  追加文件 echo "liuyazhuang" >> liuyazhuang.txt

cat：显示文件内容，也可以将数个文件合并成一个文件；

格式：格式：cat [参数]< 文件名 >

cat  test.txt：显示 test.txt 文件内容；

cat  test.txt | more  ：逐页显示 test.txt 文件中的内容；

cat  test.txt >> test1.txt ：将 test.txt 的内容附加到 test1.txt 文件之后；

cat  test.txt test2.txt >readme.txt　: 将 test.txt 和 test2.txt 文件合并成 readme.txt 文件；

head: 显示文件的头几行（默认 10 行） -n: 指定显示的行数格式：head -n 文件名；

tail：显示文件的末尾几行（默认 10 行）-n：指定显示的行数   -f：追踪显示文件更新 （一般用于查看日志，命令不会退出，而是持续显示新加入的内容）；

格式：格式：tail [参数]< 文件名 >

tail-10 /etc/passwd ：显示 /etc/passwd/ 文件的倒数 10 行内容；

tail+10 /etc/passwd ：显示 /etc/passwd/ 文件从第 10 行开始到末尾的内容；

more：用于翻页显示文件内容（只能向下翻页）；

more 命令是一般用于要显示的内容会超过一个画面长度的情况。为了避免画  面显示时瞬间就闪过去，用户可以使用 more 命令，让画面在显示满一页时暂停，此时可按空格健继续显示下一个画面，或按 Q 键停止显示；

ls  -al  |more：以长格形式显示 etc 目录下的文件列表，显示满一个画面便暂停，可 按空格键继续显示下一画面，或按 Q 键跳离；

less：翻页显示文件内容（带上下翻页）按下上键分页，按 q 退出；

less 命令的用法与 more 命令类似，也可以用来浏览超过一页的文件。所不同  的是 less 命令除了可以按空格键向下显示文件外，还可以利用上下键来卷动文件。当要结束浏览时，只要在 less 命令的提示符 “：” 下按 Q 键即可；

ls  -al | less：以长格形式列出 /etc 目录中所有的内容。用户可按上下键浏览或按 Q 键跳离。

3、查看硬件信息

Ispci：查看 PCI 设备  -v：查看详细信息

Isusb：查看 USB 设备 -v：查看详细信息

Ismod：查看加载的模块 (驱动)

4、关机、重启

shutdown 关闭、重启计算机

shutdown [关机、重启] 时间  -h 关闭计算机   -r：重启计算机

如：立即关机：shutdown -h now

10 分钟后关机：shutdown -h +10

23:30 分关机：shutdown -h 23:30

立即重启：shutdown -r now

poweroff：立即关闭计算机

reboot：立即重启计算机

5、归档、压缩

zip: 压缩文件  zip liuyazhuang.zip myfile  格式为：“zip 压缩后的 zip 文件文件名”

unzip：解压文件  unzip liuyazhuang.zip

gzip：压缩文件 gzip 文件名

tar：归档文件

tar -cvf out.tar liuyazhuang  打包一个归档（将文件 "liuyazhuang" 打包成一个归档）

tar -xvf liuyazhuang.tar     释放一个归档（释放 liuyazhuang.tar 归档）

tar -cvzf backup.tar.gz/etc  

-z 参数将归档后的归档文件进行 gzip 压缩以减少大小。

-c：创建一个新 tar 文件

-v：显示运行过程的信息

-f：指定文件名

-z：调用 gzip 压缩命令进行压缩

-t：查看压缩文件的内容

-x：解开 tar 文件

tar  -cvf test.tar  *：将所有文件打包成 test.tar, 扩展名. tar 需自行加上

tar  -zcvf test.tar.gz  *：将所有文件打包成 test.tar, 再用 gzip 命令压缩

tar -tf   test.tar ：查看 test.tar 文件中包括了哪些文件

tar -xvf test.tar       将 test.tar 解开

tar -zxvf foo.tar.gz   解压缩

gzip 各 gunzip 命令

gziptest.txt ：压缩文件时，不需要任何参数

gizp–l test.txt.gz：显示压缩率

6、查找

locate：快速查找文件、文件夹：locate keyword

此命令需要预先建立数据库，数据库默认每天更新一次，可用 updatedb 命令手工建立、更新数据库。

find 查找位置查找参数

如：

find . -name _liuyazhuang_ 查找当前目录下名称中含有 "liuyazhuang" 的文件

find /-name *.conf  查找根目录下（整个硬盘）下后缀为. conf 的文件

find /-perm 777 查找所有权限是 777 的文件

find /-type d 返回根目录下所有的目录

find . -name "a*"-exec ls -l {} ;

find 功能：用来寻找文件或目录

格式：find [<路径>] [匹配条件]

find /-name httpd.conf  搜索系统根目录下名为 httpd.conf 的文件

7、ctrl+c : 终止当前的命令

8、who 或 w 命令

功能：查看当前系统中有哪些用户登录

格式：who/w [参数]

9、dmesg 命令

功能：显示系统诊断信息、操作系统版本号、物理内存的大小以及其它信息。

10、df 命令

功能：用于查看文件系统的各个分区的占用情况。

11、du 命令

功能：查看某个目录中各级子目录所使用的硬盘空间数。

格式：du [参数] < 目录名 >

12、free 命令

功能：用于查看系统内存，虚拟内存（交换空间）的大小占用情况。

27.  VIM

VIM 是一款功能强大的命令行文本编辑器，在 Linux 中通过 vim 命令可以启动 vim 编辑器。

一般使用 vim + 目标文件路径 的形式使用 vim

如果目标文件存在，则 vim 打开目标文件，如果目标文件不存在，则 vim 新建并打开该文件。

：退出 vim 编辑器

VIM 模式

vim 拥有三种模式：

（1）命令模式（常规模式）

vim 启动后，默认进入命令模式，任何模式都可以通过 esc 键回到命令模式（可以多按几次），命令模式下可以键入不同的命令完成选择、复制、粘贴、撤销等操作。

命名模式常用命令如下：

i : 在光标前插入文本

o: 在当前行的下面插入新行

dd: 删除整行

yy：将当前行的内容放入缓冲区（复制当前行）

n+yy : 将 n 行的内容放入缓冲区（复制 n 行）

p: 将缓冲区中的文本放入光标后（粘贴）

u：撤销上一个操作

r: 替换当前字符

/ 查找关键字

（2）插入模式

在命令模式下按 "i" 键，即可进入插入模式，在插入模式可以输入编辑文本内容，使用 esc 键可以返回命令模式。

（3）ex 模式

在命令模式中按 ":" 键可以进入 ex 模式，光标会移动到底部，在这里可以保存修改或退出 vim.

ext 模式常用命令如下：

：保存当前的修改

：退出

! ：强制退出，保存修改

  : 保存并退出，相当于: wq

number 显示行号

:! 系统命令  执行一个系统命令并显示结果

：切换到命令行，使用 ctrl+d 切换回 vim

28.  软件包管理命令 (RPM)

1、软件包的安装

使用 RPM 命令的安装模式可以将软件包内所有的组件放到系统中的正确路径，安装软件包的命令是: rpm –ivh wu-ftpd-2.6.2-8.i386.rpm

i：作用 rpm 的安装模式 v: 校验文件信息 h: 以＃号显示安装进度。

2、软件包的删除

删除模式会将指定软件包的内容全部删除，但并不包括已更改过的配置文件，删除 RPM 软件包的命令如下：rpm –e  wu-ftpd

注意：这里必须使用软件名 “wu-ftpd” 或”wu-ftpd-2.6.2-8 而不是使用当初安装时的软件包名. wu-ftpd-2.6.2-8.i386.rpm

3、软件包升级

升级模式会安装用户所指定的更新版本，并删除已安装在系统中的相同软件包，升级软件包命令如下：rpm –Uvh wu-ftpd-2.6.2-8.i386.rpm  –Uvh：升级参数。

4、软件包更新

更新模式下，rpm 命令会检查在命令行中所指定的软件包是否比系统中原有的软件 包更新。如果情况属实，rpm 命令会自动更新指定的软件包；反之，若系统中并没有指定软件包的较旧版本，rpm 命令并不会安装此软件包。而在升级模式下，不管系统中是否有较旧的版本，rpm 命令都会安装指定的软件包。

rpm –Fvhwu-ftpd-2.6.2-8.i386.rpm   -Fvh：更新参数

5、软件包查询

若要获取 RPM 软件包的相关信息，可以使用查询模式。使用 - q 参数可查询一个已  安装的软件包的内容。

rpm  –q wu-ftpd

查询软件包所安装的位置：rpm –ql package-name

rpm –ql xv (l 参数：显示文件列表)