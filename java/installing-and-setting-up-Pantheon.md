# Using Pantheon, the Java Ethereum Client with Linux

![Toolbelt: pantheon included!](https://i.imgur.com/kxP76k9.jpg)
Original photo by jesse Orrico

This is the first article of a 3-part series on installing Pantheon, the Java client for Ethereum:

1.  [Linux](#)
2.  macOS
3.  Windows

Having some powerful tools in your toolbelt is essential for a Java developer, and one of the crucial tools for an Ethereum blockchain developer is the network client. This is the piece of software that actually communicates data to and from the blockchain. Among other things, you use the client to: spin up nodes, act as a peer discovery agent to see who else is participating in the network and validate and send transactions. This guide helps you install and setup this core tool you need for programming on Ethereum with Java. Although there are some great networking clients out there, Pantheon is the only one written in Java.

Pantheon is an open-source, Apache 2.0 licensed Ethereum client written in Java. It is mainnet compatible, has a modular architecture, and has privacy and permissioning features as well as new consensus algorithms.

This is the first of a series of step-by-step guides to install and configure the Pantheon client on Linux/macOS/Windows. This guide focuses on Linux operating system, but you can use many of the commands and steps on macOS with some basic modifications.

## Before Getting started - Docker

Before installing, I would suggest anyone wanting to setup and install Pantheon for the first time to try it out using the [Docker images provided in the Pantheon documentation](http://docs.pantheon.pegasys.tech/en/stable/Getting-Started/Run-Docker-Image/). The only requirements are having [Docker installed](https://docs.docker.com/v17.12/install/linux/docker-ce/ubuntu/) and using Linux or macOS.
A single docker command can run a mainnet, local, rinkeby or websockets version of Pantheon, and use [`curl`](https://curl.haxx.se/) or similar tools to get or send data to the running node.

> For quick, temporary tests this guide uses `/tmp/pantheon/dev/`, `/tmp/pantheon/mainnet/`, `/tmp/pantheon/rinkeby/` as suitable options and are automatically cleaned at every boot. You can create other folders instead, but whichever option you choose, make sure you create the folders first.

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

-   [Installing the binary distribution](http://docs.pantheon.pegasys.tech/en/stable/Installation/Install-Binaries/#linux-unix-windows-without-chocolatey)
    For binary installation, [follow along to this section](#binary-install) and skip the next.
-   [Building from source](http://docs.pantheon.pegasys.tech/en/stable/Installation/Install-Binaries/#linux-unix-windows-without-chocolatey)
    For Source install, [skip to this section](#build-from-source).

> **Requirements**: For both of these methods, Pantheon needs the Java JDK to be installed on your machine. Current versions of Pantheon require Java JDK 11+ installed.

### Binary install

Remember to have 4GB RAM if running a private network, and [review further requirements](http://docs.pantheon.pegasys.tech/en/stable/Installation/Overview/#disk-space-and-ram-requirements) for other installation types.

1.  Download the Pantheon binaries](<https://bintray.com/consensys/pegasys-repo/pantheon/_latestVersion#files>).

    We can use `wget` to do this.

        $ sudo apt install wget
        $ cd ~/bin/
        $ wget   https://bintray.com/consensys/pegasys-repo/download_file?file_path=pantheon-1.1.4.tar.gz -O pantheon-1.1.4.tar.gz
        $ wget https://bintray.com/consensys/pegasys-repo/download_file\?file_path\=pantheon-1.1.4.tar.gz -O pantheon-1.1.4.tar.gz

> `$HOME/bin/` and `$HOME/.local/{bin,opt,usr}` are the best possible install folders for local user binaries that will be used by a single user. Other options are available such as `/opt/local/` or `/usr/local/bin/` depending on your local setup and preference. [See here for more details](https://unix.stackexchange.com/questions/36871/where-should-a-local-executable-be-placed).

2.  Unpack the compressed file:


    $ tar -xzf pantheon-1.1.4.tar.gz
    $ cd pantheon-1.1.4

> Replace 1.1.4 with whichever release you have downloaded.

3.  Confirm the download isn't corrupted and check the version.


    $ bin/pantheon --help
    $ bin/pantheon --version

The output should return the pantheon and java jdk version.

    $ bin/pantheon --version
    pantheon/v1.1.4/linux-x86_64/oracle_openjdk-java-11
    $ bin/pantheon --help

### Build from Source

Two options are available here; [installing and running locally](http://docs.pantheon.pegasys.tech/en/stable/Installation/Build-From-Source/#installation-on-linux-unix-mac-os-x) or [on a VM](http://docs.pantheon.pegasys.tech/en/stable/Installation/Build-From-Source/#installation-on-vm).
This guide will focus on the local running solution.

1.  Clone the Pantheon codebase


    $ cd ~/bin/
    $ git clone --recursive https://github.com/PegaSysEng/pantheon.git

2.  Build Pantheon


    $ cd pantheon/
    $ ./gradlew build -x test

3.  Choose distribution version and check version.


    $ cd build/distributions/
    $ tar -xzf pantheon-1.1.4.tar.gz
    $ cd pantheon-1.1.4/
    $ bin/pantheon --version
    $ bin/pantheon --help

## Config

In reality, no additional configuration is necessary for Pantheon to run correctly.
Each different network type (including mainnet) determined by command line flags will automatically load the appropriate default configuration.

If the settings have to be changed, these options are either configured at Node or Network-level.
Network-level settings are defined in the genesis file and will be loaded by very Node connected to that specific network. Whereas Node-level settings are modified either in the node configuration file, or through the command line flags.

For more information on configuration, [check out the corresponding documentation](http://docs.pantheon.pegasys.tech/en/stable/Configuring-Pantheon/Network-vs-Node/).

## Starting Pantheon

After the above steps are done, you can continue using this distribution with the [regular Starting Pantheon guide](http://docs.pantheon.pegasys.tech/en/stable/Getting-Started/Starting-Pantheon/).

* * *

Be sure to check out our next guide on installing Pantheon on macOS.
