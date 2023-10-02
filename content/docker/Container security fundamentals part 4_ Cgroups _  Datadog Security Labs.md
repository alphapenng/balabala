> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [securitylabs.datadoghq.com](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-4/)

> A look at how cgroups are used in Linux and container systems

Managing system resources can be a challenge when multiple processes are running on a host. A single misbehaving program could consume all available resources, causing the entire system to crash. To tackle this problem, Linux relies on control groups (cgroups) to manage each process's access to resources, such as CPU and memory.

Docker and other containerization tools use cgroups to restrict the resources that containers can use, which can help avoid "noisy neighbor" issues. This is particularly helpful when working with Kubernetes, as workloads from multiple applications frequently share resources on the same host.

In this post, we will take a closer look at cgroups and explore how they ensure that each process has access to the resources it requires to operate efficiently. We will also cover several security aspects of cgroups, including how you can use cgroups to reduce the risk of denial-of-service attacks and manage containers' access to specific devices on a host.

[cgroups v1 and v2](#cgroups-v1-and-v2)
---------------------------------------

It's worth noting that two versions of cgroups might be utilized on a given host, depending on the Linux distribution and version. Control group v2 provides management benefits over the original implementation and is required for certain container features, such as [rootless containers](https://docs.docker.com/engine/security/rootless/#known-limitations).

Control group v2 was initially introduced in version 4.5 of the Linux kernel in 2016, but it only recently became the default in some distributions. To determine which version(s) are running on a host, you can verify the mounted filesystems. For instance, if you execute the command `mount | grep cgroup` on an Ubuntu 20.04 host, you will see one line for "cgroup2" and several for "cgroup," indicating that both systems are installed.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-1.png?auto=format&w=896&dpr=1.25) cgroup mount list - Ubuntu 20.04

However, if you run the same command on an Ubuntu 22.04 system, you will only see cgroup v2.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-2.png?auto=format&w=896&dpr=1.25) cgroup mount list - Ubuntu 22.04

Since cgroup v2 is the version that is used in recent Linux distributions, we will focus on v2 in the remainder of our examples.

[Cgroups basics](#cgroups-basics)
---------------------------------

There are several ways to examine the cgroups that are used on a Linux host. One option is to use the `/proc` filesystem to view the cgroups that are being used for a specific process (for instance, the bash shell of the running user).

Executing the command `cat /proc/[PID]/cgroup` will reveal the cgroup "slice" and "scope" to which the process belongs (slices and scopes are utilized to organize cgroups and processes). In the following example, we first used `ps -fC bash` to obtain the process ID of our shell. We then used that process ID to discover the cgroup session that it employs.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-3.png?auto=format&w=896&dpr=1.25) Finding the cgroup scope and slice for a bash shell

To see the available resources that can be modified for that process, you can look in the `/sys` filesystem, which corresponds to the information we obtained from the previous command (e.g., `/sys/fs/cgroup/user.slice/user-1000.slice/session-4.scope`):

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-4.png?auto=format&w=896&dpr=1.25) Showing resources for a given cgroup scope

This manual process can be time-consuming, so you can leverage higher-level utilities that present cgroup information in a more organized way. For example, `systemd-cgls` can display a hierarchical view of the different cgroup scopes on the host.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-5.png?auto=format&w=896&dpr=1.25) Using systemd-cgls for a hierarchical view of cgroup information

Additionally, the [`lscgroup`](https://linux.die.net/man/1/lscgroup) utility from the `cgroup-utils` package can be useful for examining cgroup information.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-6.png?auto=format&w=896&dpr=1.25) Using lscgroup to show cgroup information

[Using cgroups to limit resources](#using-cgroups-to-limit-resources)
---------------------------------------------------------------------

Now that we have an understanding of how to view cgroup information, the next step is to explore how we can use cgroups to restrict the resources available to processes, which can help alleviate denial-of-service risks. To demonstrate this, we will employ the [`stress` tool](https://linux.die.net/man/1/stress) to simulate an attacker or misbehaving application consuming all of the CPU on our host.

Inside a Docker container, we can utilize the command `stress -c 2`, which will start two processes that consume a total of 2 cores of CPU. Then, by executing the `top` command in another window, we can verify the effect on the host's CPU.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-7.png?auto=format&w=896&dpr=1.25) Using the stress tool to consume CPU resources

Docker offers various options for limiting the amount of CPU time the container can utilize, but the simplest is the `--cpus` flag, which allows you to specify a decimal number of CPUs that can be utilized. Under the covers, Docker leverages cgroups to enforce this limit.

For example, executing `docker run --name stress --cpus 0.5 -it stressimage /bin/bash` will restrict the container to 0.5 CPUs. After utilizing the same `stress` command from the previous container, we can observe the results of this restriction in `top`.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-8.png?auto=format&w=896&dpr=1.25) CPU resource usage being constrained by cgroups

Instead of being able to utilize two CPU cores, the stress processes are now restricted to 0.5 CPUs (25 percent of a core for each process).

We can also observe the details of the cgroup restriction that Docker implemented by examining the underlying filesystem. To accomplish this, we first obtain the process ID of our Docker container using `docker inspect -f '{{.State.Pid}}' stress`. Then we can look up the cgroup information for this process. The container's cgroup directory contains a `cpu.max` file that displays a value of `50000 100000`, which is equivalent to 0.5 CPUs. By default, Docker does not restrict a process's CPU usage, so the file would display a value of `max 100000`. If an attacker got access to this container, they could use all of the CPU resources on the host (for example, to mine cryptocurrency).

[Using cgroups to defeat fork bombs](#using-cgroups-to-defeat-fork-bombs)
-------------------------------------------------------------------------

A common denial-of-service attack on Linux systems is known as a [fork bomb](https://en.wikipedia.org/wiki/Fork_bomb), which occurs when an attacker generates a very large number of processes, ultimately depleting the system's resources. By default, containers (and other Linux processes) are not restricted in terms of how many new processes they can generate, which means that any process can create a fork bomb.

Cgroups have the ability to restrict the number of processes that can be spawned, which effectively safeguards the host from a fork bomb attack. We can demonstrate this by using the `--pids-limit` flag as part of the `docker run` command, which will essentially set the appropriate cgroup.

To see how this works, we can launch a container with the command `docker run -it --pids-limit 10 ubuntu:22.04 /bin/bash`, which will restrict the container to a maximum of 10 processes. Then we can execute a bash fork bomb with the command `:(){ :|: & };:`

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-4/screenshot-9.png?auto=format&w=896&dpr=1.25) Docker PID limits in effect with a fork bomb

Very quickly, the container reaches the limit of 10 processes, and errors are displayed. However, the underlying host will remain responsive, preventing the denial-of-service attack.

[Using cgroups to control device access](#using-cgroups-to-control-device-access)
---------------------------------------------------------------------------------

Another security-related aspect of cgroups is that they can be used to control access to devices. Containers provide access to a range of devices on the host machine, as detailed in runc's [allowed devices list](https://github.com/opencontainers/runc/blob/main/libcontainer/specconv/spec_linux.go#L188), and it is possible to utilize Docker's functionality (which uses cgroups) to add other devices to that list. This allows you to give specific containers access to hardware (such as an audio device).

You can add the [`--device` option](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) to a `docker run` command to grant access to a device. For instance, executing `docker run -d --rm --device /dev/dm-0 --name webdevice nginx` generates a container that has access to the `/dev/dm-0` device.

Linux tools do not provide as much information for examining cgroup access to devices, compared to other resources like CPU or memory. In cgroup v2, eBPF programs are utilized to [manage access to devices](https://docs.kernel.org/admin-guide/cgroup-v2.html#device-controller), so the standard tooling won't work. Instead, the `bpftool` program is required. You can use this program to list the eBPF programs associated with any given cgroup, providing some visibility into the container's access to the host, although not with great deal of detail.

[Conclusion](#conclusion)
-------------------------

Controlling shared resources is a critical aspect of ensuring that multiple containers can effectively share a single server. In this post, we introduced cgroups, which are the primary mechanism that Linux systems use to achieve this control. We also demonstrated how cgroups can be utilized to help alleviate common denial-of-service attacks and manage access to specific devices that are connected to a host.

So far, all of the security mechanisms that we have examined have been under the control of the `root` user on the system. However, there are also occasions when we want to restrict the actions of the `root` user. In the [next post](http://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-5), we will explore how Mandatory Access Control (MAC) systems like SELinux and AppArmor can accomplish this.