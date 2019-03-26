# ENS: Beginner's Guide

User experience is a key challenge when developing a dapp. Ethereum has complexities that should be hidden away to enable broad adoption. One such complexity, is an Ethereum address, it is long, unwieldy, and hard to remember.

The Ethereum Name Service (ENS) is an incredibly useful tool for dapp developers. ENS is like DNS, in that it maps a memorable shortcut to an address. Using ENS we can map the friendly name `ethereum.eth` to the rather unfriendly `0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359`. Subsequently, the friendly name can be used in-place of the address, making it easier to remember, and reducing the chance of errors. 

An ENS name has a root name `ethereum.eth` which can contain sub-names like `wallet.ethereum.eth`. The root name is owned by a party who successfully bid for it in a [Vickrey auction](https://medium.com/the-ethereum-name-service/a-beginners-guide-to-buying-an-ens-domain-3ccac2bdc770 "Vickrey auction").

In fact, ENS doesn't just map to addresses. ENS is highly extensible and supports many types of mappings. The same friendly name can be mapped to multiple endpoints at the same time. 

So `ethereum.eth` name could point to:
- A multisig wallet contract address
- Public encryption keys for secure communication
- Website content (via IPFS hash or multihash)

## Code Walkthrough

Many Ethereum libraries, including Web3.js now support ENS lookups out-of-the-box. Unfortunately using ENS is not as intuitive as the library documentation suggests; there are a number of things to look out for.

To demonstrate how to lookup ENS names we will write a simple Node.js command-line tool called `enslookup`. Given an ENS name as an argument it will query the ENS registry for information about that name.

### Prerequisites

First you will need to install Node.js and npm by following the install instructions on the [Node.js website](https://nodejs.org/ "Node.js").

Create a new project directory called `enslookup` and change directory into it.

```bash
mkdir enslookup
cd enslookup
```

### Web3.js

We will be using Web3.js to interact with the ENS registry. To install Web3.js use the Node.js package manager `npm`.

Create a file called `package.json`:

```json
{
    "dependencies": {
        "web3": "1.0.0-beta.50"
    }
}
```

Then install the package by executing:

```bash
npm install
```

### Environment Variable

TODO: infura url

### Enslookup

Create a new file called `enslookup` (notice there is no file extension).

Make the file executable:
```bash
chmod +x enslookup
```

Edit the file in your favorite editor - don't worry too much about the code here but it:
 - Allows the file to be executed by Node.js
 - Allows us to use Javascript async/await syntax
 - Gets the ENS name from the command's parameters

```js
#!/usr/bin/env node

(async () => {

    // get the ens name to lookup as the first argument to the command
    const [,,name] = process.argv;
    // bail if no name provided
    if(!name){
        console.error('No name provided for lookup\nUsage: enslookup <name>')
        return;
    }
    console.log(`Name:\t\t${name}`);

    // insert more cool stuff here

})();
```

Next, we will setup Web3.js to connect to Ethereum:

```js
// load web3 library
const Web3 = require('web3');

// connect to an Infura endpoint to connect to Ethereum
// feel free to use your own mainnet node
const web3 = new Web3(process.env.INFURA_URL);
```

Now, it is very tempting to jump right in and lookup an address using `web3.eth.ens.getAddress(EnsName)` but there is something important to consider first.

To resolve an address, the ENS name's owner must have configured a resolver smart contract. It is very likely that a resolver smart contract has not been configured for the ENS name. If you call `web3.eth.ens.getAddress(EnsName)` on an ENS name that has no resolver smart contract configured, Web3.js will give you a very unhelpful error message.

So first, we check the existence of the resolver smart contract for the ENS name:

```js
 // get the resolver contract 
const resolver = await web3.eth.ens.resolver(name);

// get the resolver contract address
const resolverAddress = resolver.address;
console.log(`Resolver:\t${resolverAddress}`);

// bail if resolver does not exist
if(resolverAddress === '0x0000000000000000000000000000000000000000'){
    return;
}
```

Surely we are ready to lookup an ENS address... right? Yes, kinda...

Looking up addresses has been part of ENS from day 1 but other types of mapping have been added later. Consequently, the resolver smart contracts that are configured for each ENS name, may differ in what they support because they were deployed at different times.

Luckily, the ENS team have implemented [standard interface detection](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-165.md "ERC-165 - Standard Interface Detection") so you can check which mappings each resolver smart contract supports.

Here is a list of the currently available interfaces (*there are more but some are deprecated*):

```js
const ensInterface = {
    address: '0x3b3b57de',
    contentHash: '0xbc1c58d1',
    pubKey: '0xc8690233'
}
```

Here is how you look up an address and its balance:

```js
if(await web3.eth.ens.supportsInterface(name, ensInterface.address)){
    const address = await web3.eth.ens.getAddress(name);
    const balanceWei = await web3.eth.getBalance(address);
    console.log(`Address:\t${address} (${web3.utils.fromWei(balanceWei, 'ether')} ether)`);
}
```

Here is how you look up a public encryption key:

```js
if(await web3.eth.ens.supportsInterface(name, ensInterface.pubKey)){
    const {x, y} = await web3.eth.ens.getPubkey(name);
    console.log(`Public Key:`);
    console.log(`\t\tx = ${x}`);
    console.log(`\t\ty = ${y}`);
}   
```

Here is how you look up a content hash (see [EIP-1577](https://eips.ethereum.org/EIPS/eip-1577) for format):

```js
if(await web3.eth.ens.supportsInterface(name, ensInterface.contentHash)){
    const contentHash = await web3.eth.ens.getContenthash(name);
    console.log(`Content hash:\t${contentHash}`);
}
```

Running the `enslookup` command on `ethereum.eth`:

```bash
./enslookup ethereum.eth
Name:		ethereum.eth
Resolver:	0x1da022710dF5002339274AaDEe8D58218e9D6AB5
Address:	0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359 (3295.179176904502385668 ether)
Public Key:
		x = 0x0000000000000000000000000000000000000000000000000000000000000000
		y = 0x0000000000000000000000000000000000000000000000000000000000000000
```
*Note on Windows you will have to run `node enslookup`*

The full code for the enslookup example can be found on [TODO]()

## Future of ENS

- ABIs - http://eips.ethereum.org/EIPS/eip-205
- Text - http://eips.ethereum.org/EIPS/eip-634
- We have only just scratched the surface...
- How will you use ENS in your dapp?





----
## Scraps

- Soon, top level DNS TLDs will be mappable to ENS (https://medium.com/the-ethereum-name-service/upcoming-changes-to-the-ens-root-a1b78fd52b38)
- It is being used to implement friendly usernames and identities (universal logins) (https://medium.com/@avsa/universal-logins-first-demo-1dc8b17a8de7)

- A domain name has a root, and many subdomains separated by '.'
- Each name can point to a single target or multiple targets depending on what you want to achieve. 
- smart contract ABI definitions
- content hashes (IPFS)
- encryption public keys
- key/value text items. 