# Go Ethereum Article Outline

Objective: Introduce the reader to developing Dapps for the Ethereum chain with Go.

## Why write Dapps using Go?

- Type-safe way to interact with contracts and the Ethereum chain.
- Extensive Go library.
- Compatible with Go test suites.
- Direct interaction with contract ABI and blockchain.

## Set up an Ethereum light node

- Keep guide simple, use light node.
- Make sure you've got [Geth](https://geth.ethereum.org/install/) installed.
- Connect Geth node to the Rinkeby network: `geth --syncmode="light" --rinkeby --rpc --rpcapi="eth,web3,personal" --ws`
  - Rinkeby: 
    - PoA testnet to make sure your application works in an environment that is as close to live as possible. 
    - Makes sure that you deal with gas price issues, and transaction failures. 
    - Must always plan for transaction failures.
- Get testnet Eth from Rinkeby faucet: <https://faucet.rinkeby.io/>

## Make simple quiz contract

- Constructor initializes contract with answer as input.
- Answer is then stored as a keccak256 hash in our contract code.
- "Answer" application takes input from user ("userAnswer") and compares it with the stored hash.
- Users that give the correct answer are then listed on the contract leaderboard (a map of addresses and date of answer).

## Generate Go bindings from .sol file.

- `abigen --sol=simplequiz.sol --pkg=simplequiz --Type=SimpleQuiz --out=/simplequiz/simplequiz.go`

## Write applications to interact with contract.

- Go application to deploy contract.
- Go application that:
  - Prints out question.
  - Gets user's answer and sends it to contract.
  - Listens for a success state for a correct answer, or a fail state for a wrong answer.
- Go application that reads and prints out the leaderboard (top 10).

## Quirks and Gotchas when running Geth in docker

–	Must run with flag --ipcaddr 0.0.0.0 to your working environment to connect to Geth running in the docker container. Without this, Geth binds to "127.0.0.1" on the docker container, which makes it accessible only from inside the container.
–	This forces Geth to bind to the docker container’s network interface, allowing access to Geth from outside the container.
–	Note that this also allows access to Geth from any device on the network that can connect to the host on the port Geth is listening on.
