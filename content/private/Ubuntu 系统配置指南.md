<!--
 * @Description: Ubuntu 配置指南
 * @Author: alphapenng
 * @Github: 
 * @Date: 2022-12-21 12:31:30
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-05-01 07:57:07
 * @FilePath: /balabala/content/private/Ubuntu 系统配置指南.md
-->

# Ubuntu 20.04 LTS 配置指南

- [Ubuntu 20.04 LTS 配置指南](#ubuntu-2004-lts-配置指南)
  - [Ubuntu 系统如何使用 root 用户登录 ssh（可选）](#ubuntu-系统如何使用-root-用户登录-ssh可选)
  - [Ubuntu 环境配置](#ubuntu-环境配置)
    - [更新系统和软件](#更新系统和软件)
    - [设置或更改时区](#设置或更改时区)
    - [安装谷歌拼音输入法](#安装谷歌拼音输入法)
    - [安装常用软件](#安装常用软件)
    - [Rustdesk 远程桌面](#rustdesk-远程桌面)
    - [文件同步 Resilio-sync](#文件同步-resilio-sync)
    - [Python 环境配置](#python-环境配置)
  - [服务器部署](#服务器部署)
    - [开启 samba 服务](#开启-samba-服务)
    - [安装 docker](#安装-docker)
    - [Rustdesk 中继服务器部署](#rustdesk-中继服务器部署)
    - [使用 unbound + redis + mosdns + clash + yacd 搭建 dns 服务器](#使用-unbound--redis--mosdns--clash--yacd-搭建-dns-服务器)
    - [acme.sh 生成免费证书（不推荐，推荐使用 nginx proxy manager 来生成证书）](#acmesh-生成免费证书不推荐推荐使用-nginx-proxy-manager-来生成证书)
    - [部署 chatgpt\_academic](#部署-chatgpt_academic)
  - [Ubuntu 运维监控](#ubuntu-运维监控)

## Ubuntu 系统如何使用 root 用户登录 ssh（可选）

Ubuntu 系统的默认用户名是 ubuntu，并在安装过程中默认不设置 root 帐户和密码。您如有需要，可在设置中开启允许 root 用户登录。具体操作步骤如下：

1. 安装 `openssh-client` `openssh-server`：

    ```bash
    sudo apt install openssh-client openssh-server
    ```

2. 使用 ubuntu 帐户登录

3. 执行以下命令，设置 root 密码。

    ```bash
    sudo passwd root
    ```

4. 输入 root 的密码，按 Enter。

5. 重复输入 root 的密码，按 Enter。
    返回如下信息，即表示 root 密码设置成功。

    ```bash
    passwd: password updated successfully
    ```

6. 执行以下命令，打开 `sshd_config` 配置文件。

    ```bash
    sudo vi /etc/ssh/sshd_config
    ```

7. 按 i 切换至编辑模式，找到 `#Authentication`，将 `PermitRootLogin` 参数修改为 `yes`。如果 `PermitRootLogin` 参数被注释，请去掉首行的注释符号（`#`）。如下图所示：

    ![PermitRootLogin](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221221123754_qOYn6U.jpg)

8. 找到 `#Authentication`，将 `PasswordAuthentication` 参数修改为 yes。如下图所示：

    ![PasswordAuthentication](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20221221124207_SxqgHR.jpg)

    > 说明
    > 若 `sshd_config` 配置文件中无此配置项，则添加 `PasswordAuthentication yes` 项即可。

9. 按 Esc，输入 :wq，保存文件并返回。

10. 执行以下命令，重启 ssh 服务。

    ```bash
    sudo service ssh restart
    ```

11. 参考 使用远程登录软件登录 Linux 实例 ，并使用以下信息登录 Ubuntu 轻量应用服务器：
    - 用户名：root
    - 登录密码：在 步骤 2 中已设置的密码

## Ubuntu 环境配置

### 更新系统和软件

```bash
sudo apt update && sudo apt upgrade -y
```

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

### 安装谷歌拼音输入法

1. 安装软件包

    ```bash
    sudo apt update
    sudo apt install -y fcitx-bin fcitx-googlepinyin
    # 等待安装完成后重启
    sudo reboot
    ```

2. 在 Ubuntu 设置 ➡️ `地区和语言`设置修改输入法管理器

    - 点击 `地区和语言` 设置页面下的 `管理已安装的语言` 按钮
    - 点击 `安装/移除语言` 按钮，随后安装所需的中文简体或中文繁体语言包
    - 在最后一行 `输入法管理器` 中把 `IBus` 改成 `fcitx`
    - 回到 `地区和语言` 设置页面，在输入源下只保留 `English(US)` ，其余全部删除
    - 重启电脑，可以看到系统桌面右上角多出一个图标，表示 `fcitx` 已成功启动
    - 在命令行中输入：`fcitx-configtool`，打开 `fcitx` 配置界面，点击 `+` 按钮，打开添加输入法界面，去掉 `仅显示当前语言` 前的勾，输入 `google` 以定位到谷歌拼音输入法，点击 `OK` 选中

3. 更换 `fcitx` 默认 UI 界面

    ```bash
    # Remove classic UI
    sudo apt remove fcitx-ui-classic
    # Install new UI
    sudo apt install fcitx-ui-qimpanel
    ```

    重启后生效。

### 安装常用软件

- `net-tools`

    `net-tools` 是一个网络工具包，给我们提供一些网络工具，比如我们可以使用 `ifconfig` 命令查看当前操作系统 ip。

    ```bash
    sudo apt install net-tools
    ```

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

    `tshark` 是 `wireshark` 的命令行版

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

- `rsync`

    `rsync` 是文件同步命令，如果本机或者远程计算机没有安装 rsync，可以用下面的命令安装。

    ```bash
    # Debian
    $ sudo apt-get install rsync

    # Red Hat
    $ sudo yum install rsync

    # Arch Linux
    $ sudo pacman -S rsync
    ```

    💁 注意，传输的双方都必须安装 rsync。

- `ipinfo`

    `ipinfo` 工具可以查询 ip 归属地信息。

    ```bash
    sudo add-apt-repository ppa:ipinfo/ppa
    sudo apt update
    sudo apt install ipinfo
    ```

- `gitui`

    `gitui` 是 `git` 工具的命令行 UI 版。

    ```bash
    curl -s https://api.github.com/repos/extrawurst/gitui/releases/latest | grep -wo "https.*linux.*gz" | wget -qi -
    tar xzvf gitui-linux-musl.tar.gz
    rm gitui-linux-musl.tar.gz
    sudo chmod +x gitui
    sudo mv gitui /usr/local/bin
    gitui
    ```

- iperf

    网络性能测试工具

    ```bash
    sudo apt-get install -y iperf3
    ```

### Rustdesk 远程桌面

1. 安装桌面环境 `gnome`

    ```bash
    sudo apt install ubuntu-gnome-desktop
    sudo systemctl start gdm
    ```

2. 安装 rustdesk 客户端

    安装包下载链接：[https://github.com/rustdesk/rustdesk/releases](https://github.com/rustdesk/rustdesk/releases)

    ```bash
    sudo apt install -fy ./rustdesk-<version>.deb
    ```

    ⚠️ rustdesk 还未支持 wayland，你必须手动切换至 X11 ⚠️

    在 `/etc/gdm/custom.conf` 或者 `/etc/gdm3/custom.conf` 文件中做以下修改：

    ```bash
    WaylandEnable=false
    ```

3. 在客户端设置 hbbs/hbbr 地址

    如果你自建了 rustdesk 中继服务器，请在客户端点击 ID 右侧的菜单按钮如下，选择 “ID / 中继服务器”。

    ![设置ID/中继服务器](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230225230024_zJIj9g.jpg)

    在 ID 服务器输入框中（被控端 + 主控端）输入 hbbs 主机或 ip 地址，另外两个地址可以不填，RustDesk 会自动推导（如果没有特别设定），中继服务器指的是 hbbr（21117）端口。

    ![输入hbbs主机或ip地址](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230225230159_pI4Fd3.jpg)

    如果需要通讯加密，请在上个界面的 Key 一栏内输入从自建中继服务器获得的公钥文件的 Key。

### 文件同步 Resilio-sync

💁 [参考文档](https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux)

1. 安装 Resilio-sync

    ```bash
    sudo dpkg -i <resilio-sync-*.deb>
    ```

2. 设置

    ```bash
    sudo systemctl enable resilio-sync
    # user_group 是当前用户组，可以通过 id 命令查看
    sudo usermod -aG <user_group> rslsync
    # user_name 是当前用户名
    sudo usermod -aG rslsync <user_name>
    # synced_folder 是当前用户的文件夹 
    sudo chmod g+rw <synced_folder>
    ```

3. 启动

    ```bash
    sudo systemctl start resilio-sync
    ```

4. 删除

    ```bash
    sudo systemctl stop resilio-sync
    sudo systemctl disable resilio-sync
    sudo apt-get purge resilio-sync
    ```

### Python 环境配置

1. 安装 Pyhton

   - Python2: `sudo apt install -y python`
   - Python3: `sudo apt install -y python3`

2. 安装 Pyenv

    - 安装
        - 安装依赖包

            ```bash
            sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
            libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
            libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git
            ```

        - 下载安装脚本并执行

            ```bash
            curl https://pyenv.run | bash
            ```

        - 在 `~/.bashrc` 文件中添加以下条目：

            ```bash
            # pyenv
            export PYENV_ROOT="$HOME/.pyenv"
            command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
            eval "$(pyenv init -)"
            ```

        - 重启 shell

            ```bash
            exec $SHELL
            ```

        - 验证是否安装成功

            ```bash
            pyenv --version
            ```

    - 卸载

        - 删除 `~/.pyenv` 文件夹

            ```bash
            rm -fr ~/.pyenv
            ```

        - 删除在 `~/.bashrc` 文件里的下列条目

            ```bash
            export PATH="$HOME/.pyenv/bin:$PATH"
            eval "$(pyenv init --path)"
            eval "$(pyenv virtualenv-init -)"
            ```

        - 重启 shell

            ```bash
            exec $SHELL
            ```

## 服务器部署

### 开启 samba 服务

1. 创建一个文件夹

    ```bash
    sudo mkdir /opt/smb
    sudo chmod -R 777 /opt/smb
    ```

2. 安装 smb 服务

    ```bash
    sudo apt update
    sudo apt install samba -y
    ```

3. 添加用户并设置密码

    ```bash
    sudo smbpasswd -a ubuntu
    ```

    :warning: 添加的用户必须已经存在。:warning:

    如果需要更改密码，再次执行 `sudo smbpasswd -a ubuntu` 即可。

    这里的 `ubuntu` 是用户名，请按照实际情况，替换为自己的用户名。

4. 在 `/etc/samba/smb.conf` 中添加如下配置

    ```bash
    [share]
        comment = share
        path = /opt/smb
        read only = no
        public = yes
        writable = yes
        valid user = ubuntu
        create mask = 0777
        directory mask = 0777
    ```

5. 重启 smb 服务

    ```bash
    sudo /etc/init.d/smbd restart
    ```

6. smb 空间扩容

    - 在 `/opt/smb/` 下新建文件夹， 作为挂载点

        ```bash
        sudo mkdir  /opt/smb/data
        sudo chmod 777 -R  /opt/smb/data
        ```

    - 接入硬盘，查看硬盘是否接入成功

        ```bash
        sudo fdisk -l
        ```

        ![fdisk](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230117213140_doW2Su.jpg)

        可以看到设备挂载的位置为 `/dev/sda1`

    - 挂载硬盘

        ```bash
        sudo mount /dev/sda1 /opt/smb/data
        sudo chmod 777 -R  /opt/smb/data
        ```

### 安装 docker

- 安装 docker 环境

    我的云主机系统是 `Ubuntu 20.04.5 LTS (Focal Fossa)`的，可以参考 docker 官方文档，按照 [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/) 指引，按步骤执行即可，最后通过 `sudo docker run hello-world` 测试是否安装成功

### Rustdesk 中继服务器部署

1. 在服务器上运行 hbbs 和 hbbr

    - hbbs - RustDesk ID 注册服务器
    - hbbr - RustDesk 中继服务器

    docker 安装示范

    ```bash
    sudo docker image pull rustdesk/rustdesk-server
    sudo docker run --name hbbs -v /docker/rustdesk:/root -td --net=host rustdesk/rustdesk-server hbbs -r <server-ip>
    sudo docker run --name hbbr -v /docker/rustdesk:/root -td --net=host rustdesk/rustdesk-server hbbr
    ```

    💁 默认情况下，hbbs 监听 21115 (tcp), 21116 (tcp/udp), 21118 (tcp)，hbbr 监听 21117 (tcp), 21119 (tcp)。务必在防火墙开启这几个端口， **请注意 21116 同时要开启 TCP 和 UDP**。其中 21115 是 hbbs 用作 NAT 类型测试，21116/UDP 是 hbbs 用作 ID 注册与心跳服务，21116/TCP 是 hbbs 用作 TCP 打洞与连接服务，21117 是 hbbr 用作中继服务，21118 和 21119 是为了支持网页客户端。如果您不需要网页客户端（21118，21119）支持，对应端口可以不开。

    - TCP(21115, 21116, 21117, 21118, 21119)
    - UDP(21116)

2. 通讯加密

    查看运行目录下的 `id_ed25519.pub` 公钥文件中的内容。

    ```bash
    cat ./id_ed25519.pub
    ```

    复制公钥内容，并在客户端 `ID/中继服务器` 的 Key 一栏内粘贴。

### 使用 unbound + redis + mosdns + clash + yacd 搭建 dns 服务器

拉取仓库至本地

```bash
git clone https://github.com/hezhijie0327/CMA_DNS.git
```

1. 运行 `yacd`

    复制如下脚本并保存为 `yacd.sh`

    ```bash
    #!/bin/bash

    # Parameter
    OWNER="haishanh"
    REPO="yacd"
    TAG="master"
    DOCKER_PATH="/docker/yacd"

    ## Function
    # Get Latest Image
    function GetLatestImage() {
        docker pull ${OWNER}/${REPO}:${TAG} && IMAGES=$(docker images -f "dangling=true" -q)
    }
    # Cleanup Current Container
    function CleanupCurrentContainer() {
        if [ $(docker ps -a --format "table {{.Names}}" | grep -E "^${REPO}$") ]; then
            docker stop ${REPO} && docker rm ${REPO}
        fi
    }
    # Create New Container
    function CreateNewContainer() {
        docker run -p 8090:80 --name yacd --restart=always \
            -d ${OWNER}/${REPO}:${TAG}
    }
    # Cleanup Expired Image
    function CleanupExpiredImage() {
        if [ "${IMAGES}" != "" ]; then
            docker rmi ${IMAGES}
        fi
    }

    ## Process
    # Call GetLatestImage
    GetLatestImage
    # Call CleanupCurrentContainer
    CleanupCurrentContainer
    # Call CreateNewContainer
    CreateNewContainer
    # Call CleanupExpiredImage
    CleanupExpiredImage
    ```

### acme.sh 生成免费证书（不推荐，推荐使用 nginx proxy manager 来生成证书）

1. 安装 acme.sh

    If you need root, please su to root first, and then install acme.sh and use it.

    ```bash
    #uninstall for current user
    acme.sh --uninstall

    #change to root
    sudo su

    #install again for root user
    curl https://get.acme.sh | sh -s email=my@example.com

    #use it
    bash
    acme.sh --issue -d .....
    ```

    尽量使用 root 用户安装使用. 安装过程进行了以下几步:

    1. 把 acme.sh 安装到你的 home 目录下:

        ```bash
        ~/.acme.sh/
        ```

        并创建 一个 shell 的 alias, 例如 .bashrc，方便你的使用: `alias acme.sh=~/.acme.sh/acme.sh`

    2. 自动为你创建 cronjob, 每天 0:00 点自动检测所有的证书，如果快过期了，需要更新，则会自动更新证书.

        更高级的安装选项请参考: <https://github.com/Neilpang/acme.sh/wiki/How-to-install>

        **安装过程不会污染已有的系统任何功能和文件 ,** 所有的修改都限制在安装目录中: `~/.acme.sh/`

2. 生成证书

    如果你还没有运行任何 web 服务，80 端口是空闲的，那么 acme.sh 还能假装自己是一个 webserver, 临时听在 80 端口，完成验证:

    ```bash
    acme.sh --issue -d www.loveshare.club --standalone
    ```

3. copy / 安装证书

    前面证书生成以后，接下来需要把证书 copy 到真正需要用它的地方.

    注意，默认生成的证书都放在安装目录下: `~/.acme.sh/`, 请不要直接使用此目录下的文件，例如：不要直接让 nginx/apache 的配置文件使用这下面的文件。这里面的文件都是内部使用，而且目录结构可能会变化.

    正确的使用方法是使用 `--install-cert` 命令，并指定目标位置，然后证书文件会被 copy 到相应的位置， 例如:

    ```bash
    acme.sh --install-cert -d www.loveshare.club --key-file /docker/ssl/www.loveshare.club.key --fullchain-file /docker/ssl/fullchain.cer --reloadcmd "docker container restart unbound"
    ```

4. 查看已安装证书信息

    ```bash
    acme.sh --info -d www.loveshare.club
    ```

5. 出错怎么办？

    如果出错，请添加 debug log：

    `acme.sh --issue  .....  --debug`

    或者：

    `acme.sh --issue  .....  --debug  2`

    请参考： <https://github.com/Neilpang/acme.sh/wiki/How-to-debug-acme.sh>

### 部署 chatgpt_academic

## Ubuntu 运维监控

- Linux 下系统状态都能通过文件获取，你甚至可以用 shell 来写类 top 工具：

  - CPU: `/proc/stat`
  - MEM: `/proc/meminfo`
  - SWAP: `/proc/swaps`
  - IO: `/proc/diskstats`
  - PROC: `/proc/${pid}/`
  - NET: `/sys/class/net/${dev}/statistics`
  - Battery:`/sys/class/power_supply/`
