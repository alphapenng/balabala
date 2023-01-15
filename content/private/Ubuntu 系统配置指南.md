<!--
 * @Description: Ubuntu 配置指南
 * @Author: alphapenng
 * @Github: 
 * @Date: 2022-12-21 12:31:30
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-01-15 21:59:22
 * @FilePath: /balabala/content/private/Ubuntu 系统配置指南.md
-->

# Ubuntu 配置指南

- [Ubuntu 配置指南](#ubuntu-配置指南)
  - [Ubuntu 系统如何使用 root 用户登录实例](#ubuntu-系统如何使用-root-用户登录实例)
  - [Ubuntu 环境配置](#ubuntu-环境配置)
    - [设置或更改时区](#设置或更改时区)
    - [软件安装](#软件安装)
  - [Ubuntu 运维监控](#ubuntu-运维监控)

## Ubuntu 系统如何使用 root 用户登录实例

Ubuntu 系统的默认用户名是 ubuntu，并在安装过程中默认不设置 root 帐户和密码。您如有需要，可在设置中开启允许 root 用户登录。具体操作步骤如下：

1. 使用 ubuntu 帐户登录轻量应用服务器。

2. 执行以下命令，设置 root 密码。

    ```bash
    sudo passwd root
    ```

3. 输入 root 的密码，按 Enter。

4. 重复输入 root 的密码，按 Enter。
    返回如下信息，即表示 root 密码设置成功。

    ```bash
    passwd: password updated successfully
    ```

5. 执行以下命令，打开 `sshd_config` 配置文件。

    ```bash
    sudo vi /etc/ssh/sshd_config
    ```

6. 按 i 切换至编辑模式，找到 `#Authentication`，将 `PermitRootLogin` 参数修改为 `yes`。如果 `PermitRootLogin` 参数被注释，请去掉首行的注释符号（`#`）。如下图所示：

    ![PermitRootLogin](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221221123754_qOYn6U.jpg)

7. 找到 `#Authentication`，将 `PasswordAuthentication` 参数修改为 yes。如下图所示：

    ![PasswordAuthentication](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221221124207_SxqgHR.jpg)

    > 说明
    > 若 `sshd_config` 配置文件中无此配置项，则添加 `PasswordAuthentication yes` 项即可。

8. 按 Esc，输入 :wq，保存文件并返回。

9. 执行以下命令，重启 ssh 服务。

    ```bash
    sudo service ssh restart
    ```

10. 参考 使用远程登录软件登录 Linux 实例 ，并使用以下信息登录 Ubuntu 轻量应用服务器：
    - 用户名：root
    - 登录密码：在 步骤 2 中已设置的密码

## Ubuntu 环境配置

### 设置或更改时区

1. 系统时区

    以下 `timedatectl` 命令将会打印系统的时区和所在时区的当前时间。并显示系统时钟服务同步以及 NTP 服务的状态：

    ```bash
    timedatectl
    ```

    ```bash
                    Local time: Sat 2023-01-14 11:18:13 CST
            Universal time: Sat 2023-01-14 03:18:13 UTC
                    RTC time: Sat 2023-01-14 03:18:13    
                    Time zone: Asia/Shanghai (CST, +0800) 
    System clock synchronized: yes                        
                NTP service: active                     
            RTC in local TZ: no       
    ```

2. 更改时区

    以下 `timedatectl` 命令打印所有时区，然后通过管道传递 grep 命令不区分大小写搜索包含括 `shang` 关键词的时区：

    ```bash
    timedatectl list-timezones | grep -i shang
    ```

    该命令将打印以下输出：

    ```bash
    Asia/Shanghai
    ```

    使用 `timedatectl` 的 `set-timezone` 选项设置系统的时区，并在 `set-timezone` 选项之后传递长时区名称。

    ```bash
    sudo timedatectl set-timezone Asia/Shanghai
    ```

    至此，我们已将系统时区设置为 `Asia/Shanghai`。如你需要验证系统时区是否设置成功。再次不带任何选项参数调用 `timedatectl` 命令，打印系统当前设置的时区即可：

    ```bash
    timedatectl
    ```

### 软件安装

- `trzsz-go`
    trzsz 是一款远端文件上传下载工具，类似 lrzsz。

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

- `tshark`

    **Install TShark**

    1. Add the Wireshark and TShark repository:

        ```bash
        sudo add-apt-repository -y ppa:wireshark-dev/stable
        ```

    2. Install TShark:

        ```bash
        sudo apt install -y tshark
        ```

    3. During installation, you will be asked if you want to allow non-root users to be able to capture packets. Select the "Yes" option. It will add the `wireshark` group and anyone who is a member of this group will be able to capture packets without being root user.

        Run the following command to add the current user to a `wireshark` group:

        ```bash
        sudo usermod -a -G wireshark $USER
        ```

        To make changes to take effect, logout and login to your machine. After reconnection, you can check TShark version:

        ```bash
        tshark --version
        ```

    4. Execute `tshark` command without any arguments to start capturing packets on default network interface:

        ```bash
        tshark
        ```

        We can find network interfaces which are available to the TShark with command:

        ```bash
        tshark -D
        ```

        The `-i` option allows capturing packets on a specific network interface.

        ```bash
        tshark -i ens33
        ```

    💁 **Uninstall TShark**

    1. If you wish to completely remove TShark and all related dependencies, execute the following command:

        ```bash
        sudo apt purge --autoremove -y tshark
        ```

    2. Remove GPG key and repository:

        ```bash
        sudo rm -rf /etc/apt/trusted.gpg.d/wireshark-dev-ubuntu-stable.gpg*
        sudo rm -rf /etc/apt/sources.list.d/wireshark-dev-ubuntu-stable-jammy.list
        ```

## Ubuntu 运维监控

- Linux 下系统状态都能通过文件获取，你甚至可以用 shell 来写类 top 工具：

  - CPU: `/proc/stat`
  - MEM: `/proc/meminfo`
  - SWAP: `/proc/swaps`
  - IO: `/proc/diskstats`
  - PROC: `/proc/${pid}/`
  - NET: `/sys/class/net/${dev}/statistics`
  - Battery:`/sys/class/power_supply/`
