> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.ilikejobs.com](https://www.ilikejobs.com/posts/wireshark/)

> wireshark 包类型 pcap 这个是 libpcap 的格式，也是 tcpdump 和 Wireshark 等工具默认支持的文件格式。pcap 格 式的文件中除了报文数据以外，也包含了抓包文件的

pcap[](#pcap)
-------------

**这个是 libpcap 的格式，也是 tcpdump 和 Wireshark 等工具默认支持的文件格式**。pcap 格 式的文件中除了报文数据以外，也包含了抓包文件的元信息，比如版本号、抓包时间、每个报 文被抓取的最大长度，等等。

cap[](#cap)
-----------

**cap 文件可能含有一些 libpcap 标准之外的数据格式，它是由一些 tcpdump 以外的抓包程序生成的。** 比如 Citrix 公司的 netscaler 负载均衡器，它的 nstrace 命令生成的抓包文件，就是 以. cap 为扩展名的。这种文件除了包含 pcap 标准定义的信息以外，还包含了 LB 的前端连接 和后端连接之间的 mapping 信息。Wireshark 是可以读取这些. cap 文件的，只要在正确的 版本上

pcapng[](#pcapng)
-----------------

pcap 格式虽然满足了大部分需求，但是它也有一些不足。比如，现在多网口的情况已经越来 越常见了，我们也经常需要从多个网络接口去抓取报文，所以单个 pcapng 的包里面会包含多个网络接口的包。

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark.png) 

`pcapng 还有很多别的特性，比如更细粒度的报文时间戳、允许对报文添加注释、更灵活的元数据，如果你是用版本比较新的 Wireshark 和 tshark 做抓包，默认生成的抓包文件就已经是 pcapng 格式了`

```
1# tcpdump -i eth0 -s 80 -w /tmp/tcpdump.cap
 3- i 指定网卡eth0
 4- s 指定抓包大小80字节
 5- w 保持成文件存储位置
 7# tcpdump -i eth0 host 10.31.200.131 -w /tmp/tcpdump.cap
 9- host 表示只抓与10.31.200.131通信的包
10- port 表示只抓指定端口的包
12PS：加更多的限制可能会抓不到包，比如NAT把对方的包给改掉了。
```

常用参数[](#%e5%b8%b8%e7%94%a8%e5%8f%82%e6%95%b0)
---------------------------------------------

*   -h：帮助

```
1// On Linux
 2# tcpdump -h
 3[root@dev-env ~]# tcpdump -h
 4tcpdump version 4.9.2
 5libpcap version 1.5.3
 6OpenSSL 1.0.2k-fips  26 Jan 2017
 7Usage: tcpdump [-aAbdDefhHIJKlLnNOpqStuUvxX#] [ -B size ] [ -c count ]
 8                [ -C file_size ] [ -E algo:secret ] [ -F file ] [ -G seconds ]
 9                [ -i interface ] [ -j tstamptype ] [ -M secret ] [ --number ]
10                [ -Q|-P in|out|inout ]
11                [ -r file ] [ -s snaplen ] [ --time-stamp-precision precision ]
12                [ --immediate-mode ] [ -T type ] [ --version ] [ -V file ]
13                [ -w file ] [ -W filecount ] [ -y datalinktype ] [ -z postrotate-command ]
14                [ -Z user ] [ expression ]
15// On Mac
16zhengxianle@zhengxinledembp  ~  dumpcap -h
17Dumpcap (Wireshark) 4.0.5 (v4.0.5-0-ge556162d8da3)
18Capture network packets and dump them into a pcapng or pcap file.
19See https://www.wireshark.org for more information.
21Usage: dumpcap [options] ...
23Capture interface:
24  -i <interface>, --interface <interface>
25                           name or idx of interface (def: first non-loopback),
26                           or for remote capturing, use one of these formats:
27                               rpcap://<host>/<interface>
28                               TCP@<host>:<port>
29  --ifname <name>          name to use in the capture file for a pipe from which
30                           we're capturing
31  --ifdescr <description>
32                           description to use in the capture file for a pipe
33                           from which we're capturing
34  -f <capture filter>      packet filter in libpcap filter syntax
```

*   -D：查看有哪些网卡

```
1// Linux
 2[root@dev-env ~]# tcpdump -D
 31.eth0
 42.tun0
 53.nflog (Linux netfilter log (NFLOG) interface)
 64.nfqueue (Linux netfilter queue (NFQUEUE) interface)
 75.usbmon1 (USB bus number 1)
 86.any (Pseudo-device that captures on all interfaces)
 97.lo [Loopback]
10// MacOS
11zhengxianle@zhengxinledembp  ~#  dumpcap -D
121. en0 (Wi-Fi)
132. awdl0
143. llw0
154. utun0
165. utun1
176. utun2
187. utun3
198. utun4
209. utun5
2110. utun6
2211. utun7
2312. utun8
2413. utun9
2514. lo0 (Loopback)
2615. en4 (Thunderbolt 4)
2716. en1 (Thunderbolt 1)
2817. en2 (Thunderbolt 2)
2918. en3 (Thunderbolt 3)
3019. bridge0 (Thunderbolt Bridge)
3120. pktap0
3221. gif0
3322. stf0
3423. ap1
35zhengxianle@zhengxinledembp~# tcpdump -D
361.en0 [Up, Running, Wireless, Associated]
372.awdl0 [Up, Running, Wireless, Associated]
383.llw0 [Up, Running, Wireless, Associated]
394.utun0 [Up, Running]
405.utun1 [Up, Running]
416.utun2 [Up, Running]
427.utun3 [Up, Running]
438.utun4 [Up, Running]
449.utun5 [Up, Running]
4510.utun6 [Up, Running]
4611.utun7 [Up, Running]
4712.utun8 [Up, Running]
4813.utun9 [Up, Running]
4914.lo0 [Up, Running, Loopback]
5015.en4 [Up, Running, Disconnected]
5116.en1 [Up, Running, Disconnected]
5217.en2 [Up, Running, Disconnected]
5318.en3 [Up, Running, Disconnected]
5419.bridge0 [Up, Running, Disconnected]
5520.pktap0 [Up]
5621.gif0 [none]
5722.stf0 [none]
5823.ap1 [Wireless, Association status unknown]
```

*   -i : 指定网卡，这里 1 指定的是 - D 中的网卡序号

```
1zhengxianle@zhengxinledembp~ # dumpcap -i 1
2Capturing on 'Wi-Fi: en0'
3File: /var/folders/23/7d2bd6ss2db4vjz8twqwf4940000gn/T/wireshark_Wi-FiSI0731.pcapng
4Packets captured: 923
5Packets received/dropped on interface 'Wi-Fi: en0': 923/0 (pcap:0/dumpcap:0/flushed:0/ps_ifdrop:0) (100.0%)
```

*   -w：指定存储在的位置

```
1zhengxianle@zhengxinledembp~# dumpcap -i 1 -w /Users/zhengxianle/Desktop/capture/sample.pcapng
2Capturing on 'Wi-Fi: en0'
3File: /Users/zhengxianle/Desktop/capture/sample.pcapng
4Packets captured: 573
5Packets received/dropped on interface 'Wi-Fi: en0': 573/0 (pcap:0/dumpcap:0/flushed:0/ps_ifdrop:0) (100.0%)
```

*   -b
    *   filesize:500000 // 代表 500M
    *   files:10 // 代表一共存 10 个文件，当第 11 个文件产生时，会覆盖第一个文件。

```
1更详细的配置：
 2-b <ringbuffer opt.> ..., --ring-buffer <ringbuffer opt.>
 3                           duration:NUM - switch to next file after NUM secs
 4                           filesize:NUM - switch to next file after NUM kB
 5                              files:NUM - ringbuffer: replace after NUM files
 6                            packets:NUM - ringbuffer: replace after NUM packets
 7                           interval:NUM - switch to next file when the time is
 8                                          an exact multiple of NUM secs
 9                          printname:FILE - print filename to FILE when written
10                                           (can use 'stdout' or 'stderr')
```

```
1zhengxianle@zhengxinledembp~ # dumpcap -i 1 -w /Users/zhengxianle/Desktop/capture/sample.pcapng -b filesize:500000
2 -b files:10
3Capturing on 'Wi-Fi: en0'
4File: /Users/zhengxianle/Desktop/capture/sample_00001_20230426220541.pcapng
5Packets captured: 1238
6Packets received/dropped on interface 'Wi-Fi: en0': 1238/0 (pcap:0/dumpcap:0/flushed:0/ps_ifdrop:0) (100.0%)
```

*   -c ： 数量，可以抓取固定数量的保文，在流量较高时，可以避免一不小心抓取过多报文
    
*   -n：不做地址转换（比如 IP 地址转换为主机，port 80 转换为 http）
    
*   -v/-vv/-vvv: 可以打印更加详细的报文信息
    
*   -e ： 可以打印二层信息，特别是 MAC 地址
    
*   -p：关闭混杂模式。
    
    `所谓混杂模式，也就是嗅探（Sniffing），就是把目的地址不是本机地址的网络报文也抓取下来。`
    
*   -X ：在解析和打印时，除了打印每个数据包的头之外，还可以用十六进制和 ASCII 打印每个数据包的数据（减去其链接级头）。 这对于分析新协议非常方便。 在目前的实现中，如果数据包被截断，这个标志可能与 - XX 的效果相同。
    

`这个参数很有用啊，可以看到具体的请求内容了，快速排查问题的时候是可以这么做的。`

```
1[root@dev-env ~]# netstat -ntpl
  2Active Internet connections (only servers)
  3Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
  4tcp        0      0 0.0.0.0:41046           0.0.0.0:*               LISTEN      3953/java           
  5tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1957/sshd           
  6tcp        0      0 0.0.0.0:8089            0.0.0.0:*               LISTEN      2818/nginx: master  
  7tcp        0      0 0.0.0.0:8090            0.0.0.0:*               LISTEN      2818/nginx: master  
  8tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      2818/nginx: master  
  9tcp        0      0 0.0.0.0:8091            0.0.0.0:*               LISTEN      2818/nginx: master  
 10tcp        0      0 0.0.0.0:18080           0.0.0.0:*               LISTEN      3953/java           
 11tcp        0      0 0.0.0.0:10051           0.0.0.0:*               LISTEN      2171/zabbix_proxy   
 12tcp        0      0 0.0.0.0:11940           0.0.0.0:*               LISTEN      1492/openvpn        
 13tcp        0      0 0.0.0.0:2181            0.0.0.0:*               LISTEN      3953/java           
 14tcp        0      0 0.0.0.0:3306            0.0.0.0:*               LISTEN      1837/mysqld         
 15tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1138/rpcbind        
 16tcp6       0      0 :::10050                :::*                    LISTEN      1489/zabbix_agent2  
 17tcp6       0      0 :::10051                :::*                    LISTEN      2171/zabbix_proxy   
 18tcp6       0      0 :::111                  :::*                    LISTEN      1138/rpcbind        
 19[root@dev-env ~]# tcpdump -i any -X port 18080
 20tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
 21listening on any, link-type LINUX_SLL (Linux cooked), capture size 262144 bytes
 2222:02:52.188802 IP 10.222.1.77.51848 > 172.22.183.239.18080: Flags [.], ack 3220596691, win 790, options [nop,nop,TS val 2719039184 ecr 2964196926], length 0
 23        0x0000:  4500 0034 2a37 4000 8006 605c 0ade 014d  E..4*7@...`\...M
 24        0x0010:  ac16 b7ef ca88 46a0 8504 150d bff6 67d3  ......F.......g.
 25        0x0020:  8010 0316 90a3 0000 0101 080a a211 3ed0  ..............>.
 26        0x0030:  b0ae 0e3e 0000 0000 0000 0000 0000 0000  ...>............
 27        0x0040:  0000 0000                                ....
 2822:02:52.188822 IP 10.222.1.77.51848 > 172.22.183.239.18080: Flags [.], ack 1, win 790, options [nop,nop,TS val 2719039184 ecr 2964196926], length 0
 29        0x0000:  4500 0034 2a37 4000 7f06 615c 0ade 014d  E..4*7@...a\...M
 30        0x0010:  ac16 b7ef ca88 46a0 8504 150d bff6 67d3  ......F.......g.
 31        0x0020:  8010 0316 90a3 0000 0101 080a a211 3ed0  ..............>.
 32        0x0030:  b0ae 0e3e 0000 0000 0000 0000 0000 0000  ...>............
 33        0x0040:  0000 0000                                ....
 3422:02:52.188961 IP 172.22.183.239.18080 > 10.222.1.77.51848: Flags [.], ack 1, win 805, options [nop,nop,TS val 2964201950 ecr 2719019098], length 0
 35        0x0000:  4500 0034 9a5b 4000 8006 f037 ac16 b7ef  E..4.[@....7....
 36        0x0010:  0ade 014d 46a0 ca88 bff6 67d3 8504 150e  ...MF.....g.....
 37        0x0020:  8010 0325 cb69 0000 0101 080a b0ae 21de  ...%.i........!.
 38        0x0030:  a210 f05a 0000 0000 0000 0000 0000 0000  ...Z............
 39        0x0040:  0000 0000                                ....
 4022:02:52.188968 IP 172.22.183.239.18080 > 10.222.1.77.51848: Flags [.], ack 1, win 805, options [nop,nop,TS val 2964201950 ecr 2719019098], length 0
 41        0x0000:  4500 0034 9a5b 4000 7f06 f137 ac16 b7ef  E..4.[@....7....
 42        0x0010:  0ade 014d 46a0 ca88 bff6 67d3 8504 150e  ...MF.....g.....
 43        0x0020:  8010 0325 cb69 0000 0101 080a b0ae 21de  ...%.i........!.
 44        0x0030:  a210 f05a 0000 0000 0000 0000 0000 0000  ...Z............
 45        0x0040:  0000 0000                                ....
 4622:02:57.212632 IP 10.222.1.77.51848 > 172.22.183.239.18080: Flags [.], ack 1, win 790, options [nop,nop,TS val 2719044208 ecr 2964201950], length 0
 47        0x0000:  4500 0034 2a38 4000 8006 605b 0ade 014d  E..4*8@...`[...M
 48        0x0010:  ac16 b7ef ca88 46a0 8504 150d bff6 67d3  ......F.......g.
 49        0x0020:  8010 0316 6963 0000 0101 080a a211 5270  ....ic........Rp
 50        0x0030:  b0ae 21de 0000 0000 0000 0000 0000 0000  ..!.............
 51        0x0040:  0000 0000                                ....
 5222:02:57.212652 IP 10.222.1.77.51848 > 172.22.183.239.18080: Flags [.], ack 1, win 790, options [nop,nop,TS val 2719044208 ecr 2964201950], length 0
 53        0x0000:  4500 0034 2a38 4000 7f06 615b 0ade 014d  E..4*8@...a[...M
 54        0x0010:  ac16 b7ef ca88 46a0 8504 150d bff6 67d3  ......F.......g.
 55        0x0020:  8010 0316 6963 0000 0101 080a a211 5270  ....ic........Rp
 56        0x0030:  b0ae 21de 0000 0000 0000 0000 0000 0000  ..!.............
 57        0x0040:  0000 0000                                ....
 5822:02:57.212782 IP 172.22.183.239.18080 > 10.222.1.77.51848: Flags [.], ack 1, win 805, options [nop,nop,TS val 2964206974 ecr 2719019098], length 0
 59        0x0000:  4500 0034 9a5c 4000 8006 f036 ac16 b7ef  E..4.\@....6....
 60        0x0010:  0ade 014d 46a0 ca88 bff6 67d3 8504 150e  ...MF.....g.....
 61        0x0020:  8010 0325 b7c9 0000 0101 080a b0ae 357e  ...%..........5~
 62        0x0030:  a210 f05a 0000 0000 0000 0000 0000 0000  ...Z............
 63        0x0040:  0000 0000                                ....
 6422:02:57.212790 IP 172.22.183.239.18080 > 10.222.1.77.51848: Flags [.], ack 1, win 805, options [nop,nop,TS val 2964206974 ecr 2719019098], length 0
 65        0x0000:  4500 0034 9a5c 4000 7f06 f136 ac16 b7ef  E..4.\@....6....
 66        0x0010:  0ade 014d 46a0 ca88 bff6 67d3 8504 150e  ...MF.....g.....
 67        0x0020:  8010 0325 b7c9 0000 0101 080a b0ae 357e  ...%..........5~
 68        0x0030:  a210 f05a 0000 0000 0000 0000 0000 0000  ...Z............
 69        0x0040:  0000 0000                                ....
 7022:02:59.585608 IP 10.222.1.12.57689 > 172.22.183.239.18080: Flags [P.], seq 1350914016:1350914568, ack 1773723314, win 2048, options [nop,nop,TS val 3234104033 ecr 2964179285], length 552
 71        0x0000:  4502 025c 0000 4000 4006 c8aa 0ade 010c  E..\..@.@.......
 72        0x0010:  ac16 b7ef e159 46a0 5085 4fe0 69b8 deb2  .....YF.P.O.i...
 73        0x0020:  8018 0800 f5cf 0000 0101 080a c0c4 82e1  ................
 74        0x0030:  b0ad c955 504f 5354 202f 7878 6c2d 6a6f  ...UPOST./xxl-jo
 75        0x0040:  622d 6164 6d69 6e2f 6170 6920 4854 5450  b-admin/api.HTTP
 76        0x0050:  2f31 2e31 0d0a 686f 7374 3a20 3137 322e  /1.1..host:.172.
 77        0x0060:  3232 2e31 3833 2e32 3339 0d0a 636f 6e6e  22.183.239..conn
 78        0x0070:  6563 7469 6f6e 3a20 6b65 6570 2d61 6c69  ection:.keep-ali
 79        0x0080:  7665 0d0a 636f 6e74 656e 742d 6c65 6e67  ve..content-leng
 80        0x0090:  7468 3a20 3434 390d 0a0d 0a43 302d 636f  th:.449....C0-co
 81        0x00a0:  6d2e 7878 6c2e 7270 632e 7265 6d6f 7469  m.xxl.rpc.remoti
 82        0x00b0:  6e67 2e6e 6574 2e70 6172 616d 732e 5878  ng.net.params.Xx
 83        0x00c0:  6c52 7063 5265 7175 6573 7498 0972 6571  lRpcRequest..req
 84        0x00d0:  7565 7374 4964 1063 7265 6174 654d 696c  uestId.createMil
 85        0x00e0:  6c69 7354 696d 650b 6163 6365 7373 546f  lisTime.accessTo
 86        0x00f0:  6b65 6e09 636c 6173 734e 616d 650a 6d65  ken.className.me
 87        0x0100:  7468 6f64 4e61 6d65 0776 6572 7369 6f6e  thodName.version
 88        0x0110:  0e70 6172 616d 6574 6572 5479 7065 730a  .parameterTypes.
 89        0x0120:  7061 7261 6d65 7465 7273 6030 2432 6332  parameters`0$2c2
 90        0x0130:  3332 3739 382d 3536 6164 2d34 3562 362d  32798-56ad-45b6-
 91        0x0140:  6162 3333 2d61 6665 6636 6261 3630 3565  ab33-afef6ba605e
 92        0x0150:  334c 0000 0188 4e11 f43a 4e1d 636f 6d2e  3L....N..:N.com.
 93        0x0160:  7878 6c2e 6a6f 622e 636f 7265 2e62 697a  xxl.job.core.biz
 94        0x0170:  2e41 646d 696e 4269 7a08 7265 6769 7374  .AdminBiz.regist
 95        0x0180:  7279 4e71 105b 6a61 7661 2e6c 616e 672e  ryNq.[java.lang.
 96        0x0190:  436c 6173 7343 0f6a 6176 612e 6c61 6e67  ClassC.java.lang
 97        0x01a0:  2e43 6c61 7373 9104 6e61 6d65 6130 2863  .Class..namea0(c
 98        0x01b0:  6f6d 2e78 786c 2e6a 6f62 2e63 6f72 652e  om.xxl.job.core.
 99        0x01c0:  6269 7a2e 6d6f 6465 6c2e 5265 6769 7374  biz.model.Regist
100        0x01d0:  7279 5061 7261 6d71 075b 6f62 6a65 6374  ryParamq.[object
101        0x01e0:  4330 2863 6f6d 2e78 786c 2e6a 6f62 2e63  C0(com.xxl.job.c
102        0x01f0:  6f72 652e 6269 7a2e 6d6f 6465 6c2e 5265  ore.biz.model.Re
103        0x0200:  6769 7374 7279 5061 7261 6d93 0b72 6567  gistryParam..reg
104        0x0210:  6973 7447 726f 7570 0b72 6567 6973 7472  istGroup.registr
105        0x0220:  794b 6579 0d72 6567 6973 7472 7956 616c  yKey.registryVal
106        0x0230:  7565 6208 4558 4543 5554 4f52 0e6f 7370  ueb.EXECUTOR.osp
107        0x0240:  4461 7461 4d61 702d 6a6f 6210 3130 2e32  DataMap-job.10.2
108        0x0250:  3136 2e31 2e31 313a 3939 3939 0000 0000  16.1.11:9999....
109        0x0260:  0000 0000 0000 0000 0000 0000            ............
11022:02:59.585641 IP 10.222.1.12.57689 > 172.22.183.239.18080: Flags [P.], seq 0:552, ack 1, win 2048, options [nop,nop,TS val 3234104033 ecr 2964179285], length 552
111        0x0000:  4502 025c 0000 4000 3f06 c9aa 0ade 010c  E..\..@.?.......
112        0x0010:  ac16 b7ef e159 46a0 5085 4fe0 69b8 deb2  .....YF.P.O.i...
113        0x0020:  8018 0800 f5cf 0000 0101 080a c0c4 82e1  ................
114        0x0030:  b0ad c955 504f 5354 202f 7878 6c2d 6a6f  ...UPOST./xxl-jo
115        0x0040:  622d 6164 6d69 6e2f 6170 6920 4854 5450  b-admin/api.HTTP
116        0x0050:  2f31 2e31 0d0a 686f 7374 3a20 3137 322e  /1.1..host:.172.
117        0x0060:  3232 2e31 3833 2e32 3339 0d0a 636f 6e6e  22.183.239..conn
118        0x0070:  6563 7469 6f6e 3a20 6b65 6570 2d61 6c69  ection:.keep-ali
119        0x0080:  7665 0d0a 636f 6e74 656e 742d 6c65 6e67  ve..content-leng
120        0x0090:  7468 3a20 3434 390d 0a0d 0a43 302d 636f  th:.449....C0-co
121        0x00a0:  6d2e 7878 6c2e 7270 632e 7265 6d6f 7469  m.xxl.rpc.remoti
122        0x00b0:  6e67 2e6e 6574 2e70 6172 616d 732e 5878  ng.net.params.Xx
123        0x00c0:  6c52 7063 5265 7175 6573 7498 0972 6571  lRpcRequest..req
124        0x00d0:  7565 7374 4964 1063 7265 6174 654d 696c  uestId.createMil
125        0x00e0:  6c69 7354 696d 650b 6163 6365 7373 546f  lisTime.accessTo
126        0x00f0:  6b65 6e09 636c 6173 734e 616d 650a 6d65  ken.className.me
127        0x0100:  7468 6f64 4e61 6d65 0776 6572 7369 6f6e  thodName.version
128        0x0110:  0e70 6172 616d 6574 6572 5479 7065 730a  .parameterTypes.
129        0x0120:  7061 7261 6d65 7465 7273 6030 2432 6332  parameters`0$2c2
130        0x0130:  3332 3739 382d 3536 6164 2d34 3562 362d  32798-56ad-45b6-
131        0x0140:  6162 3333 2d61 6665 6636 6261 3630 3565  ab33-afef6ba605e
132        0x0150:  334c 0000 0188 4e11 f43a 4e1d 636f 6d2e  3L....N..:N.com.
133        0x0160:  7878 6c2e 6a6f 622e 636f 7265 2e62 697a  xxl.job.core.biz
134        0x0170:  2e41 646d 696e 4269 7a08 7265 6769 7374  .AdminBiz.regist
135        0x0180:  7279 4e71 105b 6a61 7661 2e6c 616e 672e  ryNq.[java.lang.
136        0x0190:  436c 6173 7343 0f6a 6176 612e 6c61 6e67  ClassC.java.lang
137        0x01a0:  2e43 6c61 7373 9104 6e61 6d65 6130 2863  .Class..namea0(c
138        0x01b0:  6f6d 2e78 786c 2e6a 6f62 2e63 6f72 652e  om.xxl.job.core.
139        0x01c0:  6269 7a2e 6d6f 6465 6c2e 5265 6769 7374  biz.model.Regist
140        0x01d0:  7279 5061 7261 6d71 075b 6f62 6a65 6374  ryParamq.[object
141        0x01e0:  4330 2863 6f6d 2e78 786c 2e6a 6f62 2e63  C0(com.xxl.job.c
142        0x01f0:  6f72 652e 6269 7a2e 6d6f 6465 6c2e 5265  ore.biz.model.Re
143        0x0200:  6769 7374 7279 5061 7261 6d93 0b72 6567  gistryParam..reg
144        0x0210:  6973 7447 726f 7570 0b72 6567 6973 7472  istGroup.registr
145        0x0220:  794b 6579 0d72 6567 6973 7472 7956 616c  yKey.registryVal
146        0x0230:  7565 6208 4558 4543 5554 4f52 0e6f 7370  ueb.EXECUTOR.osp
147        0x0240:  4461 7461 4d61 702d 6a6f 6210 3130 2e32  DataMap-job.10.2
148        0x0250:  3136 2e31 2e31 313a 3939 3939 0000 0000  16.1.11:9999....
149        0x0260:  0000 0000 0000 0000 0000 0000            ............
```

打标记[](#%e6%89%93%e6%a0%87%e8%ae%b0)
-----------------------------------

包除了小以外，还需要为每步操作打标记，这样的包一目了然，赏心悦目。比如：

1.  sudo ping [www.baidu.com](http://www.baidu.com/) -c 1 -s 1
2.  操作步骤 1
3.  sudo ping [www.baidu.com](http://www.baidu.com/) -c 1 -s 2
4.  操作步骤 2
5.  sudo ping [www.baidu.com](http://www.baidu.com/) -c 1 -s 3
6.  操作步骤 3

> 解释（MacOS 下）：-c 指定 ping 次数，-s 指定包大小

```
1usage: ping [-AaDdfnoQqRrv] [**-c count**] [-G sweepmaxsize]
 2            [-g sweepminsize] [-h sweepincrsize] [-i wait]
 3            [-l preload] [-M mask | time] [-m ttl] [-p pattern]
 4            [-S src_addr] [**-s packetsize**] [-t timeout][-W waittime]
 5            [-z tos] host
 6       ping [-AaDdfLnoQqRrv] [-c count] [-I iface] [-i wait]
 7            [-l preload] [-M mask | time] [-m ttl] [-p pattern] [-S src_addr]
 8            [-s packetsize] [-T ttl] [-t timeout] [-W waittime]
 9            [-z tos] mcast-group
10Apple specific options (to be specified before mcast-group or host like all options)
11            -b boundif           # bind the socket to the interface
12            -k traffic_class     # set traffic class socket option
13            -K net_service_type  # set traffic class socket options
14            --apple-connect       # call connect(2) in the socket
15            --apple-time          # display current time
```

在抓包时可以看到包下面 Data（-s 部分大小），byte 的大小表示当前是第几步，就不容易出错。

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%201.png) 

过滤技巧[](#%e8%bf%87%e6%bb%a4%e6%8a%80%e5%b7%a7)
---------------------------------------------

*   已知协议，直接输入协议即可，例如：http/tcp/smtp 等，多个协议可以用 || 来分开，例如：tcp||http
*   ip + 端口号是比较常用的过滤方式，例如：ip.addr eq 172.22.183.226 && tcp.port eq 8080，还可以右键单击感兴趣的包，选择 follow TCP/UDP Stream，就可以自动过滤当前的包了。
*   过滤跟某个 IP 地址相关的包

*   排除某些端口

```
1ip.addr == 192.168.0.1
```

*   根据端口范围查找

```
1not (tcp or arp or smtp)
```

*   按照关键词查询：区分大小写

```
1tcp.port in {80,443,8080}
```

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%202.png) 

*   按照关键词查询：不区分大小写（matches 采用的是 regex）

```
1frame contains "baidu.com"
```

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%203.png) 

**如何过滤一个 TCP/UDP Stream 呢？**

两端的 IP 加 port，单击 wireshark 的 Statistics→conversations，再单击 TCP 或者 UDP 标签就可以看到所有的 Stream 了。如下图：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%204.png) 

*   用鼠标过滤：可以选择感兴趣的包，右键加入筛选即可。有两种方式：
    
    *   Prepare a Filter→Selected（可以选择多个一起执行）
    *   Apply as Filter→Selected（立即自动执行）
    
    也有很多组合方式可以按条件来：
    
    *   Selected
    *   not selected
    *   and selected
    *   or selected
    *   and not selected
    *   or not selected
*   过滤后的导出到新文件，因为文件更小。导出时要选择 File→Export Specified Packets，这样就不会漏掉关联的包，不然会报错。
    
*   过滤失败的握手
    
    ```
    1frame matches "baidu.com"
    ```
    
*   过滤重传的握手请求
    

过滤完查看完整的包流程，可以看到服务端的端口被使用了。

```
1tcp.flags.reset == 1 && tcp.seq==1
```

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%205.png) 

抓包时过滤[](#%e6%8a%93%e5%8c%85%e6%97%b6%e8%bf%87%e6%bb%a4)
-------------------------------------------------------

需求：统计某个 HTTPS VIP 的访问流量里，TLS 版本（主要是 TLS1.0、1.1、1.2、1.3）的分布。为了控制抓包文件的大小，不抓 TLS 的所有报文，只想抓 TLS 版本信息。

针对这个需求，tcpdump 本身没有现成的过滤器。BPF 本身是基于偏移量来做解析的，所以可以在 tcpdump 中使用这种偏移量技术，所以类似如下命令：

```
1tcp.flags.syn == 1 && tcp.analysis.retransmission
```

*   dst port 443：这个最简单，就是抓取从客户端发过来的访问 HTTPS 的报文。
*   tcp[20]==22：这是提取了 TCP 的第 21 个字节（因为初始序号是从 0 开始的），由于 TCP 头部占 20 字节，TLS 又是 TCP 的载荷，那么 TLS 的第 1 个字节就是 TCP 的第 21 个字节，也就是 TCP[20]，这个位置的值如果是 22（十进制），那么就表明这个是 TLS 握手报文。
*   tcp[25]==1：同理，这是 TCP 头部的第 26 个字节，如果它等于 1，那么就表明这个是 Client Hello 类型的 TLS 握手报文。

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%206.png) 

对应到偏移量的介绍如下：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%207.png) 

tcpdump 也预定义了一些相对方便的过滤器。比如我们想要过滤出 TCP RST 报文，那么可以用下面这种写法，相对来说比用数字做偏移量的写法，要更加容易理解和记忆：

```
1tcpdump -w /tmp/[fileter_TLS_Client_Hello.pcap](https://drive.google.com/file/d/112X8cKH78DQ0GQL8kMlT2RvI3gxUwbHv/view?usp=drive_link) 'dst port 443 && tcp[20]==22 && tcp[25]==1'
```

对应到偏移量的写法如下：

```
1tcpdump -w file.pcap 'tcp[tcpflags]&(tcp-rst) != 0'
```

读取抓包文件[](#%e8%af%bb%e5%8f%96%e6%8a%93%e5%8c%85%e6%96%87%e4%bb%b6)
-----------------------------------------------------------------

tcpdump 后面加上 - r 参数和文件名称，就可以读取这个文件了，也可以加上过滤条件：

```
1tcpdump -w file.pcap 'tcp[13]&4 != 0'
```

过滤后转存[](#%e8%bf%87%e6%bb%a4%e5%90%8e%e8%bd%ac%e5%ad%98)
-------------------------------------------------------

抓包以后过滤想要的报文，并保存到另一个文件中，如下所示：

```
1tcpdump -r file.pcap 'tcp[tcpflags] & (tcp-rst) != 0'
```

解析已知协议与 IP 域名映射[](#%e8%a7%a3%e6%9e%90%e5%b7%b2%e7%9f%a5%e5%8d%8f%e8%ae%ae%e4%b8%8eip%e5%9f%9f%e5%90%8d%e6%98%a0%e5%b0%84)
-------------------------------------------------------------------------------------------------------------------------

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%208.png) 

查询当前已经解析了哪些域名[](#%e6%9f%a5%e8%af%a2%e5%bd%93%e5%89%8d%e5%b7%b2%e7%bb%8f%e8%a7%a3%e6%9e%90%e4%ba%86%e5%93%aa%e4%ba%9b%e5%9f%9f%e5%90%8d)
---------------------------------------------------------------------------------------------------------------------------------------

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%209.png) 

设置私有 IP 名称[](#%e8%ae%be%e7%bd%ae%e7%a7%81%e6%9c%89ip%e5%90%8d%e7%a7%b0)
-----------------------------------------------------------------------

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2010.png) 

查看刚设置自定义的名称：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2011.png) 

保存文件（含 host 对应名称）[](#%e4%bf%9d%e5%ad%98%e6%96%87%e4%bb%b6%e5%90%abhost%e5%af%b9%e5%ba%94%e5%90%8d%e7%a7%b0)
-----------------------------------------------------------------------------------------------------------

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2012.png) 

设置时间列[](#%e8%ae%be%e7%bd%ae%e6%97%b6%e9%97%b4%e5%88%97)
-------------------------------------------------------

设置计时器，按照发送包的时间间隔来设置当前包发出去后返回需要的时间。

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2013.png) 

设置时间重新开始计时的时间引用，时间会从当前引用开始重新计时

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2014.png) 

设置 TCP Stream Time，tcp 的响应时间（可以根据此时间做排序以后排查慢的包）

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2015.png) 

1.  单击 Analyze→Expert Information，可以显示出来不同级别的提示信息。比如：重传的统计、连接的建立和重置统计等。分析网络性能和连接问题时这个功能比较有用，如下图：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2016.png) 

1.  单击 Statistics→Service Response Time，再选定协议名称，可以得到响应时间统计表。在衡量服务器性能时经常需要统计此结果。如下图：选择的是 SMB 协议的操作响应时间，**不知道为啥没有值。**
    
     ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2017.png) 
2.  单击 Statistics→TCP Stream Graph，可以生成几类统计图。例如：
    
    *   Time-Sequence Graph（Stevens）
    *   Time-Sequence Graph（tcptrace）
    *   Throughput
    *   Round Trip Time
    *   Window Scaling
    
     ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2018.png) 

可以根据传输数据信息来分析系统发送数据状态。

1.  单击 Statistics→ Capture File Properties 看到一些统计信息，比如平均流量等，可以推测负载状况。如下图：流量大小 6.8M。

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2019.png) 

1.  概览（statistics→Conversations）, 根据此可以分析出当前抓包的概览信息，包括

*   包的数量，大小 IPv4 流量信息，传输时间长
*   TCP 中开始时间，数据传输时间
*   TCP 中 IP 地址，端口号，包的大小，包开始时间，持续时间
*   UDP 的客户端、服务端信息，传输包的大小，开始时间，持续时间等信息

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2020.png) 

可以根据需求，直接使用右键进行包的过滤，过滤以后可以在主页面中看到过滤后的包。

`注意：当开启Nagle算法和延迟确认时，在分析过程中如果看不出差异，可以缩小时间范围。`

设置允许重组 tcp 流量包

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2021.png) 

导出 http 文件（这里是 http 的请求）

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2022.png) 

选择以后，点击保存即可

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2023.png) 

可以在此处下载 IP 地址对应的城市：[https://dev.maxmind.com/geoip/geolite2-free-geolocation-data?lang=en](https://dev.maxmind.com/geoip/geolite2-free-geolocation-data?lang=en)

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2024.png) 

可以在 statistics→endpoints 中进行分析，同时可以用 map 进行映射到地图

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2025.png) 

根据城市做搜索：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2026.png) 

command+f 搜索关键字，例如查询 “common/service” 的关键词，如下图：**这个太有用了！！**

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2027.png) 

```
1tcpdump -r file.pcap 'tcp[tcpflags]&(tcp-rst)!=0' -w rst.pcap
```

[**tshark**](https://www.notion.so/tshark-de1f0be16cd0480c990e894b44fe1dec?pvs=21)

设置窗口的 Layout[](#%e8%ae%be%e7%bd%ae%e7%aa%97%e5%8f%a3%e7%9a%84layout)
--------------------------------------------------------------------

这里设置第三个窗口，以协议栈的方式显示。

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2028.png) 

右键可以显示当前每个协议字段的值：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2029.png) 

设置完了显示如此：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2030.png) 

DDoS 之 SYN flood[](#ddos%e4%b9%8bsyn-flood)
-------------------------------------------

原理，大量主机发送 SYN 请求给服务器，假装要链接 TCP 建立链接。这些 SYN 请求可能含有假的源地址，所以服务器响应以后永远收不到 Ack，就会留下 half-open 状态的 TCP 链接。由于每个 TCP 链接都会消耗一定的系统资源，所以大量的无用连接会影响到真正的用户访问，导致拒绝访问情况产生。

TCP window full[](#tcp-window-full)
-----------------------------------

表示这个包的发送方已经把对方所声明的接收窗口耗尽了。

TCP Zerowindow[](#tcp-zerowindow)
---------------------------------

TCP 中的 “win=” 代表接收窗口的大小，表示这个包的**发送方**当前还有多少缓冲区可以接收数据。

上面这两个的区别：TCP window full 表示这个包的发送方暂时没办法再发送数据了，TCP Zerowindow 表示这个包的发送方暂时没办法再接受数据了。也就是说两者都意味着传输暂停，都必须引起重视。

Package size limited during capture[](#package-size-limited-during-capture)
---------------------------------------------------------------------------

```
1# ip route get 172.16.0.52
2172.16.0.52 dev **en0**  src 172.16.0.52
3# ip route get develop.pansft.com
4172.22.183.226 via 10.222.1.1 dev **utun8**  src 10.222.1.4
5# ip route get www.ilikejobs.com
6104.21.42.70 via 172.16.0.1 dev **en0**  src 172.16.0.52
```

TCP Previous segment not captured[](#tcp-previous-segment-not-captured)
-----------------------------------------------------------------------

TCP 传输过程中，同一台主机发出的数据段应该是连续的，即后一个包的 Seq 号等于前一个包的 Seq+Len（三次握手和四次挥手是例外）。

如果 wireshark 发现一个包的 seq 号大于前一个包的 seq+len，就知道中间缺失了一段数据。假如缺失的那段数据在整个网络包中都找不到（即排除乱序），就会提示 [TCP Previous segment not captured]。

🔔：

网络包没有抓到分两种情况，一种是真丢了，另一种是实际上没有丢，但是被抓包工具漏掉了。

在 Wireshark 上如何区分这两种情况呢，只需要看对方回复的 ACK 即可，如果确认包含了没抓的那个包，那就是抓包工具漏掉了而已，否则就是真丢了。

`注意：网络传输路径中有可能网络设备MTU比较小，会导致丢包，需要保持网络路径的MTU一致。`

TCP Acked unseen segment[](#tcp-acked-unseen-segment)
-----------------------------------------------------

当 Wireshark 发现被 ACK 的那个包没有抓到，就会提示 TCP ACKED unseen segment，这个几乎是可以永远忽略的。

TCP Out-of-order[](#tcp-out-of-order)
-------------------------------------

TCP 在传输过程中（不包含三次握手，四次挥手），同一台主机发出的数据包应该是连续的，即最后一个包的 Seq 号等于前一个包的 Seq+len。

小跨度的乱序影响不大，比如原本顺序 为 1、2、3、4、5 号包被打乱城 2、1、3、4、5 就没事，但跨度大的乱序可能触发快速重传，比如打乱城 2、3、4、5、1 时，就会触发足够多的 Dup Ack，而导致 1 号包的重传。

TCP Dup ACK[](#tcp-dup-ack)
---------------------------

当乱序或者丢包发生时，接受方会收到一些 Seq 号比期望值大的包，它每次收到这种包就会 Ack 一次期望的 Seq 值，以此方式来提醒发送方，于是就产生了一些重复的 ack，Wireshark 会在这些重复的 ack 上打标记 [TCP Dup Ack]。

TCP Fast Retransmission[](#tcp-fast-retransmission)
---------------------------------------------------

当发送方收到 3 个以上或者 TCP Dup ACK，就意味着之前发送的包可能丢了，于是快速重传它。

TCP Retransmission[](#tcp-retransmission)
-----------------------------------------

如果一个包真的丢了，有没有后续的包可以在接受方触发 Dup Ack 时，就不会快速重传，这种情况只能等到超时了再重传，此类包就会被 Wireshark 打上 TCP Retransmission。

此处可以重点学习一下。

TCP Segment of a reassembled PDU[](#tcp-segment-of-a-reassembled-pdu)
---------------------------------------------------------------------

这个表示可以把属于同一个应用层的 PDU 的 TCP 包虚拟地集中起来，在最后形成一个完整的包。

需要在 Wireshark 里面启用这个配置。在：Preferences→ Protocols→TCP 菜单，如下图：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2031.png) 

Continuations to[](#continuations-to)
-------------------------------------

跟上面的相反，需要关闭 Allow sub dissector to reassemble tcp streams 这个开关，就会显示这个信息。

Time-to-live exceeded（Fragment reassembly time exceeded)[](#time-to-live-exceededfragment-reassembly-time-exceeded)
-------------------------------------------------------------------------------------------------------------------

表示这个包的发送方之前就收到了一些分片，但是由于某些原因迟迟无法组装起来。

为什么 MacBook 上提示：You don’t have permission to capture on local interfaces.[](#%e4%b8%ba%e4%bb%80%e4%b9%88macbook%e4%b8%8a%e6%8f%90%e7%a4%bayou-dont-have-permission-to-capture-on-local-interfaces)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

解决方法：

```
1可以通过-s参数来指定抓包的大小，下面就是指定每个包抓1000字节的包。
2[root] tcpdump -i eth0 -s 1000 -w /tmp/tcpdump.cap
```

参考：[https://andrewbaker.ninja/2023/01/14/macbook-fixing-the-wireshark-permissions-bug-you-dont-have-permission-to-capture-on-that-device/](https://andrewbaker.ninja/2023/01/14/macbook-fixing-the-wireshark-permissions-bug-you-dont-have-permission-to-capture-on-that-device/)

四次挥手的疑惑[](#%e5%9b%9b%e6%ac%a1%e6%8c%a5%e6%89%8b%e7%9a%84%e7%96%91%e6%83%91)
---------------------------------------------------------------------------

如下图，这个包的 ack 为什么没有加 1 呢？

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2032.png) 

其实是因为延迟确认导致的这个问题，因为它省掉了四次挥手中的第二个包，所以流程如下图：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2033.png) 

因为启用了延迟确认，所以在第二个包和第三个包进行了合并。

但是图中的第 319 个包的 ACK 逻辑如下：

 ![](https://www.ilikejobs.com/posts/wireshark/wireshark%2034.png) 

此时，319 相当于 317 的 ack，但是 318 已经发出去了，所以 319 根本不算挥手的过程包。

这里只有 318、320、321 是真正的挥手包。

* * *

* * *