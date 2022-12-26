---
2022-12-21 12:31:58
---

# Ubunut 配置指南

## Ubuntu 系统如何使用 root 用户登录实例

Ubuntu 系统的默认用户名是 ubuntu，并在安装过程中默认不设置 root 帐户和密码。您如有需要，可在设置中开启允许 root 用户登录。具体操作步骤如下：

1.  使用 ubuntu 帐户登录轻量应用服务器。

2.  执行以下命令，设置 root 密码。

    ```bash
    sudo passwd root
    ```

3.  输入 root 的密码，按 Enter。

4.  重复输入 root 的密码，按 Enter。
    返回如下信息，即表示 root 密码设置成功。

    ```bash
    passwd: password updated successfully
    ```

5.  执行以下命令，打开 `sshd_config` 配置文件。

    ```bash
    sudo vi /etc/ssh/sshd_config
    ```

6.  按 i 切换至编辑模式，找到 `#Authentication`，将 `PermitRootLogin` 参数修改为 `yes`。如果 `PermitRootLogin` 参数被注释，请去掉首行的注释符号（`#`）。如下图所示：
    ![PermitRootLogin](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221221123754_qOYn6U.jpg)

7.  找到 `#Authentication`，将 `PasswordAuthentication` 参数修改为 yes。如下图所示：
    ![PasswordAuthentication](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221221124207_SxqgHR.jpg)

    > 说明
    > 若 `sshd_config` 配置文件中无此配置项，则添加 `PasswordAuthentication yes` 项即可。

8.  按 Esc，输入 :wq，保存文件并返回。

9.  执行以下命令，重启 ssh 服务。

    ```bash
    sudo service ssh restart
    ```

10. 参考 使用远程登录软件登录 Linux 实例 ，并使用以下信息登录 Ubuntu 轻量应用服务器：
    -   用户名：root
    -   登录密码：在 步骤 2 中已设置的密码

## Ubuntu 环境配置

### 软件安装

-   trzsz-go

    1. installation

    ```bash
    sudo apt update && sudo apt install software-properties-common
    sudo add-apt-repository ppa:trzsz/ppa && sudo apt update
    sudo apt install trzsz
    ```

    2. Install `trzsz-go` on the local computer, and `alias ssh="trzsz ssh"` for convenience.

    ```bash
    # for mac install trzsz-go
    brew update
    brew install trzsz-go
    ```

    3. usage

    `trz` upload files to the remote server

    ```bash
    usage: trz [-h] [-v] [-q] [-y] [-b] [-e] [-d] [-B N] [-t N] [path]

    Receive file(s), similar to rz and compatible with tmux.

    positional arguments:
        path               path to save file(s). (default: current directory)

    optional arguments:
        -h, --help         show this help message and exit
        -v, --version      show program's version number and exit
        -q, --quiet        quiet (hide progress bar)
        -y, --overwrite    yes, overwrite existing file(s)
        -b, --binary       binary transfer mode, faster for binary files
        -e, --escape       escape all known control characters
        -d, --directory    transfer directories and files
        -B N, --bufsize N  max buffer chunk size (1K<=N<=1G). (default: 10M)
        -t N, --timeout N  timeout ( N seconds ) for each buffer chunk.
                            N <= 0 means never timeout. (default: 20)
    ```

    `tsz` download files from the remote server

    ```bash
    usage: tsz [-h] [-v] [-q] [-y] [-b] [-e] [-d] [-B N] [-t N] file [file ...]

    Send file(s), similar to sz and compatible with tmux.

    positional arguments:
        file               file(s) to be sent

    optional arguments:
        -h, --help         show this help message and exit
        -v, --version      show program's version number and exit
        -q, --quiet        quiet (hide progress bar)
        -y, --overwrite    yes, overwrite existing file(s)
        -b, --binary       binary transfer mode, faster for binary files
        -e, --escape       escape all known control characters
        -d, --directory    transfer directories and files
        -B N, --bufsize N  max buffer chunk size (1K<=N<=1G). (default: 10M)
        -t N, --timeout N  timeout ( N seconds ) for each buffer chunk.
                            N <= 0 means never timeout. (default: 20)
    ```
