<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-06-26 07:16:18
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-07-05 23:01:27
 * @FilePath: \balabala\content\linux\使用 acme.sh 申请免费证书.md
-->

# 使用 acme.sh 申请免费证书

- [使用 acme.sh 申请免费证书](#使用-acmesh-申请免费证书)
  - [准备工作](#准备工作)
  - [部署步骤](#部署步骤)
    - [安装 acme.sh 证书申请脚本(请使用 root 用户安装)](#安装-acmesh-证书申请脚本请使用-root-用户安装)
    - [使用 Standalone 模式申请 SSL 证书](#使用-standalone-模式申请-ssl-证书)
    - [使用 CloudFlare API Key 申请 SSL 证书](#使用-cloudflare-api-key-申请-ssl-证书)
    - [安装域名证书](#安装域名证书)
    - [查看目前申请的证书](#查看目前申请的证书)
    - [撤销目前申请的证书](#撤销目前申请的证书)
    - [手动续期证书](#手动续期证书)
    - [卸载 Acme.sh 脚本](#卸载-acmesh-脚本)
    - [出错怎么办？](#出错怎么办)

## 准备工作

- 一台 VPS
- 一个域名
- CloudFlare 账号（如使用 CF API）

## 部署步骤

### 安装 acme.sh 证书申请脚本(请使用 root 用户安装)

1. 运行以下命令，安装 acme.sh 证书申请脚本

    💁 如果之前使用的是非 root 用户安装，请先卸载。

    ```bash
    # 为当前用户卸载脚本
    acme.sh --uninstall

    # 切换到 root 用户
    sudo su

    # 为 root 用户安装脚本，替换 my@example.com 为自己的邮箱
    curl https://get.acme.sh | sh -s email=my@example.com
    ```

    acme.sh 会安装到你的 home 目录也就是 `/root` 下，编辑 `/root/.bashrc` 配置文件，添加一个 shell 的 alias，方便你的使用: `alias acme.sh=~/.acme.sh/acme.sh`

2. 切换默认证书签发的 CA 机构为下面三家的任何一家

    - Let's Encrypt （签发速度快，稳定）

        ```bash
        acme.sh --set-default-ca --server letsencrypt
        ```

    - ZeroSSL （稳定、但部分情况无法签发）

        ```bash
        bash ~/.acme.sh/acme.sh --set-default-ca --server zerossl
        ```

    - Buypass（没试过）

        ```bash
        bash ~/.acme.sh/acme.sh --set-default-ca --server buypass
        ```

3. 设置 Acme.sh 自动更新，始终与官方保持一致

    ```bash
    bash ~/.acme.sh/acme.sh --upgrade --auto-upgrade
    ```

### 使用 Standalone 模式申请 SSL 证书

💁 此方法使用之前请确保 80 端口畅通，并且域名已经事先解析到 VPS 的 IP

域名解析至 IPv4：

```bash
bash ~/.acme.sh/acme.sh --issue -d "域名" --standalone -k ec-256
```

域名已解析至 IPv6：

```bash
bash ~/.acme.sh/acme.sh --issue -d "域名" --standalone -k ec-256 --listen-v6
```

### 使用 CloudFlare API Key 申请 SSL 证书

💁 此方法可以使用泛域名、无需 DNS 解析，但由于受到 CF API 限制，不可适用于 Freenom 系列的免费域名

1. 设置 CloudFlare Global API Key 和登录邮箱

    ```bash
    export CF_Key="你自己的CloudFlare Global API Key"
    export CF_Email="你自己的CloudFlare账户登录邮箱"
    ```

2. 运行一下命令

    - **单域名**

        IPv4 或原生双栈 VPS

        ```bash
        bash ~/.acme.sh/acme.sh --issue --dns dns_cf -d "域名" -k ec-256
        ```

        IPv6

        ```bash
        bash ~/.acme.sh/acme.sh --issue --dns dns_cf -d "域名" -k ec-256 --listen-v6
        ```

    - **泛域名**

        IPv4 或原生双栈 VPS

        ```bash
        bash ~/.acme.sh/acme.sh --issue --dns dns_cf -d "*.域名" -d "域名" -k ec-256
        ```

        IPv6

        ```bash
        bash ~/.acme.sh/acme.sh --issue --dns dns_cf -d "*.域名" -d "域名" -k ec-256 --listen-v6
        ```

### 安装域名证书

💁 由于 acme.sh 的证书不能直接使用，因此我们需要安装证书

单域名

```bash
bash ~/.acme.sh/acme.sh --install-cert -d "域名" --key-file /root/private.key --fullchain-file /root/cert.crt --ecc
```

泛域名

```bash
bash ~/.acme.sh/acme.sh --install-cert -d "*.域名" --key-file /root/private.key --fullchain-file /root/cert.crt --ecc
```

> 运行此命令后，证书 crt 路径为 /root/cert.crt，私钥 key 路径为 /root/private.key，可自行修改

### 查看目前申请的证书

```bash
bash ~/.acme.sh/acme.sh --list
```

### 撤销目前申请的证书

```bash
bash ~/.acme.sh/acme.sh --revoke -d "域名" --ecc
bash ~/.acme.sh/acme.sh --remove -d "域名" --ecc
```

### 手动续期证书

```bash
bash ~/.acme.sh/acme.sh --renew -d "域名" --force --ecc
```

### 卸载 Acme.sh 脚本

```bash
bash ~/.acme.sh/acme.sh --uninstall
```

### 出错怎么办？

如果出错，请添加 debug log：

`acme.sh --issue  .....  --debug`

或者：

`acme.sh --issue  .....  --debug  2`

请参考： <https://github.com/Neilpang/acme.sh/wiki/How-to-debug-acme.sh>