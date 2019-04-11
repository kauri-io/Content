# Proposal: The many ways to set up a Go Ethereum development environment

## Development on the testnets

- Testnets and the difference.
  - Ropsten: PoW testnet. Allows testing of DApp in PoW environment.
  - Rinkeby: PoA testnet. Guaranteed blocks mined every 15 seconds.

### Run Geth node connected to the Ethereum network

`geth --syncmode="light" --rinkeby --rpc --rpcapi="eth,web3,admin,personal" --ws`
- Light node -- closest to Ethereum networked environment.
- Fast/Full node -- allows you to access data and execute message calls (calls that don't require gas to execute) on synced blocks, but new transactions cannot be broadcast to the network if you're not connected to it.

`infura.io`
- Public gateway. Same as light node, but without the need to run it locally.
- Managed by third-party; precautions apply.

## Offline development

- Can set up local development environment that simulates an Ethereum blockchain.
- Essentially running a blockchain simulator.
- Allows offline local development.
- GasPrice and GasLimit are arbitrarily set.

`geth --dev --rpc --rpcapi="eth,web3,admin,personal" --ws`
- prefunded developer account (set as eth.accounts[0] and eth.coinbase; locked with passphrase `""`)

`geth puppeth`
- set up local PoA network with the Puppeth tool.

## Unit testing with backend simulator

Can write a backend simulator into your Go application to build test suites; allows for unit testing.

`sim := backends.NewSimulatedBackend(genesisAlloc, auth.GasLimit)`

