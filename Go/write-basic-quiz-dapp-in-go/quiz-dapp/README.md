# Basic Quiz DApp in Go

## Requirements
Requires:


- Go ^1.11
- Make sure Go modules are enabled by running `export GO111MODULE=on`
- github.com/ethereum/go-ethereum ^v1.8.20
- github.com/joho/godotenv ^1.3.0

To compile the contract:

- `abigen` github.com/ethereum/go-ethereum ^v1.8.20
- `solc` from github.com/ethereum/solidity ^0.5.2

To use `compile-abi.sh`:

- Docker

## Run

1. Create a `.env` file. You can use `env_example` as a template.
    ```bash
    cp env_example .env
    ```
2. Your `.env` file should look like this:
    ```env
    GATEWAY="https://rinkeby.infura.io/v3/<project_id>"                 // IPC or TCP Gateway
    KEYSTORE="keystore/UTC--2019-01-11T19-49-52.732927400Z--<addr>"     // Keystore file.
    KEYSTOREPASS=""                                                     // Keystore password
    QUESTION="this is a question"                                       // Quiz question
    ANSWER="this is an answer"                                          // Quiz answer
    ```


Make sure you have a keystore file. 
You can create one with `geth` 
(and in the process, create a new Ethereum wallet)
by running:
    ```bash
    # Create new keystore file in current directory
    geth --datadir . account new
    ```

Or to run the application in a private chain:

```bash
# You'll find your keystore file in ./private_node/go-ethereum.../<keystorefile>
# Your IPC endpoint will be ./private_node/geth.ipc
geth --dev --datadir ./private_node
```
