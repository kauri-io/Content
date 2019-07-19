# Using Pantheon, the Java Ethereum Client with Linux

![Toolbelt: Pantheon included!](https://i.imgur.com/LhdU0DH.jpg)
Original photo by Jesse Orrico

This is the first article of a 3-part series on installing Pantheon, the Java client for Ethereum:

1.  [Linux](#)
2.  macOS
3.  Windows

Having some powerful tools in your toolbelt is essential for a Java developer, and one of the crucial tools for an Ethereum blockchain developer is the network client. This is the piece of software that communicates data to and from the blockchain. Among other things, the client: spins up nodes, acts as a peer discovery agent to see who else is participating in the network and validates and sends transactions.

This guide helps you install and setup this core part you need for programming on Ethereum with Java. Although there are some great networking clients out there, Pantheon is the only one written in Java.

Pantheon is an open-source, Apache 2.0 licensed Ethereum client written in Java. It is mainnet compatible, has a modular architecture, and has privacy and permissioning features as well as new consensus algorithms.

This is the first of a series of step-by-step guides to install and configure the Pantheon client on Linux/macOS/Windows. This guide focuses on Linux operating system, but you can use many of the commands and steps on macOS with some basic modifications.

## Try Pantheon with Docker

Before installing, I would suggest anyone wanting to setup and install Pantheon for the first time to try it out using our [Docker images](http://docs.pantheon.pegasys.tech/en/stable/Getting-Started/Run-Docker-Image/). The requirements to do so are having [Docker installed](https://docs.docker.com/v17.12/install/linux/docker-ce/ubuntu/) and using Linux or macOS.
You can use a single docker command to run a mainnet, local or rinkeby version of Pantheon, and then use [`curl`](https://curl.haxx.se/) or similar tools to get or post data to the running node.

> For quick, temporary tests this guide uses `/tmp/pantheon/dev/`, `/tmp/pantheon/mainnet/`, `/tmp/pantheon/rinkeby/` as mount volumes, which are automatically cleaned at every boot. You can create other folders instead, but whichever option you choose, make sure you create the folders first.

```shell
$ mkdir -p /tmp/pantheon/dev/
$ mkdir -p /tmp/pantheon/mainnet/
$ mkdir -p /tmp/pantheon/rinkeby/
```

Here are some examples:

Mainnet Node:

```shell
docker run pegasyseng/pantheon:latest
```

Local test Node with Websockets and HTTP RPC services enabled:

```shell
docker run -p 8545:8545 -p 8546:8546 --mount type=bind,source=/tmp/pantheon/dev,target=/var/lib/pantheon pegasyseng/pantheon:latest --miner-enabled --miner-coinbase fe3b557e8fb62b89f4916b721be55ceb828dbd73 --rpc-http-cors-origins="all" --rpc-ws-enabled --network=dev
```

Rinkeby Node:

```shell
docker run -p 30303:30303 --mount type=bind,source=/tmp/pantheon/rinkeby,target=/var/lib/pantheon pegasyseng/pantheon:latest --network=rinkeby
```

While the node is running, you can use another terminal window to interact with the node.

![](https://i.imgur.com/kw1VHDs.png)

For example, using `curl` to call the `eth_chainId` RPC method:

```shell
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' localhost:8545
```

* * *

## Getting started with Linux

Two installation methods are available:

-   [Installing the binary distribution](http://docs.pantheon.pegasys.tech/en/stable/Installation/Install-Binaries/)
    For binary installation, [follow along to this section](#binary-install) and skip the next.
-   [Building from source](http://docs.pantheon.pegasys.tech/en/stable/Installation/Build-From-Source/)
    For building from source, [skip to this section](#build-from-source).

> **Requirements**: For both of these methods, Pantheon needs the Java JDK installed on your machine. Current versions of Pantheon require Java JDK 11+ installed.

### Binary install

Remember to have at least 4GB of RAM if running a private network, and [review  the further requirements](http://docs.pantheon.pegasys.tech/en/stable/Installation/Overview/#disk-space-and-ram-requirements) for other installation types.

1.  [Download the Pantheon binaries](https://bintray.com/consensys/pegasys-repo/pantheon/_latestVersion#files).

You can use `wget` to do this.

```shell
$ sudo apt install wget
$ cd ~/bin/
$ wget   https://bintray.com/consensys/pegasys-repo/download_file?file_path=pantheon-1.1.4.tar.gz -O pantheon-1.1.4.tar.gz
$ wget https://bintray.com/consensys/pegasys-repo/download_file\?file_path\=pantheon-1.1.4.tar.gz -O pantheon-1.1.4.tar.gz
```

> `$HOME/bin/` and `$HOME/.local/{bin,opt,usr}` are the recommended install folders for local user binaries on machines used by a single user. Other options are available such as `/opt/local/` or `/usr/local/bin/` depending on your local setup and preference. [Read this Stack Exchange thread for more details](https://unix.stackexchange.com/questions/36871/where-should-a-local-executable-be-placed).

2.  Unpack the compressed file:

```shell
$ tar -xzf pantheon-1.1.4.tar.gz
$ cd pantheon-1.1.4
```

> Replace 1.1.4 with whichever release you downloaded.

3.  Confirm the download isn't corrupted and check the version .The output should return the Pantheon and JDK version.

```shell
$ bin/pantheon --version
pantheon/v1.1.4/linux-x86_64/oracle_openjdk-java-11
```

### Build from Source

Two options are available: [installing and running locally](http://docs.pantheon.pegasys.tech/en/stable/Installation/Build-From-Source/#installation-on-linux-unix-mac-os-x) or [on a VM](http://docs.pantheon.pegasys.tech/en/stable/Installation/Build-From-Source/#installation-on-vm).

This guide focuses on the local solution.

1.  Clone the Pantheon codebase

```shell
$ cd ~/bin/
$ git clone --recursive https://github.com/PegaSysEng/pantheon.git
```

2.  Build Pantheon

```shell
$ cd pantheon/
$ ./gradlew build -x test
```

3.  Choose distribution version and check version.

```shell
$ cd build/distributions/
$ tar -xzf pantheon-1.1.4.tar.gz
$ cd pantheon-1.1.4/
$ bin/pantheon --version
$ bin/pantheon --help
```

## Config

No additional configuration is necessary for Pantheon to run correctly.
Each different network type (including mainnet) set by the `--network` command line flags automatically loads the appropriate default configuration.

If you need to change the settings, these options are either configured at Node or Network-level.
Network-level settings are defined in the genesis file and are loaded by every Node connected to that specific network. Whereas Node-level settings are modified either in the node configuration file, or through command line flags.

For more information on configuration, [read the corresponding documentation](http://docs.pantheon.pegasys.tech/en/stable/Configuring-Pantheon/Network-vs-Node/).

## Starting Pantheon

After you have completed the above steps, you can continue using this distribution with the [regular Starting Pantheon guide](http://docs.pantheon.pegasys.tech/en/stable/Getting-Started/Starting-Pantheon/).

For a quick preview, this could be an HTTP request on a `dev` network Node running with docker.

```shell
$ docker run -p 8545:8545 --mount type=bind,source=/tmp/pantheon/dev,target=/var/lib/pantheon pegasyseng/pantheon:latest --miner-enabled --miner-coinbase fe3b557e8fb62b89f4916b721be55ceb828dbd73 --rpc-http-cors-origins="all" --rpc-http-enabled --network=dev
```

This is how you build a request calling the `eth_chainId` method.

```java
String payload='{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}';
String requestUrl="http://localhost:8545";
sendRequest(requestUrl, payload);
```

And the method implementation:

```java
public static String sendRequest(String requestUrl, String payload) {
    try {
        URL url = new URL(requestUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        connection.setDoInput(true);
        connection.setDoOutput(true);
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept", "application/json");
        connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        OutputStreamWriter outputWriter = new OutputStreamWriter(connection.getOutputStream(), "UTF-8");

        outputWriter.write(payload);
        outputWriter.close();

        BufferedReader buffer = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuffer jsonString = new StringBuffer();
        String line;
        while ((line = buffer.readLine()) != null) {
                jsonString.append(line);
        }
        buffer.close();

        connection.disconnect();
        return jsonString.toString();
    } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
    }
}
```

That request should return the following result:

```json
{
  "jsonrpc" : "2.0",
  "id" : 1,
  "result" : {
    "startingBlock" : "0x0",
    "currentBlock" : "0x2d0",
    "highestBlock" : "0x66c0"
  }
}
```

Fine more information in the [Pantheon documentation](http://docs.pantheon.pegasys.tech/en/stable/).
