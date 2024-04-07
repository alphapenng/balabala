> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [liujiacai.net](https://liujiacai.net/blog/2024/04/05/robust-shell-scripting/)

> 最近在写一个 asdf 的插件，为了保证移植性，它对插件所能使用的命令有及其严格的限制，banned_commands.bats 里列举了被禁用的命令，

最近在写一个 asdf 的[插件](https://github.com/zigcc/asdf-zig/pull/2/files)，为了保证移植性，它对插件所能使用的命令有及其严格的[限制](https://asdf-vm.com/plugins/create.html#golden-rules-for-plugin-scripts)，[banned_commands.bats](https://github.com/asdf-vm/asdf/blob/master/test/banned_commands.bats) 里列举了被禁用的命令， 这进一步加深笔者的一个印象：写好 Shell 脚本真不是一件简单地事情。

可能每个程序员都会或多或少的被 Shell 折磨过，这篇文章就来系统地讲述 Shell 编程，重新认识一下这门即熟悉又陌生的语言， 当然，更重要的是介绍如何写出一份健壮的 Shell 脚本。

概述
--

Shell 编程是一个很大的范畴，通常是指用一门 Shell（比如：zsh、bash） 外加各种命令（比如：grep、awk）来编写。 [POSIX shell](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html) 算是一个标准，但功能相对简陋，[Bash](https://www.gnu.org/software/bash/manual/html_node/index.html) 历史最为悠久，应用最广泛，因此很大程度上 Shell 编程就是写 Bash 脚本。 本文内容会以 POSIX 标准为基础，同时涵盖 Bash 中常用的功能。一门 Shell 通常会提供以下功能，后文也会就这几方面展开叙述：

*   变量
*   流程控制，比如：if、while、for 等
*   函数
*   [内置命令](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html)，比如： `cd` 、 `[` 、 `:` 等

需要说明一点，Shell 编程对空格的处理十分敏感，代码相同，但空格不同，意义就不一样！后面在介绍时也会不断强调这一点。

变量
--

变量是任何一门语言中最基本、最实用的基本组件，很难想象一个没有变量的语言会是怎样，Shell 中定义变量的语法如下：

这里有两点需要注意：

*   等号左右两侧没有空格，否则就会被视为命令调用，这一点对初学者来说十分迷惑，但仔细想想其实是合理的，否则解释器怎么知道用户的意图呢？
*   变量类型只有 string，可以用后面提到的 `((exp))` [这种语法](https://www.gnu.org/software/bash/manual/html_node/Shell-Arithmetic.html)对变量进行四则运算

使用一个变量的语法是 `$var` ，推荐的写法是 `"${var}"` 用双引号包起来可以保证变量里即使有空格，也不会为视为两个参数，加花括号是为了防止歧义，比如：

上面例子意图是创建 `/tmp/john_file` 这个文件，但是实际上 `user_file` 整体会被识别成变量名，因此会出现不符合预期的行为， 改用 `touch "/tmp/${user}_file"` 就可以消除歧义了。

在实际使用时，经常会有给变量赋默认值的情况，比如当 CC 没有指定时，设置为 gcc，可用下面这种语法：

此外，在交互式脚本中，可以使用 `read` 这个 Bash 内置函数来让用户输入变量的值：

```
var=value
```

除了用户定义的变量，Shell 中有大量[内置变量](https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html)，下面是一些常见的：

<table><thead><tr><th>内置变量</th><th>含义</th></tr></thead><tbody><tr><td><code>$0</code> .. <code>$9</code></td><td>脚本、函数执行时的参数，最多有 9 个，第一个为脚本、函数名本身</td></tr><tr><td><code>$@</code></td><td>所有的参数，相当于 <code>$1</code> 一直到最后</td></tr><tr><td><code>$*</code></td><td>和 <code>$@</code> 类型，只是不会保留空格，"File with spaces" 会变成 <code>File</code> <code>with</code> <code>spaces</code> 三个参数</td></tr><tr><td><code>$$</code></td><td>当前运行 shell 的 PID（进程标识符）</td></tr><tr><td><code>$?</code></td><td>上一条命令的返回值</td></tr><tr><td><code>IFS</code></td><td>Internal Field Separator，用来区分不同参数直接的<a href="https://www.gnu.org/software/bash/manual/html_node/Word-Splitting.html">分隔符</a>，默认是 <code>SPACE</code> <code>TAB</code> <code>NEWLINE</code></td></tr></tbody></table>

### Quote

在上面已经介绍过，在使用变量时最好用双引号包起来，否则可能会有问题：

在上面命令中，touch 命令会意外的创建两个文件，而不是一个名为 `a b` 的文件。

除了双引号，还有单引号，即 `'$var'` ，表示不会对 var 进行求值，而是原样输出。

### 数组

Bash 对变量类型进行了增强，提供了索引数组和关联数组两种类型：

*   索引数组（Indexed arrays）使用整数（包括[算术表达式](https://www.gnu.org/software/bash/manual/html_node/Shell-Arithmetic.html)引用），索引从 0 开始
*   关联数组（Associative arrays）使用任意字符串，类似于其他语言的 HashMap 类型

```
user=john
touch "/tmp/$user_file"
```

条件控制
----

如果 `test-commands` 的返回值是 0，表示 true，接着执行后面的 `consequent-commands;` ，否则进行后面的判断。

除了判断一个命令的返回值，POSIX shell 还提供了一个特殊的内置命令： `test` ，它后面可以跟一组条件表达式，用于常规逻辑的判断， 比如两个变量是否相等。 `test` 命令还有个等价的命令，即 `[` 。只是用 `[` 时，最后一个参数必须是 `]` 表示判断语句的结束， 而且这种写法更为常见，但我们需要意识到 `[` 是个内置命令。

上面 if 的语法虽然看起来简单，但还是想强调三点：

1.  if 语句最后有个 `fi` ，表示结束
2.  `then` 必须在单独的一行，如果想和 `if` 放一起，可以用隔离符（比如：分号，换行是另一种常见的隔离符）将它们分开： `if [ .. ]; then` 。后面可以看到，这条隔离规则适用于所有复杂的表达式。
3.  使用 `[ condition ]` 进行判断时，两边必须要有空格。这里可以做个实验：
    
    ```
    CC=${CC:-gcc}
    ```
    
    为了弄清楚上面的错误，我们可以使用 `bash -vx if.sh` 对脚本进行调试：
    
    ```
    echo "What's your name?"
    read my_name
    echo "Hello ${my_name}"
    ```
    
    可以看到当 `foo` 这个变量没有定义时，会展开成 `[ = bar ]` ，很明显这是语法错误，因为 `=` 是个二元运算符， 这里报错可以解读为：在 `[` 后期望跟一个一元操作符。而且这里如果写成了 `[ ${foo} = "bar" ]` 也是错误， 因为它和上面展开是等价的！必须是 `[ "${foo}" = "bar" ]` 才正确。
    
    下面是 POSIX test 命令中支持的一些[条件表达式](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html)，其中需要着重注意的是：
    
    > 字符串比较用的是 `=` ，数字比较用的是 `-eq`
    

<table><thead><tr><th>条件表达式</th><th>含义</th></tr></thead><tbody><tr><td><code>[ -e pathname ]</code></td><td>pathname 所指的文件存在，不关心文件类型</td></tr><tr><td><code>[ -f pathname ]</code></td><td>pathname 所指的文件存在，并且是普通文件</td></tr><tr><td><code>[ -d pathname ]</code></td><td>pathname 所指的文件存在，并且是目录</td></tr><tr><td><code>[ -S pathname ]</code></td><td>pathname 所指的文件存在，并且是 Socket</td></tr><tr><td><code>[ -L pathname ]</code></td><td>pathname 所指的文件存在，并且是软链</td></tr><tr><td><code>[ -w pathname ]</code></td><td>pathname 所指的文件存在，并且有可写的权限</td></tr><tr><td><code>[ -x pathname ]</code></td><td>pathname 所指的文件存在，并且有可执行权限</td></tr><tr><td><code>[ -s pathname ]</code></td><td>文件大小是否大于 0</td></tr><tr><td><code>[ -n string ]</code></td><td>字符串长度是否大于 0</td></tr><tr><td><code>[ -z string ]</code></td><td>字符串长度是否等于 0</td></tr><tr><td><code>[ string ]</code></td><td>字符串是否不是 null</td></tr><tr><td><code>[ s1 = s2 ]</code></td><td>s1 是否等于 s2</td></tr><tr><td><code>[ s1 != s2 ]</code></td><td>s1 是否不等于 s2</td></tr><tr><td><code>[ n1 -eq n2 ]</code></td><td>数字 n1 是否等于数字 n2</td></tr><tr><td><code>[ n1 -ne n2 ]</code></td><td>数字 n1 是否不等于数字 n2</td></tr><tr><td><code>[ n1 -gt n2 ]</code></td><td>数字 n1 是否大于（great than）数字 n2</td></tr><tr><td><code>[ n1 -ge n2 ]</code></td><td>数字 n1 是否大于或等于数字 n2</td></tr><tr><td><code>[ n1 -lt n2 ]</code></td><td>数字 n1 是否小于（less than）数字 n2</td></tr><tr><td><code>[ n1 -le n2 ]</code></td><td>数字 n1 是否小于或等于数字 n2</td></tr><tr><td><code>[ express1 -a express2 ]</code></td><td>两个表达式都是 true</td></tr><tr><td><code>[ express1 -o express2 ]</code></td><td>两个表达式有一个为 true</td></tr><tr><td><code>[ ! express ]</code></td><td>对表达式取反</td></tr></tbody></table>

### Bash 加强版判断命令

除了 `[ exp ]` 表示判断，Bash 中增加了 `[[ exp ]]` 这种语法，它支持更高级的条件表达式：

*   `s1 < s2` ， `s1 > s2` 对字符串按照字典序进行大小判断
*   `s1 == s2` ， `s1 != s2` 右边的 s2 在没有被 quote 时，会被视为模式，对 s1 进行[通配符模式匹配](https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html)。
    
*   `s1 =~ s2` ，在 s2 没有被 quote 时，被视为 [POSIX 扩展的正则](https://liujiacai.net/blog/2014/12/07/regexp-favors)，进行正则匹配（内部用 [regexec](https://linux.die.net/man/3/regexec) 实现）。比如：
    
    ```
    foo="a b"
    touch $foo
    ```
    
    更多使用细节，可以参考：[3.2.5.2 Conditional Constructs](https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html)。
    
*   `(( expression ))` 会对 expression 进行四则运算，当结果不为 0 是，表示 true。支持的运算符在[这里](https://www.gnu.org/software/bash/manual/html_node/Shell-Arithmetic.html)查看。需要说明一点，这个表达式只支持整数，如果是浮点数，需要利用其他命令，比如 [bc](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/bc.html) 。
    
    ```
    # 索引数组声明方式
    declare -a indexed=(hello world)
    # 关联数组声明方式，bash 4 开始支持
    # declare -A associative=([hello]=1 [world]=2)
    
    echo "First element is" ${indexed[0]}
    for i in ${indexed[@]}; do
      echo "$i"
    done
    ```
    

循环控制
----

使用示例：

```
First element is hello
hello
world
```

```
if test-commands
then
  consequent-commands;
[elif more-test-commands; then
  more-consequents;]
[else alternate-consequents;]
fi
```

上面这个例子中用到了算数表达式 `$((expression))` 。

```
if ["${foo}" = "bar" ]
then
  echo "bar"
else
  echo "not bar"
fi
```

这个例子中，通过修改 IFS 来达到对字符串进行分割的效果。需要注意的是， for 语句不能写成 `for x in "${foo}"` ， 因为这时就不会对其进行分割了。

### Bash 增强版 for

一个示例：

```
bash: line 1: [: =: unary operator expected
not bar
```

函数
--

[函数定义](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_05)的语法如下：

```
+ '[' = bar ']'
if.sh: line 1: [: =: unary operator expected
```

[compound-command](https://www.gnu.org/software/bash/manual/html_node/Compound-Commands.html) 可以是上面提到的各种流程控制命令，比如 if、while、for 等，比如：

```
if [[ "foo" == f* ]]; then
  echo "matched"
else
  echo "not matched"
fi

if [[ "foo" == "f*" ]]; then
  echo "matched"
else
  echo "not matched"
fi
```

也可以是后面介绍的分组命令。函数最后一条命令的返回值为整体的返回值，返回值只能是数字，0 表示正常返回。 也可以用 `return` 来提前返回。和其他语言不同的是，shell 中的函数没有作用域的概念，如下例：

```
matched
not matched
```

可以看到，函数里面可以直接修改外部的变量，如果要避免这种行为，可以使用 local 这个 Bash 内置函数来表示声明内部变量：

```
if [[ "foo" =~ f.* ]]; then
  echo "matched"
else
  echo "not matched"
fi
```

### 分组命令

分组命令（grouping commands）是一次执行多个命令的语法，可以作为函数体，也可以单独执行。

第二种方式结尾多了一个分号，这是由于花括号不是分隔符，如果没有分号来隔离， `}` 可能表示的是命令的一个参数，因此这里用分号表示后面的字符不再是命令的参数了，出来用分号外，换行符是更为常见的分隔符。而圆括号没有这个问题，因为他本身就是一个分隔符。

```
matched
```

通过上面的输出[可以看到](https://unix.stackexchange.com/questions/138463/do-parentheses-really-put-the-command-in-a-subshell)，在子 shell 环境执行的命令也可以读到父环境的变量，这是由于在进行 fork 时，子进程和父进程的内存是一样的，真正的区别在于，在子 shell 环境创建的变量，在父环境中是看不到的。

内置命令
----

[内置命令](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html)包含在 shell 本身中。当内置命令的名称作为简单命令（参见简单命令）的第一个单词时，shell 会直接执行该命令，而不会调用其他程序。内置命令可以实现外部命令无法实现的功能。最常见内置命令是 `cd` ，它会改变 shell 的当前工作目录（CWD），这个功能是无法通过外部命令来实现的。其他常见命令：

<table><tbody><tr><td>内置命令</td><td>含义</td></tr><tr><td><code>: [arguments]</code></td><td>除了扩展参数和执行重定向外，不做任何操作。返回状态为零</td></tr><tr><td><code>. filename [arguments]</code></td><td>在当前 shell 上下文中读取并执行文件名参数中的命令</td></tr><tr><td><code>exec [-cl] [-a name]</code></td><td>如果提供 command，它将替换当前 shell 而不创建新进程</td></tr><tr><td><code>export name=value</code></td><td>标记环境中要传递给子进程的每个变量</td></tr><tr><td><code>set [-/+o option]</code></td><td>当带 option 时，可以改变 shell 的属性， <code>-o</code> 表示开启， <code>+</code> 表示关闭</td></tr></tbody></table>

常用命令
----

```
if (( 1 + 1 )); then
  echo "true"
else
  echo "false"
fi

if (( 1 - 1 )); then
  echo "true"
else
  echo "false"
fi

echo "0.1 + 0.1" | bc -l

# 这里先用命令替换进行浮点数运算、比较，之后在用 (( .. )) 表达式判断真伪
if (( $(echo "0.1+0.1 == 0.2" | bc -l) )); then
  echo "0.1+0.1 = 0.2"
else
  echo "0.1+0.1 != 0.2"
fi
```

更多 Shell 参数替换命令可以参考：[Shell Parameter Expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)

模板
--

鉴于写一个健壮的 Shell 脚本十分困难，因此网络上不断有人分享 Shell 编写的心得，下面[这个模板](https://gist.github.com/m-radzikowski/53e0b39e9a59a1518990e76c2bff8038)就是一个不错的经验之谈：

```
true
false
.2
0.1+0.1 = 0.2
```

1.  首先这里用 [set](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html) 这个内置命令设置了 shell 的属性，以 `-` 开头表示开启以下属性：
    
    *   `e` ，POSIX 标准。任何命令失败时，立刻退出，就像执行了 `exit` 一样，失败时会产生一个 ERR 信号供 trap 捕捉。
    *   `o pipefail` ，Bash 提供。在执行 pipeline 时， `e` 只会保证第一条命令失败后，后面的 pipeline 不会执行，但 shell 脚本会继续执行，这个选项就可以解决这个问题：
        
        ```
        while test-commands; do consequent-commands; done
        
        for name [ [in [words …] ] ; ] do commands; done
        ```
        
        可以看到 bar 还是输出了。加上 `-o pipefail` 后就不会了：
        
        ```
        for i in 1 2 3
        do
          echo "Looping ... number $i"
        done
        ```
        
    *   `u` ，POSIX 标准。对未定义变量展开时，立刻退出。
    *   `-E` ，Bash 提供。可以保证在某些复杂命令出现错误时，trap 可以捕捉到 ERR 信号。
        
        ```
        Looping ... number 1
        Looping ... number 2
        Looping ... number 3
        ```
        
        这里可以看到， `-e` 已经阻止 shell 继续执行，但是 trap 并没有捕捉到错误信号，加上 `-E` 就可以避免这个问题：
        
        ```
        x=3
        while [ $x -gt 0 ]
        do
          echo "Looping ... number $x"
          x=$(($x-1))
        done
        ```
        
2.  `cleanup` 里面的 `trap - SIGINT SIGTERM ERR EXIT` 表示后面指定信号的行为重置为 shell 启动时的值，这样可以防止 cleanup 因接受到多个信号，而被重复调用多次。
3.  最后的 `script_dir` 表示脚本所在位置，这样不论用什么方式调用它，都可以获得正确的绝对路径。

此外，还可以利用 [ShellCheck](https://www.shellcheck.net/) 这个静态检查工具来帮助我们发现代码中的潜在问题，每个错误都对应一个专门的 [WIKI 页面](https://github.com/koalaman/shellcheck/wiki/Checks)来解释。

Emacs 用户的话，可以利用 [auto-insert](https://www.gnu.org/software/emacs/manual/html_node/autotype/Autoinserting.html) 来自动插入这个模板。

总结
--

通过整理这篇文章，笔者自己对 shell 这门古老语言有了不少新的认识，之前经常看到写文章说推荐 XX 用法，不要用 YY 用法， 也没去深究，导致每次用都忘记了，遇到问题再去 Google，浪费了不少时间，想要真正的偷懒，还是要做到『知其然、知其所以然』， 不然肯定会重复的犯同样的错误！