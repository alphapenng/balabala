<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-06-26 07:16:18
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-07-01 09:57:01
 * @FilePath: /balabala/content/linux/使用 acme.sh 申请免费证书.md
-->

# 使用 acme.sh 申请免费证书

- [使用 acme.sh 申请免费证书](#使用-acmesh-申请免费证书)
  - [准备工作](#准备工作)
  - [部署步骤](#部署步骤)
    - [安装 acme.sh 证书申请脚本(请使用 root 用户安装)](#安装-acmesh-证书申请脚本请使用-root-用户安装)

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

```
#use it
bash
acme.sh --issue -d .....
```


    1. 自动为你创建 cronjob, 每天 0:00 点自动检测所有的证书，如果快过期了，需要更新，则会自动更新证书.

        更高级的安装选项请参考: <https://github.com/Neilpang/acme.sh/wiki/How-to-install>

        **安装过程不会污染已有的系统任何功能和文件 ,** 所有的修改都限制在安装目录中: `~/.acme.sh/`

1. 生成证书

    如果你还没有运行任何 web 服务，80 端口是空闲的，那么 acme.sh 还能假装自己是一个 webserver, 临时听在 80 端口，完成验证:

    ```bash
    acme.sh --issue -d www.loveshare.club --standalone
    ```

2. copy / 安装证书

    前面证书生成以后，接下来需要把证书 copy 到真正需要用它的地方.

    注意，默认生成的证书都放在安装目录下: `~/.acme.sh/`, 请不要直接使用此目录下的文件，例如：不要直接让 nginx/apache 的配置文件使用这下面的文件。这里面的文件都是内部使用，而且目录结构可能会变化.

    正确的使用方法是使用 `--install-cert` 命令，并指定目标位置，然后证书文件会被 copy 到相应的位置， 例如:

    ```bash
    acme.sh --install-cert -d www.loveshare.club --key-file /docker/ssl/www.loveshare.club.key --fullchain-file /docker/ssl/fullchain.cer --reloadcmd "docker container restart unbound"
    ```

3. 查看已安装证书信息

    ```bash
    acme.sh --info -d www.loveshare.club
    ```

4. 出错怎么办？

    如果出错，请添加 debug log：

    `acme.sh --issue  .....  --debug`

    或者：

    `acme.sh --issue  .....  --debug  2`

    请参考： <https://github.com/Neilpang/acme.sh/wiki/How-to-debug-acme.sh>
    