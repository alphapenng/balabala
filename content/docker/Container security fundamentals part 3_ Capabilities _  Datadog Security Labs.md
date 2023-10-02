> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [securitylabs.datadoghq.com](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-3/)

> A look at how capabilities are used in Linux and container systems

In the [previous part](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-2/) of this series, we mentioned that Docker containers don’t yet make use of the time namespace. We also explored how containers run as the root user in many cases. With those two points in mind, what would happen if we tried to change the date and time inside of a container?

To test this out, we’ll start a new container with `docker run -it ubuntu:22.04 /bin/bash`. Then we'll try changing the time with `date +%T -s “08:08:08”`. This gives us the response `date: cannot set date: Operation not permitted`.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-1.png?auto=format&w=896&dpr=1.25) root user cannot change time in a container

Given that we’re the root user who would usually be able to set the time on a host, there must be some other feature that's preventing this from working.

The answer is the focus of this post: Linux capabilities.

[What are Linux capabilities?](#what-are-linux-capabilities)
------------------------------------------------------------

Traditionally in Linux, there was a divide between the all-powerful root user and ordinary, unprivileged users. If a process needed to do anything only the root user could do, it would have to run with `sudo` or the binary would need to be changed to be “setuid root,” meaning that it could do _anything_ root could do. From a security perspective, this is not ideal because it’s not at all granular, which introduces additional risk when vulnerabilities are found in programs that are setuid root.

This problem led to the introduction of [Linux capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html#NAME). Capabilities split up the monolithic root privilege into 41 (at the time of publication) privileges that can be individually granted to processes or files. Some of these privileges are fairly fine-grained, like `CAP_AUDIT_READ`, which controls the right to read audit logs. Others are wide-ranging, like `CAP_SYS_ADMIN`, which grants a wide array of privileged actions, such as the ability to mount and unmount filesystems on the host.

[Investigating capabilities](#investigating-capabilities)
---------------------------------------------------------

Like namespaces, capabilities are used outside of containerization by standard Linux daemons and utilities. We can use the [`pscap` program](https://man7.org/linux/man-pages/man8/pscap.8.html) from the `libcap-ng-utils` package to see what capabilities have been granted to processes on our host. `pscap` will only list programs that have been granted any capabilities; unprivileged processes will not be listed.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-2.png?auto=format&w=896&dpr=1.25) pscap shows processes with capabilities

The screenshot above shows `pscap` output from an Ubuntu 22.04 virtual machine. While quite a few processes are running with full capabilities, others have been given limited capabilities.

We can also use the [`filecap` program](https://man7.org/linux/man-pages/man8/filecap.8.html) from the same package to investigate where capabilities have been added to specific programs. Adding capabilities to programs is a good alternative to making those programs setuid root because it would help reduce the risk of privilege escalation if an attacker were to exploit vulnerabilities in one of those programs.

Running `sudo filecap -a 2>/dev/null` will show all the programs on the system that have had capabilities applied to them. (As an aside, the `2>/dev/null` part of that command is just a method to stop error lines from printing out, making it easier to see the information we’re looking for.)

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-3.png?auto=format&w=896&dpr=1.25) using filecap to show files with capabilities

From the output, we can see that several instances of the `ping` utility have been granted the `net_raw` capability (`CAP_NET_RAW`) that is needed for creating Internet Control Message Protocol (ICMP) packets that are commonly used by `ping`.

Let's take a look at an example of how you could use capabilities to allow a program to do something that requires elevated privileges. We will create a simple [Golang web server](https://github.com/raesene/golang-demos/tree/main/webserver) that listens on port 80 and replies to a request. If we compile it and then try to run it, we get a `permission denied` error message.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-4.png?auto=format&w=896&dpr=1.25) an ordinary user cannot bind port 80/TCP

Now let's see what happens if we then use the `setcap` utility to add the `CAP_NET_BIND_SERVICE` to the binary and run it again. The error no longer occurs and the program runs successfully.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-5.png?auto=format&w=896&dpr=1.25) With a file capability the webserver can bind port 80/TCP

[Capabilities and containers](#capabilities-and-containers)
-----------------------------------------------------------

Now that we’ve seen how capabilities are used on Linux systems, let’s take a look at how they’re used in containers. We can start by running a container on our host with `docker run -d nginx` and then using `pscap` again to see what has changed.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-6.png?auto=format&w=896&dpr=1.25) pscap showing the capabilities of nginx running in a container

We can see that our NGINX process has been granted a set of capabilities. This screenshot shows the set of capabilities that Docker grants to containers by default. This set was designed so that most workloads would be able to run inside containers successfully, while restricting any capabilities that could lead to privilege escalation attacks.

It’s also possible to check which capabilities a container has from the inside of the container. You can use tools like [amicontained](https://github.com/genuinetools/amicontained) to determine your effective rights. This will show the same set of capabilities we saw from outside of the container.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-7.png?auto=format&w=896&dpr=1.25) amicontained can be used to show the capabilities available inside a container

It’s possible to either increase or decrease a container's rights by using [Docker's `cap-add` and `cap-drop` flags](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) to add and drop capabilities.

[Minimizing a container's set of capabilities](#minimizing-a-containers-set-of-capabilities)
--------------------------------------------------------------------------------------------

We've seen that Docker containers are provided with a set of capabilities by default. Depending on your application, you may be able to drop some or all of these capabilities to help harden your containers. It's worth remembering that capabilities are rights granted to the root user. This means that if your application runs perfectly well as a non-root user, it should run fine in a container without any capabilities. In those cases, you can just drop all capabilities and it should work fine.

It's also worth noting that there are a couple of common cases when you traditionally would have needed capabilities, but no longer need them anymore.

The first example is `ping`. As we mentioned earlier, `ping` can make use of the `NET_RAW` capability. However, depending on the Linux distribution you’re using, it may not actually need that capability any longer.

Let’s demonstrate this on an Ubuntu 22.04 installation. If we use `getcap`, we can see that `ping` has the `NET_RAW` capability. However, if we use `setcap` to remove that capability and then try to `ping` again, it works!

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-8.png?auto=format&w=896&dpr=1.25) even without a file capability ping works ok

This is due to a feature known as “ping_group_range” that allows a Linux system to define a range of groups that can send ICMP echo requests without privileges. When we look at that setting on our test VM, we can see that the range is basically all groups, which explains why `ping` was able to work without the `NET_RAW` capability.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-9.png?auto=format&w=896&dpr=1.25) sysctl setting for ping range

In containers, this setting may vary depending on the runtime you’re using. It may also differ from the host-level setting, as the settings inside a specific network namespace do not need to align with host-level settings. Docker has had this feature enabled by default since 2020, so any recent version will automatically set the ping_group_range sysctl in the network namespace that’s created when you start a container. As of version 1.18, Kubernetes has added this to the list of [“safe” sysctls](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/#enabling-unsafe-sysctls), so even if your container runtime doesn’t set it, you can add this setting in a pod manifest.

The other common use case where a capability is needed (`NET_BIND_SERVICE`, in this case) is when binding a port in the “privileged” set (any port under 1024 by default). This is useful, for example, when creating a web server that binds port 80/TCP. As in the case of `ping`, there is a sysctl parameter that you can change to allow unprivileged processes to bind low ports. On an Ubuntu 22.04 host, we can see this parameter (`net.ipv4.ip_unprivileged_port_start`) is set to 1024 by default. This means that if we try to bind any port below 1024, such as port 80, it wouldn’t work unless we were root or the process had the `NET_BIND_SERVICE` capability.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-10.png?auto=format&w=896&dpr=1.25) sysctl setting for unprivileged port range

However, inside a container, the situation may differ depending on the runtime you’re using. Because this setting (and others relating to networking) can be managed at the network namespace level, Docker takes advantage of that by making changes that only affect a specific container. Below, you can see that the `net.ipv4.ip_unprivileged_port_start` parameter is set to 0 by default on a Docker container, allowing low ports to be bound by unprivileged users.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-3/screenshot-11.png?auto=format&w=896&dpr=1.25) sysctl setting for unprivileged port range inside a container

So we've seen that it’s likely that you can drop `NET_RAW` and `NET_BIND_SERVICE` from the containers you run, but what about all the other capabilities that are granted to Docker containers by default? Depending on what your container does, it may be possible to drop them, too. One basic way to test this out on your container is to drop all capabilities at once (i.e., by running your application container with the `cap-drop=ALL`) and then monitor for errors as it completes a run of its test suite. This should help you confirm if your container actually needs any specific capabilities to do its work.

[Conclusion](#conclusion)
-------------------------

In this blog post, we introduced capabilities, another layer of isolation used by Docker-style containers to separate individual containers from each other and the underlying host. Capabilities are a relatively flexible mechanism, and the isolation they provide can be strengthened or weakened as required for the operation of an application. We also saw how it’s possible (and preferable) to use capabilities as a way to grant root privileges on a more granular level than older, monolithic permission structures like setuid root. However, one of the problems that capabilities can’t solve is stopping one container from taking all of a host’s resources. In the next part of the series, we’ll look at how containers solve that problem with cgroups.