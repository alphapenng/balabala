> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [mp.weixin.qq.com](https://mp.weixin.qq.com/s?__biz=MzA3Njc1MDU0OQ==&mid=2650933081&idx=1&sn=ecc5f0f770ed8327f93a4c2b3c4e6f39&chksm=84aa2ce3b3dda5f5b51ece2b5777af7ae087936c0d39136b18419310ea93d0c7f619ecb900c6&cur_album_id=2209804829378543621&scene=189#wechat_redirect)

我们使用简单的开发工具 aardio ，体积只有几 MB，下载打开就可以编程了，不需要任何复杂的配置。  

**▶ 入门示例**
==========

使用 aardio 新建一个源码文件：  

======================

![](https://mmbiz.qpic.cn/sz_mmbiz_gif/8Bia8Vd22gBPhCyxp1n3ugEXlsMoorffKMgCTrRvaIzQ1ia8EysyND3jZRQuc8iajic4YoXekSzQO4mcu4s8OSkRicg/640?wx_fmt=gif)

输入以下代码，点击**「运行」**按钮合成并播放乐曲：

```
//钢琴
0 大钢琴（声学钢琴）
1 明亮的钢琴
2 电钢琴
3 酒吧钢琴
4 柔和的电钢琴
5 加合唱效果的电钢琴
6 羽管键琴（拨弦古钢琴）
7 科拉维科特琴（击弦古钢琴）

//色彩打击乐器
8 钢片琴
9 钟琴
10 八音盒
11 颤音琴
12 马林巴
13 木琴
14 管钟
15 大扬琴

//风琴
16 击杆风琴
17 打击式风琴
18 摇滚风琴
19 教堂风琴
20 簧管风琴
21 手风琴
22 口琴
23 探戈手风琴

//吉他
24 尼龙弦吉他
25 钢弦吉他
26 爵士电吉他
27 清音电吉他
28 闷音电吉他
29 加驱动效果的电吉他
30 加失真效果的电吉他
31 吉他和音

//贝司
32 大贝司（声学贝司）
33 电贝司（指弹）
34 电贝司（拨片）
35 无品贝司
36 掌击1
37 掌击2
38 电子合成1
39 电子合成2

//弦乐
40 小提琴
41 中提琴
42 大提琴
43 低音大提琴
44 弦乐群颤音音色
45 弦乐群拨弦音色
46 竖琴
47 定音鼓

//合奏/合唱
48 弦乐合奏音色1
49 弦乐合奏音色2
50 合成弦乐合奏音色1
51 合成弦乐合奏音色2
52 人声合唱“啊”
53 人声“嘟”
54 合成人声
55 管弦乐敲击齐奏

//铜管
56 小号
57 长号
58 大号
59 加弱音器小号
60 法国号（圆号）
61 铜管组（铜管乐器合奏音色）
62 合成铜管音色1
63 合成铜管音色2

//簧管
64 高音萨克斯风
65 次中音萨克斯风
66 中音萨克斯风
67 低音萨克斯风
68 双簧管
69 英国管
70 巴松（大管）
71 单簧管（黑管）

//笛
72 短笛
73 长笛
74 竖笛
75 排箫
76 Bottle Blow
77 日本尺八
78 口哨声
79 奥卡雷那

//合成主音
80 合成主音1（方波）
81 合成主音2（锯齿波）
82 合成主音3
83 合成主音4
84 合成主音5
85 合成主音6（人声）
86 合成主音7（平行五度）
87 +合成主音8（贝司加主音）

//合成音色
88 合成音色1（新世纪）
89 合成音色2（温暖）
90 合成音色3
91 合成音色4（合唱）
92 合成音色5
93 合成音色6（金属声）
94 合成音色7（光环）
95 合成音色8

//合成效果
96 雨声
97 音轨
98 水晶
99 大气
100 明亮
101 鬼怪
102 回声
103 科幻

//民间乐器
104 西塔尔（印度）
105 班卓琴（美洲）
106 三昧线（日本）
107 十三弦筝（日本）
108 卡林巴
109 风笛
110 民族提琴
111 山奈

//打击乐器
112 叮当铃
113 Agogo 钟
114 钢鼓
115 木鱼
116 太鼓
117 通通鼓
118 合成鼓
119 铜钹

//声音效果
120 吉他换把杂音
121 呼吸声
122 海浪声
123 鸟鸣
124 电话铃
125 直升机
126 鼓掌声
127 Q 声
```

**▶ 编程记谱规则  
**  
上面的编程记谱法基于简谱记号设计。
===================================

中音使用简谱记号：  

============

```
"1,2,3,4,5,6,7"
```

  
高音在后面加一个单引号：

```
"1',2',3',4',5',6',7'"
```

  
低音在音符前面加一个单引号：

```
"'1,'2,'3,'4,'5,'6,'7"
```

  
所有音符以逗号分开，忽略空格、制表符、换行等。  

前面加负号表示消音（停止演奏指定音符），例如：

```
"-5,-'5"
```

  
用下划线表示一个延时单位（默认为 250 毫秒 ），前面的音符（或下划线）与后面的下划线可以连起来写，例如：

```
"5___,5___"
```

  
记谱时可以直接调用 midiOut 的成员函数，函数名后必须有括号 () 且必须有参数，例如：

```
"pitchBend(0.6),1__,2__,3__"
```

  
pitchBend 函数用于弯音，参数为表示百分比的小数，0 ~ 0.5 为向下弯音，0.5 ~  1 为向上弯音。更多可用函数请参考库函数文档。

其他数值表示延时，其他字符串表示字幕。

下面是一个小例子：

```
import sys.midiOut;
var midiOut = sys.midiOut(); 

//播放简谱
midiOut.play("
1,150,
pitchBend(0.6), 弯音,
500, 延时 500 毫秒,
-1,停（音符前加负号表示消音）
");  
```

**▶ 转换简谱为程序代码**
===============

  
我们学习一下怎么翻译简谱，先找个简谱：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOkUAUkj2YAQkicKaLiaaxzgravggXXazNib8egj05Fhwlayz5YUsUTrsvrZp7XbOpf7l0JlpJBfMt1A/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

4/4 表示以四分音符为一拍，每小节有 4 拍。那么我们用 2 个下划线表示一拍（也就是 500 毫秒 ），那么 上面的 

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOkUAUkj2YAQkicKaLiaaxzgrgfddice3szIwCjfRmibvVF5m2Gdvtc3HSMVerroIfd6GialucOLATpd8A/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

我们翻译为代码：

```
1__,2__,3__,1__,
```

  
再看下面的简谱：

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOkUAUkj2YAQkicKaLiaaxzgrOYG64KY6icU4J4yYIkZiaSsPXiaul6sCPE2J29ibZEhzkQ5iabln2Ssic1Kg/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

这上面的短横线为增时线，表示增加一拍（这里是 500 毫秒，代码里就是增加 2 个下划线 ），所以上面的简谱翻译为代码就是：

```
3__,4__,5__,__,
```

  
然后我们再看简谱：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBOkUAUkj2YAQkicKaLiaaxzgrdH1Cib0ndpUO9UKBHdzRPaHeKqey6fMveRT9oCfO5SH4YjVkTiaZfZ7Q/640?wx_fmt=png&wxfrom=5&wx_lazy=1&wx_co=1)

音符下面的横线是减时线，也就是由一拍减为半拍（这里是 250 毫秒，代码里用一个下划线表示），所以上面的简谱翻译为代码就是：

```
5_,6_,5_,4_,3__,1__,
```

  
最后生成完整源代码如下：

```
import sys.midiOut;

//打开播放设备
var midiOut = sys.midiOut(); 

//播放简谱
midiOut.play("
    1__,2__,3__,1__, 
    1__,2__,3__,1__, 
    3__,4__,5__,__,
    3__,4__,5__,__,
    5_,6_,5_,4_,3__,1__,
    5_,6_,5_,4_,3__,1__, 
    2__,'5__,1__,__

");  
```

  
要特别注意上面有一个低音 '5，音符前面加个单引号表示低音。  

**▶ 自定义音高、拍子快慢  
**
===================

midiOut.play 函数可选用第 2 个参数指定音符 1 对应的 SPN 音名（ 可用音名在 sys.midiOut.notes 名字空间定义 ），默认值为 "C4"。可选用第 3 个参数指定单个下划线对应的延时单位（默认为 250 毫秒 ）

我们将上面示例的音符 1 改为 "E4" （其他数字音符会自动调整音高），一个延时单位改为 125 毫秒（加快一倍），代码如下：

```
import sys.midiOut;

//打开播放设备
var midiOut = sys.midiOut(); 

//播放简谱
midiOut.play("
    两只老虎,
    1__,2__,3__,1__, 
    两只老虎,
    1__,2__,3__,1__, 
    跑得快,
    3__,4__,5__,__,
    跑得快,
    3__,4__,5__,__,
    一只没有耳朵,
    5_,6_,5_,4_,3__,1__,
    一只没有尾巴,
    5_,6_,5_,4_,3__,1__, 
    真奇怪,
    2__,'5__,1__,__
","E4",125);  
```

  
请运行一下，听一听有什么区别。

**▶ 绘制桌面歌词**
============

下面我们再小小改进一下，播放音乐时在桌面上显示漂亮的歌词。

源码如下：  

```
//创建桌面歌词窗口
import win.util.lyric;
var lyric = win.util.lyric();
lyric.show();

//打开播放设备
import sys.midiOut;
var midiOut = sys.midiOut(); 

//定义显示歌词的函数
midiOut.log = function(str){
    lyric.text = str; 
}

//播放简谱
midiOut.play("
    两只老虎,
    1__,2__,3__,1__, 
    两只老虎,
    1__,2__,3__,1__, 
    跑得快,
    3__,4__,5__,__,
    跑得快,
    3__,4__,5__,__,
    一只没有耳朵,
    5_,6_,5_,4_,3__,1__,
    一只没有尾巴,
    5_,6_,5_,4_,3__,1__, 
    真奇怪,
    2__,'5__,1__,__
");  
```

  
按「运行」按钮，显示效果如下：  

![](https://mmbiz.qpic.cn/sz_mmbiz_png/8Bia8Vd22gBPhCyxp1n3ugEXlsMoorffKGNqy2p2UBpictLibTX0INpgmApPqGiaeeZSxI2U6DkR8q4QGmmJjnb3SQ/640?wx_fmt=png)

**▶ 多线程**
=========

下面创建独立线程合成并播放音乐，源码：

```
//合成并输出音乐
import win.util.lyric;
var lyric = win.util.lyric();
lyric.show();

//创建独立线程
thread.invoke( function(lyric){
    import sys.midiOut;
    var midiOut = sys.midiOut();
        
    //指定字幕回显函数
    midiOut.log = function(v) lyric.text = v;
    
    midiOut.play("
        两只老虎,
        1__,2__,3__,1__, 
        两只老虎,
        1__,2__,3__,1__, 
        跑得快,
        3__,4__,5__,__,
        跑得快,
        3__,4__,5__,__,
        一只没有耳朵,
        5_,6_,5_,4_,3__,1__,
        一只没有尾巴,
        5_,6_,5_,4_,3__,1__, 
        真奇怪,
        2__,'5__,1__,__
    ");  

    lyric.close();
},lyric);

win.loopMessage();
```

**▶ 使用 SPN 音名记谱**
=================

  
编程记谱时可使用 sys.midiOut.notes 名字空间指定的所有音名，这些音名使用科学音高记号（Scientific pitch notation）。

音名与音符的对应关系如下：

<table><tbody><tr><td data-colwidth="72"><p data-track="16">音名</p></td><td data-colwidth="88" width="60"><p data-track="17">唱名</p></td><td data-colwidth="65" width="80"><p data-track="18">简谱</p></td></tr><tr><td data-colwidth="72"><p data-track="19">&nbsp;C4</p></td><td data-colwidth="88" width="146"><p data-track="27">&nbsp;do</p></td><td data-colwidth="65" width="63"><p data-track="40">&nbsp;1</p></td></tr><tr><td data-colwidth="72"><p data-track="20">&nbsp;D4</p></td><td data-colwidth="88" width="60"><p data-track="29">&nbsp;re</p></td><td data-colwidth="65" width="63"><p data-track="41">&nbsp;2</p></td></tr><tr><td data-colwidth="72"><p data-track="21">&nbsp;E4</p></td><td data-colwidth="88" width="60"><p data-track="31">&nbsp;mi</p></td><td data-colwidth="65" width="63"><p data-track="42">&nbsp;3</p></td></tr><tr><td data-colwidth="72"><p data-track="22">&nbsp;F4</p></td><td data-colwidth="88" width="60"><p data-track="33">&nbsp;fa</p></td><td data-colwidth="65" width="63"><p data-track="43">&nbsp;4</p></td></tr><tr><td data-colwidth="72"><p data-track="23">&nbsp;G4</p></td><td data-colwidth="88" width="60"><p data-track="35">&nbsp;sol</p></td><td data-colwidth="65" width="63"><p data-track="44">&nbsp;5</p></td></tr><tr><td data-colwidth="72"><p data-track="24">&nbsp;A4</p></td><td data-colwidth="88" width="60"><p data-track="37">&nbsp;la</p></td><td data-colwidth="65" width="63"><p data-track="45">&nbsp;6</p></td></tr><tr><td data-colwidth="72"><p data-track="25">&nbsp;B4</p></td><td data-colwidth="88" width="60"><p data-track="39">&nbsp;ti （si,xi）</p></td><td data-colwidth="65" width="63"><p data-track="46">&nbsp;7</p></td></tr></tbody></table>

当然音名与唱名的对应关系可以变更，这里先不用管这些。音名后面的数值越大表示越高的音，例如 C4（ 中央 C ，简谱中的 1 ） 高八度就是 C5（ 高音 do，简谱 1 上面加一点），低八度的音就是 C3 （ 低音 do，简谱 1 下面加一点）。

注意：

*   SPN 音名中的 -1 省略
    
*   SPN 音名中的升号 ♯（Sharp） 用小写 s 替代
    

  
例如：C-1♯ 略写为 Cs 。

示例：  

```
import sys.midiOut;
var midiOut = sys.midiOut();

midiOut.play(" 
    C4,_,_,D4,_,_,E4,_,_,C4,_,_, 
    C4,_,_,D4,_,_,E4,_,_,C4,_,_, 
    E4,_,_,F4,_,_,G4,_,_,_,_, 
    E4,_,_,F4,_,_,G4,_,_,_,_, 
    G4,_,A4,_,G4,_,F4,_,E4,_,_,C4,_,_, 
    G4,_,A4,_,G4,_,F4,_,E4,_,_,C4,_,_, 
    D4,_,_,G3,_, _,C4,
    1000
");  
```

  
也可以这样写：

```
import sys.midiOut;

//打开音名空间
namespace sys.midiOut.notes{ 
    
    //记谱（这里下划线与音符不能连起来，也不能使用数字音符）
    drm = {
        "两只老虎",
        C4,_,_,D4,_,_,E4,_,_,C4,_,_,
        "两只老虎",
        C4,_,_,D4,_,_,E4,_,_,C4,_,_,
        "跑得快",
        E4,_,_,F4,_,_,G4,_,_,_,_,
        "跑得快",
        E4,_,_,F4,_,_,G4,_,_,_,_,
        "一只没有耳朵",
        G4,_,A4,_,G4,_,F4,_,E4,_,_,C4,_,_,
        "一只没有尾巴",
        G4,_,A4,_,G4,_,F4,_,E4,_,_,C4,_,_,
        "真奇怪",
        D4,_,_,G3,_, _,C4,
        //用下面的方式调用函数，小于等于 127 的延时必须调用 delay 函数
        {"delay",1000} 
    } 
}

var midiOut = sys.midiOut();
midiOut.play( sys.midiOut.notes.drm );  
```

**  
▶ 切换乐器**
=============

  
我们还可以选择不同的乐器，代码示例：

```
import sys.midiOut;
var midiOut = sys.midiOut(); 

//选择八音盒，参数为乐器编号
midiOut.changeInstrument(10);
```

  
在谱子中也可以切换乐器，例如：

```
import sys.midiOut;
var midiOut = sys.midiOut();

midiOut.play( "
changeInstrument(10),
1___,
2___,
3___,
" );  
```

  
可用的乐器编号为 0~127 范围的数值，全部编号如下：

```
//钢琴
0 大钢琴（声学钢琴）
1 明亮的钢琴
2 电钢琴
3 酒吧钢琴
4 柔和的电钢琴
5 加合唱效果的电钢琴
6 羽管键琴（拨弦古钢琴）
7 科拉维科特琴（击弦古钢琴）
//色彩打击乐器
8 钢片琴
9 钟琴
10 八音盒
11 颤音琴
12 马林巴
13 木琴
14 管钟
15 大扬琴
//风琴
16 击杆风琴
17 打击式风琴
18 摇滚风琴
19 教堂风琴
20 簧管风琴
21 手风琴
22 口琴
23 探戈手风琴
//吉他
24 尼龙弦吉他
25 钢弦吉他
26 爵士电吉他
27 清音电吉他
28 闷音电吉他
29 加驱动效果的电吉他
30 加失真效果的电吉他
31 吉他和音
//贝司
32 大贝司（声学贝司）
33 电贝司（指弹）
34 电贝司（拨片）
35 无品贝司
36 掌击1
37 掌击2
38 电子合成1
39 电子合成2
//弦乐
40 小提琴
41 中提琴
42 大提琴
43 低音大提琴
44 弦乐群颤音音色
45 弦乐群拨弦音色
46 竖琴
47 定音鼓
//合奏/合唱
48 弦乐合奏音色1
49 弦乐合奏音色2
50 合成弦乐合奏音色1
51 合成弦乐合奏音色2
52 人声合唱“啊”
53 人声“嘟”
54 合成人声
55 管弦乐敲击齐奏
//铜管
56 小号
57 长号
58 大号
59 加弱音器小号
60 法国号（圆号）
61 铜管组（铜管乐器合奏音色）
62 合成铜管音色1
63 合成铜管音色2
//簧管
64 高音萨克斯风
65 次中音萨克斯风
66 中音萨克斯风
67 低音萨克斯风
68 双簧管
69 英国管
70 巴松（大管）
71 单簧管（黑管）
//笛
72 短笛
73 长笛
74 竖笛
75 排箫
76 Bottle Blow
77 日本尺八
78 口哨声
79 奥卡雷那
//合成主音
80 合成主音1（方波）
81 合成主音2（锯齿波）
82 合成主音3
83 合成主音4
84 合成主音5
85 合成主音6（人声）
86 合成主音7（平行五度）
87 +合成主音8（贝司加主音）
//合成音色
88 合成音色1（新世纪）
89 合成音色2（温暖）
90 合成音色3
91 合成音色4（合唱）
92 合成音色5
93 合成音色6（金属声）
94 合成音色7（光环）
95 合成音色8
//合成效果
96 雨声
97 音轨
98 水晶
99 大气
100 明亮
101 鬼怪
102 回声
103 科幻
//民间乐器
104 西塔尔（印度）
105 班卓琴（美洲）
106 三昧线（日本）
107 十三弦筝（日本）
108 卡林巴
109 风笛
110 民族提琴
111 山奈
//打击乐器
112 叮当铃
113 Agogo 钟
114 钢鼓
115 木鱼
116 太鼓
117 通通鼓
118 合成鼓
119 铜钹
//声音效果
120 吉他换把杂音
121 呼吸声
122 海浪声
123 鸟鸣
124 电话铃
125 直升机
126 鼓掌声
127 Q 声
```