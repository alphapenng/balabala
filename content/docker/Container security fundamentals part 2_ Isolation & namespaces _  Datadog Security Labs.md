> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [securitylabs.datadoghq.com](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-2/)

> A look at how Docker containers use namespaces for isolation

In the [first part](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-1/) of this series, we explored how containers are really just Linux processes. Now we need to understand how containers are isolated from the rest of the machine. In other words, how do we make sure that a process running in one container can’t easily interfere with the operation of another container or the underlying host?

Linux containers use several different mechanisms to provide isolation, as shown below. Each of these layers can be used independently of containerization. Indeed, some of them, including namespaces, the focus of this post are used by standard Linux processes as part of their operation.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/isolation-layers.png?auto=format&w=896&dpr=1.25) Container Isolation Layers

In comparison to virtual machines, one of the more powerful aspects of Linux container isolation is that it provides the flexibility to control the level of isolation in place. However, this can also lead to security weaknesses. As we come to understand more about how container isolation works, we will start to see how these layers can be manipulated to suit different scenarios. We will also explore how we can use standard Linux tooling to interact with those layers and troubleshoot container security issues.

This post focuses on the first of these layers of isolation: Linux namespaces.

[Namespaces](#namespaces)
-------------------------

Linux namespaces allow the operating system to provide a process with an isolated view of one or more system resources. Linux currently supports [eight namespaces](https://man7.org/linux/man-pages/man7/namespaces.7.html):

*   Mount
*   PID
*   Network
*   Cgroup
*   IPC
*   Time
*   UTS
*   User

Namespaces are a critical part of how containers are secured, as they restrict a contained process's view of the rest of the host. Understanding how namespaces work can also be helpful for securing containers and troubleshooting problems. Namespaces are quite flexible, in that they can be applied individually or in groups to one or more processes. It’s also possible to use standard Linux tools to interact with them, which opens up some interesting possibilities for debugging containers and performing security investigations of running container instances.

We can use the [`lsns` command](https://man7.org/linux/man-pages/man8/lsns.8.html) to view namespaces on the host, as shown below. This utility comes as part of the [`util-linux` package](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-2/%E2%80%8B%E2%80%8Bhttps://github.com/util-linux/util-linux) on most Linux distributions.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_1.png?auto=format&w=896&dpr=1.25) Output of the lsns command

The “NPROCS” field shows that 238 processes are using the first set of namespaces on this host. We can also see that some processes have been assigned to their own namespaces (generally either `mnt` or `uts`). These processes weren't started by Docker, but they are making use of specific namespaces to isolate their resources.

After using Docker to start a new container with the command `docker run -d nginx`, rerunning `sudo lsns` will show a new set of namespaces for our NGINX processes (highlighted below). By default, Docker makes use of the `mnt`, `uts`, `ipc`, `pid`, and `net` namespaces when it creates a container.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_2.png?auto=format&w=896&dpr=1.25) lsns output with a Docker container running

Now that we've covered namespaces at a high level, let's take a look at each individual namespace in more detail.

[Mount namespace](#mount-namespace)
-----------------------------------

The mount (`mnt`) namespace provides a process with an isolated view of the filesystem. It can be useful for ensuring that processes don’t interfere with files that belong to other processes on the host. When using the `mnt` namespace, a new set of filesystem mounts is provided for the process in place of the ones it would receive by default.

We can see which mount namespaces are used by a process by looking in the `/proc` filesystem; the information is contained in `/proc/[PID]/mountinfo`. We can also use a tool like [`findmnt`](https://man7.org/linux/man-pages/man8/findmnt.8.html), which will provide a nicely formatted version of the same information.

When using these kinds of tools, we first need to find the process ID of our container. One way to do this is by using [Docker’s inspect command](https://docs.docker.com/engine/reference/commandline/inspect/).

Running `docker inspect -f '\{\{.State.Pid\}\}' [CONTAINER]` will return the PID information, allowing us to run `findmnt -N [PID]` to get the mount information.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_3.png?auto=format&w=896&dpr=1.25) Using docker inspect and findmnt to examine mnt namespaces

In the screenshot above, we can see that our container has a root filesystem mount in `/var/lib/docker`, where Docker stores all of the image and container filesystem layers. Container runtimes use [OverlayFS](https://jvns.ca/blog/2019/11/18/how-containers-work--overlayfs/) to help improve performance and lower the storage requirements of containers.

An important security-related point to keep in mind is that all of the root filesystems used by the containers on a host will be in a directory managed by the container runtime tool (`/var/lib/docker/` by default). As such, you'll definitely want to ensure that strong filesystem permissions are in place on that directory and that it’s being monitored for unauthorized access.

We can see some more information about the root filesystem by looking in `/proc` again. Specifically, `/proc/[PID]/mountinfo` has all the information about the mounts provided to that process:

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_4.png?auto=format&w=896&dpr=1.25) Output of mountinfo in /proc

We can also use other Linux tooling to interact with the namespaces created by Docker. This is a useful technique when troubleshooting containers or investigating possibly malicious activity occurring in a container. One such tool that is very useful for interacting with namespaces is [nsenter](https://man7.org/linux/man-pages/man1/nsenter.1.html). We can use it to execute commands inside containers, without needing to install or use the Docker CLI. Nsenter should be available on most Linux systems, but if it’s not installed, it can generally be added as part of the `util-linux` package.

The command `sudo nsenter --target 2525 --mount ls /` will show us the root filesystem of our container, as shown below. This type of information can be helpful during a threat hunt or forensic review.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_5.png?auto=format&w=896&dpr=1.25) Using nsenter to list files in a container

[PID namespace](#pid-namespace)
-------------------------------

The PID namespace allows a process to have an isolated view of other processes running on the host. Containers use PID namespaces to ensure that they can only see and affect processes that are part of the contained application. Multiple containers may also share the same PID namespace. This can be helpful for troubleshooting, as you can create a diagnostics container in the same namespace as an application container, and use it to run troubleshooting tools on the main application process.

We can use nsenter to show the list of processes running inside a container. To do this, we will need a container image that has the `ps` binary, as we’re going to enter the `pid` and `mnt` namespaces that `ps` needs to get a process list. (The reason for entering the `mnt` namespace as well is that we'll need to mount the `/proc` filesystem in order to allow `ps` to get that information.)

We can get a `busybox` image running as a container in the background with `docker run --name busyback -d busybox top` (this runs the `top` program in the container so it doesn’t exit). Then we’ll use `docker inspect` to get the PID of our container and use nsenter to examine the process list inside the container, as shown below. This allows us to see our `top` process running.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_6.png?auto=format&w=896&dpr=1.25) Using nsenter and ps on a container

Another way to demonstrate the PID namespace is to use Linux’s [unshare utility](https://man7.org/linux/man-pages/man1/unshare.1.html) to run a program in a new set of namespaces.

Running `sudo unshare --pid --fork --mount-proc /bin/bash` will provide us with a bash shell in a new PID namespace.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_7.png?auto=format&w=896&dpr=1.25) Using unshare to create a new PID namespace

When running containers, it can also be helpful to use PID namespaces to see the processes running in another container. The `--pid` switch on `docker run` allows us to start a container for debugging purposes in the process namespace of another container.

To demonstrate this, we’ll start a web server container by running `docker run -d --name=webserver nginx`. Then we'll start a debugging container by running `docker run -it --name=debug --pid=container:webserver raesene/alpine-containertools /bin/bash`. If we then run the `ps -ef` command, we can see the processes from our original web server container as well as the processes from our debugging container.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_8.png?auto=format&w=896&dpr=1.25) docker debug using PID namespaces

Sharing the process namespace across containers is also possible in Kubernetes clusters, where it can be useful for debugging issues. If you want to share namespaces across a pod, it requires an option to be passed when the workload you want to debug is started. Specifically, you need to include `shareProcessNamespace: true` in your pod specification, as mentioned in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/).

[Network namespace](#network-namespace)
---------------------------------------

Next on the list of namespaces is the network (`net`) namespace. This is responsible for providing a process's network environment (interfaces, routing, etc.). It is very useful for ensuring that contained processes can bind the ports they need without interfering with each other, and for verifying that traffic can be directed to specific applications.

As with the previously mentioned namespaces, it’s possible to interact with the network namespace by using standard Linux tools like nsenter. The first step is to get our container’s PID so we can use nsenter to look at the container’s network. This time, we'll use the `-n` switch on nsenter to enter the network namespace, and then we can use standard tools to show the container’s IP address, as shown below.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_9.png?auto=format&w=896&dpr=1.25) Using nsenter with net namespaces

An important point here is that the `ip` command we’re running is being sourced from the host VM and doesn’t have to exist inside the container. This makes it a useful technique for troubleshooting networking issues in locked down containers that don’t have a lot of utilities installed in them.

Another piece of Linux tooling that may be used to interact with network namespaces is the `ip` command itself, via the `netns` sub-command. This sub-command typically allows you to interact with various network namespaces on a system. Note, however, that it doesn’t work in Docker because the symlinks that `netns` relies on are not present.

It is possible to use Docker to share network namespaces, similarly to getting containers to share the PID namespace. We can launch a debugging container, perhaps with tools like tcpdump installed, and connect it to the network of the running container.

Running `docker run -it --name=debug-network --network=container:webserver raesene/alpine-containertools /bin/bash` would allow us to connect to the network of an existing container called “webserver.” Once it’s launched, we can run `netstat -tunap` to see listening ports, and it will show the web server running on port 80 from the other container.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_10.png?auto=format&w=896&dpr=1.25) Using netstat from a debug container

In Kubernetes environments, network namespace sharing will typically be in place for all containers in a single pod. Although you cannot launch a debugging container in an existing pod, you can use the new [ephemeral containers feature](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/#ephemeral-container) to dynamically add a container to the pod’s network namespace. We can demonstrate how this works by starting a pod with an NGINX image and then adding an ephemeral container to the pod by using the `kubectl debug` command. As we can see in the screenshot below, the ephemeral container has access to the network namespace of the original container.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_11.png?auto=format&w=896&dpr=1.25) Using kubectl debug

One interesting point to note here is that on the right-hand side of the `netstat` output, we can see that the PID information is not available. This is due to the fact that we’re only sharing the original container's network namespace, not the PID namespace.

It’s also possible to share the namespace of a specific container in a pod by using `kubectl debug`. Adding the `--target` switch and naming a specific container in the pod will allow kubectl to set the debug container to share the PID namespace of that container.

We can see from the screenshot below that the “PID/Program name” column now displays information about the NGINX program that’s running.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_12.png?auto=format&w=896&dpr=1.25) Using kubectl debug with target container

[Cgroup namespace](#cgroup-namespace)
-------------------------------------

[Control groups](https://man7.org/linux/man-pages/man7/cgroups.7.html) (cgroups) are designed to help control a process's resource usage on a Linux system. In containerization, they’re used to reduce the risk of “noisy neighbors” (containers that use so many resources that they degrade the performance of other containers on the same host).

Traditionally, cgroups assigned to processes were not namespaced, so there was some risk that information about processes would leak from one container to another. This led to the introduction of the cgroup namespace, which gives containers their own isolated cgroups.

Typically, there isn't any need to modify the cgroup namespace when running containers, but for demonstration purposes, let's see what happens if you were to modify the cgroups namespace settings on a container.

First we’ll start a container and look at the number of entries in `/sys/fs/cgroup`:

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_13.png?auto=format&w=896&dpr=1.25) cgroup files in a container namespace

But if we create another container that uses the host's cgroup namespace, we can see a lot more information available in that filesystem:

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_14.png?auto=format&w=896&dpr=1.25) cgroup files in the host namespace

And upon looking in the `/sys/fs/cgroup/system.slice/` directory of a container with access to the host's cgroup namespace, we can see that it contains information about system services running on the host. This is an example of the type of information leakage that is mitigated by using an isolated cgroup namespace.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_15.png?auto=format&w=896&dpr=1.25) Information disclosed in cgroup files

[IPC namespace](#ipc-namespace)
-------------------------------

The [IPC namespace](https://man7.org/linux/man-pages/man7/ipc_namespaces.7.html) is not relevant to many use cases, but it is enabled by default on container runtimes to provide isolation for certain types of resources like POSIX message queues.

[UTS namespace](#uts-namespace)
-------------------------------

The [UTS namespace](https://man7.org/linux/man-pages/man7/uts_namespaces.7.html) is another less commonly used namespace with a relatively specific purpose: setting the hostname used by a process. Linux container runtimes activate this namespace by default, which is why containers have different hostnames than their underlying VMs.

We can demonstrate this by starting a pair of containers. The first uses its own UTS namespace and the second shares the host’s UTS namespace (using the `--uts=host` flag). As you can see below, in the first container, we get a randomly assigned hostname and in the second, our hostname matches the underlying host's.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_16.png?auto=format&w=896&dpr=1.25) UTS namespace affecting hostname

[Time namespace](#time-namespace)
---------------------------------

The [time namespace](https://man7.org/linux/man-pages/man7/time_namespaces.7.html) was added in 2020, making it a relatively new Linux namespace. It allows for groups of processes to have different time settings than the underlying host, which can be useful for certain purposes, such as testing or stopping time from jumping forward when a container has been snapshotted and then restored.

At the moment, it’s not yet supported by all container runtimes. Runc, which is used by Docker, containerd, and CRI-O, is still in the process of [adding support to its specification](https://github.com/opencontainers/runtime-spec/pull/1151). However, if you want to use the time namespace in containers, support has been added to [Linux Containers (LXC)](https://discuss.linuxcontainers.org/t/lxc-5-0-lts-has-been-released/14381).

We can also demonstrate the time namespace by using the [unshare command](https://man7.org/linux/man-pages/man1/unshare.1.html). Below, you can see the effect by checking the uptime of a host first without a time namespace and then modifying the boot time assigned to a process while starting a new time namespace.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_17.png?auto=format&w=896&dpr=1.25) time namespace with unshare

[User namespace](#user-namespace)
---------------------------------

The [user namespace](https://man7.org/linux/man-pages/man7/user_namespaces.7.html) enables isolation of things like the user account running a process. Most importantly from a security perspective, it allows for processes to be root inside the namespace, without actually being root on the host. This is particularly useful in containerization, as some applications need to be root to run (for example, certain package managers). You can use user namespaces to enable those applications without introducing the risk of running the contained processes as the host’s root user (a common default setting for many container runtimes).

It’s possible to enable user namespaces on container runtimes like Docker. On others, like Podman, this is already enabled by default. At the moment, it’s not possible to use user namespaces in Kubernetes, but [work is underway to address that](https://github.com/kubernetes/enhancements/issues/127).

We can demonstrate the effect of user namespaces by using the unshare utility again. Running the command `unshare --fork --pid --mount-proc -U -r bash` will take us to a new shell where we appear to be the root user.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_18.png?auto=format&w=896&dpr=1.25) whoami in a user namespace

Given that we didn’t use `sudo` to run that command, this might seem like a case of bad privilege escalation. However, if we start another shell on our machine and look at the process list, we can see that the bash shell started by the unshare command is still running as our original user, not root.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_19.png?auto=format&w=896&dpr=1.25) Process list with user namespaces

Also, if we try to delete a file that only the root user would be able to access, it fails.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_20.png?auto=format&w=896&dpr=1.25) The root in a user namespace cannot edit system files

If you try to launch a new user namespace as a non-root user and it doesn’t work, it’s possible that this feature has been blocked at a host level. This feature may be disabled on some Linux distributions, as there have been some recent security vulnerabilities, like [CVE-2022-0185](https://www.willsroot.io/2022/01/cve-2022-0185.html), which were most easily exploited if users had the ability to create new user namespaces. You can verify this by looking at the value of the `kernel.unprivileged_userns_clone` sysctl. If it’s set to “1” (as below) the feature is enabled. If it’s set to “0” then unprivileged users won’t be able to create new user namespaces without using something like sudo.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-2/screenshot_21.png?auto=format&w=896&dpr=1.25) Unprivileged user namespace sysctl setting

[Conclusion](#conclusion)
-------------------------

Linux namespaces are a foundational part of how container runtimes like Docker work. We've seen how they can provide fine-grained isolation of a container’s view of the host’s resources in a number of ways. And, since they are a native Linux feature, we can use tools that ship with common Linux distributions to interact with them, aiding troubleshooting.

However, namespaces alone don’t provide a complete answer to how Linux containers are isolated from the host. Head over to the [next installment of this series](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-3/), where we examine how capabilities are implemented in Linux and how they restrict the rights of Linux’s all-powerful root user. We also explore how Docker uses capabilities to make sure that being root in a container doesn’t automatically allow a user to break out of the container and compromise the host: [Container security fundamentals part 3: Capabilities](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-3/).

You can also subscribe to our RSS feed [here](https://securitylabs.datadoghq.com/rss/feed.xml), or use this [direct Feedly link](https://feedly.com/i/subscription/feed%2Fhttps%3A%2F%2Fsecuritylabs.datadoghq.com%2Frss%2Ffeed.xml).