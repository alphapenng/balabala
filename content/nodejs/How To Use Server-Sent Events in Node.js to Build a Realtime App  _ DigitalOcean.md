> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.digitalocean.com](https://www.digitalocean.com/community/tutorials/nodejs-server-sent-events-build-realtime-app)

> Learn how to build an alternative to WebSockets for handling realtime events in JavaScript.

### [Introduction](#introduction)[](#introduction)

Server-Sent Events (SSE) is a technology based on HTTP. On the client-side, it provides an API called `EventSource` (part of the HTML5 standard) that allows us to connect to the server and receive updates from it.

Before making the decision to use server-sent events, we must take into account two very important aspects:

*   It only allows data reception from the server (unidirectional)
*   Events are limited to UTF-8 (no binary data)

If your project only receives something like stock prices or text information about something in progress it is a candidate for using Server-Sent Events instead of an alternative like [WebSockets](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket).

In this article, you will build a complete solution for both the backend and frontend to handle real-time information flowing from server to client. The server will be in charge of dispatching new updates to all connected clients and the web app will connect to the server, receive these updates and display them.

[Prerequisites](#prerequisites)[](#prerequisites)
-------------------------------------------------

To follow through this tutorial, you’ll need:

*   A local development environment for Node.js. Follow [How to Install Node.js and Create a Local Development Environment](https://www.digitalocean.com/community/tutorial_series/how-to-install-node-js-and-create-a-local-development-environment).
*   Familiarity with Express.
*   Familiarity with React (and [hooks](https://www.digitalocean.com/community/tutorials/react-react-hooks)).
*   [cURL](https://www.digitalocean.com/community/tutorials/workflow-downloading-files-curl) is used to verify the endpoints. This may already be available in your environment or you may need to install it. Some familiarity with using command-line tools and options will also be helpful.

This tutorial was verified with cURL v7.64.1, Node v15.3.0, `npm` v7.4.0, `express` v4.17.1, `body-parser` v1.19.0, `cors` v2.8.5, and `react` v17.0.1.

[Step 1 – Building the SSE Express Backend](#step-1-building-the-sse-express-backend)[](#step-1-building-the-sse-express-backend)
---------------------------------------------------------------------------------------------------------------------------------

In this section, you will create a new project directory. Inside of the project directory will be a subdirectory for the server. Later, you will also create a subdirectory for the client.

First, open your terminal and create a new project directory:

Navigate to the newly created project directory:

Next, create a new server directory:

Navigate to the newly created server directory:

Initialize a new `npm` project:

Install `express`, `body-parser`, and `cors`:

This completes setting up dependencies for the backend.

In this section, you will develop the backend of the application. It will need to support these features:

*   Keeping track of open connections and broadcast changes when new facts are added
*   `GET /events` endpoint to register for updates
*   `POST /facts` endpoint for new facts
*   `GET /status` endpoint to know how many clients have connected
*   `cors` middleware to allow connections from the frontend app

Use the first terminal session that is in the `sse-server` directory. Create a new `server.js` file:

Open the `server.js` file in your code editor. Require the needed modules and initialize Express app:

sse-server/server.js

Then, build the middleware for `GET` requests to the `/events` endpoint. Add the following lines of the code to `server.js`:

sse-server/server.js

The `eventsHandler` middleware receives the `request` and `response` objects that Express provides.

Headers are required to keep the connection open. The `Content-Type` header is set to `'text/event-stream'` and the `Connection` header is set to `'keep-alive'`. The `Cache-Control` header is optional, set to `'no-cache'`. Additionally, the HTTP Status is set to `200` - the status code for a successful request.

After a client opens a connection, the `facts` are turned into a string. Because this is a text-based transport you must [stringify](https://www.digitalocean.com/community/tutorials/js-json-parse-stringify) the array, also to fulfill the standard the message needs a specific format. This code declares a field called `data` and sets to it the stringified array. The last detail of note is the double trailing newline `\n\n` is mandatory to indicate the end of an event.

A `clientId` is generated based on the timestamp and the `response` Express object. These are saved to the `clients` array. When a `client` closes a connection, the array of `clients` is updated to `filter` out that `client`.

Then, build the middleware for `POST` requests to the `/fact` endpoint. Add the following lines of the code to `server.js`:

sse-server/server.js

The main goal of the server is to keep all clients connected and informed when new facts are added. The `addNest` middleware saves the fact, returns it to the client which made `POST` request, and invokes the `sendEventsToAll` function.

`sendEventsToAll` iterates the `clients` array and uses the `write` method of each Express `response` object to send the update.

[Step 2 – Testing the Backend](#step-2-testing-the-backend)[](#step-2-testing-the-backend)
------------------------------------------------------------------------------------------

Before the web app implementation, you can test your server using cURL:

In a terminal window, navigate to the `sse-server` directory in your project directory. And run the following command:

It will display the following message:

In a second terminal window, open a connection waiting for updates with the following command:

This will generate the following response:

An empty array.

In a third terminal window, create a post POST request to add a new fact with the following command:

After the `POST` request, the second terminal window should update with the new fact:

Now the `facts` array is populated with one item if you close the communication on the second tab and open it again:

Instead of an empty array, you should now receive a message with this new item:

At this point, the backend is fully functional. It is now time to implement the `EventSource` API on the frontend.

[Step 3 – Building the React Web App Frontend](#step-3-building-the-react-web-app-frontend)[](#step-3-building-the-react-web-app-frontend)
------------------------------------------------------------------------------------------------------------------------------------------

In this part of our project, you will write a React app that uses the `EventSource` API.

The web app will have the following set of features:

*   Open and keep a connection to our previously developed server
*   Render a table with the initial data
*   Keep the table updated via SSE

Now, open a new terminal window and navigate to the project directory. Use [`create-react-app`](https://www.digitalocean.com/community/tutorials/react-create-react-app) to generate a React App.

Navigate to the newly created client directory:

Run the client application:

This should open a new browser window with your new React application. This completes setting up dependencies for the frontend.

For styling, open the `App.css` file in your code editor. And modify the contents with the following lines of code:

sse-client/src/App.css

Then, open the `App.js` file in your code editor. And modify the contents with the following lines of code:

sse-client/src/App.js

The `useEffect` function argument contains the important parts: an `EventSource` object with the `/events` endpoint and an `onmessage` method where the `data` property of the event is parsed.

Unlike the `cURL` response, you now have the event as an object. You can now take the `data` property and parse it giving, as a result, a valid JSON object.

Finally, this code pushes the new fact to the list of facts, and the table gets re-rendered.

[Step 4 – Testing the Frontend](#step-4-testing-the-frontend)[](#step-4-testing-the-frontend)
---------------------------------------------------------------------------------------------

Now, try adding a new fact.

In a terminal window, run the following command:

The `POST` request added a new fact and all the connected clients should have received it. If you check the application in the browser you will have a new row with this information.

[Conclusion](#conclusion)[](#conclusion)
----------------------------------------

This article served as an introduction to server-sent events. In this article, you built a complete solution for both the backend and frontend to handle real-time information flowing from server to client.

SSE were designed for text-based and unidirectional transport. Here’s the [current support for `EventSource` in browsers](https://caniuse.com/#feat=eventsource).

Continue your learning by exploring [all of the features available to `EventSource`](https://developer.mozilla.org/en-US/docs/Web/API/EventSource) like `retry`.