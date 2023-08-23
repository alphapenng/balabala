> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzIyNDQ2MTQwOQ==&mid=2247493433&idx=1&sn=8a6f2c9975f34b9e2e7be62479f24478&chksm=e80c3037df7bb9212d320ca3fff025a81347fbc163add2a0456ea5a522ab6a836755af84ccb6&token=1949573976&lang=zh_CN#rd)

阮一峰的博客是科技类博客中的佼佼者，内容丰富，排版精美，业界良心，访问量巨大。每周五的《科技爱好者周刊》更是备受关注与期待。作为阮一峰博客的拥趸和忠实读者，我迫不及待地盼望着每周五的到来，期待着能够在周刊中找到那些令人震撼的科技新闻与深度分析。同样，阮老师著译出版物质量都很高，其关于 JavaScript 的相关作品更是深入浅出，广受读者欢迎。

今天看到阮一峰老师的最新电子书 TypeScript 教程 - 网道 [1] 已经上线了，为了方便离线阅读，就用 `mdbook` 将其打包成 `PDF` 和 `EPUB` 格式。文末附下载。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/SVEibGmlMicGeQK5a5JiaFr0ZdLl57b3OwjnicN6GpXGzElhibbOoicVgALAO92hpvZI2Jxzw0qll0iaESYEU2HFrTonQ/640?wx_fmt=png)

mdbook
------

介绍 - mdBook 中文文档 [2]

**mdBook** 是一个由 RUST 构建的命令行工具，可以将 Markdown 文档，变成 HTML 网站，可以用来制作电子书。这样的工具，用在产品信息或是 API 文档，教程，课件资料等等场景。

*   • **轻量级：** Markdown[3] 语法
    
*   • **搜索：** 集成 search[4] 功能
    
*   • **语法高亮：** syntax highlighting[5]
    
*   • **多个主题：** Theme[6] 自定义输出的格式
    
*   • **预先处理器：** Preprocessors[7] 预处理的扩展，比如
    
*   • **后端：** Backends[8] 选择输出的渲染格式
    
*   ・ 自然，还具有 Rust[9] 加持，速度杠杠的。
    
*   ・ 甚至，Rust 代码 [10] 的自动测试。
    

### 安装

安装 mdbook 非常简单，在安装好 RUST 环境和工具链后，只需要执行下面的命令即可：

```
cargo install mdbook
```

### 创建

如创建一个名为 `tsbook` 的电子书项目：

![](https://mmbiz.qpic.cn/sz_mmbiz_jpg/SVEibGmlMicGeQK5a5JiaFr0ZdLl57b3OwjarWkh8C6hosOHibXIQdBK0lE3OCzGlZR86wlPRN6y2zibHjhiaCjIC1UQ/640?wx_fmt=jpeg)

mdbook init

```
PS C:\projects\online-books> mdbook init tsbookDo you want a .gitignore to be created? (y/n)yWhat title would you like to give the book?a typescript book2023-08-08 23:34:37 [INFO] (mdbook::book::init): Creating a new book with stub contentAll done, no errors...
```

默认会创建一个 `src` 目录，里面有一个 `SUMMARY.md` 文件，用来存放目录结构。

```
📦tsbook
 ┣ 📂book
 ┣ 📂src
 ┃ ┣ 📜chapter_1.md
 ┃ ┗ 📜SUMMARY.md
 ┣ 📜.gitignore
 ┗ 📜book.toml
```

其中，根目录下的 `book.toml` 是配置文件，可以用来配置电子书的标题、作者、语言、主题等信息。

```
[book]authors = ["mzhren"]language = "en"multilingual = falsesrc = "src"title = "a typescript book"
```

`src` 目录下的 `SUMMARY.md` 是目录结构文件，用来配置电子书的目录结构。

```
# Summary- [Chapter 1](./chapter_1.md)
```

### 预览

```
mdbook serve
```

![](https://mmbiz.qpic.cn/sz_mmbiz_jpg/SVEibGmlMicGeQK5a5JiaFr0ZdLl57b3OwjtttfLmfqgicibibPPAwof7trZpPTXzAgicUnILLpqnaG62q6z3dTYGMZzQ/640?wx_fmt=jpeg)

mdbook serve

### 打包

```
mdbook build
```

这样就会在 `book` 目录下生成一个 `index.html` 文件，用浏览器打开即可，跟预览的效果一样，可以用来发布到网站上。

```
📦tsbook
 ┣ 📂book
 ┃ ┣ 📂css
 ┃ ┃ ┣ 📜chrome.css
 ┃ ┃ ┣ 📜general.css
 ┃ ┃ ┣ 📜print.css
 ┃ ┃ ┗ 📜variables.css
 ┃ ┣ 📂FontAwesome
 ┃ ┃ ┣ 📂css
 ┃ ┃ ┃ ┗ 📜font-awesome.css
 ┃ ┃ ┗ 📂fonts
 ┃ ┃ ┃ ┣ 📜fontawesome-webfont.eot
 ┃ ┃ ┃ ┣ 📜fontawesome-webfont.svg
 ┃ ┃ ┃ ┣ 📜fontawesome-webfont.ttf
 ┃ ┃ ┃ ┣ 📜fontawesome-webfont.woff
 ┃ ┃ ┃ ┣ 📜fontawesome-webfont.woff2
 ┃ ┃ ┃ ┗ 📜FontAwesome.ttf
 ┃ ┣ 📂fonts
 ┃ ┃ ┣ 📜fonts.css
 ┃ ┃ ┣ 📜OPEN-SANS-LICENSE.txt
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-300.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-300italic.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-600.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-600italic.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-700.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-700italic.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-800.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-800italic.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-italic.woff2
 ┃ ┃ ┣ 📜open-sans-v17-all-charsets-regular.woff2
 ┃ ┃ ┣ 📜SOURCE-CODE-PRO-LICENSE.txt
 ┃ ┃ ┗ 📜source-code-pro-v11-all-charsets-500.woff2
 ┃ ┣ 📜.nojekyll
 ┃ ┣ 📜404.html
 ┃ ┣ 📜ayu-highlight.css
 ┃ ┣ 📜book.js
 ┃ ┣ 📜chapter_1.html
 ┃ ┣ 📜clipboard.min.js
 ┃ ┣ 📜elasticlunr.min.js
 ┃ ┣ 📜favicon.png
 ┃ ┣ 📜favicon.svg
 ┃ ┣ 📜highlight.css
 ┃ ┣ 📜highlight.js
 ┃ ┣ 📜index.html
 ┃ ┣ 📜mark.min.js
 ┃ ┣ 📜print.html
 ┃ ┣ 📜searcher.js
 ┃ ┣ 📜searchindex.js
 ┃ ┣ 📜searchindex.json
 ┃ ┗ 📜tomorrow-night.css
 ┣ 📂src
 ┃ ┣ 📜chapter_1.md
 ┃ ┗ 📜SUMMARY.md
 ┣ 📜.gitignore
 ┗ 📜book.toml
```

生成 PDF
------

生成 PDF 的方法有很多种，比如用浏览器打印，或者用 Pandoc 等工具。mdbook 有一个 mdbook-pdf 项目，可以将 mdbook 生成的 HTML 文件，转换成 PDF 格式。

mdbook-pdf 有两种生成 PDF 的方式：

*   ・ 通过浏览器打印功能，将 HTML 文件转换成 PDF 文件。
    
*   ・ 通过 wkhtmltopdf 工具，将 HTML 文件转换成 PDF 文件。
    

### 安装 mdbook-pdf

```
cargo install mdbook-pdf
```

### 配置《TypeScript 教程》

下载《TypeScript 教程》的源码：

wangdoc/typescript-tutorial: TypeScript 教程 [11]

用 mdbook 初始化已经创建了一个电子书项目，现在我们需要将《TypeScript 教程》的内容拷贝到 `src` 目录下。

设置好目录结构后，我们需要修改 `SUMMARY.md` 文件，将目录结构写入到 `SUMMARY.md` 文件中。

```
# Summary- [简介](./intro.md)- [基本用法](./basic.md)- [any 类型](./any.md)- [类型系统](./types.md)- [数组](./array.md)- [元组](./tuple.md)- [symbol 类型](./symbol.md)- [函数](./function.md)- [对象](./object.md)- [interface](./interface.md)- [类](./class.md)- [泛型](./generics.md)- [Enum 类型](./enum.md)- [类型断言](./assert.md)- [模块](./module.md)- [namespace](./namespace.md)- [装饰器](./decorator.md)- [装饰器（旧语法）](./decorator-legacy.md)- [declare 关键字](./declare.md)- [d.ts 类型声明文件](./d.ts.md)- [运算符](./operator.md)- [类型映射](./mapping.md)- [类型工具](./utility.md)- [注释指令](./comment.md)- [tsconfig.json 文件](./tsconfig.json.md)- [tsc 命令](./tsc.md)
```

更改 toml 文件，将电子书的标题、作者、语言、主题等信息修改成《TypeScript 教程》的信息。

```
[book]authors = ["阮一峰"]language = "zh-CN"multilingual = falsesrc = "src"title = "阮一峰《TypeScript 教程》"# 添加章节序号[preprocessor.chapter-number]# 导出 html、pdf、带目录的pdf[output.html][output.pdf]# 添加页眉页脚display-header-footer= trueheader-template = "<h3 style='font-size:8px; margin-left: 85px;width:200px;' class='title'></h3><h3 style='margin-left:120px;font-size:8px;'>https://wangdoc.com/typescript/</h3>"footer-template = "<p style='font-size:10px; margin-left: 48%'><span class='pageNumber'></span> / <span class='totalPages'></span></p>"prefer-css-page-size = true[output.pdf-outline]optional = true
```

### 生成 PDF

```
mdbook build
```

这样，pdf 文件就生成了。其默认路径是 `book/pdf/output.pdf`。

### 遗留问题

生成的 PDF 文件，没有目录（虽然安装了 `mdbook-pdf-outline` ，但调用不到）。可能是我配置的问题，还需要进一步研究。

生成 EPUB
-------

`mdbook` 有一个实验性质的 `mdbook-epub` 后端渲染器，可以将 `mdbook` 生成的 HTML 文件，转换成 EPUB 格式。

### 安装 mdbook-epub

```
cargo install mdbook-epub
```

只要在 `book.toml` 文件中添加 `epub` 配置，就可以生成 EPUB 文件了。

```
+ [output.epub]
```

`mdbook-epub` 也可以`单独`使用，不需要 `mdbook` 来调用它，自己就可渲染出 EPUB 文件。如果只想渲染 EPUB 文档，这种方式非常有用。

```
$ mdbook-epub -s true ./path/to/book/dir$ mdbook-epub --standalone true ./path/to/book/dir
```

`epub` 的排版相对于 `pdf` 来说，要复杂一些。而阮一峰老师这本书，写得十分规整，排版也很漂亮，也不涉及图片，所以生成的 epub 文件也非常漂亮。

PDF & EPUB 下载
-------------

https://www.aliyundrive.com/s/yEkXFFeqaph 提取码: wl94

链接：https://pan.baidu.com/s/1eiPaDjTwgjD4O1V_vU-Bzg?pwd=1234 提取码：1234

参考资料
----

*   • mdBook - mdBook Documentation[12]
    
*   • mdbook 写作真的好用 - 掘金 [13]
    
*   • HollowMan6/mdbook-pdf: A backend for mdBook written in Rust for generating PDF based on headless chrome and Chrome DevTools Protocol. (用 Rust 编写的 mdBook 后端，基于 headless chrome 和 Chrome 开发工具协议生成 PDF)[14]
    
*   • mdbook-pdf-outline · PyPI[15]
    
*   • mdbook-chapter-number — Rust application // Lib.rs[16]
    
*   • mdbook-pdf/README_CN.md at main · HollowMan6/mdbook-pdf[17]
    
*   • Michael-F-Bryan/mdbook-epub: An experimental mdbook backend for creating EPUB documents.[18]
    

### 往期推荐

*   • [免费 ChatGPT 网站导航](http://mp.weixin.qq.com/s?__biz=MzIyNDQ2MTQwOQ==&mid=2247493285&idx=1&sn=3676a14a17170ccb5162b84c52e09b9d&chksm=e80c31abdf7bb8bdae25a8546877f393075aa2c91a4544bc0540949c15f01f9aef04868ad576&scene=21#wechat_redirect)
    
*   • [AudioNote: 一种最简单的方式帮助您整理所有思绪](http://mp.weixin.qq.com/s?__biz=MzIyNDQ2MTQwOQ==&mid=2247493200&idx=2&sn=4cf4d6fe6fab4a65bbc3f3239ac539b6&chksm=e80c315edf7bb848de6ba289a6da34779bbbaf676aada0246ac97116c0757fd4ccc285d11558&scene=21#wechat_redirect)
    
*   • [初一数学题测试各大语言模型计算能力](http://mp.weixin.qq.com/s?__biz=MzIyNDQ2MTQwOQ==&mid=2247493184&idx=2&sn=5fbbecf28f803f5f8470af98bda03965&chksm=e80c314edf7bb858f6b42828101c349e3834390d338bac6c5ecf8942390044a1b6351b4ff28f&scene=21#wechat_redirect)
    
*   • [ChatGPT API 调用程序合集](http://mp.weixin.qq.com/s?__biz=MzIyNDQ2MTQwOQ==&mid=2247493104&idx=2&sn=b3da10726947f03cac30aec505687c81&chksm=e80c32fedf7bbbe8c6f01ea9aa240cc373d4e88673092034c9889dae65fbb414cae87c20a964&scene=21#wechat_redirect)
    
*   • [两个 Python 脚本，快速构建妹子图片网站](http://mp.weixin.qq.com/s?__biz=MzIyNDQ2MTQwOQ==&mid=2247492814&idx=1&sn=2a1090cdb0f5f73462d130504d1b9a84&chksm=e80c33c0df7bbad6b21818039f18ee399deda6681b3061f7cb9bba762606af4354b8f9bad8d3&scene=21#wechat_redirect)
    

欢迎关注我的公众号 “**码农真经**”，原创技术文章第一时间推送。

#### 引用链接

`[1]` TypeScript 教程 - 网道: _https://wangdoc.com/typescript/_  
`[2]` 介绍 - mdBook 中文文档: _https://llever.com/mdBook-zh/_  
`[3]` Markdown: _https://llever.com/mdBook-zh/format/markdown.zh.html_  
`[4]` search: _https://llever.com/mdBook-zh/guide/reading.zh.html#search_  
`[5]` syntax highlighting: _https://llever.com/mdBook-zh/format/theme/syntax-highlighting.zh.html_  
`[6]` Theme: _https://llever.com/mdBook-zh/format/theme/index.html_  
`[7]` Preprocessors: _https://llever.com/mdBook-zh/format/configuration/preprocessors.zh.html_  
`[8]` Backends: _https://llever.com/mdBook-zh/format/configuration/renderers.zh.html_  
`[9]` Rust: _https://www.rust-lang.org/_  
`[10]` Rust 代码: _https://llever.com/mdBook-zh/cli/test.zh.html_  
`[11]` wangdoc/typescript-tutorial: TypeScript 教程: _https://github.com/wangdoc/typescript-tutorial_  
`[12]` mdBook - mdBook Documentation: _https://crisal.io/tmp/book-example/book/index.html_  
`[13]` mdbook 写作真的好用 - 掘金: _https://juejin.cn/post/7201787862236823608_  
`[14]` HollowMan6/mdbook-pdf: A backend for mdBook written in Rust for generating PDF based on headless chrome and Chrome DevTools Protocol. (用 Rust 编写的 mdBook 后端，基于 headless chrome 和 Chrome 开发工具协议生成 PDF): _https://github.com/HollowMan6/mdbook-pdf_  
`[15]` mdbook-pdf-outline · PyPI: _https://pypi.org/project/mdbook-pdf-outline/_  
`[16]` mdbook-chapter-number — Rust application // Lib.rs: _https://lib.rs/crates/mdbook-chapter-number_  
`[17]` mdbook-pdf/README_CN.md at main · HollowMan6/mdbook-pdf: _https://github.com/HollowMan6/mdbook-pdf/blob/main/README_CN.md_  
`[18]` Michael-F-Bryan/mdbook-epub: An experimental mdbook backend for creating EPUB documents.: _https://github.com/Michael-F-Bryan/mdbook-epub_