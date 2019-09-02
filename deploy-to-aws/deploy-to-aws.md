# Deploying a full-stack dApp to Amazon EC2

In the previous [tutorial in this series](https://kauri.io/collection/5b8e401ee727370001c942e3), we saw how to develop a full-stack ethereum blockchain dApp. 

In this tutorial therefore, we will see how to deploy the dApp to an Amazon web services (AWS) elastic cloud computing (EC2) instance. We will also create a private ethereum blockchain node using [kaleido](https://kaleido.io/) and finally configure the dApp to work with this blockchain node.

## Prerequisites

In order to successfully complete this tutorial, you'll need a good understanding of the following concepts,

- Connecting to a remote server via SSH
- Basic linux Command Line Interface (CLI) knowledge
- Finally a good understanding on how the blockchain works would also be recommended but not necessary

## Launch and Connect to an EC2 Instance

To launch an EC2 instance, please follow the instructions provided in this [tutorial](https://hackernoon.com/launching-an-ec2-instance-fbfd50894aac)

- Make sure the instance state in the console is indicated as running and there is a green tick under status checks once you are done creating and lauching the instace.
- Make sure you are able to SSH into the EC2 instance as detailed in the article above.
- And finally make sure you install the apache server as specified in the article above as well.

## Create a Private Ethereum Blockchain Node using [Kaleido](https://kaleido.io/)

To create a private ethereum blockchain node in kaleido, please do the following

1. Create a new Kaleido account and then sign in/log in and complete the sign up process.
2. After logging in, create a Consortium, by clicking the `Create Consortium` button and then do the following.
- Enter the name and mission of the consortium as required.
- Then set your home region e.g. Ohio if you had selected USA as your country.
- Click on `NEXT` and then click on `FINISH` in the next tab
3. Afterwards, setup a New Environment by clicking on the `SETUP ENVIRONMENT` button and doing the following
- Enter the name of the enviroment or leave it blank as you choose and click on `NEXT`
- In the `Protocol` tab, select `Geth` under PROVIDER. This is very important because we need to create an ethereum blockchain node, the other 2 options will create blockchain nodes for other providers not covered by this tutorial.
- Also by default, `PoA` should be selected under CONSENSUS ALGORITHM
- Finally click on `FINISH` to complete setting up the environment
4. Finally add the ethereum node by clicking on the `ADD NODE` and doing the following,
- Select the correct `OWNING MEMBER` for the node and the enter the name of the node and click on `NEXT`
- Click `NEXT` in the `CLOUD CONFIGURATION` tab and leave the settings in default mode.  Please note under the free plan, you won't be able to change any of the settings available unless you upgrade your account.
- Finally in the `SIZE` tab, select the `Node Size` you want. Please note under the free plan, only the small node size will be available. Also click on `FINISH` to complete setting up the node.

After completing the above steps, give the newly created node about 3 minutes to finish initializing and starting up. Also please note the `RPC ENDPOINT` url of the node, we'll need it later in this tutorial. You can copy it by clicking on options (i.e the 3 dots at the end of the row) and then click on `View Node Details`. Finally click on the `Copy` link that is next to the URL.





