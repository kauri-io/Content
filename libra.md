# Title

Even though Facebook's name is hard to find on [the Libra website](https://libra.org), the long term plan is for it to integrate with their forthcoming [Calibra wallet](https://newsroom.fb.com/news/2019/06/coming-in-2020-calibra/), and then, the whole game plan might make more sense. For now, the intention of Libra appears to a global currency, maybe for those who have little access to banks, or maybe for the global citizens of Facebook.

With partnerships with major "old finance" enterprises on board such as Mastercard, PayPal, Stripe and Visa, it's hard to know if Libra will be the injection that cryptocurrencies have always needed, or the end of cryptocurrencies as we all know them.

We don't know for now, but in this post we take a quick look through the getting started guide for the project and what we can accomplish with it. This is early days for the project and we tested quickly, so some details are probably missing.

## Setup

We followed [the setup instructions in the documentation](https://developers.libra.org/docs/my-first-transaction#clone-and-build-libra-core) on macOS which worked with out any issues and downloaded any dependencies missing from our local system.

We noticed that Libra is using [rocksdb](https://rocksdb.org) for storage, which is unsurprising as it's a popular option, and also created by Facebook. There are also other dependencies, mostly used for cryptography and storage, you can see the full list in the various _Cargo.toml_ files in the repository. Which also shows that most of Libra is written in Rust. Interestingly we noticed that Libra uses the [Rust Bitcoin hashes](https://github.com/rust-bitcoin/bitcoin_hashes) project for hashing, plus a handful of Parity labs modules.

## Build and connect

After setup, [you can build the CLI client and connect to the testnet](https://developers.libra.org/docs/my-first-transaction#build-libra-cli-client-and-connect-to-the-testnet). This takes some time and uses a reasonable amount of your computer resources, but again completed with no issues. At the end of the build process, your local machine connects to a validator node and provides you with an interface to the node.

[Next we tried creating accounts](https://developers.libra.org/docs/my-first-transaction#create-alice-s-and-bob-s-account), which worked fine. There are three main functions: `account`, `query`, `transfer`; all of which are relatively self-explanatory. In this step of the tutorial we create two accounts, each of which have their own index and hex address. You can use the index value instead of the address in other CLI commands to reference the account you want to interact with.

## Add coins

[Next we add Libra coins using a time-honored faucet](https://developers.libra.org/docs/my-first-transaction#add-libra-coins-to-alice-s-and-bob-s-accounts). We noticed that the testnet faucet has a limit of 5 requests per minute, which is not realistic for a real world payment option, hopefully this is just testnet rate limiting.

At this point we also noticed that using the `query account_state 0` command returned a couple of interesting field values, including a `Blockchain version` value, a "sequence number" (kind of like a nonce). The account also had a state before we have yet pushed the account values to the blockchain. This is different from Ethereum or Bitcoin and means that either account generation must also have an event which pings testnet or that if it’s a valid account number, Libra returns its balance as "none", but validates it’s a compliant address.

## Submit transaction

[Next we tried sending a transaction between accounts](https://developers.libra.org/docs/my-first-transaction#submit-a-transaction). This step reintroduces the sequence value mentioned above, as you can query the sequence to understand the number of transactions on each account so far. Once you have submitted the transaction you can query for the status to find out when the validator node has accepted it. You can also use a "blocking transfer" to only return to the client when a validator node has validated a transaction.

## Summary

What’s most interesting about Libra is that we’re seeing how another set of engineers maybe not so steeped in the crypto-world would build a blockchain. That's not to say their choices are better or worse, but it’s interesting.
