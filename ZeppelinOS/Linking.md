# Linking, Publishing, and Vouching Oh My!

The next feature of ZeppelinOS is the ability to link to EVM packages that are already deployed. In this tutorial we're going to learn how to link to these packages and publish our own!

#### Linking

Linking to an EVM package is useful when there is already a package existing for your needs because you aren't wasting your time and space on the network deploying another package that already exists. Keep in mind that packages can be updated once deployed.

To link to a package simply create your project.

In the directory of your choice, create your project and then change to that directory:

`$ mkdir math-project`

`$ cd math-project`

Now we're going to create our project.json file to store the relevant data for the project. You will be prompted with properties to fill in; you can fill them out if you wish or just press enter to leave them as the default.

`$ npm init`

To initialize as a ZeppelinOS project execute the following:

`$ zos init math-project`

This command initialized Truffle by creating a configuration file as well as two empty files for us to work with our contract. The zos command also created a zos.json file which is going to contain more information about the project in relation to ZeppelinOS.

The last step is to download the ZeppelinOS project library.

Note: This library has to be installed with every project. It cannot be used project to project.

`$ npm install zos-lib`

Open your project In a text editor of your choice (I'm using Atom) and create a new file called `MathContract.sol` under the contracts folder.

``` solidity
pragma solidity ^0.5.0;

import "openzeppelin-eth/contracts/math/SafeMath.sol";

contract MathContract {
  using SafeMath for uint256;

  uint256 multiply;
  uint256 adding;

function operations (uint256 _x, uint256 _y) external {
    multiply.mul(_x);
    adding.add(_y);
  }

}
```
openzeppelin-eth is an EVM package that is already deployed. It contains the same contracts that OpenZeppelin does. The only difference between the two is that openzeppelin-eth is deployed.

Now we are going to link our contract to the package:

`$ zos link openzeppelin-eth`

We are now linked and we are going to compile and then add the contract to our project:

`$ truffle compile`

`$ zos add MathContract`

Now in a separate terminal run ganache.

`$ ganache-cli --port 9545 --deterministic`

Open up your original terminal and start a new session. For the address you can choose any of the addresses from the ganache window under the available accounts section. I'm going to be using the 9th address.

`$ zos session --network local --from ganache-address-here --expires 3600`

Note: If you get a message at any point saying "A network name must be provided to execute the requested action" it means that our session expired. Simply run the `zos session` command from above and try again from where you left off.

Now we are going to push our contract to the local network.

`$ zos push --deploy-dependencies --network local`

It's time to create an instance of our contract as well as the package we linked to.

`$ zos create MathContract`

//fill in the rest here :( it doesn't work


















#### Publishing

We've seen how to deploy, upgrade, and link our smart contracts. Now it's time to learn about publishing. If you've created an EVM package that you'd like to publish for others to use, we're going to talk about how to do that.

Note: If you follow the steps in this section of the tutorial you will publish your package to the network. If you don't want to do that, use this section as a reference.

Create your project and initalize it:
`$ mkdir project-name`
`$ cd project-name`
`$ npm init`
`$ zos init project-name`

Within the contracts folder, that's where you are going to create your contract/package. Once you're finished you're going to add them:

`$ zos add contract-name-here`

Then you can push your contract to the network. You have to use a real network not your local network for it to be used by others.

`zos push --network network-here`

Simply replace network-here with the network you are going to publish to.

Next we're going to edit the `package.json` file. Add the following to the bottom of the file.
``` solidity
"files": [
   "contracts",
   "build",
   "zos.json",
   "zos.*.json"
 ]
```
 Before you add this code in, make sure that you change the second last bracket to have a comma after it. Your file should look something like this:
```solidity
{
  "name": "",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
  "openzeppelin-eth": "^2.1.3",
    "zos-lib": "^2.1.2"
  },
  "files": [
     "contracts",
     "build",
     "zos.json",
     "zos.*.json"
   ]
}
```
If you have a zos.dev ....json file you can remove it now because it was specific for your local test network.

When you're ready:

`$ npm login`

You'll be prompted to fill in your credentials such as username, password and email address.
Once you have an account. The last step is to publish your package to npm.

`$ npm publish`

If any developers ever want to link to your package all they have to do is:

`$ zos link your-project-name`

That's it! It's very easy to publish an EVM package and it's even easier to link to one!

#### Vouching

Vouching is useful to ensure the authenticity of a package. Anyone can create an EVM package but not all packages are useful or written very well. Vouching provides a way for the user to measure the quality of code of the package. The ZEP token is an ERC20 token that is going to be used in ZeppelinOS to vouch. Right now vouching is in it's early beta stages and is controlled by the following [contract](https://github.com/zeppelinos/zos/blob/v2.0.0/packages/vouching/contracts/Vouching.sol). This is the next feature we will see very soon.

Documentation:

https://docs.zeppelinos.org/docs/linking.html

https://docs.zeppelinos.org/docs/vouching.html
