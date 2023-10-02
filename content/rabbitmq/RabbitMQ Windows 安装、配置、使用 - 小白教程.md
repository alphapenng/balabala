> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [developer.aliyun.com](https://developer.aliyun.com/article/1134566)

> RabbitMQ Windows 安装、配置、使用 - 小白教程

1、配套文件

下载 erlang：[http://www.erlang.org/downloads/](http://www.erlang.org/downloads/)

下载 RabbitMQ：[http://www.rabbitmq.com/download.html](http://www.rabbitmq.com/download.html)

![](https://ucc.alicdn.com/images/user-upload-01/20181117194803563.png)

2、RabbitMQ 服务端代码是使用并发式语言 Erlang 编写的，安装 Rabbit MQ 的前提是安装 Erlang，双击 otp\_win64\_21.1.exe 直接安装，选择默认配置即可，如果不安装 Erlang 或安装错误而直接安装 RabbitMQ 会弹出如下错误提示；

![](https://ucc.alicdn.com/images/user-upload-01/20181117194827381.png)

![](https://ucc.alicdn.com/images/user-upload-01/20181117194847512.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

![](https://ucc.alicdn.com/images/user-upload-01/20181117194907546.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

![](https://ucc.alicdn.com/images/user-upload-01/20181117194917475.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

![](https://ucc.alicdn.com/images/user-upload-01/20181117194927600.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

3、设置 Erlang 的环境变量和 path 路径

默认情况下安装程序会生成一个系统环境变量，如果没有生成就自己添加一个

![](https://ucc.alicdn.com/images/user-upload-01/20181117194954392.png)

添加到 Path 中，

![](https://ucc.alicdn.com/images/user-upload-01/20181117195104407.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

配置好之后，打开 CMD，输入 erl 然后回车键，会弹出版本信息，表示 Erlang 安装成功。

![](https://ucc.alicdn.com/images/user-upload-01/20181117195127146.png)

4、安装 RabbitMQ

直接双击 rabbitmq-server-3.7.8.exe 进行安装，选择默认配置即可

![](https://ucc.alicdn.com/images/user-upload-01/20181117195152332.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

![](https://ucc.alicdn.com/images/user-upload-01/20181117195200782.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

![](https://ucc.alicdn.com/images/user-upload-01/20181117195209500.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

![](https://ucc.alicdn.com/images/user-upload-01/20181117195219951.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

5、安装 Web 网页管理插件 RabbitMQ-Plugins

安装 RabbitMQ-Plugins，这个相当于是一个管理界面，方便我们在浏览器界面查看 RabbitMQ 各个消息队列以及 exchange 的工作情况。程序安装好之后默认情况下服务是开启的，这一点可以打开 Windows 的服务界面查看，

![](https://ucc.alicdn.com/images/user-upload-01/20181117195242945.png)

打开开始菜单，选择 RabbitMQ Server->RabbitMQ Service-stop 命令，停止服务

![](https://ucc.alicdn.com/images/user-upload-01/20181117195303614.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

此时再次打开 Windows 的服务管理界面，可以看见 RabbitMQ 服务已停止，

![](https://ucc.alicdn.com/images/user-upload-01/2018111719532259.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

然后打开 CMD 窗口，切换到 RabbitMQ 安装路径的 sbin 目录下，

![](https://ucc.alicdn.com/images/user-upload-01/20181117195338203.png)

输入指令：“rabbitmq-plugins enable rabbitmq\_management”

![](https://ucc.alicdn.com/images/user-upload-01/20181117195357345.png)

安装完 rabbitmq 插件，开启服务，打开开始菜单，RabbitMQ Server->RabbitMQ Service-start 开启服务，

![](https://ucc.alicdn.com/images/user-upload-01/20181117195415540.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

成功开启服务之后，同样打开服务管理界面，查看是否已开启服务

![](https://ucc.alicdn.com/images/user-upload-01/20181117195431919.png)

6、然后打开 IE 浏览器，可以通过访问 [http://localhost](http://localhost/):15672 进行测试，默认的登陆账号为：guest，密码为：guest。

![](https://ucc.alicdn.com/images/user-upload-01/20181117195454210.png)

成功登陆之后，如下所示

![](https://ucc.alicdn.com/images/user-upload-01/20181117195510871.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

7、添加一个队列

选择 Queues 页面，打开 “Add a new queue”，为队列命名，如“MQ\_Test”，其它选择可以默认，然后点击“Add queue” 按钮，

![](https://ucc.alicdn.com/images/user-upload-01/20181117195544772.png)

添加成功之后，在 “All queues” 选项下面会列出刚才创建的队列信息，

![](https://ucc.alicdn.com/images/user-upload-01/20181117195603688.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

8、发送 “Hello world!!!” 测试

在 “All queues” 列表中选择刚刚创建的队列 “MQ\_Test”, 会显示“MQ\_Test” 的信息页面，主要显示了该队列的网络状态以及速率监控等，然后选择 “Publish message”，在“Payload” 中输入”Hello world!!!”，

![](https://ucc.alicdn.com/images/user-upload-01/20181117195637415.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

然后点击 “Publish message” 按钮，就可以发送消息，发送完之后在 “Overview” 中显示了实时的网络状态，

![](https://ucc.alicdn.com/images/user-upload-01/20181117195656899.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

9、然后选择 “Get messages” 下拉框，会弹出接收消息的显示界面，点击 “Get message” 按钮，接收到来自服务器的消息，也就是刚刚发送的“Hello world”,

![](https://ucc.alicdn.com/images/user-upload-01/20181117195717917.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTMyMzI3NDA=,size_16,color_FFFFFF,t_70)

到此，可以说明 RabbitMQ 的安装均已正常，进一步操作请参考官网的操作文档，[http://www.rabbitmq.com/documentation.html](http://www.rabbitmq.com/documentation.html)