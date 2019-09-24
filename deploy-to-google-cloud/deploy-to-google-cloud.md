# Deploying a full-stack dApp to Google Cloud (Firebase)

In the previous [tutorials in this series](https://kauri.io/collection/5b8e401ee727370001c942e3), we saw how to develop a full-stack ethereum-based blockchain dApp.

In this tutorial, we learn how to deploy the dApp to Google Cloud's servers, to be scalable and accessible anywhere in the world.

## Google Cloud and Firebase
Google Cloud is a suite of products from Google, similar to Amazon's AWS. It a powerful suite of products, ranging from computation, databases, to storage.

Google's Firebase is an abstraction and subset of Google Cloud, making it easier for developers to use Google Cloud infrastructure. For example, Firebase Functions is an easier interface for Cloud Functions. Similarly, Firebase Storage and Hosting is an abstraction built on top of Cloud Storage.

In this tutorial, we will cover Firebase as that is the recommended option for static websites such as dApp frontends. Some other reasons why Firebase should be used in this case include:
 - Free https certificate for your domain
 - Free hosting and subdomain from Google (both a `yourproject.web.app` and `yourproject.firebaseapp.com` domains)
 - No complex setup with CNAME records and bucket setups (e.g. setting up permissions, etc)
 - An easy to use rollback/release history
 - No billing setup needed

## Prerequisites

We will be assuming that you have followed and completed the previous tutorial, [Truffle: Adding a frontend with react box](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/truffle-react-box-frontend). In other words, you have:
 - A truffle project setup and working,
 - Your truffle project contains some smart contract code,
 - Your truffle project has an existing frontend (in React),
 - You have deployed your smart contract code to [Rinkeby using Infura](https://kauri.io/article/86903f66d39d4379a2e70bd583700ecf/v14/truffle:-adding-a-frontend-with-react-box#deploy), and
 - Your React frontend (on localhost) is successfully communicating with your smart contracts on Rinkeby.

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

