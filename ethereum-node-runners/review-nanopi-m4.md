# Review NanoPi M4

## Introduction

The purpose of this document is to review the single-board computer [**NanoPi-M4**](https://www.friendlyarm.com/index.php?route=product/product&product_id=234) to sync an Ethereum full-node,

This guide isn't about mining on the Ethereum blockchain and earning Ether as reward but only about running a peer-to-peer node on the network. So some people could ask what's the benefits of investing $150 in this setup?

Here is some benefits and incentive to run a node:
- You will own a trusted Ethereum stack you can rely to manage your assets and send transactions to the network yourself (remote nodes are generally reliable but are controlled by 3rd parties and typically throttle heavy usage)
- You can help secure the network; the more independent nodes running the more copies there are of the blockchain and the more resilient it is.
- You want to make the network faster and secure; the more nodes the lower the latency in sharing blocks and the more copies of the blockchain that exist.
- It is fun!

<br />

## Specifications

### Single-Board ARM computer


![](https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.geeky-gadgets.com%2Fwp-content%2Fuploads%2F2018%2F08%2FNanoPi-M4-RK3399-Mini-PC.jpg&f=1)

The [NanoPi-M4](http://wiki.friendlyarm.com/wiki/index.php/NanoPi_M4) is a RK3399 SoC based ARM board with similar ports, interfaces and size as the RaspberryPi 3 B+.

The NanoPi M4 has two RAM options: 4GB LPDDR3 and 2GB DDR3. *We chose the 4GB options which is more recommanded to run a Geth full node*.

The NanoPi M4 has an onboard 2.4G & 5G dual-band WiFi + Bluetooth 4.1 combo wireless module, four USB3.0 Type A host ports, one Gbps Ethernet port, one HDMI 2.0 Type A port, one 3.5mm audio jack and one Type-C port.

Follow the link for the [detailed specification](https://www.hackerboards.com/product/279/)

### SDCard (OS)

The Operating System is installed on a [SanDisk Ultra 16GB](https://www.amazon.com/SanDisk-Class-UHS-I-Memory-SDSDUNC-016G-GN6IN/dp/B0143RTB1E) SDCard which is largly enough knowing the Ethereum datastore will be located on a seperate SSD.

### SSD (Ethereum datastore)

Storage is an important component for the node, as we know, an Ethereum node needs to read, verify and write state transition and has consequently a very high IO usage.

We made an attempt on a SDCard (240GB with max speed around 100Mb/s) which failed because it was too slow to keep up, so we decided to find a faster option and took a [SanDisk SSD PLUS 480GB](https://www.amazon.com/SanDisk-240GB-Solid-State-SDSSDA-240G-G26/dp/B01F9G43WU/) plugged to the USB3.0 port via the following adapter [USB 3.0 SATA III Hard Drive Adapter Cable](https://www.amazon.com/Drive-Adapter-Cable-Support-Black/dp/B07S9CKV7X)


<br />

## Total Cost

Approximate cost.

| Component | Reference | Cost |
| --------- | --------- | ---- |
| Board | NanoPi-M4 | $50 |
| SDCard | SanDisk Ultra 16GB | $6 |
| SSD | SanDisk SSD PLUS 480GB  | $33 |
| USB-SATA Adapter | USB 3.0 SATA III Hard Drive Adapter Cable | $7 |
| Power supply | USB C Charger 15W 5V/3A | $17 |
| Ethernet cable | RJ45 Ethernet cable | $5 |
| <b>TOTAL</b> |  | <b>$118</b> |


<br />

## Installation and configuration

### Step 1 - Install the OS

[ARMBian](https://www.armbian.com/) is a Debian and Ubuntu based computer operating system for ARM development boards.

### Procedure

1. Insert the SD card into your computer or laptop.

2. Download [ARMBian for Nanopi-M4 (Stetch)](https://www.armbian.com/nanopi-m4/)

*Debian Stretch (version 9) is the latest stable version of Debian. This version comes without desktop.*

3. Unzip the Package

![](https://imgur.com/Kbmmrgy.png)

4. Download and launch [Etcher](https://www.balena.io/etcher/)

*Etcher is a free, multi-platform and open-source utility used for burning image files and create live SD cards and USB flash drives*

![](https://imgur.com/DLRY2fI.png)

5. Select and the ARMBian image `Armbian_5.75_Nanopim4_Debian_stretch_default_4.4.174.img`, select the Drive (SDCard) and finally click on Flash

![](https://imgur.com/LgiZtOw.png)

6. Once done, remove the SDCard from your laptop and insert it into the NanoPi-M4

7. Plug the Ethernet cable

8. Plug the power

![photo](https://imgur.com/09U3qDy.png)

9. Find the IP of the machine (on your router for example - DHCT table)

10. Connect via SSH from your laptop

*ARMBian default root password is `1234`*. After logging in, you will be asked to changed the default root password and to create a new user. We are calling him `pi`.

```shell
$ ssh root@192.168.128.210

root@192.168.128.210's password: 1234
You are required to change your password immediately (root enforced)
 _   _                         _   __  __ _  _   
| \ | | __ _ _ __   ___  _ __ (_) |  \/  | || |  
|  \| |/ _` | '_ \ / _ \| '_ \| | | |\/| | || |_
| |\  | (_| | | | | (_) | |_) | | | |  | |__   _|
|_| \_|\__,_|_| |_|\___/| .__/|_| |_|  |_|  |_|  
                        |_|                      

Welcome to ARMBIAN 5.75 stable Debian GNU/Linux 9 (stretch) 4.4.174-rk3399
System load:   0.00 0.00 0.00  	Up time:       14 min		
Memory usage:  2 % of 3811MB 	IP:            192.168.128.210
CPU temp:      47°C           	
Usage of /:    10% of 15G    	

Last login: Wed May 29 11:15:58 2019 from 192.168.128.11
Changing password for root.
(current) UNIX password: 1234
Enter new UNIX password: <NEW ROOT PASSWORD>
Retype new UNIX password: <NEW ROOT PASSWORD>


Thank you for choosing Armbian! Support: www.armbian.com

Creating a new user account. Press <Ctrl-C> to abort

Please provide a username (eg. your forename): pi
Trying to add user pi
Adding user `pi' ...
Adding new group `pi' (1000) ...
Adding new user `pi' (1000) with group `pi' ...
Creating home directory `/home/pi' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: <NEW PI PASSWORD>
Retype new UNIX password: <NEW PI PASSWORD>
passwd: password updated successfully
Changing the user information for pi
Enter the new value, or press ENTER for the default
	Full Name []: pi
	Room Number []:
	Work Phone []:
	Home Phone []:
	Other []:
Is the information correct? [Y/n] Y

Dear pi, your account pi has been created and is sudo enabled.
Please use this account for your daily work from now on.
```

11. Exit the terminal and connect with user `pi`

```shell
$ exit

$ ssh pi@192.168.128.210
pi@192.168.128.210's password:
 _   _                         _   __  __ _  _   
| \ | | __ _ _ __   ___  _ __ (_) |  \/  | || |  
|  \| |/ _` | '_ \ / _ \| '_ \| | | |\/| | || |_
| |\  | (_| | | | | (_) | |_) | | | |  | |__   _|
|_| \_|\__,_|_| |_|\___/| .__/|_| |_|  |_|  |_|  
                        |_|                      

Welcome to ARMBIAN 5.75 stable Debian GNU/Linux 9 (stretch) 4.4.174-rk3399   
System load:   5.00 4.13 3.40  	Up time:       13:18 hours		Local users:   2            	
Memory usage:  94 % of 3811MB 	Zram usage:    64 % of 1023Mb 	IP:            192.168.128.210
CPU temp:      85°C           	
Usage of /:    10% of 233G   	

[ 0 security updates available, 3 updates total: apt upgrade ]
Last check: 2019-05-30 00:00

Last login: Thu May 30 08:19:58 2019 from 192.168.128.12
```


12. Upgrade the system (this might take a little while)

```
$ sudo apt-get update
$ sudo apt-get upgrade
```


<br>

### Step 2 - Prerequisites

#### Mount SSD

Once the SSD is connected to the device via USB, we will need to find it and configure the fstab to mount automatically the disk.

1. Find the disk name (drive)

Run the command `fdisk -l` to list all the connected disk to the system (includes the RAM) and try to identify the SSD. With a size of *223.6 GiB*, the disk named `/dev/sda` is our SSD.

```shell
$ sudo fdisk -l

Disk /dev/mmcblk0: 16.5 GiB, 16087425024 bytes, 500170752 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xe8bbae5e

Device         Boot Start       End   Sectors   Size Id Type
/dev/mmcblk0p1      32768 495169023 495136256 236.1G 83 Linux

Disk /dev/sda: 223.6 GiB, 240065183744 bytes, 468877312 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 33553920 bytes

Disk /dev/zram0: 50 MiB, 52428800 bytes, 12800 sectors
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes

(...)
```

2. Create a partition

If you disk is new and just out of the package, you will need to create a partition.

```shell
$ sudo mkfs.ext4 /dev/sda
```

3. Manually mount the disk

You can now manually mount the disk to the folder `/mnt/ssd`.

```shell
$ sudo mount /dev/sda /mnt/ssd
```

4. Automatically mount the disk on startup

Last step consists to configure `fstab` to automatically mount the disk when the system starts.

You first need to find the Unique ID of the disk using the command `blkid`.

```shell
$ sudo blkid
/dev/mmcblk0p1: UUID="74460295-555c-4920-9ea1-ed107280edf0" TYPE="ext4" PARTUUID="e8bbae5e-01"
/dev/zram1: UUID="b5bcae37-2b96-42d5-8dff-9ae5a5ef843f" TYPE="swap"
/dev/zram2: UUID="a89d23e5-85e7-4e8e-8ea0-0ac1ae081999" TYPE="swap"
/dev/zram3: UUID="c7d4e1f1-cc6e-4201-859d-fdac265d1373" TYPE="swap"
/dev/zram4: UUID="a0069c64-2ca8-4bef-b61a-33686e97bd7d" TYPE="swap"
/dev/mmcblk0: PTUUID="e8bbae5e" PTTYPE="dos"
/dev/sda: UUID="77c02187-51cb-4ce4-96cb-9766733c7793" TYPE="ext4"
```

Our SSD named `/dev/sda` has the unique ID `77c02187-51cb-4ce4-96cb-9766733c7793`.

Edit the file `/etc/fstab` and add the following line to configure auto-mount of the disk on startup.

```shell
$ sudo vi /etc/fstab
```

Add this line at the end:

```shell
UUID=77c02187-51cb-4ce4-96cb-9766733c7793 /mnt/ssd ext4 defaults 0 0
```

Reboot the system

```shell
$ sudo reboot
```


<br>

#### Configure a static IP

By using static IP address, it will be a lot easier to get access to the machine since it has a fixed IP, not the dynamic one

Edit the file `/etc/network/interfaces` with the following content (change the static IP, netmark and gateway)

```shell
$ sudo vi /etc/network/interfaces
```

```shell
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet static
    address 192.168.128.210
    netmask 255.255.255.0
    gateway 192.168.128.1    
    dns-nameservers 1.1.1.1
```
Finally, let's restart the network connection to apply the change.

```shell
$ sudo ifdown eth0
$ sudo ifup eth0
```

<br>

### Router and firewall configuration

In order to communicate correctly with other peers, Geth needs to accept connections on port **30303** from outside. You will to configure your firewall accordingly to allows for incoming requests on port 30303 to reach the machine via  port-forwarding for instance.


<br>

#### Required softwares

Install the following softwares that might be needed during the procedure.

```shell
$ sudo apt-get install htop git curl bash-completion jq libgmp3-dev
```


<br>

### Step 3 - Install Geth

#### a. Install and configure Golang

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

#### b. Install Geth from source

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

### Step 4 - Configure and run Geth

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

### Step 5 - Configure Geth as a service

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

### Step 6 - Check Status

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

<br />

## Benchmark

Based on the following [monitoring solution](), we have monitoring the following metrics over time:
- Block sync
- States download
- Peers connected
- Disk size (SSD)
- Disk Speed
- Memory comsuption
- Load average
- CPU/Disk usage
- CPU Temperature

![](https://i.imgur.com/jrjOSpY.png)

Notes
- Fast block download
- Very Long states download
- Very low write speed (far from theoritical speed)
- Memory and CPU ok

<br />

## Conclusion




<br>

## Special thanks

This initiative began from a discussion about how hard it is to keep a Ethereum node stable and in-sync on a Raspberry Pi. From there, we decided to investigate alternative solutions and launched this experiment. So thank you for the interesting discussions and for your help in the last few weeks to make this experiment a success !

- Coogan Brennan
- [Daniel Ellison](https://kauri.io/public-profile/b929d237b337ce356fd0732472175babf08233ce)
- Lorenzo Sicilia

<br>
<br>
