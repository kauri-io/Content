# Introductory to IPFS

## What is It?

InterPlanetary File System, also known as IPFS, is a peer to peer media protocol that means to make the web faster, safer, and open sourced. We're in need of a system where we can store information in a way that it's easy to remember. It needs fast performance and resilient access to data. Able to access large amounts of data efficiently at a low cost. IPFS although in it's early stages can do all of these things.

## What We're Using Right Now

In the current implementation of the web, we are using a server called hypertext transfer protocol, also known as http. Our computers send an http request to a server hosting a website and then that server sends our computer a response back with the information we requested.

There are many problems with this method:
- Most applications are hosted by only one server. Therefore if anything happens to it, you won't be able to access the content anymore.
- It's inefficient because it downloads from one server. If there are a lot of people trying to access the same site, it will dramatically slow down the server and download speed.
- The servers we are accessing information from are usually far away and for this reason, it's more expensive.
- There is a lot of wasted space on duplicated content.
- We are reliant on site administrators to keep a website active and updated and on hosting companies to keep our data safe. We depend on other servers to keep content accessible to us.

## How it works

IPFS is a decentralized way of storing and sharing files. Everything is kept track of through an address that's associated with its contents. It works using a structure called a merkledag which is a combination of a merkle tree and directed acyclic graphs. This is simply a cryptographically authenticated structure of data that uses different cryptographic hashes to address content. It allows for data to be linked together.

### Peer2Peer
IPFS works in a peer to peer system. Peer to peer is a network in which other computer systems or 'peers', share files directly between each other. Peers connected together are referred to as a swarm. Every computer using IPFS is a node on the network and every person who accesses content will have it stored on their node for a short period of time. Your node is then a host for anyone around you to access that content. Multiple modes can have the same content stored and thus you no longer have to depend on a single server for your content. It's a swarm of nodes that exchange data.

To reiterate:  
- You connect to the swarm.
- Request a file.
- Your computer looks for the closest peer around you for a copy.
- if they don't have it you'll look to go to the original source.
- You download the file and become a host for it.
- You only host files you use (the files you're interested in).
- everyone is a host and a client at the same time

### Content Addressable

Every file is given a unique identifier called a cryptographic hash. The hash is what is used to search for content on all the nodes. Instead of describing what the file is, it describes what the file contains. If the content of the file changes then the hash will change as well. This allows it to be tamper proof because you will know it's altered based on its hash. This is possible through the InterPlanetary naming system, also known as IPFN. This is a secure method because there is no possible way to tell what the content is through the hash.


## Benefits

Now that we understand what IPFS and how it works we'll explain why it matters.

### Replication and Distribution

There are no duplicates on the network because the hash for a file is based on the contents. If the contents of the two files are the same, they will have the same hash. This frees up unnecessary space. As well content will always be accessible even when its content changes because the hash does not point to its location, it points to its contents.

### Access and Censorship

Content will always be accessible because it's available from multiple sources. For this reason, content is difficult to censor. Authorities can't censor media because it's too hard to block every outlet. As well it's harder to attack the system because they would have to target every peer that has the content they want. There are no weak links or failing points in the system since there will always be another node.

#### Speed

Everyone serves each other content and thus you don't necessarily have to search far away servers for the content you want to access. It allows it to be a quick system regardless of how close you are to the original host. If a file is too large (bigger than 256 kb) it's broken down into smaller pieces and joined together when it reaches the user.

## Downfalls

IPFS is a system that only works if people are actively participating in it. But if people are participating content will be available forever if people want it to be there. As well, personal information is not secure on this sort of system.


## how to ties to the blockchain

Blockchain and IPFS are in its early stages but both focus on decentralization which is essentially eliminating the middle man. Right now IPFS is being used to store hashes to the files on blockchain for multiple different applications. Together they fall into the same level of technology of there being an internet with no servers. Both based on Web3.0 technology they are a perfect match.



## Conclusion


IPFS is a system that allows the web to be more reliable and robust than what we have right now. It saves us money by not having to rely on servers that are far away. The content we want is always available to us because we have the option of pinning it forever. If a server goes down, it's not an issue because we can access the information from somewhere else. It's fast, reliable, and space efficient so what are we waiting for?

Documentation:

https://docs.ipfs.io/introduction/usage/

https://www.sitepoint.com/http-vs-ipfs-is-peer-to-peer-sharing-the-future-of-the-web/

https://medium.com/@ConsenSys/an-introduction-to-ipfs-9bba4860abd0

For background information on Web3.0 check out the following link:

https://blockchainhub.net/web3-decentralized-web/
