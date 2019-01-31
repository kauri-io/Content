# Introductory To OpenZeppelin

#### What Is OpenZeppelin?

OpenZeppelin is a library of reusable smart contracts for the Ethereum blockchain. It focuses on secure and simple open source code. The contracts are continuously tested and community reviewed and they follow the best industry standards and security practices.

#### OpenZeppelin vs ZeppelinOS

The difference between both applications is that OpenZeppelin is a framework of contracts to use In your code, while ZeppelinOS is a platform of utilities to securely manage your smart contracts. In this tutorial series we will only be focusing on OpenZeppelin.

#### Types of contracts

 Depending on your project, OpenZeppelin has many different kinds of contracts to meet your needs. Contracts are divided into the following categories:

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

The idea behind the contract database is to make it easier for you write your own. Contracts from OpenZeppelin should not be modified but instead inherited or combined with your own contracts for the best functionality. Its purpose is to serve as a base for you to get started with. We will dive into the contracts and their uses later on the series.

#### How To Download

To begin, you will need to have Node.js and Truffle installed on your machine. As well to work with OpenZeppelin you should be familiar with Solidity: the programming language for smart contracts. The [Solidity In Depth Manual](https://solidity.readthedocs.io/en/v0.5.1/solidity-in-depth.html) is a good read to brush up on the language.

To download [Node.js](https://nodejs.org/en/download/) click on the hyperlink and follow the instructions in regards to your operating system.

To install Truffle simply open your command terminal of choice and type in the following.

Note: You must have Node.js  installed before you can download Truffle.

    $ npm install -g truffle

In a directory of your choice you are going to make a new project folder and initialize it with Truffle.

    $ mkdir myproject
    $ cd myproject
    $ truffle init

We are now going to install the OpenZeppelin library into our projects root directory. We use the --save-exact option to ensure that all dependencies are configured with an exact version since breaking changes(change in software that will potentially make other components fail) might occur when versions are updated.

    $ npm init -y
    $ npm install --save-exact openzeppelin-solidity

OpenZeppelin is now fully installed. All of the library's contracts will be stored in the following folder path within your project.

        node_modules/openzeppelin-solidity/contracts

To use the contracts all you have to do is import them by adding an import statement at the beginning of your contract:

        import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

Note: OpenZeppelin must be installed every time you make a new project. It is not accessible from project to project.

#### Conclusion

OpenZeppelin allows the user to write amazing contracts using a wide variety of baseline contracts to choose from. As well, Every contract follows secure industry standards. As a developer or independent user, you're going to save time and effort while using OpenZeppelin. In the rest of the tutorial series we're going to be talking about the different types of contracts and their uses.

Documentation:

<https://github.com/OpenZeppelin/openzeppelin-solidity>

<https://openzeppelin.org/>

To see examples of
