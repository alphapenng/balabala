> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s/Od3Autp_jQjWpRi-y67Vow)

作为一名 Vue 开发者，你可能也曾纠结过：**到底应该使用 Composition API 还是继续使用 Options API 呢？** 毕竟，Vue 3 已经发布了，Composition API 也成为了官方推荐的写法。

我的答案和 Vue 官方文档的说法一致：

**除非你的项目非常小或者简单，否则请使用 Composition API 而不是 Options API。**

为什么这么说呢？这篇文章会带你深入了解 Composition API 和 Options API 的区别，帮助你做出明智的选择。

### 主要区别：Composition API 更胜一筹！

我会重点介绍三个最重要的区别：

1.  **代码组织：** 代码应该如何组织才能更清晰易懂？
    
2.  **模块化：** 如何将代码拆分成独立的功能模块？
    
3.  **可重用性：** 如何让代码可以重复使用，避免重复编写？
    

### 1. 代码组织：告别混乱，拥抱清晰

代码组织对开发至关重要，想象一下，你在一堆杂乱无章的代码中寻找某个功能，简直是噩梦！

Options API 强制你把所有计算属性放在一起，所有监听器放在一起，所有方法放在一起等等。但这并不是我们写代码的习惯！

我们通常根据**功能**来修改代码，从一个计算属性跳到一个方法，再跳到模板，然后又回到生命周期钩子。我们不会花一个小时写完所有计算属性，然后再去写所有方法。

所以，我们希望代码能够根据**功能**来组织，而不是按照 Options API 强制的结构。

**Composition API 就非常擅长这一点！** 它可以让你根据功能来组织代码，而不是按照 Options API 强制的结构。

**当然，也有一点需要注意：** Composition API 允许你自由组织代码，但也意味着你需要自己确保代码整洁。

> 程序员嘛，偶尔会偷懒，对吧？ Options API 至少能保证代码有一点组织性。 但只要你稍微自律一点，就可以在 Composition API 中保持代码整洁。 而且，我们可以通过创建可组合函数来解决这个问题，后面会详细讲解。

### 2. 模块化：代码整洁，功能独立

除了组织代码，我们还需要将代码拆分成独立的功能模块，就像把一个大房子分成不同的房间，这样才能更好地管理和维护。

**Composition API 可以轻松地创建模块，我们称之为 “可组合函数”。**

当你把相关功能的代码放在一起，并进行良好的组织之后，就可以轻松地将它们提取到可组合函数中。这些可组合函数可以是单一用途的，也可以是可重复使用的。

这样，代码就变得更加易读和易懂了。

以下是一个包含 “点赞” 按钮逻辑的组件示例：

```
import { ref, computed, onMounted } from 'vue';const likes = ref(0);onMounted(() => {  fetch('/api/post/1')    .then((response) => response.json())    .then((data) => {      likes.value = data.post.likes;    });});const sendLike = async () => {  likes.value++;  fetch('/api/post/1/likes', {    method: 'POST'  })    .catch((error) => {      likes.value--;    });};const likesAmount = computed(() => {  return likes.value + ' people have liked this';});
```

现在，我们将相关代码提取到 useLikes 可组合函数中：

```
// useLikes.jsimport { ref, computed, onMounted } from 'vue';export default function useLikes(postId) {  const likes = ref(0);  onMounted(() => {    fetch(`/api/posts/${postId}`)      .then((response) => response.json())      .then((data) => {        likes.value = data.post.likes;      });  });  const sendLike = async () => {    likes.value++;    fetch('/api/post/1/likes', {      method: 'POST'    })      .catch((error) => {        likes.value--;      });  }  return {    likes,    sendLike  }}
```

现在，我们的组件代码变得更加简洁：

```
import { computed } from 'vue';import useLikes from '@/useLikes';const {  likes,  sendLike,} = useLikes(1);const likesAmount = computed(() => {  return likes.value + ' people have liked this';});
```

你并不需要总是将可组合函数提取到单独的文件中，你也可以在组件中内联定义它们。如果你想了解更多关于可组合函数的信息，可以查看 Clean Components Toolkit 中的 21 种 Vue 设计模式。

Options API 没有很好的方法可以像这样将逻辑分解成模块。

过去，我们尝试模块化 Vue 逻辑的三种主要方法是：

*   纯 JavaScript 函数和对象
    
*   无渲染组件
    
*   混合
    

它们都有自己的缺陷，所以让我们仔细看看。

**纯 JavaScript 函数和对象** 在 Vue 项目中模块化逻辑当然很有用。这里的主要缺点是，你无法访问 Vue 的任何反应性功能，这极大地限制了你可以实际使用它来做什么。

可组合函数本质上是 JavaScript 函数，但它们具有能够访问 Vue 反应性系统的额外优势（如果它不使用 Vue 的反应性，它只是一个实用程序方法）。

**无渲染组件** 曾经非常流行，因为它们是模块化 Vue 2 逻辑的最佳方法 —— 在 Composition API 出现之前。但你实际上是在创建一个完整的组件来承载一些逻辑，因此存在很多不必要的开销。

我记得是 TailwindCSS 的 Adam Wathan 在 2018 年首次推广无渲染组件。

还存在从插槽作用域内部访问所需变量的问题：

```
<template>
  <RenderlessComponent v-slot="slotProps">
    <ChildComponent :props="slotProps" />
  </RenderlessComponent>
</template>
```

如果你在组件中存在需要使用 slotProps 中的值的逻辑，那么你就没有办法了。 要么将该逻辑推送到 ChildComponent 中，要么使用这种模板技巧，在模板中调用一个方法并将 slotProps 传递给它：

```
<template>
  <RenderlessComponent v-slot="slotProps">
    <ChildComponent :props="myMethod(slotProps)" />
  </RenderlessComponent>
</template>
```

```
const myMethod = slotProps => {  // 现在我们可以在这个方法中访问 slotProps，但这只是个方法内的操作 :/};
```

无渲染组件仍然有一些用途，但说实话，不要再做各种模板体操了 —— 即使这很有趣。

**最后，我们来说说混合 (mixins)。**

早在 2016 年，web 开发社区就已开始远离混合，这完全是合理的。

主要原因是混合会创建隐式的依赖关系，非常难以追踪。方法、计算属性和其他内容以一种不清晰且难以发现的方式添加到组件中。

当你尝试更改使用混合的组件（或更改组件中使用的混合）时，你真的无法知道会发生什么，或者你可能会破坏什么。

但是，使用可组合函数，你清楚地知道它们被用在了哪些组件中，以及如何在这些组件中使用它们。每个依赖关系都是显式的，所以你知道所有逻辑来自哪里。

在 Nuxt 3 中，自动导入依然如此。虽然导入不是显式的，但可组合函数本身的使用是显式的，这正是我们需要的。

混合的问题实际上是一个著名的被称为脆弱基类问题的问题。 真是太可惜了，我们之前没有预料到这一点。

### 3. 可重用性：让代码更灵活，更高效

最后，我们来说说可重用性。 写完并测试好一段代码后，我们希望能够重复使用它，充分发挥它的价值。

我们已经看到，使用 Composition API，我们可以使用可组合函数来创建高度可重用的逻辑块。这些可组合函数可以与 Vue 的各种反应性系统、生命周期钩子以及几乎所有 Vue 的流程进行交互。

但由于它们没有通过 this 绑定到组件实例，因此我们可以在整个项目中甚至多个项目之间共享它们。

VueUse 就是一个很好的例子。

它是一个包含数十个经过测试的、非常有用且写得很好的可组合函数的库，它们经过精心设计，确保稳定可靠。如果你还没有尝试过 VueUse，以下是一些示例：

*   useTitle 可以轻松更新页面的标题：
    

```
const title = useTitle('The Initial Title');// 反应式地更改标题title.value = 'This is a new title';
```

*   useAsyncState 允许你异步执行代码，而不会阻塞主代码，并在异步代码返回后反应式更新：
    

```
const { state: number, isLoading } = useAsyncState(fetchData());// 当数据被获取后，由于 `number` 是反应式更新的，因此此值会自动重新计算const computedValue = computed(() => number + 4);
```

*   useStorage 允许你反应式地访问 localStorage、sessionStorage 或你想要的任何其他存储提供程序：
    

```
// 从存储中读取数据，并提供一个回退值const name = useStorage('my-name', 'Default Name');// 任何更改都会与 localStorage 反应式地同步name.value = 'Michael Thiessen';
```

但是，如果你尝试使用 Options API 来实现类似的功能，那么你就没有办法了。

我们已经讲过为什么无渲染组件和混合不是很好的选择，那么你就真的没有其他选择了。你可以使用纯 JavaScript 文件，但再次提醒你，你将错过所有反应性功能。

而且，说实话，我们谈论的是让 Vue 组件和逻辑可重用，所以如果没有反应性，你真的走不了多远。

这三个主要因素 —— 代码组织、模块化和可重用性 —— 是相互关联的。你需要模块化来实现可重用性，而模块化需要良好的组织。

虽然 Options API 可以提供部分功能，但 Composition API 在这方面真正脱颖而出，这也是官方推荐使用 Composition API 的主要原因。

### 更多区别

虽然代码组织、模块化和可重用性是最重要的考虑因素，但我想指出一些其他区别。

在本节中，我们将介绍以下内容：

1.  表现力
    
2.  this 带来的问题
    
3.  TypeScript 支持
    
4.  样板代码
    
5.  处理常量（和外部资源）
    

### 1. 表现力

Composition API 比 Options API 更加细粒度，让你可以更精确地控制反应性的工作方式。

实际上，在 Vue 3 中，Options API 是使用 Composition API 构建的。它是一个抽象层，帮助简化了一些关键区域，**但这意味着你必须牺牲一些控制力和灵活性**。

有时这很好，但有时你想要额外的灵活性，这就是 Composition API 真正闪耀的地方。

### 2. this 是个大麻烦

Options API 始终需要访问 this。

如果你使用 Options API 有一段时间了，你可能也会遇到一些问题。

例如，你需要确保使用常规函数，否则你将无法访问 this：

```
methods: {  someMethod: () => {    // 糟糕，“this 未定义”    console.log(this.someComputedProp);  },  someMethod() {    // 好多了    console.log(this.someComputedProp);  }}
```

但有时，你需要使用箭头函数而不是常规函数，才能在函数上下文中保留 this：

```
methods: {  someMethod() {    const sortedArray = this.array.sort((a, b) => {      // 需要使用箭头函数才能使用 `this`      return b[this.sortProp] - a[this.sortProp];    });    // ...  }}
```

在 Composition API 中，这些烦恼都不存在了 —— 你可以根据需要编写函数，它会正常工作。

你无需考虑或担心如何访问 this。

### 3. TypeScript 支持

Vue 3 是用 TypeScript 编写的，所以与 Vue 2 相比，TypeScript 支持有了很大改进。然而，与 Options API 相比，使用 Composition API 仍然可以更好地控制类型。

使用 TS 与 Options API 需要将你的组件包装在 defineComponent 方法中，然后还需要做一些额外的工作才能正确地进行类型化。

而使用 Composition API，我们得到了对 TypeScript 惊人的支持，并且在每个新版本中不断改进。例如，泛型组件：

```
<script setup lang="ts" generic="T">  defineProps<{    items: T[]    selected: T  }>()</script>
```

generic 字段中的值与普通 TypeScript 中的 <...> 一样，所以我们在这里有完全的灵活性：

```
<script setup lang="ts" generic="T extends string | number, U extends Item">import type { Item } from './types'defineProps<{ id: T list: U[]}>()</script>
```

如果你正在用 TypeScript 编写应用，那么 Composition API 绝对是首选。

### 4. 样板代码

我相信你一定见过 Composition API 和 Options API 在样板代码方面的对比。

使用 `<script setup>` 时，这种区别会更加明显，因为我们只需要写更少的代码：

```
<script setup>import { ref } from 'vue';const number = ref(0);</script>
```

```
<script>export default { data() { return { number: 0, }; }};</script>
```

这个例子很简单，但我们减少了很多行代码。在更大的组件中，节省的代码量会更多。

根据你编写的组件不同，这些样板代码可能会成为文件的重要组成部分。但主要问题是，所有这些额外的代码都是噪音，在阅读和理解代码时，你必须过滤掉它们。

更少的样板代码让代码更容易理解和使用！

### 5. 处理常量和外部资源

如果需要在模板中渲染一个图标或 SVG 文件，该怎么办？

使用 Options API 时，你必须决定是将其作为反应式值放在 data 中，还是作为计算属性：

```
import Logo from './logo.svg';export default {  data() {    return {      logo: Logo,    };  },};
```

但 SVG 图标并不真正属于 “数据”，它也不需要是反应式的。所以，也许你可以通过计算属性将其放入模板作用域：

```
import Logo from './logo.svg';export default {  computed: {    // 使用箭头函数，因为我们不访问 `this`    logo: () => Logo,  },};
```

虽然这两种方法都有效，但它们都没有什么道理。

如果你真的想避免使其成为反应式的，还有第三种方法：

```
import Logo from './logo.svg';export default {  data() {    // 将其添加到组件实例中，而不使其成为反应式的    this.logo = Logo;    return {      // ...    };  },};
```

通过直接将该值添加到组件实例中，你可以在模板中访问它，但它不会成为反应式的。

以下是用 `<script setup>` 的更佳解决方案，它需要 Composition API：

```
import Logo from './logo.svg';
```

**是的，这就是我们真正需要做的，因为 `<script setup>` 作用域内的任何内容都在模板作用域内。**

你认为哪种方法更有道理？

Options API 的优势
---------------

如果我说 Options API 在某一方面比 Composition API 更好，我可没说谎：

**简单性。**

是的，Composition API 更强大，更灵活，而且在很多方面都更好。

**但它更复杂。它可能更难理解。**

我认为这是它最大的缺点，也是许多开发者不喜欢它的主要原因，也许是唯一的原因。我们很多从 Vue 2 开始使用 Options API 的开发者，多年来已经非常熟练，而 Composition API 是全新的，并且可能仍然很困难。

你无需处理在不同地方使用 .value 和 ref 的不一致性，你无需考虑如何组织代码 —— 你只需要写代码，然后事情就会发生。

然而，在我看来，这些额外的难度与 Composition API 带来的额外价值相比，是微不足道的。

**只需要花一些时间来习惯它。**

为什么 Composition API 比 Options API 更好？
-------------------------------------

我完全同意 Vue 官方立场，认为 Composition API 是更好的选择。

主要原因是：

*   更好的代码组织
    
*   更好的模块化
    
*   通过可组合函数实现更好的可重用性
    

Composition API 在一些不太重要的方面也更出色：

*   更强的表现力
    
*   无需处理 this 和作用域的复杂性
    
*   更好的 TypeScript 支持
    
*   更少的样板代码
    
*   处理常量和外部资源更容易
    

虽然这些区别在小型项目中也会显现出来，但随着应用程序规模和复杂程度的增加，这些区别会变得更加显著和重要。这就是文档专门为生产应用程序推荐 Composition API 的原因。

**但是，Composition API 有一个主要的缺点：它的复杂性。**

但是，我和大多数 Vue 社区成员都认为，这种微不足道的复杂性增加，完全值得它带来的所有好处。

只需要花一些时间和精力来适应它。

**最后，别忘了还有更多精彩内容等你探索！**

* * *

**往期推荐**  

[38 个 Vue、Nuxt 和 Vite 技巧、窍门和实践的合集](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650105474&idx=2&sn=6cee0a947289b9c1f856e0f3a1412b13&chksm=83dbfbe7b4ac72f1cd2b42e64db8321cfd767df5165d6316e3a5c6a537702bf194db9c53d9c5&scene=21#wechat_redirect)  

[10 个 必备的 JavaScript 实用技巧和最佳实践！](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650106089&idx=1&sn=1fb7f2b9fd697a54aa57b5c18e1c7a7d&chksm=83dbf58cb4ac7c9a8100142f08c08705a0d4f968346416b16b7f4b8deda34893ee5ab6087507&scene=21#wechat_redirect)  

[2024 年 10 个很实用的 CSS 新特性，你不一定知道！](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650106051&idx=1&sn=991587c0863a2206ccf56ba63cb79c46&chksm=83dbf5a6b4ac7cb0c64d74c2b6a92f71d3b81d2ba81b31ef846dd80a3cc22195af92636c34c8&scene=21#wechat_redirect)  

[10 个 React 开发避坑指南](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650105995&idx=1&sn=7325a906f2bced7bed7f76838ede41d6&chksm=83dbf5eeb4ac7cf8d4e18b1b014c98cb8a0e2dfbf10cd55078fc7b147ecbcaf6bd7227b4ea15&scene=21#wechat_redirect)  

[12 种 Vue 设计模式](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650105965&idx=1&sn=b43f99b929647c756079744383772606&chksm=83dbf508b4ac7c1eba1dd4ca244e02b0156b94ebe5f13ce44b8e8f51a7a1f428c47198103ab4&scene=21#wechat_redirect)  

[CSS 秘密武器：25 个小技巧，助你写出更优雅的代码！](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650105932&idx=2&sn=36a4b877f09a975bcb6086838ef727b9&chksm=83dbf529b4ac7c3fc8d6e6b2a6e85713cc97aef04cbde86943896bb6046900eec2b79ad4ef28&scene=21#wechat_redirect)  

[JavaScript 的新技能：5 大技巧，打造更强大的 Web 应用](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650105874&idx=1&sn=4bf345474addd373c52fc5f41acdf7cb&chksm=83dbf577b4ac7c6134c67f326b239f6f7b200db25f721a9a8aac3d37b0fbfd13c3934629e3e5&scene=21#wechat_redirect)

[程序员必备：9 个超赞的速查表网站，2024 年开发效率翻倍！](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650105861&idx=1&sn=788796b55bd065129f01be62f43770e3&chksm=83dbf560b4ac7c76d3386f9012ac2fa1a1f449cc215aa98885c5cc654b8ad54cdf1f04bac6d3&scene=21#wechat_redirect)

[Vue 3 将推出新特性，可以抛弃虚拟 DOM 了！](http://mp.weixin.qq.com/s?__biz=MzAxODE4MTEzMA==&mid=2650105142&idx=1&sn=e58fe75374c171c32f3d9a94f914b075&chksm=83dbf853b4ac7145a3f1d9e3afaac89970217ca1688943798d313fa124310db7681482235264&scene=21#wechat_redirect)

我是前端宝哥，每日分享前端开发技术，关注下面二维码，围观我的朋友圈。

![](https://mmbiz.qpic.cn/sz_mmbiz_png/HLN2IKtpicicFHfZ75G4Tx1P92ugQGdodm4h4WIXQurbVIibaExv01dLZCLpXsUJAoU9Z5cKmHWqzGibE1tB3xTXicg/640?wx_fmt=other&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1&tp=webp)

关注下方公众号加星标，送我的电子书资料

*   回复「小抄」，领取 Vue、JavaScript 和 WebComponent 小抄 PDF
    
*   回复「Vue 脑图」获取 Vue 相关脑图
    
*   回复「思维图」获取 JavaScript 相关思维图
    
*   回复「简历」获取简历制作建议
    
*   回复「简历模板」获取精选的简历模板
    
*   回复「电子书」下载我整理的大量前端资源，含面试、Vue 实战项目、CSS 和 JavaScript 电子书等。
    
*   回复「知识点」下载高清 JavaScript 知识点图谱
    
*   回复「读书」下载成长的相关电子书
    

![](https://mmbiz.qpic.cn/mmbiz_png/HLN2IKtpicicHpYacCBKecStRrLlokLQtv98CfjVfDlny8EYwrVyibhCdIkwF8UwWwgQYWN7mno5x6QnUwj9eKgoA/640?wx_fmt=other&wxfrom=5&wx_lazy=1&wx_co=1&tp=webp)

**PS：感谢您读到这里。原创更文不易，请关注我，加个星标。文章末尾点赞 + 分享，您的认同，将是我前行的最大动力！**