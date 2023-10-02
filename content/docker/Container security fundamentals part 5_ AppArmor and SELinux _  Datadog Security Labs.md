> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [securitylabs.datadoghq.com](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-5/)

> A look at how AppArmor and SELinux are used in Linux and container systems

Throughout [this series](https://securitylabs.datadoghq.com/articles/?s=container%20security%20fundamentals), we've covered various layers of security that can isolate containers not only from other processes on the host but also from their underlying host. In this post, we'll discuss how [AppArmor](https://apparmor.net/) and [SELinux](https://github.com/SELinuxProject) can provide additional restrictions beyond the other layers of isolation we've previously discussed.

[Mandatory Access Control Systems](#mandatory-access-control-systems)
---------------------------------------------------------------------

AppArmor and SELinux are examples of Mandatory Access Control (MAC) systems. These systems differ from other security controls (which are generally called Discretionary Access Control (DAC) systems) in that, generally, the user can't change their operation.

File permissions are one example of a DAC system. The owner of a file can modify its permissions to allow anyone on the host to modify it. With MAC systems, the user may not be able to modify the constraints that are placed on the resources they own. These restrictions can apply even to the root user, although the root user on a system can just disable the entire MAC system to bypass this restriction. MAC systems in Linux allow you to constrain access to various system resources so that even an otherwise privileged process cannot access them.

While it is possible to use either AppArmor or SELinux on any Linux host, there is typically only one default MAC system enabled, which varies based on the distribution. By default, Debian-derived systems have AppArmor and Red Hat-based systems use SELinux.

[AppArmor](#apparmor)
---------------------

AppArmor implements its controls by defining different profiles that can be applied to processes running on the host. These profiles can restrict access to a number of resources, including files, network traffic, and [Linux capabilities](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-3/#what-are-linux-capabilities).

On a system with AppArmor installed, we can start exploring how it's used and configured with the `sudo aa-status` command. This will show information about AppArmor's configuration and status.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-1.png?auto=format&w=896&dpr=1.25) output of aa-status

From this output, we can see several pieces of interesting information:

*   AppArmor is loaded and working.
*   34 profiles are defined on the system.
*   Currently, no processes have an active AppArmor profile.

From the perspective of containerization, the most interesting part of the profile list is the `docker-default` entry. [This profile](https://docs.docker.com/engine/security/apparmor/#understand-the-policies) is provided by default in Docker and is designed to offer some protection without risking application compatibility. However, this means that it isn't as locked down as it could be, making it necessary to create more restrictive profiles for applications that need additional protection.

To demonstrate what happens when a process gets an active AppArmor profile, we can start a new Docker container with `docker run -d nginx` and then run the `aa-status` command. This will show that we now have five processes (which are started by our container) with a profile defined and also five processes in enforce mode, meaning that AppArmor will restrict their operation according to the profile defined for each process.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-2.png?auto=format&w=896&dpr=1.25) docker default apparmor profile applied to nginx

Now that we've explored the basics of AppArmor, let's look at what we can do with a custom AppArmor profile, and how we can apply that to a Docker container.

[Custom profiles with AppArmor](#custom-profiles-with-apparmor)
---------------------------------------------------------------

AppArmor allows you to control a number of Linux resources, including network and file access. To demonstrate this with a simple example, we can create a profile that blocks write access to the `/etc` directory inside a container, even if the user running the container is `root`.

First, we'll create a minimal profile to achieve our goal.

```
#include <tunables/global>
profile docker-block-bin flags=(attach_disconnected, mediate_deleted) {
  #include <abstractions/base>
  file,
  deny /etc/** wl,
}
```

The key line here is `deny /etc/** wl`, which blocks write access to `/etc` and any subdirectories. We'll write this profile to `/etc/apparmor.d/containers/docker-block-etc` and then use the command `sudo apparmor_parser -r /etc/apparmor.d/containers/docker-block-etc` to load it into the kernel. Once that's ready, we can test it out with Docker.

We can create a new container and [use the `--security-opt` flag](https://docs.docker.com/engine/security/seccomp/#pass-a-profile-for-a-container) to apply our `etc` blocking profile to it:

```
docker run --rm -it --name block-bin --security-opt "apparmor=docker-block-etc" ubuntu:22.04 /bin/bash
```

Then, from inside the container, we can attempt to access `/etc`. The output confirms that, despite being the root user, we can't write to that directory.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-3.png?auto=format&w=896&dpr=1.25) custom apparmor profile blocking write to /etc

If you need to develop more complex profiles for Docker containers, there are some tools that can help ease the process, such as [Bane](https://github.com/genuinetools/bane). Bane has the advantage of automatically adding base restrictions for all Docker containers. It also provides a simplified syntax for profile specification.

[SELinux](#selinux)
-------------------

SELinux has had quite a long history with Linux. The U.S. National Security Agency originally implemented it as a series of patches to the Linux kernel in 2000. Since then, development has continued within the Linux ecosystem, and today, SELinux is used by default in Red Hat-based distributions, among others.

SELinux takes quite a different approach to security, when compared with AppArmor. Instead of having discrete profiles that are applied to processes, SELinux labels Linux resources, such as files and ports, and restricts access to them based on each resource's labels and the properties of the process trying to access the resource.

On a system with SELinux installed, we can use the `sestatus` command to see how it's configured.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-4.png?auto=format&w=896&dpr=1.25) output of sestatus

This command returns key information about how SELinux is configured on this host.

The first line indicates that SELinux is enabled. `Loaded policy name` tells us that we're running in `targeted` mode (which means that SELinux will be applied to specific processes chosen by the distribution provider (e.g., Red Hat) on the host), as opposed to `mls` mode, which is stricter and applies restrictions to every process. Typically, `mls` mode is not suitable for general purpose systems, due to the complexity of managing labeling and permissions on all processes.

The next important line is: `Current mode: enforcing`. Here, the possible options are: `enforcing`, `permissive`, and `disabled`. Permissive mode is useful for setting up SELinux, as it will not block actions. Instead, it will log any denials that would have occurred if the system had been in enforcing mode.

Now that we've noted that SELinux is enabled on this host, we can explore more details about its current configuration. Running `sudo semanage login -l` will show us how SELinux is configured to handle standard user processes.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-5.png?auto=format&w=896&dpr=1.25) output of semanage login -l

From this output, we can see that SELinux considers ordinary users (denoted by `__default__`) and the root user to be unconfined, meaning that it won't apply restrictions to them.

You can use standard system tools and the `-Z` switch to view the labels that SELinux uses. For example, `pf -efZ` will show information about the labels applied to different processes. In the example below, we can see that `dockerd` and `containerd` processes have the `container_runtime_t` type applied to them using a label, and the bash and ssh processes used by a standard user have the `unconfined_t` type.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-6.png?auto=format&w=896&dpr=1.25) SELinux attributes on processes

We can also see this information in file systems by using commands like `ls -alZ`.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-7.png?auto=format&w=896&dpr=1.25) SELinux attributes on files

[Container SELinux policies](#container-selinux-policies)
---------------------------------------------------------

When running Docker under Linux distributions like Fedora or Red Hat, a general SELinux policy will be applied to all new containers. Like Docker's default AppArmor profile, this general profile has to make tradeoffs in the protection provided, as it applies the same policy to every container.

To see the effect of this policy, we can run something like `docker run --rm -it --name home_container -v /home/rorym:/hosthome fedora /bin/bash` to start a new container called "home_container" that mounts our home directory into the container. If we try to create a file inside the `/hosthome` directory inside the container, we get blocked, even though we are running as the root user.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-8.png?auto=format&w=896&dpr=1.25) SELinux blocking access to /home on the host

To confirm that SELinux is blocking access, we can run the same container and add the `--security-opt label:disable` to the command, which effectively disables SELinux for that container. If we then try creating a file inside the `/hosthome` directory, we can see that it is successful.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-9.png?auto=format&w=896&dpr=1.25) container with SELinux disabled

If we want to create a custom SELinux policy that will allow us to access our home directory, one option is to use a tool like [udica](https://github.com/containers/udica). This tool analyzes data about a running container to create an SELinux policy that can then be loaded and used.

First, let's inspect our container and pipe the results to udica by running: `docker inspect home_container | sudo udica home_container`. Once this is done, udica will direct us to load the new SELinux module (which it has created) and then restart our container while specifying the new policy. After starting our container with this policy, we can see that we're allowed to write to the home directory as needed.

![](https://datadog-securitylabs.imgix.net/img/container-security-fundamentals/part-5/screenshot-5.png?auto=format&w=896&dpr=1.25) container with custom label via udica

[Conclusion](#conclusion)
-------------------------

Mandatory access control systems can provide an additional layer of protection for containers. However, it also requires effort to learn how to effectively use them, and customizing them to work with containers at scale is a significant undertaking. As such, organizations typically need to assess their risk profile to determine if it makes sense to use them. In the [next part of the series](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-6/), we'll take a look at another option for low-level container hardening, using seccomp profiles.