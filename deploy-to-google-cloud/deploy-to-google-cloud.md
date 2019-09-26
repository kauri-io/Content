# Deploying a full-stack dApp to Google Cloud

In the previous [tutorials in this series](https://kauri.io/collection/5b8e401ee727370001c942e3), we saw how to develop a full-stack ethereum-based blockchain dApp.

In this tutorial, we learn how to deploy the dApp to Google Cloud's servers, to be scalable and accessible anywhere in the world.

## Prerequisites

We will be assuming that you have followed and completed the previous tutorial, [Truffle: Adding a frontend with react box](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/truffle-react-box-frontend). In other words, you have:
 - A truffle project setup and working,
 - Your truffle project contains some smart contract code,
 - Your truffle project has an existing frontend (in React),
 - You have deployed your smart contract code to [Rinkeby using Infura](https://kauri.io/article/86903f66d39d4379a2e70bd583700ecf/v14/truffle:-adding-a-frontend-with-react-box#deploy), and
 - Your React frontend (on localhost) is successfully communicating with your smart contracts on Rinkeby.

## Google Cloud and Firebase
Google Cloud is a suite of products from Google, similar to Amazon's AWS. It a powerful suite of products, ranging from computation, databases, to storage.

Google's Firebase is an abstraction and subset of Google Cloud, making it easier for developers to use Google Cloud infrastructure. For example, Firebase Functions is an easier interface for Cloud Functions. Similarly, Firebase Storage and Hosting is an abstraction built on top of Cloud Storage.

In this tutorial, we will cover deploying your dApp to both *Firebase* and/or *Google Cloud Storage*.

If you are looking for fully featured static hosting then Firebase is the recommended option. Benefits include:
 - Free https certificate for your domain
 - Free hosting and subdomain from Google (both a `yourproject.web.app` and `yourproject.firebaseapp.com` domains)
 - No complex setup with CNAME records and bucket setups (e.g. setting up permissions, etc)
 - An easy to use rollback/release history
 - No billing setup needed

If you would rather have a barebones static hosting solution, then Google Cloud Storage may be more suited. However you will need to have a domain name ready, be OK with changing some domain records, and need to setup your own https certificates (if needed).

For more information on the Google Cloud products and options, see the official [Serving Websites](https://cloud.google.com/solutions/web-serving-overview) documentation.

# Firebase

## Signing up
1. [Sign up for a Firebase](https://console.firebase.google.com/) using your Google account.
2. Follow the instructions to create a new Firebase project.
3. When prompted on the `Project Overview` page, select `Web` to create a new web project.
4. Name your web app and check the box for `Also set up Firebase Hosting for this app`.
5. You don't need to add the Firebase SDK, so skip the step if asked.

## Setting up locally
1. In your terminal, install the Firebase CLI:
    ```
    npm install -g firebase-tools
    ```
2. In the same terminal, sign into Firebase:
    ```
    firebase login
    ```
3. Still in your terminal, navigate to your fullstack dApp root directory using the `cd` command (e.g. `cd truffle-react-box-frontend/`), and initiate your project:
    ```
    firebase init
    ```
    - When prompted, use the `up` and `down` arrows on your keyboard to select `Hosting`, press `spacebar` to select it, then `enter` to go to the next screen.
    - When prompted, select `Use an existing project`, then select the project you created on the Firebase website.
    - When asked `What do you want to use as your public directory?`, just press enter. We will change this manually later on.
    - When asked `Configure as a single-page app (rewrite all urls to /index.html)?`, select `y`.

## Making deployment easy
1. In your text editor / IDE, open the newly created `firebase.json` file. 
    - Replace 
        ```
        "public": "public",
        ``` 
        with: 
        ```
        "public": "client/build",
        "predeploy": [
            "cd client && npm run build"
        ],
        ```
    This change tells Firebase to build your React dApp frontend, then use those build files to deploy to Firebase Hosting.
2. You are now ready to deploy. From your terminal (still in the fullstack dApp root directory), enter:
    ```
    firebase deploy
    ```

## Accessing your dApp
1. Congratulations, your dApp is now live, hosted on Google's scalable infrastructure thanks to Firebase. You can access your dApp by going to the provided `Hosting URL` shown in the terminal.

2. Whenever you update your React frontend code, simply repeat step 2 in `Making deployment easy` to update your live dApp frontend code.

# Google Cloud Storage

## Initial setup
1. Select or create a GCP project on the [project selector page](https://console.cloud.google.com/projectselector2/home/dashboard?_ga=2.107617601.-277740605.1569517720)
    - If you are creating a new project, select the `Create` in the top right, name your project, and add it to an organisation if you would like to keep things organised.
2. Since we will be utilising Cloud Storage, you will need to enable billing on your account. You will only be charged for costs above the (very) [generous free tier](https://cloud.google.com/storage/pricing) of hosting. 
    - You can learn how to [enable billing for the project here](https://cloud.google.com/billing/docs/how-to/modify-project).
    - If you already have a billing account added to GCP, then you can choose this billing account from the [manage billing accounts page](https://console.cloud.google.com/billing?_ga=2.73604561.-277740605.1569517720)
3. You will need to have a domain you currently own. In this tutorial we will use the domain `example.com` as a placeholder.
    - To verify that you own the domain and can use it with Cloud Storage, you will need to follow the steps to [verify that you own or manage the domain](https://cloud.google.com/storage/docs/domain-name-verification#verification).
    - If you purchased your domain name via Google Domains, then verification is automatic.

### Create a `CNAME` record
 - Once you have completed the `Initial setup` above, you will need to add a `CNAME` record to your domain. Consult the support documentation of your domain provider to find out how to add a `CNAME` record.
    - Create a `CNAME` record that points to `c.storage.googleapis.com`
        ```
        NAME                TYPE    DATA
        www.example.com     CNAME   c.storage.googleapis.com
        ```

### Create a Google Storage bucket
 - Go to the [Cloud Storage browser](https://console.cloud.google.com/storage/browser?_ga=2.40579681.-277740605.1569517720) and create a bucket whose name matches the `CNAME` you created.
    - e.g. If the `CNAME` you added was `www.example.com`, then create a bucket with the name `www.example.com`.
    - Enter the bucket information and choose the `default` settings for each step.

### Install the `gsutil` tool
1. To work quickly and effectively with Cloud Storage, we should install the `gsutil` utility. 
    - Follow the instructions to [Install the Cloud SDK](https://cloud.google.com/sdk/docs/). When prompted, choose the project that you created initially.
    - If needed, install [Python 2.7](https://www.python.org/downloads/release/python-2711/)

## Deploying your dApp

### Upload your dApp's static files
1. From your terminal, navigate to your fullstack dApp root directory using the `cd` command (e.g. `cd truffle-react-box-frontend/`).
2. As you would for any React.js based app, create a optimised production build of your frontend:
    - Navigate to the `client/` directory and run the command: `npm run build`
3. In the same `client/` directory, run the command:
    ```
    gsutil rsync -R build gs://www.example.com
    ```
    - This will upload all the contents of your `client/build/` directory to the Storage bucket you created

### Make all files in your bucket publicly accessible
1. Since we are only hosting a static website in the bucket, we want all the files to be publicly readable. 
     - In the [Cloud Storage browser](https://console.cloud.google.com/storage/browser?_ga=2.40579681.-277740605.1569517720), select your dApp's website bucket you created.
     - Select the `Permissions` tab.
     - Select `Enable` in the `Simplify access control with Bucket Policy Only` alert.
     - Confirm the selection.
     - Select `Add members` and enter `allUsers` in the `New members` field, with the `Storage Object Viewer` role.
2. Your bucket is now publicly accessible. 
     - If your `CNAME` record has been set up properly and has propogated, your domain name will point to the bucket's contents.
     - Congratulations, your dApp is now live, hosted on Google Cloud Storage!
3. Whenever you update your React code, simply follow the steps in `Deploying your dApp` to update your deployed dApp.
