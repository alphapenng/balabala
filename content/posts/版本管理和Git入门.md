---
title: "版本管理和Git入门"
date: 2021-08-28T19:15:47+08:00
draft: false
toc: true
isCJKLanguage: true
tags:
- 技术
- Git
---

## 说明

**此版截图是我在方糖出品的免费课「Git 基础课」上做的学习摘要，仅供个人学习 Git 参考使用，完整的课程还请移步课程链接-[Git 基础课](https://01.ftqq.com/2021/08/21/git-course/)学习**

## 版本管理的需求

### 时间机器

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwogm56nfj61g00nq0y102.jpg" alt="image-20210319143636709"/><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwoi8o0bjj60n20pcdic02.jpg" alt="image-20210319143720289" width=50%/>

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwoikyiydj61cu0peafh02.jpg" alt="image-20210319143844561" />

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwoity147j61bi0iejv602-20210828210903625.jpg" alt="image-20210319144100478" />

### 方案对比

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwoj5sln8j61gs0ly77m02.jpg" alt="image-20210319144247197" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwojl19udj61ka0ncgpm02.jpg" alt="image-20210319144501889" />

### 版本库

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwoju4lixj61fu0pm14t02.jpg" alt="image-20210319151125298" />

### 版本库-文件命名

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwok4mn7oj61jw0jugqm02.jpg" alt="image-20210319151455436" />

### SHA-1



<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwok9tnhsj618s0leact02.jpg" alt="image-20210319151603092" />

**如果文件内容是一样的，那它产生的 SHA-1 值一定是一样的**

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwokky20bj60xs0qidkg02.jpg" alt="image-20210319151908760" width=60%/><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwokqrbs6j60xu0kowil02.jpg" alt="image-20210319152053547" width=60% /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwokz8r8qj60x80jsjvb02.jpg" width=60% />

## tree结构和暂存区

### 目录结构和对应关系

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwolafe0cj61cw0msgo802.jpg" alt="image-20210319153027499" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwolj0lnxj61k00q442302.jpg" alt="image-20210319153119228" />

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwon96o70j61oi0r0k3d02.jpg" alt="image-20210319153245165" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwonfposmj61h80pawqz02.jpg" alt="image-20210319153356728" />

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwonu4789j61ki0okgqt02.jpg" alt="image-20210319153514004" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwoo1ftmfj61k20wyah802.jpg" alt="image-20210319153804470" />

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwoow426uj61g40zsjzv02.jpg" alt="image-20210319154016153" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwoqvev6wj612c12mn9k02.jpg" alt="image-20210319154204303" />

### 源代码和版本库的对应关系

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtworkhdazj61co0mgact02.jpg" alt="image-20210319154428244" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtworuphcbj61cc0n677702.jpg" alt="image-20210319154533118" />

### 暂存区

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwossyeitj61jo0ngn1202.jpg" alt="image-20210319154648154" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwot2noemj61jg0mkdjv02.jpg" alt="image-20210319154748607" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwouiws9jj61k20nwn2y02.jpg" alt="image-20210319155246670" />

### 文件状态

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwov024uhj61d20qan2902.jpg" alt="image-20210319154943171" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwougz9evj61e60q8gqw02.jpg" alt="image-20210319155116565" />

### 快照链表

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwounjzl7j61ee0hun0b02.jpg" alt="image-20210319155452910" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwouus6h9j61dq0s8afq02.jpg" alt="image-20210319155559690" />

## 协同和分支

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwovj28rbj618i0nygpz02.jpg" alt="image-20210319155813823" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp0kxifjj61940p2gqp02.jpg" alt="image-20210319160631844" />

### 分布式的版本控制

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp0p4kg9j61by0pmn2902.jpg" alt="image-20210319160811835" />

### 冲突和合并

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp1517isj615q0no0wb02.jpg" alt="image-20210319160859570" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp0wqhv6j616k0rcwjr02.jpg" alt="image-20210319160930326" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp1gbbrdj619i0nu43002-20210828211717113.jpg" alt="image-20210319161009536" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp1vthltj61680reafl02-20210828214441447-20210828214522003.jpg" alt="image-20210319161104284" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/image-20210319161209570.png" alt="image-20210319161104284" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp2tfr35j61fe0nodk702.jpg" alt="image-20210319161243953" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp32nk1oj61k40nqdk702.jpg" alt="image-20210319161403672" />

### 分支

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp3h0h4ij61ho0pen1f02.jpg" alt="image-20210319161503923" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp3n8v2nj61i60teqap02.jpg" alt="image-20210319161556465" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp410rt7j61ie0t246l02.jpg" alt="image-20210319161754411" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp4jpiivj61im0t8tgw02.jpg" alt="image-20210319161832475" />

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp4wtdmxj61fm0u6n3a02.jpg" alt="image-20210319161946816" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp52nnyyj61gy0ukn4q02-20210828211918200.jpg" alt="image-20210319162025963" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp9b79k5j61j60zugqj02.jpg" alt="image-20210319162148930" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp9273nnj61ng0ycti002.jpg" alt="image-20210319162236629" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwp9ocxvtj61oi0yk48102.jpg" alt="image-20210319162320886" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpa22gbij61bi0xa7b102.jpg" alt="image-20210319162458083" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpbityn7j615m0wu78g02.jpg" alt="image-20210319163330164" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpbrus87j61la0x0qc702.jpg" alt="image-20210319163421543" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpbxhywrj61ic0wyagz02.jpg" alt="image-20210319163605030" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpclx34tj61j80won5402-20210828212118136.jpg" alt="image-20210319163639557" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpdgw03vj61io0wwq7f02.jpg" alt="image-20210319163741771" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpdudqm5j61ii0yoaiy02.jpg" alt="image-20210319163918082" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpec50k8j61iw0yodpk02.jpg" alt="image-20210319164037758" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpeo163ij61ow0xu43s02.jpg" alt="image-20210319164132813" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpf71c4rj61oq0xggsj02.jpg" alt="image-20210319164233884" />

**通常只在本地仓库进行 rebase 操作，远程仓库不进行 rebase 操作**

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpfizci4j61n20xc13402.jpg" alt="image-20210319164540477" />

**合并特定提交到分支上面来**

## 回顾

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpfmbxayj61g00duwiz02.jpg" alt="image-20210319164952744" />



## Git命令实战

<img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpfpusauj60yq13811l02.jpg" alt="image-20210319165758186" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpfuglifj60yk11gdop02.jpg" alt="image-20210319190409249" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpg3vng8j60yw12s7ca02.jpg" alt="image-20210319191059786" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpgfv8u1j60yk0wyaex02.jpg" alt="image-20210319192814117" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpgoowl4j60yy11g1kx02.jpg" alt="image-20210319165855297" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpgx2txhj60ys1204qp02.jpg" alt="image-20210319170416091" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwph3suetj60yu12g4qp02.jpg" alt="image-20210319170732546" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwphdy7f4j60z012a4qp02-20210828212354905.jpg" alt="image-20210319171524293" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpi3q949j60z011ygyn02.jpg" alt="image-20210319191158374" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpivkpxoj622g12wkcx02.jpg" alt="image-20210319191715690" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpjb94rmj60z40pqqcw02.jpg" alt="image-20210319192150779" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpj8cx0rj622i0xeb2902.jpg" alt="image-20210319192616946" /><img src="https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/006x9NuVly1gtwpjhqtg1j60y811i1kx02.jpg" alt="image-20210319193330075" />





