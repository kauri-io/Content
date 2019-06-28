Vyper Online allows you to write and then compile your smart contracts into Bytecode, ABI and LLL using only your web browser. The Vyper online compiler has a variety of prewritten smart contracts for your convenience. These include a simple open auction, safe remote purchases, ERC20 token and more.

[The source code used in this tutorial can be found here.](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/remix-bounties-smartcontract)

Before we get started, a quick reminder of what we will be building: A dApp which will allow any user to issue a bounty in ETH

- Any user with an Ethereum account can issue a bounty in ETH along with some requirements
- Any user can submit a fulfilment of the bounty along with some evidence
- The bounty issuer can accept a fulfilment which would result in the fulfiller being paid out

Clear the content of the editor. Name the file Bounty

![](https://api.kauri.io:443/ipfs/QmNWQaemeZhPL4cqEHgqU3Qsktp3XBEydcA9e8vfkQVKLW)

We'll first define structs for the contract.

> Structs are custom defined types that can group several variables.

```
struct Bounty:
    issuer: address
    deadline: timestamp
    data: bytes32
    status: uint256
    amount: wei_value
```

```
struct Fulfillment:
    accepted: bool
    fulfiller_address: address
    data: bytes32
```

To test if everything is working at any time of writing the contract, you can use the Compile button on [Vyper Online](https://vyper.online) to compile the contract.

![](https://api.kauri.io:443/ipfs/QmNQH4ytWiWeHSRgLTQofbnkzYRRuiRtmwLguVTWXHCKoS)

If everything is ok, you should see a tick on Bytecode, ABI and LLL tabs, this indicates the compilation was successful.

![](https://api.kauri.io:443/ipfs/QmTLoPwXJ1TooRbC9hagxHcBXkPNAJsFULvCnhfUBzWpdg)

If there is an error, you should be able to see the error message when you open any of the tab links.

![](https://api.kauri.io:443/ipfs/QmcTdx9ifH6nipE2KeaWjkz6EtDMgk3m3ib4zGCX1vyipM)

## Issuing a Bounty

Now that we have the basic skeleton of our smart contract, we can start adding functions, first we will tackle allowing a user to issue a bounty.

### Declare state variables

Just like in solidity, there are state varaibles in vyper. State variables are values which are permanently stored in a contract storage.

[You can see a full list of vyper types in the vyper types documentation ](https://vyper.readthedocs.io/en/latest/types.html)

Next we define events for the contract. Vyper can log events caught during runtime and display it for the user.

```
BountyIssued: event({_id: int128, _issuer: indexed(address), _amount: wei_value, data: bytes32 })
```

```
BountyCancelled: event({ _id: int128, _issuer: indexed(address), _amount: wei_value })
```

```
BountyFulfilled: event({ _bountyId: int128, _issuer: indexed(address), _fulfiller: indexed(address), _fulfillmentId: int128, _amount: wei_value})
```

```
FulfillmentAccepted: event({ _bountyId: int128, _issuer: indexed(address), _fulfiller: indexed(address), _fulfillmentId: int128, _amount: wei_value })
```

We have four events that has different fields. The user may wish to listen to the events for changes on the contract.

Let's declare an constant values which we’ll use to keep track of a bounties state

```
CREATED: constant(uint256) = 0
ACCEPTED: constant(uint256) = 1
CANCELLED: constant(uint256) = 2
```

Now, let's define 2 arrays where we will store data about each issued bounty and fulfillments

```
bounties: map(int128, Bounty)
fulfillments: map(int128, Fulfillment)
```

Before we move to functions, in vyper we have decorators written on top of each of the function. [See functions](https://vyper.readthedocs.io/en/latest/structure-of-a-contract.html#functions)

### Issue Bounty Function

Now that we have declared our state variables we can now add functions to allow users to interact with our smart contract

```
@public
@payable
```

We add the public decorator to the function so that it can be called from the contract. In order to send ETH to our contract we need to add the payable keyword to our function. Without this payable keyword the contract will reject all attempts to send ETH to it via this function. Read more about [decorators](https://vyper.readthedocs.io/en/latest/structure-of-a-contract.html#functions).

```
def issueBounty(_data: bytes32, _deadline: timestamp):
    assert msg.value > 0
    assert _deadline > block.timestamp

    bIndex: int128 = self.nextBountyIndex

    self.bounties[bIndex] = Bounty({ issuer: msg.sender, deadline: _deadline, data: _data, status: 0, amount: msg.value })
    self.nextBountyIndex = bIndex + 1

    log.BountyIssued(bIndex, msg.sender, msg.value, _data)

```

The function issueBounty receives a bytes32 `_data` and an integer `_deadline` as arguments (the requirements as a bytes32, and the deadline as a unix timestamp)

```
assert msg.value > 0
assert _deadline > block.timestamp
```

Since vyper does not support modifiers, we use the assert keyword check to ensure that the every condition is met. The function will return error if any of the conditions are not met.

```
bIndex: int128 = self.nextBountyIndex
```

We define a variable of int128 to hold the current Index position of the bounty. This is necessary because we need to use it to store the new bounty on the bounties list.

The body of our function just has two lines

```
self.bounties[bIndex] = Bounty({ issuer: msg.sender, deadline: _deadline, data: _data, status: 0, amount: msg.value })
self.nextBountyIndex = bIndex + 1
```

First we insert a new Bounty into our bounties array using the bIndex, setting the BountyStatus to CREATED.

In vyper, msg.sender is automatically set as the address of the sender, and msg.value is set to the amount of Weis ( 1 ETH = 1000000000000000000 Weis).

So we set the msg.sender as the issuer and the msg.value as the bounty amount.

```
log.BountyIssued(bIndex, msg.sender, msg.value, _data)
```

Next, we log the event BountyIssued for the user to subscribe to.

### Try it yourself

Now that you have seen how to add a function to issue a bounty, try adding the following functions to the Bounties contract:

- `fulfilBounty(uint _bountyId, string _data)` This function should store a fulfilment record attached to the given bounty. The `msg.sender` should be recorded as the fulfiller.
- `acceptFulfilment(uint _bountyId, uint _fulfilmentId)` This function should accept the given fulfilment, if a record of it exists against the given bounty. It should then pay the bounty to the fulfiller.
- `function cancelBounty(uint _bountyId)` This function should cancel the bounty, if it has not already been accepted, and send the funds back to the issuer

Note: For `acceptFulfilment` you will need to call the `send` function to send the ETH to the `fulfiller`. You can read more about the [address.transfer member here](https://solidity.readthedocs.io/en/latest/units-and-global-variables.html#address-related).

You can find the [complete Bounties.vy file here for reference](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/blob/master/remix-bounties-smartcontract/Bounties-complete.vy).

## Next Steps

- Read the next guide: [Understanding smart contract compilation and deployment](https://kauri.io/article/973c5f54c4434bb1b0160cff8c695369/understanding-smart-contract-compilation-and-deployment)
- Learn more about Remix-IDE from the [documentation](https://remix.readthedocs.io/en/latest/) and [github](https://github.com/ethereum/remix-ide)

> If you enjoyed this guide, or have any suggestions or questions, let me know in the comments.

> If you have found any errors, feel free to update this guide by selecting the **'Update Article'** option in the right hand menu, and/or [update the code](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/remix-bounties-smartcontract)
