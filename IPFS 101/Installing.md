# Installation

In this tutorial, we are going to install IPFS and learn basic commands.

## Prerequisites

Familiar with the command line and IPFS concepts.

## Downloading

There are 3 different ways to install IPFS: from a prebuilt package, from ipfs-update, and building from source. We are going to be installing from the prebuilt package method. To use the other methods [follow the link.](https://docs.ipfs.io/introduction/install/)

We are going to install the **go-ipfs** prebuilt package from the [downloads page.](https://dist.ipfs.io/#go-ipfs) Depending on your platform, choose the appropriate download.

Once you finish downloading, unzip the package in the location of where you want to store the IPFS tool.

The last step is to add the IPFS binary to your `PATH`. You are going to need the path to where you saved the IPFS.exe file. Copy the location and then depending on your platform, follow the instructions to add it to your `PATH`.

[Windows](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/)

[Linux](https://www.techrepublic.com/article/how-to-add-directories-to-your-path-in-linux/)

Open your terminal and try the following:

Note: For Windows users, I recommend Powershell over Command Prompt.

  `$ ipfs help`

If IPFS was added to your path successfully, you will see the help text output.

That's It! You now have the IPFS installation on your machine.

## Initializing

Before we can use IPFS, we must initialize a local repository. This repository contains the settings and internal data for your user account. It also generates a peer identity key to cryptographically sign any content you create.  

  `$ ipfs init`

The init command outputs your peer identity key. This key is similar to an account number.**init** suggests the following command to try:

 `$ ipfs cat /ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG/readme`

 You should see something like this:

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

You can try the other files suggested by simply replacing **readme** from the above command with any of the ones listed ie) **about**,**help**, etc.

It's important to know where your IPFS repository is located because this is where all of your content is going to be stored. The following command will tell you its location as well as its contents.

  `$ ls ~/.ipfs`

## Basic Commands

The quick start guide gives a list of all the commands to get started in IPFS.

### Creating & Adding a File to IPFS

Navigate to a directory where you would like to create a file and then do the following:

  `$ mkdir hello-ipfs`
  `$ cd hello-ipfs`

We just created a folder and changed to its directory. Now lets create a file inside this folder.

    `$ echo "hello world 1" > helloworld.txt`

The text file **helloworld.txt** contains a line of text that says **"hello world 1"**. Next, add the file to IPFS.

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

As you can see, we changed the text to say **"hello world 2"** and when we added it to IPFS, we were given a new hash. By using the cat command, we see that our **helloworld.txt** file was updated with the nee text.

It's also possible to still read the "hello world 1" phrase that we had earlier.

  `$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`
  `hello world 1`
  `$ cat helloworld.txt`
  `hello world 2`

Using the first hash we are given, we can read what the hash represents. By reading **"helloworld.txt"** we see that the content still hasn't changed.

We can revert back to the **"hello world 1"** text if we wish.

  `$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8 > helloworld.txt`
  `$ cat helloworld.txt`
  `hello world 1`

### Pinning

As we talked about earlier, content on your node only stays there for a short period of time. Pinning allows you to tell IPFS what you want to keep around for an extend period of time.

Using the file we created earlier, we're going to pin it.

  `$ ipfs pin add QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`

Once pinned, it will stay on your node and not be collected with the garbage command. Lets see what happens when we try to garbage collect it.

  `$ ipfs repo gc`
  `$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`
  `hello world 1`

Your file stayed on your node even after we garbage collected everything.

Note: `$ ipfs repo gc` allows you to clean your node of all the files you were hosting.

### To Remove a Pin

`$ ipfs pin rm QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`
`$ ipfs repo gc`
`$ ipfs cat QmYBmnUzkvvLxPksYUBGHy2sqbvwskLQw5gK6whxHGcsa8`

The first command removes the pin and when we garbage collect, it is no longer on our node. The file will still be available in local directory stored on our computer but we are no longer hosting it on the node.

### Connecting to the Web

So far we've been working with IPFS locally. Now we're ready to try things online. Open another terminal and run the daemon command.

`$ ipfs daemon`

Daemon allows you to interact with the IPFS network through localhost on your browser. Switch back to your other terminal; We're going to take a look at our peers.

Note: If you ever get an error message saying "API not found" while using IPFS, run the daemon command and continue where you left off. **To ensure that IPFS runs correctly it is suggested to run the daemon command every time you use IPFS; even locally.**

`$ ipfs swarm peers`

You will see a bunch of addresses flash across your terminal. What we just did was open the swarm component that allows us to listen and maintain connections with other peers on the network. The **peers** command allows us to see every peer that has an open connection.

We've successfully connected to the IPFS network and from here we can get content from other nodes if we know the content hash.

If we know the hash of a file and want to save it on our computer we can do the following:

  `$ipfs name/ipfs/hash-here/name-of-file > name.jpg`

We can also view a file directly in our browser:

    `$ start http://127.0.0.1:8080/ipfs/Qmdh9Sk33zbLgPCPsadcSrvaJt4YUifP3njYbZT9W7B9zG`

You should see a picture of a dog. If you know the hash of another file, just replace the hash!

### Web Console

Now that we've connected our node to the network we can use the IPFS Web Console.

<http://localhost:5001/webui>

In the console, you will be able to check the status of your node, upload files to IPFS, explore files, see your peers, and adjust settings for your node. The web console is the ultimate tool for managing your IPFS node.

### Command Summary

We've gone over the basics of working with IPFS. Here is a summary of all the commands we talked about, as well as other useful ones.

-   **ipfs add name-of-file** : Adds a file to IPFS.

-   **ipfs cat hash-of-file** : Shows the contents of the file.

-   **ipfs pin add hash-of-file** : Pin files to local IPFS storage.

-   **ipfs pin rm hash-of-file** : Removes pin to local IPFS storage.

-   **ipfs repo gc** : Removes files from IPFS storage.

-   **ipfs daemon** : Starts an online connection to the network.

-   **ipfs swarm peers** : List peers with open connections.

-   **ipfs commands** : Lists all commands.

-   **ipfs id** : Tells you your id as well as other node id information.

-   **ipfs version** : The version of IPFS you are running.

-   **ipfs help** : Provides you with help information.

  Note: If you type in any command in the following format: **ipfs base-command** , the terminal will display the usage of that command. Ex) ipfs swarm, will tell you all the possibilities of the swarm command.

There are many other commands; these are basic ones to get started. To read about the rest [follow the link.](http://127.0.0.1:8080/ipns/docs.ipfs.io/reference/api/cli/#ipfs)

### Updating

To update IPFS, the **ipfs-update** client is required. Follow the [link](http://127.0.0.1:8080/ipns/dist.ipfs.io/#ipfs-update) and scroll down the page till you find the update tool. Download it to your computer. Unzip the package, and then add it to your path as we did at the beginning of this tutorial.

Once installed you will be able to use the **ipfs update** command to update IPFS.

## Conclusion

Now that we've discovered the basics of IPFS, the possibilities are endless! Try out different commands to see what they do and upload files using the web console. IPFS is still in its early stages and there are plenty of more exciting features to come.

Note: If you want to access the readme file as well as the others listed in the readme, you will need to have daemon running in the background.

Documentation:

<https://medium.freecodecamp.org/ipfs-101-understand-by-doing-it-9f5622c4d4ed>

<https://docs.ipfs.io/introduction/usage/>

For more advanced tutorials once you get the hang of the basics try out the following:

<https://flyingzumwalt.gitbooks.io/decentralized-web-primer/content/>
