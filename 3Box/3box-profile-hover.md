
### Summary


One of the biggest frictions with onboarding users to Web3 is overcoming a lot of the technical issues that are required by design from decentralized networks and one of them are public addresses which are represented by a 40 character hexadecimal hash which is very unappealing for users.
This issue can be solved using profile hovers which instead of displaying a user's Ethereum address you can display a basic social identity, think of it like using ENS domains but more sociable.
In this tutorial, we will expand on what 3Box offers and how to use profile hovers in React and HTML/CSS apps.


## Introducing the 3Box SDK and APIs


3Box allows front-end web developers to keep user data on an open storage network instead of a centralized database server, browser localStorage, or the blockchain. With 3Box, developers are able to quickly build more secure, lightweight, and powerful applications.
All the data is publicly available but only private data can be decrypted by the user given explicit permission.

3Box provides a JS SDK and various APIs. The profile hover uses the profiles API to get basic data of the user such as the name.

There are different APIs available and these are the most important ones:

Identity API: This one allows developers to perform various actions such as getting the decentralized identity (DID) from a user address or linking new addresses to the DID

Auth API: This API allows developers to request access to a user's 3box profile and spaces.

Profiles API: This API allows developers to perform various actions such as getting public and private information from the user profile.

Take a look at all the available APIs [here](https://docs.3box.io/api/index).

## Overview on profile hovers


Profile hovers are a quick and easy way to make your decentralized application more sociable, useable and interactive with a basic social identity that works natively with Ethereum.
If you have a decentralized application and you want to replace user's hex addresses with human-readable names, images, descriptions and other social metadata in their application's UI then you're in the right place!
The `profile-hover` component consists of two elements: `tile` and `hover`, they both have different functionalities.
The `tile` element appears when you need to display an Ethereum address. It has a default style associated with it but you can also decide not to use it.
![Tile](/images/tile.png)
The `hover` element appears once the `tile` element is hovered and it pulls the data from the user's 3Box profile such as name, image, and description.
![Hover](/images/hover.png)

As outlined in the previous section the profile-hover uses the profiles API to get the data but if the user didn't sign up with 3Box it shows the shortened address and a blocky identicon like this:
![No_account](/images/no_account.png)

## Using profile hovers in a React app

Before diving in, you will need to have NodeJS installed, follow the guide
[here](https://nodejs.org/en/download/package-manager/)

As a first step, you will need to create a React application in which we will use
profile hovers.

`npx create-react-app profile-demo`

Afterward, let's install the `profile-hover` component.

`cd profile-demo
 npm i -S profile-hover`

Let's open the `App.js` and import the package:

`import ProfileHover from 'profile-hover';`

At this point, we can use the imported component to our liking. There are various
ways with which we can customize how to display it.
Let's modify the `App.js` in order to see how easy it is to use this feature.

```
import React from 'react';
import "./App.css";
import ProfileHover from 'profile-hover';

const App = ({}) => {
  return (
    <>
      <div className='ethAddress'>
        <ProfileHover orientation="right" url="www.kauri.io" showName tileStyle address='0x3f46680099cf623163c96747a8addb85a1da1cd1' />
      </div>

      <div className='ethAddress'>
        <ProfileHover orientation="right" noImgs showName tileStyle address='0xec1f83cf6a6dc7ee04a79c99a67cd3800111b355' />
      </div>
      <div className='ethAddress'>
        <ProfileHover orientation="right" noCoverImg showName tileStyle address='0x499c9c826a356f72926a258afa63bcdb4df33702' />
      </div>
      <div className='ethAddress'>
        <ProfileHover orientation="right" noCoverImg showName tileStyle address='0xfc27bf5bdc304ea27e74fd3f514e5400f0a9e76d' />
      </div>
      <div className='ethAddress'>
        <ProfileHover orientation="right" noImgs showName address='0x781901682d3e9341a6c195ee6fe58047a9235f07' />
      </div>
      <div className='ethAddress'>
        <ProfileHover orientation="right" displayFull showName address='0x442dccee68425828c106a3662014b4f131e3bd9b
' fullDisplay />
      </div>
      <div className='ethAddress'>
        <ProfileHover orientation="right" showName address='0xd75bb1e6ef53d0c65bcf53ecb19d8c64a7026c58' noTheme>
          0xa8ee0babe72cd9a80ae45dd74cd3eae7a82fd5d1
        </ProfileHover>
      </div>
    </>
  )
}

export default App; 
```

Let me explain the example above, `ProfileHover` is the React component used to
define various profiles, there are multiple properties associated with it for example
you can use a custom theme for the `Tile` instead of using the default one by using
the `noTheme` property or you can also specify the location of the hover.

Last but not least thing, let's also modify `App.css` so we can visualize the
profiles in a smooth way adding the following lines:

```
.ethAddress {
        padding: 20px 0px 0px 40px;
        height: 80px;
}
```

Now you can run the React app.

`npm start`

![App](/images/app.png)


# Using the HTML element

In order to use the profile hover with a HTML app, we need to add the script at
the end of the page.

``<script type="text/javascript" src="https://unpkg.com/profile-hover"></script>``

To display and address, you just need to add the following tag.

` <threebox-address data-address='0x442dccee68425828c106a3662014b4f131e3bd9b'></threebox-address>`

There are few other ways to customize your profile hover, you can add `data-display='full'`
to show the entire address instead of the shortened one.
You can also decide to not use the default styling using `data-theme='none'`.

This is an example of how you can use profile hovers in a HTML App.

```
<html>
  <head>
    <title>Profile demo</title>
    <style>
      .ethAddress {
        padding: 20px 0px 0px 40px;
        height: 80px;
      }
    </style>
  </head>
  <body>
    <div class='ethAddress'>
      <threebox-address data-address='0x442dccee68425828c106a3662014b4f131e3bd9b' data-display='full'></threebox-address>
    </div>
    <div class='ethAddress'>
      <threebox-address data-address='0xfc27bf5bdc304ea27e74fd3f514e5400f0a9e76d' data-theme='none'>
      </threebox-address>
    </div>
  </body>
    <script type="text/javascript" src="../dist/widget.js"></script>
  </html>
```

## Customize the profile hover

Imagine if you like the hover but you want to modify how they are visualized,
this is in fact possible. Let's take a look at the important properties.

The `address` property is required in order to display the profile hover since every 3Box
profile is associated with an address.

The `showName` property makes it possible to show the user's name from their 3Box profile,
if you don't use the property it shows the address shortened. If a user didn't add a
name to the profile, it will show the shortened address.

The `url` property allows redirecting to a specific link when clicking on the `Tile`.

The `displayFull` property shows the entire address instead of the shortened address.
Remember that if you add the `showName` property after, it will override it (look
at the penultimate profile in the example above ).

These are the most important properties, if you want to take a look at all of them,
check them out [here](https://github.com/3box/profile-hover#prop-types).

## Conclusion

We have seen how to use this feature, now I hope you will use it to improve your
UI . If you have any questions regarding profile hovers head over to the official
documentation here: https://docs.3box.io/ and if you want to discuss something
there is an apposite [Discord](https://discordapp.com/invite/TAefehN) for that.
See you next time.
