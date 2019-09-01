# Interacting with an Ethereum Smart Contract in Rust

This tutorial will explain how to deploy and interact with Ethereum smart contracts using the Rust programming language.

## Prequisites

We will be following on from the previous article in this series, [Sending Ethereum Transactions with Rust](https://kauri.io/article/97c85229c66445759bb0ce642224d364/sending-ethereum-transactions-with-rust), so ensure that you already know how to import the `rust-web3` library, and how to connect to an Ethereum node.

Like in the previous tutorial, we assume that you have a reasonable level of Ethereum knowledge, and understand what a smart contract is.  If you are a complete Ethereum notive, then I advice that you first check out the [Ethereum 101 series](https://kauri.io/collection/5bb65f0f4f34080001731dc2). 

## The Example Smart Contract

Throughout this tutorial, we will work with a very basic document registry smart contract, where the hash of the document can be stored on the Ethereum blockchain for proof of authorship.

```solidity
pragma solidity ^0.5.6;


/**
*  @dev Smart Contract resposible to notarize documents on the Ethereum Blockchain
*/
contract DocumentRegistry {

    struct Document {
        address signer; // Notary
        uint date; // Date of notarization
        string hash; // Document Hash
    }

    /**
     *  @dev Storage space used to record all documents notarized with metadata
     */
    mapping(bytes32 => Document) registry;

    /**
     *  @dev Notarize a document identified by the hash of the document hash, the sender and date in the registry
     *  @dev Emit an event Notarized in case of success
     *  @param _documentHash Document hash
     */
    function notarizeDocument(string calldata _documentHash) external returns (bool) {

        bytes32 id = keccak256(abi.encodePacked(_documentHash));

        //Check this document has not already been notarized
        require(registry[id].signer == address(0));

        registry[id].signer = msg.sender;
        registry[id].date = now;
        registry[id].hash = _documentHash;

        emit Notarized(msg.sender, _documentHash);

        return true;
    }

    /**
     *  @dev Verify a document identified by its has was noterized in the registry previsouly.
     *  @param _documentHash Document hash
     *  @return bool if document was noterized previsouly in the registry
     */
    function isNotarized(string calldata _documentHash) external view returns (bool) {
        return registry[keccak256(abi.encodePacked(_documentHash))].signer != address(0);
    }

    /**
     *  @dev Definition of the event triggered when a document is successfully notarized in the registry
     */
    event Notarized(address indexed _signer, string _documentHash);
}
```

## Deploying

To deploy a smart contact to the Ethereum network, we must have access to the bytecode of the contract, as this is what is actually stored on the blockchain.

In our example, the bytecode is located in the `../contract/build/DocumentRegistry.bin` directory.  It can be loaded from file within the code by using the built in `include_str!' macro, which loads a utf8-encoded file as a string:

```rust
let bytecode = include_str!("../contract/build/DocumentRegistry.bin");
```

We must also load the abi.  The abi describes the function names, arguments and return types amongst other things, in json format.  Similar but not identical to the bytecode step, we use the `include_bytes!` macro to load the abi, as the rust-web3 library expects the abi in bytes format.

```rust
let json = include_bytes!("../contract/build/DocumentRegistry.abi");
```

Once we have these to values, we're ready to deploy our contract:

```rust
let registry_contract = Contract::deploy(web3.eth(), json)
    .unwrap()
    .confirmations(0)
    .poll_interval(time::Duration::from_secs(10))
    .options(Options::with(|opt| opt.gas = Some(3_000_000.into())))
    .execute(bytecode, (), accounts[0])
    .unwrap()
    .wait()
    .unwrap();
```

This is quite a hefty line of code, but we'll break it down step by step.

The [`Contract::deploy`](https://tomusdrw.github.io/rust-web3/web3/contract/struct.Contract.html#method.deploy) function takes the [`Eth`](https://tomusdrw.github.io/rust-web3/web3/api/struct.Eth.html) namespace as an argument along with the abi json we previously loaded.  It returns a [`Builder`](https://tomusdrw.github.io/rust-web3/web3/contract/deploy/struct.Builder.html) wrapped in a `Result` (hence the `unwrap()`).  

This builder struct is a configuration factory specifically for smart contract deployment, and contains a number of functions to configure deployment parameters:

- `confirmations(..)` specifies the number of confirmations required after smart contract code deployment, before the future completes.  This is useful if you are concerned about the Ethereum blockchain forking.  As this is just an example, we don't wait for any confirmations, and complete as soon as the contract creation transaction is mined.
- `poll_interval(..)` defines how regularly to poll the Ethereum client when checking if the contract creation transaction has been mined.  It takes a [`Duration`](https://doc.rust-lang.org/nightly/core/time/struct.Duration.html) struct as input.  Right now the average block time is around 13 seconds on the main Ethereum network, so a 10 second polling interval makes sense.
- `options(..)` takes an [`Option`](https://tomusdrw.github.io/rust-web3/web3/contract/struct.Options.html) struct as an argument and provides you with a way a modifying some of the values of the contract creation transaction.  The values that can be specified are `gas`, `gas_price`, `value` and `nonce`.  Here we're using the defaults for everything besides `gas`.
- `execute(..)` is the function that actually initiates the sending of the contract creation transaction.  It takes the loaded bytecode as an argument, along with any smart contract constructor parameters and the sender account.  Our smart contract does not contain a constructor with arguments, so the arguments passed in is empty, and we are deploying with `accounts[0]`.  The function returns a [`PendingContract`](https://tomusdrw.github.io/rust-web3/web3/contract/deploy/struct.PendingContract.html) value (wrapped in a `Result`).  This `PendingContract` implements the `Future` trait, and so we `wait()` until completion, which in this example will occur once the transaction has been mined.  Finally, the resultant value, a [`Contract`](https://tomusdrw.github.io/rust-web3/web3/contract/struct.Contract.html) object representing the newly deployed `DocumentRegistry` is unwrapped.

## Querying the Smart Contract

```rust
let document_hash = "QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco";

let result = registry_contract
    .query("isNotarized", String::from(document_hash), accounts[0], Options::default(), None);
let is_notarised : bool = result.wait().unwrap();
```

Once we have a deployed `Contract` reference, interating with the contract functions is fairly simple.  

The [`query`](https://tomusdrw.github.io/rust-web3/web3/contract/struct.Contract.html#method.call) function is provided to make a readonly function call (free with no transaction).  The first three arguments to this function are the most important; the name of the function that is to be called, the function arguments and the from account.  The `isNotarized` function takes a single String document hash as its argument, but notice that we must convert the `&str` type to `String` with the `String::from(..)` function.

The function returns a [`QueryResult`](https://tomusdrw.github.io/rust-web3/web3/contract/struct.QueryResult.html) which implements the `Future` trait, so as usual we `wait()` and `unwrap()` to obtain the returned value from the function, a `bool` in this case.

## Invoking a State Changing Function

```rust
let notarize_options = Options::with(|opt| opt.gas = Some(3_000_000.into()));
let tx_hash = registry_contract.call("notarizeDocument", String::from(document_hash), accounts[0], notarize_options).wait().unwrap();
```

The `Contract` abstraction also makes invoking a state changing function (which involves sending a transaction and hence costs gas) very simple.

The [`call`](https://tomusdrw.github.io/rust-web3/web3/contract/struct.Contract.html#method.call) function can be used to invoke a transaction in order to call a state changing function.  Note, that this is actually quite a confusingly named function, as usually smart contract _calls_ are considered to be non state changing query invocations, but this is not the case when using `rust-web3`.  Identically to the `query` function, the first 3 arguments are the smart contract function name, function arguments and the from address.  In this example we also specify the `gas` value via the `Options` struct.  This is because without this setting we would see an `out of gas` exception when mining the transaction on our `ganache-cli` node, as the default gas value provided by `rust-web3` does not cover the costs of the `notarizeDocument` function.

A [`CallFuture`](https://docs.rs/web3/0.8.0/web3/contract/struct.CallFuture.html) is returned, which again implements the `Future` trait.  Once the future completes, the transaction hash is returned.

## Putting it all Together

In thie complete example below, we call `isNotarised` for a document hash that has not yet been notarised, then `notariseDocument`, and then `isNotatised` again so that the state change can be demonstrated:

```rust
extern crate web3;

use std::time;
use web3::contract::{Contract, Options};
use web3::futures::Future;

fn main() {
    let (_eloop, transport) = web3::transports::Http::new("http://localhost:8545").unwrap();

    let web3 = web3::Web3::new(transport);
    let accounts = web3.eth().accounts().wait().unwrap();

    let bytecode = include_str!("../contract/build/DocumentRegistry.bin");
    let json = include_bytes!("../contract/build/DocumentRegistry.abi");

    let registry_contract = Contract::deploy(web3.eth(), json)
        .unwrap()
        .confirmations(0)
        .poll_interval(time::Duration::from_secs(10))
        .options(Options::with(|opt| opt.gas = Some(3_000_000.into())))
        .execute(bytecode, (), accounts[0])
        .unwrap()
        .wait()
        .unwrap();

    println!("Contract address: {:?}", registry_contract.address());

    let document_hash = "QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco";

    let result = registry_contract
        .query("isNotarized", String::from(document_hash), accounts[0], Options::default(), None);
    let is_notarised : bool = result.wait().unwrap();
    println!("is_notarised: {}", is_notarised);

    let notarize_options = Options::with(|opt| opt.gas = Some(3_000_000.into()));
    let tx_hash = registry_contract.call("notarizeDocument", String::from(document_hash), accounts[0], notarize_options).wait().unwrap();

    let result = registry_contract.query("isNotarized", String::from(document_hash), None, Options::default(), None);
    let is_notarised : bool = result.wait().unwrap();
    println!("is_notarised: {}", is_notarised);
    println!("tx_hash: {:?}", tx_hash);
}
```

## Summary

The ability to deploy smart contracts and execute functions on these contracts is the main use case of the Ethereum network.  In this tutorial we walked through the process of deploying, querying and updating the state of Ethereum smart contracts within the Rust programming language.

The full source code that has been covered in this guide is available on GitHub [here](https://github.com/craigwilliams84/rust-ethereum/).



