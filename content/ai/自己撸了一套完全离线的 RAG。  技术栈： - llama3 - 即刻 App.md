> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [m.okjike.com](https://m.okjike.com/originalPosts/66559c0b348420a2ad32efde)

> 即刻 App，享受探索、表达和创造

自己撸了一套完全离线的 RAG。

技术栈：  
- llama3 替代 OpenAI  
- nextjs 做 UI 和 api  
- postgresql pgvector 做存储

中间碰到一些坑，第一个国内开发就是网络的坑，大部分框架默认自带就是 OpenAI 的服务，但是被墙，有的框架写的太死，都不好配置代理...

第二个坑，OpenAI 默认向量纬度是 1536，但是 llama3 是 4096，得手动搞一下数据库，它默认创建的时候是 1536。

还有很多配置因为 ts llamaindex 可能太小众了，配置啥都没有，我得去读一下源码...

学习和参考了 [@艾逗笔](https://m.okjike.com/users/35224A78-8B11-469E-B307-16B58688FBEC) 的两个项目，感谢！

[github.com](https://github.com/all-in-aigc/gpts-works)  
[github.com](https://github.com/thinkany-ai/rag-search)

[github.com](https://github.com/langchain-ai/langchain-nextjs-template) 这个项目是用 langchain 来写的，不过可以学习一下他的输出 prompt，以及 RAG 的写法。

总的来说要自己搞一下，该踩的坑还得得躺。

来自圈子
----

[![](https://cdnv2.ruguoapp.com/Ftblo4H7hiyVYfZ4XLd3mP2ktJqyv3.jpg?imageMogr2/auto-orient/heic-exif/1/format/jpeg/thumbnail/120x120%3E)](https://m.okjike.com/topics/63579abb6724cc583b9bba9a)

热门评论
----

*   我最近也在做离线 RAG，用的 llamaindex+qdrant。模型试了一圈 Yi 1.5 的中文效果非常好，embedding 和 reranker 模型用的都是智源的
    
*   EasyPlux: Retrieval-Augmented Generation
    

查看更多 25 条评论