# Deploying a full-stack dApp to Amazon EC2

In the previous [tutorial in this series](https://kauri.io/collection/5b8e401ee727370001c942e3), we saw how to develop a full-stack ethereum blockchain dApp. 

In this tutorial therefore, we will see how to deploy the dApp to an Amazon web services (AWS) elastic cloud computing (EC2) instance. We will also create a private ethereum blockchain node using [kaleido](https://kaleido.io/) and finally configure the dApp to work with this blockchain node.

## Prerequisites

In order to successfully complete this tutorial, you'll need a good understanding of the following concepts,

- Connecting to a remote server via SSH.
- Basic linux Command Line Interface (CLI) knowledge.
- Finally a good understanding on how the blockchain works would also be recommended but not necessary for completing this tutorial.

## Launch and Connect to an EC2 Instance

To launch an EC2 instance, please follow the instructions provided in this [tutorial](https://hackernoon.com/launching-an-ec2-instance-fbfd50894aac)

- Make sure the instance state in the console is indicated as running and there is a green tick under status checks once you are done creating and launching the instance.
- Make sure you are able to SSH into the EC2 instance as detailed in the article above.
- And finally make sure you install the apache server `httpd` , `node.js` and `git` by running the following commands.
```sh
sudo yum update -y
sudo yum install -y httpd git nodejs
sudo service httpd start
sudo chkconfig httpd on
```

## Create a Private Ethereum Blockchain Node using [Kaleido](https://kaleido.io/)

To create a private ethereum blockchain node in kaleido, please do the following:-

1. Create a new Kaleido account and then sign in/log in and complete the sign up process.
2. After logging in, create a Consortium, by clicking the `Create Consortium` button and then do the following:-
- Enter the name and mission of the consortium as required.
- Then set your home region e.g. Ohio if you had selected USA as your country.
- Click on `NEXT` and then click on `FINISH` in the next tab
3. Afterwards, setup a New Environment by clicking on the `SETUP ENVIRONMENT` button and doing the following:-
- Enter the name of the enviroment or leave it blank as you choose and click on `NEXT`
- In the `Protocol` tab, select `Geth` under PROVIDER. This is very important because we need to create an ethereum blockchain node, the other 2 options will create blockchain nodes for other providers not covered by this tutorial.
- Also by default, `PoA` should be selected under CONSENSUS ALGORITHM
- Finally click on `FINISH` to complete setting up the environment
4. Finally add the ethereum node by clicking on the `ADD NODE` and doing the following:-
- Select the correct `OWNING MEMBER` for the node and the enter the name of the node and click on `NEXT`
- Click `NEXT` in the `CLOUD CONFIGURATION` tab and leave the settings in default mode.  Please note under the free plan, you won't be able to change any of the settings available unless you upgrade your account.
- Finally in the `SIZE` tab, select the `Node Size` you want. Please note under the free plan, only the small node size will be available. Also click on `FINISH` to complete setting up the node.

After completing the above steps, give the newly created node about 3 minutes to finish initializing and starting up. Also please note the `RPC ENDPOINT` url of the node, we'll need it later in this tutorial. You can copy it by clicking on the name of the newly create node, which will take you to the node details. And then finally click on the `Copy` link that is next to the URL.

In order to be able to connect to the newly created node above, we also need to add new app credentials in Kaleido, by doing the following:-

1. Click on the `+ADD ` dropdown button and then choose the `New App Credentials` option.
2. Make sure the correct membership is selected under the `MEMBERSHIP` option and then enter a new name for the credential.
3. Please note the `USERNAME` and `PASSWORD` shown. 
- Also please copy the password shown and save it in a secure place. This is the only time the password will be shown, so if you lose it, you'll have to create new app credentials to be able to connect to the node.
4. Click on `DONE` to save the app credentials.

## Create a Kaleido IPFS Node.

Because the dApp we are going to deploy also needs to connect to an IPFS node, we'll need to create a new node by doing the following:-

1. Navigate to an existing environment, and click the +ADD dropdown in the top right portion of the screen.
2. Select the `Add Services` option. This will open a new panel exposing the currently available Kaleido Services.
3. Click the `ADD` button beneath IPFS File Store.
4. Supply an arbitrary name for the node and click ADD. Click DONE to finish the deployment.
5. The newly created IPFS node will appear at the bottom of your environment panel under `MEMBER SERVICES`.

Finally we need to save the IPFS gateway URL created in a safe place because we'll need it later in the tutorial by doing the following:-
- In the kaleido dashboard `environment`, click on the newly ipfs node created under `MEMBER SERVICES` 
- A new page `Application Credentials` will appear, and so select the `App Credentials` created above under `CREDENTIAL NAME` and under `SECRET KEY`  enter the passoword saved from above and click on `SUBMIT`.
- Copy the URL under `MY COMPANY ORGANIZATION - IPFS GATEWAY ENDPOINT` and append the `APPLICATION CREDENTIALS` displayed to this URL i.e. if the url is `https://u0b2fvaghe-u0kzkqcb5x-ipfs.us0-aws.kaleido.io/ipfs` and the credentials are `u0hnyi99nm:8abPcEHO1ioxo7pckJKcxw3VzKl8D19TsFp5o7pE-cj4` the new url will be `u0hnyi99nm:8abPcEHO1ioxo7pckJKcxw3VzKl8D19TsFp5o7pE-cj4@u0b2fvaghe-u0kzkqcb5x-ipfs.us0-aws.kaleido.io`
	- Please save this url in a secure place

## Deploy the dApp to AWS

The dApp we'll be using for deployment, is the [react project](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/truffle-react-box-frontend) from a previous tutorial. So go ahead and fork the repo inorder to be able to make the changes described below.

To deploy the dApp to the AWS EC2 instance, you'll need to do the following:-

### Generate a new Ethereum Wallet and Mnemonic

This step is optional if you already have an existing ethereum wallet and are comfortable using it's mnemonic in the above dApp.

To generate a new wallet therefore, go to https://iancoleman.io/bip39 and in the BIP39 Mnemonic code form, do the following:-
1. Select “ETH — Ethereum” from the “Coin” drop down
2. Select a minimum of “12” words
3. Click the “Generate” button to generate the mnemonic
4. Copy and save the mnemonic located in the field “BIP39 Mnemonic”, remember to keep this private as it is the seed that can generate and derive the private keys to your ETH accounts

You will also get the address of the wallet in the table under "Derived Addresses" in the first row under the column Address. i.e. `0x06c6b9bfF7281e97DE8455df05f0EC62528f4DEC`


### Setup Truffle

In the repo forked above, create a `secrets.json` file in the root path of the `truffle-react-box-frontend` folder.

Then get the kaleido connection Url by doing the following:-

- Click on the newly created ethereum node above.
- Click on the `+ Connect Node` button
- Under `Select a Connection Type` click on the `VIEW DETAILS` button under NATIVE JSON/RPC
- Select the `App Credential` you created aboved and enter the password for it in the `SECRET KEY` field and click on the `SUBMIT` button
- Finally in the new page, select `HTTPS` under the `JSON/RPC` panel, scroll to the `Auth Type - INURL` section and copy the `CONNECTION URL` displayed there.

Then save the kaleido config as follows by setting the `mnemonic` phrase you got when creating the wallet and also the `CONNECTION URL` copied from the above step. i.e. the `secrets.json` file should look as shown below.
```json
{
	"mnemonic": "YOUR SECRET MNEMONIC",
	"kaleidoUrl": "username:password@kaleidonodeurl"
}
```
In the file `truffle.js` replace the current infura configuration with the kaleido configuration. 

By replacing the lines
```json 
    rinkeby: {
      provider: new HDWalletProvider(secrets.mnemonic, "https://rinkeby.infura.io/v3/"+secrets.infuraApiKey),
      network_id: '4'
    }
```

with the lines 
```json
	production: {
      provider:  new HDWalletProvider(secrets.mnemonic, secrets.kaleidoUrl),
      network_id: '*',
      gas: 4700000
    }
```

### Setup Metamask

You'll also need to install and setup [metamask](https://metamask.io/) which is a web3 provider for normal browsers, to help them connect to the ethereum blockchain.

Once metamask is up and running in your browser or if you had already installed it, please do the following:-

- Click on the metamask extension/add-on in your browser to open it.
- Then click on the `Import using account seed phrase` link displayed on the extension before you login.
- In the new page enter `mnemonic` phrase copied from above and then also enter a new password for the account. 
	- Be very careful with this step as it will overwrite any existing accounts you had in metamask. So please make sure you BACKUP the seed phrases of any existing accounts before importing the above phrase, otherwise you WILL LOSE access to your accounts FOREVER if they are not backed up anywhere else.
- Then login into metamask using the password you created in the above step and copy the address of the wallet by clicking on the account name.
	- This address should match the address derived when creating the new `mnemonic` phrase above.

You'll also need to configure metamask to connect to the above kaleido node, by doing the following:-
- Login to MetaMask
- In the networks dropdown i.e. Main Ethereum Network, Rinkeby Test Network e.t.c, select the option `Custom RPC`
- Enter `Kaleido` under network name in the new page and then also enter the kaleido connection url from above i.e. `username:password@kaleidonodeurl` as the network `New RPC URL` and then click on `Save`. The rest of the fields can be left blank for now.

### Fund the Ethereum Wallet

To fund the ethereum wallet created above do the following:-

- Go the kaleido dashboard, select your consortium and then your environment.
- Under the `SERVICES` table, click on the `Ether Pool` option i.e the 3 dots at the end of the row and then select `Fund Account`
- In the new page, paste the wallet address copied from metamask above and enter the amount of ETH you want to fund the account with and click on `FUND`

This will now add the funds to the address associated with the wallet and metamask will reflect this if you select the `kaleido` network created above. Please note that these funds are NOT REAL and hence can't be used for transactions in the main ethereum network.

They can however be used to facilitate blockchain transactions in the private kaleido network.

### Setup the dApp in AWS

After connecting to the kaleido node create above via metamask and also after funding the account, its time now to finally deploy the dApp to AWS.

And to do this, we'll do the following:-

1. SSH login to our newly created AWS EC2 instance.
2. Clone via git the [react project](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/truffle-react-box-frontend) repo we forked above to our instance i.e. `git clone https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series.git`
3. We'll then to change directory `cd` to the `truffle-react-box-frontend` folder to deploy the contracts via truffle by doing the following:-
- Installing the truffle package globally via the command `npm i truffle -g`
- Then we'll compile the smart contracts via the command `truffle compile`
- And then deploy the contracts to the Kaleido private Ethereum Blockchain node we created above via the command `truffle migrate`
- If you take a look at the Block Explorer in Kaleido and you should see that new transactions have just been executed for the `Bounties` smart contract.
- We may also test the contract in the Truffle Console via the command `truffle console --network production` which will open a console where we can interact with the deployed contract.
- Also note, if we make any changes to the smart contract, we'll need to re-deploy them to the kaleido node via the commands `truffle compile && truffle migrate`
4. After the contract deployment is done, change Directory `cd` to the react-project i.e. `cd truffle-react-box-frontend/client/` and install the required node dependencies via the command `npm install`
5. Edit the file `truffle-react-box-frontend/client/src/App.js` to reflect the above kaleido changes and replace the following lines
```js
const etherscanBaseUrl = "https://rinkeby.etherscan.io";
const ipfsBaseUrl = "https://ipfs.infura.io/ipfs";
```
with
```js
const etherscanBaseUrl = "https://console.kaleido.io/environments/{consortiumId}/{environmentId}/explorer";
const ipfsBaseUrl = "username:password@kaleidoIPFSUrl/ipfs";
```
You can get the `consortiumId` and `environmentId` variables by manually opening the kaleido block explorer in your browser and then copy and pasting the url generated.

Also the `kaleidoIPFSUrl` is the IPFS Url we generated when setting up an IPFS node above.

Also change the file `/truffle-react-box-frontend/client/src/utils/IPFS.js` and replace the line
```js
const ipfs = new IPFS({ host: 'ipfs.infura.io', port: 5001, protocol: 'https' });
```

With the line 
```js
const ipfs = new IPFS({ provider: 'username:password@kaleidoIPFSUrl', protocol: 'https' });
```
6. Edit /etc/httpd/conf/httpd.conf i.e. `sudo nano /etc/httpd/conf/httpd.conf` and modify to look as follows
```conf
<Directory "/var/www/html">
    #
    # Possible values for the Options directive are "None", "All",
    # or any combination of:
    #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
    #
    # Note that "MultiViews" must be named *explicitly* --- "Options All"
    # doesn't give it to you.
    #
    # The Options directive is both complicated and important.  Please see
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
    # for more information.
    #
    Options Indexes FollowSymLinks

    #
    # AllowOverride controls what directives may be placed in .htaccess files.
    # It can be "All", "None", or any combination of the keywords:
    #   Options FileInfo AuthConfig Limit
    #
    AllowOverride All

    Options -MultiViews
    <IfModule mod_rewrite.c>
	    RewriteEngine On
	    # If an existing asset or directory is requested go to it as it is
	    RewriteCond %{DOCUMENT_ROOT}%{REQUEST_URI} -f [OR]
	    RewriteCond %{DOCUMENT_ROOT}%{REQUEST_URI} -d
	    RewriteRule ^ - [L]
	    # If the requested resource doesn't exist, use index.html
	    RewriteRule ^ /index.html
	</IfModule>

    #
    # Controls who can get stuff from this server.
    #
    Require all granted
</Directory>
```
7. Restart the apache server for these changes to apply, with the command `sudo service httpd start`
8. Build the dApp for production running the CLI command `npm run build` inside the folder `truffle-react-box-frontend/client/`
9. Once the build is done, copy and paste all the files and folders inside the `truffle-react-box-frontend/client/dist/` folder into the apache folder i.e. `cd dist/ && cp -R * /var/www/html/`
10. Finally navigate to the ip address of the EC2 instance and the dApp will be displayed. You also should be able to interact with the dApp via metamask using the `Kaleido Custom RPC` as expected.
	- In case of any changes to the dApp, please repeat steps 7 to 9 in that order to see your changes.

## Conclusion

With AWS EC2 and Kaleido we can setup robust private ethereum blockchain nodes, todeploy private dApps and scale these node's as needed to support the dApp without having to worry about the privacy and also security issues that come with deploying dApps in the main and test ethereum networks.