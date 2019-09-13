# - Install Geth on Linux Debian 

## Introduction

In this tutorial, we will go throught a step-by-step guide to install and configure an Ethereum full node ([Geth](https://geth.ethereum.org/) client) on Linux Operating System.

**Notes:**
- *The following tutorial is using Debian based Linux distribution such as Debian GNU, Ubuntu, Raspbian, etc.*
- *The configuration won't cover the mining but only the syncing which consists if participating to the Ethereum network and providing an up-to-date version of the ledger.*


##  Install Geth

### a. Install and configure Golang

1. Download the archive in ~/download

*For Nanopi-M4, we need to [download](https://golang.org/dl/) Golang for Architecture ARMv8: `go1.12.5.linux-arm64.tar.gz`*

```shell
$ mkdir ~/download
$ cd ~/download
$ wget https://dl.google.com/go/go1.12.5.linux-arm64.tar.gz
```

2. Extract it into /usr/local, creating a Go tree in /usr/local/go

```shell
$ sudo tar -C /usr/local -xvf go1.12.5.linux-arm64.tar.gz
```

3. Change owner to root, and change permissions

```shell
$ sudo chown root:root /usr/local/go
$ sudo chmod 755 /usr/local/go
```

4. Create a workspace folder, and 3 sub-folders inside it

```shell
$ mkdir ~/go_workspace{,/bin,/pkg,/src}
```


5. Set environment variables. Edit the file /etc/profile and append this line at the end:

```shell
$ sudo vi /etc/profile
```

```shell
export PATH=$PATH:/usr/local/go/bin
```

6. Edit the file ~/.profile and add those two lines at the end:

```shell
$ sudo vi  ~/.profile
```

```shell
export GOPATH=$HOME/go_workspace
export PATH=$HOME/go_workspace/bin:$PATH
```


7. Reboot

```shell
$ sudo reboot
```

8. Try it

```shell
$ go version
go version go1.12.5 linux/arm64
```

### b. Install Geth from source

To install Ethereum client **Geth**, we will compile it from the GitHub source in order to get the latest version (most optimised version).

1. Clone the repository

```shell
$ git clone https://github.com/ethereum/go-ethereum.git
```

*Feel free to use another release/tag or branch by adding `--branch <tag_name>` at the end.*

2. Go in the folder and build geth

```shell
$ cd go-ethereum
$ make geth
```

3. Move the binary to /usr/local/bin

```shell
$ sudo mv ~/go-ethereum/build/bin/geth /usr/local/bin
```

4. Try it

```shell
$ geth version
INFO [05-29|18:01:06.998] Bumping default cache on mainnet         provided=1024 updated=4096
WARN [05-29|18:01:06.999] Sanitizing cache to Go's GC limits       provided=4096 updated=1270
Geth
Version: 1.9.0-unstable
Architecture: arm64
Protocol Versions: [63 62]
Network Id: 1
Go Version: go1.12.5
Operating System: linux
GOPATH=/home/pi/go_workspace
GOROOT=/usr/local/go
```


<br>

## Configure and run Geth

Geth can synchronise the blockchain in different modes:
- `full` syncs the full blockchain (block headers, block bodies and validates everything from genesis block)
- `fast` syncs pruned blockchain data (not process transactions until the current block)
- `light` syncs directly to the last few blocks, does not store the whole blockchain in database

`fast` is a good option to run a **full-node** and sync the device more or less quickly (few days).


Geth also has a `--cache` option which specifies the amount of RAM the client can use. NanoPi-M4 has 4GB RAM so we can use `--cache 2048` without problem.

By default, all the data will be stored in `~/.ethereum/geth/`

1. Create a data directory on the SSD with pi permissions

```shell
$ sudo mkdir /mnt/ssd/ethereum
$ sudo chown -R pi:pi /mnt/ssd/ethereum
```


2. Run the following command to see of Geth starts syncing the blockchain.

```shell
$ geth --syncmode fast --cache 2048 --datadir /mnt/ssd/ethereum

Ctrl+C to stop it
```

*[See documentation](https://github.com/ethereum/go-ethereum/wiki/Command-Line-Options) for command line options*


<br>

## Configure Geth as a service

We want to run Geth as a service and keep the processus running in the background after we close the session, we will install a systemctl service ([systemd explanation](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units))

1. Create the following file:

```shell
$ sudo vi /etc/systemd/system/geth.service
```

```shell
[Unit]
Description=Geth Node
After=network.target auditd.service
Wants=network.target
[Service]
WorkingDirectory=/home/pi
ExecStart=/usr/local/bin/geth --syncmode fast --cache 2048 --datadir /mnt/ssd/ethereum
User=pi
Group=pi
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
Alias=geth.service
```

2. Start the service

*The following command will start Geth in the background using our service file definition*

```shell
$ sudo systemctl start geth
```

3. Configure the service to start at boot

*The following command will configure Geth to automatically start after a reboot.*

```shell
$ sudo systemctl enable geth
```

4. Check the logs

*You can visualise the service logs by watching the file `/var/log/syslog`*

```shell
$ sudo tail -f /var/log/syslog

May 30 10:25:48 localhost geth[14376]: INFO [05-30|10:25:48.389] Imported new state entries               count=879  elapsed=48.942ms  processed=11156730 pending=6790  retry=0    duplicate=2836 unexpected=6886
May 30 10:25:50 localhost geth[14376]: INFO [05-30|10:25:50.084] Imported new block headers               count=192  elapsed=19.388s   number=4740140 hash=147d4e…f4f827 age=1y5mo2w
May 30 10:25:56 localhost geth[14376]: INFO [05-30|10:25:56.024] Imported new block receipts              count=230  elapsed=8.162s    number=4707422 hash=a6c473…ffcbea age=1y5mo3w  size=7.85MiB
May 30 10:25:59 localhost geth[14376]: INFO [05-30|10:25:59.677] Imported new block headers               count=2048 elapsed=9.224s    number=4742188 hash=d1e667…3822b9 age=1y5mo2w
```


<br>

## Check Status

After the client runs, you can attach the geth console and check the status:

1. Open Geth console

```shell
$ geth attach  --datadir /mnt/ssd/ethereum/
```

2. Current syncing state

```javascript
> web3.eth.syncing
{
  currentBlock: 4711199,
  highestBlock: 7860354,
  knownStates: 11177391,
  pulledStates: 11173552,
  startingBlock: 4473105
}

```

*This command will say `false` if the node is synced. Otherwise it will show the current block*

2. Peers connected

```javascript
> admin.peers
[{
    caps: ["eth/63"],
    enode: "enode://73e161b7a165ef26eca2ab28629b4ce00df6629a6ca9f55cf1d29de671254cfe9200a6be1bc7e60d4dc61a567fdaa40b62ed85b7a26eb90835eaf6f59ea470d4@90.46.105.80:30303",
    id: "799534e3d37925b1f024529317ce9e35d3e98fd65c0c90ea32226fdb844e773b",
    name: "Geth/v1.8.23-stable-c9427004/windows-amd64/go1.11.5",
    network: {
      inbound: false,
      localAddress: "192.168.128.210:60534",
      remoteAddress: "90.46.105.80:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        difficulty: 9.815280324952898e+21,
        head: "0xfb31a8e868ef564361e0d17d578737f8016cb8f8407c313af37d4a47b3d384d2",
        version: 63
      }
    }
}]
```

<br>

## Conclusion

TODO
