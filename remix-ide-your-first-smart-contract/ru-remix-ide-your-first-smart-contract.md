
# Примечания от переводчика

Данныая статья является переводом [материала][link-original-article], опубликованного пользователм [@joshorig][joshorig-profile]. Переводчик сохранил авторский стиль изложения от первого лица.

Во избежание неоднозначностей и разночтений, часть устоявшихся терминов оставлена без перевода. Например: `JavaScript`, `Blockchain`, `Solidity`.

Ссылки, приведенные в статье, ведут на страницы с англолязычной документацией, поскольку соответствующая документация на русском отсутствует на момент создания данного перевода.

# Среда разработки Remix - создайте свой первый Smart Contract

## 1. Вступление от автора

Простейшим способом разработать свой `smart contract` на языке `Solidity` является использование [онлайн-окружения Remix][remix-ide-open]

Она не требует никаких действий по установке либо настройке, поскольку выполнена как сайт, а не как приложение. Просто откройте [этот сайт][remix-ide-open] - и вы уже готовы приступить к написанию кода своего контракта.

Среда разработки Remix предоставляет обширный набор вспомогательных средств для отладки, статического анализа и публикации кода контракта. Все они доступны как часть единого онлайн-окружения.


[Исходный код][tutorial-source-root], приведенный в данном обучающем материале, можно найти [по этой ссылке][tutorial-source-root].


Прежде, чем продолжить, вспомним: `"А что, собственно, будет являться конечным результатом нашей работы?"`.

```
Пользователи нашего распределенного приложения (dApp)
смогут создавать задания
и выплачивать за их выполнение гонорар 
в криптовалюте "эфир" (имеющей буквенный код ETH).
```

* Любой пользователь, имеющий учетную запись в блокчейне Ethereum, может создать задание. Задание содержит описание критериев приемки выполненной работы, а также значение суммы гонорара для исполнителя.
(под учетной записью понимается пара ключей `"public key/pivate key"` - прим. переводчика)
* Любой пользователь может подать заявку на получение гонорара, предоставив доказательства факта выполнения задания надлежащим образом.
* Создатель задания должен подтвердить приемку работы, дабы получить ее результат. В этом случае вознаграждение будет автоматически выплачено исполнителю созданным нами контрактом.

## 2. Создание контракта в среде Remix

Откройте [страницу][remix-ide-open] среды Remix. В левом верхнем углу вы увидите кнопку с иконкой `"+"`. Нажмите на нее и введите `"Bounties.sol"` в качестве имени файла в появившееся диалоговое окно.

![screenshot : creatng a file in remix][screenshot-remix-create-file]

В качестве первой строки нашего контракта на языке Solidity обязательно должен находиться номер версии компилятора.

```
pragma solidity ^0.5.0;
```

Благодаря этой инструкции, Solidity будет знать, что нужен компилятор версии `0.5.0` либо новее. Но не более новый, чем `0.6.0`, в которой могут быть изменения, ломающие обратную совместимость. Данное ограничение обеспечивается символом `^`, стоящим перед номером версии.
(Таким образом, `Solidity` следует правилам [semantic versioning][link-semantic-versioning] - прим. переводчика)

Теперь создадим сам класс, который будет содежжать код котракта. Для этого напишем 

```
contract Bounties {

}
```

Далее, добавим конструктор, дабы иметь возможность создать экземпляр нашего контракта.

```
constructor() public {}
```

## 3. Компиляция контракта

На этом этапе мы получили базовый каркас электронного контракта (Smart Contract). Далее - скомпилируем его в Remix IDE.

Ваш файл `Bounties.sol` сейчас должен выглядеть следующим образом:

```
pragma solidity ^0.5.0;

contract Bounties {

    constructor() public {}
}
```

В окружении Remix выберите `вкладку "Compile"` в правом верхнем углу экрана и запустите процесс компиляции нажатием `кнопки "Start to Compile"` как показано на снимке экрана ниже.

![screenshot: compile a smart contract in Remix IDE][screenshot-remix-compile]

В случаче успеха вы должны увидеть название своего `контракта "Bounties"` на зеленом фоне, как показано на том же снимке экрана.

## 4. Публикация задания

Пришло время расширить наш каркас контракта некоторой функциональностью.
Начнем с публикации задания.

### 4.1 Объявление переменных для хранения состояния

Что же такое переменные состояния в `Solidity`? 
Дело в том, что экземпляр электронного контракта имеет возможность запоминать свое состояние,
помещая его в хранилище EVM (Ehtereum Virtual Machine - прим. переводчика).
Это состояние описываеться одной либо несколькими переменными, 
которые могут иметь один из встроенных в язык Solidity типов. 
Значение, хранящееся в этих переменных, может быть изменено 
лишь функциями, вызванными во время транзакции.

Исчерпывающий список типов можно найти в документации языка `Solidity`. 
А именно, в [секции "Types"][doc-solidity-types].

Первым делом, давайте объявим перечислимый тип, 
описывающий множество состояний, в которых может находиться задача.

```
// множество "состояния задачи"
//
enum BountyStatus 
{ 
    CREATED  , // "создано" - новая задача, ожидающая иполнителя
    ACCEPTED , // "принято к исполнению" - исполнитель найден и утвержден
    CANCELLED  // "отменена" - работодатель больше не нуждается в данной услуге
}
```

<br>
Далее объявим структуру, для хранения данных о задаче.

```
// структура "заказ" (работа за вознаграждение)
//
struct Bounty {

    // учетная запись ethereum работодателя
    //
    address issuer;

    // срок выполнения.
    // исполнитель не получит вознаграждение, если нарушит его.
    //
    uint deadline;

    // описание задания
    //
    string data;

    // состояние задачи
    // тип enum был только что объявлен нами выше
    //
    BountyStatus status;

    // сумма вознаграждения в WEI
    // WEI - минимальная неделимая дробная часть валюты "эфир"
    // 10^18 WEI == 1 ETH 
    //
    uint amount;
}
```

<br>
Что такое структура? 
Структура - это конструкция языка, 
позволяющая описывать собственные типы данных. 
По сути, это - набор переменных, 
которые могут принадлежать как типам, встроенным в язык `Solidity`, 
так и являться другими структурами.
Набор переменных объединяют в структуру
с целью их группирования и более понятной организации 
при разработке кода контракта.


<p>
Давайте-ка добавим в наш контракт переменную-массив, 
хранящую данные обо всех созданных контрактах.

```
Bounty[] public bounties;
```

### 4.2 Issue Bounty Function

Now that we have declared our state variables we can now add functions to allow users to interact with our smart contract

```
function issueBounty(
    string memory _data,
    uint64 _deadline
)

public payable hasValue() validateDeadline(_deadline) returns (uint)
{
    bounties.push(Bounty(msg.sender, _deadline, _data,
    BountyStatus.CREATED, msg.value));
    return (bounties.length - 1);
}
```

The function issueBounty receives a string memory `_data` and an integer `_deadline` as arguments (the requirements as a string, and the deadline as a unix timestamp)

As of Solidity version 0.5.0 explicit data location for all variables of struct, array or mapping types is now mandatory. Read more about [Solidity 0.5.0 breaking changes here](https://solidity.readthedocs.io/en/v0.5.0/050-breaking-changes.html)

Since string is an array of bytes we must explicitly specify the data location of the argument `_data`. We specify `memory` since we do not wish to store this data when the transaction has been completed.

Solidity requires that you define the return type(s) We specify: `returns(uint)` Which means we are returning a uint (the array index of the Bounty as the ID)

We define the visibility of this function as `public`.Read more about [solidity function visibility](https://solidity.readthedocs.io/en/v0.4.24/contracts.html#visibility-and-getters)

In order to send ETH to our contract we need to add the payable keyword to our function. Without this payable keyword the contract will reject all attempts to send ETH to it via this function.

The body of our function just has two lines
```
bounties.push(Bounty(msg.sender, _deadline, _data,
BountyStatus.CREATED, msg.value));
```

First we insert a new Bounty struct to out bounties array, setting the BountyStatus to CREATED.

In Solidity, msg.sender is automatically set as the address of the sender, and msg.value is set to the amount of Weis ( 1 ETH = 1000000000000000000 Weis).

So we set the msg.sender as the issuer and the msg.value as the bounty amount.
```
return (bounties.length - 1);
```

## Validation with Modifiers

Modifiers in solidity allow you to attach additional pieces of code to be run before or after the execution of a function. It is common practice in solidity to use modifiers to perform argument validation for solidity functions.

## Validate Deadline

validateDeadline(_deadline) is added to ensure the deadline argument is in the future, it should not be possible for a user to issue a bounty with a deadline in the past.
```
modifier validateDeadline(uint _newDeadline) {
    require(_newDeadline > now);
    _;
}
```

We use the `modifier` keyword to declare a modifier, modifiers like functions can receive arguments of their own.

The position of the `_;` symbol is key within a modifier. This body of the function being modified is inserted where this symbol appears.

So the validateDeadline modifier essentially says, execute this line:
```
require(_newDeadline > now);
```
Then execute the main function.

For validation the `require` keyword allows for conditionals to be set, if not met, the execution is halted, reverted, and remaining gas returned to the user.

In general `require` should be used to validate user inputs, responses from external contracts, and state conditions prior to execution.

You can read more about [assert, require, and revert here] (http://solidity.readthedocs.io/en/v0.4.24/control-structures.html#error-handling-assert-require-revert-and-exceptions).

So to modifier validateDeadline reads as follows:

If the `deadline > now` continue and execute function body, else revert and refund remaining gas to caller.


### Has Value

`hasValue()` is added to ensure `msg.value` is a non zero value. Even though as previously discussed the `payable` keyword ensures msg.value is set, it can still be sent as zero.

Similar to `validateDeadline` we use `require` to ensure `msg.value` input is valid e.g `>0`
```
modifier hasValue() {
    require(msg.value > 0);
    _;
}
```
`payable` is actually a pre-defined modifier in solidity, and validates that ETH is sent when calling a function which requires the smart contract to be funded.

You can read more about how modifiers can be used to restrict access and guard against incorrect usage in the [solidity documentation] (https://solidity.readthedocs.io/en/v0.4.24/common-patterns.html?highlight=modifier#restricting-access)


### Issue Bounty Event

It is best practice when modifying state in solidity to emit and event. Events allow blockchain clients to subscribe to state changes and perform actions based on those changes.

For example a user interface showing a list of transfers in and out of an account, for example [etherscan] (https://etherscan.io/address/0x69a70e299367ff4c3ba1fe8c93fbddd9b5b4771a), could listen to a “transfer” event to update the user on the latest transfers in and out of an account.

Read more about [solidity events here] (https://solidity.readthedocs.io/en/latest/contracts.html#events).

Since when issuing a bounty we change the state of our Bounties.sol contract we will issue a `BountyIssued` event.
First, we need to declare our event:
```
event BountyIssued(uint bounty_id, address issuer, uint amount, string data);
```
Our BountyIssued event emits the following information about the bounty data stored:

* *bountyId: *The id of the issued bounty
* *issuer: *The account of the user who issued the bounty
* *amount: *The amount in Weis allocated to the bounty
* *data: *The requirements of the bounty as a string

Then in our `issueBounty` function, we need to emit the `BountyIssued` event:
```
bounties.push(Bounty(msg.sender, _deadline, _data, BountyStatus.CREATED, msg.value));
*emit BountyIssued(bounties.length - 1,msg.sender, msg.value, _data);*
return (bounties.length - 1);
```
Now that we have added our `issueBounty` function our `Bounties.sol` file should look like the following:
```
pragma solidity ^0.5.0;
/**
* @title Bounties
* @author Joshua Cassidy- <joshua.cassidy@consensys.net>
* @dev Simple smart contract which allows any user to issue a bounty in ETH linked to requirements
* which anyone can fulfil by submitting the evidence of their fulfilment
*/
contract Bounties {
/*
* Enums
*/
enum BountyStatus { CREATED, ACCEPTED, CANCELLED }
/*
* Storage
*/
Bounty[] public bounties;
/*
* Structs
*/
struct Bounty {
    address issuer;
    uint deadline;
    string data;
    BountyStatus status;
    uint amount; //in wei
}
/**
* @dev Contructor
*/
constructor() public {}
/**
* @dev issueBounty(): instantiates a new bounty
* @param _deadline the unix timestamp after which fulfillments will no longer be accepted
* @param _data the requirements of the bounty
*/
function issueBounty(
    string memory _data,
    uint64 _deadline
)
public
payable
hasValue()
validateDeadline(_deadline)
returns (uint)
{
    bounties.push(Bounty(msg.sender, _deadline, _data, BountyStatus.CREATED, msg.value));
    emit BountyIssued(bounties.length - 1,msg.sender, msg.value, _data);
    return (bounties.length - 1);
}
/**
* Modifiers
*/
modifier hasValue() {
    require(msg.value > 0);
    _;
}
modifier validateDeadline(uint _newDeadline) {
    require(_newDeadline > now);
    _;
}
/**
* Events
*/
event BountyIssued(uint bounty_id, address issuer, uint amount, string data);
}
```

## Deploy & interact in Remix

Now that we have our smart contract we can deploy to a local development blockchain running in the RemixIDE (browser), and test our `issueBounty` function.

First, lets compile our `Bounties.sol` contract to ensure we have no errors. In Remix, select the “Compile” tab in the top right hand side of the screen, and start the compiler by selecting the “Start to Compile” option.

![](https://api.beta.kauri.io:443/ipfs/QmPbH2hJxqjwyCbo7iLMovVQLZyb96V9EbzKkUhJnS4Eem)

You will notice, a few static analysis warnings in the IDE above the compilation result. Remix runs a set of static analysers to help avoid known security vulnerabilities and follow best practices. You can read more about [Remix Analysis here.] (https://remix.readthedocs.io/en/latest/analysis_tab.html) We can ignore these warning for now and move on to deploying and interacting with our smart contract.

In Remix, select the `Run` tab in the top right hand side of the screen. Within the `Environment` dropdown section, select the `Javascript VM` option.

![](https://api.beta.kauri.io:443/ipfs/QmdAgBc9WzFmE4GwKBxHkMRCBBdAapHP1Ym3dR8mS2atSF)

The “JavaScript VM” option, runs a Javascript VM blockchain within the browser, this allows you to deploy and send transactions to a blockchain within the RemixIDE in the browser. This is particularly useful for prototyping especially since no dependencies are required to be installed locally. [You can read more about running transactions within Remix here] (https://remix.readthedocs.io/en/latest/run_tab.html).

Within the `Run` tab in Remix, with the `JavaScript VM` environment option selected. Click the `Deploy` button.

![](https://api.beta.kauri.io:443/ipfs/QmerrAduWYrYaxMT5254xE5DjngDid81hgaVT32uqGt1qt)

This executes a transaction to deploy the contract to the local blockchain environment running in the browser. We’ll talk more about contract creation transactions later on in the series.

Within the RemixIDE console, which is located directly below the editor panel, you will see the log output of the contract creation transaction.

![](https://api.beta.kauri.io:443/ipfs/QmXCiXYPFLbuk8X8eWv16F3PQFSp2ZEi8pstDrsSbYNybw)

The “green” tick indicates that the transaction itself was successful.

Within the “Run” tab in Remix, we can now select our deployed Bounties contract so that we can invoke the `issueBounty` function. Under the “Deployed Contracts” section we see a list of function which can be invoked on the deployed smart contract.

Here we have the following options:

* `issueBounty` the colour of this button “pink” indicates that invocation would result in a transaction
* `bounties` the colour of this button “blue” indicates that invocation would result in a call

![](https://api.beta.kauri.io:443/ipfs/QmUzyH4Vugc3vN52hna8r1r5hRzuLKTVXRC3vP4Huejqwt)

To invoke the `issueBounty` function, we need to first set the arguments in the “issueBounty” input box.

Set the `string _data` argument to some string “some requirements” and set the `uint64 _deadline` argument to a unix timestamp in the future e.g “1691452800” August 8th 2023.

Since our `issueBounty` function is `payable` we must ensure `msg.value` is set, we do this by setting the values at the top of the “Run” tab with the RemixIDE.

Here we have the following options:

* *Environment: *As previously alluded to, sets the blockchain environment to interact with.
* *Account: *Allows the selection of an account to send the transaction from, and also to see the amount of ETH available in each account.
* *Gas Limit: *Set the max amount of gas to be used by execution of the transaction
* *Value: *The amount to send in `msg.value` here you can also select the denomination in “Wei, Gwei, Finney and Ether”

So go ahead and set “Value” to some number > 0, but less than the current amount available in the selected account. In this example we’ll set it to `1 ETH`

Clicking the “issueBounty” button in the “Deployed Contracts” section, within the “Run” tab, will send a transaction invoking the `issueBounty` function, on the deployed `Bounties` contract.

Within the console you will find the log output of the issueBounty transaction.

![](https://api.beta.kauri.io:443/ipfs/QmUzyH4Vugc3vN52hna8r1r5hRzuLKTVXRC3vP4Huejqwt)

The “Green” tick indicates the transaction was successful.

The decoded output, gives you the return value of the function call, here it is `0`.

This should be the index of our “Bounty” data within the bounties array in our smart contract data store. We can double check the storage was correct by invoking the “bounties” method in the “Deployed Contracts” section.

Set the `uint256` argument of the bounties function to `0` and click the “blue” bounties button.

![](https://api.beta.kauri.io:443/ipfs/QmS17UXysJzMLibRzDShajzzMsV5Lkvi3jdjJQTYVqrQzu)

Here we confirm that the data inputs for our issuedBounty are retrieved correctly from the “bounties” array with deployed smart contracts storage.

### Try it yourself

Now that you have seen how to add a function to issue a bounty, try adding the following functions to the Bounties contract:

* `fulfilBounty(uint _bountyId, string _data)` This function should store a fulfilment record attached to the given bounty. The `msg.sender` should be recorded as the fulfiller.
* `acceptFulfilment(uint _bountyId, uint _fulfilmentId)` This function should accept the given fulfilment, if a record of it exists against the given bounty. It should then pay the bounty to the fulfiller.
* `function cancelBounty(uint _bountyId)` This function should cancel the bounty, if it has not already been accepted, and send the funds back to the issuer

Note: For `acceptFulfilment` you will need to use the `address.transfer(uint amount)` function to send the ETH to the `fulfiller`. You can read more about the [address.transfer member here] (https://solidity.readthedocs.io/en/latest/units-and-global-variables.html#address-related).

You can find the [complete Bounties.sol file here for reference] (https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/blob/master/remix-bounties-smartcontract/Bounties-complete.sol).

## Next Steps
- Read the next guide: [Understanding smart contract compilation and deployment](https://kauri.io/article/973c5f54c4434bb1b0160cff8c695369/understanding-smart-contract-compilation-and-deployment)
- Learn more about Remix-IDE from the [documentation](https://remix.readthedocs.io/en/latest/) and [github](https://github.com/ethereum/remix-ide)

>If you enjoyed this guide, or have any suggestions or questions, let me know in the comments. 

>If you have found any errors, feel free to update this guide by selecting the **'Update Article'** option in the right hand menu, and/or [update the code](https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/remix-bounties-smartcontract)


[link-original-article]: https://kauri.io/article/124b7db1d0cf4f47b414f8b13c9d66e2/v8/remix-ide-your-first-smart-contract
[joshorig-profile]: https://kauri.io/public-profile/7b88584d0e6a608fa3a8716b0ca1620d61834a0c

[remix-ide-open]: https://remix.ethereum.org/
[tutorial-source-root]: https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/tree/master/remix-bounties-smartcontract

[screenshot-remix-create-file]: https://api.beta.kauri.io:443/ipfs/QmYMw578VU2z4nUwGbDwcoMBBmDTEsbriSNs7H44smJpYZ

[screenshot-remix-compile]: https://api.beta.kauri.io:443/ipfs/QmSxzksHcCp9AibwAGsTxdYntdn6hGiBmjeCZm3bpKf4h6

[link-semantic-versioning]: https://semver.org/

[doc-solidity-types]: http://solidity.readthedocs.io/en/latest/types.html