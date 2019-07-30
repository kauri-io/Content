# Running a Pantheon Node in Java Integration Tests

The first problem you are likely to meet when attempting to write integration tests for your java Ethereum application is that you need a running node to connect to for sending transactions.  One option to overcome this is to manually run a node yourself in the background, but this becomes hard to manage if you want to run your tests in a CI pipeline, and forcing all contributors to you codebase to run a node manually is not ideal.  Luckily there's a better way!

## Running a Node with Testcontainers

[Testcontainers](https://www.testcontainers.org/) is a useful library that allows you to fire up a Docker container programmatically within your test code, and there are a number of Ethereum clients that have ready-made Docker containers uploaded to Dockerhub, which makes this task easier.

In this guide, I describe how to start and shutdown a [Pantheon](https://github.com/PegaSysEng/pantheon) node during your integration tests, so you don't have to start a node manually or within your CI pipeline

## Including the Testcontainers library

The Testcontainers library dependency can be obtained via maven central, so to include the library, add the following dependency to your `pom.xml` (or equivalent in Gradle):

```xml
<dependency>
    <groupId>org.testcontainers</groupId>
    <artifactId>testcontainers</artifactId>
    <version>1.12.0</version>
    <scope>test</scope>
</dependency>
```
## Starting Pantheon

Its preferential and more performant to start Pantheon once before all tests execute, rather than before every test.  To acheive this behaviour we will instantiate a static `GenericContainer` annotated with a `@ClassRule` JUnit annotation.

_ClassRule_

```java
@ClassRule
public static final GenericContainer pantheonContainer =
        new GenericContainer("pegasyseng/pantheon:1.1.3")
                .withExposedPorts(8545, 8546)
                .withCommand(
                        "--miner-enabled",
                        "--miner-coinbase=0xfe3b557e8fb62b89f4916b721be55ceb828dbd73",
                        "--rpc-http-enabled",
                        "--rpc-ws-enabled",
                        "--network=dev")
                .waitingFor(Wait.forHttp("/liveness").forStatusCode(200).forPort(8545));
}
```

The `GenericContainer` is instantiated, with a docker image name as an argument.  We're using the 1.1.3 version of Pantheon in this instance.  The standard default ports for http and websocket RPC are exposed with the `withExposedPorts(..)` method.

A number of runtime command arguments are set, which configure the node in a way that is suitable for testing:

**--miner-enabled:** We need to enable mining so that the transactions that we send within our tests are actually included within blocks.

**--miner-coinbase:** Set the coinbase to be an account that you have a private key for.  This is mandatory when mining is enabled, so here we set the account to be the well known Pantheon dev account, which is automatically loaded with Ether when in dev mode.

**--rpc-http-enabled:** Enable the http RPC endpoint, so Web3j can connect.

**--rpc-ws-enabled:** Enable the websocket RPC endpoint.  This is not required if only http is being tested.

**--network=dev:** The network type is set to `dev`.  This starts a private development node, with a pre-defined configuration to make mining very easy, to be easier on CPU usage.

For a full list of all available Pantheon commands, see the official documentation [here](https://docs.pantheon.pegasys.tech/en/stable/Reference/Pantheon-CLI-Syntax/).

### Waiting for Pantheon to Start

Finally, we must wait for Pantheon to fully start before running our tests.  Luckily, Pantheon comes autoconfigured with a liveness endpoint out of the box, so testcontainers is instructed to automatically poll the `/liveness` endpoint on port `8545` until a 200 response is returned.  We can then be confident that Pantheon is running correctly.

## Connecting to the Pantheon container using Web3j

Pantheon should now be up and running on `localhost`.  You can now connect to the Pantheon node within your test classes, and perform Ethereum operations such as sending transactions by using Web3j:

```java
final Integer port = pantheonContainer.getMappedPort(8545);
Web3j web3j = Web3j.build(new HttpService(
        "http://localhost:" + port), 500, Async.defaultExecutorService());

Credentials credentials = Credentials.create("0x8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63");
```

### Mapped Port

The default JSON RPC port, 8545, was exposed when creating the container, but it was not mapped to the same port on localhost.  A random available port is automatically selected instead, which is beneficial because it removes the chance of the port not being open on your test machine (which could happen if you are running the tests in parallel for example).

To obtain the mapped port number, simply call the `getMappedPort(..)` method on the container.  This port should then be used when constructing the Web3j connection url.

### Polling Interval

By default, Web3j polls the connected Ethereum client every 10 seconds for operations such as getting the latest mined blocks and checking if events have been emitted.  Our Pantheon test network will generally create blocks much faster than every 10 seconds so reducing the poll interval in Web3j should increase the speed of the tests.  The poll interval can be passed to the `Web3j.build` static method, and here we are configuring the interval to be 500ms.

### Test Credentials

Sending transactions in the private dev network still requires gas, so we must have access to an account with a positive balance.  This has been thought out, and the development network has a number of accounts that are pre-loaded with more test Ether than you could ever need!  The private keys of these accounts are well known and are documented [here](https://docs.pantheon.pegasys.tech/en/stable/Configuring-Pantheon/Accounts-for-Testing/), which makes it easy to generate a `Credentials` object for use in your tests.

## Stopping Pantheon / Web3j

As we're using a `@ClassRule` annotation, the stopping of the Pantheon container will be handled automatically at the end of the test class execution.  Its a good idea to shutdown the web3j instance after each test though:

```java
@After
public void shutdownWeb3j() {
    web3j.shutdown();
}
```

## Summary

Using the Testcontainers library to start an Pantheon node is a simple and convenient way to ensure that an Ethereum node is accessible to your tests.  This makes running the tests in your continuous integration pipeline less arduous, and also means that other third party contributors can run your tests on their local machine more easily.

An example test class demonstrating the code described in this tutorial can be found [here](https://github.com/kauri-io/java-web3j-pantheon-testing/blob/master/src/test/java/io/kauri/java/test/TestWeb3jPantheon.java), from the [java-web3j-pantheon-testing](https://github.com/kauri-io/java-web3j-pantheon-testing) project.

