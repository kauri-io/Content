# Installation

In this tutorial, we are going to install IPFS and learn basic commands.

## Prerequisites

Familiar with the command line and IPFS concepts

## Downloading

There are 3 different ways to install IPFS onto your computer: from a prebuilt package, from ipfs-update, and building from source. We are going to be installing from the prebuilt package method. To try out the other ways [follow the link.](https://docs.ipfs.io/introduction/install/)

We are going to install the **go-ipfs** prebuilt package from the [downloads page.](https://dist.ipfs.io/#go-ipfs) Depending on your machine platform choose the appropriate download.

Once you finish downloading the package you are ready to unzip the folder.

The last step is to add the IPFS binary to your `PATH`. Where ever you have the IPFS.exe file is the path you're going to use. Copy its location and then depending on your machine platform follow the instructions to add it to your `PATH`.

[Windows](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/)

[Linux](https://www.techrepublic.com/article/how-to-add-directories-to-your-path-in-linux/)

Open up your terminal and try the following:

Note: For Windows users, I recommend Powershell over Command Prompt.

  `$ ipfs help`

If IPFS is added to your path successfully, you will see the help text output.

That's It! You now have the IPFS installation on your machine.

## Initializing

Before you can use IPFS the way it's intended, we must initialize a local repository. this repository contains all the settings and internal data for your user account. It also generates a peer identity key to cryptographically sign the content you create.  

  `$ ipfs init`

The init command outputs your peer identity key. This key is similar to an account number. It is associated to you. **init** suggested the following command. Lets  try it out.

 `$ ipfs cat /ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG/readme`

 You should see something like this:

 ```
 Hello and Welcome to IPFS!

██╗██████╗ ███████╗███████╗
██║██╔══██╗██╔════╝██╔════╝
██║██████╔╝█████╗  ███████╗
██║██╔═══╝ ██╔══╝  ╚════██║
██║██║     ██║     ███████║
╚═╝╚═╝     ╚═╝     ╚══════╝

If you're seeing this, you have successfully installed
IPFS and are now interfacing with the ipfs merkledag!

 -------------------------------------------------------
| Warning:                                              |
|   This is alpha software. use at your own discretion! |
|   Much is missing or lacking polish. There are bugs.  |
|   Not yet secure. Read the security notes for more.   |
 -------------------------------------------------------

Check out some of the other files in this directory:

  ./about
  ./help
  ./quick-start     <-- usage examples
  ./readme          <-- this file
  ./security-notes
```

You can try out some of the other files suggested by simply replacing **readme** from the command above with any of the ones listed.

It's important to know where your IPFS repository is located on your machine because this is where all of your content is going to be stored.

  `$ ls ~/.ipfs`

This command will tell you where the **.ipfs** folder is stored and the contents of the folder.

## Basic Commands

The quick start guide gives a list of all the commands to get started in IPFS. At any point, you can use this guide as a reference.

### Creating & Adding a File to IPFS

Navigate to a directory where you would like to create a file and then do the following:

  `$ mkdir hello-ipfs`
  `$ cd hello-ipfs`

  Now create a file inside this folder.

    `$ echo "hello world 1" > helloworld.txt`

  Add the file to IPFS.

    `$ ipfs add hellowworld.txt`

  You will see the following output:

    `added QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8 helloworld.txt`

  The combination of letters and numbers is the hash associated with this text file. The hash is created based on the contents of the file. If you change the contents of the file, the hash will change. Save this hash to access this file later on.

### Reading content

Without using IPFS you can read the contents of the **helloworld.txt** file by:

  `$ cat mytextfiletxt`

We added this file to IPFS which makes it possible to read it from there as well. Using the hash generated from the file we created earlier, enter the following:

  `$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`
  `hello world 1`

It returns the content of the file for us to read.

### Changing the Content

Now we're going to see what happens if we change the text inside our **helloworld.txt** file.

  `$ echo "hello world 2" > helloworld.txt`
  `$ ipfs add helloworld.txt`
  `added QmfEKnXvgW7gbbxPj7e3LF4ZsaX8hxW427ASiGUKXDUZnB`
  `$ cat helloworld.txt`
  `hello world 2`

As you can see, we changed the text to say hello world 2 and when we added it to IPFS we were given a new hash. When reading the content we are given our new text. It is also possible to still read the "hello world 1" phrase that we had earlier.

  `$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`
  `hello world 1`
  `$ cat helloworld.txt`
  `hello world 2`

Using the first hash we are given we can read what we previously had. We can also revert back to the "hello world 1" text if we wish.

  `$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8 > helloworld.txt`
  `$ cat helloworld.txt`
  `hello world 1`

### Pinning

As we talked about earlier, content on your node only stays there for a short period of time. Pinning allows you to tell IPFS what you want to keep around.

Using the file we created earlier, we're going to pin it.

  `$ ipfs pin add QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`

You will see a list of all the items you have pinned now. In that list, you will see 3 different kinds of pins. Direct pins, which pin just a single block, recursive pins which pin a block and all its children, and indirect pins which are from a parent block being pinned recursively.

Once pinned, it will stay on your node and not be garbage collected. We will try and see what happens.

  `$ ipfs repo gc`
  `$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`
  `hello world 1`

Your file stuck around even after we cleaned the node of everything else.

Note: `$ ipfs repo gc` allows you to clean your node of all the files you were hosting.

To remove a pin:

`$ ipfs pin rm QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`
`$ ipfs repo gc`
`$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`

The first command removes the pin and as you can see after using the last command our file is no longer on our node. It will still be available in our directory stored on our computer but we are no longer hosting it on the node.

### Connecting to the Web

So far we've been working with IPFS locally. Now we're ready to try things online. Open another terminal and run the daemon command.

`$ ipfs daemon`

Daemon allows you to interact with the IPFS network through localhost on your browser. Switch back to your other terminal and we're going to take a look at the other peers.

Note: If you ever get an error message saying "API not found" while using IPFS, run the daemon command and continue where you left off. To ensure that IPFS runs correctly it is suggested to run the daemon command every time you use IPFS; even locally.

`$ ipfs swarm peers`

You will see a bunch of addresses flash across your terminal. What we just did was open the swarm component that allows us to listen and maintain connections with other peers on the network. The **peers** command allows us to see every peer that has an open connection.

We've successfully connected to the IPFS network and from here we can get content from other nodes if we know its hash.

If we know a file we can do:

  `$ipfs name/ipfs/hash-here/name-of-file > name.jpg`

We can view a file directly in our browser:

    `$ start http://127.0.0.1:8080/ipfs/Qmdh9Sk33zbLgPCPsadcSrvaJt4YUifP3njYbZT9W7B9zG`

If you know the hash of a file and want to view it in your browser just replace it with the one above!


### Web Console

Now that we've connected our node to the network we can use the IPFS Web Console.

http://localhost:5001/webui

In the console, you will be able to check the status of your node, upload files to IPFS, explore files, see your peers, and adjust settings for your node. The web console is the ultimate tool for managing your IPFS node.

### Command Summary

We've gone over the basics of working with IPFS. Here is a summary of all the commands we talked about, as well as some other useful ones.

  - **ipfs add name-of-file** : Adds a file to IPFS.

  - **ipfs cat hash-of-file** : Shows the contents of the file.

  - **ipfs pin add hash-of-file** : Pin files to local IPFS storage.

  - **ipfs pin rm hash-of-file** : Removes pin to local IPFS storage.

  - **ipfs repo gc** : Removes files from IPFS storage.

  - **ipfs daemon** : Start an online connection to the network.

  - **ipfs swarm peers** : List peers with open connections.

  - **ipfs commands** : Lists all commands.

  - **ipfs id** : Tells you your id as well as other node id information.

  - **ipfs version** : The version of IPFS you are running.

  - **ipfs help** : Provides you with the help information.


  Note: If you type in any command in the following format: **ipfs base-command** , the terminal will display the usage of that command. Ex) ipfs swarm, will tell you all the possibilities of this command.

  There are many other commands, these are the basic ones to get started. To read about the rest [follow the link.](http://127.0.0.1:8080/ipns/docs.ipfs.io/reference/api/cli/#ipfs)

### Updating

To update IPFS, the **ipfs-update** client is required. Follow the [link](http://127.0.0.1:8080/ipns/dist.ipfs.io/#ipfs-update) and scroll down the page till you find the update tool. Download it to your computer. Unzip the package, and then add it to your path as we did at the beginning of this tutorial.

Once installed you will be able to use the **ipfs update** command to update IPFS.

## Conclusion

Now that we've discovered the basics of IPFS, the possibilities are endless! Try out different commands to see what they do and upload files using the web console. IPFS is still in its early stage and there are plenty more exciting features to come.

Note: If you want to access the readme file as well as the others listed in the readme, you will need to have daemon running in the background.

Documentation:

https://medium.freecodecamp.org/ipfs-101-understand-by-doing-it-9f5622c4d4ed

https://docs.ipfs.io/introduction/usage/

For more advanced tutorials once you get the hang of the basics try out the following:

https://flyingzumwalt.gitbooks.io/decentralized-web-primer/content/
