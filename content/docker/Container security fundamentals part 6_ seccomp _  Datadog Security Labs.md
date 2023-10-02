> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [securitylabs.datadoghq.com](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-6/)

> A look at how seccomp is used in Linux and container systems

Throughout [this series](https://securitylabs.datadoghq.com/articles/?s=container%20security%20fundamentals), we've covered various layers of security that can isolate containers not only from other processes on the host but also from their underlying host. In this post, we'll discuss how seccomp filters are used as a "last line of defense" by container runtimes.

[Syscalls and seccomp overview](#syscalls-and-seccomp-overview)
---------------------------------------------------------------

[Seccomp filters](https://www.kernel.org/doc/html/v4.19/userspace-api/seccomp_filter.html) are a way of restricting which [Linux syscalls](https://man7.org/linux/man-pages/man2/syscall.2.html) a process can perform. Syscalls are essentially the interface between userspace programs and the Linux kernel. Whenever a program needs access to a service provided by the host kernel (e.g., when opening a file or creating a new process), it uses a syscall to get that.

Linux machines offer a wide range of syscalls—currently, more than 300 are available. It's important to note that syscalls vary depending on the underlying hardware architecture. For example, you will see differences in the syscall table between ARM-based systems and AMD64 ones.

Seccomp filters are written [Berkeley Packet Filter (BPF)](https://en.wikipedia.org/wiki/Berkeley_Packet_Filter) programs that restrict which syscalls a process can make, allowing for very fine-grained restrictions to be put in place. The most widely used example of this is in containers, where users often run as root and there is a need to block dangerous syscalls that could allow for container breakout.

[Seccomp filters in Docker containers](#seccomp-filters-in-docker-containers)
-----------------------------------------------------------------------------

As part of the default set of restrictions that Docker puts in place, a [seccomp filter is applied to any new container](https://docs.docker.com/engine/security/seccomp/). This filter can catch cases where an action in a container would be allowed by the other layers of protection (e.g., [capabilities](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-3/)). Historically, there have been several cases where a security exploit would have been blocked by Docker's seccomp filter. One example is [CVE-2022-0185](https://blog.aquasec.com/cve-2022-0185-linux-kernel-container-escape-in-kubernetes), which uses the `unshare` syscall to exploit a vulnerability. This syscall is blocked by Docker's seccomp filter.

To create this seccomp filter, Docker created an allowlist of calls, and then blocked any syscalls not on the list. This means that we can avoid risks where a new dangerous syscall (i.e., one that can be used to escape a container) is added to the Linux kernel.

Let's illustrate the effect of Docker's seccomp filter by using a utility which calls a blocked syscall. In this case, we'll use `unshare`, which creates new namespaces on a host.

First, we'll run a standard Docker container with `docker run -it ubuntu:22.04 /bin/bash` and try the `unshare` command. This results in "Operation not permitted," due to the seccomp filter.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-6/screenshot-1.png?auto=format&w=896&dpr=1.25) Unshare blocked by seccomp

Next, we can start a container with the seccomp filter explicitly disabled (`docker run --security-opt seccomp=unconfined -it ubuntu:22.04 /bin/bash`). If we try running the same command again, we can see that it succeeds.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-6/screenshot-2.png?auto=format&w=896&dpr=1.25) Unshare allowed when Docker's seccomp filter is disabled

[Creating custom seccomp filters](#creating-custom-seccomp-filters)
-------------------------------------------------------------------

Although the Docker default seccomp profile provides a good level of isolation, there are some scenarios that call for different degrees of restrictions. In those cases, you'll need a custom seccomp profile.

For Docker, you can specify seccomp profiles in JSON format. For example, if you wanted a blank seccomp profile that would block all syscalls, it would look something like this:

```
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": [
    "SCMP_ARCH_X86_64",
    "SCMP_ARCH_X86",
    "SCMP_ARCH_X32"
  ],
  "syscalls": [
  ]
}
```

The `defaultAction` specifies what will be done when the syscall doesn't match any part of the policy. In this case, we have it as `SCMP_ACT_ERRNO`, which means that an error will be returned and the call is denied. Check out this [man page](https://man7.org/linux/man-pages/man3/seccomp_rule_add.3.html) to learn about other `defaultAction` options.

Of course, that's not very useful as policies go, as it'll essentially stop the container from working, and all containers need to make syscalls. A more practical example might be blocking some set of functionality which is generally allowed by Docker. For example, you may want to block the `io_uring` set of syscalls, as they've been involved in a large number of kernel vulnerabilities over the last couple of years, as mentioned by Google in their [kCTF retrospective](https://security.googleblog.com/2023/06/learnings-from-kctf-vrps-42-linux.html).

Here, the best approach would be to start from Docker's [default seccomp policy](https://github.com/moby/moby/blob/master/profiles/seccomp/default.json) and then just remove the relevant syscalls. In this case, that policy includes three `io_uring` related syscalls:

```
"io_uring_enter",
"io_uring_register",
"io_uring_setup",
```

All we need to do is remove those entries, save the profile as a new file, and provide that to our Docker container on startup.

To supply a custom seccomp profile, you just pass the name of the profile as a parameter to the `docker run` command. So, for example, if you have a profile called `no_io_uring.json`, you could apply it to a new container like this:

```
docker run -it --security-opt seccomp=no_io_uring.json ubuntu:22.04 /bin/bash
```

Another option for generating custom seccomp profiles is to audit the syscalls your applications generate and then use this audit log to create a custom profile that allows only those syscalls. Tools like [Inspektor Gadget](https://www.inspektor-gadget.io/docs/latest/gadgets/advise/seccomp-profile/) can help automate this process.

[Conclusion](#conclusion)
-------------------------

Seccomp filters provide a fine-grained "last layer of defense" for containers and other Linux processes looking to block access to specific syscalls. They're a useful addition to Docker container security and have been instrumental in blocking some exploits that may otherwise have allowed for container breakouts. We've also seen how creating custom seccomp filters can be useful for adding another layer of security to your containers without interrupting workflows.

Over the course of this [series of posts](https://securitylabs.datadoghq.com/articles/?s=container%20security%20fundamentals), we've demonstrated that, while the security model of Docker containers can feel a bit like a closed box, it's actually a series of discrete layers which can be explored using standard Linux tools. Hopefully, we've also given you some ideas for how you could improve the security of your containerized environment by changing the configuration of some of those layers.

In an upcoming series of posts, we'll cover the next layer in your containerization stack—Kubernetes—and explore how its security architecture works.