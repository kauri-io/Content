As discussed earlier in the series, when developing dApps, and especially writing smart contracts, there are many repetitive tasks you will undertake. Such as compiling source code, generating ABIs, testing, and deployment.

Development frameworks hide the complexity of these tasks and enable you as a developer to focus on developing your dApp/idea.

Before we take a look at these frameworks such as [truffle](https://truffleframework.com/), [embark](https://embark.status.im/) and [populous](https://github.com/ethereum/populus), we’re going to take a detour and have a look at the tasks performed and hidden by these frameworks.

Understanding whats happening under the hood is particularly useful when you run into issues or bugs with these frameworks.

So this article will walk you through how to manually compile and deploy your Bounties.vy smart contract from the command line, to a local development blockchain.

## Steps

Before deployment, a smart contract needs to be encoded into EVM friendly binary called bytecode, much like a compiled Java class.
The following steps typically need to take place before a contract is deployed:

1. Smart contract is written in a human friendly language (e.g Vyper)
2. The code is compiled into bytecode and a set of function descriptors (Application Binary Interface, known as ABI) by a compiler (e.g vyper)
3. The bytecode is packed with other parameters into a transaction
4. The transaction is signed by the account deploying the contract
5. The signed transaction is sent to the blockchain and mined

So for step 1, will we use the [Bounties.vy](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/blob/master/manual-compilation-and-deploy/Bounties.vy) contract we have written previously in this series.

## Vyper Compiler

Step 2 requires us to compile our smart contract, in order to compile vyper we need to use the vyper compiler. Typically frameworks such as [truffle](https://truffleframework.com/), [embark](https://embark.status.im/) and [populous](https://github.com/ethereum/populus) come with a version of vyper preconfigured, however since we will be compiling without a framework, we will need to install vyper manually.

### Installing Vyper

# Using pip

```
pip install vyper
```

### Installing JQ

To help with processing json content, during compilation and deployment lets install JQ
Using homebrew:

```
brew install jq
```

Or on ubuntu like so:

```
sudo apt-get install jq
```

Read more about [installing jq here](https://stedolan.github.io/jq/download/)

Windows users should also read the link above.

### Compiling Vyper

Once vyper is installed we can now compile our smart contract. Here we want to generate

- The bytecode (binary)to be deployed to the blockchain
- The ABI (Application Binary Interface) which tells us how to interact with the deployed contract

So lets setup our directory to work from and copy our Bounties.vy smart contract

```
mkdir dapp-series-bounties
cd dapp-series-bounties
touch Bounties.vy
```

Now copy the contents of [Bounties.vy](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/blob/master/manual-compilation-and-deploy/Bounties.vy) which we previously developed into the Bounties.vy file.

The command to compile would be:

```
$ vyper -f json Bounties.vy
```

This command tells the compiler to combine both the abi and binary output into one json file, Bounties.json. To get the abi from the vyper contract, use

```
$ vyper -f abi Bounties.vy
```

We can view the output using jq:

```
$ cat Bounties.json| jq

[
  {
    "name": "BountyIssued",
    "inputs": [
      {
        "type": "int128",
        "name": "_id",
        "indexed": false
      },
      {
        "type": "address",
        "name": "_issuer",
        "indexed": true
      },
      {
        "type": "uint256",
        "name": "_amount",
        "indexed": false,
        "unit": "wei"
      },
      {
        "type": "bytes32",
        "name": "data",
        "indexed": false
      }
    ],
    "anonymous": false,
    "type": "event"
  },...]
```

## Deployment

Now its time to deploy our smart contract!

This command:

`vyper Bounties.vy`

Returns the contract's bytecode which you can use to deploy through mist, geth or with myetherwallet

## Next Steps

- Read the next guide: [Truffle: Smart Contract Compilation & Deployment](https://kauri.io/article/cbc38bf09088426fbefcbe7d42ac679f/truffle:-smart-contract-compilation-and-deployment)
- Learn more about the Truffle suite of tools from the [website](https://truffleframework.com/)

> If you enjoyed this guide, or have any suggestions or questions, let me know in the comments.

> If you have found any errors, feel free to update this guide by selecting the **'Update Article'** option in the right hand menu, and/or [update the code](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/truffle-compilation-and-deploy)
