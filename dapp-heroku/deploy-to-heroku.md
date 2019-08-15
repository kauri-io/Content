# Truffle: Deploying Your App to Heroku

Earlier in the series, we deployed our Bounties.sol smart contract using Truffle, and added a react.js front end to interact with the contract through a web browser. In this tutorial we will deploy our application to [Heroku](https://www.heroku.com).

[The source code for this tutorial can be found here](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/truffle-react-box-frontend).

## Heroku

Heroku is a Platform-as-a-Service (PaaS) that enables developers to quickly build, deploy, and scale web applications. We'll use Heroku to quickly deploy our application and make it accessible to the public.

## Prerequisites

You'll need to configure the application, as defined in an earlier tutorial, [Truffle: Adding a frontend with react box](https://kauri.io/article/86903f66d39d4379a2e70bd583700ecf/v14/truffle:-adding-a-frontend-with-react-box).

Additionally, you'll need to install the Heroku CLI.

More information on the Heroku CLI can be found [here](https://devcenter.heroku.com/articles/heroku-cli).

The Heroku CLI is available through Homebrew:
```bash
brew tap heroku/brew && brew install heroku
```

## Setup Heroku

Navigate to the project directory in your terminal. Note, you are going to need to run some `git` commands from the top level of the working tree. For the purposes of this tutorial, let's assume that you have an independent copy of the [react project from the previous tutorial](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/truffle-react-box-frontend).

If you haven't already, initialize your project as a git repository. Git is used natively by Heroku to update your code.

```bash
git init
```

Here we create a new Heroku app and indicate we want to use the standard nodejs buildpack by Heroku.

```bash
heroku create --buildpack heroku/nodejs
```

Heroku will automatically asign your application a random name. Alternatively, you may give you application a memorable name that will be accessible at your-app-name.herokuapp.com.

```bash
heroku create mynewdapp --buildpack heroku/nodejs
```

If you initialized the Git repository prior to running `heroku create` you'll be able to see the heroku remote by running `git remote`.

If you don't see a remote named 'remote', you can add it manually.
```
git remote add heroku [your heroku git remote url here]
```

## Define a Procfile

The only change required to the codebase to deploy your app is a Procfile. A Procfile specifies commands to be executed by the app upon startup. In this case, we use the Procfile to mimic the local deployment process, but on the Heroku server.

Add a file called `Procfile` (no file extension) to the /client directory. The Procfile is specific to the React application, not the rest of the repository. Add a single line to the Procfile.

```
web: npm start
```

This defines a web worker to execute `npm start`. You can read more about Procfiles [here](https://devcenter.heroku.com/articles/procfile).

## Configure and Deploy the Smart Contract

Just like when configuring the web application to deploy locally, you'll need to deploy your smart contract. However, since the web application is now on a remote server, you won't be able to use a locally deployed smart contract.

You can follow any of the previous guides, for example the deployment as shown in [Truffle: Adding a frontend with react box](https://kauri.io/article/86903f66d39d4379a2e70bd583700ecf/v14/truffle:-adding-a-frontend-with-react-box#deploy) using Infura. You can use any publicly accessible node to deploy your smart contract, as long as the contract address is updated appropriately in client/src/contracts/Bounties.json.

## Deploy Your Application

You are now ready to deploy your application. Heroku needs to ingest the contents of the /client directory. The current repository also includes source code for your smart contract, which Heroku does not know how to handle. Additionally, Heroku requires that your `package.json` file be in the root of the directory.

Start by commiting your code locally, if you haven't already.

```bash
git add -A
git commit -m 'your commit message'
```

In order to avoid restructuring the application folders, you can instead just push the /client directory to the Heroku remote on the master branch.

```bash
`git push heroku `git subtree split --prefix client [branch (optional)]`:master --force`
```

Here we are push the local repository to the remote called heroku, using the a local branch programmatically defined using `git subtree split...`, to a remote branch called master, and force the push. You can get a better sense of what is occuring by first just running `git subtree split --prefix client master`. This returns a hash, for example `206ac9684c0e8e169121198ee6d1d19d0e4a06a7`. The local branch does not need to be defined. In this example, the branch called master was used but you can change that to any local branch.

That command only works once the master branch has been established on the remote. If this is your first commit being pushed to Heroku, run this instead.

```bash
git subtree push --prefix client heroku master
```

Note, the second command can be used exclusively, but occassionally draws issues when the Heroku remote gets out of sync with another remote (for example an origin remote on GitHub).

Note, if you are working out of the root directory of this series, you can 
Login to your account or create a new one at [https://www.heroku.com](https://www.heroku.com). From your dashboard, click the `new` button to create a new application.

![Create New Application](/Create-New-App.png)

Give your application a name. This name will be publicly facing as part of your Heroku-issued URL. For example, using the app name `full-stack-dapp-tutorial`, our application will be available at full-stack-dapp-tutorial.herokuapp.com. You can mask this later with your own URL.

![Name Your App](/Name-New-App.png)

## Deploy to Heroku

Add Procfile to existing codebase

git init first so that heroku create will automatically set the remote.

heroku create --buildpack heroku/nodejs

Note, cannot have both package-lock.json and yarn.lock. If you have a yarn.lock file, Yarn will be used by Heroku instead of npm.

If alone, use git subtree push --prefix client heroku master

REFERNCE:
After working on our project for about a week we came across an issue. We started getting fast-forward issues after others team members deployed to Heroku. Once another team member deployed to Heroku are usual deployment command of:

git subtree push --prefix client heroku master

no longer worked.

The reason being our local branch was behind the Heroku remote. Even after attempting a pull from the Heroku remote we were still having issues. The solution was this:

git push heroku 'git subtree split --prefix web branch':master --force

where web is the subdirectory where you Heroku app lives.

Use `git push heroku `git subtree split --prefix client`:master --force` instead if on a team

Good reference here: https://brettdewoody.com/deploying-a-heroku-app-from-a-subdirectory/

## Run the App

You should now see a URL to access your application. It should look like your-app-name.herokuapp.com. You can also run `heroku open` from the command line to open a browser to the appropriate url.

Once you navigate to the right webpage, you'll be able to configure metamask. Be sure to set MetaMask to use the right Ethereum network to interface with your deployed contract. Now you'll be able to interact with your smart contract through the browser anywhere with an internet connection.