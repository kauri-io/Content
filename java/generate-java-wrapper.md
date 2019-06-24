Generate a Java Wrapper from your Smart Contract
===

In this article, we will discover how to generate a Java Class Wrapper directly from our smart contract in order to easily interract with a smart contract in pure Java.

Different methods exist to achieve the generation of a Smart Contract Java Wrapper:
- Web3j Command Line tool and solc
- Web3j Command Line tool and Truffle artefacts
- web3j-maven-plugin
- web3j-gradle-plugin

To illustrate the methods listed above, we will use the following Smart Contract which noratize documents into a registry on the Ethereum Blockchain.

*DocumentRegistry.sol*
```solidity
pragma solidity ^0.5.6;


/**
*  @dev Smart Contract resposible to notarize documents on the Ethereum Blockchain
*/
contract DocumentRegistry {

  struct Document {
      address signer; // Notary
      uint date; // Date of notarization
      bytes32 hash; // Document Hash
  }

  /**
   *  @dev Storage space used to record all documents notarized with metadata
   */
  mapping(bytes32 => Document) registry;

  /**
   *  @dev Notarize a document identified by its 32 bytes hash by recording the hash, the sender and date in the registry
   *  @dev Emit an event Notarized in case of success
   *  @param _documentHash Document hash
   */
  function notarizeDocument(bytes32 _documentHash) external returns (bool) {
    registry[_documentHash].signer = msg.sender;
    registry[_documentHash].date = now;
    registry[_documentHash].hash = _documentHash;

    emit Notarized(msg.sender, _documentHash);

    return true;
  }

  /**
   *  @dev Verify a document identified by its has was noterized in the registry previsouly.
   *  @param _documentHash Document hash
   *  @return bool if document was noterized previsouly in the registry
   */
  function isNotarized(bytes32 _documentHash) external view returns (bool) {
    return registry[_documentHash].hash ==  _documentHash;
  }

  /**
   *  @dev Definition of the event triggered when a document is successfully notarized in the registry
   */
  event Notarized(address indexed _signer, bytes32 _documentHash);
}
```

<br />

## Generate a Java Smart Contract Wrapper

### Web3j Command Line tool and solc

This first method consists to generate the Smart contract ABI and bytecode from **solc (Solidity Compiler)** and provide those two files as input to **web3j-cli** to generate the Java Wrapper.

<br />

**1. Install solc and verify the version**
Use the following [link](https://solidity.readthedocs.io/en/develop/installing-solidity.html) to install solc on your machine and run the command below to make sure solc version is greater or equals to `0.5.6` (version specified in the smart contract).

```shell
$ solc --version
solc, the solidity compiler commandline interface
Version: 0.5.9+commit.c68bc34e.Linux.g++
```

<br />

**2. Install web3j-cli**
To install web3j-cli, download the latest release package [here](https://github.com/web3j/web3j/releases).

Then unzip the package like this:

```shell
$ unzip web3j-4.3.0.zip
Archive:  web3j-4.3.0.zip
   creating: web3j-4.3.0/
   creating: web3j-4.3.0/lib/
  inflating: web3j-4.3.0/lib/console-4.3.0-all.jar
   creating: web3j-4.3.0/bin/
  inflating: web3j-4.3.0/bin/web3j
  inflating: web3j-4.3.0/bin/web3j.bat
```

And run the following command

```shell
$ ./web3j-4.3.0/bin/web3j version

              _      _____ _     _
             | |    |____ (_)   (_)
__      _____| |__      / /_     _   ___
\ \ /\ / / _ \ '_ \     \ \ |   | | / _ \
 \ V  V /  __/ |_) |.___/ / | _ | || (_) |
  \_/\_/ \___|_.__/ \____/| |(_)|_| \___/
                         _/ |
                        |__/

Version: 4.3.0
Build timestamp: 2019-05-09 06:48:01.876 UTC
```

*TODO move into PATH*

<br />

**3. Compile the smart contract with solc**

Given our Solidity file `DocumentRegistry.sol`, the following command `solc <sol> --bin --abi --optimize -o <output>` compiles the smart contract and generates in the same directory two files:
- **DocumentRegistry.bin**: Binary file, bytecode of the smart contract
- **DocumentRegistry.abi**: ABI (Application Binary Interface) of the smart contract which defines the interface in a JSON format.

```shell
$ solc DocumentRegistry.sol --bin --abi --optimize -o ./
Compiler run successful. Artifact(s) can be found in directory ./.

$ ls -l
total 12
-rw-rw-r-- 1 gjeanmart gjeanmart  565 Jun 24 13:42 DocumentRegistry.abi
-rw-rw-r-- 1 gjeanmart gjeanmart  676 Jun 24 13:42 DocumentRegistry.bin
-rw-rw-r-- 1 gjeanmart gjeanmart 1488 Jun 24 13:40 DocumentRegistry.sol
```

<br />

**4. Generate the Java Smart Contracy Wrapper with web3j-cli**

Using the solc result (ABI and bytecode) and web3j-cli (installed during step 2), it's now possible to generate our Smart conctract Java Wrapper with the following command

```shell
$ web3j solidity generate [-hV] [-jt] [-st] -a=<abiFile> [-b=<binFile>] -o=<destinationFileDir> -p=<packageName>

   -h, --help                        Show this help message and exit.
   -V, --version                     Print version information and exit.
   -jt, --javaTypes                  use native java types. Default: true
   -st, --solidityTypes              use solidity types.
   -a, --abiFile=<abiFile>           abi file with contract definition.
   -b, --binFile=<binFile>           optional bin file with contract compiled code in order to generate deploy methods.
   -o, --outputDir=<destinationFileDir> destination base directory.
   -p, --package=<packageName>       base package name.
```

For example:
```shell
$ web3j solidity generate -a DocumentRegistry.abi  -b DocumentRegistry.bin -o . -p me.gjeanmart.tutorials.javaethereum.wrapper

              _      _____ _     _
             | |    |____ (_)   (_)
__      _____| |__      / /_     _   ___
\ \ /\ / / _ \ '_ \     \ \ |   | | / _ \
 \ V  V /  __/ |_) |.___/ / | _ | || (_) |
  \_/\_/ \___|_.__/ \____/| |(_)|_| \___/
                         _/ |
                        |__/

Generating me.gjeanmart.tutorials.javaethereum.wrapper.DocumentRegistry ... File written to .
```

As a result, you should see the Java Wrapper file generated into the folder `<package_folders>/<contract>.java` that can be copied to the `src/main/java/` folder of your project.

```shell
./me/gjeanmart/tutorials/javaethereum/wrapper/DocumentRegistry.java
```

<br />

### Web3j Command Line tool and Truffle artefacts

[**Truffle**](https://www.trufflesuite.com/truffle) is one of the most well-known framework to develop, test and deploy with Ethereum. It is possible associate **Truffle** for the Smart Contract development and testing with **Web3j** to build the middleware client.

**1. Install Truffle**
Truffle comes as a npm package.

```shell
$ npm install truffle -g
- Fetching solc version list from solc-bin. Attempt #1
+ truffle@5.0.24
added 27 packages from 439 contributors in 11.636s

$ truffle version
Truffle v5.0.24 (core: 5.0.24)
Solidity v0.5.0 (solc-js)
Node v10.15.3
Web3.js v1.0.0-beta.37
```

<br />

**2. Initialise a new Truffle project**
To initialize a Truffle project, we will execute the command `truffle init` in a new folder. You should obtain a tree view composed of `contracts/`, `migration/`, `test/` and `truffle-config.js`.

```shell
$ mkdir truffle
$ cd truffle
$ truffle init

✔ Preparing to download
✔ Downloading
✔ Cleaning up temporary files
✔ Setting up box

Unbox successful. Sweet!

Commands:

  Compile:        truffle compile
  Migrate:        truffle migrate
  Test contracts: truffle test

$ ls -l
total 20
drwxrwxr-x 2 gjeanmart gjeanmart 4096 Jun 24 14:25 contracts
drwxrwxr-x 2 gjeanmart gjeanmart 4096 Jun 24 14:25 migrations
drwxrwxr-x 2 gjeanmart gjeanmart 4096 Jun 24 14:25 test
-rw-rw-r-- 1 gjeanmart gjeanmart 4233 Jun 24 14:25 truffle-config.js
```

<br />

**3. Add the contract into the folder `contracts`**
Copy the Smart Contract source `DocumentRegistry.sol` into the folder `contracts`.

<br />

**4. Compile the contract**

Compile the smart contract with the command `truffle compile`, in case of success, this command generate a new folder `build/contracts/` containing a Truffle artefact for each Smart contract compiled.

```shell
$ truffle compile

Compiling your contracts...
===========================
> Compiling ./contracts/DocumentRegistry.sol
> Compiling ./contracts/Migrations.sol
> Artifacts written to /home/gjeanmart/workspace/tutorials/java-ethereum-wrapper/truffle/build/contracts
> Compiled successfully using:
   - solc: 0.5.8+commit.23d335f2.Emscripten.clang

$ ls -l build/contracts/
total 136
-rw-rw-r-- 1 gjeanmart gjeanmart 79721 Jun 24 14:33 DocumentRegistry.json
-rw-rw-r-- 1 gjeanmart gjeanmart 54043 Jun 24 14:33 Migrations.json
```

<br />

**5. Generate the Smart Contract Java Wrapper from the Truffle Artefact**

FInally, web3j-cli provides a way to generate the Smart Contract Java Wrapper directly from the Truffle artefact result of `truffle compile`.

```shell
$ web3j  truffle generate ./build/contracts/DocumentRegistry.json -o . -p me.gjeanmart.tutorials.javaethereum.wrapper

              _      _____ _     _
             | |    |____ (_)   (_)
__      _____| |__      / /_     _   ___
\ \ /\ / / _ \ '_ \     \ \ |   | | / _ \
 \ V  V /  __/ |_) |.___/ / | _ | || (_) |
  \_/\_/ \___|_.__/ \____/| |(_)|_| \___/
                         _/ |
                        |__/

Generating me.gjeanmart.tutorials.javaethereum.wrapper.DocumentRegistry ... File written to .
```

As a result, you should see the Java Wrapper file generated into the folder `<package_folders>/<contract>.java` that can be copied to the `src/main/java/` folder of your project.

```shell
./me/gjeanmart/tutorials/javaethereum/wrapper/DocumentRegistry.java
```

*Note: With Truffle you can do a lot more: Deployment script (migration), Multi-network configuration, testing, debugging. I recommand reading [the following guide](https://kauri.io/collection/5b8e401ee727370001c942e3) to learn more about all the features.*


<br />

### web3j-maven-plugin

The next solution is more elegant than the two precendent because you don't have to install webj-cli and copy the file to your source folder. This part can be done directly inside your java project using Maven and the plugin [**web3j-maven-plugin**](https://github.com/web3j/web3j-maven-plugin).

After having created a Maven project (see article-1).

**1. Prerequisite**

- solc (Solidity Compiler): Use the following [link](https://solidity.readthedocs.io/en/develop/installing-solidity.html) to install solc on your machine and run the command below to make sure solc version is greater or equals to `0.5.6` (version specified in the smart contract).

```shell
$ solc --version
solc, the solidity compiler commandline interface
Version: 0.5.9+commit.c68bc34e.Linux.g++
```

<br />

**2. Place the smart contract into the folder `src/main/resources`**

<br />

**3. Configure Maven to generate the Wrapper during the phase `generate-sources`**

In the next step, we will configure two Maven plugins:

- ***web3j-maven-plugin***:
The first plugin is doing exactly the same operation as the two previous methods but in an automated and integrated with Maven.
First of all, we configure the plugin to be executed automaticaly when entering on phase `generate-sources` of the project.
Secondly we configure the plugin parameters:
    - *packageName*: Package name to apply to the generated Java Wrapper classes
    - *sourceDestination*: Target destination folder to move the generated  Java Wrapper classes
    - *soliditySourceFiles*: Place where to find the Smart Contract source files


- ***build-helper-maven-plugin***
The second plugin is simply used to add the *sourceDestination* folder into the classpath so we can import the generated Java Wrapper classes

<br />

*pom.xml*
```xml
    <build>
        <plugins>
            <plugin>
                <groupId>org.web3j</groupId>
                <artifactId>web3j-maven-plugin</artifactId>
                <version>4.2.0</version>
                <executions>
                    <execution>
                        <id>generate-sources-web3j</id>
                        <phase>generate-sources</phase>
                        <goals>
                            <goal>generate-sources</goal>
                        </goals>
                        <configuration>
                            <packageName>me.gjeanmart.tutorials.javaethereum.contracts.generated</packageName>
                            <sourceDestination>${basedir}/target/generated-sources/contracts</sourceDestination>
                            <soliditySourceFiles>
                                <directory>${basedir}/src/main/resources</directory>
                                <includes>
                                    <include>**/*.sol</include>
                                </includes>
                            </soliditySourceFiles>
                        </configuration>
                    </execution>
                </executions>
            </plugin>

            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>build-helper-maven-plugin</artifactId>
                <executions>
                    <execution>
                        <id>add-source</id>
                        <phase>generate-sources</phase>
                        <goals>
                            <goal>add-source</goal>
                        </goals>
                        <configuration>
                            <sources>
                                <source>${basedir}/target/generated-sources/contracts</source>
                            </sources>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```

**4. Run Maven generate-sources**

The last step simply consist to build our Maven project using for example `mvn clean package` (include generate-sources phase). As a result, we can see the Java Wrapper has been generated into `/target/generated-sources/contracts/me/gjeanmart/tutorials/javaethereum/contracts/generated/DocumentRegistry.java` and added to the classpath automatically.


![](https://imgur.com/nBMOWGq.png)

<br />

### web3j-gradle-plugin


*build.gradle*
```gradle
/*
 * This file was generated by the Gradle 'init' task.
 *
 * This generated file contains a sample Java Library project to get you started.
 * For more details take a look at the Java Libraries chapter in the Gradle
 * user guide available at https://docs.gradle.org/5.0/userguide/java_library_plugin.html
 */

plugins {
    // Apply the java-library plugin to add support for Java Library
    id 'java-library'
    id 'org.web3j' version '4.3.0'
}

repositories {
    // Use jcenter for resolving your dependencies.
    // You can declare any Maven/Ivy/file repository here.
    jcenter()
}

dependencies {
    // This dependency is exported to consumers, that is to say found on their compile classpath.
    api 'org.apache.commons:commons-math3:3.6.1'

    // This dependency is used internally, and not exposed to consumers on their own compile classpath.
    implementation 'com.google.guava:guava:26.0-jre'
    implementation 'org.web3j:core:4.3.0'

    // Use JUnit test framework
    testImplementation 'junit:junit:4.12'
}

web3j {
    generatedPackageName = 'me.gjeanmart.tutorials.javaethereum.contracts.generated'
    generatedFilesBaseDir = "$buildDir/contracts"
}

```

![](https://imgur.com/dA0sVy1.png)

<br />

## Use the generated Java Smart Contract Wrapper




<br />
