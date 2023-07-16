<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-07-16 10:33:44
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-07-16 13:09:21
 * @FilePath: /balabala/content/linux/ubuntu20.4下使用clash.md
-->

# ubuntu 20.04 下使用 clash

- [ubuntu 20.04 下使用 clash](#ubuntu-2004-下使用-clash)
  - [下载 clash](#下载-clash)
  - [配置 clash](#配置-clash)
  - [配置 ubuntu 的网络代理](#配置-ubuntu-的网络代理)
    - [图形界面配置](#图形界面配置)
    - [cli 配置](#cli-配置)

## 下载 clash

`github 地址`：<https://github.com/Dreamacro/clash>
`下载最新版本 clash` ：<https://github.com/Dreamacro/clash/releases>

或者通过 curl 下载：

```bash
curl -o https://github.com/Dreamacro/clash/releases/download/v1.17.0/clash-linux-amd64-v1.17.0.gz
```

解压

```bash
tar zxvf ./clash-linux-amd64-v1.17.0.gz
```

授权可执行权限:

```bash
chmod +x clash-linux-amd64-v1.17.0
```

初始化 clash:

```bash
sudo ./clash-linux-amd64-v1.17.0
```

💁 初始化执行 clash 会默认在 /root/.config/clash/ 目录下生成配置文件和全球 IP 地址库：config.yaml 和 Country.mmdb

## 配置 clash

clash 使用 yaml 作为配置文件，配置文件示例可以参考：<https://github.com/Dreamacro/clash/wiki/configuration>

## 配置 ubuntu 的网络代理

### 图形界面配置

![配置ubuntu的网络代理](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230716120447_V8ae1D.jpg)

### cli 配置

编辑 `~/.bashrc` 文件，添加以下配置：

```bash
alias proxy="export http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias unproxy="unset http_proxy;unset https_proxy;unset all_proxy"
```

保存并重载：

```bash
source ~/.bashrc
```
