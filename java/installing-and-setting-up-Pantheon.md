# Installing & Configuring the Pantheon Client

This is the first of a series of step-by-step guides to install and configure the Pantheon client on Linux/Mac/Windows.
This guide will focus on Linux operating system.


## Before Getting started

Before even installing, I would suggest anyone wanting to setup and install Pantheon for the first time to try it out without any setup using the [quickstart provided at the Pantheon documentation site](http://docs.pantheon.pegasys.tech/en/stable/Getting-Started/Run-Docker-Image/). The only requisites needed to do so, are having docker installed and using Linux or MacOS.
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

Remember to have 4GB RAM if running a private network, and 8GB of RAM if running mainnet or a public test network and at least 2TB for the full blockchain mainnet archive sync.
