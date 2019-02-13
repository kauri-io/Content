# Token Standards

## What is a Token?

In Ethereum, tokens are a digital asset that can represent anything. It could be a protocol, physical object, or even cryptocurrency.

<!-- TODO: Clarify -->

A token is a smart contract and a smart contract is simply a piece of code. To send a token you need to write a contract. Keep in mind that this contract must conform to a set of special standards in order to be able to interact with other tokens/smart contracts.

## Types of Standards

In this tutorial, we are going to cover the two types of standards that OpenZeppelin have made contracts for. Keep in mind that there are more standards.

### ERC20

This is the most common standard for Ethereum tokens to follow. It describes the way tokens are transferred between addresses and how their data is accessed. Every ERC20 token is identical and equal to each other.

### ERC721

This is the standard for a non-fungible token. Non-fungible means that these tokens cannot be interchanged whereas ERC20 tokens can be interchanged. ERC721 tokens are all unique and have special standards in relation to how they are managed, owned, and traded.

## OpenZeppelin & ERC20

OpenZeppelin provides different contracts to assist with creating and interacting with an ERC20 token.

-   **IER20**: Defines the implementation all tokens should conform to.

-   **ERC20**: Basic implementation of the token.

-   **ERC20Detailed**: Allows you to add more information to your tokens such as name, symbol, and decimals.

-   **ERC20Mintable**: Allows anyone with the minter role to mint tokens.

-   **ERC20Burnable**: Allows you to destroy the token.

-   **ERC20Capped**: Maximum cap on tokens allowed.

-   **ERC20Pausable**: Allows anyone with the pauser role to freeze the transfer of tokens to and from users.

-   **safeERC20**: Forces transfers and approvals to succeed or the transaction is reverted.

-   **TokenTimelock**: To release tokens after a specified timeout. This could be used in an Escrow situation.

    ```solidity
    pragma solidity ^ 0.5.2;

    import "openzeppelin-solidity/contracts/token/ERC20/ERC20-option-you-choose.sol";

    contract ERC20Contract is ERC20-option-you-choose {
      // the rest of your code
    }
    ```

## OpenZeppelin & ERC721

OpenZeppelin provides contracts for creating and interacting with an ERC721 token.

-   **IERC721**: Interface for the token.

-   **ERC721**: Basic implementation of ERC721.

-   **IERC721Receiver**: How to handle ERC721 tokens and not mistake it for an ERC20 token.

-   **ERC721Mintable**: Allows anyone with the minter role to mint tokens.

-   **ERC721Pausable**: Allows anyone with the pauser role to freeze the transfer of tokens to and from users.

    ```solidity
    pragma solidity ^ 0.5 .2;

    import "openzeppelin-solidity/contracts/token/ERC721/ERC721-option-you-choose.sol";

    contract ERC721Contract is ERC721-option-you-choose {
      // the rest of your code
    }
    ```

## Conclusion

To use any of the features from the token library, import them at the top of your contract. **import "openzeppelin-solidity/contracts/token/chosen standard"**.  Then you may inherit its functions into your contract.

Note: You can have multiple inheritances but they must all be for the same standard.

```solidity
pragma solidity ^ 0.5 .2;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Burnable.sol";

contract ERC721Contract is ERC721Mintable , ERC20Burnable {
  // the rest of your code
}
```

It's important to understand token standards as well as how to create token smart contracts. With the use of OpenZeppelin, it is easy to follow the standards and create more detailed tokens and contracts.

Documentation:

<https://openzeppelin.org/api/docs/learn-about-tokens.html>

<https://beta.kauri.io/article/b282e90cb260459fb8a8cc6e24ae34fa/v1/ethereum-101-part-v-tokenization>

<https://openzeppelin.org/api/docs/token_ERC20_ERC20.html>

<https://openzeppelin.org/api/docs/token_ERC721_ERC721.html>

To see some more examples of how to use ERC20 and ERC721 inheritable features check out the following links:

[ERC721](https://github.com/search?q=import+%22openzeppelin-solidity%2Fcontracts%2Ftoken%2FERC721%22&type=Code)

[ERC20](https://github.com/search?utf8=%E2%9C%93&q=import+%22openzeppelin-solidity%2Fcontracts%2Ftoken%2FERC20%22&type=Code)
