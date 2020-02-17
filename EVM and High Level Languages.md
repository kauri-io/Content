# The EVM and High-Level Smart Contract Programming Languages

## Introduction

Bitcoin has always been the highest volume and value cryptocurrency in digital money, and it runs on blockchain technology. Blockchain is a peer to peer, public, encrypted, trust-less ledger. [Script ](https://en.bitcoin.it/wiki/Script) is the name of the scripting language that constructs Bitcoin. Script is a mid to lower capability programming language. Public and private key transacting is the model for signing transactions. Besides transacting digital assets, there is no extra utility built into Bitcoin. 

Ethereum Blockchain technology offers limitless use cases, thanks to its virtual machine. Smart contracts are programs written in a high-level programming language, including [Solidity ](https://solidity.readthedocs.io/) and [Vyper](https://vyper.readthedocs.io/en/latest/installing-vyper.html). These languages build Smart contract code that compiles for use on the Ethereum Blockchain. This computing system revolutionizes privacy, security, and freedom otherwise unrealized in present-day governance.

## Ethereum Virtual Machine Feature Overview

High-level is a vague description of a computing platform's capability. Precise performance metrics would go beyond the scope of this article. The Ethereum Blockchain is a powerful and isolated virtual computing environment. Computing features of the Ethereum Virtual Machine (EVM) include: 

* Predefined function libraries 
* Function constructors and destructors
* Function overrides 
* High-level logic
* Looping and recursion 
* Full range of expressions for logical and mathematical arguments
* Control structures
* More than one variable can pass in and out of a function 
* User ability to define custom functions 
* Inheritance
* Polymorphism 
* Sand boxing 
* Two-way interaction with other smart contracts 

Simple transaction protocol initiates the deployment of very powerful applications on the EVM. The Ethereum protocol is trust-less; secured by peer-to-peer consensus and data encryption. It is very difficult, impossible, to access unauthorized information. The program code is verifiable and impossible to alter. Always available to every user as the same version and build. Pushing updates that users ignore can become a thing of the past.

Prebuilt functions are built in the EVM.  Among other things these functions create data abstractions between the developer and the actual blockchain implementation.  Direct features of the EVM are listed below that have an aggregate functionality of a self contained computer system.

* Simple transaction methods for new smart contract deployment
* Smart contract interaction only by address
* Arguments and data pass in from the user and pass out to a user or contract
* A stack type data structure holds local variables
* It reads function call arguments and return-addresses
* Logic functions can change the order in which instructions execute
* Addressable persistent storage acts as a virtual hard drive 
* Non-persistent storage acts as system memory

A closer look at the EVM and dApp ecosystem show a complex orchestration of silently running programs and processes. Technology today offers many choices in a programming language presenting obstacles in compatibility. Cross-platform data abstraction requires a complex web of behind the scenes computing. 

## Discrete Parts that make the EVM

As stated before, the EVM is prebuilt with libraries of ready to use functions. Smart contract languages such as Solidity and Vyper are simple, feature-rich languages. Embedded function libraries manipulate data in ways making the EVM quasi-Turing complete. Turing complete system is so named on the basis that it can use a lot of math proving it can solve any algorithm.

### EVM Opcodes and Bytecode

<a href="https://imgur.com/J3lKgEy"><img src="https://i.imgur.com/J3lKgEy.png" title="source: imgur.com" /></a>

Opcodes are a large library of functions preprogrammed into the EVM. You can find a list of all Opcodes [in the documentation](https://www.ethervm.io/#opcodes). Fewer resources handle these functions because they are small, 4-bit hex identifiers. Every function found in JavaScript or Python exists also in the EVM. Opcodes include functions for data manipulation, I/O, storage, security, and logic. High-level smart contract language compiles into bytecode. This is data passed into the EVM in hex that calls opcode functions and handles user arguments. The image located at the top of the page is a matrix of two digit hex opcodes. 

### Transactions

Smart Contracts are deployed on the EVM blockchain. Every type of transaction uses the same format to execute the EVM. Two main smart contact transactions call the contract or deploy a new contract. Either of these transactions are capable of calling a large variety of functions. Functions called can be user defined. Data passes in and out of the EVM in either case. This data can pass back to the user or forward on to another contract.

<a href="https://imgur.com/bfKk7mY"><img src="https://i.imgur.com/bfKk7mY.png" title="source: imgur.com" /></a>

The image above shows how a transaction flow happens in the EVM. Data is passed out of the EVM in what is known as a 'block'. A block is the final result of the arguments, variables, functions, and transactions presented. The data has been manipulated and encrypted. A proof of work puzzle solved by network miners cryptographically proves data integrity. It also cryptographically ties the completed block to adjacent data blocks.

## Miners - The actual computing power of the EVM

Key features of the Ethereum Blockchain include decentralization and peer to peer networking. A node can be run by any individual with hardware meeting minimum system requirements. Transactions are broadcast on to the network so that multiple nodes can see them at the same time. A fee is included for the miner that completes the proof of work and finishes a block. This spider web type of proliferation allows the nodes to compare the information they have received and agree that it matches. This comparison is performed among many nodes to create what is called consensus, or agreement that the values now held in block are the true values that represent the current state of the EVM.

## Package Managers, Containers, and Data Abstraction

<a style="height: auto, width: auto"><img src="https://i.imgur.com/x9pHiHQ.png" title="source: imgur.com" /></a>

The above image shows a visual relationship between the high-level languages that are used for dApp programming and the Ethereum Blockchain. Typical dApp implementations may contain multiple programming languages and protocols. The dApp is therefore often created using a container for development and deployment. A container creates an enclosed running environment that holds utilities, libraries, dependencies, and Path variables to ensure proper functionality of the modular dApp components. 

NPM, Yarn, Django, and React are all package managers that install and abstract the dependencies required in dApp deployment. These various modules handle everything from coding, test flow, and smart contract deployment. This list is not exhaustive of the features and development flows requiring multiple app dependencies installed. During development, the installed application modules are fine tuned by the developer. A package file is created as a manifest for the container application to automatically handle installation and configuration of the many installed dependencies and variables required for these foreign protocols to communicate correctly.

In the image there are four modules on the client-side and two modules on the server side. The client-side implementation shows a dApp browser user interface, web3.js interface, HTML/CSS/JS, and the smart contract component (written in a programming language such as Solidity or Vyper). Each physical platform also denotes a layer of abstraction that is created by high-level language, package installation management, and app containers.

A user can open a dApp on a dApp browser with zero need to specify how to run in that environment. This behind the scenes configuration is no small task. Package manifests can list installation dependency lists with 10, 20, 50, or more installed dependencies required. Package managers such as NPM or Yarn manage the installation specifically creating a run-time environment optimized to run the dApp

The final layer of abstraction happens between the client-side hardware and the Ethereum Virtual Machine. Package managers and containers also orchestrate plug-ins and dependency installation for interacting with the EVM.

## Conclusion

The Ethereum Virtual Machine is a blockchain that serves as a secure database.  It is also a self contained virtual computer that can execute high level program instructions.  The code is stored publicly as are the resulting state.  Programs can be trusted.  Work flow can be automated.  Information can be validated.  Finances and loans can be automated and reduce or eliminate the risk of lending.  The high-level functionalities of the EVM open the imagination to an infinite spectrum of use cases.  The bottleneck lies only in the imagination of the developer, or lack thereof.

This series examines the EVM at a deeper level for blockchain educated readers, but still only scratches the surface of how much information exists about the EVM.  Resources have been listed at the end of each part of this four part series to direct the reader to more in depth subject matter.


## Resources

* [What is the Ethereum Virtual Machine?](https://techcoins.net/ethereum-virtual-machine/)

* [Solidity](https://solidity.readthedocs.io/en/develop/index.html)

* [Vyper](https://github.com/vyperlang/vyper)

* [How to Learn Solidity:  The Ultimate Ethereum Coding Tutorial](https://blockgeeks.com/guides/solidity/)

