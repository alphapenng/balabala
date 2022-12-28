<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2022-01-14 06:18:56
 * @LastEditors: alphapenng
 * @LastEditTime: 2022-12-28 14:02:48
 * @FilePath: /balabala/content/private/【啥是剪辑】Pr基础快捷键.md
-->

# 【啥是剪辑】Pr基础快捷键

[toc]

* 工具
  * 选择工具 A
  * 剃刀工具 B
  * 速率伸缩工具 D
* 应用
  * 编辑
    * 撤销 Ctrl+Z
    * 重做 Shift+Ctrl+Z
    * 清除 Backspace
  * 序列
    * 应用剃刀于当前时间标示点 C
    * 放大 H
    * 缩小 G
  * 素材
    * 速度/持续时间 Ctrl+J
    * 设置标记 M
    * 打开或者关闭当前音频、视频 Ctrl+B
    * 应用默认视频过渡到选择项 Ctrl+T
    * 应用默认音频过渡到选择项 Ctrl+Alt+T
    * 复制素材到其他轨道 Alt+鼠标推拽
    * 清除入点和出点 Alt+X
* 字体
  * 思源黑体Normal 字号60
* 导出视频
  * 文件→导出→媒体 Ctrl+M
  * 导出设置
    * 格式 H.264
    * 视频
      * 1920x1080
      * 帧速率 25
      * 场序 逐行
      * 长宽比 方形像素
      * 性能 硬件加速
      * 配置文件 高
      * 级别 5.1
      * 比特率编码 VBR
      * 目标比特率 5.9（B站） 10/12（商业）
    * 音频
      * 格式 AAC
      * 编码 AAC
      * 频率 44.1kHz
      * 声道 立体声
      * 音频质量 高
      * 比特率 320
    * 使用最高渲染质量
* 代理
  * DaVinci转码
    * 素材放入媒体池→剪辑面板中再拖到时间线→deliver面板中导出编解码器选择『Apple ProRes（Windows选择DNxHD）』类型选择『Apple ProRes 422 Proxy』
* Pr和DaVinci交互
  * Pr导出： 文件→导出→Final Cut Pro XML...
  * DaVinci导入：
    * 素材导入： 导入原始素材（非代理素材）
    * 时间线导入： 文件→导入时间线→导入AAF、EDL、XML...→在弹出的菜单中取消『自动将源片段导入媒体池』的对勾
    * deliver窗口导出
  * 回批：把调完色的素材再返回到剪辑软件中
