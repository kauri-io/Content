# Introductory To OpenZeppelin

## What Is OpenZeppelin?

OpenZeppelin is a library of reusable smart contracts for the Ethereum blockchain that focus on secure and simple open source code. The contracts are continuously tested and community reviewed and they follow the best industry standards and security practices.

<!-- TODO: Why would I want to use? -->

## OpenZeppelin vs ZeppelinOS

<!-- TODO: Polish -->

The difference between both applications is that OpenZeppelin is a framework of contracts to use in your code, while ZeppelinOS is a platform of utilities to securely manage your smart contracts. In this tutorial series we will only focus on OpenZeppelin.

## Types of Contracts

Depending on your project, OpenZeppelin has different kinds of contracts to meet your needs. OpenZeppelin divides contracts into the following categories:

    1.  Access:                 Roles and privileges.
    2.  Crowdsale:              Creating a smart contract for use in a crowdsale.
    3.  Cryptography:           Protecting your information.
    4.  Drafts:                 Contracts that are currently being tested.
    5.  Introspection:          Interface support.
    6.  Lifecyle:               Managing the behaviour of your contract.
    7.  Math:                   Perform operations without overflow errors.
    8.  Ownership:              Manage ownership throughout your contract.
    9.  Payment:                How your contract will release tokens.
    10. Tokens:                 Creating tokens and protecting them.
    11. Utilities:              Other contracts that could assist you.

You shouldn't change OpenZeppelin contracts, but instead inherited or combined with your own contracts for the best functionality. Its purpose is to serve as a base for you to get started with. We will dive into the contracts and their uses later on in the series.

## How To Download

To begin, you need to have [Node.js](https://nodejs.org/en/download/) and [Truffle](#) installed on your machine. To work with OpenZeppelin you should be familiar with Solidity: the programming language for smart contracts. The [Solidity In Depth Documentation](https://solidity.readthedocs.io/en/v0.5.1/solidity-in-depth.html) is a good read to brush up on the language.

In a directory of your choice make a new project folder and initialize Truffle in it.

    mkdir myproject
    cd myproject
    truffle init

We are now going to install the OpenZeppelin library into our project root directory. We use the `--save-exact` option to ensure that all dependencies are configured with an exact version since breaking changes (change in software that potentially make other components fail) might occur when versions are updated.

    npm init -y
    npm install --save-exact openzeppelin-solidity

OpenZeppelin is now fully installed. All the library's contracts are stored in the `node_modules/openzeppelin-solidity/contracts` folder path within your project.

To use the contracts, import them by adding an import statement at the beginning of your contract:

    import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

## Conclusion

OpenZeppelin allows you to write standard, safer and securer contracts using a wide variety of baseline contracts to choose from. As a developer or independent user, you save time and effort while using OpenZeppelin. Throughout the rest of the tutorial series we're going to be talking about the different types of contracts and their uses.

Documentation & Helpful Links:

<https://github.com/OpenZeppelin/openzeppelin-solidity>

<https://openzeppelin.org/>

[Click here for examples of functions inherited from OpenZeppelin contracts.](https://github.com/OpenZeppelin/openzeppelin-solidity/tree/2c34cfbe0ea5b2969ca5a13710694f44c1be3e6a/contracts/mocks)
