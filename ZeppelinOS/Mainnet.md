# How to Deploy to The Mainnet

In previous tutorials, we were working in our local development environment for testing purposes. This tutorial describes how to add to your code so that you can deploy to the mainnet.

The first step is to have the truffle hdwallet provider installed. The wallet allows you to sign (authenticate) transactions.

Note: The wallet must be installed in every project as well as in your project directory.

  `$ npm install truffle-hdwallet-provider`

Next go to [Infura](https://infura.io/) to gain access to a network node. You will need to [register](https://infura.io/register) for an account. Infura allows the user to remotely attach to a node on the network and run their application. Otherwise the user would have to run the node on their computer.

Once you are signed in, create a new project and from the Endpoint drop down: select mainnet or one of the test nets depending on where you want to deploy. Write down the project ID because we will need it in a couple of steps.

Now we have a node and a wallet but we need an account to join the two together. Install [Metamask](https://metamask.io/). Metamask will allow you to create an account where you can store funds, run dApps, and sign transactions. Upon creation of your account you will be given a mnemonic aka secret phrase associated with your account. We are going to use this mnemonic later on.  

Now that you have your mnemonic, project ID, and account we can make some changes to our configuration file. Under the **truffle-config.js** file add the following:

  ```solidity
  const HDWalletProvider = require('truffle-hdwallet-provider');
  const fs = require('fs');

  let secrets;

  if (fs.existsSync('secrets.json')) {
   secrets = JSON.parse(fs.readFileSync('secrets.json', 'utf8'));
  }

  module.exports = {
    networks: {
      development: {
        network_id: "*",
        host: 'localhost',
        port: 8545
      },
      rinkeby: {
        provider: new HDWalletProvider(secrets.mnemonic, "https://rinkeby.infura.io/v3/"+secrets.infuraProjectID),
        network_id: '4'
      },
      kovan: {
        provider: new HDWalletProvider(secrets.mnemonic, "https://kovan.infura.io/v3/"+secrets.infuraProjectID),
        network_id: '42'
      },
      ropsten: {
        provider: new HDWalletProvider(secrets.mnemonic, "https://ropsten.infura.io/v3/"+secrets.infuraProjectID),
        network_id: '3'
    },
      main : {
        provider: new HDWalletProvider(secrets.mnemonic, "https://main.infura.io/v3/"+secrets.infuraProjectID),
        network_id: '1'
      }
  }
};
  ```
You'll also need to create a **secerts.json** within your project folder. You're going to add your mnemonic and Infura and Project ID to it.

  ```Solidity
  {
  "mnemonic" : "mnemonic-here",
  "infuraProjectID" : "project-id-here"
  }
  ```

Now we can push to the mainnet or test net. If you want to deploy to a test net, replace mainnet with the name of your test net.

  `$ zos push --network mainnet`

That's it!! Your contract is now published to the mainnet. To apply this to our previous tutorials we would change commands that say **--network local** to **--network mainnet** as well as follow the steps outlined above.

Documentation:

<https://docs.zeppelinos.org/docs/mainnet>
