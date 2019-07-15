# Installing & Configuring the Pantheon Client on Linux

Pantheon is an open-source, Apache 2.0 licensed Ethereum client written in Java. It is mainnet compatible, has a modular architecture, and has privacy and permissioning features as well as new consensus algorithms.


This is the first of a series of step-by-step guides to install and configure the Pantheon client on Linux/Mac/Windows.
This guide will focus on Linux operating system, but many of the commands and steps can be reproduced on MacOS with some basic modifications.


## Before Getting started

Before even installing, I would suggest anyone wanting to setup and install Pantheon for the first time to try it out without any setup using the [quickstart provided at the Pantheon documentation site](http://docs.pantheon.pegasys.tech/en/stable/Getting-Started/Run-Docker-Image/). The only requirements needed to do so, are having [Docker installed](https://docs.docker.com/v17.12/install/linux/docker-ce/ubuntu/) and using Linux or MacOS.
A single docker command can be used to run a mainnet, local, rinkeby or websockets version of Pantheon in order to call [`curl`](https://curl.haxx.se/) or other tools to get or send data to the running node.

These are some of the current examples:

> For quick, temporary tests this guide uses `/tmp/pantheon/dev/`, `/tmp/pantheon/mainnet/`, `/tmp/pantheon/rinkeby/` as suitable options and will automatically be cleaned at every boot.

```
$ mkdir /tmp/pantheon/dev/
$ mkdir /tmp/pantheon/mainnet/
$ mkdir /tmp/pantheon/rinkeby/
```

Mainnet Node:

`docker run pegasyseng/pantheon:latest`

Local test Node with Websockets and HTTP RPC services enabled:

`docker run -p 8545:8545 -p 8546:8546 --mount type=bind,source=/tmp/pantheon/testnode,target=/var/lib/pantheon pegasyseng/pantheon:latest --miner-enabled --miner-coinbase fe3b557e8fb62b89f4916b721be55ceb828dbd73 --rpc-http-cors-origins="all" --rpc-ws-enabled --network=dev`


Rinkeby Node:

`docker run -p 30303:30303 --mount type=bind,source=/tmp/pantheon/rinkeby,target=/var/lib/pantheon pegasyseng/pantheon:latest --network=rinkeby`

> **Note:** In the above examples, `/tmp/pantheon/testnode` must be replaced by the local folder where data will be stored. This must also be an existing folder.

While the node is running, another terminal window can be used to interact with the node.

![](https://i.imgur.com/kw1VHDs.png)

Using `curl` to call `eth_chainId` RPC method:

`curl -X POST --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' localhost:8545`

---

## Getting started

Two forms of installation are available;

* [Installing the binary distribution](http://docs.pantheon.pegasys.tech/en/stable/Installation/Install-Binaries/)
* [Building from source](http://docs.pantheon.pegasys.tech/en/stable/Installation/Build-From-Source/)

### Binary install

Remember to have 4GB RAM if running a private network, and 8GB of RAM if running mainnet or a public test network and at least 2TB for the full blockchain mainnet archive sync.

> **Requirements**: Pantheon needs the Java JDK to be previously installed on your machine. To be prepared for future versions of Pantheon, it is recommended to have Java JDK 11+ installed.

1. `[Download the Pantheon binaries](https://bintray.com/consensys/pegasys-repo/pantheon/_latestVersion#files).

  We can use `wget` to do this.
  ```
  $ sudo apt install wget
  $ cd ~/bin/
  $ wget   https://bintray.com/consensys/pegasys-repo/download_file?file_path=pantheon-1.1.4.tar.gz -O pantheon-1.1.4.tar.gz
  $ wget https://bintray.com/consensys/pegasys-repo/download_file\?file_path\=pantheon-1.1.4.tar.gz -O pantheon-1.1.4.tar.gz
  ```

> `/home/bin/` is the best possible install folder for local user binaries that will be used by a single user. Other options are available such as `/opt/local/` or `/usr/local/bin/` depending on your local setup and preference. [See here for more details](https://unix.stackexchange.com/questions/36871/where-should-a-local-executable-be-placed).

2. Unpack the compressed file:
```
$ tar -xzf pantheon-1.1.4.tar.gz
$ cd pantheon-1.1.4
```
> Replace 1.1.4 with whichever release you have downloaded.

3. Confirm the download isn't corrupted and check the version.
```
$ bin/pantheon --help
$ bin/pantheon --version
```

The output should return the pantheon and java jdk version.

```
$ bin/pantheon --version
pantheon/v1.1.4/linux-x86_64/oracle_openjdk-java-11

```
