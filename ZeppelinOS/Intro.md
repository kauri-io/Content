# Introductory To ZeppelinOS

## What is It?

ZeppelinOS  is a development platform of utilities to help manage and operate smart contract projects in Ethereum. Its counterpart _OpenZeppelin_ is a library of reusable and secure smart contracts. In this tutorial series we are going to be primarily focusing on ZeppelinOS.

ZeppelinOS is a command line tool with a multitude of built in features to assist you with your contracts. Before we summarize the different features it's important to know what EVM packages are since this is what ZeppelinOS revolves around.

EVM packages are collections of upgradeable on-chain smart contract code that can be reused. For understanding purposes, think of it as a dependency that you can update without having to deploy. Thus whenever there is a bug that needs fixing, or a new feature to be added you can easily upgrade your code/contract without having to deploy a whole new one.

I'll put a couple definitions down to make this document easier to understand:

-   EVM: Ethereum Virtual Machine. The algorithm that powers the entire Ethereum platform. It can be thought of as a program that connects all the nodes/blocks together that are in the network.

    Note: Before ZeppelinOS, the problem was that once contracts were deployed to the EVM there was no way to upgrade them.

-   EVM Packages: Piece of on-chain code that is reusable.

-   On-chain: Transactions that happen **on** the Ethereum/cryptocurrency blockchain.

-   Off-chain: Transactions that happen **off** the Ethereum/cryptocurrency blockchain.

-   Dependency: A piece of software requires other code aka _dependencies_ to make it work.

-   ZEP: A token created for ZeppelinOS.

-   dApp: Decentralised application.

## Features

Right now ZeppelinOS has some great features to get you started:

-   Deploying & Upgrading: Once you deploy your contract onto the network you can upgrade it through EVM packages without having to deploy a brand new contract. Before EVM packages your contract would be permanently frozen and not upgradeable once deployed.

-   Publishing: You can create and deploy your own EVM packages to the blockchain for other users to reuse in their projects.

-   Linking: Projects can be linked to EVM packages that are already deployed on the blockchain.

-   Vouching: To support the creators of EVM packages as well as ensure authenticity, you can vouch with ZEP tokens to confirm the quality of a package. Thus you can earn ZEP by auditing and developing packages.

## Future Features

ZeppelinOS has more features rolling out in the new year to make development and maintenance even easier. According to the [roadmap](https://blog.zeppelinos.org/zeppelinos-development-roadmap-pt-one/) we can expect to see the following:

-   **Kernel Standard Libraries**: This is an on-chain set of upgradeable libraries that you can inherit into your smart contracts. This stage of the project is available and running to users in the form of [OpenZeppelin](https://openzeppelin.org/).

Although as per the [whitepaper](https://zeppelinos.org/zeppelin_os_whitepaper.pdf) it sounds like ZeppelinOS will be getting it's own version of a kernel separate from OpenZeppelin.

-   **Development Tools**: We will have a set of tools for making development and maintenance easier. Some examples will include:

    -   Attack Management system: to deal with emergency attacks. This will allow the user to perform a pause, revert to the previous states, or fork the contract.

    -   Upgrade Management: Allow upgradeability of your smart contract to implement things such as progressive deployment of features, security patch maintenance, and updating in general.

-   **Interaction**: Various utilities to enhance inter-contract communications and networking will be introduced. Such as:

    -   Scheduling: Will allow you to interfere with the execution time of your contract. An example would be enabling your contract to perform asynchronous execution on a function so that anyone can pay the gas costs and it doesn't have to be the last person to use it.

    -   Marketplace: A hub where users can browse and sell services. Thus it is a market place for contracts. Submissions to the marketplace would be reviewed to ensure high quality and security.

    -   Blockchain Information Provider: This feature will allow you to have access to information such as current ETH price, gas price, transaction pool size, average mining block times, and more.

-   **Off-chain Tools**: These tools will be aimed at simplifying the development process. Assisting with debugging, testing, deploying and monitoring of smart contract dApps.

    -   Analytic Dashboard: Help you to monitor the health of your dApp smart contracts.

    -   Interface: An interface designed to help you perform security analysis, manage upgrades, and read data about contracts once they are deployed. The interface will have all the necessary off-chain tools to make the process as easy as possible.

## Conclusion

We are expecting to see ZeppelinOS roll out some new features in the up coming future but in the meantime we have plenty to get us started. The ZeppelinOS framework is designed to make creating contracts as easy as possible. They've solved a major issue in providing the ability to upgrade an already deployed contract. Once the rest of the features are launched, creating smart contracts will have never been easier.

Documentation

[ZeppelinOS](https://zeppelinos.org/)

[Technical details](https://blog.zeppelin.solutions/technical-details-of-zeppelinos-d3cf4da591f7)

[White paper](https://zeppelinos.org/zeppelin_os_whitepaper.pdf)

[Introducing ZeppelinOS](https://blog.zeppelin.solutions/introducing-zeppelinos-the-operating-system-for-smart-contract-applications-82b042514aa8)
