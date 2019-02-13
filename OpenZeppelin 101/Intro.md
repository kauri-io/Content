# Introductory To OpenZeppelin

## What Is OpenZeppelin?

OpenZeppelin is a library of reusable smart contracts to be used on Ethereum. The contracts focus on secure and simple open source code. They are continuously tested and community reviewed to ensure they follow the best industry standards and security practices.

<!-- TODO: Why would I want to use? -->

## OpenZeppelin vs ZeppelinOS

<!-- TODO: Polish -->

Often confused to be the same thing, OpenZeppelin and ZeppelinOS are two different applications. OpenZeppelin is a series of open source contracts to inherit into your code. While ZeppelinOS is a platform of utilities to securely manage your smart contracts. In this tutorial series, we will only be focusing on OpenZeppelin.

## Types of Contracts

OpenZeppelin has a variety of contracts to meet your needs. They are divided into the following categories:

1.  Access:                 Roles and privileges.
2.  Crowdsale:              Creating a smart contract for use in a crowdsale.
3.  Cryptography:           Protecting your information.
4.  Drafts:                 Contracts that are currently being tested.
5.  Introspection:          Interface support.
6.  Lifecycle:               Managing the behaviour of your contract.
7.  Math:                   Perform operations without overflow errors.
8.  Ownership:              Manage ownership throughout your contract.
9.  Payment:                How your contract will release tokens.
10. Tokens:                 Creating tokens and protecting them.
11. Utilities:              Other contracts that could assist you.

OpenZeppelin contracts are meant to be inherited or combined with your own contracts for functionality purposes. It serves as a base for you to build from. Later in the series, we will explore the uses of these contracts.

## How To Download

To begin, you need to have [Node.js](https://nodejs.org/en/download/) and [Truffle](#) installed on your machine. To work with OpenZeppelin you should be familiar with Solidity: the programming language for smart contracts. The [Solidity In Depth documentation](https://solidity.readthedocs.io/en/v0.5.1/solidity-in-depth.html) is a good place to start.

In a directory of your choice make a new project folder and initialize Truffle in it.

    $ mkdir myproject
    $ cd myproject
    $ truffle init`

Now we're going to install the OpenZeppelin library into our projects root directory. We use the **--save-exact** option to ensure that all dependencies are configured with an exact version since breaking changes (change in software that can potentially make other components fail) might occur when versions are updated.

    $ npm init -y
    $ npm install --save-exact openzeppelin-solidity

OpenZeppelin is now installed. The library of contracts are stored in the **node_modules/openzeppelin-solidity/contracts** folder path within your project.

To use the library, add an import statement at the beginning of the contract specifying which one you want to use.

  `$ import "openzeppelin-solidity/contracts/ownership/Ownable.sol";`

## Conclusion

OpenZeppelin allows you to write more complex and secure contracts using their variety of base contracts. Less time is spent building the foundation and thus more time is available to optimize details. Throughout the rest of this tutorial series, we're going to be discussing the different kinds of contracts as well as their uses.

Documentation & Helpful Links:

<https://github.com/OpenZeppelin/openzeppelin-solidity>

<https://openzeppelin.org/>

[Click here for examples of contracts that use the OpenZeppelin library.](https://github.com/OpenZeppelin/openzeppelin-solidity/tree/2c34cfbe0ea5b2969ca5a13710694f44c1be3e6a/contracts/mocks)
