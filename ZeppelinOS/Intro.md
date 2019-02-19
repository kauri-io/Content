# Introductory To ZeppelinOS

## What is It?

ZeppelinOS is a development platform of utilities to help manage and operate smart contract projects in Ethereum. Its counterpart _OpenZeppelin_ , comprises of a library of reusable and secure smart contracts. In this tutorial series, we are primarily focusing on ZeppelinOS.

ZeppelinOS is a command line tool with a multitude of built-in features to assist you with developing contracts. They are responsible for creating a feature called the EVM Package.

EVM packages are collections of upgrade-able on-chain smart contract code that is reusable. For understanding purposes, think of it as a dependency that you can update without having to deploy. As a result, whenever there's a bug that needs fixing or a new feature to add, you have the ability to upgrade your contract without deploying a new one. Before ZeppelinOS this was impossible; your contracts would forever be frozen on the blockchain.

Upgrade-ability is a feature that every developer needs to use and without ZeppelinOS it's impossible. EVM packages are accessible through inheriting and take up little to no code. Writing contracts will take less time which allows the quality and complexity of contracts to have never been better. In the next tutorial: Deploying & Upgrading we will go over how to use ZeppelinOS but for now we're going to talk about what it has to offer.

Here are a couple definitions to make this introductory easier to understand:

  - **EVM**: Ethereum Virtual Machine. The algorithm that powers the entire Ethereum platform. It's the program that connects all the nodes/blocks together in the network.

  - **EVM Packages**: Piece of on-chain code that's reusable.

  - **On-chain**: Transactions that happen **on** the Ethereum/cryptocurrency blockchain.

  - **Off-chain**: Transactions that happen **off** the Ethereum/cryptocurrency blockchain.

  - **Dependency**: Piece of code that makes other code ex) software, work properly.  

  - **ZEP**: A token created for ZeppelinOS.

  - **dApp**: Decentralized application.

## Features

  ZeppelinOS has great features to get you started:

  - Deploying & Upgrading: Once your contract deploys onto the network, you have the option of  upgrading it through EVM packages. Before these packages, your deployed contracts would not be upgrade-able.

  - Publishing: Developers have the option of publishing their EVM packages to the blockchain for others to integrate into their projects.

  - Linking: Any project can link to an EVM package that is already deployed on the blockchain. This establishes a database of packages that everyone can use.

  - Vouching: To support the creators of EVM packages and promote authenticity, vouching is possible with ZEP tokens. This confirms the reliability of a package. Thus you can earn ZEP by auditing and developing packages.

## Future Features

ZeppelinOS has more features rolling out in the new year to make development and maintenance even easier. According to the [road map](https://blog.zeppelinos.org/zeppelinos-development-roadmap-pt-one/) we can expect to see the following:

  - **Kernel Standard Libraries**: This is an on-chain set of upgradeable libraries that you can inherit into your smart contracts. This stage of the project is active and available to users in the form of [OpenZeppelin](https://openzeppelin.org/).

    Although as per the [whitepaper](https://zeppelinos.org/zeppelin_os_whitepaper.pdf), it sounds as though ZeppelinOS will be receiving its own separate version of a kernel sometime in the near future.

  - **Development Tools**: A set of tools that will make development and maintenance hassle-free. Examples include:

    - Attack Management system: To deal with emergency attacks. This will allow the user to perform actions such as pause, revert to the previous states, or fork the contract.

    - Upgrade Management: Manage progressive deployment of features, security patch maintenance, and updating.

  - **Interaction**: Various utilities to enhance inter-contract communications and networking.

    - Scheduling: Will allow you to interfere with the execution time of your contract. An example would be enabling your contract to perform asynchronous execution on a function so that anyone can pay the gas cost instead of one specific person.

    - Marketplace: A hub where users can browse and sell services. Hence it's a market place for contracts. Submissions to the marketplace will be reviewed to ensure high quality and best security practices.

    - Blockchain Information Provider: This feature will allow you to have access to information such as current ETH price, gas price, transaction pool size, average mining block times, and more.

  - **Off-chain Tools**: Off-chain tools aim to simplify the development process. Assisting with debugging, testing, deploying and monitoring of smart contract dApps.

    - Analytic Dashboard: Help you to track the health of your dApp smart contracts.

    - Interface: An interface designed to perform security analysis, manage upgrades, and interpret data about contracts once they deploy.

## Conclusion

We are expecting to see ZeppelinOS roll out new features in the up and coming future. In the meantime, we have plenty to get us started. The ZeppelinOS framework is designed to make creating contracts as easy as possible. They've resolved a fundamental issue in providing the ability to upgrade an already deployed contract. Once the rest of the features are launched, creating smart contracts will have never been easier.

Documentation

[ZeppelinOS](https://zeppelinos.org/)

[Technical details](https://blog.zeppelin.solutions/technical-details-of-zeppelinos-d3cf4da591f7)

[White paper](https://zeppelinos.org/zeppelin_os_whitepaper.pdf)

[Introducing ZeppelinOS](https://blog.zeppelin.solutions/introducing-zeppelinos-the-operating-system-for-smart-contract-applications-82b042514aa8)
