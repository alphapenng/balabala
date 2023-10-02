> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [securitylabs.datadoghq.com](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-1/)

> A look at how containers work as Linux processes and what that means for security.

A core benefit of using containers is that most of the time you don’t have to think about what’s happening under the hood. Tools like Docker and Kubernetes do a great job of hiding complexity from their users.

However, when you need to debug and secure containerized environments, it can be very helpful to understand how to interact with containers at a low level. Fortunately, because most containerization tools are built on Linux, you can use existing Linux tools to interact with and debug them.

When securing containerized environments, it’s also vital to understand how containers use layers of isolation—and how those layers can fail—so you can mitigate any risks.

This series will break down how containers work and walk through some practical ideas for securing and troubleshooting containerized environments. We’ll mainly focus on standard Docker-style containers throughout this series, but our examples will also apply to other container runtimes like Podman, containerd, and CRI-O.

In this post, we'll demonstrate that [containers are processes](#containers-are-just-processes), use Linux tools to [interact with containers](#interacting-with-a-container-as-a-process), and [explore what this means for securing container environments](#what-does-this-mean-for-security).

[Containers are just processes](#containers-are-just-processes)
---------------------------------------------------------------

The first thing to understand about containers is that, from an operating system perspective, they’re processes—just like any other application that runs directly on the host. To demonstrate this, we can create a Linux virtual machine and install Docker on it. Note: if you’re interested in following along with the practical examples in this series, we recommend using a standard Linux VM instead of Docker for Windows/MacOS, as those tools add some complexity that makes it harder to see what’s happening.

Let's start by checking if there are any active processes named `nginx` on our VM:

```
ps -fC nginx
```

This should return an empty list, as we don’t have any NGINX web servers running at the moment.

Now, let's start a Docker container by using the [`nginx` image from Docker Hub](https://hub.docker.com/_/nginx).

```
docker run -d nginx:1.23.1
```

Once the container is up, we'll run our `ps` command again:

```
ps -fC nginx
```

This time, we get back something like the below, which shows us that several NGINX processes are now running on the machine. As far as our Linux machine is concerned, someone just ran NGINX on the host.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-1/nginx-process-list.png?auto=format&w=896&dpr=1.25) Nginx process list

As we dig deeper into the notion that containers are processes, one initial question might be: how do you tell the difference between an NGINX server started from a Docker image and one that’s just been installed on a VM? There are a couple of ways to do that, but the first, easiest one is to check for running containers with `docker ps`:

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-1/docker-ps.png?auto=format&w=896&dpr=1.25) docker process list

Alternatively, we could use Linux process tools to determine if the web server is running as a container. The `--forest` option on `ps` (for example, `ps -ef --forest`) lets us see a hierarchy of processes. In this case, our NGINX processes have a parent process of `containerd-shim-runc-v2`. You should see a shim process for each container running on the host. This shim process is part of containerd and is used by Docker to manage contained processes. The goal of this shim process is to allow containerd or the Docker daemon to be restarted without having to restart all the containers running on the host.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-1/containerd-shim.png?auto=format&w=896&dpr=1.25) Process list with containerd shim

[Interacting with a container as a process](#interacting-with-a-container-as-a-process)
---------------------------------------------------------------------------------------

We now know that containers are just processes—but what does that mean in terms of how we can interact with them? Being able to interact with them as processes is useful for both troubleshooting their operation and investigating changes in running containers (for example, in a forensic investigation). There are a couple of things to keep in mind here, but the first is that we can use the [`/proc` filesystem](https://docs.kernel.org/filesystems/proc.html) to get more information about our running containers.

The `/proc` filesystem in Linux is a virtual or pseudo filesystem. It doesn’t contain real files—instead, it is populated with information about the running system. As long as a user has the right privileges on a host that runs Docker, they can use `/proc` to access information about _any_ container running on the host.

Let’s look at some information about the NGINX container we started up earlier. On the test system we're using, we can see that the `nginx` process ID is 2336. If we list files in `/proc`, we will see a numbered directory for every process on the host, including our NGINX process. Each of these directories contains a variety of files and directories with information about that process, meaning that we can navigate into the 2336 directory to find out more about our contained process.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-1/proc-filesystem.png?auto=format&w=896&dpr=1.25) proc filesystem

It can also be helpful to use Linux tooling to work with containers that have been hardened to remove tools such as file editors or process monitors. Hardening container images is a common security recommendation, but it does make debugging trickier. You can edit files inside the container by accessing the container’s root filesystem from the `/proc` directory on the host. Navigating to `/proc/[PID]/root` will give you the directory listing of the contained process that has that PID.

In this case, running `sudo ls /proc/2336/root` will show us a listing that looks like this:

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-1/proc-details.png?auto=format&w=896&dpr=1.25) proc filesystem details

Now, if we use `touch` to add a file to this directory, we can confirm that it’s been added by using `docker exec` to list files on the container. This technique can be used to do things like edit configuration files in containers from the host.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-1/proc-created-file.png?auto=format&w=896&dpr=1.25) Proc filesystem file creation

And here's another benefit of containers being processes: we can use host-level tools to kill those processes without needing to use container tools. This isn’t something that’s a good idea for general use, as it could interact oddly with settings like Docker’s [restart policy](https://docs.docker.com/config/containers/start-containers-automatically/#use-a-restart-policy), but there may be times when it’s necessary.

As an example, let's kill our NGINX container by using the command, `sudo kill 2336`. We can then run `docker ps` to confirm that our container is no longer present.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-1/killed-nginx-process.png?auto=format&w=896&dpr=1.25) Killed nginx process

[What does this mean for security?](#what-does-this-mean-for-security)
----------------------------------------------------------------------

We've seen that, in many ways, containers are just Linux processes. This has some interesting consequences for security. First, we need to account for the fact that anyone who has access to the underlying host can use process lists to see information about running containers—even if they can’t directly access tools like Docker.

One example of this would be using Linux tooling to access a container’s environment variables, which often store secret information. A user with access to the underlying host can read the contents of the `environ` file inside a process's area in `/proc` to see that information, as shown below in an example where a container was started with an environment variable of “TOP_SECRET=API_KEY”.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-1/proc-environment-variable.png?auto=format&w=896&dpr=1.25) proc environment variable leaks

Another consequence is that we can use existing Linux security tooling to interact with containers. We’ll see examples of this later in this blog series, but so far, we’ve shown that it’s possible to examine a container's root filesystem and other characteristics via `/proc`. This can be very useful for investigating actions that have been taken, such as looking at files that an attacker has added to a container.

[Conclusion](#conclusion)
-------------------------

The first step in understanding how Linux containers work is to realize that they’re just processes. Of course, that opens the door to a number of other questions, like “How is the contained process isolated from the underlying host?” and “Where is the container's filesystem located?” We’ll cover these points and more in upcoming parts of this series.

Head over to the [part 2](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-2/) of this series to dive into container isolation and Linux namespaces!

You can also subscribe to our RSS feed [here](https://securitylabs.datadoghq.com/rss/feed.xml), or use this [direct Feedly link](https://feedly.com/i/subscription/feed%2Fhttps%3A%2F%2Fsecuritylabs.datadoghq.com%2Frss%2Ffeed.xml).