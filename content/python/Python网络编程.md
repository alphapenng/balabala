<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-07-16 16:44:14
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-07-23 10:14:39
 * @FilePath: /balabala/content/python/Python网络编程.md
-->

# Python 网络编程

- [Python 网络编程](#python-网络编程)
  - [socket](#socket)
  - [TCP 编程](#tcp-编程)
  - [UDP 编程](#udp-编程)

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

![public_socket1](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230716172813_gCsbFP.jpg)

![public-socket2](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230716215045_xH8K9p.jpg)

## TCP 编程

![TCP](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230716220657_2Ps86I.jpg)

如上图左边所示，server 进程首先要绑定一个端口并监听来自 client 的连接，如果某个 client 的连接过来了，server 就与 该 client 建立 socket 连接

所以 server 会打开端口（比如 80）监听，每来一个 client ，就创建该 socket 连接

考虑到会有大量的 client 与 server 进行连接，server 要能够区分一个 socket 连接对应哪个 client

一个 socket 由四个元素组成：

- server 地址（目标地址）

- client 地址（源地址）

- server 端口（目标端口）

- client 端口（源端口）

除此之外，server 还需要同时响应多个 client 的请求，所以每个连接都需要一个新的进程或者新的线程来处理，否则 server 一次就只能处理一个 client 的请求了

我们来编写一个简单的 server 程序，它接受 client 连接，把 client 发过来的数据加上 hello 再返回给 client

首先创建一个基于 ipv4 和 TCP 协议的 socket 对象

```python
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
```

然后我们绑定监听的地址和端口（可以绑定到某一块网卡的 IP 地址上，也可以用0.0.0.0绑定到所有的网络地址，还可以用 127.0.0.1绑定到本机地址）

这里我们是通过本机来实现 C/S 架构，所以绑定到 127.0.0.1 上，而且不要绑定端口号小于 1024 的端口（要有管理员权限才能绑定）

💁 ps: 端口复用

我们知道 TCP 关闭连接有一个四次挥手的过程，当 server 主动关闭连接时，会有一个 TIME_WAIT（时间等待）状态，等待 2MSL（最长报文段寿命）后进入关闭状态

那么在这个 TIME_WAIT 状态下，端口还处于被别的进程绑定的状态之中，那么其他进程就会拿不到这个端口，产生报错

我们可以通过端口复用来解决这个问题

```python
# 提示：socket.setsockopt() 方法要在 socket.bind() 之前设置
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, True)

level: 设置哪个级别的 socket，socket.SOL_SOCKET 表示当前 socket

option: 设置什么内容（权限）socket.SO_REUSEADDR 端口复用

value: True 表示复用，False 表示不复用
```

```python
# 绑定本地 9999 端口
s.bind(('127.0.0.1', 9999))
```

接着开始监听端口，参数为指定等待连接的最大数量

```python
# 监听的连接数最多为5
s.listen(5)
print('Waiting for connection...')
```

server 程序通过一个 while 循环来接受来自 client 的连接，accept()会等待并返回一个 client 的连接

当有 client 来连接时，就创建一个线程来处理会话

```python
while True:
    sock, addr = s.accept()
    t = threading.Thread(target=tcplink, args=(sock, addr))
    t.start()
```

连接建立后，server 首先返回一条欢迎消息，然后等待 client 的数据，收到数据之后并加上 hello 再发送给 client

如果没有数据或者 client 发送了 exit 字符串就关闭连接

```python
def tcplink(sock, addr):
    print('Accept new connection from %s:%s...' % addr)

    # 返回欢迎信息
    sock.send(b'hello!')

    # 当 client 发送数据时，返回 hello+数据给 client
    while True：
        data = socke.recv(1024)
        time.sleep(1)

        # 如果 client 不发送数据或者发送 exit，退出连接
        if not data or data.decode('utf-8') == 'exit:
            break
        else:
            sock.send(('Hello, %s!' % data.decode('utf-8')).encode('utf-8'))
    sock.close()
    print('Connection form %s:%s closed.' % addr)  
```

接下来我们编写一个 client 程序

创建一个基于 ipv4 和 TCP 协议的 socket 对象

```python
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
```

客户端要主动发起 TCP 连接，必须知道服务器的 IP 地址和端口号

```python
# 注意参数是一个 tuple，包含地址和端口号
s.connect(('127.0.0.1', 9999))
```

TCP 连接创建的是双向通道，双方都可以同时给对方发数据。但是谁先发谁后发，怎么协调，要根据具体的协议来决定

例如，HTTP 协议规定 client 必须先发请求给 server，server 收到后才发数据给 client

接收数据时，调用 recv (max) 方法，一次最多接收指定的字节数

```python
mes = s.recv(1024)

# 接收到的数据是 byte 格式，需要转码
print(mes.decode('utf-8'))
```

我们将数据发送给 server，并接收 server 返回的数据

```python
for data in [b'Travis', b'EDISON', b'JOHN']:
    s.send(data)
    print(s.recv(1024).decode('utf-8'))
```

当通信完之后，发送 exit 给 server，然后调用 close () 方法关闭 Socket，这样，一次完整的网络通信就结束了

```python
s.close()
```

## UDP 编程

TCP 是建立可靠连接，并且通信双方都可以以流（stream）的形式发送数据，相对于 TCP ，UDP 则是面向无连接的协议

使用 UDP 协议时，不需要建立连接，只需要知道对方的 IP 地址和端口号就可以直接发送数据包

虽然用 UDP 传输数据不可靠，但它的优点是和 TCP 比，速度快，对于不要求可靠到达的数据，就可以使用 UDP 协议

![UDP](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20230723100207_9cv5QF.jpg)

首先编写一个 `server 程序`

创建一个 socket 对象，SOCK_DGRAM 指定使用面向流的 UDP 协议

```python
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
```

绑定端口 8888，也可以绑定 9999

💁 服务器绑定 UDP 端口和 TCP 端口互不冲突，也就是说，UDP 的 9999 端口与 TCP 的 9999 端口可以各自绑定

```python
s.bind(('127.0.0.1', 8888))
```

与 TCP 不同的是，UDP 不需要监听端口，而是直接接收来自 client 的数据

```python
print(' Bind UDP on 8888........ ')
while True:
    # recvfrom 接收数据，返回(data, address)
    data, addr = s.recvfrom(1024)
    print('Received from %s:%s.' % addr)
    #sendto 发送数据， 发送形式是(data, address)
    s.sendto(b'Hello, %s!' % data, addr)

# 关闭套接字
s.close()
```

然后编写一个 `client 程序`

创建一个 socket 对象，SOCK_DGRAM 指定使用面向流的 UDP 协议

```python
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
```

client 使用 UDP 时，首先仍然创建基于 UDP 的 Socket，然后，不需要调用 connect ()，直接通过 sendto () 给 server 发数据

```python
for data in [b'Edison', b'Kanye', b'Kendrick']:
    # 发送数据：
    s.sendto(data, ('127.0.0.1', 9999))
    # 接收数据：
    print(s.recv(1024).decode('utf-8'))
    
# 关闭套接字
s.close()
```
