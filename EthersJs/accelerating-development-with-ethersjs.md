# Accelerating DApp Development with Ethersjs

Today's decentralized application stack often consists of a front end component, smart contracts, and a framework to interact with the blockchain. Web3 is used today in a majority of cases to facilitate the interaction with the Ethereum blockchain, however Web3 is a large, poorly documented, and difficult to maintain. Ethersjs is an alternative library that offers all of the features of web3 in a tiny, well-tested package.

Ethersjs is used today to create a seamless connection between a frontend and the Ethereum blockchain. In this example, we employ Angular 7.X and Ethersjs to create a simple wallet application and interact with a smart contract deployed on the Ethereum blockchain.

### Prerequisites

First you will need to install nodejs and Angular. Both installations can be found here:

- [Nodejs](https://nodejs.org/en/)
- [Angular](https://angular.io/guide/quickstart)

### Creating a Wallet Application

To get started, download the following initial [Angular application](https://github.com/jacobcreech/Ethersjs-example/tree/initial). To start, run

```
npm install
ng serve --open
```

You should be greeted the words "initial application" in your browser.

Ethersjs follows the general standard of installing packages for your application. Simply run

```
npm install --save ethers
```

Now everything is set up to work with Ethersjs on our simple application.


## Creating a Wallet

We are first going to use Ethersjs to create a new wallet. Change to the following html:

/src/app/wallet/wallet.component.html

```
<div fxFlex="20"></div>
<div fxFlex="60" class="wallet">
  <button mat-raised-button color="primary" (click)="onSubmit()">Generate Wallet</button>
  <p *ngIf="publickey">Public Key: {{publickey}}</p>
  <p *ngIf="privatekey">Private Key: {{privatekey}}</p>
</div>
<div></div>
```

To create a wallet, we use the wallet.createRandom() to create a random public and private key. We can use this wallet to do other actions with, such as creating transactions and signing messages.

/src/app/wallet/wallet.component.ts

```
onSubmit() {
  	const randomWallet = ethers.Wallet.createRandom();
  	this.publickey = randomWallet.address;
  	this.privatekey = randomWallet.privateKey;
  	const wallet = new ethers.Wallet(this.privatekey);
  }
```

Before we can do anything with this wallet, we must first connect it to the Ethereum blockchain. We will be doing this using the default web3 provider by Ethers.

Add the following to the wallet.component.ts:

```
provider: any;

ngOnInit() {
  this.provider = ethers.getDefaultProvider('homestead');;
}
```

This obtains the web3 connection provided by Metamask, and makes it ready to use by Ethers.

### Sending and Signing Transactions

Next we create the ability to send a transaction on our application. Ethers provides the ability to edit any data within a transaction, such as gas limit and what address you are sending the transaction to. In order to send a transaction using the wallet, create a send transaction button that uses the sendTransaction method from Ethersjs, as well as some form fields for input on the transaction.

/src/app/wallet/wallet.component.html

```
<form [formGroup]="transactionForm" (ngSubmit)="sendTransaction(transactionForm.value)">
		<mat-form-field appearance="outline">
	    <mat-label>To</mat-label>
	    <input formControlName="toAddress" matInput placeholder="0xAddress">
	  </mat-form-field>
	  <mat-form-field appearance="outline">
	    <mat-label>Amount</mat-label>
	    <input formControlName="etherAmount" matInput placeholder="1">
	    <span matSuffix>Ether</span>
	  </mat-form-field>
		<button mat-raised-button color="secondary">Send Transaction</button>
	</form>
```

In your class, import the formModules and create the base form information.

```
import { Component, OnInit } from '@angular/core';
import { ethers } from 'ethers';
import { FormBuilder, FormGroup, NgForm } from '@angular/forms'; 

@Component({
  selector: 'app-wallet',
  templateUrl: './wallet.component.html',
  styleUrls: ['./wallet.component.scss']
})
export class WalletComponent implements OnInit {

	publickey: string;
	privatekey: string;
	transactionForm: FormGroup;
	toAddress: string;
	etherAmount: string;
	wallet: any;
	provider: any;

  constructor(private fb: FormBuilder) { 
  	this.transactionForm = fb.group({
  		'toAddress': [null],
  		'etherAmount': [null]
  	});
  }

  ngOnInit() {
  	this.provider = ethers.getDefaultProvider('homestead');;
  }

  onSubmit() {
  	const randomWallet = ethers.Wallet.createRandom();
  	this.publickey = randomWallet.address;
  	this.privatekey = randomWallet.privateKey;
  	this.wallet = new ethers.Wallet(this.privatekey, this.provider)
  }

}
```

In order to send a transaction, Ethersjs provides a simple sendTransaction method for all wallets. Add a sendTransaction method to the wallet class, inputting the form.

```
sendTransaction(form: NgForm) {
	let transaction = {
	  to: form.toAddress,
	  value: ethers.utils.parseEther(form.etherAmount)
	}

	this.wallet.sendTransaction(transaction)
		.then((tx) => {
			console.log(tx);
		})
}
```

We first create the transaction object, giving where the transaction is going in the `to` field. `value` denotes how much ether, default in the units Wei, is being sent to the address mentioned. We use the parseEther util provided by ethers to easily convert from Ether to Wei. After creating the transaction object, we use our wallet we created before to send the transaction. In this implementation, console logs the transaction receipt.

Signing a message in a transaction is very useful for a number of reasons. A signed message can be used to verify that the owner is the address provided, and this allows smart contracts and other entities to verify truth in a trustless system. To sign a message using Ethers, you use the signMessage function on your message.

```
wallet.signMessage(message);
```

## Interacting with Smart Contracts

One of the many novelties of Ethereum is the creation and use of smart contracts on the blockchain. Dapp development relies on easy interaction with smart contracts, and Ethers has an easy to use solution.

Take for example this very simple [Sample Contract](https://ropsten.etherscan.io/address/0x8a32989b65186d3596251d7d7c8a427a26669354#code). In this contract, we store variables by adding it to the blockchain, and can read all currently stored variables. Interacting with this contract with Ethers, we first create the ABI for it, found [here](https://ropsten.etherscan.io/address/0x8a32989b65186d3596251d7d7c8a427a26669354#code).

```
let abi = [{"constant":false,"inputs":[{"name":"_value","type":"uint256"}],"name":"add","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getValues","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}];
```

We know the address of the contract is at `0x8a32989b65186d3596251d7d7c8a427a26669354`. Using both of these and our wallet, we can create a contract object using Ethers.

```
let contractAddress = '0x8a32989b65186d3596251d7d7c8a427a26669354';

let contract = new ethers.Contract(contractAddress, abi, wallet);
```

In the contract, we find both the add and getValues functions. To call these functions using Ethers, you call the functions listed in the ABI. 

```
await contract.add("Message");
contract.getValues()
		.then((result) => {
		console.log(result);
		});
```

We can add this to our UI by adding an add field and a getValues field.

```
<form [formGroup]="contractForm" (ngSubmit)="addToContract(contractForm.value)">
		<mat-form-field appearance="outline">
	    <mat-label>Value</mat-label>
	    <input formControlName="value" matInput placeholder="1">
	  </mat-form-field>
		<button mat-raised-button color="secondary">Add to Contract</button>
</form>
<button mat-raised-button color="primary" (click)="getValues()">Get Values</button>
<p *ngIf="message">Message: {{message}}</p>
```

We add the previous code to functions getValues() and addToContract(), as well as creating the forms in our ts.

```
contractForm: FormGroup;
message: string;
value: string;
abi: any;
contractAddress: any;

constructor(private fb: FormBuilder) { 
  	this.contractForm = fb.group({
  		'value': [null]
  	})
  	this.abi = [{"constant":false,"inputs":[{"name":"_value","type":"uint256"}],"name":"add","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getValues","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}];
  	this.contractAddress = "0x8a32989b65186d3596251d7d7c8a427a26669354";
  }

addToContract(form: NgForm) {
  		let contract = new ethers.Contract(this.contractAddress, this.abi, this.wallet);
  		contract.add(form.value);
  }

  getValues() {
  	let contract = new ethers.Contract(this.contractAddress, this.abi, this.wallet);
  	contract.getValues()
  			.then((result) => {
  				this.message = result;
  			});
  }
```

## Further Improvements

We have created a simple Dapp that can create a wallet, send a transaction, and interact with a smart contract. Using Ethersjs, we are able to interact with the Ethereum blockchain with ease, and expand to more complex use cases. Further improvements to this demo that we have created would be to create a better design, add more wallet integrations, and separation of concerns between the wallet and contract component. With this demo app, you can now include a wallet app by just including the wallet web component in your dapp. 

Ethersjs is a powerful tool, and a strong alternative to web3 for dApp development. The small compact library makes creating dApps a breeze, taking all the heavylifting off of the developer's shoulders and making it easier to focus on the smart contract or website design. For more information on Ethersjs, checkout out the [documentation](https://docs.ethers.io/ethers.js/html/index.html).