<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-01-15 22:02:17
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-01-16 19:45:34
 * @FilePath: /balabala/content/private/Linux_LVM_简明教程.md
-->

# Linux LVM 简明教程

- [Linux LVM 简明教程](#linux-lvm-简明教程)
  - [LVM 测试说明](#lvm-测试说明)
  - [准备磁盘分区](#准备磁盘分区)
  - [准备物理卷（PV）](#准备物理卷pv)
  - [准备卷组 (VG)](#准备卷组-vg)
  - [创建逻辑卷 (LV)](#创建逻辑卷-lv)
  - [扩展一个 LVM 卷](#扩展一个-lvm-卷)
  - [缩减一个 LVM 卷](#缩减一个-lvm-卷)
  - [扩展一个卷组](#扩展一个卷组)
  - [收缩一个卷组](#收缩一个卷组)
  - [自动挂载文件系统](#自动挂载文件系统)
  - [hdparm 命令](#hdparm-命令)

LVM 使用分层结构， 如下图所示。

![LVM分层结构图](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230115220551_OlC7dI.jpg)

图中顶部，首先是实际的物理磁盘及其划分的分区和其上的物理卷（PV）。一个或多个物理卷可以用来创建卷组（VG）。然后基于卷组可以创建逻辑卷（LV）。只要在卷组中有可用空间，就可以随心所欲的创建逻辑卷。文件系统就是在逻辑卷上创建的，然后可以在操作系统挂载和访问。

## LVM 测试说明

本文将介绍怎么在 linux 中创建和管理 LVM 卷。我们将会分成两个部分。第一个部分，我们首先要在一个硬盘上创建多个逻辑卷，然后将它们挂载在 /lvm-mount 目录。然后我们将要对创建好的卷调整大小。而第二部分，我们将会从另外一块硬盘增加额外的卷到 LVM 中。

## 准备磁盘分区

通过使用 fdisk，创建磁盘分区。我们需要创建 3 个 1G 分区，注意，并不要求分区的大小一致。同样，分区需要使用‘8e’类型来使他们可用于 LVM。

```bash
# fdisk /dev/sdb
```

```bash
Command (m for help): n ## 新建
Command action
   e   extended
   p   primary partition (1-4)
p ## 主分区
 
Partition number (1-4): 1 ## 分区号
First cylinder (1-1044, default 1):  ## 回车用默认的1
Last cylinder, +cylinders or +size{K,M,G} (1-1044, default 1044): +1G ## 大小
 
Command (m for help): t ## 改变类型
Selected partition 1
Hex code (type L to list codes): 8e ## LVM 的分区代码
Changed system type of partition 1 to 8e (Linux LVM)
```

重复上面的操作来创建其他两个分区。分区创建完成后，我们应该有类似如下的输出：

```bash
# fdisk -l
```

```bash
   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1         132     1060258+  8e  Linux LVM
/dev/sdb2             133         264     1060290   8e  Linux LVM
/dev/sdb3             265         396     1060290   8e  Linux LVM
```

## 准备物理卷（PV）

刚创建的分区是用来储存物理卷的。LVM 可以使用不同大小的物理卷。

```bash
# pvcreate /dev/sdb1
# pvcreate /dev/sdb2
# pvcreate /dev/sdb3
```

使用下列命令检查物理卷的创建情况。下面截取部分输出。"/dev/sdb2" 是一个新的 "1.01 GiB" 物理卷。

```bash
# pvdisplay
```

```bash
--- NEW Physical volume ---
PV Name               /dev/sdb2
VG Name
PV Size               1.01 GiB
Allocatable           NO
PE Size               0
Total PE              0
Free PE               0
Allocated PE          0
PV UUID               jszvzz-ENA2-g5Pd-irhV-T9wi-ZfA3-0xo092
```

使用下列命令可以删除物理卷。

```bash
# pvremove /dev/sdb1
```

## 准备卷组 (VG)

下列命令用来创建名为 'volume-group1' 的卷组，使用 /dev/sdb1, /dev/sdb2 和 /dev/sdb3 创建。

```bash
# vgcreate volume-group1 /dev/sdb1 /dev/sdb2 /dev/sdb3
```

使用下列命令可以来验证卷组。

```bash
# vgdisplay
```

```bash
--- Volume group ---
VG Name               volume-group1
System ID
Format                lvm2
Metadata Areas        3
Metadata Sequence No  1
VG Access             read/write
VG Status             resizable
MAX LV                0
Cur LV                0
Open LV               0
Max PV                0
Cur PV                3
Act PV                3
VG Size               3.02 GiB
PE Size               4.00 MiB
Total PE              774
Alloc PE / Size       0 / 0
Free  PE / Size       774 / 3.02 GiB
VG UUID               bwd2pS-fkAz-lGVZ-qc7C-TaKv-fFUC-IzGNBK
```

从输出中，我们可以看见卷组的使用量 / 总量。物理卷给卷组提供空间。只要在这个卷组中还有可用空间，我们就可以随意创建逻辑卷。

使用下列命令删除卷组。

```bash
# vgremove volume-group1
```

## 创建逻辑卷 (LV)

下列命令创建一个名为 'lv1'、大小为 100MB 的逻辑卷。我们使用小分区减少执行时间。这个逻辑卷使用之前创建的卷组的空间。

```bash
# lvcreate -L 100M -n lv1 volume-group1
```

逻辑卷可使用 lvdisplay 命令查看。

```bash
# lvdisplay
```

```bash
--- Logical volume ---
LV Name                /dev/volume-group1/lv1
VG Name                volume-group1
LV UUID                YNQ1aa-QVt1-hEj6-ArJX-I1Q4-y1h1-OFEtlW
LV Write Access        read/write
LV Status              available
# open                 0
LV Size                100.00 MiB
Current LE             25
Segments               1
Allocation             inherit
Read ahead sectors     auto
- currently set to     256
Block device           253:2
```

现在逻辑卷已经准备好了，我们可以格式化和挂载逻辑卷，就像其它 ext2/3/4 分区一样！

```bash
# mkfs.ext4 /dev/volume-group1/lv1
# mkdir /lvm-mount
# mount /dev/volume-group1/lv1 /lvm-mount/
```

一旦逻辑卷挂载，我们就可以到挂载点 /lvm-mount/ 上读写了。要创建和挂载其它的逻辑卷，我们重复这个过程。

最后，使用 lvremove 我们可以删除逻辑卷。

```bash
# umount /lvm-mount/
# lvremove /dev/volume-group1/lv1
```

## 扩展一个 LVM 卷

调整逻辑卷大小的功能是 LVM 最有用的功能。这个部分会讨论我们怎么样扩展一个存在的逻辑卷。下面，我们将会扩展先前创建的逻辑卷‘lv1’扩大到 200MB。

注意，调整逻辑卷大小之后，也需要对文件系统调整大小进行匹配。这个额外的步骤各不相同，取决于创建文件系统的类型。在本文中，我们使用 'lv1' 创建了 ext4 类型的文件系统，所以这里的操作是针对 ext4 文件系统的。（ext2/3 文件系统也类同）。命令的执行顺序是很重要的。

首先，我们卸载掉 lv1 卷

```bash
# umount /lvm-mount/
```

然后，设置卷的大小为 200M

```bash
# lvresize -L 200M /dev/volume-group1/lv1
```

接下来，检查磁盘错误

```bash
# e2fsck -f /dev/volume-group1/lv1
```

运行以下命令扩展文件系统以后，ext4 信息就更新了。

```bash
# resize2fs /dev/volume-group1/lv1
```

现在，这个逻辑卷应该已经扩展到 200MB 了。我们检查 LV 的状态来验证。

```bash
# lvdisplay
```

```bash
--- Logical volume ---
LV Name                /dev/volume-group1/lv1
VG Name                volume-group1
LV UUID                9RtmMY-0RIZ-Dq40-ySjU-vmrj-f1es-7rXBwa
LV Write Access        read/write
LV Status              available
# open                 0
LV Size                200.00 MiB
Current LE             50
Segments               1
Allocation             inherit
Read ahead sectors     auto
- currently set to     256
Block device           253:2
```

现在，这个逻辑卷可以再次挂载，同样这个方法也可用于其他分区。

## 缩减一个 LVM 卷

这章节介绍缩减 LVM 卷大小的方法。命令的顺序同样重要。并且，下列命令对 ext2/3/4 文件系统同样有效。

注意减少逻辑卷的大小值若小于储存的数据大小，存储在后面的数据会丢失。

首先，卸载掉卷。

```bash
# umount /dev/volume-group1/lv1
```

然后，检测磁盘错误。

```bash
# e2fsck -f /dev/volume-group1/lv1
```

接下来缩小文件系统，更新 ext4 信息。

```bash
# resize2fs /dev/volume-group1/lv1 100M
```

完成以后，减少逻辑卷大小

```bash
# lvresize -L 100M /dev/volume-group1/lv1
```

:warning: Reducing active logical volume to 100.00 MiB THIS MAY DESTROY YOUR DATA (filesystem etc.) Do you really want to reduce lv1? [y/n]: y Reducing logical volume lv1 to 100.00 MiB Logical volume lv1 successfully resized

最后，验证调整后的逻辑卷大小。

```bash
# lvdisplay
```

```bash
--- Logical volume ---
LV Name                /dev/volume-group1/lv1
VG Name                volume-group1
LV UUID                9RtmMY-0RIZ-Dq40-ySjU-vmrj-f1es-7rXBwa
LV Write Access        read/write
LV Status              available
# open                 0
LV Size                100.00 MiB
Current LE             25
Segments               1
Allocation             inherit
Read ahead sectors     auto
- currently set to     256
Block device           253:2
```

## 扩展一个卷组

本节将讨论扩展卷组的方法，将一个物理卷添加到卷组。让我们假设我们的卷组 'volume-group1' 已经满了，需要扩大。手上的硬盘（sdb）已经没有其他空闲分区，我们添加了另外一个硬盘（sdc）。我们将看到如何把 sdc 的分区添加到卷组以扩展。

检测现在卷组状态

```bash
# vgdisplay volume-group1
```

```bash
--- Volume group ---
VG Name               volume-group1
System ID
Format                lvm2
Metadata Areas        3
Metadata Sequence No  8
VG Access             read/write
VG Status             resizable
MAX LV                0
Cur LV                1
Open LV               0
Max PV                0
Cur PV                3
Act PV                3
VG Size               3.02 GiB
PE Size               4.00 MiB
Total PE              774
Alloc PE / Size       25 / 100.00 MiB
Free  PE / Size       749 / 2.93 GiB
VG UUID               bwd2pS-fkAz-lGVZ-qc7C-TaKv-fFUC-IzGNBK
```

首先，我们创建一个 2GB 分区 sdc1，类型为 LVM（8e），如教程前所述。

```bash
# fdisk /dev/sdc
```

```bash
Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-1044, default 1):
Using default value 1
Last cylinder, +cylinders or +size{K,M,G} (1-1044, default 1044): +2G
 
Command (m for help): t
Selected partition 1
Hex code (type L to list codes): 8e
Changed system type of partition 1 to 8e (Linux LVM)
 
Command (m for help): w
The partition table has been altered!
```

然后，我们创建一个物理卷 /dev/sdc1

```bash
# pvcreate /dev/sdc1
```

现在，物理卷已经准备好了，我们可以简单地将它增加到已存在的卷组 'volume-group1' 上。

```bash
# vgextend volume-group1 /dev/sdc1
```

使用 vgdisplay 来验证（可以看到卷组大小已经增大）。

```bash
# vgdisplay
```

```bash
--- Volume group ---
VG Name               volume-group1
System ID
Format                lvm2
Metadata Areas        4
Metadata Sequence No  9
VG Access             read/write
VG Status             resizable
MAX LV                0
Cur LV                1
Open LV               0
Max PV                0
Cur PV                4
Act PV                4
VG Size               5.03 GiB
PE Size               4.00 MiB
Total PE              1287
Alloc PE / Size       25 / 100.00 MiB
Free  PE / Size       1262 / 4.93 GiB
VG UUID               bwd2pS-fkAz-lGVZ-qc7C-TaKv-fFUC-IzGNBK
```

注意，尽管我们使用一个单独的磁盘做示范，其实只要是‘8e’类型的磁盘分区都可以用来扩展卷组。

总结一下，LVM 是一个非常给力的工具，用来创建和管理可变大小的分区。本文中，我们已经介绍了动态分区如何在 LVM 中创建和使用。我们也介绍了扩展 / 缩小逻辑卷和卷组的方法，和如何增加一个新的磁盘到 LVM。

希望对你有帮助。

## 收缩一个卷组

可在 root 权限下通过 vgreduce 命令删除卷组中的物理卷来减少卷组容量。**不能删除卷组中剩余的最后一个物理卷。**

```bash
vgreduce [option] vgname pvname ...
```

其中：

- option：命令参数选项。常用的参数选项有：

  - -a：如果命令行中没有指定要删除的物理卷，则删除所有的空物理卷。
  - --removemissing：删除卷组中丢失的物理卷，使卷组恢复正常状态。
- vgname：要收缩容量的卷组名称。

- pvname：要从卷组中删除的物理卷名称。

示例：从卷组 vg1 中移除物理卷 /dev/sdb2。

```bash
# vgreduce vg1 /dev/sdb2
```

## 自动挂载文件系统

手动挂载的文件系统在操作系统重启之后会不存在，需要重新手动挂载文件系统。但若在手动挂载文件系统后在 root 权限下进行如下设置，可以实现操作系统重启后文件系统自动挂载文件系统。

1. 执行 blkid 命令查询逻辑卷的 UUID，逻辑卷以 /dev/vg1/lv1 为例。

    ```bash
    # blkid /dev/ubuntu-vg/ubuntu-lv2
    ```

    ```bash
    /dev/ubuntu-vg/ubuntu-lv2: UUID="26765d58-2f78-4b24-aa6e-ca78a069cca0" TYPE="ext4"
    ```

    查看打印信息，打印信息中包含如下内容，其中 `26765d58-2f78-4b24-aa6e-ca78a069cca0` 是一串数字，为 UUID， `ext4` 为文件系统类型。

2. 执行 `vi /etc/fstab` 命令编辑 fstab 文件，并在最后加上如下内容。

    ```bash
    UUID=uuidnumber  mntpath                   fstype    defaults        0 0
    ```

    内容说明如下：

    - 第一列：UUID，此处填写 1 查询的 uuidnumber 。
    - 第二列：文件系统的挂载目录 mntpath 。
    - 第三列：文件系统的文件格式，此处填写 1 查询的 fstype 。
    - 第四列：挂载选项，此处以 “defaults” 为例；
    - 第五列：备份选项，设置为 “1” 时，系统自动对该文件系统进行备份；设置为 “0” 时，不进行备份。此处以 “0” 为例；
    - 第六列：扫描选项，设置为 “1” 时，系统在启动时自动对该文件系统进行扫描；设置为 “0” 时，不进行扫描。此处以 “0” 为例。

3. 验证自动挂载功能。

    - 执行 umount 命令卸载文件系统，逻辑卷以 /dev/vg1/lv1 为例。

        ```bash
        # umount /dev/ubuntu-vg/ubuntu-lv2
        ```

    - 执行如下命令，将 /etc/fstab 文件所有内容重新加载。

        ```bash
        # mount -a
        ```

    - 执行如下命令，查询文件系统挂载信息，挂载目录以 /mnt/ssd 为例。

        ```bash
        # mount | grep /mnt/ssd
        ```

        查看打印信息，若信息中包含如下信息表示自动挂载功能生效。

        ```bash
        /dev/mapper/ubuntu--vg-ubuntu--lv2 on /mnt/ssd type ext4 (rw,relatime)
        ```

## hdparm 命令

- 查看硬盘型号

    ```bash
    sudo hdparm -i /dev/sda | grep "Model"
    ```

- 查看硬盘型号和硬盘序列号:

    ```bash
    hdparm -i /dev/sdb
    ```

- 显示硬盘的柱面，磁头，扇区数

    ```bash
    hdparm -g /dev/sdb
    ```

    geometry = 60801 [柱面数] /255 [磁头数] /63 [扇区数], sectors = 976773168 [总扇区数], start = 0 [起始扇区数】

- 评估硬盘的读取效率

    ```bash
    hdparm -t  /dev/sdb1
    ```

- 评估硬盘快取的读取效率

    ```bash
    hdparm -T /dev/sdb1
    ```

- 检测硬盘的硬件规格

    ```bash
    hdparm -I /dev/sdb
    ```
