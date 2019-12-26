# How to create a Metamask Plugin

## What is It?

Metamask plugin is a script which allows developers to customize the extension and introduce extra features with the help of powerful APIs provided by metamask. By default, the plugin system has zero privilege. Though, there are several methods in the snaps which enables a permission system that can be offered to the users according to the requirement of DApps. 


## Why Snaps?

Everyday new protocols are being introduced in the ecosystem, and their DApp requires interacting with User accounts, and running a persistent script on the user’s behalf, either to monitor state, pre-process transactions, or even just to serve up a new peer to peer file transport to different sites with a shared cache.
DApp to DApp, these requirements vary but the current implementation of the Metamask, users are asked to install the extension and say yes to security-sensitive permissions. Also, if DApp uses Metamask as their web3 provider. They can not introduce any additional features to the wallet. 

After realizing that adding functionality is an incredibly powerful pattern, arguably the `hallmark of open computing`. To serve different use cases where innovation can be made possible with development, Metamask introduced Snaps: The Metamask Plugin System.


## How it works ?

The plugin script will be able to add different functionalities by making API calls. Metamask has introduced `wallet` API, which is an extension of `web3.currentProvider` API. This will allow developers to build better permission system, and user experience. For example, a file-sharing plugin doesn’t need to know what page you’re on, just what hash you want to load or set. This plugin can operate with little knowledge of what is going on. 

## Different Plugin Ideas

Every plugin has the ability to provide its own API to the sites that a user visits, as well as to other plugins, allowing plugins to build on each other, in a sort of decentralized dependency graph. For example, a state channel plugin might rely on a whisper plugin. 

### Smart Contract Security || auditAddress plugin API
Smart Contract Security is a huge issue, both because you can’t be secure enough, and no matter how many layers of checks you add, you always have to ask who watches the watchmen?
- plugins could add warnings or endorsements of accounts wherever MetaMask displays them.

### ENS || resolveName plugin API
Decentralized name systems are an exciting opportunity for loading content outside of the traditional certificate authority system, and we don’t want to dictate what name systems a user can subscribe to!
- This API can allow the addition of new name resolving strategies.

### Privacy protocols || getAppKey() | confirm plugin API

Privacy-centric protocols require unique forms of cryptography, so rather than try to implement every kind of signing algorithm in existence and audit and merge them. 

- The first team that requires a new curve can use our wallet.getAppKey() API to get a unique private key for their domain, generated from the user’s own seed phrase uniquely for the plugin’s origin, which is now treated as the authority for that key type, which can also use our confirm API to get user consent for that type of signature.

### Layer 2 Scaling || getAppKey() | wallet_manageAssets()

This is a WIP. Metamask has introduced a suite of plugins APIs will unlock dapp development to innovate decentralized agreements far off the main chain. For instance, switching from main chain to side chain requires user to perform manual switching. Snap's permission system can help to automate this process.  

