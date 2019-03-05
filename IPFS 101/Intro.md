# Introductory to IPFS

## What is It?

InterPlanetary File System, also known as IPFS, is a peer to peer media protocol that aims to make the web faster, safer, and open. To meet this aim, a system that has fast performance, continuous access to content, efficient data transfer, easy naming conventions, and low cost is needed. Although IPFS is in its early stages, it meets all these requirements.

## What We're Using Right Now

In the current implementation of the web, we are using a service called [hypertext transfer protocol](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol), also known as HTTP. When we search for content on the web, our computer sends an HTTP request to the server hosting the content. In return, the server sends a response with the information we requested.

There are problems with this method:

- Many applications on the web are hosted by one server or cloud provider. If anything happens to the server, we are not able to access the content anymore.
- Downloading from a single server is inefficient. If lots of people try to access the same site, browsing and downloading is incredibly slow.
- The servers we access information from are often far away. The further the distance, the more expensive it is to access the content.
- Duplicated content creates wasted space.
- We depend on others to keep content accessible and secure. Site administrators depend on hosting companies to keep websites active, updated, and secure.

## How it works

IPFS is a decentralized way of storing and sharing files. IPFS keeps track of objects through an address that's associated with the contents of the object. It works using a structure called a [merkledag](https://github.com/ipfs/specs/tree/master/merkledag) which is a combination of a Merkle tree and [directed acyclic graphs](https://en.wikipedia.org/wiki/Directed_acyclic_graph). Merkledag is a cryptographically authenticated structure of data that uses different cryptographic hashes to address content. It allows for data to link together.

### Peer2Peer

IPFS runs using a peer to peer system. Peer to peer is a network in which other computer systems or 'peers,' share files directly between each other. Connected peers are called a 'swarm.' IPFS calls every computer using the protocol 'a node'. When you access content on the network, your system first looks at nodes near you to see if they have what you're looking for. If it doesn't find it, it searches farther away. When your node finds the content, it stores it for a short period. Essentially you become a host for nodes close to you. Multiple modes can host the same content and thus you no longer have to depend on a single server. It's a swarm of nodes that exchange data.

To reiterate:

- You connect to the swarm.
- Request a file.
- Your computer looks for the closest peer for a copy.
- If they don't have it, it looks farther away (from the original server).
- You download the file and host it.
- With this method, you only host files you're interested in.
- Everyone is a host and a client at the same time

### Content Addressable

Every file has a unique identifier called a cryptographic hash. IPFS uses this hash to search for content on the network. Instead of describing what the file is, it describes what the file contains. If the content of the file changes then the hash changes. This is a tamper-proof system because you know if it's been altered based on the hash. The [InterPlanetary naming system](https://docs.ipfs.io/guides/concepts/ipns/), also known as IPFN is responsible for this feature. IPFN is a secure method because there is no way possible to determine what the content is through the hash.

## Why it Matters

### Replication and Distribution

Duplicates don't exist on the network because the hash for a file is based on the contents. If the contents of the files are the same, the hashes are also the same. Getting rid of duplicates frees up additional space.

### Access and Censorship

Content is always accessible because it's available from multiple sources. For this reason, content is difficult to censor. Attacks would have to be directed at all nodes containing the content. Weak links or failing points in the system don't exist because there is always another node. Since the hash points to the content and not its location, content is always accessible because there is no such thing as a broken link.

### Speed

Everyone serves each other content, and thus you don't necessarily have to access far away servers. This allows it to be a quick system regardless of how close you are to the original host. If a file is too large (bigger than 256 kb) it's broken down into smaller pieces and joined together when it reaches the user. Smaller pieces of information travel faster.

## Downfalls

IPFS is a system that only works if people are actively participating in it. If people are participating, content is available forever, but only if people want it to be there. As well, personal information is not secure on this system. Personal information would be challenging to keep designated to one node because of the way information is shared in IPFS.

## Conclusion

IPFS is a system that allows the web to be more reliable and robust than what we have right now. It saves us money by not having to rely on servers that are far away. The content we want is always available to us because we have the option of pinning it forever. If a server goes down, it's not an issue because we can access the information from somewhere else. IPFS and Blockchain are both headed in the same direction; towards a decentralized system. It's fast, reliable, and space efficient so what are we waiting for?

## Next Steps

- <https://docs.ipfs.io/introduction/usage/>
- <https://www.sitepoint.com/http-vs-ipfs-is-peer-to-peer-sharing-the-future-of-the-web/>
- <https://medium.com/@ConsenSys/an-introduction-to-ipfs-9bba4860abd0>
