# Crowdsales

## What is a Crowdsale?

In Blockchain, crowdsales are fundraisers to help assist in the development of a project or start-up. The tokens sold during the crowdsale are used to participate in the project once it is eventually launched. The tokens are only usable with this project. In some cases, these tokens gain market value later on depending on how successful the company is.

## OpenZeppelin & Crowdsales

OpenZeppelin created four categories of contracts based on the most important properties of a crowdsales.

### Price & Rate Configuration

The price point and rate at which tokens are bought and sold is a major factor when creating a token for a crowdsale.

The **IncreasingPriceCrowdsale.sol** contract allows you to linearly in time increase the price of tokens.

<!-- TODO: Clarify -->

Something important to understand is the rate of a crowdsale. Currency math is always done in the smallest denomination. To read the amount, the currency is converted to the correct decimal place. The smallest currency is Wei. **This is for currency**

    1 Eth = 10^18 Wei

**In terms of tokens**, the smallest denomination is TKNbits, a.k.a. bits.

    1 TKN = 10^(decimals) TKNbits

You should keep these conversions in mind when writing and working with currencies and tokens in your contract. **Remember calculations are always in Wei and TKNbits.**

### Emission

Emission refers to how the token reaches the user. The straight forward method is to immediately transfer the token to the buyer. Although, there are other options to help control the number of tokens that are sold, the price point, etc.

-   Default: The crowdsale contract owns the tokens and transfers them to the buyers when they purchase them.

-   **MintedCrowdsale.sol**: The crowdsale contract mints tokens when a purchase is made. This is a way to ensure that excess tokens are not created.

    <!-- TODO: Clarify below -->

-   **AllowanceCrowdsale.sol**: This contract allows for another wallet to grant the crowdsale contract tokens to be sold. With this method, you need to ensure that you approve the allowance using the ERC20 **approve()** function.

    ```solidity
    pragma solidity ^ 0.5.2;

    import "openzeppelin-solidity/contracts/crowdsale/emission/emission-you-choose.sol";

    contract myCrowdsale is emission-you-choose {
        //the rest of your code
    }
    ```

### Validation

Validation ensures that the specified requirements meet the customers' needs. OpenZeppelin has implemented the following contracts:

-   **CappedCrowdsale.sol**: Adds a cap to the crowdsale. If the cap is exceeded, token purchases will not be valid. This can help to keep the value of the token in control.

-   **IndividuallyCappedCrowdsale.sol**: Caps individuals purchases to ensure that not one person owns all the tokens.

-   **WhitelistedCrowdsale.sol**: Only people who are on the whitelist can buy tokens.

-   **TimedCrowdsale.sol**: Your crowdsale has an opening and closing time.

    ```solidity
    pragma solidity ^ 0.5 .2;

    import "openzeppelin-solidity/contracts/crowdsale/validation/validation-you-choose.sol";

    contract myCrowdsale is validation-you-choose {
        //the rest of your code
    }
    ```

### Distribution

The most important part of the crowdsale is how the tokens are released. There are different options for this process.

-   Default: Release the tokens immediately when the buyers purchase them.

-   **PostDeliveryCrowdsale.sol**: Tokens are distributed after the crowdsale is over. Buyers are given the option of using the **withdrawToken()** function to obtain the tokens purchased.

-   **RefundableCrowdsale.sol**: If the minimum goal of the crowdsale is not reached, users can access the **claimRefund()** function to get their Ether back.

    ```solidity
    pragma solidity ^ 0.5 .2;

    import "openzeppelin-solidity/contracts/crowdsale/distribution/distribution-you-choose.sol";

    contract myCrowdsale is distribution-you-choose {
        //the rest of your code
    }
    ```

## Conclusion

Note: If more than one crowdsale feature is used, they must be separated by commas and each be imported.

```solidity
pragma solidity ^ 0.5 .2;

import "openzeppelin-solidity/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";

contract myCrowdsale is PostDeliveryCrowdsale, TimedCrowdsale {
    //the rest of your code
}
```

## Documentation:

<https://openzeppelin.org/api/docs/learn-about-crowdsales.html>

<https://openzeppelin.org/api/docs/crowdsale_Crowdsale.html>

For examples of how to use OpenZeppelin Crowdsale contracts use the following link to access open source code:

[Crowdsales](https://github.com/search?q=import+%22openzeppelin-solidity%2Fcontracts%2Fcrowdsale&type=Code)
