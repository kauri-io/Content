# Sending Ethereum Transactions with Rust

This tutorial will walk you through the code required to send an Ethereum transaction within a Rust application.

## Prequisites

This tutorial assumes that you already have a Rust IDE available.  It also assumes some basic knowledge of Ethereum and does not cover concepts such as the contents of an Ethereum transaction.  

## Libraries Used

We will be heavily using the MIT licensed rust-web3 library of which sourcecode can be found [here](https://github.com/tomusdrw/rust-web3).

To use this library in your application, it must be added to your `Cargo.toml` file:

```toml
[dependencies]
web3 = { git = "https://github.com/tomusdrw/rust-web3" }

```

The library can then be added to your crate:

```rust
extern crate web3;
```

## Starting an Ethereum Node

We need access to a node that we can connect to in order to send transactions.  In this tutorial we will use `ganache-cli`, which will allow you to quickly start a personal Ethereum network, with a number of unlocked and funded accounts.

Taken from the `ganache-cli` [installation documentation](https://github.com/trufflesuite/ganache-cli#installation), to install with npm, use the command:

```
npm install -g ganache-cli
```

or if you prefer to use Yarn:

```
yarn global add ganache-cli
```

Once installed, simply run the command, to quickly start a private Ethereum test network:

```
ganache-cli
```

## Sending a Transaction from a Node-Managed Account

The easiest way to send a transaction is to rely on the connected Ethereum node to perform the transaction signing.  This is generally a less secure approach however, as it relies on the account being "unlocked" on the node.

### Required `Use` Declarations

```rust
use web3::futures::Future;
use web3::types::{TransactionRequest, U256};
```

### Connecting to the Node

```rust
let (_eloop, transport) = web3::transports::Http::new("http://localhost:8545").unwrap();

let web3 = web3::Web3::new(transport);
```

First we must create a transport object that will be used to connect to the node. In this example we are going to connect via `http`, to `localhost` on port `8545`, which is the default port for Ganache, and most if not all Ethereum clients.

**Note:** An EventLoop is also created, but that is out of the scope of this guide.

Next we construct a web3 object, passing in the previously created transport variable, and thats it!  We have now have a connection to the Ethereum node!

### Obtaining Account Details

Ganache-cli automatically unlocks a number of accounts and funds them with 100ETH, which is useful for testing.  The accounts differ on every restart though, so we need a way to programmatically obtain the account information:

```rust
let accounts = web3.eth().accounts().wait().unwrap();

```

The [Eth namespace](https://tomusdrw.github.io/rust-web3/web3/api/struct.Eth.html), obtained via `web3.eth()` contains many useful functions for interacting with the Ethereum node.  Obtaining a list of managed accounts via `accounts()` is one of them.  An asynchronous future is returned, so we wait for the task to complete (`wait()`), and obtain the result (`unwrap()`).

### Sending the Transaction

The parameters of the transaction to be sent is defined via a `TransactionRequest` structure:

```rust
let tx = TransactionRequest {
        from: accounts[0],
        to: Some(accounts[1]),
        gas: None,
        gas_price: None,
        value: Some(U256::from(10000)),
        data: None,
        nonce: None,
        condition: None
    };
```

Most of the fields within this struct are optional, with sensible default values being used if not manually specified.  As we are sending a simple ETH transfer transaction, the data field will be empty, and in this example we use the default `gas` and `gas_price` values.  We also do not specify a `nonce`, as the `rust-web3` library will query the Ethereum client for this latest nonce value by default.  The `condition` is a `rust-web3` specific field and allows you to delay sendind the transaction until a certain condition is met, such as a specific block number being reached for example.

Once the `TransactionRequest` has been initiated, its a one-liner to send the transaction:

```rust
let tx_hash = web3.eth().send_transaction(tx).wait().unwrap();
```

The `TransactionRequest` is passed to the `send_transaction(..)` function within the `Eth` namespace, which returns a promise that completes once the transaction has been broadcast to the network.  On completion, the promise returns the transaction hash `Result`, which can then be unwrapped.

### Putting it all Together...

```rust
extern crate web3;

use web3::futures::Future;
use web3::types::{TransactionRequest, U256};

fn main() {
    let (_eloop, transport) = web3::transports::Http::new("http://localhost:8545").unwrap();

    let web3 = web3::Web3::new(transport);
    let accounts = web3.eth().accounts().wait().unwrap();

    let balance_before = web3.eth().balance(accounts[1], None).wait().unwrap();

    let tx = TransactionRequest {
        from: accounts[0],
        to: Some(accounts[1]),
        gas: None,
        gas_price: None,
        value: Some(U256::from(10000)),
        data: None,
        nonce: None,
        condition: None
    };

    let tx_hash = web3.eth().send_transaction(tx).wait().unwrap();

    let balance_after = web3.eth().balance(accounts[1], None).wait().unwrap();

    println!("TX Hash: {:?}", tx_hash);
    println!("Balance before: {}", balance_before);
    println!("Balance after: {}", balance_after);
}

```

Run this code, and you should see that the `accounts[1]` balance is 10000 wei greater after the transaction was sent...a successful ether transfer!

## Sending a Raw Transaction