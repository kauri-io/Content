# Implementations

Before we dive into using IPFS, here is a brief introduction to the different implementations we have available to us.

## Command Line Tool:

The IPFS protocol comes in two different languages: Go and JavaScript. In the near future, we can also expect to see it in Python.

**go-ipfs** The main implementation of IPFS. Included it has a daemon server, command line tool, HTTP API for controlling the node, and an HTTP gateway to serve content to HTTP browsers.

**js-ipfs** The JavaScript browser implementation. Allows you to start an IPFS node directly in your program or control a node that is already running through HTTP API.

In our tutorial, we are going to be using the Go implementation. For more information on **js-ipfs** visit the [link.](https://js.ipfs.io/)


## Browser extension

IPFS has a browser companion to access IPFS resources from a locally running node. The companion is available on [Chrome](https://chrome.google.com/webstore/detail/ipfs-companion/nibjojkomfdiaoajekhjakgkdhaomnch?hl=en) and [Firefox.](https://addons.mozilla.org/en-US/firefox/addon/ipfs-companion/) It provides you with information about your gateway, API, version, and the number of peers connected. You can also do things such as share files and switch to a custom or public gateway.

## Local Webhost

Once you have IPFS set up you can access your own personal web host to see the status of your node. You'll be able to read information such as network traffic, bandwidth, peers, and more.

http://localhost:5001/webui

You can upload files to your node as well as explore files on other nodes if you know their hash. The Web User Interface is the ultimate tool for checking the status of your node and managing your files.
