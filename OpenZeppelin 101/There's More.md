# There's More!

OpenZeppelin has a wide range of utilities to add more complexity to your contracts.  

## Cryptography

Within the cryptography folder we have two contracts to help with security:

-   **ECDSA.sol** : This contract will help you to manage and recover your ECDSA signatures (Elliptic Curve Digital Signature Algorithm).

-   **MerkleProof.sol** : Functions to help verify Merkle proofs.

    ```solidity
    pragma solidity ^0.5.2;

    import "openzeppelin-solidity/contracts/cryptography/ECDSA.sol";

    contract ECDSAMock {
        using ECDSA for bytes32;

        function recover(bytes32 hash, bytes memory signature) public pure returns (address) {
            return hash.recover(signature);
        }

        function toEthSignedMessageHash(bytes32 hash) public pure returns (bytes32) {
            return hash.toEthSignedMessageHash();
        }
    }
    ```

Documentation: <https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/mocks/ECDSAMock.sol>

## Drafts

The drafts folder contains contracts which are currently in their development stage.

-   **Counters.sol** : A simple counter contract.

-   **ERC20Migrator.sol** : Used to migrate an ERC20 token from one contract to another.

-   **SignatureBouncer.sol** : Set a signature as a permission to do an action.

-   **SignedSafeMath.sol** : Performs math with a safety check that will revert if there is an error.

-   **TokenVesting.sol** : A token holder contract that will gradually release its token balance.

## Introspection

Introspection is a set of contracts that perform interface detection. They allow you to determine if your contract will support the interface you want to use.

Earlier in the series we introduced token standards. In this tutorial, we are going to talk about another standard called ERC165. ERC165 is used to help with run time interface detection. The introspection folder provides the following contracts:

-   **IERC615** : Base interface that ERC165 will conform to. It also defines the interface you're working on.

-   **ERC165** : This contract is used to support interface detection using a lookup table.

-   **ERC165Checked** : Simplifies the process of checking if a contract supports the interface you want to use.

    ```solidity
    pragma solidity ^0.5.2;

    import "openzeppelin-solidity/contracts/introspection/ERC165.sol";

    contract ERC165Mock is ERC165 {
        function registerInterface(bytes4 interfaceId) public {
            _registerInterface(interfaceId);
        }
    }
    ```

Documentation: <https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/mocks/ERC165Mock.sol>

Note: When we refer to the interface we are talking about what the contracts ABI can represent.

Application Binary Interface/ABI: The interface by which the application program gains access to the operating system and other services.

## Lifecycle

Lifecycle contains a single contract called **Pausable.sol** which allows children contracts to have an emergency stop feature.

#### Math

There are two math contracts:

-   **Math.sol** : Assorted math operations to use.

-   **SafeMath.sol** : Provides math operations that protect your contract from overflow errors.

    ```solidity
    pragma solidity ^0.5.2;

    import "openzeppelin-solidity/contracts/math/SafeMath.sol";

    contract SafeMathMock {
        function mul(uint256 a, uint256 b) public pure returns (uint256) {
            return SafeMath.mul(a, b);
        }

        function div(uint256 a, uint256 b) public pure returns (uint256) {
            return SafeMath.div(a, b);
        }

        function sub(uint256 a, uint256 b) public pure returns (uint256) {
            return SafeMath.sub(a, b);
        }

        function add(uint256 a, uint256 b) public pure returns (uint256) {
            return SafeMath.add(a, b);
        }

        function mod(uint256 a, uint256 b) public pure returns (uint256) {
            return SafeMath.mod(a, b);
        }
    }
    ```

Documentation: <https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/mocks/SafeMathMock.sol>

## Payment

Payment allows you to set different properties in regards to payment options.

-   **PullPayment.sol** : Fix stalling problems by using an **asyncSend()** function to send money to ie a person and then requesting that they withdraw the amount later.

-   **PaymentSplitter.sol** : You can split a payment between multiple people in whichever percentages you want.

-   **ConditionalEscrow.sol** : An escrow contract that only allows a withdrawal if a condition is met.

-   **Escrow.sol** : Holds ether until the payee of the contract withdraws it. Thus It governs the release of funds involved in a transaction.

-   **RefundEscrow.sol** : Escrow that holds funds for a beneficiary, which are deposited from multiple parties.

    ```Solidity
    pragma solidity ^0.5.2;

    import "openzeppelin-solidity/contracts/payment/PullPayment.sol";

    contract PullPaymentMock is PullPayment {
        constructor () public payable {
        }
        function callTransfer(address dest, uint256 amount) public {
            _asyncTransfer(dest, amount);
        }
    }
    ```

Documentation: <https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/mocks/PullPaymentMock.sol>

## Utilities

Utilities contains contracts that don't fall under the other categories.

-   **Address.sol** : Will tell you if the target address belongs to a contract.

-   **Arrays.sol** : A search that looks through a sorted array to find the index of the element value.

-   **ReentrancyGuard.sol** : Helps your contract guard against reentrancy attacks(a bug or attack on your contract).

    ```Solidity
    pragma solidity ^0.5.2;

    import "openzeppelin-solidity/contracts/utils/Address.sol";

    contract AddressImpl {
        function isContract(address account) external view returns (bool) {
            return Address.isContract(account);
        }
    }
    ```

Documentation: <https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/mocks/AddressImpl.sol>

## Conclusion

OpenZeppelin provides the user with a multitude of contracts to support the creation of complex contracts.

Documentation:

<https://openzeppelin.org/api/docs/learn-about-utilities.html>

For more examples of how to use these functions check out the link below:

<https://github.com/OpenZeppelin/openzeppelin-solidity/tree/master/contracts/mocks>
