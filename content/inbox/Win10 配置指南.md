---
2022-08-01 20:16:11
---

# Win10 配置指南

- [Win10 配置指南](#win10-配置指南)
  - [准备工作](#准备工作)
  - [开发人员设置](#开发人员设置)
    - [WSL](#wsl)
      - [先决条件](#先决条件)
      - [安装 WSL 2](#安装-wsl-2)
      - [用户配置](#用户配置)
        - [更改默认安装的 Linux 发行版](#更改默认安装的-linux-发行版)
        - [设置 Linux 用户名和密码](#设置-linux-用户名和密码)
      - [更新 Linux](#更新-linux)
        - [查看更新 Linux 系统相关信息](#查看更新-linux-系统相关信息)
      - [映射你的 Linux 驱动器](#映射你的-linux-驱动器)
      - [固定代码目录](#固定代码目录)
      - [重启 WSL](#重启-wsl)
    - [配置 Windows PowerShell](#配置-windows-powershell)
    - [Windows 终端](#windows-终端)
      - [安装 Windows 终端](#安装-windows-终端)
      - [终端设置](#终端设置)
        - [默认配置文件](#默认配置文件)
        - [开始目录](#开始目录)
    - [在 WSL 中配置 Git](#在-wsl-中配置-git)
      - [姓名](#姓名)
      - [电子邮件](#电子邮件)
      - [用户名](#用户名)
    - [GitHub 凭据](#github-凭据)
      - [创建你的个人访问令牌](#创建你的个人访问令牌)
      - [Git 凭据管理器](#git-凭据管理器)
      - [存储令牌](#存储令牌)
    - [在 WSL 中配置 Zsh](#在-wsl-中配置-zsh)
      - [安装 Zsh](#安装-zsh)
      - [OhMyZsh](#ohmyzsh)
      - [cURL](#curl)
      - [安装 OhMyZsh](#安装-ohmyzsh)
      - [更多插件](#更多插件)
        - [zsh-autosuggestions](#zsh-autosuggestions)
        - [zsh-syntax-highlighting](#zsh-syntax-highlighting)
        - [autojump](#autojump)
        - [zsh-vi-mode](#zsh-vi-mode)
        - [zsh\_codex](#zsh_codex)
    - [安装 Python](#安装-python)
      - [版本控制](#版本控制)
    - [安装 Node.js](#安装-nodejs)
      - [NVM](#nvm)
        - [安装 NVM](#安装-nvm)
        - [更改 node 版本](#更改-node-版本)
    - [在 WSL 里安装 Docker](#在-wsl-里安装-docker)
      - [安装 Docker](#安装-docker)
      - [测试是否安装成功](#测试是否安装成功)
    - [Vagrant + Hyper-v 快速创建 Linux 虚拟机](#vagrant--hyper-v-快速创建-linux-虚拟机)
      - [Enable Hyper-V using PowerShell](#enable-hyper-v-using-powershell)
      - [Vagrant](#vagrant)
      - [创建虚拟机](#创建虚拟机)
      - [Vagrant 的基本使用](#vagrant-的基本使用)
    - [Visual Studio 代码](#visual-studio-代码)
      - [安装 VS Code](#安装-vs-code)
      - [远程扩展](#远程扩展)
      - [更改默认终端](#更改默认终端)
    - [Chocolatey](#chocolatey)
      - [安装 Chocolatey](#安装-chocolatey)
      - [基本 Chocolatey 命令](#基本-chocolatey-命令)
      - [Windows 应用程序](#windows-应用程序)
    - [其他环境](#其他环境)
      - [🐍 Python](#-python)
      - [💾Databases](#databases)

## 准备工作

1. 安装系统
2. 安装驱动
3. 安装 office
4. 激活系统

## 开发人员设置

[dev guide](https://github.com/Vets-Who-Code/windows-dev-guide/blob/main/README_cn.md)

### WSL

[WSL install guide](https://docs.microsoft.com/en-us/windows/wsl/install)

#### 先决条件

1. 安装前准备，把主板 bios 虚拟化打开

2. 升级系统至安装 WSL2 的最低系统版本

    **_查看系统版本：_**

    选择 `Windows_logo_key + R`，键入 `winver`，选择 `OK`。

    你可以通过选择 **开始 > 设置 > Windows 更新 > 检查更新** 更新系统版本。

#### 安装 WSL 2

现在，可以在管理员 PowerShell 或 Windows 命令提示符中输入此命令，然后重启计算机来安装运行适用于 Linux 的 Windows 子系统 (WSL) 所需的全部内容。

```
wsl --install
```

#### 用户配置

##### 更改默认安装的 Linux 发行版

默认情况下，安装的 `Linux` 分发版为 `Ubuntu`。 可以使用 `-d` 标志进行更改。

若要更改安装的发行版，请输入：`wsl --install -d <Distribution Name>`。 将 `<Distribution Name>` 替换为要安装的发行版的名称。

若要查看可通过在线商店下载的可用 Linux 发行版列表，请输入：`wsl --list --online 或 wsl -l -o`。

若要在初始安装后安装其他 Linux 发行版，还可使用命令：`wsl --install -d <Distribution Name>`。

##### 设置 Linux 用户名和密码

使用 WSL 安装 Linux 发行版的过程完成后，使用 “开始” 菜单打开该发行版（默认情况下为 Ubuntu）。 系统将要求你为 Linux 发行版创建 “用户名” 和 “密码”。

-   此用户名和密码特定于安装的每个单独的 Linux 分发版，与 Windows 用户名无关
-   创建用户名和密码后，该帐户将是分发版的默认用户，并将在启动时自动登录
-   此帐户将被视为 Linux 管理员，能够运行 sudo (Super User Do) 管理命令
-   在 WSL 上运行的每个 Linux 发行版都有其自己的 Linux 用户帐户和密码。 每当添加分发版、重新安装或重置时，都必须配置一个 Linux 用户帐户。

若要更改或重置密码，请打开 Linux 发行版并输入命令：`passwd`。 系统会要求你输入当前密码，然后要求输入新密码，之后再确认新密码。

**_如果忘记了 Linux 分发版的密码：_**

请打开 PowerShell，并使用以下命令进入默认 WSL 分发版的根目录：`wsl -u root`

如果需要在非默认分发版中更新忘记的密码，请使用命令：`wsl -d Debian -u root`，并将 `Debian` 替换为目标分发版的名称。

在 PowerShell 内的根级别打开 WSL 发行版后，可使用此命令更新密码：`passwd <username>`，其中 `<username>` 是发行版中帐户的用户名，而你忘记了它的密码。

系统将提示你输入新的 UNIX 密码，然后确认该密码。 在被告知密码已成功更新后，请使用以下命令在 PowerShell 内关闭 WSL：`exit`。

#### 更新 Linux

##### 查看更新 Linux 系统相关信息

查看 WSL2 系统版本 `lsb_release -a`

更新系统安装源 `sudo apt-get update && sudo apt-get upgrade`

#### 映射你的 Linux 驱动器

1. 从文件资源管理器打开 `\\wls$\` 位置
2. 右键单击 Ubuntu 文件夹，然后选择 `Map network drive`
3. 选择你要使用的驱动器号，保留 `Reconnect at sign-in` 选中和 `Connect using different credentials` 未选中，然后单击完成

如果你想从 Linux 终端访问 Windows 文件，它们可以在 `/mnt/` 目录中找到，因此你的 Windows 用户目录将位于 `/mnt/c/Users/username`。

映射 Ubuntu 驱动器后，你可以使用文件资源管理器轻松地将 Windows 文件拖放或复制/粘贴到 Linux 文件系统。

但是，建议将你的项目文件存储在 Linux 文件系统上。这将比从 Windows 访问文件快得多，而且也可能有点错误。

#### 固定代码目录

在 Ubuntu 中创建一个代码目录，然后将其固定到文件资源管理器左侧的快速访问菜单上。在 Windows 和 Linux 之间快速传输文件时，这会派上用场。

1. 打开文件资源管理器并单击我们创建的 Ubuntu 网络驱动器
2. 选择主目录，然后选择你的用户目录
3. 右键单击并创建一个新文件夹，将其命名为代码或你想要的任何其他内容
4. 将新文件夹拖到左侧，在显示 `Quick access` 的星形图标下方

#### 重启 WSL

如果由于某种原因 WSL 停止工作，你可以使用 PowerShell/命令提示符中的以下两个命令重新启动它：

```
wsl.exe --shutdown
wsl.exe
```

### 配置 Windows PowerShell

1. [powershell github core](https://github.com/PowerShell/PowerShell)
2. 设置 Windows Terminal 默认启动为 PowerShell7
3. [安装 oh-my-posh](https://gist.github.com/xiaopeng163/0fe4225a56ff97cd47e25a4b8a6f36ec)

    ```
    Install-Module oh-my-posh -Scope CurrentUser -SkipPublisherCheck
    Install-Module posh-git -Scope CurrentUser
    Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
    ```

4. 引入配置 `notepad.exe $PROFILE`

    ```
    Import-Module posh-git
    Import-Module oh-my-posh
    Set-PoshPrompt -Theme dracula
    ```

5. [安装字体](https://ohmyposh.dev/docs/config-fonts)
6. 安装文件图标库

    ```
    Install-Module -Name Terminal-Icons -Repository PSGallery
    ```

7. 使用图标

    ```
    Import-Module -Name Terminal-Icons
    ```

8. 命令行自动补全和提示

    ```
    Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
    ```

9. 配置 vim 在 powershell 中打开

    - find vim path

        git 是自带 vim 的`path = C:\Program Files\Git\usr\bin\vim`

    - vimrc 配置

        ```
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
        set fileencodings=ucs-bom,utf-8,chinese,cp936
        ```

    - ps profile 配置

        ```
        # There's usually much more than this in my profile!
        $SCRIPTPATH = "C:\Program Files\Git\usr\bin"
        $VIMPATH    = $SCRIPTPATH + "\vim.exe"

        Set-Alias vi   $VIMPATH
        Set-Alias vim  $VIMPATH

        # for editing your PowerShell profile
        Function Edit-Profile
        {
        	vim $profile
        }

        # for editing your Vim settings
        Function Edit-Vimrc
        {
        	vim $home\_vimrc
        }
        ```

### Windows 终端

#### 安装 Windows 终端

[Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/install)

#### 终端设置

我建议快速设置的几件事是**默认配置文件**和你的**起始主目录**。这些设置使启动 Windows 终端将直接打开到我们用户主目录中的 WSL。

##### 默认配置文件

Windows 终端默认启动时会打开 PowerShell 或命令提示符 shell，以下是如何将其切换到 WSL：

1. 从 Windows 终端中选择 `˅` 图标并转到设置菜单
2. 在启动部分，你将找到默认配置文件下拉列表，选择 Ubuntu。在它下面，选择 Windows 终端作为默认终端应用程序

##### 开始目录

默认的 Ubuntu 终端将打开到根目录。为了更快地找到你的文件，我们可以将其打开到你的主目录中。

1. 在设置菜单的配置文件部分下，单击 Ubuntu
2. 在常规选项卡上，你将找到一个起始目录输入
3. 输入以下将“用户名”替换为你的 Ubuntu 用户名
4. 你可以不选中 `Use parent process directory` 框
5. 如果它仍在打开你的 / 目录，请将位于 `Starting directory` 输入框正上方的 `Command line` 设置更改为以下内容： `wsl.exe-d Ubuntu`

还有更多设置需要探索，还有一个 JSON 文件可以编辑以进行更高级的自定义。

查看 [this guide](https://www.ubuntupit.com/best-windows-terminal-themes-and-color-schemes/) 了解一些流行的 Windows 终端主题以及如何安装它们。

### 在 WSL 中配置 Git

Git 应该预装在大多数（如果不是所有的话）WSL Linux 发行版上。为确保你拥有最新版本，请在基于 Ubuntu 或 Debian 的发行版中使用以下命令：

```
sudo apt install git
```

#### 姓名

要设置你的 Git 配置文件，请打开 WSL 命令行并使用此命令设置你的姓名（将“你的姓名”替换为你的首选用户名）：

```
git config --global user.name "Your Name"
```

#### 电子邮件

使用此命令设置你的电子邮件（将“youremail@domain.com”替换为你喜欢的电子邮件）：

```
git config --global user.email "youremail@domain.com"
```

#### 用户名

最后，添加你的 GitHub 用户名以将其链接到 git（区分大小写！）：

```
git config --global user.username "GitHub username"
```

确保你输入的是 `user.username` 而不是 `user.name`，否则你将覆盖你的姓名并且你将无法正确同步到你的 GitHub 帐户。

你可以通过键入 `git config--global user.name` 等来仔细检查你的任何设置。要进行任何更改，只需再次键入必要的命令，如上例所示。

### GitHub 凭据

#### 创建你的个人访问令牌

GitHub 已删除在远程存储库中工作时使用传统密码的功能。你现在需要创建个人访问令牌。

> 当使用 [GitHub API](https://docs.github.com/en/rest/overview/other-authentication-methods#via-oauth-and-personal-access-tokens) 或 [命令行](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#using-a-token-on-the-command-line) 时，个人访问令牌（PAT）是使用密码对 GitHub 进行身份验证的替代方案。

按照 [these docs](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) 获取有关创建个人令牌的分步说明。

#### Git 凭据管理器

一旦你第一次输入令牌，它就可以通过 [Git 凭据管理器（GCM）](https://github.com/GitCredentialManager/git-credential-manager) 存储，因此你不必每次都对自己进行身份验证。

你可以同时在 WSL 和 Windows 中安装 Git。[适用于 Windows 的 Git](https://gitforwindows.org/) 包括 GCM，是安装它的首选方式。

你还可以下载 [Windows 的最新安装程序](https://github.com/GitCredentialManager/git-credential-manager/releases/latest) 来安装 GCM 独立版。

#### 存储令牌

安装 Git Credential Manager 后，你可以将其设置为与 WSL 一起使用。打开你的 WSL 终端并输入以下命令：

```
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"
```

### 在 WSL 中配置 Zsh

Z shell 的工作原理几乎与默认 Linux 安装中的标准 BASH shell 相同。它的不同之处在于它对插件和主题的支持，以及一些额外的功能，如拼写更正和递归路径扩展。是时候把 BASH 扔进垃圾桶了！

#### 安装 Zsh

```
sudo apt install zsh
```

安装后，键入 `zsh` 命令。Zsh 会要求你选择一些配置。我们稍后将在安装 oh-my-zsh 时执行此操作，因此选择选项 0 以创建配置文件并防止再次显示此消息。

#### OhMyZsh

到目前为止，最流行的插件框架是 [OhMyZsh](https://ohmyz.sh/)。它预装了大量插件、主题、助手等。它肯定有助于提高生产力，但更重要的是，它看起来 😎 很酷。

#### cURL

首先，我们需要确保安装了 [cURL](https://curl.se/)。“客户端 URL”的缩写，它是一种从命令行传输数据的方法，这就是我们下载 OhMyZsh 的方式。

```
sudo apt install curl
```

#### 安装 OhMyZsh

在你的终端中输入以下命令以安装 OhMyZsh：

```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

就这样！你现在应该在主目录中看到一个`.oh-my-zsh` 目录。要更改插件和主题，你需要编辑你的 `.zshrc` 文件，也可以在你的主目录中找到。这是与 OhMyZsh 捆绑在一起的所有 [themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) 和 [plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) 的列表。

#### 更多插件

##### [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

zsh 的自动建议，它根据历史记录和完成情况在你键入时建议命令。

1. 将此存储库克隆到 `$ZSH_CUSTOM/plugins`（默认情况下 `~/.oh-my-zsh/custom/plugins`）

    ```
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```

2. 将插件添加到要加载的 Oh My Zsh 的插件列表中（在 `~/.zshrc` 中）：

    ```
    plugins=(git zsh-autosuggestions)
    ```

3. 开始新的终端会话。

##### [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

此包为 shell zsh 提供语法高亮显示。当命令在 zsh 提示符下输入到交互式终端时，它可以高亮显示命令。这有助于在运行命令之前查看命令，特别是在捕获语法错误方面。

1. 在 oh-my-zsh 的 plugins 目录中克隆此存储库：

    ```
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    ```

2. 激活 `~/.zshrc` 中的插件：

    ```
    plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
    ```

3. 开始新的终端会话。

##### autojump

autojump 是为了进行目录快速跳转而准备的，它记录用户的目录访问数据，并通过 `j <目录名>` 命令进行快速的跳转（在此之前，还需要用普通的方法访问目录，让 autojump 建立数据）

1. autojump 安装

    ```
    sudo  apt-get install autojump
    ```

2. 在 zsh 中开启 autojump 插件的支持（所有的插件在 `~/.on-my-zsh/plugins/` 目录中）：

    ```
    plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump)
    ```

##### [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode)

1. 将此存储库克隆到 `$ZSH_CUSTOM/plugins`（默认情况下 `~/.oh-my-zsh/custom/plugins`）

    ```
    git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
    ```

2. 将插件添加到要加载的 Oh My Zsh 的插件列表中（在 `~/.zshrc` 中）：

    ```
    plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump zsh-vi-mode)
    ```

3. 开始新的终端会话。

##### [zsh_codex](https://github.com/tom-doerr/zsh_codex)

1. Install the OpenAI package.

    ```bash
    pip3 install openai
    ```

2. 将此存储库克隆到 `$ZSH_CUSTOM/plugins`（默认情况下 `~/.oh-my-zsh/custom/plugins`）

    ```
    git clone https://github.com/tom-doerr/zsh_codex.git ~/.oh-my-zsh/custom/plugins/zsh_codex
    ```

3. 将插件添加到要加载的 Oh My Zsh 的插件列表中（在 `~/.zshrc` 中）：

    ```
    plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump zsh-vi-mode zsh_codex)
    bindkey '^X' create_completion
    ```

4. 在 `~/.config` 目录下创建一个名为 `openaiapirc` 的文件，填入你的 `ORGANIZATION_ID` 和 `SECRET_KEY`。

    ```
    [openai]
    organization_id = ...
    secret_key = ...
    ```

5. 开始新的终端会话，编写想要 AI 执行的操作或变量名然后按下 `^X`，AI 将执行你的操作。

### 安装 Python

#### 版本控制

[pyenv](https://github.com/pyenv/pyenv#installation)

[Simple Python Version Management: pyenv](/content/private/Simple%20Python%20Version%20Management%20pyenv.md)

[pyenv for Windows](/content/private/pyenv%20for%20Windows.md)

### 安装 Node.js

Node.js 是一个 JavaScript 运行时环境，它在 Web 浏览器之外执行 JavaScript 代码。

#### NVM

你可能需要根据你正在处理的不同项目的需求在 Node.js 的多个版本之间切换。Node Version Manager 允许你通过命令行快速安装和使用不同版本的节点。

##### 安装 NVM

1. 打开你的 Ubuntu 命令行并使用以下命令安装 nvm：

    ```
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    ```

    要验证安装，请输入： `command-v nvm`。这应该返回“nvm”，如果你收到“未找到命令”或根本没有响应，请关闭当前终端，重新打开它，然后重试。

2. 列出当前安装了哪些版本的 Node（此时应该没有）：

    ```
    nvm ls
    ```

3. 安装当前和稳定的 LTS 版本的 Node.js.

    安装 Node.js 的当前稳定 LTS 版本（推荐用于生产应用）：

    ```
    nvm install --lts
    ```

    安装当前版本的 Node.js（用于测试最新的 Node.js 功能和改进，但更有可能出现问题）：

    ```
    nvm install node
    ```

4. 列出安装了哪些版本的 Node：

    ```
    nvm ls
    ```

    现在你应该看到列出了你刚刚安装的两个版本。

5. 验证是否安装了 Node.js 和当前版本：

    ```
    node --version
    ```

    然后验证你是否也安装了 npm：

    ```
    npm --version
    ```

##### 更改 node 版本

使用以下命令更改要用于任何给定项目的 Node 版本：

要切换到当前版本：

```
nvm use node
```

要切换到 LTS 版本：

```
nvm use --lts
```

你还可以将特定编号用于你安装的任何其他版本：

```
nvm use v8.2.1.
```

要列出所有可用的 Node.js 版本，请使用命令： `nvm ls-remote`。

### 在 WSL 里安装 Docker

#### 安装 Docker

1.  [Install Docker Script](https://gist.github.com/xiaopeng163/f3e72bb1990860859076985d5a723cba)

```
# install docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

if [ ! $(getent group docker) ];
then
   sudo groupadd docker;
else
   echo "docker user group already exists"
fi

sudo gpasswd -a $USER docker
sudo service docker restart

rm -rf get-docker.sh
```

2.  将用户添加进 docker 组：

    ```
    sudo usermod -aG docker alphapenng
    ```

#### 测试是否安装成功

1. 查看版本：`docker version`
2. 启动 server：`sudo service docker start`
3. 拉取镜像：`sudo docker pull nginx`
4. 查看镜像：` sudo docker image ls`
5. 自启动 docker：`sudo systemctl enable docker`

### Vagrant + Hyper-v 快速创建 Linux 虚拟机

#### Enable Hyper-V using PowerShell

[Windows install Hyper-v](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v)

1. Open a PowerShell console as Administrator.

2. Run the following command:

    ```
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
    ```

If the command couldn't be found, make sure you're running PowerShell as Administrator.
When the installation has completed, reboot.

#### Vagrant

1. 安装 Vagrant

    [Vagrant](https://www.vagrantup.com/)

2. 打开 PowerShell 键入 `vagrant` 无错误提示说明安装成功

#### 创建虚拟机

1. 下载虚拟机镜像 [Vagrant Cloud](https://app.vagrantup.com/boxes/search)

2. 安装 centos/7 虚拟机

    ```
    vagrant init centos/7
    # 以管理员身份启动 PowerShell 并执行以下命令
    vagrant up --provider=hyperv
    ```

3. 查看虚拟机状态

    ```
    vagrant status
    ```

#### Vagrant 的基本使用

-   启动虚拟机

```
vagrant up
```

-   查看虚拟机状态

```
vagrant status
```

-   关闭虚拟机

```
vagrant halt
```

-   删除虚拟机

```
vagrant destroy
```

-   连接 default 虚拟机

```
vagrant ssh
```

-   退出 default 虚拟机

```
exit
```

-   查看 default host ssh 配置的相关信息

```
vagrant ssh-config default
```

-   通过 ssh 连接 default 虚拟机

```
ssh vagrant@172.18.51.54  -i "C:/Users/Barca/Documents/vagrant-demo/.vagrant/machines/default/hyperv/private_key"
```

-   允许虚拟机通过 ssh 密码登录

    1. `sudo vim /etc/ssh/sshd_config`

    2. 添加 `PasswordAuthentication yes` 保存退出

    3. 重启 ssh 服务 `sudo service sshd restart`

### Visual Studio 代码

#### 安装 VS Code

VS Code 在 Windows、macOS 和 Linux 上可用。你可以下载最新的 Windows 安装程序 [here](https://code.visualstudio.com/)。我建议使用稳定版本。

#### 远程扩展

在 VS Code 上安装[远程-WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) 扩展。

> 这允许你使用 WSL 作为集成开发环境，并为你处理兼容性和路径。[Learn more](https://code.visualstudio.com/docs/remote/remote-overview)。

此扩展还允许你使用 `code` 命令直接从你的 WSL 终端启动 VS Code。

如果我在我的存储库的根目录中，我会使用 `code.` 在 VS Code 中启动整个目录。

```
cd my-project
code .
```

#### 更改默认终端

WSL2 shell 可以通过按下 `Ctrl + Shift + P` 并键入/选择终端：选择默认配置文件，然后选择 zsh。

### Chocolatey

Chocolatey 是一个类似于 [homebrew](https://brew.sh/) 的包管理器，但适用于 Windows。

#### 安装 Chocolatey

1. 打开管理 PowerShell 终端

2. 运行 `Get-ExecutionPolicy`

3. 如果返回 `Restricted`，则运行 `Set-ExecutionPolicy AllSigned` 或 `Set-ExecutionPolicy Bypass-Scope Process`

    **_使用 PowerShell，你必须确保 Get-ExecutionPolicy 不受限制。我们建议使用 Bypass 绕过策略以安装或 AllSigned 以提高安全性。_**

4. 现在运行以下命令：

    ```
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    ```

5. 如果你没有看到任何错误，你就可以使用 Chocolatey 了！现在键入 `choco` 或 `choco -?`，或参见 [开始使用](https://docs.chocolatey.org/en-us/getting-started) 了解使用说明

#### 基本 Chocolatey 命令

我们使用 `choco` 命令来使用 chocolatey。请记住，你必须使用管理 shell 才能使其工作。在 [社区包存储库](https://community.chocolatey.org/packages) 上搜索可用的应用程序。

安装一个新包：

```
choco install filename
```

删除包：

```
choco uninstall filename
```

列出所有已安装的软件包：

```
choco list
```

更新：

```
choco upgrade filename
```

或一次更新所有内容：

```
choco upgrade all
```

#### Windows 应用程序

以下是一些我最喜欢的（免费）应用程序，用于在 Windows 上提高生产力和开发：

-   [Wox](http://www.wox.one/)-功能齐全的启动器
-   [RunJs](https://runjs.app/)-JavaScript 和 TypeScript 游乐场
-   [Responsively](https://responsively.app/)-一个修改后的 Web 浏览器，有助于响应式 Web 开发。
-   [Zeal](https://zealdocs.org/)-Dash 的 Windows 版本
-   [Figma](https://www.figma.com/)-协作 UI 设计工具
-   [draw.io](https://app.diagrams.net/)-流程图制作器和图表软件
-   [GitHub desktop](https://desktop.github.com/)-Git 的 GUI
-   [Postman](https://www.postman.com/)-API 工具
-   [Notion](https://www.notion.so/)-项目管理和笔记软件
-   [微软 PowerToys](https://docs.microsoft.com/en-us/windows/powertoys/?WT.mc_id=twitter-0000-docsmsft)-一组高级用户实用程序

你可以在 admin shell 中使用 chocolatey 使用以下命令一次下载所有这些：

```
choco install wox runjs responsively zeal figma drawio github-desktop postman notion powertoys -y
```

### 其他环境

我们可以使用更多的语言和工具。如果你对 JavaScript 和 Web 开发以外的内容感兴趣，请查看以下指南，以将你的开发环境提升到一个新的水平。

#### 🐍 Python

[开始在 Windows 上使用 Python 进行 Web 开发](https://docs.microsoft.com/en-us/windows/python/web-frameworks)

#### 💾Databases

[开始使用 Windows 子系统上的数据库 Linux](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database)
