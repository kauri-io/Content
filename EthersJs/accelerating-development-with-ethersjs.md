# Accelerating DApp Development with Ethers.js

Today's decentralized application stack often consists of a front end component, smart contracts, and a framework to interact with the blockchain. Web3 is used today in a majority of cases to facilitate the interaction with the Ethereum blockchain, however, Web3.js is large, poorly documented, and difficult to maintain. Ethers.js is an alternative library that offers all of the features of Web3.js in a smaller, well-tested package.

Ethers.js is used today to create a connection between a frontend and the Ethereum blockchain. In this example, we employ Angular 7.X and Ethers.js to create a simple wallet application and interact with a smart contract deployed on the Ethereum blockchain.

### Prerequisites

First, you will need to install node.js and Angular. You can find both installations here:

- [Nodejs](https://nodejs.org/en/)
- [Angular](https://angular.io/guide/quickstart)

### Creating a Wallet Application

To get started, download the following initial [Angular application](https://github.com/jacobcreech/Ethersjs-example/tree/initial). Make sure you are on the `initial` branch. To start, run

```
npm install
ng serve --open
```

You should be greeted with the words "initial application" in your browser.

Ethers.js follows the general standard of installing node packages for your application, run the below to install it

```
npm install --save ethers
```

Now everything is set up to work with Ethers.js on our application.


## Creating a Wallet

We first use Ethers.js to create a new wallet. Change `/src/app/wallet/wallet.component.html` to the following html:


```
<div fxFlex="20"></div>
<div fxFlex="60" class="wallet">
  <button mat-raised-button color="primary" (click)="onSubmit()">Generate Wallet</button>
  <p *ngIf="publickey">Public Key: {{publickey}}</p>
  <p *ngIf="privatekey">Private Key: {{privatekey}}</p>
</div>
<div></div>
```

To create a wallet, we use the `wallet.createRandom()` to create a random public and private key. We can use this wallet for other actions, such as creating transactions.

In `/src/app/wallet/wallet.component.ts`, change the `onSubmit() {}` function to the below:

```
onSubmit() {
      const randomWallet = ethers.Wallet.createRandom();
      this.publickey = randomWallet.address;
      this.privatekey = randomWallet.privateKey;
      const wallet = new ethers.Wallet(this.privatekey);
  }
```

Before we can do anything with this wallet, we must first connect it to the Ethereum blockchain. We do this using the default web3 provider by Ethers.js.

Update the `ngOnInit() {}` function in `wallet.component.ts` to the below:

```
provider: any;

ngOnInit() {
  this.provider = ethers.getDefaultProvider('homestead');;
}
```

This obtains the web3 connection provided by Metamask and makes it ready to use by Ethers.

### Sending and Signing Transactions

Next, we create the ability to send a transaction with our application. Ethers.js provides the ability to edit any data within a transaction, such as gas limit and what address you are sending the transaction to. In order to send a transaction using the wallet, create a send transaction button that uses the sendTransaction method from Ethers.js, as well as some form fields for input on the transaction.

Inside `/src/app/wallet/wallet.component.html` add the code below inside the two `<div>`s

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

In the `wallet.component.ts` class, import the `formModules` and create the base form information.


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

In order to send a transaction, Ethers.js provides a `sendTransaction` method for all wallets. Add a `sendTransaction` method to the wallet class, inputting the form.

```
sendTransaction(form: any) {
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

We first create the transaction object, giving where the transaction is going in the `to` field. `value` denotes how much ether, default in the units Wei, is being sent to the address mentioned. We use the `parseEther` util provided by Ethers.js to easily convert from Ether to Wei. After creating the transaction object, we use our wallet we created before to send the transaction. In this implementation, the console logs the transaction receipt.

## Interacting with Smart Contracts

One of the many novelties of Ethereum is the creation and use of smart contracts on the blockchain. Dapp development relies on interaction with smart contracts, and Ethers.js has a solution. With Ethers.js, you can interact with a smart contract to exchange tokens with two parties, or play one of the many Dapp games. 

Take for example this [Sample Contract](https://ropsten.etherscan.io/address/0x8a32989b65186d3596251d7d7c8a427a26669354#code). In this contract, we store variables by adding it to the blockchain and can read all currently stored variables. Storing values on the Ethereum blockchain is useful for Dapp development, as the storage allows developers to reference variables to do interactions such as storing signatures, or keeping track of cryptokittens up for trade. Interacting with this contract with Ethers.js, we create the ABI for it, found [here](https://ropsten.etherscan.io/address/0x8a32989b65186d3596251d7d7c8a427a26669354#code). ABI stands for Application Binary Interface. This interface defines functions found at a smart contract address, and can be used to call various functions at that smart contract.

```
let abi = [{"constant":false,"inputs":[{"name":"_value","type":"uint256"}],"name":"add","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getValues","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}];
```

We know the address of the contract is at `0x8a32989b65186d3596251d7d7c8a427a26669354`. Using both of these and our wallet, we can create a contract object using Ethers.

```
let contractAddress = '0x8a32989b65186d3596251d7d7c8a427a26669354';

let contract = new ethers.Contract(contractAddress, abi, wallet);
```

In the contract, we find both the add and `getValues` functions. To call these functions using Ethers, you call the functions listed in the ABI. 

```
await contract.add("Message");
contract.getValues()
        .then((result) => {
        console.log(result);
        });
```

We can add this to our UI by adding an additional field and a `getValues` field.

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

Add the code above to the `getValues()` and `addToContract()` functions, as well as adding the forms to `wallet.component.html`.

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

addToContract(form: any) {
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

In this tutorial we created a dapp that creates a wallet, sends a transaction, and interacts with a smart contract. Using Ethersjs, we are able to interact with the Ethereum blockchain with ease and expand to more complex use cases. Further improvements to this demo that we have created would be to create a better design, add more wallet integrations, and separation of concerns between the wallet and contract component. With this demo app, you can now include a wallet app by just including the wallet web component in your dapp. 

Ethers.js is a powerful tool and a strong alternative to web3 for dApp development. The small compact library makes creating dApps a breeze, taking all the heavy lifting off of the developer's shoulders and making it easier to focus on the smart contract or website design. For more information on Ethers.js, checkout out the [documentation](https://docs.ethers.io/ethers.js/html/index.html).