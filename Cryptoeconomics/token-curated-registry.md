# Incentivizing high-quality curation with a Token-Curated Registry
## What is a Token-Curated Registry
The idea behind a Token-Curated Registry (TCR) is simple: create a list around certain topic. With such simplicity comes flexibility: it’s possible to curate a list of persons, companies, schools, etc.
Lists are inherent to people: we create, maintain, and consume them all the time. With token-curated registries, this process can become decentralized, as there are no central parties who control it: once deployed, such list is fully autonomous from its creator.
There are three groups of users of a registry: consumers, producers, and candidates. Consumers are the “readers“ of the registry, who use the information for their own goals. Producers are the “writers” of the registry, they vote on whether to include given item to the list or not. Candidates nominate items to be included to the list.
## Economics
Each TCR has internal token, which is used to coordinate and incentivise honest behaviour. The token is usually traded on the market.
Candidates stake tokens when they nominate new items. Once the proposal is done, any member of the list can challenge it by making a deposit. 
The challenge is resolved by token holders. Once new item is proposed, each holder can vote in a limited period of time. Then, the votes are calculated and the outcome is executed. The more tokens a user owns, the more voting power he has.
If the item ends up included into the list (no challenge was initiated or the token holders voted the proposal in), a candidate receives tokens back. If the item is rejected, stake is usually split between challenger and voters that were in majority.
Existing registry items, or listees, can also be challenged at any time. For that case, they must keep a minimum deposit that will be seized in case the challenge will be successful so it will be split between challenger and majority voters. In case the challenge will fail, the listee will keep the deposit, and the challenger stake will be split between listee and majority voters. 
## Examples of TCRs
One can create a list to curate anything meaningful: from comedy movies and best cafes in Beijing to the top MBA schools and approved drugs.
Sticking with the “good comedy movies” examples, let’s look at how it would work. In that scenario, good candidates for the list producers might be movie enthusiats with ton of experience watching movies. The candidates for that list might be the movie creators themselves, as they have incentive to put their movies to the list. As for consumers, it will be useful for anyone who loves comedy and needs to decide what to watch in the evening.
Specing of live TCRs, FOAM project uses Token-Curated Registry to curate points-of-interest. FOAM holders can vote
Other use cases include curating URLs (AdChain), tokens (Messari), and smart contracts (Panvala).
## Creating a TCR
In this tutorial, we will create a “Best comedy movies” dapp. It will consist of a smart contract, that can be then used (with slight modifications) for curation of other items, and a web app that connects to the particular instance of that contract and allows to consume the list without directly interacting with the contract.
### Smart contract
Token-curated registry has several configurable parameters. Perfectly, this parameters should be governed in a decetralized manner, but how to achieve that is an open question. For the sake of simplicity, we will keep the parameters stable and let the creator set them at the time of deploying the contract.
The parameters of TCR are:
* minimal deposit required to make a proposal
* length of the apply stage
* length of the vote commit stage
* length of the vote reveral stage
* the percent of stake that goes to the listee or its challenger
* the percent of votes that form vote quorum
### Front-end
## Potential attacks

## Limitations and improvement ideas

## Wrap-up

## Further reading
TCRs is a broad topic that goes beyond technical specifics. If you want to learn more, I recommend going through the following resources:
* The first public description of the Token-curated registries: [Token-Curated Registries 1.0 – Mike Goldin – Medium](https://medium.com/@ilovebagels/token-curated-registries-1-0-61a232f8dac7)
* Update by the author of the original paper, Mike Goldin, where he ::fsdfsa:: : https://medium.com/@ilovebagels/token-curated-registries-1-1-2-0-tcrs-new-theory-and-dev-updates-34c9f079f33d
* “Awesome token-curated registries” repository on Github: [GitHub - miguelmota/awesome-token-curated-registries: Curated list of awesome Token Curated Registry (TCR) resources.](https://github.com/miguelmota/awesome-token-curated-registries)
* A reference TCR implementation: [GitHub - skmgoldin/tcr: A generic token-curated registry](https://github.com/skmgoldin/tcr)
