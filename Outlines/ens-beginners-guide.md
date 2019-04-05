# ENS: Beginner's Guide

- ENS is an incredibly useful tool for dapp developers. 
- The Ethereum Naming Service (ENS) is a decentralised naming service built on Ethereum.
- It can be thought of like DNS.
- It enables friendly names to be resolved to multiple targets.
- A domain name has a root, and many subdomains separated by '.'
- Each name can point to a single target or multiple targets depending on what you want to achieve. 
- It is highly extensible and supports many target types such as Ethereum addresses/contracts, ABI definitions, content hashes (IPFS), public keys, and key/value text items
- It lives on the Ethereum blockchain so is naturally decentralised.
- It can be queried from smart contracts
- By being able to resolve friendly names it enhances your application's usability.
- Particularly good for reliably resolving contract addresses and their associated ABIs

## Code Walkthrough

- Many Ethereum libraries, such as Web3 or Ethers.js now support ENS out-of-the-box.
- TODO code example

## Future of ENS

- Soon, top level DNS TLDs will be mappable to ENS (https://medium.com/the-ethereum-name-service/upcoming-changes-to-the-ens-root-a1b78fd52b38)
- So ethereum.org could resolve to an multisig contract address and an IPFS content hash of the website and their public key for encrypted communication
- It is being used to implement friendly usernames and identities (universal logins) (https://medium.com/@avsa/universal-logins-first-demo-1dc8b17a8de7)
- How will you use ENS in your dapp?

