# Running a Pantheon Node in Java Integration Tests

The first snag you'll come up against when attempting to write integration tests for your java Ethereum application is that you'll need a running node to connect to for sending transactions.  One option to overcome this is to manually run a node yourself in the background, but this becomes hard to manage if you want to run your tests in a CI pipeline, and forcing all contributors to you codebase to run a node manually is not ideal.  Luckily theres a better way!

# Running a Node with Testcontainers

Testcontainers is a super useful library that allows you to fire up a Docker container programmatically within your test code.  Luckily, there are a number of Ethereum clients that have ready-made Docker containers uploaded to Dockerhub, which makes this task even easier.

In this guide, I'll describe how to start and shutdown a [Pantheon](https://github.com/PegaSysEng/pantheon) node during your integration tests, so that you do not have to be concerned with starting a node manually or within your CI pipeline

## Starting Pantheon

```
private static FixedHostPortGenericContainer pantheonContainer;

@BeforeClass
public static void startPantheon() throws InterruptedException {
        pantheonContainer = new FixedHostPortGenericContainer("pegasyseng/pantheon:latest");
        pantheonContainer.waitingFor(Wait.forListeningPort());

        pantheonContainer
                .withFixedExposedPort(8545, 8545)
                .withFixedExposedPort(8546, 8546)
                .withEnv("MINER_ENABLED", "true")
                .withEnv("MINER_COINBASE", "00a329c0648769a73afac7f9381e08fb43dbea72")
                .withEnv("RPC_HTTP_ENABLED", "true")
                .withEnv("RPC_WS_ENABLED", "true")
                .withEnv("NETWORK", "dev")
                .start();

        waitForPantheonToStart(10000, Web3j.build(new HttpService("http://localhost:8545")));
}
```

Its preferential and more performant to start Pantheon once before all tests execute, rather than before every test, which is why this method is static, with the `@BeforeClass` JUnit annotation.

A `FixedHostPortGenericContainer` is instantiated, which takes a docker image name as an argument.  We're using the latest release version of Pantheon in this instance.  The standard default ports for http and websocket RPC ports are exposed with the `withFixedExposedPort(..)` method.

A number of environment variables are set, to configure the node to be suitable for testing:

**MINER_ENABLED:** We need to enable mining so that the transactions that we send within our tests are actually included within blocks.

**MINER_COINBASE:** Set the coinbase to be an account that you have a private key for.  This is so that the account will actually have some Ether to pay for the gas fees needed to send transactions.  Here we have set the address to be the well known Parity dev account.

**RPC\_HTTP\_ENABLED:** Enable the http RPC endpoint, so Web3j can connect.

**RPC\_WS\_ENABLED:** Enable the websocket RPC endpoint.  This is not required if only http is being tested.

**NETWORK:** The network type is set to `dev`.  This starts a private development node, with a pre-defined configuration to make mining very easy, to be easier on CPU usage.

## Waiting for Pantheon to Start

```
private static void waitForPantheonToStart(long secondsToWait, Web3j web3j) {
    Awaitility
            .await()
            .atMost(secondsToWait, TimeUnit.SECONDS)
            .until(() -> {
                try {
                    //Wait for one block to mine so the miner account has some eth...
                    if (web3j.ethBlockNumber().send().getBlockNumber().intValue() > 0) {
                        return true;
                    }

                    return false;
                } catch (Throwable t) {
                    //If an error occurs, the node is not yet up
                    return false;
                }
            });
}
```
We need to ensure that Pantheon is up and running before the tests begin executing.  To do this, the [Awaitility](`https://github.com/awaitility/awaitility`) library is used to continuously poll the node to obtain the latest block number until a successful response is received.  We actually wait until the block number is greater than zero as this means a block has been mined so we can guarantee that our test account (the miner coinbase) has some ether to use within the tests.

## Stopping Pantheon

Stopping the Pantheon container is a simple one-liner, which is again performed in a static method, with an @AfterClass annotation, so that it is executed after all tests have finished.

```
@AfterClass
private static void stopPantheon() {
    pantheonContainer.stop();
}
```

## Summary

Using the Testcontainers library to start an Pantheon node is a simple and convenient way to ensure that an Ethereum node is accessible to your tests.  This will make running the tests in your continuous integration pipeline less arduous, and also make it easier for other third party contributors to run your tests on their local machine.

