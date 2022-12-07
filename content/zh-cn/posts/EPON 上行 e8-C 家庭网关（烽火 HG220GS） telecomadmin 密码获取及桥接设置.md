---
title: "EPON 上行 E8 C 家庭网关（烽火 HG220GS） telecomadmin 密码获取及桥接设置"
date: 2022-11-21T21:04:54+08:00
draft: false
tags: ["geek","homelab"]
categories: ["geek"]
authors:
- alphapenng
---

![toc](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_07_0SVVIk.png)

## 获取 `telecomadmin` 账户密码

1. 以默认配置账号密码登录光猫后台管理页面

    这里以默认配置地址为例，登录 [http://192.168.1.1](http://192.168.1.1)，输入默认配置账号密码，点击确认。

    ![默认配置账号密码登录](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_22_xQEAjw.png)

2. 访问 [http://192.168.1.1/logoffaccount.html](http://192.168.1.1/logoffaccount.html) 页面，将隐藏账号`启用`，保存退出。

    ![启用隐藏账号](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_22_segES4.png)

3. 访问 [http://192.168.1.1](http://192.168.1.1) ，输入隐藏账号密码登陆

    ```
    账号：fiberhomehg2x0
    密码：hg2x0
    ```

    ![隐藏账号密码登录](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_22_16mIRi.png)

4. 打开 [http://192.168.1.1/backupsettings.html](http://192.168.1.1/backupsettings.html) 备份配置文件 `backupsettings.conf`

    ⚠️ `请注意文件大小应该在 45KB 左右`。

    ![备份配置文件](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_22_iGVxIG.png)

5. 解密 telecomadmin 账号密码

    用记事本打开刚才下载的配置文件 `backupsettings.conf`，定位 <X_CT-COM_TeleComAccount> 字段，会发现 password，这是用 base64 加密的，使用 [base64 解密工具](https://base64.us) 可以解开，即得到密码。

    ![用 base64 加密的 password 密码](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_23_bJhg9S.png)

## 将光猫设置为桥接模式

1. 以 `telecomadmin` 账号和密码登录光猫后台管理界面

2. 将 `tr069` 协议禁用，关闭中间件
   ![禁用 tr069](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_23_zUMe7Q.png)

    ⚠️ 若“保存/应用”按钮无法点击，请使用网页开发者工具移除按钮的 `disalbed` 属性。

    ```javascript
    // 移除命令
    $0.removeAttribute('disabled')
    ```

    ![打开开发者工具](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_23_Fkc9DZ.png)

    ![移除保存按钮 disabled 属性](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_23_E7odDi.png)
    ![再次点击保存](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_23_pjB4Jw.png)
    ![重启路由器](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_23_dOB9Pt.png)

3. 更改桥接模式

    在“宽带设置”标签页里，会看到三个连接名称，第一个是 `tr69`，第二个是 `iptv`，第三个是 `internet`（上网连接）。

    ![更改桥接模式](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_23_4msLtz.png)

    ![填入mtu值并保存](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_bkxtRv.png)

    若忘记拨号上网的密码可以打开开发者工具查看

    ![查看拨号上网密码](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_11_23_s1o2Vy.png)

    更改完后，点击“保存/应用”按钮，重启路由器。

4. 关闭光猫 dhcp 服务(可选，如果影响路由器可以选择关闭)

    ⚠️ **关闭之前请先截屏备份，日后需要开启时再恢复设置** ⚠️

    ![截屏备份dhcp服务](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_07_1ZUI1B.png)

    ![关闭光猫dhcp服务](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_6eFkIc.png)

5. 关闭光猫 wifi 服务

    ![关闭光猫wifi服务](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_YNDRB5.png)

## 主路由（Openwrt）设置拨号上网

1. 设置 WAN 口拨号上网

    ![修改WAN口协议](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_O1bdHs.png)

    ![填入拨号上网用户名密码](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_OTHsz9.png)

    ![保存并应用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_enQDFH.png)

2. 添加虚拟接口以访问光猫后台

    ![创建虚拟接口](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_rKXF90.png)

    ![接口常规设置](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_zGQKdf.png)

    ![取消默认网关](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_bKdr40.png)

    ![修改防火墙设置](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_XsdeG7.png)

    ![保存并应用](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/2022_12_05_ahHfTC.png)
