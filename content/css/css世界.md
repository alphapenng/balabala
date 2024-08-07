<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2024-06-08 22:16:37
 * @LastEditors: alphapenng
 * @LastEditTime: 2024-07-21 18:54:01
 * @FilePath: /balabala/content/css/css世界.md
-->
# css 世界 notes

- [css 世界 notes](#css-世界-notes)
  - [css 世界的专业术语](#css-世界的专业术语)
  - [流、元素与基本尺寸](#流元素与基本尺寸)
    - [块级元素](#块级元素)
    - [width/height 作用的具体细节](#widthheight-作用的具体细节)
      - [深藏不露的 width:auto](#深藏不露的-widthauto)
      - [改变 width/height 作用细节的 box-sizing](#改变-widthheight-作用细节的-box-sizing)
      - [关于 height:100%](#关于-height100)
    - [CSS min-width/max-width和min-height/max-height二三事](#css-min-widthmax-width和min-heightmax-height二三事)
      - [为流体而生的 min-width/max-width](#为流体而生的-min-widthmax-width)
      - [与众不同的初始值](#与众不同的初始值)
      - [超越!important，超越最大](#超越important超越最大)
      - [任意高度元素的展开收起动画技术](#任意高度元素的展开收起动画技术)
    - [内联元素](#内联元素)
      - [哪些元素是内联元素](#哪些元素是内联元素)
      - [内联世界深入的基础—内联盒模型](#内联世界深入的基础内联盒模型)
      - [幽灵空白节点](#幽灵空白节点)
  - [盒尺寸四大家族](#盒尺寸四大家族)
    - [深入理解 content](#深入理解-content)
      - [content 与替换元素](#content-与替换元素)
      - [content 内容生成技术](#content-内容生成技术)
    - [温和的 padding 属性](#温和的-padding-属性)
      - [padding 与元素的尺寸](#padding-与元素的尺寸)
      - [padding 的百分比值](#padding-的百分比值)
      - [标签元素内置的 padding](#标签元素内置的-padding)
      - [padding 与图形绘制](#padding-与图形绘制)
    - [激进的 margin 属性](#激进的-margin-属性)
      - [margin 与元素尺寸以及相关布局](#margin-与元素尺寸以及相关布局)
      - [margin 的百分比值](#margin-的百分比值)
      - [正确看待 CSS 世界里的 margin 合并](#正确看待-css-世界里的-margin-合并)
      - [深入理解 CSS 中的 margin:auto](#深入理解-css-中的-marginauto)
      - [margin 无效情形解析](#margin-无效情形解析)
    - [功勋卓越的 border 属性](#功勋卓越的-border-属性)
      - [为什么 border-width 不支持百分比值](#为什么-border-width-不支持百分比值)
      - [了解各种 border-style 类型](#了解各种-border-style-类型)
      - [border-color 和 color](#border-color-和-color)
      - [border 与透明边框技巧](#border-与透明边框技巧)
      - [border 与图形构建](#border-与图形构建)
      - [border 等高布局技术](#border-等高布局技术)
  - [内联元素与流](#内联元素与流)
    - [字母 x——CSS 世界中隐匿的举足轻重的角色](#字母-xcss-世界中隐匿的举足轻重的角色)
      - [字母 x 与 CSS 世界的基线](#字母-x-与-css-世界的基线)
      - [字母 x 与 CSS 中的 x-height](#字母-x-与-css-中的-x-height)
      - [字母 x 与 CSS 中的 ex](#字母-x-与-css-中的-ex)
    - [内联元素的基石 line-height](#内联元素的基石-line-height)
      - [内联元素的高度之本—line-height](#内联元素的高度之本line-height)
      - [深入 line-height 的各类属性值](#深入-line-height-的各类属性值)
      - [内联元素 line-height 的“大值特性”](#内联元素-line-height-的大值特性)
    - [line-height 的好朋友 vertical-align](#line-height-的好朋友-vertical-align)
      - [vertical-align 家族基本认识](#vertical-align-家族基本认识)
      - [vertical-align 作用的前提](#vertical-align-作用的前提)
      - [vertical-align 和 line-height 之间的关系](#vertical-align-和-line-height-之间的关系)
      - [深入理解 vertical-align 线性类属性值](#深入理解-vertical-align-线性类属性值)
      - [深入理解 vertical-align 文本类属性值](#深入理解-vertical-align-文本类属性值)
      - [简单了解 vertical-align 上标下标类属性值](#简单了解-vertical-align-上标下标类属性值)
      - [无处不在的 vertical-align](#无处不在的-vertical-align)
      - [基于 vertical-align 属性的水平垂直居中弹框](#基于-vertical-align-属性的水平垂直居中弹框)
  - [流的破坏与保护](#流的破坏与保护)
    - [魔鬼属性 float](#魔鬼属性-float)
      - [float 的本质与特性](#float-的本质与特性)
      - [float 的作用机制](#float-的作用机制)
      - [float 更深入的作用机制](#float-更深入的作用机制)
      - [float 与流体布局](#float-与流体布局)
    - [float 的天然克星 clear](#float-的天然克星-clear)
      - [什么是 clear 属性](#什么是-clear-属性)
      - [成事不足败事有余的 clear](#成事不足败事有余的-clear)
    - [CSS 世界的结界——BFC](#css-世界的结界bfc)
      - [BFC 的定义](#bfc-的定义)
      - [BFC 与流体布局](#bfc-与流体布局)
    - [最佳结界 overflow](#最佳结界-overflow)
      - [overflow 剪裁界线 border box](#overflow-剪裁界线-border-box)
      - [了解 overflow-x 和 overflow-y](#了解-overflow-x-和-overflow-y)
      - [overflow 与滚动条](#overflow-与滚动条)
      - [依赖 overflow 的样式表现](#依赖-overflow-的样式表现)
      - [overflow 与锚点定位](#overflow-与锚点定位)
    - [float 的兄弟 position:absolute](#float-的兄弟-positionabsolute)
      - [absolute 的包含块](#absolute-的包含块)
      - [具有相对特性的无依赖 absolute 绝对定位](#具有相对特性的无依赖-absolute-绝对定位)
      - [absolute 与 text-align](#absolute-与-text-align)
    - [absolute 与 overflow](#absolute-与-overflow)
    - [absolute 与 clip](#absolute-与-clip)
      - [重新认识的 clip 属性](#重新认识的-clip-属性)
      - [深入了解 clip 的渲染](#深入了解-clip-的渲染)
    - [absolute 的流体特性](#absolute-的流体特性)
      - [absolute 流体特性](#absolute-流体特性)
      - [absolute 的 margin:auto 居中](#absolute-的-marginauto-居中)
    - [position:relative 才是大哥](#positionrelative-才是大哥)
      - [relative 对 absolute 的限制](#relative-对-absolute-的限制)
      - [relative 与定位](#relative-与定位)
      - [relative 的最小化影响原则](#relative-的最小化影响原则)
    - [强悍的 position:fixed 固定定位](#强悍的-positionfixed-固定定位)
      - [position:fixed 不一样的“包含块”](#positionfixed-不一样的包含块)
      - [position:fixed 的 absolute 模拟](#positionfixed-的-absolute-模拟)
  - [CSS 世界的的层叠规则](#css-世界的的层叠规则)
    - [z-index 只是 CSS 层叠规则中的一叶小舟](#z-index-只是-css-层叠规则中的一叶小舟)
    - [理解 CSS 世界的层叠上下文和层叠水平](#理解-css-世界的层叠上下文和层叠水平)
      - [什么是层叠上下文](#什么是层叠上下文)
      - [什么是层叠水平](#什么是层叠水平)
    - [理解元素的层叠顺序](#理解元素的层叠顺序)
    - [务必牢记的层叠准则](#务必牢记的层叠准则)
    - [深入了解层叠上下文](#深入了解层叠上下文)
      - [层叠上下文的特性](#层叠上下文的特性)
      - [层叠上下文的创建](#层叠上下文的创建)
      - [层叠上下文与层叠顺序](#层叠上下文与层叠顺序)
      - [z-index 负值深入理解](#z-index-负值深入理解)
    - [z-index“不犯二”准则](#z-index不犯二准则)
  - [强大的文本处理能力](#强大的文本处理能力)
    - [line-height 的另外一个朋友 font-size](#line-height-的另外一个朋友-font-size)
      - [font-size 和 vertical-align 的隐秘故事](#font-size-和-vertical-align-的隐秘故事)
      - [理解 font-size 与 ex、em 和 rem 的关系](#理解-font-size-与-exem-和-rem-的关系)
      - [理解 font-size 的关键字属性值](#理解-font-size-的关键字属性值)
      - [font-size:0 与文本的隐藏](#font-size0-与文本的隐藏)
    - [字体属性家族的大家长 font-family](#字体属性家族的大家长-font-family)
      - [了解衬线字体和无衬线字体](#了解衬线字体和无衬线字体)
      - [等宽字体的实践价值](#等宽字体的实践价值)
      - [中文字体和英文名称](#中文字体和英文名称)
      - [一些补充说明](#一些补充说明)
    - [字体家族其他成员](#字体家族其他成员)
      - [貌似粗犷、实则精细无比的 font-weight](#貌似粗犷实则精细无比的-font-weight)


## css 世界的专业术语

1. 长度单位

    长度单位又可以分为相对长度单位和绝对长度单位：

    （1）相对长度单位。相对长度单位又分为相对字体长度单位和相对视区长度单位。

    - 相对字体长度单位，如 `em` 和 `ex`，还有 CSS3 新世界的 `rem` 和 `ch` （字符 0 的宽度）。
    - 相对视区长度单位，如 `vh`、 `vw`、 `vmin`、`vmax`。

    （2）绝对长度单位：最常见的就是 `px`，还有 `pt`、 `cm`、 `mm`、 `pc` 等了解一下就可以，在我看来，他们实用性近乎零，至少我这么多年一次都没用过。

2. 选择器

    选择器是用来瞄准目标元素的东西，例如，上面的.vocabulary 就是一个选择器。

    - 类选择器：指以“.”这个点号开头的选择器。很多元素可以应用同一个类选择器。“类”，天生就是被公用的命。
    - ID 选择器：“#”打头，权重相当高。ID 一般指向唯一元素。但是，在 CSS 中，ID样式出现在多个不同的元素上并不会只渲染第一个，而是雨露均沾。但显然不推荐这么做。
    - 属性选择器：指含有[]的选择器，形如[title]{}、[title= "css-world"]{}、[title~="css-world"]{}、[title^= "css-world"]{}和[title$="css-world"]{}等。
        1. [title~=“css-world”]{}：此选择器用于选择title属性中含有css-world这个词的元素，该词必须是一个完整的单词，即被空格分隔的字符串。理解为：如果title属性的值是一个词的列表（比如由空格分隔的单词），那么匹配列表中存在的css-world这个单词。例如，`<div title="hello css-world now">`将被选中，但`<div title="css-worldnow">`则不会被选中，因为`css-worldnow` 与 `css-world` 不是一个完整的单词匹配。
        2. [title^=“css-world”]{}：此选择器用于选择title属性的值以css-world开头的元素。理解为：它是查找属性值以特定字符串“开始”的元素。例如，`<div title="css-world tutorial">`会被选中。
        3. [title$=“css-world”]{}：此选择器用于选择title属性的值以css-world结束的元素。理解为：它查找那些属性值以特定字符串“结束”的元素。例如，`<div title="welcome to css-world">`会被选中。

        总之：

        • ~=表示属性值必须包含一个完整的单词，该单词是你指定的值。
        • ^=表示属性值以你指定的字符串开始。
        • $=表示属性值以你指定的字符串结束。

    - 伪类选择器：一般指前面有个英文冒号（:）的选择器，如:first-child 或:last-child 等。

        伪类 `(:)`

        伪类用于定义元素的特殊状态，并给这些状态的元素添加样式。伪类基于元素的状态，比如它们是否被悬停、聚焦或被选中等，来应用样式。伪类选择器通过单冒号:表示。

        常见的伪类包括:

        • :hover：当用户鼠标悬停在元素上时，为该元素添加样式。
        • :active：当元素被用户激活（例如，通过点击）时，为该元素添加样式。
        • :focus：当元素获得焦点时（例如，通过点击或使用Tab键导航），为该元素添加样式。
        • :first-child：选择其父元素的第一个子元素。
        • :last-child：选择其父元素的最后一个子元素。
        • :not(selector)：选择不符合指定选择器模式的元素。

    - 伪元素选择器：就是有连续两个冒号的选择器，如::first-line::first-letter、::before 和::after。

        伪元素 `(::)`

        伪元素用于创建某些不在文档树中的元素，并给这些”虚构”的元素添加样式。使用伪元素，你可以影响元素的特定部分或以某种方式添加到元素中的内容，而无需更改HTML代码。伪元素选择器通过双冒号::表示（CSS2中是单冒号，但CSS3推荐使用双冒号来区分伪类和伪元素）。

        常见的伪元素包括:

        • ::before：在元素内容的前面插入新内容。
        • ::after：在元素内容的后面插入新内容。
        • ::first-letter：选择文本块的第一个字母进行样式设置。
        • ::first-line：选择文本块的第一行进行样式设置。
        • ::placeholder：选择输入字段占位符的样式设置。
        • ::selection：选择用户通过鼠标或键盘选择的文本部分的样式。

3. 关系选择器

    关系选择器是指根据与其他元素的关系选择元素的选择器，常见的符号有空格、>、~，还有+等，这些都是非常常用的选择器。

    - 后代选择器：选择所有合乎规则的后代元素。**空格连接。**
    - 相邻后代选择器：仅仅选择合乎规则的儿子元素，孙子、重孙元素忽略，因此又称“子选择器”。**>连接。** 适用于 IE7 以上版本。
    - 兄弟选择器：选择当前元素后面的所有合乎规则的兄弟元素。**~连接。** 适用于 IE7 以上版本。
    - 相邻兄弟选择器：仅仅选择当前元素相邻的那个合乎规则的兄弟元素。**+连接。** 适用于IE7 以上版本。

## 流、元素与基本尺寸

### 块级元素

“块级元素”对应的英文是 block-level element，常见的块级元素有`<div>`、`<li>`和`<table>`等。需要注意是，“块级元素”和“display 为 block 的元素”不是一个概念。例如，`<li>`元素默认的 display 值是 list-item，`<table>`元素默认的 display 值是 table，但是它们均是“块级元素”，因为**它们都符合块级元素的基本特征，也就是一个水平流上只能单独显示一个元素**，多个块级元素则换行显示。

**正是由于“块级元素”具有换行特性，因此理论上它都可以配合 clear 属性来清除浮动带来的影响。**

按照 display 的属性值不同，值为 block 的元素的盒子实际由外在的“块级盒子”和内在的“块级容器盒子”组成，值为 inline-block 的元素则由外在的“内联盒子”和内在的“块级容器盒子”组成，值为 inline 的元素则内外均是“内联盒子”。

现在，大家应该明白为何display属性值是inline-block的元素既能和图文一行显示，又能直接设置 width/height 了吧！因为有两个盒子，外面的盒子是 inline 级别，里面的盒子是 block 级别。

💁 **width/height 作用在哪个盒子上?**

这个问题也是很简单的，因为在解释内外盒子的时候就已经提到过了：是内在盒子，也就是“容器盒子”。

### width/height 作用的具体细节

#### 深藏不露的 width:auto

我们应该都知道，width 的默认值是 auto。auto 因为是默认值，所以出镜率不高，但是，它却是个深藏不露的家伙，它至少包含了以下 4 种不同的宽度表现。

（1）**充分利用可用空间。** 比方说，`<div>`、`<p>` 这些元素的宽度默认是 100%于父级容器的。这种充分利用可用空间的行为还有个专有名字，叫作 fill-available。
（2）**收缩与包裹。** 典型代表就是浮动、绝对定位、inline-block 元素或 table 元素，英文称为 shrink-to-fit，直译为“收缩到合适”，有那么点儿意思，但不够形象，我一直把这种现象称为“包裹性”。**CSS3 中的 fit-content 指的就是这种宽度表现。**
（3）**收缩到最小。** 这个最容易出现在 table-layout 为 auto 的表格中，这种行为在规范中被描述为“preferred minimum width”或者“minimum content width”。后来还有了一个更加好听的名字 min-content。
（4）**超出容器限制。** 除非有明确的 width 相关设置，否则上面 3 种情况尺寸都不会主动超过父级容器宽度的，但是存在一些特殊情况。例如，内容很长的连续的英文和数字，或者内联元素被设置了 `white-space:nowrap`，则表现为“恰似一江春水向东流，流到断崖也不回头”。

在 CSS 世界中，盒子分“内在盒子”和“外在盒子”，显示也分“内部显示”和“外部显示”，同样地，尺寸也分“内部尺寸”和“外部尺寸”。其中“内部尺寸”英文写作“Intrinsic Sizing”，**表示尺寸由内部元素决定**；还有一类叫作“外部尺寸”，英文写作“Extrinsic Sizing”，**宽度由外部元素决定**。现在，考考大家：上面 4 种尺寸表现，哪个是“外部尺寸”？哪个是“内部尺寸”？

就第一个，也就是`<div>`默认宽度100%显示，是“外部尺寸”，其余全部是“内部尺寸”。而这唯一的“外部尺寸”，是“流”的精髓所在。

1．外部尺寸与流体特性
（1）正常流宽度。当我们在一个容器里倒入足量的水时，水一定会均匀铺满整个容器，在页面中随便扔一个`<div>`元素，其尺寸表现就会和这水流一样铺满容器。
**我很多年前总结过一套“鑫三无准则”，即“无宽度，无图片，无浮动”。为何要“无宽度”？原因很简单，表现为“外部尺寸”的块级元素一旦设置了宽度，流动性就丢失了。**
（2）格式化宽度。格式化宽度仅出现在“绝对定位模型”中，也就是出现在 position 属性值为 absolute 或 fixed 的元素中。在默认情况下，绝对定位元素的宽度表现是“包裹性”，宽度由内部尺寸决定，但是，有一种情况其宽度是由外部尺寸决定的，是什么情况呢？
对于非替换元素，当 left/top 或 top/bottom 对立方位的属性值同时存在的时候，元素的宽度表现为“格式化宽度”，其宽度大小相对于最近的具有定位特性（position 属性值不是 static）的祖先元素计算。
2．内部尺寸与流体特性
如何快速判断一个元素使用的是否为“内部尺寸”呢？很简单，假如这个元素里面没有内容，宽度就是 0，那就是应用的“内部尺寸”。

据我所知，在 CSS 世界中，“内部尺寸”有下面 3 种表现形式。
（1）包裹性。
“包裹性”是我自己对“shrink-to-fit”理解后的一种称谓，我个人觉得非常形象好记，一直用了很多年。“包裹性”也是 CSS 世界中很重要的流布局表现形式。
所谓“自适应性”，指的是元素尺寸由内部元素决定，但永远小于“包含块”容器的尺寸（除非容器尺寸小于元素的“首选最小宽度”）。换句话说就是，“包裹性”元素冥冥中有个 max-width:100%罩着的感觉（注意，此说法只是便于大家理解，实际上是有明显区别的）。
**按钮就是 CSS 世界中极具代表性的 inline-block 元素，可谓展示“包裹性”最好的例子，具体表现为：按钮文字越多宽度越宽（内部尺寸特性），但如果文字足够多，则会在容器的宽度处自动换行（自适应特性）。**
**除了 inline-block 元素，浮动元素以及绝对定位元素都具有包裹性，均有类似的智能宽度行为。**
（2）首选最小宽度。
所谓“首选最小宽度”，指的是元素最适合的最小宽度。
（3）最大宽度。
最大宽度就是元素可以有的最大宽度。我自己是这么理解的，“最大宽度”实际等同于“包裹性”元素设置 white-space:nowrap 声明后的宽度。如果内部没有块级元素或者块级元素没有设定宽度值，则“最大宽度”实际上是最大的连续内联盒子的宽度。

#### 改变 width/height 作用细节的 box-sizing

1．box-sizing 的作用
2. 为何 box-sizing 不支持 margin-box
3. 如何评价 `*{box-sizing:border-box}`
    （1）这种做法易产生没必要的消耗。
    （2）这种做法并不能解决所有问题。
4. `box-sizing` 发明的初衷
    根据我这么多年的开发经验，在 CSS 世界中，唯一离不开 box-sizing:border-box 的就是原生普通文本框`<input>`和文本域`<textarea>`的 100%自适应父容器宽度。
    拿文本域`<textarea>`举例，`<textarea>`为替换元素，替换元素的特性之一就是尺寸由内部元素决定，且无论其 display 属性值是 inline 还是 block。这个特性很有意思，对于非替换元素，如果其 display 属性值为 block，则会具有流动性，宽度由外部尺寸决定，但是替换元素的宽度却不受 display 水平影响，因此，我们通过 CSS 修改`<textarea>`的display 水平是无法让尺寸 100%自适应父容器的。
    在我看来，box-sizing 被发明出来最大的初衷应该是解决替换元素宽度自适应问题。如果真的如我所言，那*{box-sizing:border-box}是不是没用在点儿上呢？是不是应该像下面这样 CSS 重置才更合理呢？
    ```css
    input, textarea, img, video, object { 
        box-sizing: border-box; 
    }
    ```

#### 关于 height:100%

height 和 width 还有一个比较明显的区别就是对百分比单位的支持。对于 width 属性，就算父元素 width 为 auto，其百分比值也是支持的；但是，对于 height 属性，如果父元素height 为 auto，只要子元素在文档流中，其百分比值完全就被忽略了。

**只要经过一定的实践，我们都会发现对于普通文档流中的元素，百分比高度值要想起作用，其父级必须有一个可以生效的高度值！**但是，怕是很少有人思考过这样一个问题：为何父级没有具体高度值的时候，height:100%会无效？
1．为何 height:100%无效
    那问题又来了：为何宽度支持，高度就不支持呢？规范中其实给出了答案。如果包含块的高度没有显式指定（即高度由内容决定），并且该元素不是绝对定位，则计算值为auto。一句话总结就是：因为解释成了 auto。
    **但是，宽度的解释却是：如果包含块的宽度取决于该元素的宽度，那么产生的布局在 CSS 2.1中是未定义的**

2．如何让元素支持 height:100%效果
（1）设定显式的高度值。这个没什么好说的，例如，设置 height:600px，或者可以生效的百分比值高度。例如，我们比较常见的：

```css
html, body { 
 height: 100%; 
}
```

（2）使用绝对定位。例如：

```css
div { 
 height: 100%; 
 position: absolute; 
}
```

此时的 height:100%就会有计算值，即使祖先元素的 height 计算为 auto 也是如此。需要注意的是，绝对定位元素的百分比计算和非绝对定位元素的百分比计算是有区别的，区别在于绝对定位的宽高百分比计算是相对于 padding box 的，也就是说会把 padding 大小值计算在内，但是，非绝对定位元素则是相对于 content box 计算的。

### CSS min-width/max-width和min-height/max-height二三事

#### 为流体而生的 min-width/max-width

一种特定区间内的自适应布局方案就诞生了，网页宽度在 1200～1400 像素自适应，既满足大屏的大气，又满足笔记本的良好显示，此时，min-width/max-width 就可以大显神威了:

```css
.container { 
 min-width: 1200px; 
 max-width: 1400px; 
}
```

在公众号的热门文章中，经常会有图片，这些图片都是用户上传产生的，因此尺寸会有大有小，为了避免图片在移动端展示过大影响体验，常常会有下面的 max-width 限制：

```css
img { 
 max-width: 100%; 
 height: auto!important; 
}
```

#### 与众不同的初始值

width/height 的默认值是 auto，而 `min-width/max-width` 和 `min-heigh/ max-height` 的初始值则要复杂些。这里要分为两部分，分别是 max-*系列和 min-*系列。**max-width 和 max-height 的初始值是 none**，min-width 和 min-height 的初始值……
虽然 MDN 和 W3C 维基的文档上都显示 min-width/min-height 的初始值是 0，但是，根据我的分析和测试，**所有浏览器中的 min-width/min-height 的初始值都是 auto。**

#### 超越!important，超越最大

1．超越!important

大家应该都知道 CSS 世界中的!important 的权重相当高，在业界，往往会把!important 的权重比成“泰坦尼克”，比直接在元素的 style 属性中设置 CSS 声明还要高，一般用在 CSS 覆盖 JavaScript 设置上。但是，就是这么厉害的!important，直接被 max-width 一个浪头就拍沉了。**style、!important 通通靠边站！因为 max-width 会覆盖 width。**

2．超越最大

超越最大指的是min-width覆盖max-width，此规则发生在min-width和max-width冲突的时候。

#### 任意高度元素的展开收起动画技术

CSS 代码如下：

```css
.element { 
 max-height: 0; 
 overflow: hidden; 
 transition: max-height .25s; 
} 
.element.active { 
 max-height: 666px; /* 一个足够大的最大高度值 */ 
}
```

其中展开后的 max-height 值，我们只需要设定为保证比展开内容高度大的值就可以，因为 max-height 值比 height 计算值大的时候，元素的高度就是 height 属性的计算高度，在本交互中，也就是 height:auto 时候的高度值。于是，一个高度不定的任意元素的展开动画效果就实现了。

### 内联元素

#### 哪些元素是内联元素

1．从定义看
首先要明白这一点：“内联元素”的“内联”特指“外在盒子”，和“display 为 inline 的元素”不是一个概念！inline-block 和 inline-table 都是“内联元素”，因为它们的“外在盒子”都是内联盒子。自然 display:inline 的元素也是“内联元素”，那么，`<button>` 按钮元素是内联元素，因为其 display 默认值是 inline-block；`<img>`图片元素也是内联元素，因为其 display 默认值是 inline 等。
2．从表现看
就行为表现来看，“内联元素”的典型特征就是可以和文字在一行显示。因此，文字是内联元素，图片是内联元素，按钮是内联元素，输入框、下拉框等原生表单控件也是内联元素。
下面有一个疑问：浮动元素貌似也是可以和文字在一个水平上显示的，是不是浮动元素也是内联级别的呢？不是的。实际上，浮动元素和后面的文字并不在一行显示，浮动元素已经在文档流之外了。证据就是，当后面文字足够多的时候，文字并不是在浮动元素的下面，而是继续在后面。这就说明，浮动元素和后面文字不在一行，只是它们恰好站在了一起而已。真相是，**浮动元素会生成“块盒子”**，这就是后话了。

#### 内联世界深入的基础—内联盒模型

下面是一段很普通的 HTML：
`<p>这是一行普通的文字，这里有个 <em>em</em> 标签。</p>`

（1）内容区域（content area）。内容区域指一种围绕文字看不见的盒子，其大小仅受字符本身特性控制，本质上是一个字符盒子（character box）；但是有些元素，如图片这样的替换元素，其内容显然不是文字，不存在字符盒子之类的，因此，对于这些元素，内容区域可以看成元素自身。
（2）内联盒子（inline box）。“内联盒子”不会让内容成块显示，而是排成一行，**这里的“内联盒子”实际指的就是元素的“外在盒子”**，用来决定元素是内联还是块级。该盒子又可以细分为“内联盒子”和“匿名内联盒子”两类：
（3）行框盒子（line box）。例如：
`<p>` `这是一行普通的文字，这里有个 <em>em</em> 标签。` `</p>`
每一行就是一个“行框盒子”（实线框标注），每个“行框盒子”又是由一个一个“内联盒子”组成的。
（4）包含盒子（containing box）。例如：
`<p>这是一行普通的文字，这里有个 <em>em</em> 标签。</p>`

#### 幽灵空白节点

规范中实际上对这个“幽灵空白节点”是有提及的，“幽灵空白节点”实际上也是一个盒子，不过是个假想盒，名叫“strut”，中文直译为“支柱”，是一个存在于每个“行框盒子”前面，同时具有该元素的字体和行高属性的 0 宽度的内联盒。

## 盒尺寸四大家族

### 深入理解 content

#### content 与替换元素

1．什么是替换元素
这种通过修改某个属性值呈现的内容就可以被替换的元素就称为“替换元素”。因此，`<img>`、`<object>`、`<video>`、`<iframe>` 或者表单元素 `<textarea>` 和 `<input>` 都是典型的替换元素。
替换元素除了内容可替换这一特性以外，还有以下一些特性。
（1）内容的外观不受页面上的 CSS 的影响。
（2）有自己的尺寸。
在 Web 中，很多替换元素在没有明确尺寸设定的情况下，其默认的尺寸（不包括边框）是 300 像素×150 像素，如`<video>`、`<iframe>`或者`<canvas>`等，也有少部分替换元素为 0 像素，如`<img>`图片，而表单元素的替换元素的尺寸则和浏览器有关，没有明显的规律。
（3）在很多 CSS 属性上有自己的一套表现规则。比较具有代表性的就是 vertical-align属性，对于替换元素和非替换元素，vertical-align 属性值的解释是不一样的。

2．替换元素的默认 display 值
所有的替换元素都是内联水平元素，也就是替换元素和替换元素、替换元素和文字都是可以在一行显示的。但是，替换元素默认的 display 值却是不一样的。

![各个替换元素的默认display属性值](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240703082829_QgFHnf.png)

3．替换元素的尺寸计算规则
我个人将替换元素的尺寸从内而外分为 3 类：固有尺寸、HTML 尺寸和 CSS 尺寸。
（1）固有尺寸指的是替换内容原本的尺寸。
（2）HTML 尺寸这个概念略微抽象，我们不妨将其想象成水煮蛋里面的那一层白色的膜，里面是“固有尺寸”这个蛋黄蛋白，外面是“CSS 尺寸”这个蛋壳。
（3）CSS 尺寸特指可以通过 CSS 的 width 和 height 或者 max-width/min-width 和 max-height/min-height 设置的尺寸，对应盒尺寸中的 content box。

- 如果没有 CSS 尺寸和 HTML 尺寸，则使用固有尺寸作为最终的宽高。
- 如果没有 CSS 尺寸，则使用 HTML 尺寸作为最终的宽高。
- 如果有 CSS 尺寸，则最终尺寸由 CSS 属性决定。
- 如果“固有尺寸”含有固有的宽高比例，同时仅设置了宽度或仅设置了高度，则元素依然按照固有的宽高比例显示。
- 如果上面的条件都不符合，则最终宽度表现为 300 像素，高度为 150 像素，宽高比 2:1。
- 内联替换元素和块级替换元素使用上面同一套尺寸计算规则。

**CSS 世界中的替换元素的固有尺寸有一个很重要的特性，那就是“我们是无法改变这个替换元素内容的固有尺寸的”。**

4．替换元素和非替换元素的距离有多远

观点 1：替换元素和非替换元素之间只隔了一个 src 属性！
观点 2：替换元素和非替换元素之间只隔了一个 CSS content 属性！

5．content 与替换元素关系剖析

实际上，在
CSS 世界中，我们把 content 属性生成的对象称为“匿名替换元素”（anonymous replaced element）。看到没，直接就“替换元素”叫起来了，可见，它们之间的联系并不是微妙，而是赤裸裸。

也正是这个原因，content 属性生成的内容和普通元素内容才会有很多不同的特性表现。我这里举几个简单的例子。

（1）我们使用 content 生成的文本是无法选中、无法复制的，好像设置了 userselect:none 声明一般，但是普通元素的文本却可以被轻松选中。同时，content 生成的文本无法被屏幕阅读设备读取，也无法被搜索引擎抓取，因此，千万不要自以为是地把重要的文本信息使用content 属性生成，因为这对可访问性和 SEO 都很不友好，content 属性只能用来生成一些无关紧要的内容，如装饰性图形或者序号之类；同样，也不要担心原本重要的文字信息会被 content 替换，替换的仅仅是视觉层。
（2）不能左右:empty 伪类。:empty 是一个 CSS 选择器，当元素里面无内容的时候进行匹配。
（3）content 动态生成值无法获取。content 是一个非常强大的 CSS 属性，其中一个强大之处就是计数器效果，可以自动累加数值，我们是无法获得此时 content 对应的具体数值是多少的，一点儿办法都没有。

#### content 内容生成技术

1．content 辅助元素生成
其中，最常见的应用之一就是清除浮动带来的影响：

```css
.clear:after { 
 content: ''; 
 display: table; /* 也可以是'block' */ 
 clear: both; 
}
```

另外一个很具有代表性的应用就是辅助实现“两端对齐”以及“垂直居中/上边缘/下边缘对齐”效果。

2．content 字符内容生成
content 字符内容生成就是直接写入字符内容，中英文都可以，比较常见的应用就是配合@font-face 规则实现图标字体效果。

3．content 图片生成

4．了解 content 开启闭合符号生成

5．content attr 属性值内容生成
此功能比较常用，我个人用得就比较多，比方说前面一节替换元素那里利用 alt 属性显示图片描述信息的例子：

```css
img::after { 
 /* 生成 alt 信息 */ 
 content: attr(alt); 
 /* 其他 CSS 略 */ 
}
```

6．深入理解 content 计数器
CSS 计数就跟我们军训报数一样。其中有这么几个关键点。
（1）班级命名：有个称呼，如生信 4 班，就知道谁是谁了。
（2）报数规则：1、2、3、4 递增报数，还是 1、2、1、2 报数，让班级的人知道。
（3）开始报数：不发口令，大眼瞪小眼，会乱了秩序。

巧的是，以上 3 个关键点正好对应 CSS 计数器的两个属性（counter-reset 和 counter-increment）和一个方法（counter()/counters()），下面依次讲解。

（1）属性 counter-reset

```css
/* 计数器名称是'wangxiaoer', 并且默认起始值是 2 */ 
.xxx { counter-reset: wangxiaoer 2; }
```

（2）属性 counter-increment。顾名思义，就是“计数器递增”的意思。值为 counter-reset 的 1 个或多个关键字，后面可以跟随数字，表示每次计数的变化值。如果省略，则使用默认变化值 1。

CSS 的计数器的计数是有一套规则的，我将之形象地称为“普照规则”。具体来讲就是：普照源（counter-reset）唯一，每普照（counter-increment）一次，普照源增加一次计数值。

```css
.counter { 
 counter-reset: wangxiaoer 2; 
 counter-increment: wangxiaoer; 
} 
.counter:before { 
 content: counter(wangxiaoer); 
} 
<p class="counter"></p>
```

```css
.counter { 
 counter-reset: wangxiaoer 2; 
} 
.counter:before { 
 content: counter(wangxiaoer); 
 counter-increment: wangxiaoer; 
}
```

（3）方法 counter()/counters()。这是方法，不是属性。类似 CSS3 中的 calc()计算。这里的作用很单纯，即显示计数，不过名称、用法有多个。

```css
/* name 就是 counter-reset 的名称 */ 
counter(name)
```

![counter的style](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240703161533_NLAAZ0.png)

7．content 内容生成的混合特性

### 温和的 padding 属性

#### padding 与元素的尺寸

内联元素的 padding 在垂直方向同样会影响布局，影响视觉表现。只是因为内联元素没有可视宽度和可视高度的说法（clientHeight 和 clientWidth 永远是0），垂直方向的行为表现完全受 line-height 和 vertical-align 的影响，视觉上并没有改变和上一行下一行内容的间距，因此，给我们的感觉就会是垂直 padding 没有起作用。

#### padding 的百分比值

**padding 百分比值无论是水平方向还是垂直方向均是相对于宽度计算的！**

#### 标签元素内置的 padding

（1）ol/ul 列表内置 padding-left，但是单位是 px 不是 em。例如，Chrome 浏览器下是 40px，由于使用的是 px 这个绝对单位，因此，如果列表中的 font-size 大小很小，则`<li>`元素的项目符号（如点或数字）就会`<ul>/<ol>`元素的左边缘距离很开，如果font-size 比较大，则项目符号可能跑到`<ul>/<ol>`元素的外面，类似图 4-43 所示的情况。
根据我自己的经验，当 font-size 是 12px 至 14px 时，22px 是比较好的一个 padding-left 设定值，所有浏览器都能正常显示，且非常贴近边缘。

```css
ol, ul { 
 padding-left: 22px; 
}
```

（2）很多表单元素都内置 padding，例如：

- 所有浏览器`<input>/<textarea>`输入框内置 padding；
- 所有浏览器`<button>`按钮内置 padding；
- 部分浏览器`<select>`下拉内置 padding，如 Firefox、IE8 及以上版本浏览器可以设置 padding；
- 所有浏览器`<radio>/<chexkbox>`单复选框无内置 padding；
- `<button>`按钮元素的 padding 最难控制！

```css
<button id="btn"></button> 
<label for="btn">按钮</label> 
button { 
 position: absolute; 
 clip: rect(0 0 0 0); 
} 
label { 
 display: inline-block; 
 line-height: 20px; 
 padding: 10px; 
} 
```

`<label>`元素的 for 属性值和`<button>`元素的 id 值对应即可。此时，所有浏览器下的按钮高度都是 40 像素，而且`<button>`元素的行为也都保留了，是非常不错的实践技巧。

#### padding 与图形绘制

### 激进的 margin 属性

#### margin 与元素尺寸以及相关布局

1．元素尺寸的相关概念

- 元素尺寸：对应 jQuery 中的$().width()和$().height()方法，包括 padding和 border，也就是元素的 border box 的尺寸。在原生的 DOM API 中写作 offsetWidth 和 offsetHeight，所以，有时候也成为“元素偏移尺寸”。
- 元素内部尺寸：对应 jQuery 中的$().innerWidth()和$().innerHeight()方法，表示元素的内部区域尺寸，包括 padding 但不包括 border，也就是元素的 padding box 的尺寸。在原生的 DOM API 中写作 clientWidth 和 clientHeight，所以，有时候也称为“元素可视尺寸”。
- 元素外部尺寸：对应 jQuery 中的$().outerWidth(true)和$().outerHeight(true)方法，表示元素的外部尺寸，不仅包括 padding 和 border，还包括 margin，也就是元素的 margin box 的尺寸。没有相对应的原生的 DOM API。

2．margin 与元素的内部尺寸

3．margin 与元素的外部尺寸

#### margin 的百分比值

#### 正确看待 CSS 世界里的 margin 合并

1．什么是 margin 合并

块级元素的上外边距（margin-top）与下外边距（margin-bottom）有时会合并为单个外边距，这样的现象称为“margin 合并”。从此定义上，我们可以捕获两点重要的信息。
（1）块级元素，但不包括浮动和绝对定位元素，尽管浮动和绝对定位可以让元素块状化。
（2）只发生在垂直方向，需要注意的是，这种说法在不考虑 writing-mode 的情况下才是正确的，严格来讲，应该是只发生在和当前文档流方向的相垂直的方向上。由于默认文档流是水平流，因此发生 margin 合并的就是垂直方向。

2.margin 合并的 3 种场景

（1）相邻兄弟元素 margin 合并。这是 margin 合并中最常见、最基本的。
（2）父级和第一个/最后一个子元素。

那该如何阻止这里 margin 合并的发生呢？
对于 margin-top 合并，可以进行如下操作（满足一个条件即可）：

- 父元素设置为块状格式化上下文元素；
- 父元素设置 border-top 值；
- 父元素设置 padding-top 值；
- 父元素和第一个子元素之间添加内联元素进行分隔。
对于 margin-bottom 合并，可以进行如下操作（满足一个条件即可）：

- 父元素设置为块状格式化上下文元素；
- 父元素设置 border-bottom 值；
- 父元素设置 padding-bottom 值；
- 父元素和最后一个子元素之间添加内联元素进行分隔；
- 父元素设置 height、min-height 或 max-height。

（3）空块级元素的 margin 合并。

如果有人不希望空`<div>`元素有 margin 合并，可以进行如下操作：

- 设置垂直方向的 border；
- 设置垂直方向的 padding；
- 里面添加内联元素（直接 Space 键空格是没用的）；
- 设置 height 或者 min-height。

3．margin 合并的计算规则

**我把 margin 合并的计算规则总结为“正正取大值”“正负值相加”“负负最负值”3 句话。**

4．margin 合并的意义

#### 深入理解 CSS 中的 margin:auto

margin:auto 的填充规则如下。
（1）如果一侧定值，一侧 auto，则 auto 为剩余空间大小。
（2）如果两侧均是 auto，则平分剩余空间。

**所以，如果想让某个块状元素右对齐，脑子里不要就一个 float:right，很多时候，margin-left:auto 才是最佳的实践，浮动毕竟是个“小魔鬼”。**

**由于绝对定位元素的格式化高度即使父元素 height:auto 也是支持的，因此，其应用场景可以相当广泛，绝对定位下的 margin:auto 居中是我用得最频繁的块级元素垂直居中对齐方式，**

#### margin 无效情形解析

（1）display 计算值 inline 的非替换元素的垂直 margin 是无效的，虽然规范提到有渲染，但浏览器表现却未寻得一点踪迹，这和 padding 是有明显区别的。对于内联替换元素，垂直 margin 有效，并且没有 margin 合并的问题，所以图片永远不会发生 margin 合并。
（2）表格中的`<tr>`和`<td>`元素或者设置 display 计算值是 table-cell 或 table-row 的元素的 margin 都是无效的。但是，如果计算值是 table-caption、table 或者 inline-table 则没有此问题，可以通过 margin 控制外间距，甚至::first-letter 伪元素也可以解析 margin。
（3）margin 合并的时候，更改 margin 值可能是没有效果的。以父子 margin 重叠为例，假设父元素设置有 margin-top:50px，则此时子元素设置 margin-top:30px 就没有任何效果表现，除非大小比 50px 大，或者是负值。
（4）绝对定位元素非定位方位的 margin 值“无效”。什么意思呢？很多时候，我们对元素进行绝对定位的时候，只会设置 1～2 个相邻方位。此时，这两个方向设置 margin 值我们在页面上是看不到定位变化的。

（5）定高容器的子元素的 margin-bottom 或者宽度定死的子元素的 margin-right 的定位“失效”。

（6）鞭长莫及导致的 margin 无效。

（7）内联特性导致的 margin 无效。

### 功勋卓越的 border 属性

#### 为什么 border-width 不支持百分比值

**其实还有很多 CSS 属性，如 outline、box-shadow、text-shadow 等，都是不支持百分比值的，原因也与此类似。**

border-width 还支持若干关键字，包括 thin、medium（默认值）和 thick，对应的尺寸大小具体如下。

- thin：薄薄的，等同于 1px。
- medium（默认值）：薄厚均匀，等同于 3px。
- hick：厚厚的，等同于 4px。

#### 了解各种 border-style 类型

1．border-style:none
2．border-style:solid
3．border-style:dashed
4．border-style:dotted
5．border-style:double

#### border-color 和 color

#### border 与透明边框技巧

1．右下方 background 定位的技巧
2．优雅地增加点击区域大小
3．三角等图形绘制

#### border 与图形构建

#### border 等高布局技术

## 内联元素与流

### 字母 x——CSS 世界中隐匿的举足轻重的角色

#### 字母 x 与 CSS 世界的基线

**字母 x 的下边缘（线）就是我们的基线。**

#### 字母 x 与 CSS 中的 x-height

**通俗地讲，x-height 指的就是小写字母 x 的高度，术语描述就是基线和等分线（mean line）（也称作中线，midline）之间的距离。**

- ascender height: 上下线高度。
- cap height: 大写字母高度。
- median: 中线。
- descender height: 下行线高度。

CSS 中有些属性值的定义就和这个 x-height 有关，最典型的代表就是 vertical-align:middle。这里的 middle 是中间的意思。注意，跟上面的 median（中线）不是一个意思。在 CSS 世界中，middle 指的是基线往上 1/2 x-height 高度。我们可以近似理解为字母 x 交叉点那个位置。

#### 字母 x 与 CSS 中的 ex

ex 是 CSS 中的一个相对单位，指的是小写字母 x 的高度，没错，就是指 x-height。

### 内联元素的基石 line-height

#### 内联元素的高度之本—line-height

对于非替换元素的纯内联元素，其可视高度完全由 line-height 决定。注意这里的措辞—“完全”，什么 padding、border 属性对可视高度是没有任何影响的，这也是我们平常口中的“盒模型”约定俗成说的是块级元素的原因。

内联元素的高度由固定高度和不固定高度组成，这个不固定的部分就是这里的“行距”。换句话说，line-height 之所以起作用，就是通过改变“行距”来实现的。

关于替换元素的高度与 line-height 的关系首先需要弄明白这个问题：line-height 可以影响替换元素（如图片的高度）吗？答案是，不可以！

不是 line-height 把图片占据高度变高了，而是把“幽灵空白节点”的高度变高了。图片为内联元素，会构成一个“行框盒子”，而在 HTML5 文档模式下，每一个“行框盒子”的前面都有一个宽度为 0 的“幽灵空白节点”，其内联特性表现和普通字符一模一样，所以，这里的容器高度会等于 line-height 设置的属性值 256px。

**实际开发的时候，图文和文字混在一起是很常见的，那这种内联替换元素和内联非替换元素在一起时的高度表现又是怎样的呢？
由于同属内联元素，因此，会共同形成一个“行框盒子”，line-height 在这个混合元素的“行框盒子”中扮演的角色是决定这个行盒的最小高度，听上去似乎有点儿尴尬，对于纯文本元素，line-height 非常威风，直接决定了最终的高度。但是，如果同时有替换元素，则 line-height 的表现一下子弱了很多，只能决定最小高度，对最终的高度表现有望尘莫及之感。为什么会这样呢？一是替换元素的高度不受 line-height 影响，二是 vertical-align 属性在背后作祟。**

对于块级元素，line-height 对其本身是没有任何作用的，我们平时改变 line-height，块级元素的高度跟着变化实际上是通过改变块级元素里面内联级别元素占据的高度实现的。

比方说，一个`<p>`元素中有 10 行图文内容，则这个`<p>`元素的高度就是由这 10 行内容产生的 10 个“行框盒子”高度累加而成；一个`<article>`元素中可能会有 20 个`<p>`元素，则这个`<article>`元素又是由这 20 个块级`<p>`元素高度累加而成，同时块级元素还可以通过 height 和 min-height 以及盒模型中的 margin、padding 和 border 等属性改变占据的高度，所有这一切就构成了 CSS 世界完整的高度体系。

#### 深入 line-height 的各类属性值

line-height 的默认值是 normal，还支持数值、百分比值以及长度值。

- 数值，如 line-height:1.5，其最终的计算值是和当前 font-size 相乘后的值。例如，假设我们此时的 font-size 大小为 14px，则 line-height 计算值是 1.5*14px=21px。
- 百分比值，如 line-height:150%，其最终的计算值是和当前 font-size 相乘后的值。例如，假设我们此时的 font-size 大小为 14px，则 line-height 计算值是 150%*14px=21px。
- 长度值，也就是带单位的值，如 line-height:21px 或者 line-height:1.5em等，此处 em 是一个相对于 font-size 的相对单位，因此，line-height:1.5em 最终的计算值也是和当前font-size相乘后的值。例如，假设我们此时的font-size大小为 14px，则line-height 计算值是 1.5*14px=21px。

乍一看，似乎 line-height:1.5、line-height:150%和 line-height:1.5em 这 3 种用法是一模一样的，最终的行高大小都是和font-size计算值，但是，实际上，line-height:1.5 和另外两个有一点儿不同，那就是继承细节有所差别。如果使用数值作为 line-height 的属性值，那么所有的子元素继承的都是这个值；但是，如果使用百分比值或者长度值作为属性值，那么所有的子元素继承的是最终的计算值。

💁 line-height 应该重置为多大的值呢？是使用数值、百分比值还是长度值呢？
下面是我的答案：如果我们做的是一个重图文内容展示的网页或者网站，如博客、论坛、公众号之类的，那一定要使用数值作为单位，考虑到文章阅读的舒适度，line-height 值可以设置在 `1.6～1.8`。如果是一个偏重布局结构精致的网站，则在我看来使用长度值或者数值都是可以的，因为，第一，我们的目的是为了兼容；第二，无论使用哪种类型值，都存在需要局部重置的场景。不过，根据我的统计，基本上各大站点都是使用数值作为全局的 line-height 值。不过，这并不表示使用数值就一定是最好的，如果网站内容的样式不是动态不可控的，有时候，固定的长度值反而更利于精确布局。因此，不要盲目跟风。那具体设置的值应该是多大呢？
如果使用的是长度值，我建议直接 `line-height:20px`，排版时候计算很方便。

#### 内联元素 line-height 的“大值特性”

![line-height的大值特性1](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240709090943_1gv8z4.png)

![line-height的大值特性2](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240709091222_yZUif5.png)

### line-height 的好朋友 vertical-align

#### vertical-align 家族基本认识

抛开 inherit 这类全局属性值不谈，我把 vertical-align 属性值分为以下 4 类：

- 线类，如 baseline（默认值）、top、middle、bottom；
- 文本类，如 text-top、text-bottom；
- 上标下标类，如 sub、super；
- 数值百分比类，如 20px、2em、20%等。

**在 CSS 世界中，凡是百分比值，均是需要一个相对计算的值，例如，margin 和 padding 是相对于宽度计算的，line-height 是相对于 font-size 计算的，而这里的 vertical-align 属性的百分比值则是相对于 line-height 的计算值计算的。可见，CSS 世界中的各类属性相互间有着紧密联系而非孤立的个体。**

#### vertical-align 作用的前提

**因为 vertical-align 起作用是有前提条件的，这个前提条件就是：只能应用于内联元素以及 display 值为 table-cell 的元素。**

CSS 世界中，有一些 CSS 属性值会在背后默默地改变元素 display 属性的计算值，从而导致 vertical-align 不起作用。比方说，**浮动和绝对定位会让元素块状化**，因此，下面的代码组合 vertical-align 是没有理由出现的：

```css
.example { 
 float: left; 
 vertical-align: middle; /* 没有作用 */ 
} 
.example { 
 position: absolute; 
 vertical-align: middle; /* 没有作用 */ 
}
```

```css
.box { 
 height: 128px; 
} 
.box > img { 
 height: 96px; 
 vertical-align: middle; 
} 
<div class="box"> 
 <img src="1.jpg"> 
</div>
```

此时图片顶着.box 元素的上边缘显示，根本没垂直居中，完全没起作用！
**这种情况看上去是 vertical-align:middle 没起作用，实际上，vertical-align 是在努力地渲染的，只是行框盒子前面的“幽灵空白节点”高度太小，如果我们通过设置一个足够大的行高让“幽灵空白节点”高度足够，就会看到 vertical-align:middle 起作用了**，CSS 代码如下：

```css
.box { 
 height: 128px; 
 line-height: 128px; /* 关键 CSS 属性 */ 
} 
.box > img { 
 height: 96px; 
 vertical-align: middle; 
}
```

**table-cell 元素设置 vertical-align 垂直对齐的是子元素，但是其作用的并不是子元素，而是 table-cell 元素自
身。就算 table-cell 元素的子元素是一个块级元素，也一样可以让其有各种垂直对齐表现。**

#### vertical-align 和 line-height 之间的关系

**最明显的就是 vertical-align 的百分比值是相对于 line-height 计算的，但表面所见的这点关系实际是只是冰山一角，实际是只要出现内联元素，这对好朋友一定会同时出现。**

![图片底部间隙](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240709094922_SxuZPn.png)

![内联特性导致的margin无效](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240709100002_qu9hVj.png)

#### 深入理解 vertical-align 线性类属性值

1. inline-block 与 baseline

    vertical-align 属性的默认值 baseline 在文本之类的内联元素那里就是字符 x 的下边缘，对于替换元素则是替换元素的下边缘。但是，如果是 inline-block 元素，则规则要复杂了：**一个 inline-block 元素，如果里面没有内联元素，或者 overflow 不是 visible，则该元素的基线就是其 margin 底边缘；否则其基线就是元素里面最后一行内联元素的基线。**

    💁这里分享一下我总结的一套基于 20px 图标对齐的处理技巧，该技巧有下面 3 个要点。

    （1）图标高度和当前行高都是 20px。很多小图标背景合并工具都是图标宽高多大生成的 CSS 宽高就是多大，这其实并不利于形成可以整站通用的 CSS 策略，我的建议是图标原图先扩展成统一规格，比方说这里的 20px×20px，然后再进行合并，可以节约大量 CSS 以及对每个图标对齐进行不同处理的开发成本。
    （2）图标标签里面永远有字符。这个可以借助:before 或:after 伪元素生成一个空格字符轻松搞定。
    （3）图标 CSS 不使用 overflow:hidden 保证基线为里面字符的基线，但是要让里面潜在的字符不可见。

    于是，最终形成的最佳图标实践 CSS 如下：

    ```css
    .icon { 
        display: inline-block; 
        width: 20px; height: 20px;
        background: url(sprite.png) no-repeat; 
        white-space: nowrap; 
        letter-spacing: -1em; 
        text-indent: -999em; 
    }

    .icon:before { 
        content: '\3000'; 
    } 
    /* 具体图标 */ 
    .icon-xxx { 
        background-position: 0 -20px; 
    }
    ```

2. 了解 `vertial-align:top/bottom`

    vertial-align:top 和 vertial-align:bottom 基本表现类似，只是一个“上”一个“下”，因此合在一起讲。

    vertial-align:top 就是垂直上边缘对齐，具体定义如下。

    - 内联元素：元素底部和当前行框盒子的顶部对齐。
    - table-cell 元素：元素底 padding 边缘和表格行的顶部对齐。

    用更通俗的话解释就是：如果是内联元素，则和这一行位置最高的内联元素的顶部对齐；如果 display 计算值是 table-cell 的元素，我们不妨脑补成`<td>`元素，则和`<tr>`元素上边缘对齐。

3．vertial-align:middle 与近似垂直居中

#### 深入理解 vertical-align 文本类属性值

文本类属性值指的就是 text-top 和 text-bottom，定义如下。

- vertical-align:text-top：盒子的顶部和父级内容区域的顶部对齐。
- vertical-align:text-bottom：盒子的底部和父级内容区域的底部对齐。

#### 简单了解 vertical-align 上标下标类属性值

#### 无处不在的 vertical-align

对于内联元素，如果大家遇到不太好理解的现象，请一定要意识到，**有个“幽灵空白节点”以及无处不在的 vertical-align 属性**。

虽然同属线性类属性值，但是 top/bottom 和 baseline/middle 却是完全不同的两个帮派，前者对齐看边缘看行框盒子，而后者是和字符 x 打交道。因此，细细考究，两者的行为表现实则大相径庭，一定要注意区分。

#### 基于 vertical-align 属性的水平垂直居中弹框

![弹框居中](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240709161646_cGShzu.png)

## 流的破坏与保护

### 魔鬼属性 float

#### float 的本质与特性

float 都有哪些有意思的特性呢？具体如下：
• 包裹性；
• 块状化并格式化上下文；
• 破坏文档流；
• 没有任何 margin 合并；

（1）包裹。假设浮动元素父元素宽度 200px，浮动元素子元素是一个 128px 宽度的图片，则此时浮动元素宽度表现为“包裹”，就是里面图片的宽度 128px，代码如下：

```css
.father { width: 200px; } 
.float { float: left; } 
.float img { width: 128px; } 
<div class="father"> 
 <div class="float"> 
 <img src="1.jpg"> 
 </div> 
</div>
```

（2）自适应性。如果浮动元素的子元素不只是一张 128px 宽度的图片，还有一大波普通的文字，例如：

```css
<div class="father"> 
 <div class="float"> 
 <img src="1.jpg">我是帅哥，好巧啊，我也是帅哥，原来看这本书的人都是帅哥~ 
 </div> 
</div>
```

则此时浮动元素宽度就自适应父元素的 200px 宽度，最终的宽度表现也是 200px。

**块状化的意思是，元素一旦 float 的属性值不为 none，则其 display 计算值就是 block 或者 table。**
**也不要指望使用 text-align 属性控制浮动元素的左右对齐，因为 text-align 对块级元素是无效的。**

#### float 的作用机制

然而，“高度塌陷”只是让跟随的内容可以和浮动元素在一个水平线上，但这只是实现“环绕效果”的条件之一，要想实现真正的“环绕效果”，就需要另外一个平时大家不太在意的特性，那就是“行框盒子和浮动元素的不可重叠性”，也就是“行框盒子如果和浮动元素的垂直高度有重叠，则行框盒子在正常定位状态下只会跟随浮动元素，而不会发生重叠”。

因为“文字环绕效果”是由两个特性（即“父级高度塌陷”和“行框盒子区域限制”）共同作用的结果，定高只能解决“父级高度塌陷”带来的影响，但是对“行框盒子区域限制”却没有任何效果，结果导致的问题是浮动元素垂直区域一旦超出高度范围，或者下面元素 margin-top 负值上偏移，就很容易使后面的元素发生“环绕效果”，代码示意如下：

```css
<div class="father"> 
    <div class="float"> 
        <img src="zxx.jpg"> 
    </div> 
    我是帅哥，好巧啊，我也是帅哥，原来看这本书的人都是帅哥~ 
</div> 
<div>虽然你很帅，但是我对你不感兴趣。</div>
.father {
 height: 64px; 
 border: 1px solid #444; 
} 
.float { 
 float:left; 
} 
.float img { 
 width: 60px; height: 64px; 
}
```

![float环绕](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713110350_EtZDwX.png)

**因此，当使用浮动元素的时候，比较稳妥的做法还是采用一些手段干净地清除浮动带来的影响，以避免很多意料之外的样式问题的发生。**

#### float 更深入的作用机制

首先，我们需要了解两个和 float 相关的术语，一是“浮动锚点”（float anchor），二是“浮动参考”（float reference）。

- 浮动锚点是 float 元素所在的“流”中的一个点，这个点本身并不浮动，就表现而言更像一个没有 margin、border 和 padding 的空的内联元素。
- 浮动参考指的是浮动元素对齐参考的实体。

在 CSS 世界中，float 元素的“浮动参考”是“行框盒子”，也就是 float 元素在当前“行框盒子”内定位。再强调一遍，是“行框盒子”，不是外面的包含块盒子之类的东西，因为CSS 浮动设计的初衷仅仅是实现文字环绕效果。

#### float 与流体布局

一侧定宽的两栏自适应布局，HTML 和 CSS 代码如下：

```css
<div class="father"> 
 <img src="me.jpg"> 
 <p class="animal">小猫 1，小猫 2，...</p> 
</div> 
.father { 
 overflow: hidden; 
} 
.father > img { 
 width: 60px; height: 64px; 
 float: left; 
} 
.animal { 
 margin-left: 70px; 
}
```

![两栏自适应布局](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713112128_3cWJp7.png)

如果是多栏布局，也同样适用。

```css
假设 HTML 结构如下：
<div class="box"> 
 <a href class="prev">&laquo; 上一章</a> 
 <a href class="next">下一章 &raquo;</a> 
 <h3 class="title">第 112 章 动物环绕</h3> 
</div> 
则 CSS 可以如下：
.prev { 
 float: left; 
} 
.next { 
 float: right; 
} 
.title { 
 margin: 0 70px; 
 text-align: center; 
}
```

也就是说，.title 所在的`<h3>`标题元素直接左右 margin，借助流体特性，保证不会和两个文字链接重叠。

### float 的天然克星 clear

#### 什么是 clear 属性

CSS 有一个专门用来处理 float 属性带来的高度塌陷等问题的属性，这个属性就是 clear。其语法如下：
`clear: none | left | right | both`

因此，我对 clear 属性值的理解是下面这样的。
• none：默认值，左右浮动来就来。
• left：左侧抗浮动。
• right：右侧抗浮动。
• both：两侧抗浮动

#### 成事不足败事有余的 clear

clear 属性只有块级元素才有效的，而::after 等伪元素默认都是内联水平，这就是借助伪元素清除浮动影响时需要设置 display 属性值的原因。

```css
.clear:after { 
 content: ''; 
 display: table; // 也可以是'block'，或者是'list-item' 
 clear: both; 
}
```

### CSS 世界的结界——BFC

#### BFC 的定义

BFC 全称为 block formatting context，中文为“块级格式化上下文”。相对应的还有 IFC，也就是 inline formatting context，中文为“内联格式化上下”。

**大家请记住下面这个表现原则：如果一个元素具有 BFC，内部子元素再怎么翻江倒海、翻云覆雨，都不会影响外部的元素。**

那什么时候会触发 BFC 呢？常见的情况如下：

- `<html>`根元素；
- float 的值不为 none；
- overflow 的值为 auto、scroll 或 hidden；
- display 的值为 table-cell、table-caption 和 inline-block 中的任何一个；
- position 的值不为 relative 和 static。

#### BFC 与流体布局

我们还是从最基本的文字环绕效果说起。还是那个小动物环绕的例子：

```css
<div class="father"> 
 <img src="me.jpg"> 
 <p class="animal">小猫 1，小猫 2，...</p> 
</div> 
img { float: left; }
```

![BFC流体布局](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713154111_RzjYBB.png)

和基于纯流体特性实现的两栏或多栏自适应布局相比，基于 BFC 特性的自适应布局有如下优点。
（1）自适应内容由于封闭而更健壮，容错性更强。比方说，内部设置 clear:both 不会与 float 元素相互干扰而导致错位。
（2）自适应内容自动填满浮动以外区域，无须关心浮动元素宽度，可以整站大规模应用。比方说，抽象几个通用的布局类名，如：

```css
.left { float: left; } 
.right { float: right; } 
.bfc { overflow: hidden; }
```

于是，只要遇到两栏结构，直接使用上面的结构类名就可以完成基本的布局。HTML 示意如下：

```css
<div class="bfc"> 
 <img src="me.jpg" class="left"> 
 <p class="bfc">小猫 1，小猫 2，...</p> 
</div>
```

### 最佳结界 overflow

#### overflow 剪裁界线 border box

overflow 属性的一个很经典的不兼容问题，即 Chrome 浏览器下，如果容器可滚动（假设是垂直滚动），则 padding-bottom 也算在滚动尺寸之内，IE 和 Firefox 浏览器忽略 padding-bottom。例如，上面的.box，我们把 overflow 属性值改成 auto（亦可点击实例页面图片），滚动到底部会发现，Chrome 浏览器下面是有 10 像素的空白的，Firefox 和 IE 却没有。

#### 了解 overflow-x 和 overflow-y

自IE8 以上版本的浏览器开始，overflow 属性家族增加了两个属性，就是这里的overflow-x 和 overflow-y，分别表示单独控制水平或垂直方向上的剪裁规则。
支持的属性值和 overflow 属性一模一样。

- visible：默认值。
- hidden：剪裁。
- scroll：滚动条区域一直在。
- auto：不足以滚动时没有滚动条，可以滚动时滚动条出现

#### overflow 与滚动条

关于浏览器的滚动条，有以下几个小而美的结论。
（1）在 PC 端，无论是什么浏览器，默认滚动条均来自`<html>`，而不是`<body>`标签。

所以，如果我们想要去除页面默认滚动条，只需要：
`html { overflow: hidden; }`

（2）滚动条会占用容器的可用宽度或高度。

如我们希望实现一个表格头固定、表格主体可以滚动的效果，常见的实现方法是使用双`<table>`，表格头是一个独立的`<table>`，主体也是一个独立的`<table>`元素，放在一个 overflow:auto 的`<div>`元素中，这种实现，如果滚动条不出现还好，两个表格的表格列可以完美对齐，但是一旦滚动条出现，主题表格可用宽度被压缩，表格列往往就无法完美对齐了。

常用的解决方法有下面两种：一种是`<table>`元素使用固定的宽度值，但是距离右侧留有 17px 的间隙，这样即使滚动条出现，也不会产生任何的宽度影响；另一种就是表格的最后一列不设定宽度（文字最好左对齐），前面每一列都定死宽度，这样最后一列就是自适应结构，就算滚动条出现，也只是自身有一些宽度变小，对整体对齐并无多大影响。

这里分享一个可以让页面滚动条不发生晃动的小技巧，即使用如下 CSS 代码：

```css
html { 
 overflow-y: scroll; /* for IE8 */ 
} 
:root { 
 overflow-y: auto; 
 overflow-x: hidden; 
} 
:root body { 
 position: absolute; 
} 
body { 
 width: 100vw; 
 overflow: hidden; 
}
```

#### 依赖 overflow 的样式表现

在 CSS 世界中，很多属性要想生效都必须要有其他 CSS 属性配合，其中有一种效果就离不开 overflow:hidden 声明，即单行文字溢出点点点效果。虽然效果的核心是 text-overflow:ellipsis，效果实现必需的 3 个声明如下：

```css
.ell { 
 text-overflow: ellipsis; 
 white-space: nowrap; 
 overflow: hidden; 
}
```

#### overflow 与锚点定位

```html
<a href="#1">发展历程></a> 
<a name="1"></a>
```

```html
<a href="#1">发展历程></a> 
<h2 id="1">发展历程</h2>
```

![URL 锚链锚点定位和 overflow 的选项卡切换效果实例页面](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713164929_7Dc55N.png)

![URL 锚链锚点定位和 overflow 的选项卡切换效果实例页面原理](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713165458_TjAJDj.png)

![focus 锚点定位和 overflow 的选项卡切换效果实例页面](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713170115_VB3kdT.png)

![focus 锚点定位和 overflow 的选项卡切换效果实例页面原理](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713170331_1uZwcR.png)

### float 的兄弟 position:absolute

我一直认为 position:absolute（下简称 absolute）和 float:left/float：right（下简称 float）是兄弟关系，都兼具“块状化”“包裹性”“破坏性”等特性，不少布局场合甚至可以相互替代。

“块状化”和浮动类似，元素一旦 position 属性值为 absolute 或 fixed，其 display 计算值就是 block 或者 table。例如，<span>元素默认是 inline 水平，但是一旦设置 position:absolute，其 display 计算值就变成了 block。

**和 float或其他“包裹性”声明带来的“自适应性”相比，absolute 有一个平时不太被人注意的差异，那就是 absolute 的自适应性最大宽度往往不是由父元素决定的，本质上说，这个差异是由“包含块”的差异决定的。换句话说，absolute 元素具有与众不同的“包含块”。**

#### absolute 的包含块

包含块（containing block）这个概念实际上大家一直都有接触，就是元素用来计算和定位的一个框。比方说，width:50%，也就是宽度一半，那到底是哪个“元素”宽度的一半呢？注意，这里的这个“元素”实际上就是指的“包含块”。有经验的人应该都知道，普通元素的百分比宽度是相对于父元素的 content box 宽度计算的，**而绝对定位元素的宽度是相对于第一个 position 不为 static 的祖先元素计算的**。

实际上，大家已经和“包含块”打过交道了，对于这些计算规则，规范是有明确定义的，具体如下（剔除了不常用的部分内容）。

（1）根元素（很多场景下可以看成是<html>）被称为“初始包含块”，其尺寸等同于浏览器可视窗口的大小。
（2）对于其他元素，如果该元素的 position 是 relative 或者 static，则“包含块”由其最近的块容器祖先盒的 content box 边界形成。
（3）如果元素 position:fixed，则“包含块”是“初始包含块”。
（4）如果元素 position:absolute，则“包含块”由最近的 position 不为 static 的祖先元素建立，具体方式如下。

如果该祖先元素是纯 inline 元素，则规则略复杂：

- 假设给内联元素的前后各生成一个宽度为 0 的内联盒子（inline box），则这两个内联盒子的 padding box 外面的包围盒就是内联元素的“包含块”；
- 如果该内联元素被跨行分割了，那么“包含块”是未定义的，也就是 CSS2.1 规范并没有明确定义，浏览器自行发挥。
否则，“包含块”由该祖先的 padding box 边界形成。

**如果没有符合条件的祖先元素，则“包含块”是“初始包含块”。**
可以看到，和常规元素相比，absolute 绝对定位元素的“包含块”有以下 3 个明显差异：
（1）内联元素也可以作为“包含块”所在的元素；
（2）“包含块”所在的元素不是父块级元素，而是最近的 position 不为 static 的祖先元素或根元素；
（3）边界是 padding box 而不是 content box。

**对于绝对定位元素，height:100%是第一个具有定位属性值的祖先元素的高度，而 height:inherit 则是单纯的父元素的高度继承，在某些场景下非常好用。**

#### 具有相对特性的无依赖 absolute 绝对定位

即使写了很多年 CSS 代码的人也可能会错误地回答下面这个问题：一个绝对定位元素，没有任何 left/top/right/bottom 属性设置，并且其祖先元素全部都是非定位元素，其位置在哪里？
很多人都认为是在浏览器窗口左上方。实际上，还是当前位置，不是在浏览器左上方。

absolute 定位效果实现完全不需要父元素设置 position为 relative 或其他什么属性就可以实现，我把这种没有设置 left/top/right/bottom 属性值的绝对定位称为“无依赖绝对定位”。很多场景下，“无依赖绝对定位”要比使用 left/top 之类属性定位实用和强大很多，因为其除了代码更简洁外，还有一个很棒的特性，就是“相对定位特性”。

**明明 absolute 是‘绝对定位’的意思，怎么又扯到‘相对定位特性’了呢？没错，“无依赖绝对定位”本质上就是“相对定位”，仅仅是不占据 CSS 流的尺寸空间而已。**

1. 各类图标定位

    ![各类图表定位1](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713182852_Ka0S8P.png)

    ![各类图表定位2](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713182951_81HsY6.png)

2. 超越常规布局的排版

    ![无依赖绝对定位与超越常规布局的排版实例页面](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713184617_tEBhZq.png)

3. 下拉列表的定位

    ![无依赖绝对定位与下拉列表定位实例页面展示](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240713185612_p67J8M.png)

4. 占位符效果模拟

5. 进一步深入“无依赖绝对定位”

#### absolute 与 text-align

按道理讲，absolute 和 float 一样，都可以让元素块状化，应该不会受控制内联元素对齐的 text-align 属性影响，但是最后的结果却出人意料，text-align 居然可以改变 absolute 元素的位置。

### absolute 与 overflow

overflow 对 absolute 元素的剪裁规则用一句话表述就是：**绝对定位元素不总是被父级 overflow 属性剪裁，尤其当 overflow 在绝对定位元素及其包含块之间的时候。**

上面这句话是官方文档的直译，似乎还是有些拗口，我们再换一种方法表述就是：**如果 overflow 不是定位元素，同时绝对定位元素和 overflow 容器之间也没有定位元素，则 overflow 无法对 absolute 元素进行剪裁。**

因此下面 HTML 中的图片不会被剪裁：

```css
<div style="overflow: hidden;"> 
 <img src="1.jpg" style="position: absolute;"> 
</div>
```

overflow 元素父级是定位元素也不会剪裁，例如：

```css
<div style="position: relative;"> 
    <div style="overflow: hidden;"> 
        <img src="1.jpg" style="position: absolute;"> 
    </div> 
</div>
```

但是，如果 overflow 属性所在的元素同时也是定位元素，里面的绝对定位元素会被剪裁：

```css
<div style="overflow: hidden; position: relative;"> 
    <img src="1.jpg" style="position: absolute;"> <!-- 剪裁 --> 
</div>
```

如果 overflow 元素和绝对定位元素之间有定位元素，也会被剪裁：

```css
<div style="overflow: hidden;"> 
    <div style="position: relative;"> 
        <img src="1.jpg" style="position: absolute;"> <!-- 剪裁 --> 
    </div> 
</div>
```

如果 overflow 的属性值不是 hidden 而是 auto 或者 scroll，即使绝对定位元素高宽比 overflow 元素高宽还要大，也都不会出现滚动条。例如，下面的 HTML 和 CSS 代码：

```css
<div class="box"> 
    <img src="1.jpg"> 
</div> 
.box { 
 width: 300px; height: 100px; 
 background-color: #f0f3f9; 
 overflow: auto; 
} 
.box > img { 
 width: 256px; height: 192px; 
 position: absolute; 
}
```

### absolute 与 clip

#### 重新认识的 clip 属性

1. fixed 固定定位的剪裁
2. 最佳可访问性隐藏

```css
<form> 
    <input type="submit" id="someID" class="clip"> 
    <label for="someID">提交</label> 
</form>

.clip {
    position: absolute;
    clip: rect(0 0 0 0);
}
```

这里使用的 clip 剪裁隐藏是我工作这么多年大浪淘沙筛选后的最佳实践，有对比才能显出好在何处。

- display:none 或者 visibility:hidden 隐藏有两个问题，一个是按钮无法被 focus 了，另外一个是 IE8 浏览器下提交行为丢失，原因应该与按钮 focus 特性丢失有关。

- 透明度 0 覆盖也是一个不错的实践。如果是移动端项目，建议这么做；但如果是桌面端项目，则完全没有必要。使用透明度 0 覆盖的问题是每一个场景都需要根据环境的不同重新定位，以保证点击区域的准确性，成本较高，但 clip 隐藏直接用一个类名加一下就好。

- 还有一种比较具有适用性的“可访问隐藏”是下面这种屏幕外隐藏：

    ```css
    .abs-out {
        position: absolute; 
        left: -999px; top: -999px; 
    }
    ```

#### 深入了解 clip 的渲染

**clip 隐藏仅仅是决定了哪部分是可见的，非可见部分无法响应点击事件等；然后，虽然视觉上隐藏，但是元素的尺寸依然是原本的尺寸，在 IE 浏览器和 Firefox 浏览器下抹掉了不可见区域尺寸对布局的影响，Chrome 浏览器却保留了。**

### absolute 的流体特性

#### absolute 流体特性

说到流体特性，我们通常第一反应就是<div>之类的普通块级元素。实际上，绝对定位元素也具有类似的流体特性，当然，不是默认就有的，而是在特定条件下才具有，这个条件就是“对立方向同时发生定位的时候”。

left/top/right/bottom 是具有定位特性元素专用的 CSS 属性，其中 left 和 right 属于水平对立定位方向，而 top 和 bottom 属于垂直对立定位方向。

当一个绝对定位元素，其对立定位方向属性同时有具体定位数值的时候，流体特性就发生了。例如：

```css
<div class="box"></div> 
.box { 
 position: absolute; 
 left: 0; right: 0; 
}
```

**如果只有 left 属性或者只有 right 属性，则由于包裹性，此时.box 宽度是 0。但是在本例中，因为 left 和 right 同时存在，所以宽度就不是 0，而是表现为“格式化宽度”，宽度大小自适应于.box 包含块的 padding box，也就是说，如果包含块 padding box 宽度发生变
化，.box 的宽度也会跟着一起变。**

**如果想让绝对定位元素宽高自适应于包含块，没有理由不使用流体特性写法，除非是替换元素的拉伸。而绝对定位元素的这种流体特性比普通元素要更强大，普通元素流体特性只有一个方向，默认是水平方向，但是绝对定位元素可以让垂直方向和水平方向同时保持流动性。**

#### absolute 的 margin:auto 居中

利用绝对定位元素的流体特性和 margin:auto 的自动分配特性实现居中，例如：

```css
.element { 
    width: 300px; height: 200px; 
    position: absolute; 
    left: 0; right: 0; top: 0; bottom: 0; 
    margin: auto; 
}
```

### position:relative 才是大哥

#### relative 对 absolute 的限制

#### relative 与定位

**relative 的定位有两大特性：一是相对自身；二是无侵入。**

“无侵入”的意思是，当 relative 进行定位偏移的时候，一般情况下不会影响周围元素的布局。

relative 的定位还有另外两点值得一提：相对定位元素的 left/top/right/bottom 的百分比值是相对于包含块计算的，而不是自身。注意，虽然定位位移是相对自身，但是百分比值的计算值不是。

top 和 bottom 这两个垂直方向的百分比值计算跟 height 的百分比值是一样的，都是相对高度计算的。同时，如果包含块的高度是 auto，那么计算值是 0，偏移无效，也就是说，如果父元素没有设定高度或者不是“格式化高度”，那么 relative 类似 top:20% 的代码等同于 top:0。

当相对定位元素同时应用对立方向定位值的时候，也就是 top/bottom 和 left/right 同时使用的时候，其表现和绝对定位差异很大。绝对定位是尺寸拉伸，保持流体特性，但是相对定位却是“你死我活”的表现，也就是说，只有一个方向的定位属性会起作用。而孰强孰弱则是与文档流的顺序有关的，默认的文档流是自上而下、从左往右，因此 top/bottom 同时使用的时候，bottom 被干掉；left/right 同时使用的时候，right 毙命。

#### relative 的最小化影响原则

“relative 的最小化影响原则”是我自己总结的一套更好地布局实践的原则，主要分为以下两部分：
（1）**尽量不使用 relative，如果想定位某些元素，看看能否使用“无依赖的绝对定位”；**
（2）**如果场景受限，一定要使用 relative，则该 relative 务必最小化。**

### 强悍的 position:fixed 固定定位

#### position:fixed 不一样的“包含块”

position:fixed 固定定位元素的“包含块”是根元素，我们可以将其近似看成`<html>`元素。换句话说，唯一可以限制固定定位元素的就是`<html>`根元素，而根元素就这么一个，也就是全世界只有一个人能限制 `position:fixed` 元素，可见人家强悍还是有强悍的资本的。

和“无依赖的绝对定位”类似，就是“无依赖的固定定位”，利用 absolute/fixed 元素没有设置 left/top/right/bottom 的相对定位特性，可以将目标元素定位到我们想要的位置，处理如下：

```css
<div class="father"> 
    <div class="right"> 
        &nbsp;<div class="son"></div> 
    </div> 
</div> 
.father { 
    width: 300px; height: 200px; 
    position: relative; 
} 
.right { 
    height: 0; 
    text-align: right; 
    overflow: hidden; 
} 
.son { 
    display: inline; 
    width: 40px; height: 40px; 
    position: fixed; 
    margin-left: -40px; 
}
```

#### position:fixed 的 absolute 模拟

```html
使用 position:absolute 进行模拟则需要一个滚动容器，假设类名是.page，则有：
<html> 
    <body> 
        <div class="page">固定定位元素<div> 
        <div class="fixed"><div> 
    </body> 
</html> 
html, body { 
 height: 100%; 
 overflow: hidden; 
} 
.page { 
 height: 100%; 
 overflow: auto; 
} 
.fixed { 
 position: absolute; 
}
```

整个网页的滚动条由.page 元素产生，而非根元素，此时.fixed 元素虽然是绝对定位，但是并不在滚动元素内部，自然滚动时不会跟随，如同固定定位效果，同时本身绝对定位。因此，可以使用 relative 进行限制或者 overflow 进行裁剪等。

然而，将网页的窗体滚动变成内部滚动，很多窗体滚动相关的小 JavaScript 组件需要跟着
进行调整，并且可能会丢失其他一些浏览器内置行为，需要谨慎使用。

## CSS 世界的的层叠规则

### z-index 只是 CSS 层叠规则中的一叶小舟

### 理解 CSS 世界的层叠上下文和层叠水平

#### 什么是层叠上下文

#### 什么是层叠水平

**需要注意的是，诸位千万不要把层叠水平和 CSS 的 z-index 属性混为一谈。尽管某些情况下 z-index 确实可以影响层叠水平，但是只限于定位元素以及 flex 盒子的孩子元素；而层叠水平所有的元素都存在。**

### 理解元素的层叠顺序

![层叠顺序](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240716220950_VPOXTh.png)

### 务必牢记的层叠准则

💁 **下面这两条是层叠领域的黄金准则。当元素发生层叠的时候，其覆盖关系遵循下面两条准则：**
（1）谁大谁上：当具有明显的层叠水平标识的时候，如生效的 z-index 属性值，在同一个层叠上下文领域，层叠水平值大的那一个覆盖小的那一个。
（2）后来居上：当元素的层叠水平一致、层叠顺序相同的时候，在 DOM 流中处于后面的元素会覆盖前面的元素。
在 CSS 和 HTML 领域，只要元素发生了重叠，都离不开上面这两条黄金准则。因为后面会有多个实例说明，这里就到此为止。

### 深入了解层叠上下文

#### 层叠上下文的特性

层叠上下文元素有如下特性。

- 层叠上下文的层叠水平要比普通元素高（原因后面会说明）。
- 层叠上下文可以阻断元素的混合模式（参见 <http://www.zhangxinxu.com/wordpress/?p=5155> 的这篇文章的第二部分说明）。
- 层叠上下文可以嵌套，内部层叠上下文及其所有子元素均受制于外部的“层叠上下文”。
- 每个层叠上下文和兄弟元素独立，也就是说，当进行层叠变化或渲染的时候，只需要考虑后代元素。
- 每个层叠上下文是自成体系的，当元素发生层叠的时候，整个元素被认为是在父层叠上下文的层叠顺序中。

#### 层叠上下文的创建

和块状格式化上下文一样，层叠上下文也基本上是由一些特定的 CSS 属性创建的。我将其总结为 3 个流派。

（1）天生派：页面根元素天生具有层叠上下文，称为根层叠上下文。
（2）正统派：z-index 值为数值的定位元素的传统“层叠上下文”。
（3）扩招派：其他 CSS3 属性。

1. 根层叠上下文

    根层叠上下文指的是页面根元素，可以看成是<html>元素。因此，页面中所有的元素一定处于至少一个“层叠结界”中。

2. 定位元素与传统层叠上下文

    对于 position 值为 relative/absolute 以及 Firefox/IE 浏览器（不包括 Chrome 浏览器）下含有 position:fixed 声明的定位元素，当其 z-index 值不是 auto 的时候，会创建层叠上下文。

    ![定位元素与传统层叠上下文](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240717082523_Sxnzam.png)

3. CSS3 与新时代的层叠上下文

    CSS3 新世界的出现除了带来了新属性，还对过去的很多规则发出了挑战，其中对**层叠上下文**规则的影响显得特别突出。

    （1）元素为 flex 布局元素（父元素 display:flex|inline-flex），同时 z-index 值不是 auto。
    （2）元素的 opacity 值不是 1。
    （3）元素的 transform 值不是 none。
    （4）元素 mix-blend-mode 值不是 normal。
    （5）元素的 filter 值不是 none。
    （6）元素的 isolation 值是 isolate。
    （7）元素的 will-change 属性值为上面 2～6 的任意一个（如 will-change:opacity、will-chang:transform 等）。
    （8）元素的-webkit-overflow-scrolling 设为 touch。

#### 层叠上下文与层叠顺序

#### z-index 负值深入理解

那 z-index 负值在实际项目中有什么用呢？具体作用如下。

（1）可访问性隐藏。z-index 负值可以隐藏元素，只需要层叠上下文内的某一个父元素加个背景色就可以。它与 clip 隐藏相比的一个优势是，元素无须绝对定位，设置 position:relative 也可以隐藏，另一个优势是它对原来的布局以及元素的行为没有任何影响，而 clip 隐藏会导致控件 focus 的焦点发生细微的变化，在特定条件下是有体验问题的。它的不足之处就是不具有普遍适用性，需要其他元素配合进行隐藏。
（2）IE8 下的多背景模拟。CSS3 中有一个多背景特性，就是一个 background 可以写多个背景图。虽然 IE8 浏览器不支持多背景特性，但是 IE8 浏览器支持伪元素，于是，IE8 理论上也能实现多背景，这个背景最多 3 个，好在绝大多数场景 3 个背景图足矣。最麻烦的其实是这个伪元素生成的背景一定是使用 absolute 绝对定位，以免影响内容的布局。于是问题来了，绝对定位会覆盖常规的元素，此时则必须借助 z-index 负值，核心 CSS 代码如下：

```css
.box { 
    background-image: (1.png); 
    position: relative; 
    z-index: 0; /* 创建层叠上下文 */ 
} 
.box:before, 
.box:after { 
    content: ''; 
    position: absolute; 
    z-index: -1;
} 
.box:before { 
    background-image: (2.png); 
} 
.box:after { 
    background-image: (3.png); 
}
```

（3）定位在元素的后面。

### z-index“不犯二”准则

**此准则内容如下：对于非浮层元素，避免设置 z-index 值，z-index 值没有任何道理需要超过 2。由于 z-index 不能超过 2，因此，我称其为“不犯二”准则。**

很重要的一点，我这里的“不犯二”准则，并不包括那些在页面上飘来飘去的元素定位，弹框、出错提示、一些下拉效果等都不受这一准则限制。
对于这类 JavaScript 驱动的浮层组件，我会借助“层级计数器”来管理，原因如下：
（1）总会遇到意想不到的高层级元素；
（2）组件的覆盖规则具有动态性。

所谓“层级计数器”，实际上就是一段 JavaScript 脚本，会遍历所有`<body>`处于显示状态的子元素，并得到最大 z-index 值，和默认的 z-index 做比较。如果超出，则显示的组件的 z-index 自动加 1，这样就不会出现有组件被其他组件覆盖的问题；如果不超出，就使用默认的 z-index 值，我习惯设成 9，因为遵循“不犯二”准则的情况下，9 已经是个足够安全的值了，浮层组件根本无须担心会被页面上某个元素层级覆盖。

## 强大的文本处理能力

### line-height 的另外一个朋友 font-size

#### font-size 和 vertical-align 的隐秘故事

#### 理解 font-size 与 ex、em 和 rem 的关系

在 CSS 中，1em 的计算值等同于当前元素所在的 font-size 计算值，可以将其想象成当前元素中（如果有）汉字的高度。

要想实现带有缩放性质的弹性布局，使用 rem 是最佳策略，但 rem 是 CSS3 单位，IE9 以上浏览器才支持，需要注意兼容性。

#### 理解 font-size 的关键字属性值

font-size 支持长度值，如 1em，也支持百分比值，如 100%。这两点想必众所周知，但 font-size 还支持关键字属性值这一点怕是就有不少人不清楚了。
font-size 的关键字属性值分以下两类。
（1）相对尺寸关键字。指相对于当前元素 font-size 计算，包括：

- larger：大一点，是`<big>`元素的默认 font-size 属性值。
- smaller：小一点，是`<small>`元素的默认 font-size 属性值。

（2）绝对尺寸关键字。与当前元素 font-size 无关，仅受浏览器设置的字号影响。注意这里的措辞，是“浏览器设置”，而非“根元素”，两者是有区别的。

- xx-large：好大好大，和`<h1>`元素计算值一样。
- x-large：好大，和`<h2>`元素计算值一样。
- large：大，和`<h3>`元素计算值近似（“近似”指计算值偏差在 1 像素以内，下同）
- medium：不上不下，是 font-size 的初始值，和 `<h4>` 元素计算值一样。为了解决大家可能有的疑问，这里有必要多说几句。如果 font-size 默认值是 medium，而 medium 计算值仅与浏览器设置有关，那为何我们平时元素 font-size 总是受环境影响变来变去呢？这完全是因为 font-size 属性的继承性，实际开发的时候，我们常常会对 `<html>` 或 `<body>` 重置 font-size 大小，例如：

  ```css
  body { 
    font-size: 14px; 
  }
  ```

- small：小，和`<h5>`元素计算值近似。
- x-small：好小，和`<h6>`元素计算值近似。
- xx-small：好小好小，无对应的 HTML 元素。

如何权衡“易于实现维护”“视觉还原”“可访问性”这三者，我这里有两个珍藏的建议。

（1）即使是定宽的传统桌面端网页，也需要做响应式处理，尤其是针对 1200 像素宽度设计的网页，但只需要响应到 800 像素即可，可以保证至少有 1.5 倍的缩放空间，如果做到这一步，那么是否需要响应浏览器的字号设置这一点就可以忽略。
（2）如果困各种原因无法做响应式处理，也没有必要全局都使用相对单位，毕竟成本等现实问题摆在那里，其实只需要在图文内容为主的重要局部区域使用可缩放的 font-size 处理即可。例如，小说网站的阅读页、微信公众号文章展示区、私信对话内容区、搜索引擎的落地页、评论区等，都强烈建议摒弃 px 单位，而采用下面的实践策略。

- 容器设置 font-size:medium，此时，这个局部展示区域的字号就跟着浏览器的设置走了，默认计算值是 16px。
- 容器内的文字字号全部使用相对单位，如百分比值或者 em 都可以，然后基于 16px 进行转换。例如：

  ```css
  .article {
    font-size: medium; 
  }
  .article h1 {
    font-size: 2em;
    margin: .875em 0;
  }
  .article p {
    font-size: 87.5%; /* 默认字号下计算值是 14px */
    margin: 1em 0;
  }
  ```

  同时使用自适应流体布局，间距什么的也使用相对单位，例如上面 margin 使用的是 em 单位。于是，当用户改变了浏览器的字号后，整个阅读区域的所有字样甚至布局都会跟着放大，文字一下子就看清楚了。这种局部处理的好处在于，页面的导航、侧边栏这些不需要长时间阅读的模块还是原来的像素布局，还是那么精致，丝毫不受影响。就这么很微小的变动，就可以让你的网页在可访问性这一块超越大多数的网站，何乐而不为？

#### font-size:0 与文本的隐藏

如果 font-size:0 的字号表现就是 0，那么文字会直接被隐藏掉，并且只能是 font-size:0，哪怕设置成 font-size:0.0000001px，
都还是会被当作 12px 处理的。
因此，如果希望隐藏 logo 对应元素内的文字，除了 text-indent 缩进隐藏外，还可以试试下面这种方法：

```css
.logo { 
 font-size: 0; 
}
```

### 字体属性家族的大家长 font-family

**font-family 默认值由操作系统和浏览器共同决定，例如 Windows 和 OS X 下的 Chrome 默认字体不一样，同一台 Windows 系统的 Chrome 和 Firefox 浏览器默认字体也不一样。**

font-family 支持两类属性值，一类是“字体名”，一类是“字体族”。“字体名”很好理解，就是使用的对应字体的名称。例如：

```css
body { 
 font-family: simsun; 
}

body { 
 font-family: 'Microsoft Yahei'; 
}

body { 
 font-family: 'PingFang SC', 'Microsoft Yahei'; 
}
```

但是，“字体族”分为很多类，MDN 上文档分类如下：
font-family: serif;
font-family: sans-serif;
font-family: monospace;
font-family: cursive;
font-family: fantasy;
font-family: system-ui;

具体含义解释如下。
• serif：衬线字体。
• sans-serif：无衬线字体。
• monospace：等宽字体。
• cursive：手写字体。
• fantasy：奇幻字体。
• system-ui：系统 UI 字体

#### 了解衬线字体和无衬线字体

字体分衬线字体和无衬线字体。**所谓衬线字体，通俗讲就是笔画开始、结束的地方有额外装饰而且笔画的粗细会有所不同的字体。网页中常用中文衬线字体是“宋体”，常用英文衬线字体有 Times New Roman、Georgia 等。无衬线字体没有这些额外的装饰，而且笔画的粗细差不多，如中文的“雅黑”字体，英文包括 Arial、Verdana、Tahoma、Helivetica、Calibri 等。**

```css
body { 
 font-family: "Microsoft Yahei", sans-serif; 
}
```

#### 等宽字体的实践价值

**所谓等宽字体，一般是针对英文字体而言的。据我所知，东亚字体应该都是等宽的，就是每个字符在同等 font-size 下占据的宽度是一样的。但是英文字体就不一定了，我随便写一个单词，就 iMac 吧，大家很明显地发现这个字符 i 要比 M 占据的宽度小。**

等宽字体在 Web 中有什么用呢？

1. 等宽字体与代码呈现
2. 等宽字体与图形呈现案例一则
3. ch 单位与等宽字体布局
  ch 和 em、rem、ex 一样，是 CSS 中和字符相关的相对单位。和 ch 相关的字符是 0，没错，就是阿拉伯数字 0。1ch 表示一个 0 字符的宽度，所以 6 个 0 所占据的宽度就是 6ch。

#### 中文字体和英文名称

（1）Windows 常见内置中文字体和对应英文名称见图

![Windows常见内置中文字体和对应英文名称](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240721135140_0wejbt.png)

（2）OS X 系统内置中文字体和对应英文名称见图

![OSX系统内置中文字体和对应英文名称](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240721135307_n5O6RL.png)

（3）Office 软件安装新增中文字体和对应英文名称见图

![Office 软件安装新增中文字体和对应英文名称](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240721135427_gBuuaZ.png)

（4）其他一些中文字体和对应英文名称见图

![其他一些中文字体和对应英文名称](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240721135517_hrupOQ.png)

#### 一些补充说明

### 字体家族其他成员

#### 貌似粗犷、实则精细无比的 font-weight

font-weight 表示“字重”，通俗点讲，就是表示文字的粗细程度。

首先让我们大致了解一下 font-weight 都支持哪些属性值。具体如下：

```css
/* 平常用的最多的 */
font-weight: normal; 
font-weight: bold; 
/* 相对于父级元素 */ 
font-weight: lighter; 
font-weight: bolder; 
/* 字重的精细控制 */ 
font-weight: 100; 
font-weight: 200; 
font-weight: 300; 
font-weight: 400; 
font-weight: 500; 
font-weight: 600; 
font-weight: 700; 
font-weight: 800; 
font-weight: 900;
```

