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

1. Create a new Kaleido account and then sign in/log in
2. After logging in, create a Consortium, by clicking the "Create Consortium" button.
- A consortium in this case means a group of users who'll be using the private blockchain



