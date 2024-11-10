<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2022-08-01 06:13:30
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-02-12 09:17:13
 * @FilePath: /balabala/content/private/我的 MacBook Pro 笔记指南.md
-->

# 我的 MacBook Pro 笔记指南

- [我的 MacBook Pro 笔记指南](#我的-macbook-pro-笔记指南)
  - [系统设置](#系统设置)
  - [日常软件](#日常软件)
  - [开发环境配置](#开发环境配置)

## 系统设置

1. 将功能键（F1-F12）设置为标准的功能键
2. 设置 Trackpad （触摸板）轻触为单击
3. 将 Dock 停靠在屏幕左边
4. 全键盘控制模式
5. 快速锁定屏幕

## 日常软件

1. 窗口管理 - Spectacle Magnet
2. 休眠 - Amphetamine Caffeine
3. 快速切换和打开应用程序 - Alt+Tab
4. 剪贴板 - PasteNow
5. 资源管理器 - QSpace Pro
6. 状态栏管理 - Bartender
7. 快速进入 Shell - go2shell
8. 快速录屏 - QuickTimePlayer
9. 截屏工具 - Xnip Snip
10. 图片素材管理 - Eagle
11. 图片上传 - iPic
12. 密码管理 - 1Password
13. 文件比较工具 - FileMerge VisualDiffer Beyond Compare
14. 设计工具 - Photoshop
15. 矢量设计工具 - Sketch
16. 清理工具 - CleanMyMac
17. Markdown - Typora YankNote
18. 播放器 - IINA
19. 办公软件 - WPS
20. NTFS For Mac - Tuxera NTFS For Mac
21. CheatSheet
22. PDF - MarginNote 3
23. 电池管理 - AIDente

## 开发环境配置

1. xcode-select -- install
2. Oh My ZSH!
    - 自动安装 `wget <https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh> -O - | sh`
    - 手动安装 `git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc`
    - 设置完环境变量和别名之后，基本上就可以用了，如果你是个主题控，还可以玩玩 zsh 的主题。在 .zshrc 里找到 ZSH_THEME，就可以设置主题了，默认主题是：`ZSH_THEME=”robbyrussell”`
    - oh my zsh 提供了数十种主题，相关文件在~/.oh-my-zsh/themes 目录下，你可以随意选择，也可以编辑主题满足自己的变态需求，我采用了默认主题 robbyrussell，不过做了一点小小的改动：`PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p%{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}>'`
    - 最后把以下代码加入.zshrc：`[[-s ~/.autojump/etc/profile.d/autojump.sh]] && . ~/.autojump/etc/profile.d/autojump.sh`
3. 替换系统默认终端 - iTerm 2 + tmux
4. 终端下的命令管理 - Homebrew
    - ruby -e "$(curl -fsSL <https://raw.githubusercontent.com/Homebrew/install/master/install>)"
    - brew install wget
    - brew install autojump
    - brew install curl
    - brew install curl-openssl
    - brew install tmux
    - brew install vim
    - brew install tree
    - brew install lua
    - brew install coreutils
    - brew install binutils
    - brew install diffutils
    - brew install findutils
    - brew install the_silver_searcher
    - brew install lrzsz
    - brew install go
    - brew install node
    - brew install jq
    - brew install htop
    - brew install axel
    - brew install cloc
    - brew install shellcheck
    - brew install tldr
    - brew install ncdu
    - brew install glances
    - brew install figlet
    - brew install screenFetch
    - brew install nmap
    - brew install ctop
    - brew install pstree
    - brew install bash-completion
    - brew install lolcat
    - brew install peco
    - brew install cowsay
    - brew install graphviz
    - brew install pyenv
    - brew install --HEAD pyenv-virtualenv
    - brew install howdoi
    - brew install httpie
    - brew tap DimitarPetrov/stegify
    - brew install stegify
    - brew install annie
    - brew install youtube-dl
    - brew install neovim
    - brew install schollz/tap/croc
    - brew install rmtrash
    - brew install nakabonne/ali/ali
    - brew tap emeryberger/scalene
    - brew install --head libscalene
    - brew install bash-snippets
    - brew install cointop
    - brew uninstall cointop && brew install cointop
    - brew install macvim
    - brew install minimum
    - brew install lazydocker
    - brew install dog
    - brew install gron
    - brew install asciinema
    - brew install eva
    - brew install atuin
    - brew install difftastic
    - brew install ttygif
    - brew install ipinfo-cli
    - brew install gh
    - brew install trzsz-go
    - brew install tesseract
    - brew install pngpaste
    - brew install xclip
    - brew install gitui
    - brew install zurawiki/brews/gptcommit
5. 终端下管理非终端软件 - Homebrew Cask

    - brew cask list
    - brew cask search chrome ==> Partial matches
    - brew cask install google-chrome
    - brew cask install iterm2
    - brew cask install firefox
    - brew cask install alfred
    - brew install dash
    - brew cask install visual-studio-code
    - brew install postman
    - brew cask install wireshark
    - brew cask install drawio
    - brew cask install beyond-compare
    - brew cask install youdaodict
    - brew cask install typora
    - brew cask install docker
    - brew cask install the-unarchiver
    - brew tap caskroom/fonts
    - brew cask install font-source-code-pro
    - brew install rdm
    - brew install imagemagick
    - brew cask install iina
    - brew cask install cheatsheet
    - brew cask install eul
    - brew cask install stats
    - brew cask install upic
    - brew install --cask fig
    - brew install xquartz
    - brew install freerdp
    - brew install --cask cakebrew
    - brew install --cask android-platform-tools
    - codelite

        ```bash
        # we need this part since we bring our own libssh bound to version 0.9.6
        brew unlink libssh

        brew tap eranif/codelite
        brew reinstall --cask codelite-official

        # in order to avoid macOS errors about "damaged app can't be opened"...
        xattr -cr /Applications/codelite.app/
        ```

6. 终端 - kitty
7. 代码编辑器 - CodeRunner VSCode
8. 代码分享 - Carbonize
9. 代码保存 - SnippetLab
10. 文件同步 - GoodSync
11. 文本编辑器 - CotEditor
12. 服务器管理 - ServerCat
13. 参考文档 - Reference Devdocs
14. 虚拟机 - VMware Fusion
