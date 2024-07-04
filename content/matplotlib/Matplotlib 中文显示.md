> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.runoob.com](https://www.runoob.com/matplotlib/matplotlib-zh.html) [Matplotlib imread () 方法](https://www.runoob.com/matplotlib/matplotlib-imread.html "Matplotlib imread() 方法") [Seaborn 教程](https://www.runoob.com/matplotlib/seaborn-tutorial.html "Seaborn 教程")

Matplotlib 中文显示不是特别友好，要在 Matplotlib 中显示中文，我们可以通过两个方法：

*   设置 Matplotlib 的字体参数。
*   下载使用支持中文的字体库。

在未设置字体，默认情况显示如下，中文部分不能正常显示：

![](https://www.runoob.com/wp-content/uploads/2023/12/fad4973c29ae7f9ec1570a1989340c97.png)

Matplotlib 的字体参数
----------------

我们可以先获取系统的字体库列表：

```
from matplotlib import pyplot as plt
import matplotlib
a=sorted([f.name for f in matplotlib.font_manager.fontManager.ttflist])

for i in a:
    print(i)
```

输出结果类似如下：

```
...
Heiti TC
Helvetica
Helvetica Neue
Herculanum
Hiragino Maru Gothic Pro
Hiragino Mincho ProN
Hiragino Sans
Hiragino Sans GB
Hoefler Text
...
```

以上代码输出 font_manager 的 ttflist 中所有注册的名字，找一个看中文字体例如：STFangsong (仿宋）、Heiti TC（黑体）, 然后添加以下代码即可。

**对于 Windows：**

```
plt.rcParams['font.family'] = 'SimHei'  # 替换为你选择的字体
```

在 Windows 系统上，选择 SimHei（黑体）或其他中文字体，并将其设置为 Matplotlib 的默认字体。

**对于 Linux：**

```
plt.rcParams['font.family'] = 'WenQuanYi Micro Hei'  # 替换为你选择的字体
```

在 Linux 系统上，使用 fc-list 命令查看已安装的字体，选择一个中文字体，并将其设置为 Matplotlib 的默认字体。

**对于 macOS：**

```
plt.rcParams['font.family'] = 'Heiti TC'  # 替换为你选择的字体
```

通过设置 `plt.rcParams['font.family']`，你告诉 Matplotlib 使用选择的字体来渲染文本，从而在图表中正确显示中文。

这样，你就能够在 Matplotlib 图表中使用系统支持的中文字体了。

```
import matplotlib.pyplot as plt

plt.rcParams['font.family'] = 'Heiti TC'  # 替换为你选择的字体

# 创建数据
x = [1, 2, 3, 4, 5]
y = [2, 4, 6, 8, 10]

# 绘制折线图
plt.plot(x, y)

# 添加标题和标签
plt.title(' 折线图示例')
plt.xlabel('X 轴')
plt.ylabel('Y 轴')

# 显示图形
plt.show()
```

这样中文就可以正常显示了，显示如下：

![](https://www.runoob.com/wp-content/uploads/2023/12/e1105655de58ea37c9f579028ca22ad0.png)

使用字体库
-----

Matplotlib 默认情况不支持中文，我们可以使用以下简单的方法来解决。

这里我们使用思源黑体，思源黑体是 Adobe 与 Google 推出的一款开源字体。

官网：[https://source.typekit.com/source-han-serif/cn/](https://source.typekit.com/source-han-serif/cn/)

GitHub 地址：[https://github.com/adobe-fonts/source-han-sans/tree/release/OTF/SimplifiedChinese](https://github.com/adobe-fonts/source-han-sans/tree/release/OTF/SimplifiedChinese)

打开链接后，在里面选一个就好了：

![](https://www.runoob.com/wp-content/uploads/2020/07/134652C4-1164-466B-ACA2-ECE8B7E6F2AF.jpg)

你也可以在网盘下载: [https://pan.baidu.com/s/10-w1JbXZSnx3Tm6uGpPGOw](https://pan.baidu.com/s/10-w1JbXZSnx3Tm6uGpPGOw)，提取码：`yxqu`。

可以下载个 OTF 字体，比如 SourceHanSansSC-Bold.otf，将该文件文件放在当前执行的代码文件中：

SourceHanSansSC-Bold.otf 文件放在当前执行的代码文件中：

```
import numpy as np 
from matplotlib import pyplot as plt 
import matplotlib
 
# fname 为 你下载的字体库路径，注意 SourceHanSansSC-Bold.otf 字体的路径
 zhfont1 = matplotlib.font_manager.FontProperties(f) 
 
x = np.arange(1,11) 
y =  2  * x +  5 
plt.title(" 菜鸟教程 - 测试 ", fontproperties=zhfont1) 
 
# fontproperties 设置中文显示，fontsize 设置字体大小
 plt.xlabel("x 轴 ", fontproperties=zhfont1)
plt.ylabel("y 轴 ", fontproperties=zhfont1)
plt.plot(x,y) 
plt.show()
```

执行输出结果如下图：

![](https://www.runoob.com/wp-content/uploads/2018/10/246E0137-BFFA-40D1-B6E1-8D4A2789B12F.jpg)