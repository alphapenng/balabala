> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.cnblogs.com](https://www.cnblogs.com/ulysessweb/p/14317519.html)

方法一：修改 font.family
==================

### 1、下载字体

下载需要的中文字体（推荐 [fontpalace](https://www.fontpalace.com)），常用字有 SimSun（宋体）、SimHei（黑体）。

### 2、安装字体

复制 ttf 字体文件（注意必须是 ttf 格式）到....../site-packages/matplotlib/mpl-data/fonts/ttf 目录下（Matplotlib 安装路径可通过 pip show matplotlib 查看）。

### 3、修改字体默认设置

#### （1）修改 Matplotlib 默认设置

通过修改 matplotlibrc 文件（....../site-packages/matplotlib/mpl-data/matplotlibrc）。在该文件中所做的修改会成为所有 Matplotlib 项目的默认设置。  
(1) 找到 font.family、font.sans-serif、axes.unicode_minus，将前面的 #删除  
(2) 在 font.sans-serif 中加入相应字体，如 SimSun  
(3) 将 axes.unicode_minus 的值从 True 改为 False，作用就是解决负号 '-' 显示问题。  
修改示例：

```
font.family: sans-serif
font.sans-serif: SimSun, DejaVu Sans, Bitstream Vera Sans, Lucida Grande, Verdana, Geneva, Lucid, Arial, Helvetica, Avant Garde, sans-serif

axes.unicode_minus : False
```

#### （2）临时修改 Matplotlib 设置

有时候仅需在部分 py 脚本中默认使用中文字体，则可以在 py 脚本中临时修改 Matplotlib 设置。  
在需要显示中文字体的 py 脚本中加入以下几行：

```
import matplotlib as mpl

mpl.rcParams['font.sans-serif'] = ['SimSun']  
mpl.rcParams['font.family']='sans-serif'
mpl.rcParams['axes.unicode_minus']=False
```

### 4、清空缓存

修改完成后需要清空 Matplotlib 缓存，即删除～/.cache/matplotlib 目录（rm -rf ~/.cache/matplotlib）。如果用的是 jupyter，需要手动重启一下 kernel。

方法二：字体属性
========

该方法使用较为灵活，可以为每个文本分别设置字体属性。

```
import matplotlib.pyplot as plt
import matplotlib.font_manager as font_manager

path = '/usr/fonts/SimSun.ttf'
zhfont = font_manager.FontProperties(fname=path)
fig, ax = plt.subplots()
ax.set_title('中文字体', fontproperties=zhfont, size=20)
```