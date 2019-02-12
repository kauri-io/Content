# How to Deploy to The Mainnet

In our previous tutorials we were working in our local development environment for testing purposes. This tutorial is going to tell you how to add to your code so you can deploy it to the mainnet.

In order to deploy we need to have the truffle hdwallet provider installed.

Note: The wallet must be installed in every project as well as in your project directory.

`$ npm install truffle-hdwallet-provider`

Next you can go to [Infura](https://infura.io/) to get access to a network node. You will need to [register](https://infura.io/register) for an account.

Once you are signed in, create a new project and from the Endpoint drop down and select mainnet or one of the test nets depending on where you want to deploy. Write down the project ID because we will need it in a couple steps.

If you don't already have a mnemonic for the account that you want to use, you can create one with an [online generator](https://iancoleman.io/bip39/). At the top of the page select the amount of words to be 12 and click the generate button. Copy this mnemonic down for safe keeping.

Scroll down to the bottom of the page where it says Derived Addresses and copy the first address listed. This is your Ethereum deployment account.

Now that you have your mnemonic, project ID, and account we can make some changes to our configuration file. Under the `truffle-config.js` file add the following:

``` solidity
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

You can now push to the mainnet.

`$ zos push --network mainnet`

That's it!! Your contract is now published to the mainnet. In our Deploying & Upgrading tutorial we would still follow all the same steps because it is good practice to test your contracts, but after we are finished testing we would use the above command to push it to the mainnet. We would then change the update command to `$ zos update FirstContract --network mainnet`.

Documentation:

https://docs.zeppelinos.org/docs/mainnet
