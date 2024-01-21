<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2024-01-19 22:18:11
 * @LastEditors: alphapenng
 * @LastEditTime: 2024-01-21 08:27:56
 * @FilePath: /balabala/content/nodejs/PM2完整指南.md
-->
# PM2 完整指南

- [PM2 完整指南](#pm2-完整指南)
  - [Getting Started with PM2](#getting-started-with-pm2)
  - [Start Your Node.js App in Development Mode with PM2](#start-your-nodejs-app-in-development-mode-with-pm2)
  - [Start Your Node.js App in Production Mode with PM2](#start-your-nodejs-app-in-production-mode-with-pm2)
  - [Monitoring Your Running Applications in PM2](#monitoring-your-running-applications-in-pm2)
  - [Restarting Your Node.js Application with PM2](#restarting-your-nodejs-application-with-pm2)
  - [Auto Restart Based on Memory Usage](#auto-restart-based-on-memory-usage)
  - [Auto Restart Based on Cron Schedule](#auto-restart-based-on-cron-schedule)
  - [Auto Restart on File Change](#auto-restart-on-file-change)
  - [Auto Restart after a Delay](#auto-restart-after-a-delay)
  - [Ignore Some Exit Codes When Auto Restarting](#ignore-some-exit-codes-when-auto-restarting)
  - [Restarting Processes after a System Reboot](#restarting-processes-after-a-system-reboot)
  - [Clustering with PM2](#clustering-with-pm2)
  - [Log Management in PM2](#log-management-in-pm2)
  - [Wrap Up and Next Steps: Dive Further into PM2](#wrap-up-and-next-steps-dive-further-into-pm2)

## Getting Started with PM2

```bash
$ npm install pm2
# or
$ yarn add pm2
```

After installing PM2, run npx pm2 --version to see the installed version:

```bash
$ npx pm2 --version
5.1.2
```

If you don't want to prefix the pm2 command with npm every time, you can install it globally:

```bash
$ npm install -g pm2
# or
$ yarn global add pm2
```

Aside from the main `pm2` command, the installation provides some other executables:

- `pm2-dev`: a development tool for restarting your application when file changes in the directory are detected (similar to [Nodemon](https://github.com/remy/nodemon)).
- `pm2-runtime`: designed to be a drop-in replacement for the node binary in Docker containers. It helps keep the running application in the foreground (unlike pm2, which sends it to the background) so that the container keeps running.
- `pm2-docker`: an alias for `pm2-runtime`.

## Start Your Node.js App in Development Mode with PM2

It can be quite tedious to restart your application server in development every time you change the source files. Using the `pm2-dev` binary to start your application can take care of that concern automatically:

```bash
$ pm2-dev start app.js
===============================================================================
--- PM2 development mode ------------------------------------------------------
Apps started         : app
Processes started    : 1
Watch and Restart    : Enabled
Ignored folder       : node_modules
===============================================================================
app-0  | {"level":30,"time":1638512528047,"pid":4575,"hostname":"Kreig","msg":"Server listening at http://127.0.0.1:3000"}
[rundev] App app restarted
app-0  | {"level":30,"time":1638512535737,"pid":4631,"hostname":"Kreig","msg":"Server listening at http://127.0.0.1:3000"}
```

At this point, your server will auto-restart each time you create, modify or delete a source file in your project. It also works when you add or remove a dependency with `npm` or `yarn`.

## Start Your Node.js App in Production Mode with PM2

When deploying an application to production, you can use the `pm2` binary to start it in the background. It launches a daemon that monitors your application and keeps it running indefinitely.

```bash
$ pm2 start app.js
[PM2] Starting /home/ayo/dev/demo/covid-node/app.js in fork_mode (1 instance)
[PM2] Done.
┌─────┬────────┬─────────────┬─────────┬─────────┬──────────┬────────┬──────┬───────────┬──────────┬──────────┬──────────┬──────────┐
│ id  │ name   │ namespace   │ version │ mode    │ pid      │ uptime │ ↺    │ status    │ cpu      │ mem      │ user     │ watching │
├─────┼────────┼─────────────┼─────────┼─────────┼──────────┼────────┼──────┼───────────┼──────────┼──────────┼──────────┼──────────┤
│ 0   │ app    │ default     │ 1.0.0   │ fork    │ 16573    │ 0s     │ 0    │ online    │ 0%       │ 19.1mb   │ ayo      │ disabled │
└─────┴────────┴─────────────┴─────────┴─────────┴──────────┴────────┴──────┴───────────┴──────────┴──────────┴──────────┴──────────┘
```

PM2 defaults to the name of the entry file as the app's `name`, but you can use a more recognizable name through the `--name` option. This name is what you'll use to reference the application in many `pm2` subcommands.

```bash
$ pm2 start app.js --name "my app"
```

Suppose you need to ensure that your application has established connections with other services (such as the database or cache) before being considered "online" by PM2. In that case, you can use the `--wait-ready` option when starting your application. This causes PM2 to wait for 3 seconds (by default) or for a ready event (`process.send('ready')`) before the application is considered ready. You can use the `--listen-timeout` option to change the length of the delay.

```bash
$ pm2 start app.js --wait-ready --listen-timeout 5000 # wait for 5 seconds
```

## Monitoring Your Running Applications in PM2

To list your running applications, use the `pm2 list` command. This prints a table describing the state of all running applications with columns for:

- the app name and id
- CPU and memory usage
- number of restarts (↺)
- uptime
- process id
- the mode (`fork` or `cluster`)

and others.

You can use this table alongside a [host monitoring service like AppSignal](https://www.appsignal.com/tour/hosts) to give you a complete picture of your application and its host environment:

```bash
$ pm2 list
┌─────┬───────────┬─────────────┬─────────┬─────────┬──────────┬────────┬──────┬───────────┬──────────┬──────────┬──────────┬──────────┐
│ id  │ name      │ namespace   │ version │ mode    │ pid      │ uptime │ ↺    │ status    │ cpu      │ mem      │ user     │ watching │
├─────┼───────────┼─────────────┼─────────┼─────────┼──────────┼────────┼──────┼───────────┼──────────┼──────────┼──────────┼──────────┤
│ 0   │ app       │ default     │ 1.0.0   │ fork    │ 16573    │ 9m     │ 0    │ online    │ 0%       │ 57.3mb   │ ayo      │ disabled │
│ 2   │ index     │ default     │ 1.0.0   │ fork    │ 0        │ 0      │ 16   │ errored   │ 0%       │ 0b       │ ayo      │ disabled │
│ 1   │ server    │ default     │ 0.1.0   │ fork    │ 17471    │ 71s    │ 0    │ online    │ 0%       │ 77.5mb   │ ayo      │ disabled │
└─────┴───────────┴─────────────┴─────────┴─────────┴──────────┴────────┴──────┴───────────┴──────────┴──────────┴──────────┴──────────┘
```

If you see only a subset of this information, try enlarging your terminal window. The `list` subcommand will not display all the columns if your terminal window is too small. You can also sort the output table according to a metric of your choice:

```bash
$ pm2 list --sort [name|id|pid|memory|cpu|status|uptime][:asc|desc]
# such as
$ pm2 list --sort uptime:desc
```

If you require more information about a particular app beyond what `list` provides, use the `show` subcommand and pass the app name to view more detailed application process metadata. Some of the metrics and data presented in the output include the app's:

- output and error log files
- heap size and usage
- event loop latency
- uptime
- number of restarts
- source control metadata

and more.

```bash
$ pm2 show server
Describing process with id 1 - name server
┌───────────────────┬──────────────────────────────────────────────────┐
│ status            │ online                                           │
│ name              │ server                                           │
│ namespace         │ default                                          │
│ version           │ 0.1.0                                            │
│ restarts          │ 0                                                │
│ uptime            │ 60m                                              │
│ script path       │ /home/ayo/dev/demo/analytics-dashboard/server.js │
│ script args       │ N/A                                              │
│ error log path    │ /home/ayo/.pm2/logs/server-error.log             │
│ out log path      │ /home/ayo/.pm2/logs/server-out.log               │
│ pid path          │ /home/ayo/.pm2/pids/server-1.pid                 │
│ interpreter       │ node                                             │
│ interpreter args  │ N/A                                              │
│ script id         │ 1                                                │
│ exec cwd          │ /home/ayo/dev/demo/analytics-dashboard           │
│ exec mode         │ fork_mode                                        │
│ node.js version   │ 17.0.0                                           │
│ node env          │ N/A                                              │
│ watch & reload    │ ✘                                                │
│ unstable restarts │ 0                                                │
│ created at        │ 2021-12-03T08:33:01.489Z                         │
└───────────────────┴──────────────────────────────────────────────────┘

. . .
```

Another way to keep tabs on your running applications is through the built-in terminal dashboard (accessed through the `monit` subcommand). This allows you to view live data on resource usage and logs for each of your applications.

```bash
$ pm2 monit
```

![monit](https://alphapenng-1305651397.cos.ap-shanghai.myqcloud.com/uPic/20240119234107_pm2.avif)

## Restarting Your Node.js Application with PM2

PM2 allows you to configure several different strategies for how your Node.js application should restart. By default, it restarts your application if it exits or crashes to minimize the impact to your customers in production while the source of the crash is investigated. The `restart` subcommand is also available for manually restarting your application at any time.

```bash
$ pm2 restart app
```

To ensure a graceful shutdown, make sure you intercept the SIGINT signal to stop all new requests and finish up existing ones before allowing your program to exit.

```bash
process.on('SIGINT', function() {
   gracefulShutdown((err) => {
     process.exit(err ? 1 : 0)
   });
})
```

You can use the `--kill-timeout` option to ensure that a graceful shutdown does not take too long:

```bash
$ pm2 restart app --kill-timeout 5000 # set a 5 second limit
```

## Auto Restart Based on Memory Usage

The `--max-memory-restart` option is available to restart an app when it reaches a certain memory threshold. This can help prevent a [Node.js heap out of memory error](https://stackoverflow.com/questions/38558989/node-js-heap-out-of-memory). You can specify the memory limit in kilobytes (K), Megabytes (M), or Gigabytes (G).

```bash
$ pm2 start app.js --max-memory-restart 1G
```

## Auto Restart Based on Cron Schedule

PM2 also offers a restart strategy based on the [Cron syntax](https://www.netiq.com/documentation/cloud-manager-2-5/ncm-reference/data/bexyssf.html). This allows you to schedule a restart at a specific time each day / on certain days of the week / a set time interval (such as every 48 hours).

```bash
# Restart at 12:00 pm every day
$ pm2 start app.js --cron-restart="0 12 * * *"
```

## Auto Restart on File Change

Remember how `pm2-dev` auto-restarts your application when you make changes to a file? You can configure the `pm2` command to act in a similar manner through the `--watch` subcommand. In the table outputted by `pm2 list`, look at the `watching` column to observe the `watch` status of an application.

```bash
$ pm2 start app.js --watch
```

## Auto Restart after a Delay

You can configure the `--restart-delay` option to set a delay for automatic restarts. The delay should be supplied in milliseconds.

```bash
$ pm2 start app.js --restart-delay=5000 # 5s delay
```

## Ignore Some Exit Codes When Auto Restarting

PM2 auto-restarts your app when the process exits, but it does not take the [exit code](https://shapeshed.com/unix-exit-codes/) into account by default, so it restarts regardless of whether the app exits cleanly or crashes. If this behavior is not desired, you can use the `--stop-exit-codes` option to set exit codes that should not prompt PM2 to auto-restart. For example, you can ensure PM2 does not auto-restart on a clean exit with the following command:

```bash
$ pm2 start app.js --stop-exit-codes 0
```

## Restarting Processes after a System Reboot

The previous section covered a variety of ways to restart your application after it is launched. However, none of the strategies there will keep your application up if your server reboots. Notably, [PM2 ships with a startup feature](https://pm2.keymetrics.io/docs/usage/startup/) that can help solve this problem. You can combine this with a good [uptime monitoring service like AppSignal's](https://www.appsignal.com/tour/uptime-monitoring) to guarantee that your application comes back online quickly, even if an accident happens.

You'll need to generate a startup script for your server's init system to execute on system boot and launch the PM2 process, which will subsequently start the configured application processes immediately. You can allow PM2 to autodetect your startup script or pass the init system used by your operating system, which could be `systemd`, `upstart`, `launchd`, `rcd`, or `systemv`.

```bash
$ pm2 startup # autodetect init system
# or
$ pm2 startup systemd # generate script for systemd
```

You should receive the following output:

```bash
[PM2] Init System found: systemd
-----------------------------------------------------------
 PM2 detected systemd but you precised systemd
 Please verify that your choice is indeed your init system
 If you arent sure, just run : pm2 startup
-----------------------------------------------------------
[PM2] To setup the Startup Script, copy/paste the following command:
sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u ayo --hp /home/ayo
```

You'll need to copy and paste the generated command into the terminal, and then run it as the root:

```bash
$ sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup <distribution> -u <user> --hp <home-path>
```

If everything goes well, you'll see the following output, indicating that PM2 is configured to start at boot.


```bash
[PM2] Init System found: systemd

. . .

[PM2] [v] Command successfully executed.
+---------------------------------------+
[PM2] Freeze a process list on reboot via:
$ pm2 save

[PM2] Remove init script via:
$ pm2 unstartup systemd
```

At this point, you can run `pm2 save` to save your process list. This saves the processes currently managed by PM2 to disk so they're accessible to the daemon on system boot.

```bash
$ pm2 save
[PM2] Saving current process list...
[PM2] Successfully saved in /home/<user>/.pm2/dump.pm2
```

Go ahead and restart your computer or server. Once it boots back up, run `pm2 list` to see if all the processes are restored. If PM2 doesn't restore them automatically, you can manually relaunch them with the `resurrect` subcommand. You then won't need to start each process individually.

```bash
$ pm2 resurrect
[PM2] Resurrecting
[PM2] Restoring processes located in /home/<user>/.pm2/dump.pm2
```

At any point in the future, you can run `pm2 save` again to update the list of processes that should be restored on boot or when using the `resurrect` subcommand.

## Clustering with PM2

[Clustering in Node.js](https://blog.appsignal.com/2021/02/03/improving-node-application-performance-with-clustering.html) refers to creating child processes that run simultaneously and share the same port in an application. This technique makes it possible to horizontally scale a Node.js application on a single machine, taking advantage of the processing capabilities offered by multi-core systems (since an instance of a Node.js app only runs on a single thread).

The standard Node.js library provides a [cluster module](https://nodejs.org/api/cluster.html) to set up clustering in Node.js applications. In a nutshell, it creates child processes (workers) and distributes incoming connections across the simultaneously running worker processes. You'll need to modify your source code to spawn and manage the workers and set up how you'd like to distribute incoming connections amongst them.

PM2 also provides a cluster mode that uses the native cluster module under the hood. However, it does not require any modifications to the application's source code. Instead, all you need to do to start a Node.js program in cluster mode is to supply the `-i` option to the `start` subcommand, as follows:

```bash
$ pm2 start app.js -i 0
┌────┬────────────────────┬──────────┬──────┬───────────┬──────────┬──────────┐
│ id │ name               │ mode     │ ↺    │ status    │ cpu      │ memory   │
├────┼────────────────────┼──────────┼──────┼───────────┼──────────┼──────────┤
│ 0  │ app                │ cluster  │ 0    │ online    │ 0%       │ 49.0mb   │
│ 1  │ app                │ cluster  │ 0    │ online    │ 0%       │ 46.8mb   │
│ 2  │ app                │ cluster  │ 0    │ online    │ 0%       │ 44.8mb   │
│ 3  │ app                │ cluster  │ 0    │ online    │ 0%       │ 42.2mb   │
└────┴────────────────────┴──────────┴──────┴───────────┴──────────┴──────────┘
```

The `-i` or instances option above allows you to specify the number of workers (child processes) that PM2 should launch. You can set `0` or `max` to specify that PM2 should spawn as many workers as the number of available CPU cores (as above). Alternatively, you can set the exact number of workers to be greater than the number of available CPU cores, if desired. If you want to add additional worker processes on the fly, use the `scale` subcommand as shown below:

```bash
$ pm2 scale <app_name> +4 # add 4 additional workers in realtime
```

Once your application launches in cluster mode, incoming requests to the server will be automatically load-balanced across all the worker processes, which can significantly improve throughput. This feature also enables you to restart your app in production (using `pm2 restart`) without suffering any downtime since PM2 waits for the new workers to become operational before it kills the old ones.

PM2's clustering feature works best when your application is completely [stateless](https://12factor.net/processes). You won't need any code modifications to scale on the same server or even across multiple servers if your app doesn't maintain any state in individual processes. If your application isn't stateless, you'll likely get better results directly using the native cluster module.

## Log Management in PM2

Log management is quite straightforward in PM2. The logs for all your running applications are placed in the `~/.pm2/logs` directory, and they can be displayed with the `logs` subcommand. All log entries are prefixed with the application's name to ensure easy identification.

```bash
$ pm2 logs # display all logs in realtime
$ pm2 logs <app_name> # display only a specific app's logs
```

You can also clear log data with the flush subcommand:

```bash
$ pm2 flush # clear all log data
$ pm2 flush <app_name> # flush log data for a specific app
```

To enable log rotation, install the following module:

```bash
$ pm2 install pm2-logrotate
```

## Wrap Up and Next Steps: Dive Further into PM2

I hope this article has helped to crystallize the importance of process management in Node.js applications and how to leverage PM2's robust feature set to manage your application efficiently.

PM2 offers other capabilities that were not covered in this article such as Docker integration, a JavaScript API, and a daemon-less mode, so ensure you check out [PM2's documentation](https://pm2.keymetrics.io/docs/usage/quick-start/) to learn more about these advanced features.
