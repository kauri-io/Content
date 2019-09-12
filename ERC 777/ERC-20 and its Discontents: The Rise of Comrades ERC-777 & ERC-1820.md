# ERC-20 and its Discontents: The Rise of Comrades ERC-777 & ERC-1820

## The problems with ERC-20

The most well-known Ethereum Request for Comment (ERC) is the [ERC-20](https://en.wikipedia.org/wiki/ERC20), which enabled the growth of Decentralized Apps (dApps), tokens, and token standards that serve the community as the blueprint for creating tokens.

One of the greatest promises of Ethereum is to remove intermediaries, in essence, our ability to directly interact with one another without a central authority, which is a principle built into ERC-20. However, this ability doesn't come without fallibility, ones that we didn't foresee as clearly as we do today – namely that not all contracts can accept all ERC-20 tokens, resulting in a substantial amount of loss of tokens.

We can send tokens to any Ethereum address, which means we can also send them to contracts which do not support them or do not have private keys, locking and losing them forever. According to some estimates, there are tens of millions of dollars’ worth of lost tokens, and with the rise of [non-fungible tokens (NFTs)](https://kauri.io/article/028ff6bf2fa0432191371e6d39398ba6/v1/cute-kitties-and-where-to-find-them-an-introduction-to-non-fungible-tokens) we ideally purchase an NFT with one transaction, which wasn't possible until now. Previously, to buy an NFT, we’d have to complete two transactions. One to change the balance on the ledger and the second to transfer it to the smart contract.

1.  `approve()` – on your coin.
2.  `transfer()` – on the contract side.

However, as a result of some recent efforts, it is now possible to purchase an NFT in a single transaction.

## The efforts of ERC-223

ERC-223 has all the features of ERC-20, but it also checks to see if the smart contract can accept tokens. The ERC-223 receiver can call a function, so it can also be used for purchasing NFTs.

Under ERC-223, for a contract to be able to receive tokens, it has to implement the ERC-223 receiver interface, however, it still isn't as complete as ERC-777 which is built with the goal of backward compatibility with ERC-20, solving its main hurdles, and avoiding the weaknesses of EIP-223.

## The introduction of ERC-777

ERC-777 is a substantial evolution over ERC-20. More than just sending tokens, ERC-777 defines the lifecycle of a token; starting with the minting process, followed by the sending process, and ending with the burn process. It allows for the management of funds by other’s, called "operators".

### From transfer (to, amount) to send (to, amount, data)

EIP-777 does not use “transfer” and “transferFrom” functions, instead, it uses “send” and “operatorSend” to avoid interface confusion.
Similar to the notes field when completing a bank transfer, the “data” in a ERC-777 token transfer can be full or empty. The `tokensReceived` hook allows for both sending and notifying a contract in a single transaction. Whereas ERC-20 required a double call (`approve`/`transferFrom`) to achieve this.

### From approve to operators

Another difference in the solidity contract of ERC-777 is the use of the `operators` function, instead of `approve()`. ERC-777 allows holders of an address to authorize others to send and burn tokens on their behalf.

### Notifications

Token holders are notified when their address is used.

## ERC-1820

ERC-1820 is a registry for checking which address supports which interface. Unlike ERC-777, ERC-1820 is not a token standard, but instead a standard for a registry.
While there might be disadvantages to relying on a separate standard, ERC-1820 offers benefits that are important to acknowledge. For example, it allows ERC-777 to remain relatively simple, without the added overcomplication of adding a registry to it. Perhaps more importantly, it allows other EIPs and smart contract infrastructures to take advantage of the registry for their own use cases.
The drawback with using ERC-1820 is ERC-777’s dependency on it. The parity hack is an obvious example of what problems such dependencies can create.

## The ERC-777 code and explanation

Below is a basic example of an ERC-777 contract, from <https://github.com/ethereum/EIPs/blob/master/EIPS/eip-777.md>:

```solidity
interface ERC777Token {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function balanceOf(address holder) external view returns (uint256);
    function granularity() external view returns (uint256);

    function defaultOperators() external view returns (address[] memory);
    function isOperatorFor(
        address operator,
        address holder
    ) external view returns (bool);
    function authorizeOperator(address operator) external;
    function revokeOperator(address operator) external;

    function send(address to, uint256 amount, bytes calldata data) external;
    function operatorSend(
        address from,
        address to,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;

    function burn(uint256 amount, bytes calldata data) external;
    function operatorBurn(
        address from,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;

    event Sent(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 amount,
        bytes data,
        bytes operatorData
    );
    event Minted(
        address indexed operator,
        address indexed to,
        uint256 amount,
        bytes data,
        bytes operatorData
    );
    event Burned(
        address indexed operator,
        address indexed from,
        uint256 amount,
        bytes data,
        bytes operatorData
    );
    event AuthorizedOperator(
        address indexed operator,
        address indexed holder
    );
    event RevokedOperator(address indexed operator, address indexed holder);
}
```

What follows is a brief discussion of the functions and events of the protocol, for a more detailed discussion, read [the official EIP-777 Github page](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-777.md).

ERC-777 defines the entire lifecycle of a token, including the minting (4), sending (3), and burning (5) of tokens.

### View Functions

a.	name function
b.	symbol function
c.	totalSupply function
d.	balanceOf function
e.	granularity function

### Operators

a.	AuthorizedOperator event
b.	RevokedOperator event
c.	defaultOperator function
d.	authorizeOperator function
e.	revokeOperator function
f.	isOperatorFor function

### Sending Tokens

a.	Sent event
b.	Send function
c.	OperatorSend function

### Minting Tokens

a.	Minted event

### Burning Tokens

a.	Burned event
b.	burn function
c.	operatorBurn function

## A use case – buying a Crypto Kitty with an ERC-777 Token

Before the advent of ERC-777, anybody wanting to purchase a non-fungible token would have had to complete two transactions. One to change the balance on the ledger and the second to transfer it to the smart contract

Using the data field in the send function, now both tasks can be accomplished in the same transaction – namely transferring tokens and informing the contract that the tokens have been transferred.

## The challenges for the protocol and its potentials

## References

<!-- TODO: ? -->
