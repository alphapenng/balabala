> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.digitalocean.com](https://www.digitalocean.com/community/tutorials/how-to-scale-node-js-applications-with-clustering)

> In this tutorial, you will scale a Node.js application using the cluster module on a machine with fou......

_The author selected the [Society of Women Engineers](https://www.brightfunds.org/organizations/society-of-women-engineers) to receive a donation as part of the [Write for DOnations](https://do.co/w4do-cta) program._

### [Introduction](#introduction)[](#introduction)

When you run a [Node.js](https://nodejs.org/en/) program on a system with multiple CPUs, it creates a process that uses only a single CPU to execute by default. Since Node.js uses a single thread to execute your JavaScript code, all the requests to the application have to be handled by that thread running on a single CPU. If the application has CPU-intensive tasks, the operating system has to schedule them to share a single CPU until completion. That can result in a single process getting overwhelmed if it receives too many requests, which can slow down the performance. If the process crashes, users won’t be able to access your application.

As a solution, Node.js introduced the [`cluster`](https://nodejs.org/api/cluster.html) module, which creates multiple copies of the same application on the same machine and has them running at the same time. It also comes with a load balancer that evenly distributes the load among the processes using the [round-robin algorithm](https://en.wikipedia.org/wiki/Round-robin_scheduling). If a single instance crashes, users can be served by the remaining processes that are still running. The application’s performance significantly improves because the load is shared among multiple processes evenly, preventing a single instance from being overwhelmed.

In this tutorial, you will scale a Node.js application using the `cluster` module on a machine with four or more CPUs. You’ll create an application that does not use clustering, then modify the app to use clustering. You’ll also use the `pm2` module to scale the application across multiple CPUs. You’ll use a load testing tool to compare the performance of the app that uses clustering and the one that doesn’t, as well as assess the `pm2` module.

[Prerequisites](#prerequisites)[](#prerequisites)
-------------------------------------------------

To follow this tutorial, you will need the following:

*   A system with four or more CPUs.
    *   If you’re using a remote server with Ubuntu 22.04, you can set up your system by following our [Initial Server Setup](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-22-04).
*   Node.js set up in your development environment. If you’re running Ubuntu 22.04, follow Option 3 of [How To Install Node.js on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04#option-3-installing-node-using-the-node-version-manager). For other systems, visit [How To Install Node.js and Create a Local Development Environment](https://www.digitalocean.com/community/tutorial_series/how-to-install-node-js-and-create-a-local-development-environment).
*   Basic knowledge for using [Express](https://expressjs.com/), which you can refresh with [How To Get Started with Node.js and Express](https://www.digitalocean.com/community/tutorials/nodejs-express-basics).

[Step 1 - Setting Up the Project Directory](#step-1-setting-up-the-project-directory)[](#step-1-setting-up-the-project-directory)
---------------------------------------------------------------------------------------------------------------------------------

In this step, you will create the directory for the project and download dependencies for the application you will build later in this tutorial. In [Step 2](https://www.digitalocean.com/community/tutorials/how-to-scale-node-js-applications-with-clustering#step-2-creating-an-application-without-using-a-cluster), you’ll build the application using Express. You’ll then scale it in [Step 3](https://www.digitalocean.com/community/tutorials/how-to-scale-node-js-applications-with-clustering#step-3-clustering-the-application) to multiple CPUs with the built-in `node-cluster` module, which you’ll measure with the `loadtest` package in [Step 4](https://www.digitalocean.com/community/tutorials/how-to-scale-node-js-applications-with-clustering#step-4-comparing-performance-using-a-load-testing-tool). From there, you’ll scale it with the `pm2` package and measure it again in [Step 5](https://www.digitalocean.com/community/tutorials/how-to-scale-node-js-applications-with-clustering#step-5-using-pm2-for-clustering).

To get started, create a directory. You can call it the `cluster_demo` or any directory name you prefer:

Next, move into the directory:

Then, initialize the project, which will also create a `package.json` file:

The `-y` option tells NPM to accept all the default options.

When the command runs, it will yield output matching the following:

Note these properties that are aligned with your specific project:

*   `name`: the name of the npm package.
*   `version`: your package’s version number.
*   `main`: the entry point of your project.

To learn more about other properties, you can review the [`package.json` section of NPM’s documentation](https://docs.npmjs.com/cli/v9/configuring-npm/package-json/).

Next, open the `package.json` file with your preferred editor (this tutorial will use `nano`):

In your `package.json` file, add the highlighted text to enable support for [ES modules](https://www.digitalocean.com/community/tutorials/understanding-modules-and-import-and-export-statements-in-javascript) when importing packages:

cluster_demo/package.json

Save and close the file with `CTRL+X`.

Next, you will download the following packages:

*   [`express`](https://expressjs.com/): a framework for building web applications in Node.js.
*   [`loadtest`](https://github.com/alexfernandez/loadtest): a load testing tool, useful for generating traffic to an app to measure its performance.
*   [`pm2`](https://pm2.keymetrics.io/): a tool that automatically scales an app to multiple CPUs.

Run the following command to download the Express package:

Next, run the command to download the `loadtest` and `pm2` packages globally:

Now that you’ve installed the necessary dependencies, you will create an application that does not use clustering.

[Step 2 — Creating an Application Without Using a Cluster](#step-2-creating-an-application-without-using-a-cluster)[](#step-2-creating-an-application-without-using-a-cluster)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

In this step, you will create a sample program containing a single route that will start a CPU-intensive task upon each user’s visit. The program will not use the `cluster` module so that you can access the performance implications of running a single instance of an app on one CPU. You’ll compare this approach against the performance of the `cluster` module later in the tutorial.

Using `nano` or your favorite text editor, create the `index.js` file:

In your `index.js` file, add the following lines to import and instantiate Express:

cluster_demo/index.js

In the first line, you import the `express` package. In the second line, you set the `port` variable to port `3000`, which the application’s server will listen on. Next, you set the `app` variable to an instance of Express. After that, you log the process ID of the application’s process in the console using the built-in [`process` module](https://nodejs.org/api/process.html).

Next, add these lines to define the route `/heavy`, which will contain a CPU-bound loop:

cluster_demo/index.js

In the `/heavy` route, you define a loop that increments the `total` variable 5 million times. You then send a response containing the value in the `total` variable using the `res.send()` method. While the example of the CPU-bound task is arbitrary, it demonstrates CPU-bound tasks without adding complexity. You can also use other names for the route, but this tutorial uses `/heavy` to indicate a heavy performance task.

Next, call the `listen()` method of the Express module to have the server listening on port `3000` stored in the `port` variable:

cluster_demo/index.js

The complete file will match the following:

cluster_demo/index.js

When you’ve finished adding your code, save and exit your file. Then run the file using the `node` command:

When you run the command, the output will match the following:

The output states the process ID of the process running and a message confirming that the server is listening on port `3000`.

To test if the application is working, open another terminal and run the following command:

**Note:** If you are following this tutorial on a remote server, open another terminal, then enter the following command:

Upon connecting, enter the following command to send a request to the app using `curl`:

The output will match the following:

The output provides the result from the CPU-intensive calculation.

At this point, you can stop the server with `CTRL+C`.

When you run the `index.js` file with the `node` command, the operating system (OS) creates a process. A process is an abstraction the operating system makes for a running program. The OS allocates memory for the program and creates an entry in a process list containing all OS processes. That entry is a _process ID_.

The program binary is then located and loaded into the memory allocated to the process. From there, it starts executing. As it runs, it has no awareness of other processes in the system, and anything that happens in the process does not affect other processes.

Since you have a single process for the Node.js application running on a server with multiple CPUs, it will receive and handle all incoming requests. In this diagram, all the incoming requests are directed to the process running on a single CPU while the other CPUs stay idle:

![](https://deved-images.nyc3.digitaloceanspaces.com/CART-69060%2FvUmFQkx.png)

Now that you have created an app without using the `cluster` module, you will use the `cluster` module to scale the application to use multiple CPUs next.

[Step 3 — Clustering the Application](#step-3-clustering-the-application)[](#step-3-clustering-the-application)
---------------------------------------------------------------------------------------------------------------

In this step, you will add the `cluster` module to create multiple instances of the same program to handle more load and improve performance. When you run processes with the `cluster` module, you can have multiple processes running on each CPU on your machine:

![](https://deved-images.nyc3.digitaloceanspaces.com/CART-69060%2F5u053tX.png)

In this diagram, the requests go through the load balancer in the primary process, which then uses the round-robin algorithm to distribute the requests among the processes.

You’ll now add the `cluster` module. In your terminal, create the `primary.js` file:

In your `primary.js` file, add the following lines to import dependencies:

cluster_demo/primary.js

In the first two lines, you import the `cluster` and `os` modules. In the following two lines, you import `dirname` and `fileURLToPath`, which you use to set the `__dirname` variable value to the absolute path of the directory where the `index.js` file is executing. These imports are necessary because the `__dirname` is not defined when using ES modules and is only defined by default in [CommonJS modules](https://nodejs.org/api/modules.html#modules-commonjs-modules).

Next, add the following code to reference the `index.js` file:

cluster_demo/primary.js

First, you set the `cpuCount` variable to the number of CPUs in your machine, which should be four or higher. Next, you log the number of CPUs in the console. Then after, you log the process ID of the primary process, which is the one that will receive all the requests, and use a load balancer to distribute them among worker processes.

Following that, you reference the `index.js` file using the `setupPrimary()` method of the `cluster` module so that it will be executed in each worker process spawned.

Next, add the following code to create the processes:

cluster_demo/primary.js

The loop iterates as many times as the value in the `cpuCount` and calls the `fork()` method of the `cluster` module during each iteration. You attach the `exit` event using the `on()` method of the `cluster` module to listen when a process has emitted the `exit` event, which is usually when the process dies. When the `exit` event is triggered, you log the process ID of the worker that has died and then invoke the `fork()` method to create a new worker process to replace the dead process.

Your complete code will now match the following:

cluster_demo/primary.js

Once you have finished adding the lines, save and exit your file.

Next, run the file:

The output will closely match the following (your process IDs and order of information may differ):

The output will indicate four CPUs, one primary process that includes a load balancer, and four worker processes listening on port `3000`.

Next, return to the second terminal, then send a request to the `/heavy` route:

The output confirms the program is working:

You can stop the server now.

At this point, you will have four processes running on all the CPUs on your machine:

![](https://deved-images.nyc3.digitaloceanspaces.com/CART-69060%2F5u053tX.png)

With clustering added to the application, you can compare the program performances for the one using the `cluster` module and the one without the `cluster` module.

In this step, you will use the `loadtest` package to generate traffic against the two programs you’ve built. You’ll compare the performance of the `primary.js` program which uses the `cluster` module with that of the `index.js` program which does not use clustering. You will notice that the program using the `cluster` module performs faster and can handle more requests within a specific time than the program that doesn’t use clustering.

First, you will measure the performance of the `index.js` file, which doesn’t use the `cluster` module and only runs on a single instance.

In your first terminal, run the `index.js` file to start the server:

You’ll receive an output that the app is running:

Next, return to your second terminal to use the `loadtest` package to send requests to the server:

The `-n` option accepts the number of requests the package should send, which is `1200` requests here. The `-c` option accepts the number of requests that should be sent simultaneously to the server.

Once the requests have been sent, the package will return output similar to the following:

From this output, take note of the following metrics:

*   `Total time` measures how long it took for all the requests to be served. In this output, it took just over 13 seconds to serve all `1200` requests.
*   `Requests per second` measures the number of requests the server can handle per second. In this output, the server handles `88` requests per second.
*   `Mean latency` measures the time it took to send a request and get a response, which is `2085.1 ms` in the sample output.

These metrics will vary depending on your network or processor speed, but they will be close to these examples.

Now that you have measured the performance of the `index.js` file, you can stop the server.

Next, you will measure the performance of the `primary.js` file, which uses the `cluster` module.

To do that, return to the first terminal and rerun the `primary.js` file:

You’ll receive a response with the same information as earlier:

In the second terminal, run the `loadtest` command again:

When it finishes, you’ll receive a similar output (it can differ based on the number of CPUs on your system):

The output for the `primary.js` app, which is running with the `cluster` module, indicates that the total time is down to 3 seconds from 13 seconds in the program that doesn’t use clustering. The number of requests the server can handle per second has tripled to `352` from the previous `88`, which means that your server can take a huge load. Another important metric is the mean latency, which has significantly dropped from `2085.1 ms` to `514.2 ms`.

This response confirms that the scaling has worked and that your application can handle more requests in a short time without delays. If you upgrade your machine to have more CPUs, the app will automatically scale to the number of CPUs and improve performance further.

As a reminder, the metrics in your terminal output will differ because of your network and processor speed. The total time and the mean latency will drop significantly, and the total time will increase rapidly.

Now that you have made the comparison and noted that the app performs better with the `cluster` module, you can stop the server. In the next step, you will use `pm2` in place of the `cluster` module.

[Step 5 — Using `pm2` for Clustering](#step-5-using-pm2-for-clustering)[](#step-5-using-pm2-for-clustering)
-----------------------------------------------------------------------------------------------------------

So far, you have used the `cluster` module to create worker processes according to the number of CPUs on your machine. You have also added the ability to restart a worker process when it dies. In this step, you will set up an alternative to automate scaling your app by using the [`pm2`](https://pm2.keymetrics.io/) process manager, which is built upon the `cluster` module. This process manager contains a load balancer and can automatically create as many worker processes as CPUs on your machine. It also allows you to monitor the processes and can spawn a new worker process automatically if one dies.

To use it, you need to run the `pm2` package with the file you need to scale, which is the `index.js` file in this tutorial.

In your initial terminal, start the `pm2` cluster with the following command:

The `-i` option accepts the number of worker processes you want `pm2` to create. If you pass the argument `0`, `pm2` will automatically create as many worker processes as there are CPUs on your machine.

Upon running the command, `pm2` will show you more details about the worker processes:

The table contains each worker’s process ID, status, CPU utilization, and memory consumption, which you can use to understand how the processes behave.

When starting the cluster with `pm2`, the package runs in the background and will automatically restart even when you reboot your system.

If you want to read the logs from the worker processes, you can use the following command:

You’ll receive an output of the logs:

In the last eight lines, the log provides the output from each of the four running worker processes, including the process ID and the port number `3000`. This output confirms that all the processes are running.

You can also check the status of the processes using the following command:

The output will match the following table:

Now that the cluster is running, enter the following command in the same terminal to test its performance:

The output will closely match the following:

The `Total time`, `Requests per second`, and `Mean latency` are close to the metrics generated when you used the `cluster` module. This alignment demonstrates that the `pm2` scaling works similarly.

To improve your workflow with `pm2`, you can generate a configuration file to pass configuration settings for your application. This approach will allow you to start or restart the cluster without passing options.

To use the config file, delete the current cluster:

You’ll receive a response that it is gone:

Next, generate a configuration file:

The output will confirm that the file has been generated:

Rename `.js` to `.cjs` to enable support for ES modules:

Using your editor, open the configuration file:

In your `ecosystem.config.cjs` file, add the highlighted code below:

cluster_demo/ecosystem.config.cjs

The `script` option accepts the file that will run in each process that the `pm2` package will spawn. The `name` property accepts any name that can identify the cluster, which can help if you need to stop, restart, or perform other actions. The `instances` property accepts the number of instances you want. Setting `instances` to `0` will make `pm2` spawn as many processes as there are CPUs. The `exec_mode` accepts the `cluster` option, which tells `pm2` to run in a cluster.

When you have finished, save and close your file.

To start the cluster, run the following command:

You’ll receive the following response:

The last line confirms that `4` processes are running. Because you haven’t created a `service-worker` script in this tutorial, you can ignore the error about the `service-worker` not being found.

To confirm that the cluster is operating, check the status:

You’ll receive a response that confirms four processes are running:

If you want to restart the cluster, you can use the app name you defined in the `ecosystem.config.cjs` file, which in this case is `cluster_app`:

The cluster will restart:

To continue managing your cluster, you can run the following commands:

<table><thead><tr><th>Command</th><th>Description</th></tr></thead><tbody><tr><td><code>pm2 start <mark>app_name</mark></code></td><td>Starts the cluster</td></tr><tr><td><code>pm2 restart <mark>app_name</mark></code></td><td>Kills the cluster and starts it again</td></tr><tr><td><code>pm2 reload <mark>app_name</mark></code></td><td>Restarts the cluster without downtime</td></tr><tr><td><code>pm2 stop <mark>app_name</mark></code></td><td>Stops the cluster</td></tr><tr><td><code>pm2 delete <mark>app_name</mark></code></td><td>Deletes the cluster</td></tr></tbody></table>

You can now scale your application using the `pm2` module and the `cluster` module.

[Conclusion](#conclusion)[](#conclusion)
----------------------------------------

In this tutorial, you scaled your application using the `cluster` module. First, you created a program that does not use the `cluster` module. You then created a program that uses the `cluster` module to scale the app to multiple CPUs on your machine. After that, you compared the performance between the app that uses the `cluster` module and the one that doesn’t. Finally, you used the `pm2` package as an alternative to the `cluster` module to scale the app across multiple CPUs.

To progress further, you can visit the [`cluster` module documentation page](https://nodejs.org/api/cluster.html) to learn more about the module.

If you want to continue using `pm2`, you can refer to the [PM2 - Process Management](https://pm2.keymetrics.io/docs/usage/process-management/) documentation. You can also try our tutorial using `pm2` for [How To Set Up a Node.js Application for Production on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-22-04).

Node.js also ships with the [`worker_threads`](https://nodejs.org/api/worker_threads.html) module that allows you to split CPU-intensive tasks among worker threads so that they can finish fast. Try our tutorial on [How To Use Multithreading in Node.js](https://www.digitalocean.com/community/tutorials/how-to-use-multithreading-in-node-js). You can also optimize CPU-bound tasks in the frontend using dedicated web workers, which you can accomplish by following the [How To Handle CPU-Bound Tasks with Web Workers](https://www.digitalocean.com/community/tutorials/how-to-handle-cpu-bound-tasks-with-web-workers) tutorial. If you want to learn how to avoid CPU-bound tasks affecting your application’s request/response cycle, check out [How To Handle Asynchronous Tasks with Node.js and BullMQ](https://www.digitalocean.com/community/tutorials/how-to-handle-asynchronous-tasks-with-node-js-and-bullmq).