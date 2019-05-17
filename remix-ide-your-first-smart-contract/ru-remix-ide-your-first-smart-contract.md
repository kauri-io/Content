
# Примечания от переводчика

Данная статья является переводом [материала][link-original-article], опубликованного пользователм [@joshorig][joshorig-profile]. Переводчик сохранил авторский стиль изложения от первого лица.

Во избежание неоднозначностей и разночтений, часть устоявшихся терминов оставлена без перевода. Например: `JavaScript`, `Blockchain`, `Solidity`.

Ссылки, приведенные в статье, ведут на страницы с англолязычной документацией, поскольку соответствующая документация на русском отсутствует на момент создания данного перевода.

# Среда разработки Remix - создайте свой первый Smart Contract

## 1. Вступление от автора

Простейшим способом разработать свой `smart contract` на языке `Solidity` является использование [онлайн-окружения Remix][remix-ide-open]

Она не требует никаких действий по установке либо настройке, 
поскольку сделана как сайт, а не как настольное приложение. 
Просто откройте [этот сайт][remix-ide-open] - 
и вы уже готовы приступить к написанию кода своего контракта.

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
contract Bounties 
{
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

contract Bounties 
{
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
struct Bounty 
{
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

<br/>
Что такое структура? 
Структура - это конструкция языка, 
позволяющая описывать собственные типы данных. 
По сути, это - набор переменных, 
которые могут принадлежать как типам, встроенным в язык Solidity, так и являться другими структурами.
Набор переменных объединяют в структуру
с целью их группирования и более понятной организации 
при разработке кода контракта.


<p>
Давайте-ка добавим в наш контракт переменную-массив, 
хранящую данные обо всех созданных контрактах.

```
Bounty[] public bounties;
```

### 4.2 Функция "создать задание"

Ранее мы подготовили переменные для работы с состоянием.
Теперь же - напишем функции для взаимодействия с нашим `smart contract`.

```
// создать задание
//
function issueBounty(
    string memory _data,        // описание работ
    uint64        _deadline     // срок исполнения 
    
) public   // функция может быть вызвана любым пользователем или другим контрактом в сети Ethereum
  payable  // при вызове этой функции контракт может получать эфир
           // полученный эфир будет храниться "на балансе" контракта

    hasValue()  // проверяем, что при вызове контракту был отправлен эфир в ненулевом объеме.
                // реализацию этого modifier запрограммируем позже
    validateDeadline(_deadline) 
                // проверяем, что крайний срок не исчерпан на момент задания
                // реализацию этого modifier запрограммируем позже
returns (uint)  // возвращает целое число - порядковый номер последнего добавленного задания
{
    bounties.push(
        Bounty(
            msg.sender, // адрес отправителя эфира, вызвавшего функцию. он же создатель нового задания.
            _deadline,  // срок исполнения. передан как параметр.
            _data,      // описание работ. передан как параметр.
            BountyStatus.CREATED, // статус "задача создана", исполнитель еще не назначен
            msg.value   // размер награды. 
                        // до выполнения задания сам эфир будет храниться в контракте.
                        // в структуру попадает только его количество
                        // измеряемое в WEI
        )
    );
            
    // отнимаем единицу, поскольку 
    // нумерация элементов массива начинается с нуля
    return (bounties.length - 1);
}
```

Функция `issueBounty()` принимает следующие параметры:
* `_data` - требования к исполнителю и описание работы. Имеет тип `string memory`
* `_deadline` - время и дата крайнего срока исполнения задания 
с точностью до секунды в формате [unix timestamp][link-unix-timestamp-wiki]

Начиная с версии `0.5.0` языка Solidity, 
нужно обязательно указывать явно
способ хранения (`memory` либо `storage`)
для всех переменных, имеющих тип
* строка - `string`
* массив - `array`
* ассоциативный массив - `mapping`

Для контрактов более ранних версий 
будут использованы соответствующие способы хранения по умолчанию.
Детальную информацию об этих важных изменениях 
в версии `0.5.0`
можно прочитать по данной [ссылке][doc-solidity-0.5.0-breaking]


Реализация строк в языке `Solidity` 
базируется на байтовом массиве 
(что в случае длинных строк более затратно, 
чем хранение чисел - прим. переводчика).
Следовательно, для параметра `_data` 
мы должны указать тип хранения.
Наш выбор падет на `memory`, 
поскольку нам не нужно хранить эти данные 
после окончания работы функции `issueBounty()`,
а также транзакции, в рамках которой эта функция будет выполняться.

Язык `Solidity` требует объявления 
типа возвращаемого значения 
(или нескольких типов в случае, 
если возвращается больше одного значения).
Мы указали `returns(uint)` - беззнаковое целое.
В него будет записываться индекс последнего, 
только что добавленного, задания.

Функция объявлена с областью видимости `public`. 
Дополнительную информацию о `видимости функций в Solidity` 
вы найдете [по данной ссылке][doc-solidity-function-visibility]

Для того, чтоб контракт при вызове функции `issueBounty()`
мог получать средства в криптовалюте "эфир" - `ETH`,
необходимо добавить ключевое слово `payable`
в описание указанной функции.
Без данного ключевого слова 
контракт будет отвергать все попытки
послать ему эфир при вызове функции `issueBounty()`.


Тело функции состоит всего лишь из двух инструкций
```
bounties.push(Bounty(msg.sender, _deadline, _data,
BountyStatus.CREATED, msg.value));
```

Сперва мы формируем экземпляр структуры
объявленного нами ранее типа `struct Bounty`
со статусом `BountyStatus.CREATED` 
и помещаем ее в наш массив `bounties`.

В языке solidity каждая функция имеет скрытый параметр `msg`,
в котором содержится контекст выполнения - 
то есть, разная полезная информация о транзакции.
Нас интересуют такие поля как
* `msg.sender` - поскольку там хранится адрес пользователя или контракта, вызвавшего нашу функцию (имеет тип `address`)
* `msg.value` - содержит количество перечисленных средств. 
Измеряется в WEI - минимально допустимой, неделимой дробной части эфира.
(1 ETH = 1000000000000000000 wei = 10^18 wei)

Таким образом, мы зададим `msg.sender` в качесиве поля `issuer`
и `msg.value` в качестве поля `amount` соответственно.
(поля принадлежат объявленной нами ранее структуре `struct Bounty`).


```
return (bounties.length - 1);
```

Далее мы просто возвращаем индекс 
только что созданной структуры в массиве.
Поскольку мы ее только что создали и поместили в массив,
его длина гарантированно будет больше нуля, 
и ошибок можно пока не опасаться.

## 5. Проверка входных данных с помощью Modifiers

Modifier - функция, объявленная особым образом,
которую можно "прикрепить" средствами языка `Solidity`
к другой, "основной" функции.
Логика modifier может быть исполнена как перед, так и после 
выполнения основной функции.

```
Широко распространена практика 
запуска modifier перед основной функцией
с целью проверки её входных параметров
```

## 5.1 Проверка крайнего срока выполнения (при создании задания)

Добавим **функцию-модификатор**
`modifier validateDeadline(_deadline)` ,
дабы с его помощью удостовериться,
что переданная конечная дата находится в будущем.
У пользователей не должно быть возможности создавать задания,
срок исполнения которых истек, так и не успев начаться.


```
modifier validateDeadline(uint _newDeadline) {
    require(_newDeadline > now);
    _;
}
```

Для объявления такой специальной функции
необходимо использовать ключевое слово `modifier`.
Модификаторы могут иметь свои входные параметры - 
так же, как и "обычные" функции языка `Solidity`.

Расположение инструкции `_;` - 
самая важная часть логики модификатора.
В этом месте будет исполнен код "основной" 
("модифицируемой") функции.

Таким образом, `modifier validateDeadline()`
сперва выполнит проверку `require(_newDeadline > now);`, 
а затем - основную функцию.

Использованная для проверки функция `require()`, 
принимает логическое условие в качестве параметра.
Если условие ложно - то выполнение будет остановлено, 
транзакция - отменена, а оставшийся газ - возвращен отправителю (он же `msg.sender`).

Обычно `require()` используется для проверки входных данных
до выполнения основной логики функции.

В общем случае,
для обработки нештатных ситуаций 
и остановки работы контракта
могут применяться 
такие функции как:
* `assert()`
* `require()`
* `revert()`

Подробную информацию об этих функциях и обработке ошибок
можно найти в [документации solidity][doc-solidity-error-handling]

Таким образом, логику модификатора `modifier validateDeadline()`
следует трактовать следующим образом :

Если `deadline > now` - продолжаем исполнять основную функцию.
Иначе - отменяем транзакцию 
и возвращаем еще не использованный остаток газа 
его вледельцу.


### 5.2 Модификатор `hasValue()`

Реализуем логику `modifier hasValue()`, 
дабы с его помощью удостовериться,
что количество адресованного контракту эфира 
не равно нулю.

Ранее упомянутое ключевое слово `payable`
предоставляет возможность получать эфир,
но не гарантирует этого. 
Поскольку количество отправляемого эфира может быть любым.
То есть, другой пользователь имеет полное право
"отправить" нулевое количество.

```
Примечание переводчика: очевидно, что это количество не может быть отрицательным
поскольку это было бы эквивалентно 
"забрать силой эфир у другого пользователя"
что абсолютно недопустипо.
```

Абсолютно так же, как в `modifier validateDeadline()`,
мы воспользуемся функцией `require()`
чтоб удостовериться в выполнении условия 
`количество отправленного эфира больше нуля`.

```
modifier hasValue() {
    require(msg.value > 0);
    _;
}
```

Кстати, ранее использованный нами `payable` - это
тоже модификатор, но встроенный в язык `Solidity`.
Он гарантирует, что эфир (а также, газ) отправляется контракту
при вызове функции, которая требует финансирования.

Детальную информацию о модификаторах,
а также о контроле доступа,
можно найти в [документации языка Solidity][doc-solidity-modifiers].


### 6. Событие-уведомление "задание создано"

В разработке на Solidity 
считается хорошим тоном сгенерировать событие
при изменении состояния контракта.
События позволяют клиентским приложениям 
подписываться на них и реагировать на произошедшие изменения.
Например, web site может добавить на свою страницу новое задание,
получив такой event от blockchain 
при выполнении написанной нами ранее функции `issueBounty()`.

Еще одним примером является 
обновление списка входящих и исходящих транзакций
для некоторого контракта
на сервисе [etherscan][link-etherscan-example].

Более детально о событиях как конструкции языка Solidity
можно прочитать в [документации][doc-solidity-events].


Поскольку в функции `issueBounty()` 
нашего контракта `Bounties.sol`
состояние меняется,
мы сгенерируем событие `BountyIssued`. 
Для этого объявим его :

```
event BountyIssued(
    uint    bounty_id, // индекс задания в массиве
    address issuer   , // создатель задания, который внес в контракт средства для вознаграждения
    uint    amount   , // сумма гонорара
    string  data     ); // описание требований к заданию
```

Таким образом, событие `BountyIssued` 
передает клиентским приложениям следующую информацию
о свежесозданном контракте: 

* *bountyId:* - идентификатор нового задания
* *issuer:* - учетная запись пользователя, создавшего задание и оплатившего его
* *amount:* - сумма вознаграждения за исполнения задания (количество WEI)
* *data:* - строка с описанием требований к исполнению заданию

Добавим же генерацию события в функцию `issueBounty()`
```
bounties.push(
    Bounty(
        msg.sender, 
        _deadline, 
        _data, 
        BountyStatus.CREATED, 
        msg.value));
        
emit BountyIssued(            // добавленное событие
        bounties.length - 1,  // индекс нового задания в качестве идентификатора
        msg.sender,           // пользователь, финансирующий задание
        msg.value,            // размер гонорара
        _data);               // описание задания

return (bounties.length - 1);
```

После описанного выше добавления функции `issueBounty`
наш контракт `Bounties.sol` будет выглядеть примерно вот так :

```
pragma solidity ^0.5.0;
/**
* @title Bounties
* @author Joshua Cassidy- <joshua.cassidy@consensys.net>
* @dev Простой электронный контракт
* который позволяет любому пользователю
* оплатить криптовалютой "эфир"
* задание с четко определенными критериями приёмки
* награду может получить любой пользователь
* предоставивший доказательства исполнения задачи
*/

contract Bounties 
{

/*
* Множества (перечислимые типы)
*/
enum BountyStatus 
{ 
    CREATED  , // "создано" - новая задача, ожидающая иполнителя
    ACCEPTED , // "принято к исполнению" - исполнитель найден и утвержден
    CANCELLED  // "отменена" - работодатель больше не нуждается в данной услуге
}

/*
* Состояние, хранилище
*/
Bounty[] public bounties;

/*
* Структуры
*/
struct Bounty 
{
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


/**
* @dev Конструктор
*/
constructor() public 
{
}


/**
* @dev issueBounty(): создает новое задание и выделяет на него средства
* @param _deadline the unix timestamp after which fulfillments will no longer be accepted
* @param _data the requirements of the bounty
*/
function issueBounty(
    string memory _data, // описание работ
    uint64 _deadline     // срок исполнения 
    
) public   // функция может быть вызвана любым пользователем или другим контрактом в сети Ethereum
  payable  // при вызове этой функции контракт может получать эфир
           // полученный эфир будет храниться "на балансе" контракта
    hasValue()                  // проверяем, что при вызове контракту был отправлен эфир в ненулевом объеме.
    validateDeadline(_deadline) // проверяем, что крайний срок не исчерпан на момент задания
returns (uint)  // возвращает целое число - порядковый номер последнего добавленного задания
{
 bounties.push(
        Bounty(
            msg.sender, // адрес отправителя эфира, вызвавшего функцию. он же создатель нового задания.
            _deadline,  // срок исполнения. передан как параметр.
            _data,      // описание работ. передан как параметр.
            BountyStatus.CREATED, // статус "задача создана", исполнитель еще не назначен
            msg.value   // размер награды. 
                        // до выполнения задания сам эфир будет храниться в контракте.
                        // в структуру попадает только его количество
                        // измеряемое в WEI
        )
    );

    emit BountyIssued(            // добавленное событие
        bounties.length - 1,  // индекс нового задания в качестве идентификатора
        msg.sender,           // пользователь, финансирующий задание
        msg.value,            // размер гонорара
        _data);               // описание задания

    // отнимаем единицу, поскольку 
    // нумерация элементов массива начинается с нуля
    return (bounties.length - 1);
}

/**
* Модификаторы
* Проверка входных параметров
*/
modifier hasValue() 
{
    require(msg.value > 0); // проверяем, что контракт получил достаточно эфира
    _; // исполняем основную функцию
}

modifier validateDeadline(uint _newDeadline) 
{
    require(_newDeadline > now); // проверяем, что введенная дата не в прошлом. 
                                 // чтоб контракт не "забивался" бесполезными данными.
    _; // исполняем основную функцию
}

/**
* События-сообщения
*/
event BountyIssued(
        uint    bounty_id, 
        address issuer   , 
        uint    amount   , 
        string  data     );
}
```

## 7. Публикация контракта и взаимодействие с ним средствами Remix

И вот, наш контракт написан. 
А значит, мы, наконец, можем поместить его
в локальный тестовый мини-блокчейн внутри Remix IDE
в целях тестирования функции `issueBounty()`.

Первым делом, скомпилируем наш контракт `Bounties.sol`
и убедимся в отсутствии ошибок. 
Для этого нужно выбрать вкладку `"Compile"`
в правом верхнем углу экрана 
и запустить процесс компиляции 
нажатием на кнопку `"Start to Compile"`.

![screenshot: remix IDE compilation result with static warnings][screenshot-remix-static-warnings]

Как вы заметили, 
над результатом компиляции появилось сообщение
об ошибках, найденных при статическом анализе.
Среда Remix запускает при компиляции 
некоторые эвристики статического анализа,
позволяющие выявить известные уязвимости в коде контракта.
Также исправление этих ошибок поможет 
следовать общепринятым рекомендациям и правилам
качественной разработки кода контрактов.

Больше информации о статическом анализе в среде Remix 
можно найти [по ссылке][doc-remix-analyzer].

В рамках данного обучающего материала 
эти ошибки можно временно не принимать во внимание
и перейти непосредственно к публикации нашего контракта,
а также к его тестированию.

Для этого выберем вкладку `"Run"`
в правом верхнем углу экрана.
В выпадающем списке `"Environment"` 
следует выбрать вариант `"JavaScript VM"`
как показано на снимке экрана ниже.

![screenshot: ethereum environment drop-down][screenshot-virtual-machine-dropdown]

При использовании данной настройки
в браузере будет создана виртуальная машина
для блокчейна средствами JavaScript.
Таким образом, все взаимодействие с контрактом
будет происходить локально, не выходя за пределы
вашего компьютера и браузера.
Это очень полезно тем, что не требует установки
дополнительных программ на ваш компьютер
для знакомства с электронными контрактами.

Узнать больше об исполнении транзакций внутри Remix IDE
можно [из документации][doc-remix-javascript-vm]

На вкладке `"Run"` окружения Remix, 
выбрав окружение `"JavaScript VM"`,
нажмите на кнопку `"Deploy"`
как показано на снимке экрана ниже.

![screenshot: "deploy" button in the "run" tab][screenshot-remix-deploy-button]

Это действие выполнит транзакцию по публикации контракта
в блокчейн, работающий локально в браузре.
Подобные транзакции будут описаны подробней в последующих статьях.

В консоли среды `Remix`, 
расположенной прямо под областью редактирования кода, 

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

### 8. Try it yourself

Now that you have seen how to add a function to issue a bounty, try adding the following functions to the Bounties contract:

* `fulfilBounty(uint _bountyId, string _data)` This function should store a fulfilment record attached to the given bounty. The `msg.sender` should be recorded as the fulfiller.
* `acceptFulfilment(uint _bountyId, uint _fulfilmentId)` This function should accept the given fulfilment, if a record of it exists against the given bounty. It should then pay the bounty to the fulfiller.
* `function cancelBounty(uint _bountyId)` This function should cancel the bounty, if it has not already been accepted, and send the funds back to the issuer

Note: For `acceptFulfilment` you will need to use the `address.transfer(uint amount)` function to send the ETH to the `fulfiller`. You can read more about the [address.transfer member here] (https://solidity.readthedocs.io/en/latest/units-and-global-variables.html#address-related).

You can find the [complete Bounties.sol file here for reference] (https://github.com/kauri-io/kauri-fullstack-dapp-tutorial-series/blob/master/remix-bounties-smartcontract/Bounties-complete.sol).

## 9. Next Steps
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
[screenshot-remix-static-warnings]: https://api.beta.kauri.io:443/ipfs/QmPbH2hJxqjwyCbo7iLMovVQLZyb96V9EbzKkUhJnS4Eem
[screenshot-virtual-machine-dropdown]: https://api.beta.kauri.io:443/ipfs/QmdAgBc9WzFmE4GwKBxHkMRCBBdAapHP1Ym3dR8mS2atSF
[screenshot-remix-deploy-button]: https://api.beta.kauri.io:443/ipfs/QmerrAduWYrYaxMT5254xE5DjngDid81hgaVT32uqGt1qt

[link-semantic-versioning]: https://semver.org/
[link-unix-timestamp-wiki]: https://ru.wikipedia.org/wiki/UNIX-%D0%B2%D1%80%D0%B5%D0%BC%D1%8F 
[link-etherscan-example]: https://etherscan.io/address/0x69a70e299367ff4c3ba1fe8c93fbddd9b5b4771a

[doc-solidity-types]: http://solidity.readthedocs.io/en/latest/types.html
[doc-solidity-0.5.0-breaking]: https://solidity.readthedocs.io/en/v0.5.0/050-breaking-changes.html

[doc-solidity-function-visibility]: https://solidity.readthedocs.io/en/v0.4.24/contracts.html#visibility-and-getters
[doc-solidity-error-handling]: http://solidity.readthedocs.io/en/v0.4.24/control-structures.html#error-handling-assert-require-revert-and-exceptions
[doc-solidity-modifiers]: https://solidity.readthedocs.io/en/v0.4.24/common-patterns.html?highlight=modifier#restricting-access
[doc-solidity-events]: https://solidity.readthedocs.io/en/latest/contracts.html#events
[doc-remix-analyzer]: https://remix.readthedocs.io/en/latest/analysis_tab.html
[doc-remix-javascript-vm]: https://remix.readthedocs.io/en/latest/run_tab.html




