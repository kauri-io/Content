# How to Deploy to The Mainnet

In our previous tutorials, we were working in our local development environment for testing purposes. This tutorial is going to tell you how to add to your code so you can deploy it to the mainnet.

In order to deploy to a real network, we need to have the truffle hdwallet provider installed.

Note: The wallet must be installed in every project and it must be in your project directory.

`$ npm install truffle-hdwallet-provider`

Next, you can go to [Infura](https://infura.io/) to get access to a network node. You will need to [register](https://infura.io/register) for an account.

Once you are signed in, create a new project and from the Endpoint drop down, select mainnet or one of the test nets depending on where you want to deploy. Write down the project ID because we will need it in a couple of steps.

If you don't already have a mnemonic for the account you're using, you can create one with an [online generator](https://iancoleman.io/bip39/). At the top of the page select the number of words to be 12 and click the generate button. Copy this mnemonic down for safe keeping.

Scroll down to the bottom of the page where it says Derived Addresses and copy the first address listed. This is your Ethereum deployment account.

Now that you have your mnemonic, project ID, and account we can make some changes to our configuration file. Under the **truffle-config.js** file add the following:

```solidity
'use strict';

var HDWalletProvider = require("truffle-hdwallet-provider");

var mnemonic = "your-mnemonic-here";

module.exports = {
  networks: {
    mainnet: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://mainnet.infura.io<your-project-id-here>")
      },
      network_id: 1
    }
  }
};
```

You can now push to the mainnet or test net. If you want to deploy to a test net, replace mainnet with the name of your test net.

`$ zos push --network mainnet`

That's it!! Your contract is now published to the mainnet. In relation to our Deploying & Upgrading tutorial from earlier, we would still follow all the same steps but we would change a few things. We would continue to test our contract but when it is time to push we would use the above command. Then we would change the update command to **$ zos update FirstContract --network mainnet**.
The same goes for the Linking tutorial. We use ganache our personal blockchain aka local network to test our contract and when we want to deploy to the mainnet we change --network local to --network mainnet.

Documentation:

<https://docs.zeppelinos.org/docs/mainnet>
