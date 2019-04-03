# Plasma Roundup: From MVP to Mainnet

Ethereum second layer scaling technology has come a long way in a short period of time. Second layer solutions, innovations beyond the layer one protocol level, include State Channels, Side Chains and Plasma. Taken together, layer two technologies present a wide scope of possibility for scaling the Ethereum blockchain.

In August 2017, Plasma creators Joseph Poon and Vitalik Buterin [proposed this framework](https://plasma.io/plasma.pdf) for scaling Ethereum transaction throughput to a "significant amount of state updates per second," potentially more than Paypal, Visa or other widely used merchant service providers.

Aside from offering comparable, if not more, transactions per second Plasma stakes its security in the value of Ethereum’s decentralized mainchain rather than in a centralized merchant service.

The promise of Plasma lays in its potential to help scale blockchain technology by processing a substantial amount of decentralized financial applications worldwide.

In January 2018, Vitalik posted the [“Minimal Viable Plasma” (MVP) specification to the Ethereum Research Forums](https://ethresear.ch/t/minimal-viable-plasma/426). The specification was designed to offer simplicity and basic security properties to kickstart development. Teams immediately began building their own implementations.

This overview is not meant to be exhaustive. Instead, by highlighting a few implementations, it aims to be indicative of the progress that Plasma has made over the past year.

Although none of the Plasma models reviewed here are production ready, they show that this technology is not just theory. Taken together, the implementations suggest that Plasma is moving rapidly toward realizing the scaling potential that its creators and implementers envision.

## Prerequisites

For most of these projects you need Truffle, Ganache and npm installed.

## FourthState Labs

Among the early Plasma implementations was [FourthState Labs](https://github.com/FourthState/plasma-mvp-rootchain), whose design included a rootchain contract according to the Plasma MVP. This rootchain, which other projects have also incorporated, is a series of Solidity smart contracts. It may be a good place to start if you are considering building your own Plasma chain. It is designed to maintain a mapping from from block number to merkle root, processing deposits, withdrawals and resolving transaction disputes. FourthState has written tests for these features which you can run by following these steps:

```shell
git clone https://github.com/fourthstate/plasma-mvp-rootchain
cd plasma-mvp-rootchain
npm install
ganache-cli // In seperate terminal window
npm test
```

![FourthState tests](/images-for-article/Fourth-Estate/fourth-estate.png)

<!-- TODO: Running? -->

## OmiseGO

Other notable early MVP's include [OmiseGO's implementation](https://github.com/omisego/plasma-contracts).  OmiseGO aspires to enable financial inclusion and interoperability through a public, decentralized OMG network. A key component of this network is Plasma. OMG’s implementation which has a root chain, child chain and a client to interact with the Plasma chain, is different from the MVP specification, however. For instance, OMG has added protection against the threat of chain re-organization (which can result from 51% attacks). And, among other additions, it has built in support for ERC20 token handling.

## Kyokan Plasma

Making the significant jump from MVP to mainnet is [Kyokan](https://github.com/kyokan/plasma). Kyokan is a Golang implementation [extending the original MVP specification](https://kauri.io/article/7f9e1c04f3964016806becc33003bdf3/v4/minimum-viable-plasma-the-kyokan-implementation). Their architecture uses the FourthState rootchain contract reviewed above and also includes root nodes to process transactions and package them into blocks, broadcast blocks to validator nodes, process exits and more. The team has been working steady since March 2018 to build a production-ready plasma implementation. Last month, just one year later, Kyokan announced that they have achieved [two critical milestones on the way to that goal](https://medium.com/kyokan-llc/announcing-our-plasma-mvp-alpha-23a8bc9673fc): the launch of their MVP mainnet alpha (capable of an initial 1,000 transactions per second) and the completion of their security audit. To help test how their Plasma will behave now that they have released it into the wild, Kyokan has launched a game of Capture the Flag where people are invited to break the system and keep the funds “just let us know how you did it, so that the rest of the community can benefit.” Successful denial of service attacks and attacks that lead to a loss of funds in [the smart contract](https://etherscan.io/address/0x0cdd78c34a4305234898864c1daccdbb326a520d) will also be paid $1,000.

While Plasma’s arrival on mainnnet is a notable milestone, the technology’s evolution needs more work and time before it is ready for mass adoption.  



Moving beyond research, [Kyokan](https://github.com/kyokan/plasma) introduced their Golang implementation [extending the original MVP specification](https://kauri.io/article/7f9e1c04f3964016806becc33003bdf3/v4/minimum-viable-plasma-the-kyokan-implementation). Kyokan uses the FourthState rootchain contract reviewed above. The architecture includes root nodes to process transactions and package them into blocks, broadcasts blocks to validator nodes, processes exits and more.



## Plasma Group

Closing 2018, the [Plasma Group](https://plasma.group/) [announced the release of their implementation](https://medium.com/plasma-group/plasma-spec-9d98d0f2fccf) aimed at the greater Ethereum community. It includes a Plasma chain operator, a client and command line wallet, support for ERC20 tokens, a block explorer, transaction load testing and more. While their implementation includes properties such as scalable light client proofs and the possibility for interchain atomic swaps, the group has moved quickly to offer a [general purpose plasma design](https://medium.com/plasma-group/towards-a-general-purpose-plasma-f1cc4d49c1f4). This general purpose design aims to overcome constraints in old design patterns which were not upgradeable and not generalizable. The purpose is to create a plasma environment that would allow the development of applications on a Plasma chain in the same way that dapps are built on the Ethereum blockchain. Hence the Plasma Group has recently offered plasma apps, also known as ‘plapps’. Plapps are a special type of smart contract called a ‘[predicate contract](https://github.com/plasma-group/plasma-predicates)’. Plapps are deployed to Ethereum, where users can interact with the contract and the plasma chain carries out the computation, which is less expensive than if it were to occur on the Ethereum main chain. 

Many aspects of [this implementation are testable](https://github.com/plasma-group). To test the [Plasma Core](https://github.com/plasma-group/plasma-core) follow these steps:

```shell
git clone git@github.com:plasma-group/plasma-core.git
cd plasma-core
npm install
npm test
```

![Plasma Core](images-for-article/Plasma-Group/Plasma-Core/plasma-group-core-test-41-passing.png)
![Plasma Core](images-for-article/Plasma-Group/Plasma-Core/plasma-group-core-test-10-passing.png)

To run Plasma Group's [chain operator](https://github.com/plasma-group/plasma-chain-operator), follow these steps:

```shell
npm install plasma-chain -g
plasma-chain account new
```

Use the [Rinkeby testnet faucet](https://faucet.rinkeby.io/) to send your Operator address ~0.5 ETH.

List all the Plasma chains which others have deployed to the Plasma Network Registry.

```shell
plasma-chain list
```

![Plasma Chain List](images-for-article/Plasma-Group/Plasma-Chain-Operator/plasma-chain-list.png)

```shell
plasma-chain deploy # the cli will warn you that deplyment takes time. it does.
plasma-chain start
```

Optionally, if you want to send test transactions to your chain run `plasma-chain testSwarm`.

To spin up Plasma Group's block explorer, assuming the same environment as above, do the following:

```shell
git clone https://github.com/plasma-group/plasma-explorer
npm install
npm run serve
```

View the local block explorer at _<http://127.0.0.1:8000>_. If that does not work you may need to forward traffic from port 80 to port 3000 with this command:

```shell
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 3000
```

![Plasma Group Block Explorer](images-for-article/Plasma-Group/Plasma-Block-Explorer/plasma-block-explorer.png)

## Summary

Overall, Plasma seems to be making a great leap forward, but there are still a few obstacles to overcome. Implementations need to be audited and tested. With mass adoption and the potential for global application, the stakes are high for these chains which, if all goes according plan, will be processing a significant number of states per second, each state possibly holding very high value. These implementations may suggest that layer two Plasma technology is right around the corner, but careful engineering to protect users and avoid risk will take time.
