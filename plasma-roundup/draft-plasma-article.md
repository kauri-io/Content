# Plasma Roundup: From MVP to Plasma Group
By Chris Spannos

Word count: 914

Ethereum second layer scaling technology has come a long way in a very short period of time. Second layer solutions, innovations beyond the layer one protocol level, include State Channels, Side Chains and Plasma. Taken together, layer two technologies present a wide scope of possibility for scaling the Ethereum blockchain. This article focuses on Plasma development only.  

In August 2017, Plasma creators Joseph Poon and Vitalik Buterin [proposed this framework](https://plasma.io/plasma.pdf) for scaling Ethereum transaction throughput to a "significant amount of state updates per second," potentially more than Paypal, Visa or other widely used merchant service providers.

Aside from offering comparable, if not more, transactions per second Plasma stakes its security in the value of Ethereum’s decentralized mainchain rather than in a centralized merchant service.

The promise of Plasma lays in its potential to help scale blockchain technology by processing a substantial amount of decentralized financial applications worldwide.

In January 2018, Vitalik posted the [“Minimal Viable Plasma” (MVP) specification to the Ethereum Research Forums](https://ethresear.ch/t/minimal-viable-plasma/426). The specification was designed to offer simplicity and basic security properties to kickstart development. Teams immediately began building their own implementations.

This overview is not meant to be exhaustive. Instead, by highlighting a few implementations, it aims to be indicative of the progress that Plasma has made over the past year.

Although none of the Plasma models reviewed here are on mainnet or production ready, they demonstrate that this technology is not just theory. Taken together, the many implementations suggest that Plasma is moving rapidly toward realizing the scaling potential that its creators and implementers envision.     

Among the early Plasma implementations was [FourthState Labs](https://github.com/FourthState/plasma-mvp-rootchain), whose design included a rootchain contract according to the Plasma MVP. This rootchain, which has been incorporated into other implementations, is pretty simple to test. To test, I used this environment:

* Linux (Debian Stretch)
* Truffle (v5.0.2)
* Ganache CLI (v6.2.5)
* NPM 6.7.0

Follow these steps to test:

0. `$ git clone https://github.com/fourthstate/plasma-mvp-rootchain`
1. `$ cd plasma-mvp-rootchain`
2. `$ npm install`
3. `$ npm install -g truffle ganache-cli` // if not installed already
4. `$ ganache-cli` // run as a background process
5. `$ npm test`

![FourthState tests](/images-for-article/Fourth-Estate/fourth-estate.png)

Other notable early MVP's include [OmiseGO's research implementation](https://github.com/omisego/plasma-mvp), which has a root chain, child chain and a client to interact with the Plasma chain. Moving beyond research, [Kyokan](https://github.com/kyokan/plasma) introduced their Golang implementation [extending the original MVP specification](https://kauri.io/article/7f9e1c04f3964016806becc33003bdf3/v4/minimum-viable-plasma-the-kyokan-implementation). Kyokan uses the FourthState rootchain contract reviewed above. The architecture includes root nodes to process transactions and package them into blocks, broadcasts blocks to validator nodes, processes exits and more.

In Kyokan, validator nodes check the validity of blocks and exit if bad behavior is detected. The Plasma contract lives on the Ethereum root chain and supports deposits, block submissions, exits and challenges. Kyokan, which aims to provide a pluggable architecture, has deployed their [Plasma Block Explorer](https://explorer.kyokan.io/) on the Rinkeby test net:

![Kyokan Block Explorer](/images-for-article/Kyokan/kyokan-block-explorer.png)

Closing 2018, the [Plasma Group](https://plasma.group/) [announced the release of their implementation](https://medium.com/plasma-group/plasma-spec-9d98d0f2fccf) aimed at the greater Ethereum community. It includes a Plasma chain operator, a client and command line wallet, support for ERC20 tokens, a block explorer, transaction load testing and more.

Many aspects of [this implementation are currently testable](https://github.com/plasma-group). To test the [Plasma Core](https://github.com/plasma-group/plasma-core) (again using the Debian, Ganache, NPM environment), follow these steps:

0. `$ git clone git@github.com:plasma-group/plasma-core.git`
1. `$ cd plasma-core`
2. `$ npm install`
3. `$ npm test`

![Plasma Core](images-for-article/Plasma-Group/Plasma-Core/plasma-group-core-test-41-passing.png)
![Plasma Core](images-for-article/Plasma-Group/Plasma-Core/plasma-group-core-test-10-passing.png)

To run Plasma Group's [chain operator](https://github.com/plasma-group/plasma-chain-operator), follow these steps:

0. `$ npm install plasma-chain -g`
1. `$ plasma-chain account new`
2. Use the [Rinkeby testnet faucet](https://faucet.rinkeby.io/) to send your Operator address ~0.5 ETH.
3. `$ plasma-chain list` # to list all the Plasma chains which others have deployed to the Plasma Network Registry.
![Plasma Chain List](images-for-article/Plasma-Group/Plasma-Chain-Operator/plasma-chain-list.png)
4. `$ plasma-chain deploy` # the cli will warn you that deplyment takes time. it does.
5. `$ plasma-chain start`
6. Optionally, if you want to send test transactions to your chain run: `$ plasma-chain testSwarm`

To spin up Plasma Group's block explorer, assuming the same environment as above, simply:
1. `$ git clone https://github.com/plasma-group/plasma-explorer`
2. `$ npm install`
3. `$ npm run serve`

View the local block explorer at http:127.0.0.1:8000. If that does not work you may need to forward traffic from port 80 to port 3000 with this command:
`$ sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 3000`
![Plasma Group Block Explorer](images-for-article/Plasma-Group/Plasma-Block-Explorer/plasma-block-explorer.png)

Overall, Plasma seems to be making a great leap forward, but there are still a few obstacles to overcome. Implementations need to be audited and tested. With mass adoption and the potential for global application, the stakes are high for these chains which, if all goes according plan, will be processing a significant number of states per second, each state possibly holding very high value. These implementations may suggest that layer two Plasma technology is right around the corner, but careful engineering to protect users and avoid risk will take time.
