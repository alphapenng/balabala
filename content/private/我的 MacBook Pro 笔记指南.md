---
2022-08-01 21:08:44
---

# 我的 MacBook Pro 笔记指南

* 系统设置
    1. 将功能键（F1-F12）设置为标准的功能键
    2. 设置 Trackpad （触摸板）轻触为单击
    3. 将 Dock 停靠在屏幕左边
    4. 全键盘控制模式
    5. 快速锁定屏幕
   
* 日常软件
    1. 窗口管理 -  Spectacle Magnet
    2. 搜索 - Alfred + Dash
    3. 休眠 -  Amphetamine Caffeine
    4. 快速切换和打开应用程序 - Manico
    5. 剪贴板 - Clipy
    6. 资源管理器 - XtraFinder ForkLift
    7. 状态栏管理 -  Vanilla Bartender
    8. 快速进入 Shell - go2shell
    9. 快速录屏 - QuickTimePlayer
    10. 截屏工具 -  Xnip Snip
    11. 图片素材管理 - Eagle
    12. 图片上传 - iPic
    13. 密码管理 - 1Password
    14. 文件比较工具 - FileMerge VisualDiffer Beyond Compare
    15. 设计工具 - Photoshop
    16. 原型设计工具 - 墨刀
    17. 矢量设计工具 - Sketch
    18. 清理工具 - CleanMyMac
    19. 印象笔记
    20. 幕布
    21. 石墨文档
    22. Markdown - Typora
    23. 播放器 - IINA
    24. WPS
    25. NTFS For Mac - Tuxera NTFS For Mac
    26. CheatSheet
    27. PDF - MarginNote 3

* 开发环境配置
    1. xcode-select -- install
    2. Oh My ZSH!
        * 自动安装 wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
        * 手动安装 git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
        * 设置完环境变量和别名之后，基本上就可以用了，如果你是个主题控，还可以玩玩 zsh 的主题。在 .zshrc 里找到ZSH_THEME，就可以设置主题了，默认主题是：ZSH_THEME=”robbyrussell”
        * oh my zsh 提供了数十种主题，相关文件在~/.oh-my-zsh/themes目录下，你可以随意选择，也可以编辑主题满足自己的变态需求，我采用了默认主题robbyrussell，不过做了一点小小的改动：PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p%{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}>'
        * 最后把以下代码加入.zshrc：[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh
    1. 替换系统默认终端 - iTerm 2 + tmux
    2. 终端下的命令管理 - Homebrew
        * ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        * brew install wget
        * brew install autojump
        * brew install curl
        * brew install curl-openssl
        * brew install tmux
        * brew install vim
        * brew install tree
        * brew install lua
        * brew install coreutils
        * brew install binutils
        * brew install diffutils
        * brew install findutils
        * brew install the_silver_searcher
        * brew install lrzsz
        * brew install go
        * brew install node
        * brew install jq
        * brew install htop
        * brew install axel
        * brew install cloc
        * brew install shellcheck
        * brew install tldr
        * brew install ncdu
        * brew install glances
        * brew install figlet
        * brew install screenFetch
        * brew install nmap
        * brew install ctop
        * brew install pstree
        * brew install bash-completion
        * brew install lolcat
        * brew install peco
        * brew install cowsay
        * brew install graphviz
        * brew install pyenv
        * brew install --HEAD pyenv-virtualenv
        * brew install howdoi
        * brew install httpie
        * brew tap DimitarPetrov/stegify
        * brew install stegify
        * brew install annie
        * brew install youtube-dl
        * brew install neovim
        * brew install schollz/tap/croc
        * brew install rmtrash
        * brew install nakabonne/ali/ali
        * brew tap emeryberger/scalene
        * brew install --head libscalene
        * brew install bash-snippets
        * brew install cointop
        * brew uninstall cointop && brew install cointop
        * brew install macvim
        * brew install minimum
        * brew install lazydocker
        * brew install dog
        * brew install gron
        * brew install asciinema
        * brew install eva
    3. 终端下管理非终端软件 - Homebrew Cask
        * brew cask list
        * brew cask search chrome ==> Partial matches
        * brew cask install google-chrome
        * brew cask install iterm2
        * brew cask install firefox
        * brew cask install alfred
        * brew install dash
        * brew cask install visual-studio-code
        * brew install postman
        * brew cask install wireshark
        * brew cask install drawio
        * brew cask install beyond-compare
        * brew cask install youdaodict
        * brew cask install typora
        * brew cask install docker
        * brew cask install the-unarchiver
        * brew tap caskroom/fonts
        * brew cask install font-source-code-pro
        * brew install rdm
        * brew install imagemagick
        * brew cask install iina
        * brew cask install cheatsheet
        * brew cask install eul
        * brew cask install stats
        * brew cask install upic
        * brew install --cask fig
        * brew install xquartz
        * brew install freerdp
        * brew install --cask cakebrew
    4. 虚拟机 - Parallels Desktop
    5. 代码编辑器 - CodeRunner
    6. 代码分享 - Carbonize
    7. 代码保存 - SnippetLab
    8. Dash
    9. 文件同步 - GoodSync
    10. 远程登录 - RustDesk
    11. 文本编辑器 - CotEditor
    12. 电池管理 - AIDente
