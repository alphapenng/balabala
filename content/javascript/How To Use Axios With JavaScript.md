> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [readmedium.com](https://readmedium.com/en/https:/medium.com/@faizan711/how-to-use-axios-with-javascript-02c8f59c99e1)

> Discover how AI technology can revolutionize your reading experience by translating and summarizing M......

![](https://cdn-images-1.readmedium.com/v2/resize:fit:800/1*GRIp79c9EDmy57mp6Dm3cg.png)Image by Author

In every application, efficient data communication between client and server is crucial. Whether you’re fetching data, submitting forms, or integrating with third-party APIs, optimizing your HTTP requests can significantly impact your application’s speed and responsiveness.

Through this article, we will explore the **Axios — a promise-based HTTP client for browser and NodeJS.** As said in its docs, it is **_Isomorphic_** _(it can run in browser and nodejs with the same codebase)._ On the server side, it uses the native node.js `http` module, while on the client (browser) it uses XMLHttpRequests. Here, we will learn from setup to usage of Axios and how it is used to optimize your HTTP requests in JavaScript Applications.

You must be asking why I should use Axios when there is a Built-in Fetch API already. Yes, you are correct you can use Fetch API but below are the 5 points as to why you should use Axios instead:

*   **Simplified API and Automatic Transforms:** Axios provide a clean, easy-to-use API that simplifies HTTP requests. It automatically transforms JSON data, saving developers from manually parsing responses. This feature reduces boilerplate code and potential errors.
*   **Interceptors for Request and Response** Axios offers powerful interceptors that allow you to modify requests before they’re sent or responses before they’re handled by `.then()` or `.catch()`. This is extremely useful for adding authentication tokens, logging, or modifying data globally across your application.
*   **Built-in Error Handling and Request Cancellation:** Axios comes with robust error handling out of the box, making it easier to handle and debug network requests. It also provides a straightforward way to cancel requests, which is particularly useful for improving performance in single-page applications or when dealing with slow networks.
*   **Browser and Node.js Support Unlike the Fetch API**, which is primarily for browsers, Axios works seamlessly in both browser and Node.js environments. This makes it an ideal choice for full-stack JavaScript applications, allowing you to use the same library for client-side and server-side requests.
*   **Wide Browser Compatibility:** Axios has built-in support for older browsers, unlike Fetch which is not supported in Internet Explorer. This broader compatibility can be crucial for applications that need to support a wide range of browsers without requiring polyfill.

![](https://cdn-images-1.readmedium.com/v2/resize:fit:800/1*vTGLvpCDeDtl0IT1XT9kyA.png)

So that you are convinced to use Axios (hopefully) now, let us look at how you can set it up in your projects. You need to have **npm**(node package manager) and a **javascript project**, of course.

run the below command in the terminal to install Axios:

then import in your project:

```
import axios from 'axios';
```

and just like that you are ready to use Axios.

Axios simplifies making HTTP requests. Here’s how to perform the four most common types of requests: **GET**, **POST**, **PUT,** and **DELETE**

GET request
-----------

```
axios.get('https://api.example.com/users')
  .then(response => {
    console.log(response.data);
  })
  .catch(error => {
    console.error('Error fetching data:', error);
  });
```

POST request
------------

```
const newUser = {
  name: 'John Doe',
  email: 'john@example.com'
};

axios.post('https://api.example.com/users', newUser)
  .then(response => {
    console.log('User created:', response.data);
  })
  .catch(error => {
    console.error('Error creating user:', error);
  });
```

PUT request
-----------

```
const updatedUser = {
  name: 'John Updated',
  email: 'john.updated@example.com'
};

axios.put('https://api.example.com/users/123', updatedUser)
  .then(response => {
    console.log('User updated:', response.data);
  })
  .catch(error => {
    console.error('Error updating user:', error);
  });
```

DELETE request
--------------

```
axios.delete('https://api.example.com/users/123')
  .then(response => {
    console.log('User deleted:', response.data);
  })
  .catch(error => {
    console.error('Error deleting user:', error);
  });
```

Each of these methods returns a Promise, allowing you to use `.then()` for successful responses and `.catch()` for errors. You can also use async/await syntax for cleaner, more synchronous-looking code:

```
async function makeRequest() {
  try {
    const response = await axios.get('https://api.example.com/users');
    console.log(response.data);
  } catch (error) {
    console.error('Error:', error);
  }
}
```

Interceptors
------------

Interceptors allow you to intercept requests or responses before they are handled by .then() or .catch(). They are of two types, request interceptor and response interceptor.

**Request** **Interceptor**

```
axios.interceptors.request.use(
  config => {
    
    config.headers['Authorization'] = `Bearer ${getToken()}`;
    return config;
  },
  error => {
    
    return Promise.reject(error);
  }
);
```

**Response** **Interceptor**

```
axios.interceptors.response.use(
  response => {
    
    return response;
  },
  error => {
    
    if (error.response.status === 401) {
      
      redirectToLogin();
    }
    return Promise.reject(error);
  }
);
```

Concurrent Requests
-------------------

`axios.all` is a helper method built into Axios to deal with concurrent requests. Instead of making multiple HTTP requests individually, the `axios.all` method allows us to make multiple HTTP requests to our endpoints altogether.

The `axios.all` function accepts an iterable object that must be a promise, such as a JavaScript array, and it returns an array of responses.

```
const getUserAccount = () => axios.get('/user/12345');
const getUserPermissions = () => axios.get('/user/12345/permissions');

axios.all([getUserAccount(), getUserPermissions()])
  .then(axios.spread((account, permissions) => {
    
    console.log('Account', account);
    console.log('Permissions', permissions);
  }));
```

![](https://cdn-images-1.readmedium.com/v2/resize:fit:800/1*K_ngAYtmG4cUDopX6t2biA.jpeg)Credits — iStock

1. Improper Error Handling
--------------------------

**Pitfall**: Neglecting to catch errors can lead to unhandled promise rejections.

_Solution_: Always use `.catch()` or try-catch with async/await:

```
async function fetchData() {
  try {
    const response = await axios.get('/api/data');
    return response.data;
  } catch (error) {
    console.error('Error fetching data:', error.message);
    
  }
}
```

2. Forgetting to Cancel Requests
--------------------------------

**Pitfall**: Unmounted components continuing to process responses can cause memory leaks.

_Solution_: Use a cancel token to abort the request when necessary:

```
const CancelToken = axios.CancelToken;
const source = CancelToken.source();

axios.get('/api/data', {
  cancelToken: source.token
}).catch(thrown => {
  if (axios.isCancel(thrown)) {
    console.log('Request canceled', thrown.message);
  } else {
    
  }
});

source.cancel('Operation canceled by the user.');
```

3. Not Transforming Request/Response Data
-----------------------------------------

**Pitfall**: Sending or receiving data in the wrong format.

_Solution_: Use “**transformRequest”** and “**transformResponse”**:

```
axios.create({
  baseURL: 'https://api.example.com',
  transformRequest: [(data) => {
    
    return JSON.stringify(data);
  }],
  transformResponse: [(data) => {
    
    return JSON.parse(data);
  }]
});
```

1. Create Axios Instances
-------------------------

Create reusable instances with predefined configurations.

```
const api = axios.create({
  baseURL: 'https://api.example.com',
  timeout: 5000,
  headers: {'X-Custom-Header': 'foobar'}
});


api.get('/endpoint').then();
```

2. Set Default Headers
----------------------

Set default headers to avoid repetition:

```
axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;
axios.defaults.headers.post['Content-Type'] = 'application/json';
```

3. Use Request Timeouts
-----------------------

Set timeouts to prevent long-running requests:

```
axios.get('/api/data', {
  timeout: 5000 
});
```

4. Implement Retry Logic
------------------------

For unreliable networks, implement retry logic:

```
const axiosRetry = require('axios-retry');

axiosRetry(axios, {
  retries: 3, 
  retryDelay: (retryCount) => {
    return retryCount * 1000; 
  },
  retryCondition: (error) => {
    
    return error.code === 'ECONNABORTED' || error.response.status >= 500;
  },
});
```

5. Cache Responses
------------------

Implement caching for frequently accessed, rarely changing data:

```
const cache = new Map();

function getCachedData(url) {
  if (cache.has(url)) {
    return Promise.resolve(cache.get(url));
  }
  return axios.get(url).then(response => {
    cache.set(url, response.data);
    return response.data;
  });
}
```

By following these practices and being aware of common pitfalls, you can optimize your use of Axios and create more efficient, reliable HTTP requests in your JavaScript applications.

_Thank you for reading! If you have any feedback or notice any mistakes, please feel free to leave a comment below. I’m always looking to improve my writing and value any suggestions you may have. If you’re interested in working together or have any further questions, please don’t hesitate to reach out to me at [fa1319673@gmail.com](mailto:fa1319673@gmail.com)._