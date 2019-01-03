# Go Ethereum Article Outline

Objective: Introduce the reader to developing Dapps for the Ethereum chain with Go.

## Why write Dapps using Go?

- Type-safe way to interact with contracts and the Ethereum chain.
- Extensive Go library.
- Compatible with Go test suites.
- Direct interaction with contract ABI, no need to write contract migrations like with the Truffle suite.
- No browser dependencies required. Interact directly with the Ethereum blockchain using Go instead of connecting using third party software like Metamask.

## Set up an Ethereum light node

- Difference between fast, full, and light. Link to node sizes chart in Etherscan.
- Why run a fast node?
- Keep guide simple, use light node.
- Connect Geth node to the Rinkeby network. Publish RPC and Websocket endpoints for our Go application to connect to.
- Sidebar: What is Rinkeby?
- Get testnet Eth from Rinkeby faucet: <https://faucet.rinkeby.io/>

## Write Ethereum contracts in Solidity

- Ethereum contracts still have to be written in Solidity or other Ethereum-friendly contract languages.
- Choose Solidity because it's accessible, widely supported, and has built-in support in Abigen
- (build solidty contract code and abi directly into .go bindings file with --sol flag)

## Make simple puzzle-solving contract

- Constructor initializes contract with answer as input.
- Answer is then stored as a keccak256 hash in our contract code.
- "Answer" application takes input from user ("userAnswer") and compares it with the stored hash.
- Users that give the correct answer are then listed on the contract leaderboard (a map of addresses and date of answer).

## Generate Go bindings from .sol file.

## Write applications to interact with contract.

- Go application to deploy contract.
- Go application that:

  - Prints out question.
  - Gets user's answer and sends it to contract.
  - Listens for a success state for a correct answer, or a fail state for a wrong answer.

- Go application that reads and prints out the leaderboard (top 10).
