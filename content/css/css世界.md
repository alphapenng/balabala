<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2024-06-08 22:16:37
 * @LastEditors: alphapenng
 * @LastEditTime: 2024-07-04 16:54:58
 * @FilePath: /balabala/content/css/css世界.md
-->
# css 世界 notes

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

