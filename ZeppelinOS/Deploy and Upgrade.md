# Getting Started: Installing, Deploying, Upgrading

In this tutorial, we are going to install ZeppelinOS, deploy a simple contract and then update it!

## Prerequisites

-   If you haven't already, install [Node.js](https://nodejs.org/en/) onto your machine and follow the online instructions.

-   An understanding of [Solidity](https://solidity.readthedocs.io/en/v0.5.1/solidity-in-depth.html) the programming language for smart contracts.

-   We also need to install [Truffle](https://truffleframework.com/truffle). Truffle is a development framework for Ethereum to test and deploy smart contracts.

`$ npm install -g truffle`

Note: We are globally installing Truffle. Thus you do not need to install it more than once.

-   We need Ganache a personal blockchain installed to test and run our smart contracts.

`$ npm install -g ganache-cli`

Note: We globally installed ganache which means we do not need to install it more than once.

## Installing

After installing Node.js we are now ready to install ZeppelinOS. Using our terminal we are going to do the following:

Note: For Windows users, I recommend Powershell over Command Prompt.

`$ npm install -g zos`

That's it! ZeppelinOS is now installed. We globally installed it onto our system so this is the only time we ever have to install it (unlike OpenZeppelin which you have to download every time you want to use it).

Note: `zos --help` will give you a full list of all ZeppelinOS commands should you require them.

#### Creating our project

In the directory of your choice, create your project and then change to that directory:

`$ mkdir first-project`

`$ cd first-project`

Now we're going to create our **project.json** file to store the relevant data for the project. You will be prompted with properties to fill in; you can fill them in if you wish or press enter to leave them as the default.

`$ npm init`

To initialize as a ZeppelinOS project execute the following:

`$ zos init first-project`

This command initialized Truffle. It created a configuration file as well as two empty files called contracts and migrations. The zos command  created a **zos.json** file which is going to contain more information about the project in relation to ZeppelinOS.

The last step is to download the ZeppelinOS project library.

Note: This library has to be installed with every project. It cannot be used project to project.

`$ npm install zos-lib`

#### Creating a Contract

After successfully installing and initializing our project we are now ready to create our smart contract.

Open your project folder in an editor of your choice(I use atom) and notice that your file structure should look as follows:

    first-project
      contracts
      migrations
      node_modules
      package-lock.json
      package.json
      truffle-config.js
      zos.json

Click on your contract folder and create a new file called `FirstContract.sol.` This is going to be our smart contract. In this file write the following:

```solidity
pragma solidity ^0.5.0;

import "zos-lib/contracts/Initializable.sol";

contract FirstContract is Initializable {

  int public year;
  int public age;
  string public name;

  function initialize(int _year,int _age, string memory _name) initializer public {
    year = _year;
    age = _age;
    name = _name;
  }

}
```

In ZeppelinOS we use an initialize function instead of a standard constructor because this allows for the contract to be upgradeable. **Initializable.sol** is the contract we imported from the zos library, which makes it possible for us to have this initialize function.

Now that we have created our contract we can compile and add information to the **zos.json** file through the following command:

`$ zos add FirstContract`

#### Deploying

We have installed and created our contract. Now we can test it with ganache our personal blockchain.

To start ganache, open a separate terminal window and type the following command:

`$ ganache-cli --port 9545 --deterministic`

You should see something similar to this:

    Available Accounts
    ==================
    (0) 0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1 (~100 ETH)
    (1) 0xffcf8fdee72ac11b5c542428b35eef5769c409f0 (~100 ETH)
    (2) 0x22d491bde2303f2f43325b2108d26f1eaba1e32b (~100 ETH)
    (3) 0xe11ba2b4d45eaed5996cd0823791e0c93114882d (~100 ETH)
    (4) 0xd03ea8624c8c5987235048901fb614fdca89b117 (~100 ETH)
    (5) 0x95ced938f7991cd0dfcb48f0a06a40fa1af46ebc (~100 ETH)
    (6) 0x3e5e9111ae8eb78fe1cc3bb8915d5d461f3ef9a9 (~100 ETH)
    (7) 0x28a8746e75304c0780e011bed21c72cd78cd535e (~100 ETH)
    (8) 0xaca94ef8bd5ffee41947b4585a84bda5a3d3da6e (~100 ETH)
    (9) 0x1df62f291b2e969fb0849d99d9ce41e2f137006e (~100 ETH)

    Private Keys
    ==================
    (0) 0x4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d
    (1) 0x6cbed15c793ce57650b9877cf6fa156fbef513c4e6134f022a85b1ffdd59b2a1
    (2) 0x6370fd033278c143179d81c5526140625662b8daa446c22ee2d73db3707e620c
    (3) 0x646f1ce2fdad0e6deeeb5c7e8e5543bdde65e86029e2fd9fc169899c440a7913
    (4) 0xadd53f9a7e588d003326d1cbf9e4a43c061aadd9bc938c843a79e7b4fd2ad743
    (5) 0x395df67f0c2d2d9fe1ad08d1bc8b6627011959b79c53d7dd6a3536a33ab8a4fd
    (6) 0xe485d098507f54e7733a205420dfddbe58db035fa577fc294ebd14db90767a52
    (7) 0xa453611d9419d0e56f499079478fd72c37b251a94bfde4d19872c44cf65386e3
    (8) 0x829e924fdf021ba3dbbc4225edfece9aca04b929d6e75613329ca6f1d31c0bb4
    (9) 0xb0057716d5917badaf911b193b12b910811c1497b5bada8d7711f758981c3773

    HD Wallet
    ==================
    Mnemonic:     "your Mnemonic here"
    Base HD Path:  m/44'/60'/0'/0/{account_index}

    Gas Price
    ==================
    20000000000

    Gas Limit
    ==================
    6721975

    Listening on 127.0.0.1:9545

    We are provided with a mnemonic that is associated with our test account as well as some details about our development blockchain. Now that the blockchain is running in the background we need to test our contract by starting a new session. Open up your other terminal.

    `$ zos session --network local --from 0x1df62f291b2e969fb0849d99d9ce41e2f137006e --expires 3600`

    We've began a session with the local network and we're using a default sender address as well as an expiry to indicate how long the session will run for.

    Finally we can deploy our contract.

    `$ zos push`

    Note: If you get a message at any point saying "A network name must be provided to execute the requested action" it means that our session expired. Simply run the **zos session** command from above and try again from where you left off.

    That's it! Our contract was successfully deployed to the local network from the default address. If you look at your ganache terminal you will see details about the deployment. As well in our project folder a new file was created. It should be called **zos.dev-"network id".json** It contains all the information about your project in this network.

    #### Upgrading

    The contract we created is now deployed to our local network and we want to upgrade it. Normally this would be impossible but with  ZeppelinOS we have the ability to do this.

    Before we upgrade, to make sure there are no errors later on we're going to compile our contract.

    `$ truffle compile`

    Should it not compile, correct your code as per the errors.

    To begin we are going to create an instance of our contract:

    `$ zos create FirstContract --init initialize --args 2019,19,Juliette`

    We are re-initializing our contract through the initialize function and we need to pass arguments to it. Thus we are initializing our contract to have the year be 2019, age be 19, and name be Juliette.

    After creating our instance we want to test it using our Truffle console.

    `$ npx truffle console --network local`

    Once the Truffle console is up we are going to do the following:

    `$ firstContract = await FirstContract.at('your-address')`
    `undefined`

    Note: Our command is what is next to the $ and our output is the next line. We have 4 commands we are going to perform in our console.

    The address you're going to use will be directly _underneath_ the 'Instance created at <an-address>  sentence that was executed from the zos create command.

    `$ firstContract.year()`
    `<BN: 7e3>`

    `$ firstContract.name()`
    `Juliette`

    `$ firstContract.age()`
    `<BN: 13>`

    Note: 7e3 is hexadecimal for 2019 and 13 is hexadecimal for 19.Integer numbers will always be displayed as hexadecimal. To confirm if your math is right you can always convert it yourself from hexadecimal to decimal.

    Our tests performed the way we wanted to, thus we can now go and update the contract.
    Type *.exit* to leave the Truffle console.

    Update your contract to look like the following:

    ```solidity
    pragma solidity ^0.5.0;

    import "zos-lib/contracts/Initializable.sol";

    contract FirstContract is Initializable {

      int public year;
      int public age;
      string public name;


      function initialize(int _year, int _age, string memory _name) initializer public {
        year = _year;
        age = _age;
        name = _name;
      }

      function increaseYear() public {
        year += 4;
        age += 4;
      }
    }
    ```

    Note: ZeppelinOS allows you to add functions, variables, etc when you update but in order to preserve functionality, if you are to declare any new variables they must be below all your existing ones. Like so,
    ``` solidity
    contract MyContract1.0 {
      uint256 public a;
      uint256 public b;
    }

    contract MyContract1.1 {
      uint256 public c;
      uint256 public d;
    }
    ```

    Once you are happy with your changes, push your contract and then update it.
    `$ zos push --network local`

    `$ zos update FirstContract --network local`

    Now that we have successfully updated our contract lets start the Truffle console again to test to make sure it works.

    `$ npx truffle console --network local`

    Now type in the following commands:

    `$ firstContract = await FirstContract.at('your-address')`
    `undefined`

    Note: Our command is what is next to the $ and our output is the next line. We have 4 commands we are going to perform in our console.

    The address you're going to use is the same one we used before.

    `$ firstContract.year()`
    `<BN: 7e3>`

    `$ firstContract.name()`
    `Juliette`

    `$ firstContract.age()`
    `<BN: 13>`

    `$ firstContract.increaseYear()`

    You should got a lot of output here. Something like the following:
    { tx:
       'address',
      receipt:
       { transactionHash:
          'address',
         transactionIndex: 0,
         blockHash:
          'address',
         blockNumber: 5,
         from: 'address',
         to: 'address',
         gasUsed: 33451,
         cumulativeGasUsed: 33451,
         contractAddress: null,
         logs: [],
         status: true,
         logsBloom:
          '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
         v: '0x1b',
         r:
          'address',
         s:
          'address',
         rawLogs: [] },
      logs: [] }

`$ firstContract.age()`
`<BN: 17>`

`$ firstContract.year()`
`<BN: 7e7>`

Note: 17 is hexadecimal for 23 and 7e7 is hexadecimal for 2023. Integer numbers will always be displayed as hexadecimal. To confirm if your math is right you can always convert it yourself from hexadecimal to decimal.

That's it! We successfully deployed and updated our contract on our local test network!

Documentation:

<https://docs.zeppelinos.org/docs/upgrading.html>
