# Serverless NFTS part 1

The first part of this tutorial demonstrates how to deploy an NFT using a technique that makes it easy to update the `tokenURI` endpoint which returns information about token metadata. This keeps your token flexible as infrastructure changes so quickly around decentralized technology.

The second part of this tutorial demonstrates how to create a serverless solution for serving that metadata. This is a widely used web2 infrastructure solution that is cheap and scaleable. It is not decentralized. This is a solution for using the Internet as it exists today. When the infrastructure around decentralized storage is a little faster and more reliable, you can replace this metadata solution for another and update your token accordingly : )

## Outline

### Upgradeable Token URI

1.  [Setup Environment](1-01.md)
2.  [Make ERC-721](1-02.md)
3.  [Make Metadata](1-03.md)
4.  [Add Metadata to ERC-721](1-04.md)
5.  [Create Migrations](1-05.md)
6.  [Make Tests](1-06.md)
7.  [Make Migration for Updates](1-07.md)
8.  [Update ERC-721 and Tests](1-08.md)
9.  [Deploy](1-09.md)
10. [Verify Contracts on Etherescan](1-10.md)

### Serverless Metadata

1.  [Make new netlify project](2-01.md)
2.  [Install netlify lambda](2-02.md)
3.  [Add helloworld function](2-03.md)
4.  [Add metadata](2-04.md)
5.  [Add proxy](2-05.md)
6.  [Add opensea](2-06.md)
7.  [Add rarebits](2-07.md)
8.  [Re-deploy and mint a token](2-08.md)
