****Not Finished****


# How to Build a Simple Crowdsale Contract

In our last tutorial we are going to be combining everything we've learned to create a simple crowdsale contract. Here is the full source code for this project.

#### Prerequisites

-   Basic understanding of OpenZeppelin. Read the previous tutorials In this series if you haven't done so yet.

-   Proficient with the Solidity language.

-   Knowledge on ERC20 token standards.

#### Downloads

Note: Windows users should use Powershell for the duration of this tutorials

We are going to require the following pieces of software to create this project.

-   Node.js : A JavaScript run-time environment.

Follow the [link](https://nodejs.org/en/download/) and follow the steps provided to download Node.js onto your operating system.

#### Getting Started

To begin we are going to create our project folder. Go into the directory where you would like to store your project

`$ mkdir simpleCrowdsale`

`$ cd simpleCrowdsale`

Now initialize the project with truffle:

`$ truffle init


Your file structure should look as follows:

//add file structure photo

After creating our folder and initializing our development environment we are going to add OpenZeppelin to the project.

Make sure you are inside your project directory and then type this code into the terminal:

`$ npm init -y`

`$ npm install --save-exact openzeppelin-solidity`

Now that we have everything installed we can finally start to create our contract!

Using your text editor of choice (I'm using Atom) open your project. Underneath the `contracts` folder create a new file and name it `simpleCrowdsale.sol`. This file is your smart contract.

Add the following code to your `simpleCrowdsale.sol` contract.

```solidity
pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/distribution/RefundableCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
```

First we told the compiler which version of solidity to use and then we imported all the contracts we want to inherit from OpenZeppelin.

To create the contract class we are going to add the following:

```solidity
contract simpleCrowdsaleToken is ERC20Mintable, ERC20Detailed {
  constructor () public ERC20Detailed("Simple Crowdsale Token", "SCT", 18){
  }

}
```

To use in the crowdsale, we created a very simple ERC20 token called simpleCrowdsaleToken that can be minted (ERC20Mintable) and is detailed (ERC20Detailed).

Using a constructor we created the token and we listed the properties defined by the ERC20Detailed function. The order goes: name, symbol, and decimal. You can change the name and symbol to whatever you like but it is recommended to keep the decimal set to 18 to meet token standards.
