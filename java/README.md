Ethereum-Java content series
==========

## Section 1: Beginners

In this section, Java developers can get started with Blockchain and Ethereum to understand the basic functionallities around accounts and smart contracts using the Java library [Web3j](https://web3j.io/).


### [Getting started, Connect to an Ethereum client](getting-started-eclipse.md) - greg

> [Chris: We will likely need an IntelliJ version too, or do we combine the posts, and separate the post after installing?]
> [Greg: I only did Eclipse because I think it is more clear for the reader. But yeah we would likely need the same for IntelliJ, would be nice to have some sort of multi-choice pannel]

IDE (Eclipse, IntelliJ)
Maven/Gradle - import dependency
Web3j class - Connect to the node (HTTP/WebSocket)
Web3j class - Interract with the node (basic): client version, gasPrice, ...


### [Manage an Ethereum account](manage-accounts.md) - greg

Account creation and wallet
Account information (balance, nonce, transaction history)
Send transaction
- Gas management
- Nonce
- Signing methods (node, middleware, client)
- TransactionManager (RawTransactionManager, FastRawTransactionManager, ReadonlyTransactionManager) and TransactionReceiptProcessor (Polling, Queuing, NoOp)

### [Generate a Java Wrapper from your Smart Contract](generate-java-wrapper.md) - greg

######  Cli
Install command line tool (web3j) and run the command

###### Maven
https://github.com/web3j/web3j-maven-plugin

###### Gradle
https://github.com/web3j/web3j-gradle-plugin

### [Interact with a Smart Contract](interacting.md) - Craig

Deployment
Function (call/transaction)


### [Listen Smart Contract events](events.md) - Craig

Observable
Filters

Reference to Eventeum for more robust and complex usecase

### [Testing](pantheon_testing.md) - Craig

Junit
embedded Pantheon



------------------------------------------

## Section 2: Intermediary

### Web3j: Advanced concepts
- transaction manager (ClientTransactionManager, RawTransactionManager, FastRawTransactionManager, ReadonlyTransactionManager)
- Transaction receipt processor
- ContractGasProvider



### Run your own node with Pantheon (A Java Enterprise Ethereum client)

Pantheon
Connect Web3j to Pantheon


### Pantehon - Private network



### Eventeum: Event Listener for a microservice architecture

Eventeum

### Working with ERC20 and ERC721 tokens



### Android development
I'm talking with the TAUG, an Android development group in Toulouse, to see how they can help out. They seem initially interested- but seems longer term.


------------------------------------------

## Section 3: Advanced

### Cava

Cryptography, blockchain utils



### Build a Dapp with a Java stack

Enterprise usecase?


### Meta-tx relayer in Java

Example of Kauri protocol SDK implementation


### IPFS Java


### Mahuta: A Java indexation/caching layer for IPFS



-------------------------------------------

## Existing Resources

> [Chris: I'm unsure what "content types" we have in communities, but we should definately add these to article sections]
> [Greg: a community can have articles and collections]

### Kauri articles:
- https://kauri.io/article/311e46faf254462f9755e245a48de0cb/v1/simple-kotlin-springboot-dapp-utilizing-web3j
- https://kauri.io/article/8fab39d41b834c6ca127ee112af3d6c9/v1/sending-transactions-to-pantheon
- https://kauri.io/article/fe81ee9612eb4e5a9ab72790ef24283d/using-eventeum-to-build-a-java-smart-contract-data-cache
- https://kauri.io/article/28c03622682842c888f6106a60c4d323/v1/introduction-to-pantheon-the-java-ethereum-client
- https://kauri.io/article/48c4c61a77304ecab8df7247aa1900ac/v1/pantheon-the-enterprise-ethereum-client
- https://kauri.io/article/f0758bcdfad84d70a5d1adf43baa59d4/v1/privacy-with-pantheon-ethereum-java-client

> [Chris: These would make great "links" if we support those at any point]
> [Greg: They could be "curated", via the API only for phase 1]

### Greg StackOverflow answers:
- https://ethereum.stackexchange.com/questions/66277/how-to-change-the-nonce-between-transactions-in-web3j/66290#66290
- https://ethereum.stackexchange.com/questions/66379/recover-solidity-funcion-event-in-web3j/66409#66409
- https://ethereum.stackexchange.com/questions/66387/where-is-the-ethlogobservable-method-in-web3j/66407#66407
- https://ethereum.stackexchange.com/questions/65039/pass-specific-address-in-web3j-send-method/65043#65043
- https://ethereum.stackexchange.com/questions/64856/web3j-how-to-get-event-args-when-parsing-logs/64865#64865
- https://ethereum.stackexchange.com/questions/64264/not-able-to-decode-the-input-data-from-transaction-using-web3j/64271#64271
- https://ethereum.stackexchange.com/questions/58102/compatibility-between-solidity-language-and-web3j-library/58107#58107
- https://ethereum.stackexchange.com/questions/66262/error-generating-new-account-with-web3j/66267#66267
- https://ethereum.stackexchange.com/questions/64254/java-lang-classcastexception-org-bouncycastle-to-error-while-creating-wallet-us/64266#64266
- https://ethereum.stackexchange.com/questions/35381/web3j-doesnt-observe-new-blocks-transactions/62721#62721
- https://ethereum.stackexchange.com/questions/29545/how-to-use-web3j-to-observe-transaction-of-erc20-token/71676#71676
- https://ethereum.stackexchange.com/questions/40730/why-is-web3j-java-not-generating-correct-return-types-for-my-contract/71675#71675
- https://ethereum.stackexchange.com/questions/12668/web3j-callback-to-retreive-public-struct/12675#12675

> [Chris: For these, links, or import?]
> [Greg: Just for inspirations]

### Pantheon resources
- https://docs.pantheon.pegasys.tech/en/stable/
- https://github.com/PegaSysEng/pantheon
- https://gitter.im/PegaSysEng/pantheon


### Web3j resources
- https://docs.web3j.io/


### Good Java resources
- https://www.baeldung.com/
- https://dzone.com/
- https://www.mkyong.com/

------------------------------------------
