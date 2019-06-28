Recently a group of Blockchain enthusiasts at the co-working space I occasionally work from decided that it was time we stopped talking about Blockchain and actually learned how to create something based on it.
We wanted to create a coin or token for the community to use internally, and whilst the project has stalled for now, I started investigating Ethereum in more depth, and the language it uses for creating smart contracts, [Vyper](https://vyper.readthedocs.io/en/latest/index.html) . I will cover the language itself in more detail in the future (when I understand it more myself!), but in this post, I will cover some of the tools available for working with the language.

## Your Language of Choice

Your starting point is [the official Ethereum clients](https://www.ethereum.org/cli) , available for all operating systems and in [Go](https://github.com/ethereum/go-ethereum) , [C++ (Aleth)](https://github.com/ethereum/aleth) , [Rust](https://github.com/paritytech/parity) , and [Python](https://github.com/ethereum/pyethereum) and [JavaScript](https://github.com/ethereum/web3.js/) . All support the full breadth of classes and methods for Vyper and many of the other tools listed here will need them as dependencies.

## Vyper Online Compiler

Vyper Online Compiler is an online editor for Vyper. Its web-based. It is currently in the experimental version. You can compile vyper codes, import vyper codes, save vyper codes to disk from it. It also has pre-written vyper codes that can serve as sample codes for you.

![](https://api.kauri.io:443/ipfs/QmRW9yKWNJGh9q63JJC1Cw35hRwiL5tzEr3RNj5sAznPF7)

## Atom

If you wish to use atom editor to write vyper codes, there is a vyper plugin that adds [syntax highlighting](https://atom.io/packages/language-vyper) on atom for you.

![](https://api.kauri.io:443/ipfs/QmQ1Kh9ai157HsnvHN87nxswshxhMSc12ent39bWkUyy8t)

## Visual Studio Code

A slightly smaller selection of extensions, but enough to get you started is the [vyper language extension](https://marketplace.visualstudio.com/items?itemName=tintinweb.vscode-vyper&ssr=true). The extension can compile code for you, integrates with [MythX](https://www.mythx.io/#faq) out of the box for you amongst other tasks.

## Deployment Frameworks

You know when the development community has started to accept a language when it starts creating frameworks for it. Unsurprisingly Ethereum has a couple of options.
[Truffle](http://truffleframework.com/) claims to be the most popular option, supporting compilation, testing, deployment, and dependency management.
[Embark](https://github.com/iurimatias/embark-framework) is similar, and also offers integration with [IPFS](http://ipfs.io/) for storage-based solutions and [whisper](https://github.com/ethereum/wiki/wiki/Whisper) for communications-based applications.
[Dapp](https://github.com/dapphub/) is a simpler CLI tool for package management, testing, and deployment of smart contracts.

## An Ecosystem of Constant Change

The blockchain space is in constant flux and thus a list of tools will not be comprehensive for the foreseeable future. If there’s anything missing from this list, please add it to the comments below.
