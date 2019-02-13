# Access Control

## What is It?

The first category of contracts we're going to talk about is access control. Access control allows the user to regulate who can use certain features of the contract. Some examples would be: minting tokens, voting on proposals, ownership, etc.

## Different Ways to Implement

There are two different ways you can apply access control in your contract. Through ownership or roles.

### Ownership

Ownership is the most basic form of access control. It is the best method to use when you have one administrative user. To implement ownership add an import statement at the beginning of your contract. **import "openzeppelin-solidity/contracts/ownership/Ownable.sol";**

Importing the **Ownable.sol** contract allows you to use functions such as **transferOwnership(address newOwner)** and **renounceOwnership()**. These functions allow you to transfer your ownership or renounce it.

The default owner of the contract is the **msg.sender** of the contract. You can change the owner in the **Ownable.sol** file.

Ownable contracts have an **is Ownable** statement. **onlyOwner** must be added to any function that you only want the administrator to have access to.

```solidity
pragma solidity ^ 0.5.2;

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

Access control can also be implemented through the **contracts/access/Roles.sol** contract. This contract allows you to assign roles to different users and as well as control who is allowed to use certain functions. This is the best method when you have many users with varying levels of authority.

Add **import "openzeppelin-solidity/contracts/access/Roles.sol";** to the top of your contract to use roles. Create your different roles **Role private "your_Role"**. A require statement in your function will state which users are allowed to access it.

```solidity
pragma solidity ^ 0.5.2;

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

Within the access folder, there is a Roles folder which contains pre-made roles that you can inherit into your contract.

## Documentation:

<https://openzeppelin.org/api/docs/learn-about-access-control.html>

<https://openzeppelin.org/api/docs/ownership_Ownable.html>

<https://openzeppelin.org/api/docs/access_Roles.html>

For examples of using **Ownable.sol** and **Roles.sol** check out the following links to open source code:

[Ownable](https://github.com/search?utf8=%E2%9C%93&q=import+%22openzeppelin-solidity%2Fcontracts%2Fownership%2FOwnable.sol%22%3B&type=Code)

[Roles](https://github.com/search?utf8=%E2%9C%93&q=import+%22openzeppelin-solidity%2Fcontracts%2Faccess%2FRoles.sol%22%3B&type=Code)
