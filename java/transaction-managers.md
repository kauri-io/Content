# Web3j Transaction Managers

A Transaction Manager in Web3j is an abstraction that controls how transactions are signed and broadcast to the Ethereum network, via a connected client.  An implementation can be passed to a [smart contract wrapper](http://LINK_TO_WRAPPER_ARTICLE) when deploying or loading a contract, or it can be used directly to send transactions in a more manual manner.

There are multiple different Transaction Manager implementations out of the box, all extending the `TransactionManager` abstract class.  Each extending class must implement the abstract `sendTransaction(..)` method:

```java
public abstract EthSendTransaction sendTransaction(
            BigInteger gasPrice, BigInteger gasLimit, String to,
            String data, BigInteger value)
            throws IOException;
```

In this article we will describe and compare the Transaction Managers that are provided by Web3j.

## ClientTransactionManager

### Signing
The client transaction manager does not perform any transaction signing, and instead, delegates to the connected Ethereum client to sign, using one of its managed accounts.  Because of this, the sender account must be unlocked in the client, which means that the client has access to the private key of the account.

### Sending
The non-signed transaction data is passed to the Ethereum client via the `eth_sendTransaction` JSON RPC endpoint of the connected client.  For more information on this endpoint, see the [geth JSON RPC documentation](https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_sendtransaction).

### Nonce Management
Like signing, calculating the transaction nonce is delegated to the connected node.

### Use Cases
For most production use cases it is not recommended to use the `ClientTransactionManager.  This is because the sender account needs to be unlocked, which adds a very significant attack vector into your architecture.  If the client is not configured correctly,  or the server security is generally lacking, then an attacker could potentially steal the funds from the unlocked account.

Therefore, to minimize risks, it is advised to only use the 'ClientTransactionManager' for testing purposes, or for unlocked accounts with a very small Ether balance.

[Source Code](https://github.com/web3j/web3j/blob/master/core/src/main/java/org/web3j/tx/ClientTransactionManager.java)

## RawTransactionManager

### Signing
The `RawTransactionManager` takes a `Credentials` file as a constructor argument, and the private key of these credentials is used to sign the transaction on the java side, before forwarding to the connected Ethereum client.  This means that account management is not handled on the client side at all, and therefore the account does not need to be unlocked.

### Sending
The encoded and signed raw transaction is broadcast to the Ethereum network via the `eth_sendRawTransaction` [JSON RPC endpoint.](https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_sendrawtransaction)

### Nonce Management
Before generating and signing the raw transaction, the nonce for the sender account is retrieved by calling [eth_getTransactionCount](https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_gettransactioncount) on the Ethereum client.  As you can probably figure out, this will retrieve the total number of transactions that have been sent from the account, including pending transactions that have not yet been included in a block.  As the nonce is zero indexed, this count **should**  equal the nonce for the next transaction to be sent.

### Use Cases
As the `RawTransactionManager` is signing server side before forwarding to the client, it is not a requirement for an Ethereum client account to be unlocked.  This means that third party nodes can be used, such as [Infura](https://infura.io/), rather than hosting your own.  However, because of the way the nonce is calculated, this transaction manager is not suitable for applications with very high transaction throughput from a single account.  More on this below.

[Source Code](https://github.com/web3j/web3j/blob/master/core/src/main/java/org/web3j/tx/RawTransactionManager.java)

## FastRawTransactionManager

### Signing
As you've probably gathered from the name, the `FastRawTransactionManager` extends `RawTransactionManager` and builds and signs transaction exactly the same way, with the nonce value being the only exception.

### Sending
`eth_sendRawTransaction` is called, just like in the `RawTransactionManager`.

### Nonce Management

Nonce management is where the `FastRawTransactionManager` differs from the vanilla `RawTransactionManager`.  Rather than calling `eth_getTransactionCount` every time a transaction is sent, an in memory transaction count is maintained and incremented every time a transaction is sent via the manager.  The count management is synchronised and is therefore thread-safe.

### Use Cases
As the name implies, this `TransactionManager` is particularly useful in applications that intend to send transactions very quickly from a single account, potentially on multiple threads.  With a standard `RawTransactionManager`, in high throughput situations there is a chance of a race condition where multiple transactions are sent with the same nonce value, causing all but one of the transactions to fail.  This is not the case with the `FastRawTransactionManager` because of the thread-safe in memory transaction count.

[Source Code](https://github.com/web3j/web3j/blob/master/core/src/main/java/org/web3j/tx/FastRawTransactionManager.java)

## ReadonlyTransactionManager

This is a stub `TransactionManager`, which actually throws an `UnsupportedOperationException` if `sentTransaction` is called.

### Use Cases
This can be used in situations where you would like to use an abstraction that takes a `TransactionManager` as an argument, such as calling the `load(..)` method of a contract wrapper, but only call (read-only) operations are ever intended to be made from the smart contract.  You do therefore not have to worry about credentials / private keys.

[Source Code](https://github.com/web3j/web3j/blob/master/core/src/main/java/org/web3j/tx/ReadonlyTransactionManager.java)

## Summary
There are a number of `TransactionManager` implementations that are bundled with Web3j, each with different characteristics.  The right choice for you depends on the manner of transactions (or lack of) that you envision will be sent  from the application that you are building.  And if there isn't an implementation that fits your use case, you can always extend the existing ones with your desired functionality!



