<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-07-16 16:44:14
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-07-16 16:59:33
 * @FilePath: /balabala/content/code/Python网络编程.md
-->

# Python 网络编程

- [Python 网络编程](#python-网络编程)
  - [socket](#socket)

## socket

Python 提供了两个级别的网络服务模块：

- socket

    低级别的网络服务模块，提供了标准的 BSD Sockets API，可以访问底层操作系统 Socket 接口的全部方法

- socketserver

    高级别的网络服务模块，它提供了服务器中心类，可以简化网络服务器的开发

先介绍 socket 模块

导入 socket 模块

```python
import socket
# 语法
socket.socket([family[, type[, proto]]])
```

- family：套接字家族；可以是 AF_UNIX 或者 AF_INET

- type：套接字类型；可以根据是面向连接（TCP）的还是非连接（UDP）分为 SOCK_STREAM 或 SOCK_DGRAM

- protocol：一般不填默认为 0

**server 端 socket 函数**

![server_socket](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230716165332_gZgbjv.jpg)

**client 端 socket 函数**

![client_socket](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230716165838_AgB4Lw.jpg)

**公共 socket 函数**

