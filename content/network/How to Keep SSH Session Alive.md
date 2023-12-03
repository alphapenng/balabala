> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [linuxiac.com](https://linuxiac.com/how-to-keep-ssh-session-alive/)

> Experience hassle-free SSH sessions. Follow our guide to keep your connections alive and eliminate fr......

**Experience hassle-free SSH sessions. Follow our guide to keep your connections alive and eliminate freezing troubles.**

In remote server management and secure data transfer, SSH (Secure Shell) stands as an indispensable tool. However, its convenience and security can sometimes be marred by a common frustration: frozen SSH sessions.

Moreover, the sudden disruption of a session can lead to lost work, delayed projects, and a sense of helplessness.

But fear not, for there is a solution at hand. This comprehensive guide unveils the secrets to maintaining active and responsive SSH connections, ensuring a seamless experience devoid of freezing troubles.

So, say goodbye to frustration and hello to efficient, uninterrupted SSH sessions. But before we move forward, let’s answer an important question.

Why Does SSH Close the Connection?
----------------------------------

The short answer is that it all comes down to TCP timeouts. TCP timeout refers to the duration that a TCP connection or a network operation waits for a response before considering the process failed.

In Linux, TCP timeout settings determine how long a TCP connection or operation should wait before assuming that a packet has been lost or a connection has become unresponsive.

This mechanism is crucial for ensuring that network communication is reliable and efficient.

In the case of keeping the SSH connection alive, there are three key system parameters that we will briefly discuss below.

*   **tcp_keepalive_time**: determines the interval between sending out TCP keepalive probes on an idle TCP connection. Keepalive probes check whether a remote peer is still alive and responsive, even when no data is being transferred.
*   **tcp_keepalive_probes**: a small packet sent by a TCP endpoint to check the health and responsiveness of the remote endpoint in an idle connection. It detects if the remote endpoint has become unreachable or the connection has been lost due to network issues.
*   **tcp_keepalive_intvl**: controls the interval between sending keepalive probes on an idle TCP connection.

Each value is in seconds and can be easily checked with the commands below.

```
cat /proc/sys/net/ipv4/tcp_keepalive_time
cat /proc/sys/net/ipv4/tcp_keepalive_probes
cat /proc/sys/net/ipv4/tcp_keepalive_intvl
```

[![](https://cdn.shortpixel.ai/spai/q_glossy+w_888+to_auto+ret_img/linuxiac.com/wp-content/uploads/2023/08/ssh-keepalive01.jpg)](https://linuxiac.b-cdn.net/wp-content/uploads/2023/08/ssh-keepalive01.jpg)Checking keepalive values in Linux.

What does it all mean? Keepalive time is 7200 seconds, or 120 minutes (2 hours). However, this does not mean your SSH session will be kept alive for 2 hours, as the following two parameters are crucial.

The system’s default settings send nine probes at 75-second intervals, totaling 675 seconds, after which the session is considered failed and closed.

In other words, after just over 11 minutes, your SSH session will be terminated on inactivity – i.e., if you don’t type something into the terminal.

Of course, you can adjust these settings, but this is not the right way to go. SSH offers its mechanism to keep sessions alive, which we’ll show you below.

How to Keep SSH Session Alive
-----------------------------

Keeping an SSH session alive is a process that involves configuration on both the client and server sides.

### Client-Side Configuration (Linux)

On the client side, your Linux desktop system, create a file in your home directory (if it doesn’t already exist) “_~/.ssh/config_.”

```
touch ~/.ssh/config
```

However, if the “_~/.ssh_” directory does not exist, you must create it, then set the appropriate permissions.

```
mkdir ~/.ssh
chmod 700 ~/.ssh
```

```
nano ~/.ssh/config
```

```
Host *
ServerAliveInterval 120
ServerAliveCountMax 30
```

Here’s what each option means:

*   **Host**: The configurations specified only apply to the hosts listed following the “_Host_” keyword. Because we used a wildcard character (*), they apply to all hosts.
*   **ServerAliveInterval**: Sets a timeout interval in seconds, after which, if no data has been received from the server, SSH will send a message through the encrypted channel to request a response from the server. The default is 0, indicating that these messages will not be sent to the server.
*   **ServerAliveCountMax**: Sets the number of server alive messages which may be sent without SSH receiving any messages back from the server. If this threshold is reached while server-alive messages are being sent, SSH will disconnect from the server, terminating the session. The default value is 3.

In other words, the client will send a keepalive message to the server every 120 seconds (2 minutes), 30 times. 120 * 30 = 3600 seconds, or one hour. This is the total amount of time for which, even without activity, our SSH session will be kept alive.

### Client-Side Configuration (Windows)

To keep their SSH session alive, Windows users using PuTTY for remote access over SSH must set the “_Seconds between keepalives_” option in the “_Connection_” tab to a value greater than zero.

In the example shown below, we have set this value to 60, meaning that every minute the PuTTY client will send a keepalive message to the server to keep the SSH connection alive.

[![](https://cdn.shortpixel.ai/spai/q_glossy+w_794+to_auto+ret_img/linuxiac.com/wp-content/uploads/2023/08/ssh-keepalive03.jpg)](https://linuxiac.b-cdn.net/wp-content/uploads/2023/08/ssh-keepalive03.jpg)Change the keepalive settings on PuTTY.

Of course, don’t forget to save your changes for the PuTTY session (“_Category_” > “_Saved Sessions_” > “_Save_“).

### Server-Side Configuration

Changing the server’s timeout options affects all clients who connect to the server. You need to edit the “_/etc/ssh/sshd_config_” file to do this.

```
sudo nano /etc/ssh/sshd_config
```

Then set the following three options:

```
TCPKeepAlive yes
ClientAliveInterval 120 
ClientAliveCountMax 30
```

[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA5MDQgNTQ0IiB3aWR0aD0iOTA0IiBoZWlnaHQ9IjU0NCIgZGF0YS11PSJodHRwcyUzQSUyRiUyRmxpbnV4aWFjLmNvbSUyRndwLWNvbnRlbnQlMkZ1cGxvYWRzJTJGMjAyMyUyRjA4JTJGc3NoLWtlZXBhbGl2ZTAyLmpwZyIgZGF0YS13PSI5MDQiIGRhdGEtaD0iNTQ0IiBkYXRhLWJpcD0iIj48L3N2Zz4=)](https://linuxiac.b-cdn.net/wp-content/uploads/2023/08/ssh-keepalive02.jpg)Change the keepalive settings on the SSH server.

Here’s what each of these three options means:

*   **TCPKeepAlive**: Specifies whether the system should send TCP keepalive messages to the client.
*   **ClientAliveInterval**: Sets a timeout interval in seconds, after which, if no data has been received from the client, the SSH server will send a message through the encrypted channel to request a response from the client. The default is 0, indicating that these messages will not be sent to the client.
*   **ClientAliveCountMax**: Sets the number of client alive messages which may be sent without the SSH server receiving any messages back from the client. If this threshold is reached while client-alive messages are being sent, the SSH server will disconnect the client, terminating the session. The default value is 3.

As in the case above with the client-side configuration, the SSH server will keep the connection alive for one hour (120 * 30 = 3600 seconds).

Finally, restart the SSH server:

```
sudo systemctl restart ssh
```

Bottom Line
-----------

Implementing SSH timeouts and keepalives presents a nuanced balance between enhancing security and ensuring reliable connections.

The benefits of SSH timeouts and keepalives are evident in their contribution to network security by automatically terminating idle sessions, thus mitigating the risk of unauthorized access and potential attacks.

On the other hand, drawbacks emerge from an overzealous application of timeouts and keepalives. Excessively aggressive settings can lead to unintended disconnects, hindering productivity and causing frustration for users.

So, to strike the right balance, administrators must carefully consider their network infrastructure and user behavior. Doing so creates a secure and efficient environment for remote communication, fostering user satisfaction and data protection.

See the [client-side](http://man.openbsd.org/ssh_config) or the [server-side](http://man.openbsd.org/sshd_config) man files for further information on additional config file options.