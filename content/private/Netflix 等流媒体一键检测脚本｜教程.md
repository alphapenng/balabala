<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2022-01-04 09:10:46
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-01-15 21:39:18
 * @FilePath: /balabala/content/private/Netflix 等流媒体一键检测脚本｜教程.md
-->

# Netflix 等流媒体一键检测脚本｜教程

- [Netflix 等流媒体一键检测脚本｜教程](#netflix-等流媒体一键检测脚本教程)
  - [脚本地址](#脚本地址)
  - [脚本使用方法](#脚本使用方法)
  - [其他脚本](#其他脚本)

## 脚本地址

github 项目地址：[NETFLIX-VERIFY](https://github.com/sjlleo/netflix-verify)

Github 主站下载链接（适用于 IPv4 网络的机器）

```bash
wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_amd64 && chmod +x nf && clear && ./nf
```

## 脚本使用方法

直接运行

简洁模式： `./nf`

简洁模式： `./nf -method lite`

专业模式：`./nf -method full`

自定义模式：`./nf -custom`

## 其他脚本

> DisneyPlus 解锁检测

github 项目地址：[VerifyDisneyPlus](https://github.com/sjlleo/VerifyDisneyPlus)

```bash
wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_amd64 && chmod +x dp && clear && ./dp
```

> Youtube 缓存节点、地域信息检测

GitHub 项目地址：[TubeCheck](https://github.com/sjlleo/TubeCheck)

```bash
wget -O tubecheck https://cdn.jsdelivr.net/gh/sjlleo/TubeCheck/CDN/tubecheck_1.0beta_linux_amd64 && chmod +x tubecheck && clear && ./tubecheck
```
