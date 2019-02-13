# Linking, Publishing, and Vouching Oh My!

The next feature of ZeppelinOS is the ability to link to EVM packages that are already deployed. In this tutorial, we're going to learn how to link to these packages and publish our own!

## Prerequisites

  -   If you haven't already, install [Node.js](https://nodejs.org/en/) onto your machine and follow the online instructions.

  -   An understanding of [Solidity](https://solidity.readthedocs.io/en/v0.5.1/solidity-in-depth.html) the programming language for smart contracts.

  -   We also need to install [Truffle](https://truffleframework.com/truffle). Truffle is a development framework for Ethereum to test and deploy smart contracts.

  `$ npm install -g truffle`

  Note: We are globally installing Truffle. Thus you do not need to install it more than once.

  -   We need Ganache a personal blockchain installed to test and run our smart contracts.

  `$ npm install -g ganache-cli`

  Note: We globally installed ganache which means we do not need to install it more than once.

## Linking

Linking to an EVM package is a useful way of using dependencies and not creating duplicates. It saves time and doesn't waste space on the network. Keep in mind that EVM packages can be updated once deployed.

In the directory of your choice, create your project and then change to that directory:

  `$ mkdir token-project`

  `$ cd token-project`

Now we're going to create our **project.json** file to store the relevant data for the project. You will be prompted to fill in properties; you can fill them in if you wish or press enter to leave them as the default.

  `$ npm init`

To initialize as a ZeppelinOS project execute the following:

  `$ zos init token-project`

This command initialized Truffle. It created a configuration file as well as two empty ones. A **zos.json**  file was also created which will contain more information about the project.

The last step is to download the ZeppelinOS project library.

Note: This library has to be installed with every project. It cannot be used project to project.

  `$ npm install zos-lib`

Open your project in a text editor of your choice (I'm using Atom) and create a new file called **MyToken.sol** under the contracts folder.

  ```solidity
  pragma solidity ^0.5.0;

  import "openzeppelin-eth/contracts/token/ERC20/ERC20.sol";
  import "openzeppelin-eth/contracts/token/ERC20/ERC20Detailed.sol";

  contract MyToken {
  ERC20Detailed private _token;

  function initialize(ERC20Detailed token) external  {
  _token = token;
  }
  }
  ```

**openzeppelin-eth** is an EVM package that is already deployed and It contains the same contracts that OpenZeppelin does. The only difference between the two is that OpenZeppelin is not deployed to the network.

Now we are going to link our contract to the package:

  `$ zos link openzeppelin-eth`

Right now the openzeppelin-eth EVM package has **StandaloneERC20**, **StandaloneERC721**, **TokenVesting**, and **PaymentSplitter** contracts pre-deployed. This means that these are the only contracts you can utilize in the EVM package.

We are now linked and are going to compile and then add the contract to our project:

  `$ truffle compile`

  `$ zos add MyToken`

Now in a separate terminal run ganache.

  `$ ganache-cli --port 9545 --deterministic`

Open up your original terminal and start a new session. For the address, you can choose any of the addresses from the ganache window under the available accounts section. I'm going to be using the 9th address.

  `$ zos session --network local --from ganache-address-here --expires 3600`

Note: If you get a message at any point saying "A network name must be provided to execute the requested action" it means that our session expired. Simply run the **zos session** command from above and try again from where you left off.

Now we are going to push our contract to the local network.

  `$ zos push --deploy-dependencies --network local`

It's time to create an instance of our contract and the package we linked to. We are going to use the **StandaloneERC20** contract to create an instance of an ERC20  token.

  `$ zos create MyToken`

  `$ zos create openzeppelin-eth/StandaloneERC20 --init initialize --args JToken,JTKN,18,100,Juliette,[],[] --network local`

The arguments are as follows: name, symbol, decimal, initial supply, initial holder, minters address, and pausers address. We left the last two empty and put "Juliette" instead of an address for who owns the token. You should see some output describing what you've initialized.

The last step is to use the truffle console to connect **MyToken** and **StandalineERC20** together. Open your **zos.dev-<network-id>.json** file and scroll down to where you see **token-project/MyToken** and **openzeppelin-eth/StandalineERC20**. The addresses listed in those sections will be the ones you use in the following commands.

  `$ truffle console --network local`

  `$ myToken = await Mytoken.at('<MyToken-address>')`
  `undefined`

  `$ myToken.initialize('<MyToken-address>')`

After this command, there should be a lot of output detailing the transaction.

That's it! You've linked to an EVM package and deployed it on your local blockchain with the arguments we submitted above and successfully joined our **StandaloneERC20** token contract with our **MyToken** contract.

## Publishing

We've seen how to deploy, upgrade, and link our smart contracts. Now it's time to learn about publishing. If you've created your own EVM package, you have the option of publishing it to the network for others to use.

Note: If you follow the steps in this section of the tutorial you will publish your package to the network. If you don't want to do that, use this section as a reference.

Create your project and initialize it:
  `$ mkdir project-name`
  `$ cd project-name`
  `$ npm init`
  `$ zos init project-name`

Within the contracts folder, you are going to create your contract/package. Once you're finished you're going to use the add command:

  `$ zos add contract-name-here`

Then you can push your contract to the network. You have to use a real network, not your local network for it to be deployed and available for others to use.

  `$ zos push --network network-here`

Replace network-here with the network you are going to publish to.

Next, we're going to edit the **package.json** file. Add the following to the bottom of the file.

  ```solidity
  "files": [
  "contracts",
  "build",
  "zos.json",
  "zos.*.json"
  ]
  ```

Before you add this code in, make sure that you change the second last bracket to have a comma after it. Your file should look something like this:

  ```solidity
  {
  "name": "",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
  "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
  "openzeppelin-eth": "^2.1.3",
  "zos-lib": "^2.1.2"
  },
  "files": [
  "contracts",
  "build",
  "zos.json",
  "zos.*.json"
  ]
  }
  ```

If you have a **zos.dev-"network id".json** file you can remove it now because it was specific for your local test network.

When you're ready:

  `$ npm login`

You'll be prompted to fill in your credentials to create an account such as username, password and email address.
Once you have an account. The last step is to publish your package to npm.

  `$ npm publish`

If any developers ever want to link to your package all they have to do is:

  `$ zos link your-project-name`

That's it! It's very easy to publish an EVM package and it's even easier to link to one!

## Vouching

Vouching is useful to ensure the authenticity of a package. Anyone can create an EVM package but not all packages are useful or reliable. Vouching provides a way for the user to measure the quality of code. The ZEP token is an ERC20 token that is going to be used in ZeppelinOS to vouch. Right now vouching is in its early beta stages and is controlled by the following [contract](https://github.com/zeppelinos/zos/blob/v2.0.0/packages/vouching/contracts/Vouching.sol). This is the next feature we will see released.

Documentation:

<https://docs.zeppelinos.org/docs/linking.html>

<https://docs.zeppelinos.org/docs/vouching.html>
