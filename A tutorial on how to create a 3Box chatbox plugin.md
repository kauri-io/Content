# Content
 A tutorial on how to create a 3Box chatbox plugin

 Updated Outline 

 1.Introduction to 3box chatbox plugin.
 2.Use cases of 3box chatbox plugin.
 3.How 3box chatbox works.
 4.Example of 3box chatbox plugin
 5.How to build with 3box chatbox plugins
 6.Reasons for using 3box chatbox plugins


A TUTORIAL ON HOW TO CREATE A 3BOX CHATBOX PLUGIN


# INTRODUCTION TO 3BOX CHATBOX PLUGIN

## What is Chatbox
Chatbox is a 3Box plugin which enables dapp developers to add chatrooms to their react Ethereum application with a few lines of code to enable rich social discourse. The 3Box Chatbox plugin is built using 3Box infrastructure, 3Box Ghost Threads and handles all 3Box and web3 logic for creating a chat box. 3Box is creating a rich plugin ecosystem that simplifies the web3 development experience.

## Ghost threads
Ghost threads are a different type of messaging thread, that do not persist messages to OrbitDB database storage. Instead, ghost messages are sent from one peer to other peers on the network using IPFS pubsub, and are kept in-memory upon receipt by online peers. New users coming online or joining the chatroom can request a message backlog from other users in the chat. The Ghost Threads API allows Ethereum app developers to create new chat features that demand scalable performance to support many users sending many messages such as site-wide chat rooms, lightning fast load speeds, or novel properties such as disappearing messages.

# USE CASES OF 3BOX CHATBOX PLUGIN

Asset-driven use cases are a great start, and native to blockchains, most activity on mainstream applications today is more social and less financial in nature. Chatbox provide simple social functionality that drives everyday engagement on dapps Below are some available use cases.

## Decide on a pop-up or in-page component.
Chatbox can configured to be displayed as a pop-up modal or as an embedded in-page element depending on the user experience you wish to provide.

## Swap in your app’s name, image/logo, and color.
Chatbox, with its simple drop-in functionality, makes it easier than ever to experiment with social web3 development. it’s fully-featured out-of-the-box and can scale with your application into production.

# HOW 3BOX CHATBOT WORKS

## Architecture
The Chatbox plugin is built using a standard implementation of 3Box Ghost Threads which are defined in the 3Box Threads API and made available via the 3Box.js SDK. As with all Ghost Threads, Chatbox messages are sent from one peer to other peers presently connected to the network using IPFS/libp2p pubsub and are then stored in-memory by online peers. The message backlog is persisted as long as there is at least one user in the chatbox, however if all users go offline the history will disappear. 
The Chatbox plugin includes UI for an embedded in-window or pop-up chat room along with all relevant logic. The component is configurable to various authentication patterns, and can handle both Web3/3Box logged-in and logged-out states.

## Authentication
Chatbox messages cannot be read until a user has authenticated their 3Box, authenticated the app's Space, and joined the Chatbox's Ghost Thread. After authenticating and joining, a user can post and receive messages from other users in real time.


# EXAMPLE OF 3BOX CHATBOX PLUGIN

To make web3 a more social and interactive place, the ability for users to leave comments on 3Box profiles. This feature is known as 3Box Wall, and it opens up a whole set of new possibilities for social interaction between web3 accounts. And best of all, comments are completely decentralized since they’re built using the 3Box Threads API provided by the 3Box.js SDK.

# HOW TO BUILD WITH 3BOX CHATBOX PLUGINS

Install the Chatbox component
Choose your authentication pattern
Configure applications settings
Usage
 
## Install the Chatbox component
npm i -S 3box-chatbox-react

## Choose your authentication pattern
Depending on when and how your dapp handles authentication for web3 and 3Box, you will need to provide a different set of props to the Chatbox component.
Three acceptable authentication patterns and their respective props are discussed below in A-C:

### Dapp handles web3 and 3Box logins, and they run before component is mounted. (recommended)
Dapp integrates with 3Box.js SDK and the 3box-chatbox-react component. In this case, the box instance returned from calling the Box.openBox(ethAddr) method via 3Box.js should be passed to the box prop in the Chatbox component. The user's current Ethereum address should be passed to the currentUserAddr prop to determine which messages are their own.

### Dapp handles web3 and 3Box logins, but they haven’t run before component is mounted. (recommended)
Dapp integrates with 3Box.js SDK and the 3box-chatbox-react component.
In this case, the login logic implemented in the dapp should be passed to the Chatbox component as the loginFunction prop, which is run when a user attempts to post a comment. The user's current Ethereum address should be passed to the currentUserAddr prop to determine which messages are their own.

### Dapp has no web3 and 3Box login logic.
Dapp only integrates with the 3box-chatbox-react component, but not 3Box.js SDK.
All web3 and 3Box login logic will be handled within the Chatbox component, though it’s required that the ethereum object from your dapp's preferred web3 provider be passed to the ethereum prop in the component. In this instance, authentication will occur when a user attempts to join a chatroom.
Best Practice for Authentication
For the best UX, we recommend implementing one of the following authentication patterns: A; B; or B with A.
These patterns allow your application to make the box object available in the global application state where it can be used by all instances of the Chatbox component regardless of which page the user is on. This global pattern removes the need for users to authenticate on each chatbox component, should you decide to have more than one, which would be the case in C.

## Configure application settings
First, choose a name for your application’s 3Box space.
Logically, 3Box threads exist and are accessed inside of 3Box spaces, and you will need to choose a name for the space to be used by your application’s threads. Although you are free to choose whichever name you’d like for your app’s space, we recommend using the name of your app. If your application already has a 3Box space, you are welcome to use that same one for the Chatbox.
Next, choose a naming convention for your application’s threads.
The Chatbox thread needs a name, and we recommend that your application creates threadNames according to a simple rule. We generally like using a natural identifier, such as community name, page URL, token ID, or other similar means.

## Usage
import ChatBox from '3box-chatbox-react';
const MyComponent = ({ handleLogin, box, ethereum, myAddress, currentUser3BoxProfile, adminEthAddr }) => (
<ChatBox
// required
spaceName="mySpaceName"
threadName="myThreadName"
// Required props for context A) & B)
box={box}
currentUserAddr={myAddress}
// Required prop for context B)
loginFunction={handleLogin}
// Required prop for context C)
ethereum={ethereum}
// optional
mute={false}
popupChat
showEmoji
colorTheme="#181F21"
currentUser3BoxProfile={currentUser3BoxProfile}
userProfileURL={address => `https://mywebsite.com/user/${address}`}
spaceOpts={}
threadOpts={}
agentProfile={
chatName: "3Box",
imageUrl: "https://imgur.com/RXJO8FD"
}
/>
);


# REASONS FOR USING 3BOX CHATBOX PLUGINS

While there are endless possibilities for what you can build using the 3box chatbox plugins, here are a few reasons to get you started.

## Chatrooms
3box chatbox plugin will make it super simple to add scalable, high-volume chatrooms, site-wide chats, or even “trollboxes” to your Ethereum application.

## Disappearing messages
Since messages only exist in-memory between online peers, it would be easy to create an application where online users can exchange messages with each other that disappear when both go offline.

## Direct messages 
The3box chatbox plugin allows for users to post messages directly to another peer id or 3ID (DID), which means that you can potentially allow users in a ghost chatroom to direct message (DM) each other on the side.



