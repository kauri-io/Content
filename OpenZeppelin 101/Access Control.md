# Access Control

## What is It?

The first category of contracts we're going to talk about is access control. Access control allows the user to regulate who can use certain features of the contract. Some examples would be: minting tokens, voting on proposals, ownership, etc.

## Different Ways to Implement

There are two different ways to implement access control in your contract: through ownership or roles.

### Ownership

Ownership is the most basic form of access control and is the best method to use when you have one administrative user. You implement ownership by adding `import "openzeppelin-solidity/contracts/ownership/Ownable.sol";` at the beginning of your contract.

Using the `Ownable.sol` contract you can use functions such as `transferOwnership(address newOwner)` in your contract to transfer ownership and `renounceOwnership()` to remove ownership altogether.

The default owner of the contract is the `msg.sender` of the contract. Thus if you want to change that you have to edit it in the `Ownable.sol` file.

When creating your contract you must state that your contract is `Ownable` and add `onlyOwner` to any function that you only want the administrator to have access to.

```solidity
pragma solidity ^ 0.5 .2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract MyContract is Ownable {

  function everyone() public {
    // anyone can use this function
  }

  function notEveryone() public onlyOwner {
    //only the owner can call this function
  }
}
```

### Roles

Another way to have access control in your contract is to import the `contracts/access/Roles.sol` file. This contract allows you to assign roles to different people using the contract and then restrict which roles are allowed to do what. This is the best method when you have multiple people with varying levels of authority.

To implement this into your contract you add `import "openzeppelin-solidity/contracts/access/Roles.sol";` to the top of your contract. Create your different roles `Role private "your_Role"`, and then add a require statement in each function stating which role is allowed to use it.

```solidity
pragma solidity ^ 0.5 .2;

import "openzeppelin-solidity/contracts/access/Roles.sol";

contract someRoles {
  using Roles for Roles.Role;

  Role private roleOne;

  function onlyRoleOne() public {
    //only roleOne can use this function
    require(roleOne.has(msg.sender), "You must be roleOne");
  }

  function anyone() public {
    //anyone can use this function
  }

}
```

<!-- TODO: More -->

As well, within the access folder there is a Roles folder which contains pre-made roles that you can inherit into your contract.

## Conclusion

Access control allows you to have more control over who can to modify and use certain aspects of your contract and it's easy to do!

Documentation:

<https://openzeppelin.org/api/docs/learn-about-access-control.html>

<https://openzeppelin.org/api/docs/ownership_Ownable.html>

<https://openzeppelin.org/api/docs/access_Roles.html>

For some examples with using roles and ownable check out the following links:

[Ownable](https://github.com/search?utf8=%E2%9C%93&q=import+%22openzeppelin-solidity%2Fcontracts%2Fownership%2FOwnable.sol%22%3B&type=Code)

[Roles](https://github.com/search?utf8=%E2%9C%93&q=import+%22openzeppelin-solidity%2Fcontracts%2Faccess%2FRoles.sol%22%3B&type=Code)
