> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [hackernoon.com](https://hackernoon.com/build-a-data-scraping-app-using-puppeteer-nodejs-postgresql-and-aptible)

> How to build a data scrapping application using Puppeteer, Node.js, PostgreSQL, and Aptible.

Building a data scraping application is common for many developers, especially in fields where data collection, analysis, and storage are crucial. Using the Puppeteer, Node.js, and PostgreSQL trio is an excellent approach.

[Puppeteer](https://pptr.dev/?ref=hackernoon.com) is a great choice for this task. It allows you to control a headless browser, which is crucial for scraping dynamic websites. Many websites now use JavaScript to load content, and Puppeteer enables you to interact with and scrape this dynamic content.

[Node.js](https://nodejs.org/en/about?ref=hackernoon.com) is well-suited for building scalable and efficient server-side applications. It's non-blocking and event-driven, making it a good fit for handling concurrent requests in a scraping application. Node.js will handle the backend of the data-scraping application.

Storing the scraped data for the app will be handled by [PostgreSQL](https://www.postgresql.org/about/?ref=hackernoon.com) because it supports complex queries and indexing, which makes it suitable for storing and retrieving scraped data efficiently.

[Aptible](https://www.aptible.com/?ref=hackernoon.com) is a PaaS provider that aids the secure deployment of applications. It also provides database management services, with PostgreSQL being one of its supported databases. Hence, this project will use the managed PostgreSQL service provided by Aptible.

In this tutorial, you'll discover how to build a data-scraping application using Puppeteer, Node.js, PostgreSQL, and Aptible. The application will scrape data from a popular movie streaming app, Netflix, and store it in a PostgreSQL database managed by Aptible.

Prerequisites
-------------

To follow along with this tutorial, you will need the following:

*   A node version of 16.13.2 or greater is installed on your machine. You can install it by following the instructions on the [official Node.js website](https://nodejs.org/en/download/?ref=hackernoon.com).
    
*   An Aptible account. Visit the [Aptible website](https://app.aptible.com/signup?ref=hackernoon.com) to sign up.
    
*   A fundamental understanding of JavaScript and Node.js.
    

### Setting up the project

To get started, create a new directory for the project and initialize a new Node.js project in it by running the following commands:

```
mkdir web-scraper
cd web-scraper
npm init -y
```

This will create a `package.json` file for you with the following output:

```
Wrote to /home/user/web-scraper/package.json:

{
  "name": "web-scraper",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```

### Installing dependencies

To install the dependencies for the project, run the following command:

```
npm install puppeteer pg dotenv
```

This will install the necessary packages, which are Puppeteer, Node-postgres, and dotenv.

### Creating the database

For the PostgreSQL database, you will use the managed database service on Aptible. To do this, follow the steps below:

1.  Log in to your Aptible account and create a new environment.
    
    ![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27238.80706921944034%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)
    
    Figure 1: Creating a new environment
    
2.  Navigate to the new environment and click on **Databases** > **New Database**.
    
    ![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27244.4394618834081%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)
    
    Figure 2: Creating a new PostgreSQL database on Aptible
    
3.  Click on the dropdown menu and select **PostgreSQL 16**. This will create a new PostgreSQL database for you.
    
    ![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27263.12686567164184%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)
    
    Figure 3: Select the latest version of PostgreSQL
    
4.  Input the Database Handle and click on **New Database** to create the database.
    
    ![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27237.52416356877322%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)
    
    Figure 4: Create the database
    

This will provision a new PostgreSQL database for you.

You can view the database by clicking the **Databases** tab on the left menu.

![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27240.33136966126656%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)

Figure 5: View the new PostgreSQL

### Creating a database endpoint

To connect to the PostgreSQL database, you will need to create a database endpoint. To do this, follow the steps below:

1.  Navigate to the database you created and click on **Endpoints** > **New Endpoint**.
    
    ![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27241.95461200585655%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)
    
    Figure 6: Creating a new endpoint
    
2.  Include an IP address in the **IP Allowlist** field. This will allow you to connect to the database from your local machine.
    
    ![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27273.1142643764003%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)
    
    Figure 7: Add IP address to Allowlist field
    
3.  After the endpoint has finished provisioning, click on the **ConnectionURL** tab.
    
    ![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27173.63903154805575%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)
    
    Figure 8: Connection URL tab
    
4.  Click on the **show** button to copy the connection URL. You will need this to connect to the database.
    
    ![](data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%27800%27%20height=%27256.6617754952311%27/%3e)![](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)
    
    Figure 9: Copy PostgreSQL endpoint connection URL
    

### Create the scraper script.

This scraper script will scrape data from Netflix and store it in the PostgreSQL database.

To create the script, create a new file named `scraper.js` in the root of the project directory and add the following code to it:

```
const puppeteer = require("puppeteer");
const { Client } = require("pg");
require("dotenv").config();
```

The code above imports the necessary packages and loads the environment variables from the `.env` file.

Below is a breakdown of the packages imported:

*   `puppeteer`: A headless browser automation library for Node.js used for web scraping.
    
*   `Client`: Part of the pg library, a PostgreSQL client for Node.js.
    
*   `dotenv`: A library for loading environment variables from a file, used to load database credentials.
    

Next, add the following code to the `scraper.js` file:

```
async function run() {
  const browser = await puppeteer.launch({ headless: "new" });
  const page = await browser.newPage();

  // Navigate to the website you want to scrape
  await page.goto("https://netflix.com/");

  // Extract data from the page
  const data = await page.evaluate(() => {
    const title = document.querySelector("h1").innerText;
    const url = window.location.href;

    return { title, url };
  });

  // Close the browser
  await browser.close();

  return data;
}
```

The code above creates a function named `run` which will be used to scrape data from the Netflix website.

A brief explanation of the code above:

*   `run` is an asynchronous function that launches a headless browser using Puppeteer.
    
*   It opens a new page, navigates to `https://netflix.com/`, extracts data (title and URL) from the page using a function provided to `page.evaluate`, and then close the browser.
    
*   The extracted data is returned as an object.
    

Next, add the following code to the `scraper.js` file:

```
async function saveToDatabase(data) {
  const client = new Client({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false },
  });

  try {
    await client.connect();

    // Check if the table exists, and create it if not
    const createTableQuery = `
      CREATE TABLE IF NOT EXISTS scraped_data (
        id SERIAL PRIMARY KEY,
        title TEXT,
        url TEXT
      );
    `;
    await client.query(createTableQuery);

    // Insert data into the database
    const insertQuery = "INSERT INTO scraped_data (title, url) VALUES ($1, $2)";
    const values = [data.title, data.url];
    await client.query(insertQuery, values);
  } finally {
    await client.end();
  }
}
```

The code above creates a function named `saveToDatabase` which will be used to save the scraped data to the PostgreSQL database.

A brief explanation of the code above:

*   `saveToDatabase` is an asynchronous function that connects to the PostgreSQL database using the credentials in the `DATABASE_URL` environment variable.
    
*   It checks if the table `scraped_data` exists and creates it if it doesn't.
    
*   It then inserts the scraped data into the database using an SQL query.
    

Next, add the following code to the `scraper.js` file:

```
(async () => {
  try {
    const scrapedData = await run();
    console.log("Scraped Data:", scrapedData);

    // Save data to the database
    await saveToDatabase(scrapedData);
    console.log("Data saved to the database.");
  } catch (error) {
    console.error("Error during scraping:", error);
  }
})();
```

The code above calls the `run` function to scrape data from the Netflix website and then call the `saveToDatabase` function to save the scraped data to the PostgreSQL database.

A brief explanation of the code above:

*   This immediately invoked function expression (IIFE) executes the scraping and database saving process.
    
*   It catches any errors that occur during scraping or database operations and logs them.
    
*   If successful, it logs the scraped data and a success message.
    

All together, the `scraper.js` file should look like this:

```
const puppeteer = require("puppeteer");
const { Client } = require("pg");
require("dotenv").config();

async function run() {
  const browser = await puppeteer.launch({ headless: "new" });
  const page = await browser.newPage();

  // Navigate to the website you want to scrape
  await page.goto("https://netflix.com/");

  // Extract data from the page
  const data = await page.evaluate(() => {
    const title = document.querySelector("h1").innerText;
    const url = window.location.href;

    return { title, url };
  });

  // Close the browser
  await browser.close();

  return data;
}

async function saveToDatabase(data) {
  const client = new Client({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false },
  });

  try {
    await client.connect();

    // Check if the table exists, and create it if not
    const createTableQuery = `
      CREATE TABLE IF NOT EXISTS scraped_data (
        id SERIAL PRIMARY KEY,
        title TEXT,
        url TEXT
      );
    `;
    await client.query(createTableQuery);

    // Insert data into the database
    const insertQuery = "INSERT INTO scraped_data (title, url) VALUES ($1, $2)";
    const values = [data.title, data.url];
    await client.query(insertQuery, values);
  } finally {
    await client.end();
  }
}

(async () => {
  try {
    const scrapedData = await run();
    console.log("Scraped Data:", scrapedData);

    // Save data to the database
    await saveToDatabase(scrapedData);
    console.log("Data saved to the database.");
  } catch (error) {
    console.error("Error during scraping:", error);
  }
})(); 
```

### Creating a `.env` file

The `.env` file will contain the database credentials. Create a new file named `.env` in the root of the project directory and add the following code to it:

```
DATABASE_URL=postgres://<username>:<password>@<host>:<port>/<database>
```

**Note:** Replace the placeholders with the database credentials from the database endpoint you created earlier.

### Running the scraper script

To run the scraper script, run the following command:

```
node scraper.js
```

This will launch a headless browser, navigate to the Netflix website, scrape data from the page, and save the data to the PostgreSQL database on Aptible.

You should see the following output:

```
Scraped Data: {
  title: 'Unlimited movies, TV shows, and more',
  url: 'https://www.netflix.com/'
}
Data saved to the database.
```

You can verify that the data was saved to the database by logging into the PostgreSQL database using the credentials from the database endpoint.

You can do this by running the following command:

```
psql <connection_url>
```

**Note:** Replace `<connection_url>` with the connection URL from the database endpoint.

Once you're logged in, you can list the tables in the database by running the following command:

```
\dt
```

You should see the `scraped_data` table listed in the output:

```
List of relations
 Schema |     Name     | Type  |  Owner
--------+--------------+-------+---------
 public | scraped_data | table | aptible
(1 row)
```

You can view the data in the `scraped_data` table by running the following command:

```
SELECT * FROM scraped_data;
```

You should see the scraped data listed in the output:

```
id |                title                 |           url
----+--------------------------------------+--------------------------
  1 | Unlimited movies, TV shows, and more | https://www.netflix.com/
(1 row)
```

Conclusion
----------

​​In this tutorial, you learned how to create a data scrapping application using Puppeteer, Node.js, PostgreSQL, and Aptible.

To enhance this project, consider adding more functionality to the scraper script. For instance, you can expand it to scrape data from multiple websites and store it in the database.

Furthermore, you can extend the application by incorporating a frontend. This addition lets you visualize the scraped data in a web browser, enhancing the user experience.