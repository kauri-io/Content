# Crowdsales

#### What is a Crowdsale?

In the blockchain world, Crowdsales are fundraisers meant to help generate funds to assist in the development of a project or start-up. Tokens sold at the crowdsale can then be used to participate in the project once it is eventually launched. These tokens are generally only useable with this project. Sometimes these tokens might gain value later on in the market based on how successful the project was.


#### OpenZeppelin & Crowdsales

Based on the four most important properties of crowdsales, OpenZeppelin created contracts to get the best functionality out of each.

###### Price & Rate Configuration

The price point and the rate at which tokens are bought and sold is a major factor when creating a token for a crowdsale.

  * IncreasingPriceCrowdsale.sol : Allows you to linearly in time increase the price of tokens.

Something important to understand is the rate of a crowdsale. Firstly currency math is always done in the smallest denomination. To later read the amount , the currency is converted to the correct decimal place. The smallest currency is Wei. **This is for currency**

         1 Eth = 10^18 Wei

** In terms of tokens**, the smallest denomination is TKNbits aka bits.

          1 TKN = 10^(decimals) TKNbits

You should keep these conversions In mind when writing and working with currencies and tokens In your contract. **Remember you are always doing calculations in Wei and TKNbits.**

###### Emission

Emission refers to how the token is going to reach the user. It could be straight forward and the token is immediately transferred to the buyer, but there are other options as well which could help to control the amount of tokens that are sold, price point, etc.

  * Default: The default scenario is to simply have the crowdsale contract own the tokens and transfer them to the buyers when they purchase them.

  * MintedCrowdsale.sol : The crowdsale contract mints tokens when a purchase is made. This is an easy way at ensuring that not too many tokens are created in excess.

  * AllowanceCrowdsale.sol :  This contract allows you to be granted an allowance to another wallet that already owns the tokens to be sold in the crowdsale. You just have to make sure that you approve the allowance using the ERC20 `approve()` method.

  ``` solidity
  pragma solidity ^ 0.5 .2;

  import "openzeppelin-solidity/contracts/crowdsale/emission/emission-you-choose.sol";

  contract myCrowdsale is emission-you-choose {
      //the rest of your code
  }
  ```

###### Validation

Validation requirements ensure that the specified requirements meet the customers needs. OpenZeppelin has implemented validation contracts as follows:

  * CappedCrowdsale.sol : Adds a cap to the crowdsale so that if the cap is exceeded the token purchases aren't valid. A cap might be installed to keep the value of the token in control.

  * IndividuallyCappedCrowdsale.sol : Caps an individuals purchases to ensure no one person owns all the tokens.

  * WhitelistedCrowdsale.sol : Only people who are on the whitelist can purchase tokens.

  * TimedCrowdsale.sol : Your crowdsale will have an opening and closing time.


  ``` solidity
  pragma solidity ^ 0.5 .2;

  import "openzeppelin-solidity/contracts/crowdsale/validation/validation-you-choose.sol";

  contract myCrowdsale is validation-you-choose {
      //the rest of your code
  }
  ```

###### Distribution

The most important part of the crowdsale is when the tokens are released. There are multiple different choices when it comes to how you want to release them.

  * Default : The default option is to release the tokens immediately when the buyers purchase them.

  * PostDeliveryCrowdsale.sol : Tokens are distributed after the crowdsale is over. This gives buyers the option of using a withdrawToken() function to obtain the tokens purchased.

  * RefundableCrowdsale.sol : If the minimum goal of the crowdsale is not reached you can use this contract to allow users to claimRefund() their Ether back.

  ``` solidity
  pragma solidity ^ 0.5 .2;

  import "openzeppelin-solidity/contracts/crowdsale/distribution/distribution-you-choose.sol";

  contract myCrowdsale is distribution-you-choose {
      //the rest of your code
  }
  ```

#### Conclusion

  Something to note is that If you want more than one crowdsale feature, simply separate them with a comma. Just make sure you import both.
  ``` solidity
pragma solidity ^ 0.5 .2;

import "openzeppelin-solidity/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";

  contract myCrowdsale is PostDeliveryCrowdsale , TimedCrowdsale {
      //the rest of your code
  }
  ```

Crowdsale contracts don't have to be difficult to write and with the help of these premade contracts, implementing different features Into your crowdsale is not a problem.

Documentation:

<https://openzeppelin.org/api/docs/learn-about-crowdsales.html>

<https://openzeppelin.org/api/docs/crowdsale_Crowdsale.html>

For some examples of how to use these contracts use the following link:

[Crowdsales](https://github.com/search?q=import+%22openzeppelin-solidity%2Fcontracts%2Fcrowdsale&type=Code)
