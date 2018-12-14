# Plasma MVP

The issues around scaling Ethereum to high-throughput production use cases are well known. There are many solutions to this problem in progress, from state channels to side chains, but an additional complexity is safely transferring transactions between the Ethereum mainchain and these other locations.

[Plasma](https://plasma.io) is a framework proposed by Joseph Poon and Vitalik Buterin to address this, and a handful of projects rapidly emerged to try and implement this proposal.

Following this [was a post](https://ethresear.ch/t/minimal-viable-plasma/426) from Vitalik outlining a minimal viable plasma (MVP) implementation that helped developers start working on a handful of programming language implementations of MVP.

[Plasma MVP](https://plasma.kyokan.io) by Kyokan is one of these implementations, written in Golang. For now, the project is focusing purely on payment use cases, and once they've refined that, they'll move onto generalized smart contracts.

As the project is in development, you may experience problems installing and running it, for best results, use a Debian-based Linux distribution. You can find [full installation instructions](https://plasma.kyokan.io/docs/installation/) in the documentation.

A plasma chain has of one root node that receives transactions, and running the `plasma start` command packages them into blocks to pass to the Ethereum blockchain. The creator of a Dapp typically runs this node, but [more hosted options](https://plasma.kyokan.io/docs/hosted-nodes/) are likely to emerge in the future. The Kyokan implementation mints new blocks every 500 milliseconds, and submits them to the [Plasma smart contract](https://github.com/kyokan/plasma/blob/develop/contracts/contracts/Plasma.sol) running on the Ethereum node you define.

You configure the Plasma node with command line arguments, or a YAML file and options include database location (LevelDB), keys, addresses, and ports. You can find [full details](https://plasma.kyokan.io/docs/configuration/) in the documentation.

A plasma chain also contains any number of validator nodes responsible for verifying blocks that the root node emits and passing transactions from Dapp users to the root node. You start these nodes with the `plasma validate` command as processes part of the Dapp, or by 3rd parties for ultimate decentralized governance. The two node types communicate by a standard JSON-RPC API.

Kyokan's Plasma MVP is undergoing an audit by [Authio](https://authio.org) that should be finished by the end of 2018 and plans to start work on language SDKs in 2019, making it easier and more secure to integrate into your Dapps. Keep an eye on progress in the [Plasma MVP GitHub repository](https://github.com/kyokan/plasma).
