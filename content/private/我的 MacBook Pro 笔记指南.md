---
2022-08-01 21:08:44
---

# 我的 MacBook Pro 笔记指南

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

## 命令详解

1. route 命令详解

    ```bash
    ROUTE(8)          BSD System Manager's Manual         ROUTE(8)

    NAME

        route -- manually manipulate the routing tables

    SYNOPSIS

        route [-dnqtv] command [[modifiers] args]

    DESCRIPTION

        Route is a utility used to manually manipulate the network routing tables.  It normally is not needed, as a system routing table management
        daemon such as routed(8), should tend to this task.

        The route utility supports a limited number of general options, but a rich command language, enabling the user to specify any arbitrary
        request that could be delivered via the programmatic interface discussed in route(4).

        The following options are available:

        -d      Run in debug-only mode, i.e., do not actually modify the routing table.

        -n      Bypass attempts to print host and network names
                symbolically when reporting actions.  (The process of
                translating between symbolic names and numerical
                equivalents can be quite time consuming, and may
                require correct operation of the network; thus it may
                be expedient to forget this, especially when
                attempting to repair networking operations).

        -t      Run in test-only mode.  /dev/null is used instead of a socket.

        -v      (verbose) Print additional details.

        -q      Suppress all output.

        The route utility provides six commands:

        add         Add a route.
        flush       Remove all routes.
        delete      Delete a specific route.
        change      Change aspects of a route (such as its gateway).
        get         Lookup and display the route for a destination.
        monitor     Continuously report any changes to the routing information base, routing lookup misses, or suspected network partitionings.

        The monitor command has the syntax:

        route [-n] monitor

        The flush command has the syntax:

        route [-n] flush [family]

        If the flush command is specified, route will ``flush'' the routing tables of all gateway entries.  When the address family may is specified
        by any of the -osi, -xns, -atalk, -inet6, or -inet modifiers, only routes having destinations with addresses in the delineated family will be
        deleted.

        The other commands have the following syntax:

        route [-n] command [-net | -host] [-ifscope boundif] destination gateway [netmask]

        where destination is the destination host or network, gateway is the next-hop intermediary via which packets should be routed.  Routes to a
        particular host may be distinguished from those to a network by interpreting the Internet address specified as the destination argument.  The
        optional modifiers -net and -host force the destination to be interpreted as a network or a host, respectively.  Otherwise, if the
        destination has a ``local address part'' of INADDR_ANY (0.0.0.0), or if the destination is the symbolic name of a network, then the route is
        assumed to be to a network; otherwise, it is presumed to be a route to a host.  Optionally, the destination could also be specified in the
        net/bits format.

        For example, 128.32 is interpreted as -host 128.0.0.32; 128.32.130 is interpreted as -host 128.32.0.130; -net 128.32 is interpreted as
        128.32.0.0; -net 128.32.130 is interpreted as 128.32.130.0; and 192.168.64/20 is interpreted as -net 192.168.64 -netmask 255.255.240.0.

        A destination of default is a synonym for -net 0.0.0.0, which is the default route.

        If the destination is directly reachable via an interface requiring no intermediary system to act as a gateway, the -interface modifier
        should be specified; the gateway given is the address of this host on the common network, indicating the interface to be used for transmis-
        sion.  Alternately, if the interface is point to point the name of the interface itself may be given, in which case the route remains valid
        even if the local or remote addresses change.

        For AF_INET and AF_INET6, the -ifscope modifier specifies the additional property of the route related to the interface scope derived from
        interface boundif.  Such property allows for the presence of multiple route entries with the same destination, where each route is associated
        with a unique interface.  This modifier is required in order to manipulate route entries marked with the RTF_IFSCOPE flag.

        The optional modifier -link specify that all subsequent addresses are specified as link-level addresses, and the names must be numeric speci-
        fications rather than symbolic names.

        The optional -netmask modifier is intended to achieve the effect of an OSI ESIS redirect with the netmask option, or to manually add subnet
        routes with netmasks different from that of the implied network interface (as would otherwise be communicated using the OSPF or ISIS routing
        protocols).  One specifies an additional ensuing address parameter (to be interpreted as a network mask). The implicit network mask gener-
        ated in the AF_INET case can be overridden by making sure this option follows the destination parameter.

        For AF_INET6, the -prefixlen qualifier is available instead of the -mask qualifier because non-continuous masks are not allowed in IPv6.  For
        example, -prefixlen 32 specifies network mask of ffff:ffff:0000:0000:0000:0000:0000:0000 to be used.  The default value of prefixlen is 64 to
        get along with the aggregatable address.  But 0 is assumed if default is specified.  Note that the qualifier works only for AF_INET6 address
        family.

        Routes have associated flags which influence operation of the protocols when sending to destinations matched by the routes.  These flags may
        be set (or sometimes cleared) by indicating the following corresponding modifiers:

        -cloning RTF_CLONING    - generates a new route on use
        -xresolve RTF_XRESOLVE   - emit mesg on use (for external lookup)
        -iface    ~RTF_GATEWAY    - destination is directly reachable
        -static RTF_STATIC     - manually added route
        -nostatic ~RTF_STATIC     - pretend route added by kernel or daemon
        -reject RTF_REJECT     - emit an ICMP unreachable when matched
        -blackhole RTF_BLACKHOLE  - silently discard pkts (during updates)
        -proto1 RTF_PROTO1     - set protocol specific routing flag #1
        -proto2 RTF_PROTO2     - set protocol specific routing flag #2
        -llinfo RTF_LLINFO     - validly translates proto addr to link addr

        The optional modifiers -rtt, -rttvar, -sendpipe, -recvpipe, -mtu, -hopcount, -expire, and -ssthresh provide initial values to quantities
        maintained in the routing entry by transport level protocols, such as TCP or TP4. These may be individually locked by preceding each such
        modifier to be locked by the -lock meta-modifier, or one can specify that all ensuing metrics may be locked by the -lockrest meta-modifier.

        In a change or add command where the destination and gateway are not sufficient to specify the route (as in the ISO case where several inter-
        faces may have the same address), the -ifp or -ifa modifiers may be used to determine the interface or interface address.

        The optional -proxy modifier specifies that the RTF_LLINFO routing table entry is the ``published (proxy-only)'' ARP entry, as reported by
        arp(8).

        All symbolic names specified for a destination or gateway are looked up first as a host name using gethostbyname(3).  If this lookup fails,
        getnetbyname(3) is then used to interpret the name as that of a network.

        Route uses a routing socket and the new message types RTM_ADD, RTM_DELETE, RTM_GET, and RTM_CHANGE.  As such, only the super-user may modify
        the routing tables.

    DIAGNOSTICS

        add [host | network ] %s: gateway %s flags %x  The specified route is being added to the tables.  The values printed are from the routing ta-
        ble entry supplied in the ioctl(2) call.  If the gateway address used was not the primary address of the gateway (the first one returned by
        gethostbyname(3)), the gateway address is printed numerically as well as symbolically.

        delete [ host | network ] %s: gateway %s flags %x As above, but when deleting an entry.

        %s %s done  When the flush command is specified, each routing table entry deleted is indicated with a message of this form.

        Network is unreachable  An attempt to add a route failed because the gateway listed was not on a directly-connected network.  The next-hop
        gateway must be given.

        not in table  A delete operation was attempted for an entry which wasn't present in the tables.

        routing table overflow  An add operation was attempted, but the system was low on resources and was unable to allocate memory to create the
        new entry.

        gateway uses the same route  A change operation resulted in a route whose gateway uses the same route as the one being changed.  The next-hop
        gateway should be reachable through a different route.

        The route utility exits 0 on success, and >0 if an error occurs.

    SEE ALSO

        netintro(4), route(4), arp(8), routed(8)

    HISTORY

        The route command appeared in 4.2BSD.

    BUGS

        The first paragraph may have slightly exaggerated routed(8)'s abilities.

    4.4BSD
    ```

2. ttygif

    - Create ttyrec recording

        ```bash
        ttyrec myrecording
        ```

        Hit CTRL-D or type exit when done recording.

    - Convert to gif

        ```bash
        ttygif myrecording -f
        ```
