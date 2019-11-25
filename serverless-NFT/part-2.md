# Part 2

## Step 1: Make new netlify project

We begin Part 2 by creating a web page in the same folder as the rest of our code.

```bash
touch ./index.html && echo "hello world : )" > ./index.html
```

Great that's a beautiful website! Let's deploy it to the internet. Create a git repo, commit your code, and push to the origin:

```bash
git add . && git commit -m 'new website' && git push -u origin master
```

I use [netlify](https://www.netlify.com) for hosting because they have an all in one package for deploying sites from repositories, running a build process, adding SSL for custom domains and the ability to add lambda functions. They also have authentication and form handling, but I've never used those features. You could use AWS or Google firebase. Go to [netlify.com](https://netlify.com)and register using your github/gitlab/bitbucket account.

We're creating an API endpoint that returns the metadata for our NFT. I know what you're thinking, "isn't this an evil centralized solution??". Yes it is. Why? Because the alternative still sucks. Until we live in a world where I can expect my IPFS file to persist after I stop seeding it, and where I don't have to wait forever for the content, we have to use the current Internet infrastructure. If you look at any successful NFT project, they're doing the same thing. The biggest NFT marketplace, [opensea.io](https://opensea.io), caches all the NFT data they can find and serves it directly. This is because it's better than relying on decentralized solutions at this point. When the decentralized solutions are viable, then our NFT will have an upgradeable metadata endpoint!

![](https://uc414b66d1555a61ff0af338d71f.previews.dropboxusercontent.com/p/thumb/AASkylKs120kW4yRiSdpZn2MCAoZS4UvdD0DV6dPev3CWpGnrq60_elD-2HBmmRJNmmt3aygyNwU-_b-lCGe-dCNLoxwXJncHN-khY3gtt-kK3t7wZSCFtO0DMPDeR55GIP67pIpcrIfOn7rawMuOA-va0gD2y1DtoPT02wMNjK2JUOtXE6_C0DiL8Kj04Mavd2QxPdau7plDjzTxkhyB8dX7jQuE21CS6CB9WwgNn_LtvaMV4Fo1ZV0001S1a7oApsN5qb17xwO5VuAjvjRNN_qO3IXeDUr_vxpdRzAMHDyMkCei8rkKsckbGtn9dPoTh9ysg_Otj4BMo_WnARuMOVu/p.png?size=1600x1200&size_mode=3)

Back to netlify, we allow them to have API access to our repo so that they can deploy changes.

![](https://ucf7855df33c5437177dc96170c6.previews.dropboxusercontent.com/p/thumb/AAQGNNZ00nUovcJcQaYxFM6sQbuZlI5S9EJt1jy4rkU7DDvu0Vukj8KyocRRAkNNj7TEWOvm9Hr9KfytrO7OxtsmdBH9ZzyX2ZvEbY8-HI9dQfr3m32VMr5zzop-6bVNTDoceaFyRxlzZsQOYF_BMio4ptKhut4zVrmxa_WYut7UOs-_7pfhj0A0Y_Bp_hXPbZ8z5BFIQw1BLdQu_8YnRzzSWwc7mRiP2nx53t-1s3gxnlAx1-yJFtPS4WCIozbmBudR1IobRRlW2rH4UPfAgJdeYw4xyDLVZprdBXm73PfuP2uSeHUfMa9vpete92RaDrl4VpYR2hWO2BiQ9um5xsRv/p.png?size=1600x1200&size_mode=3)

Find our repo and select it.

![](https://ucdafacb9382bc3c5808911c8c33.previews.dropboxusercontent.com/p/thumb/AAQrkkWfIxshO1s6YqyZrB2Gj7yopKtFHG8KZAtDaBcTaaktefbVCRi-t760QysjJssL8igexJekBeOKPdhD8-1o2Yzpca6aXQXttwFjiW5c2hvWWgGNXFQWYw5xF_IBbhB3HmtNA5NJd6itj2jE32JvKrqXKvH-zqPf6_arEokTyVgVqu8_BYp0gPLeDHyrX61E_MQvAKfmdqCgWi_K17i6PNPQM_TVuPAE4TxjUrO7pFFJdWKpCwdrpTR6BKVpd17yPAcrlDEjbLkDm1bwE8COw3crt_JhGyfuTu-kAl1yAs0dIs7svUTKMgTRolX_ws9-PaLvCkeaqUKYNK0nxOh1/p.png?size=1600x1200&size_mode=3)

We don't need to add a build command or a publish directory because our website is just one _index.html_ file and it's in the project root. You are probably already on `master` branch so that won't need to change (although netlify can auto-deploy each branch on a new domain if you want it to). Next click "Deploy site".

![](https://uc1389aa6c344d7ba00fbb011780.previews.dropboxusercontent.com/p/thumb/AAQ5pFViddeNISgV_B4iCTZ8bwZpdkTRIkRdAJQLhTbyJ-xdXHuqnjSXjYNdWg7dUJE0bGYzcIPEPjvkTkTDAueCorCZDmOblkp1_MsjFStE3gA3KGf-BGEXJxYvaMgMp3IKhK7QcNYOi_y5s4Oje6jltIwsyF61Ikz_gaRddecbqIE8QB1Q3XVhiynYHzWKmoHCAqV4YSJOopy9nuI3QLbK1knSs3yaKMfxqYyR_S4g0ev7h1L5Ioxypj0_UL2EVYbBU4QR67Yw92oCaeTTuomrpOL7gVpTENezditePy_pZUljDeNwnYH2UoSmox2P8ZJB21iK7vBxqrkv50jrrkbg/p.png?size=1600x1200&size_mode=3)

If you want to change your site name from the auto generated name, click _Site settings_ and scroll down to _Change site name_. I changed mine to "block-workshop" which makes it available at <https://block-workshop.netlify.com> once the deploy process has completed.

If everything went well you should see this beautiful website:

![](https://ucf3418fcd6a9d45fb73e8f9bd3a.previews.dropboxusercontent.com/p/thumb/AAQNz-QaGgB6szyi-XeKTDhuyGwPCw93iwWtTAf045bp_2VkVemzgTTSM50yWQkbbfXCXo0hFkvZdQCaufFEl0xqXURtRylo2uU9SGtDfhIKyz1vk5Ebcfau35g3_Ch5oCWAz73mn49gWNgcmgplnW6Nl3I6Z4Pu4XUZ-8SxsuI0k5d-a4qhXGaUJJXUsGAKS-y8Oalx2o1vy-R91dRGpEdbHIBYW9sXZZqHepmdTUHpcu_qQSCVP09FXbcVxzrcRJKF5IzaHYgm3HC_dWKVbdURi0nN3A50fE2jMfEreSWvTIuQeNQid-gAM2aBRQxbAixjauzf_uCM6hdiZfngL0Aj/p.png?size=1600x1200&size_mode=3)

## Step 2: Install netlify lambda

Install `netlify-lambda` as a dev dependency so we can access it with `npx`. This is a utility for building the lambda function and serving it locally so you can test functions before deploying them.

```bash
yarn add netlify-lambda -D
# or
npm install netlify-lambda --save-dev
```

Add a directory where your lambda functions live. Call it _lambda_ as that makes sense.

```bash
mkdir lambda
```

Create a configuration _.toml_ file for netlify to define where our functions are served from:

```bash
touch netlify.toml
```

Now add the key `functions` to the toml file which is where the functions are served from after the `netlify-lambda` builds them:

```toml
[build]
  functions = "functions"
```

Create a dummy function in the _lambda_ folder:

```bash
touch ./lambda/helloworld.js
```

Add the boilerplate that netlify provides from their docs:

```javascript
exports.handler = function(event, context, callback) {
  callback(null, {
    statusCode: 200,
    body: "Hello, World"
  });
};
```

The file exports a function called `handler`. This is the same format that AWS uses for their lambda functions (because netlify is a wrapper around AWS). If you have a lambda function you've used with AWS, you can use it with netlify, and if you have any advanced trouble shooting requests regarding these functions, add "AWS" to your query and not "netlify".

Run a local server so we can test the endpoint using the `netlify-lambda` utility:

```bash
$ npx netlify-lambda serve lambda
netlify-lambda: Starting server
Lambda server is listening on 9000
Hash: 47a70dc1b032c7c81a89
Version: webpack 4.27.1
Time: 745ms
Built at: 2018-12-13 18:52:53
        Asset      Size  Chunks             Chunk Names
helloworld.js  1.03 KiB       0  [emitted]  helloworld
Entrypoint helloworld = helloworld.js
[0] ./helloworld.js 129 bytes {0} [built]
```

This builds a new _functions_ folder where the _helloworld.js_ file is compiled and served from. It's accessible from port `9000` by default and is accessible at `http://localhost:9000/helloworld`

![](https://uc74130f676d8a161e0616692013.previews.dropboxusercontent.com/p/thumb/AAR1j7_y3pUKjl60tLlh2EvZhdohn7TihNSQ8oBoUOFTFsDTW32IFAySLKIfG2OPwTP7Oat1JPtIkef9GsIZd0jRRJW8d92eIG57erfPydXxbDJ6d1PxyCRUCMo4sP59u_YIOV5Yfoe69-HB8nUSO8xgyp0U9mL3EDCT-YkE8CZ3lrX_V_Xb9CjZoe9iioig-jhnKRmebQd8c3FueXv8A1m-NiF8D1Q2cL6BY3irLVmOlQKS5GqHytI5Q7WrcW0rSZ-wqWs9SBtc_BPoRk_7S_OQCkEDkJiKD8r2ngPK19sg_Kk5kgsUBrY_hv4Kqh6wYFiHreUcDpjI3lt1PYGhp9FH/p.png?size=1600x1200&size_mode=3)

Commit your code and push to your repo. Netlify should notice the push to `master` and auto-deploy it.

```bash
git add . && git commit -m 'Step 2: Install netlify lambda' && git push
```

You now have access to a _functions_ section on netlify where you have one `helloworld` function

![](https://ucf4baadccb7db9a6cd75408aeca.previews.dropboxusercontent.com/p/thumb/AATVG-qFH_38zv6hBl2TaYLoBDhq8Ee14aRmV-NnCTyEZF9EfwQ-KD82dzq5r0rZtT1oJ4iR1cQVhU8UaMQxZxr1HFoDG_SygwEmPVLdoNxzsom7G626n6kSOJBfq76VCJmb1OEYXqLLsn79daWiwkXEy8ER3CqhQ2P3HZIfx6DWM3Q8KuTLusE0LTJ_XihM7UGXcxnK-oqNdHkLm7uc_aX-3Xx3QunFF8pFG46vOxEghXJF6rCZoiE7LWCoKtuvUaUuAEJZoaMoKH1pA1fq3Wp1dnNvc1MeAZrram04kjngudepFTahzBDzK7BFv_WyfZ1sPmKOfGU2oRiXyhaVz-p-/p.png?size=1600x1200&size_mode=3)

When the deploy finishes you should be able to access it at <https://{SITE_NAME}.netlify.com/.netlify/functions/helloworld>

This is the deployed format for the functions so that there aren't any name conflicts with your current routing. This is inconvenient syntax though, we'll add proxy rules to the metadata endpoint in a later step.

## Step 3:  Add Metadata

Now that we've created a dummy endpoint, let's make one that's more useful. Create a new file in your _lambda_ directory called _metadata.js_ and fill it with the same hello world code from before. (Or duplicate the _helloworld.js_ file):

```bash
cp ./lambda/helloworld.js ./lambda/metadata.js
```

Now take a moment to read the _helloworld.js_ file:

```javascript
exports.handler = function(event, context, callback) {
  callback(null, {
    statusCode: 200,
    body: "Hello, World"
  });
};
```

The handler function takes 3 parameters:

-   `event` which is the event that triggers the function
-   `context` which is the context of the event
-   `callback` which ends the request and fills it with content and header information.

We handle requests for our token metadata that follows the format we built into our _Metadata.sol_ contract. That means it's a `GET` request with the token ID built into the route of the URL, like `https://domain.com/metadata/{tokenId}`. To pass `GET` parameters we use a format like `https://domain.com/metadata?tokenId={tokenId}`. We could define our `tokenURI` to follow a format like this, but that's ugly.

Let's work with this format for now and improve it later. We log the event to see if we can find the `tokenId` parameter passed to the URL. This is easier to do in our local setup so follow the URL pattern `http://localhost:9000/metadata?tokenId=666`

Add some `console.log`s to the _metadata.js_ handler function so we can read what's going on in those parameters:

```javascript
exports.handler = function(event, context, callback) {
  console.log("EVENT", event)
  console.log("CONTEXT", context)
  callback(null, {
    statusCode: 200,
    body: "Hello, World"
  });
};
```

Restart the `netlify-lambda` utility (if it's still running) and visit the URL:

```bash
npx netlify-lambda serve lambda
```

If you check the console running the server you see the contents of `event` and `context`, and the `tokenId` under `queryStringParameters`:

```bash
$ npx netlify-lambda serve lambda
netlify-lambda: Starting server
Lambda server is listening on 9000
Hash: 6507b49ec95292f0e68a
Version: webpack 4.27.1
Time: 665ms
Built at: 2018-12-13 19:18:56
        Asset      Size  Chunks             Chunk Names
helloworld.js  1.03 KiB       0  [emitted]  helloworld
  metadata.js  1.08 KiB       1  [emitted]  metadata
Entrypoint helloworld = helloworld.js
Entrypoint metadata = metadata.js
[0] ./helloworld.js 129 bytes {0} [built]
[1] ./metadata.js 195 bytes {1} [built]
Request from ::1: GET /metadata?tokenId=666
EVENT { path: '/metadata',
  httpMethod: 'GET',
  queryStringParameters: { tokenId: '666' },
  headers:
   { host: 'localhost:9000',
     connection: 'keep-alive',
     'cache-control': 'max-age=0',
     'upgrade-insecure-requests': '1',
     'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
     accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
     'accept-encoding': 'gzip, deflate, br',
     'accept-language': 'en-US,en;q=0.9' },
  body: 'W29iamVjdCBPYmplY3Rd',
  isBase64Encoded: true }
CONTEXT {}
Response with status 200 in 8 ms.
```

To be compliant with EIP-721 and EIP-1047, the Token Metadata JSON Schema should follow the following format:

```json
{
    "title": "Asset Metadata",
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "description": "Identifies the asset to which this token represents",
        },
        "description": {
            "type": "string",
            "description": "Describes the asset to which this token represents",
        },
        "image": {
            "type": "string",
            "description": "A URI pointing to a resource with mime type image/* representing the asset to which this token represents. Consider making any images at a width between 320 and 1080 pixels and aspect ratio between 1.91:1 and 4:5 inclusive.",
        }
    }
}
```

Lets try returning this, but replace the name with the `tokenId`, and return an autogenerated image, for example `https://dummyimage.com/600x400/000000/fff/&text=test%20image`.

![](https://dummyimage.com/600x400/000000/fff/&text=test%20image)

```javascript
const tokenId = event.queryStringParameters.tokenId
const metadata =  {
    "name": "Token #" + tokenId,
    "description": "Describes the asset to which this token represents",
    "image": "https://dummyimage.com/600x400/000000/fff/&text=token%20" + tokenId,
}
```

Return it in the `callback` function, and stringify the JSON object before returning it:

```javascript
callback(null, {
    statusCode: 200,
    body: JSON.stringify(metadata)
});
```

When we check our endpoint (and if you have a JSON prettier browser extension) it returns this:

![](https://uc9391e75a390f0c5ffd5451b9c5.previews.dropboxusercontent.com/p/thumb/AAQV6sUZqW5NMGfUXxsgU9nNNozydEKWULiakWO-F0ZNHZN5Ss1RyHps7JEMgAnYd74Kl4AulURfW77iMpYEvedkwy2DCKj0afbs3qwZNjr8DW8fiWCJQLuGz4iCprMVMebw3bjVXCK8TXt_fy3zJKuukq3jsj_MDqXehRP_UcOenS5jowdbgtR-O2sytPPY7SrkP_hYMlisjWe6rYgjGGjwy97NgvCE32wLvO0oRuUaQ3n5N2-qtpgNpLAvXLWdfpttUSH3QFr_XPEImetaKLq_xLGZ1ygjA_iiz4hLBf96eZN0Mxvau6qSi9s-W0k1-UFZaZrYGudnJB7OSL1mb_hE/p.png?size=1600x1200&size_mode=3)

## Step 4: Add proxy routing

On netlify we still use the inconvenient URL format, `/.netlify/functions/metadata?tokenId=666`, to see the new endpoint. Open the _netlify.toml_ file and add some re-write rules so that we can transform a pretty URL like `/metadata/666` into something that our lambda function understands like `/.netlify/functions/metadata?tokenId=666`:

```toml
[build]
  functions = "functions"

[[redirects]]
  from = "/metadata/:tokenId"
  to = "/.netlify/functions/metadata?tokenId=:tokenId"
  status = 200
```

This redirects queries from `/metadata` to whatever is at the location `/.netlify/functions/metadata`. The `:tokenId` placeholder designates that the value should carry over to the same location in the other url. The status it should returns in the header is `200` which means success.

## Step 5: Add opensea.io

To make sure our metadata shows up on sites like opensea we want to serve a format the service understands. The [Opensea docs](https://docs.opensea.io) say they expect metadata that adheres to the following example:

```json
{
  "description": "Friendly OpenSea Creature that enjoys long swims in the ocean.",
  "external_url": "https://openseacreatures.io/3",
  "image": "https://storage.googleapis.com/opensea-prod.appspot.com/puffs/3.png",
  "name": "Dave Starbelly",
  "attributes": [ ... ],
}
```

With an additional `attributes` key that you can populate like:

```json
{
"attributes": [
    {
      "trait_type": "base",
      "value": "starfish"
    },
    {
      "trait_type": "eyes",
      "value": "big"
    },
    {
      "trait_type": "mouth",
      "value": "surprised"
    },
    {
      "trait_type": "level",
      "value": 5
    },
    {
      "trait_type": "stamina",
      "value": 1.4
    },
    {
      "trait_type": "personality",
      "value": "sad"
    },
    {
      "display_type": "boost_number",
      "trait_type": "aqua_power",
      "value": 40
    },
    {
      "display_type": "boost_percentage",
      "trait_type": "stamina_increase",
      "value": 10
    },
    {
      "display_type": "number",
      "trait_type": "generation",
      "value": 2
    }
  ]
}
```

Add some attributes to our endpoint. Maybe our `tokenId` could reflect a zodiac sign:

```javascript
exports.handler = function(event, context, callback) {
  const tokenId = event.queryStringParameters.tokenId
  const metadata =  {
    "name": "Token #" + tokenId,
    "external_url": "https://block-workshop.netlify.com/",
    "description": "This is a very basic NFT with token Id #" + tokenId,
    "image": "https://dummyimage.com/600x400/000000/fff/&text=token%20" + tokenId,
    "attributes": [
      {
        "trait_type": "zodiac",
        "value": returnZodiac(tokenId)
      }
    ]
  }
  callback(null, {
    statusCode: 200,
    body: JSON.stringify(metadata)
  });
};
function returnZodiac(tokenId) {
  const month = ((tokenId - 1) % 12) + 1
  switch(month) {
    case(1):
      return 'Capricorn'
    case(2):
      return 'Aquarius'
    case(3):
      return 'Pisces'
    case(4):
      return 'Aries'
    case(5):
      return 'Taurus'
    case(6):
      return 'Gemini'
    case(7):
      return 'Cancer'
    case(8):
      return 'Leo'
    case(9):
      return 'Virgo'
    case(10):
      return 'Libra'
    case(11):
      return 'Scorpio'
    case(12):
      return 'Sagittarius'
  }
}
```

## Step 6: Add rarebits

Another popular NFT marketplace is [rarebits](https://rarebits.io/). Let's adhere to their format as well:

```json
{
  "name": "Robot token #14",
  "image_url": "https://www.robotgame.com/images/14.png",
  "home_url": "https://www.robotgame.com/robots/14.html",
  "description": "This is the amazing Robot #14, please buy me!",
  "properties": [
    {"key": "generation", "value": 4, type: "integer"},
    {"key": "cooldown", "value": "slow", type: "string"}
  ],
  "tags": ["red","rare","fire"]
}
```

What do you know! It follows it's own spec! You can now see why it's important to maintain flexibility around your metadata endpoint. Until we live in a world that has settled on a standard that everyone uses and isn't hosted on a lambda function on netlify.

Add info to our token so it adheres to rarebits as well:

```javascript
exports.handler = function(event, context, callback) {
  const tokenId = event.queryStringParameters.tokenId
  const metadata =  {

    // both opensea and rarebits
    "name": "Token #" + tokenId,
    "description": "This is a basic NFT with token Id #" + tokenId,

    // opensea
    "external_url": "https://block-workshop.netlify.com/",
    // rarebits
    "home_url": "https://block-workshop.netlify.com/",

    // opensea
    "image": "https://dummyimage.com/600x400/000/fff/&text=token%20" + tokenId,
    // rarebits
    "image_url": "https://dummyimage.com/600x400/000/fff/&text=token%20" + tokenId,

    // opensea
    "attributes": [
      {
        "trait_type": "zodiac",
        "value": returnZodiac(tokenId)
      }
    ],
    // rarebits
    "properties": [
      {"key": "zodiac", "value": returnZodiac(tokenId), type: "string"},
    ],

    // rarebits
    "tags": ["cool","hot","mild"]
  }
  callback(null, {
    statusCode: 200,
    body: JSON.stringify(metadata)
  });
};
```

Now we have a fat json object returned.

![](https://uc3591ee0d156272d6d44a75e14f.previews.dropboxusercontent.com/p/thumb/AAQ6MYlutPXbhs2zT648D1SxsE_EgC4ufuyWWAc8VfD5UAohsfVOep_nB3BdU2hNRWh-M0JhnIh7x-CcmDjG1lPNdINvN2drm_tt8eGhNeyqPIiEb-W1y3v2WzsiKa1lM-NG9WpvcpXNlooKLwOwZxg427x9QYZb3X1YZ7XlT_y9lRf8HBbQSVLyYFEAjgBEFcz44KFz4g5uW8_X1wBloC-Qhsdv9O0x0LFHs1ZJyi5NmztHBkbijUc1n2JKnDsJ_cb898eSpprjuY8unTY07B5g3Pwfg7lM54NDhMrsbnHqh2-hsOtKHOrfziLXM_Xnojqlpx_n2WM3U_RtH-Iq3m65/p.png?size=1600x1200&size_mode=3)

## Step 7: Re-deploy and mint a token

Now we have a metadata API endpoint and we don't have to do anything to service it. We even have a minified website and seeded across a Content Delivery Network. All we're missing is our Token.

When we deployed our Token we used a metadata endpoint that returned `https://domain.com/metadata/{tokenId}`, but `domain.com` isn't our domain! We have to update our metadata endpoint.

Thankfully we built in that ability, and a migration. Inside the _Metadata.sol_ contract update the URI with our netlify subdomain:

```solidity
function tokenURI(uint _tokenId) public pure returns (string memory _infoUrl) {
    string memory base = "https://block-workshop.netlify.com/metadata/";
    string memory id = uint2str(_tokenId);
    return base.toSlice().concat(id.toSlice());
}
```

Run the migration so that only the metadata is replaced, and updated inside of the contract:

```bash
$ truffle migrate --network rinkeby -f 3 --to 3

...

Using network 'rinkeby'.

Running migration: 3_update_metadata.js
  Running step...
  Replacing Metadata...
  ... 0xe596fcf7f20073988c4c57167d19a529b086ddd978ce386bf66485a97f3ad2d9
  Metadata: 0xfb66019e647cec020cf5d1277c81ad463e4574a4
        Metadata deployed at: 0xfb66019e647cec020cf5d1277c81ad463e4574a4
        Token deployed at: 0x1170a2c7d4913d399f74ee5270ac65730ff961bf
  ... 0xc3316fa072e84038ee30c360bc70cdc4107d3fcb74780e33e34b0e117e1534aa
Saving successful migration to network...
  ... 0x416630f6fad98eef2f065014c55ac8b43901ef804435b92d4d02f804a7d4c242
Saving artifacts...
```

Return to our etherscan certified token and mint our first token. You should see that our `updateMetadata` transaction is listed there now.

![](https://uc18af950bb2bbb43caed8ef91a5.previews.dropboxusercontent.com/p/thumb/AAR5ahct-jMZKMnqELbKxvL2F7ccPdf6EsEJTpslZaLR4apXE3pnij17_F9koFQgsyRO2gf-ByPAZQQxCXC5FHCkW81w72fiElR7V2xUFIrRqHiLyMILO9WB5U5bCr67Gzr20WUQhvvxgfhOmDq_tIDsKIRijXpR3BpAXvhQf5IECyMtjg_ulK5rkLsf9tORJXFZr35I3zEzFNHA8N7SrjXL7b3_5RMXw0ooBPysfvuyJDnB_MwDk_elmlPH3RKQjwsex-AExDb7a1poxw_gG-K3ek6hWCsQC94lBjRaZnKw65ICjWnRTZ046IQSOzhKo3UMnfVIq_lLkp8OJ557mN0x/p.png?size=1600x1200&size_mode=3)

Since I'm using a metamask account that is the same as my deploy account, I have permission to mint a token. Open the _write contract_ tab, authenticate with metamask, and mint a token.

![](https://uc6b0904cff6e65b808ed1505ab1.previews.dropboxusercontent.com/p/thumb/AAQ44Gg0Qi2wLm1BXIlj3yYIw0kUijaocI4Nm799pkoXyR9pPicsQtEgIetVruEPo3TM1eF-PucIicmH7801ctrhrelGNl_Oxf_hv-OhUGzIV284I86w3P7-y-G-YSs_iMfPhIAvFiaoU9Ak9e7_KT_lBDjA2rCtM2FdY5A2GXzjTH-pQm92uHV893asK7gZ-3XvLqxYKnOs6DPQgR4GS1i7PJSU8Wp59zZC-mMxfTULkiCmUkwI-RpN5cP22TpA6rDHH5mwG4hHVYVdFa0-T8JCUrcguRwD8Dusv3xTxoDO-_8sQSubAwJ53Z3eAuLWXBoq1WpfF2QvH_EUmSdGj011/p.png?size=1600x1200&size_mode=3)

Since I added my own address as the recipient, I should be the proud owner of token #1. I can check using the token view of etherscan we saw before.

![](https://ucaed88202fd8784b6d7018a39b5.previews.dropboxusercontent.com/p/thumb/AAQf0pl7T0Emb9mjIvRbHSwBBsq5lqSS_qg0ZtixmRwW_bsdbUCpaoJtKz7hLMc45g7qF8TAwUGpCpxOSUzLwhHrvFXJ5v8bDZugB_rVz6l_ngTCuBDgzat1PrsQPHo6wTkE3emYiVF4tx97VNJ4fOTc5cJH1N8AWu5FhROQAjULGsjb_bLeTIhV0kq2qfhG15zhZlQEbNAtd9cMkIJtMnFfKhA_dAI4rc3SlokSa1BflJKAQYTdwsPC3IvAL4GNdiqFBAtpgzBeZbO0y1IMnhSWpvBHaQ-6h3KPNNJwnm4I3KYDwFUTEC8UBDdlYo6RoVdu6_4hGCZ9dN2XP6xOVyiv/p.png?size=1600x1200&size_mode=3)

Wow, there's a token!

Open opensea and see if they've noticed that we exist. With rarebits and opensea you have to request that they track your token before it shows up in the sidebar, but you can skip that by hard coding the contract address in to the URL. Knowing our token address is at `0x1170a2c7d4913d399f74ee5270ac65730ff961bf` and our `tokenId` is `1` we are able to visit the rinkeby version of the URL like this:

<https://rinkeby.opensea.io/assets/0x1170a2c7d4913d399f74ee5270ac65730ff961bf/1>

![](https://www.dropbox.com/s/k6djvdkyms1bctk/Screenshot%202018-12-13%2021.00.28.png?dl=1)

WOW, they even know our token's zodiac sign!

![](https://ucd9dea5ef590eca17a254640713.previews.dropboxusercontent.com/p/thumb/AAQOs-eV4Zp2dA5aEEFe892Fa4UbRwpLIUqsqSMNCJkx3VjDQXspwbxrf39WpHOEoSbPEMLPNULA2ZNA6ersPIr--ke4szSWDW4cQ6tjh0Gk0ms7gU965WxjjvmYIXuwslYqCXjaQSjPBaaHXXE1UiglDPGuSlWoVDLX-XQYAMF7zAf3NWEOVf-5tBhlvZd_Quo8yFVXfnwvrU6ocE-ztMJVDzw2QEbbXOX2WPXkSAuUABYdP8RDZq0Y3HDFxHfecGFMUj2tx5zPGHBghoEoDy-akFkrZ6vDD6ZmUSnqVN5Dv70sSjtb69k5iXScxwpxidE4dA6gX8QXGAijVrxRMi6M/p.png?size=1600x1200&size_mode=3)

Add it to the app officially and we can see it in the rinkeby section.

![](https://ucb4f2d0fe014a038f5db3d4351c.previews.dropboxusercontent.com/p/thumb/AAQyRq7FC8lQ59Z7tPl3K35Z-qjtFHr6AHqs9wPkRcDIrcp9fI3yIAxLIIAozqtpcA2FLe2ILncNbh6eU4UQRF__miLE-OG3BnxZg0H90hi4QVYqhhLKnmDIGSJF2G2uRxYs5ph55VE7lQvx49ClmAMgw1A-lYKbP_ETmgL9Gidz7PsqCFO5_k6QM5X1zHGrU6C1jQOgNJeEIaXUgUBy889XFbJsBkM9SaoUgQROoEA0lRJjGSCT9Saocq4IEEokTUv7NSaRZmT-6b_sl-RfYFJm0GcTkjN4OYXNENYuWJwf1GX2b5AA40RJ8RZwmdiDrG7kP7aiAyyRgUrHcvPXBX3J/p.png?size=1600x1200&size_mode=3)

![](https://uc6721b9fbe8b9e400b0e16a2b2d.previews.dropboxusercontent.com/p/thumb/AAQeFmkQqEaiy9bAlkIy2FV4UsG0vBotkFZ0_Dzn0mh6O2DCuJinbK-n7zlZ1_gdzmI8PBPsSVezc5Iu2vWsSRY1buw7k-a4CNJGUodJ8TvPsnLf55TFwqcymHtVY5v4UmnSBXbTRb3PAnb0TqmlboscKyMFREn-P3eMeKGMKe8y9Gm0Cm8uy-YpWLNLXh1XCzuq8t8UL17bKn3GY7XQILxb_UGSH6CLm90YeIwKRPAVEkjOjbAa0zOwscawB0MnluWXY1uB4snGafdzTUAY9_VGFbh04KM-txa04VC8HAfx4pjF4IVG7pX5h3yP-Itz3KBDK47l0itBTasaLj4oNhfh/p.png?size=1600x1200&size_mode=3)

![](https://ucd9b2861e6e5ca875b4b34c1bc3.previews.dropboxusercontent.com/p/thumb/AAS4FZYKNCr6iW3NaN7sjFFwcZXdod24D8n3DRHq91n0AT8T_aL63FEtjpZXQIHC1o62wnN6ecLfatgZ_1MfopIsfPsMDQUxwE2ppprAnK31XzbeXxocj_4KzxAMSxK1Plg_aeNRYv_gzB7xG4zki_86iPks53c5kOPv8r2IAepGjbmXQUxfW6J6CO_szBAw3K5OiY8FEZ7B6a5UxWzLtbDiIOFrvVrQuUyH5BxWb7caZ08acxtA74Z2_0Hv-Bb68CTVi9uLd5Hma4sga1bXtebf32KDFG_4jPX91zsJSsIyRcneOYrjA7kWHgnvAmhmzdBYmCiNy5gJKZusVNz-OIzq/p.png?size=1600x1200&size_mode=3)

And we're up!

![](https://uc4202e9fca8d3904326cce90f88.previews.dropboxusercontent.com/p/thumb/AASwwB6oLcA9dncl3v72gavD8lsLJgfjAKLIffLx__UvTaC5ojT_et1GnBS1wo5jBCarhHlgrKUCh2MPA6M2wgZw50L-nkco8VAqPJm7X1E3jEiWR6un59p7eW_vzEhWwzKqza13BbHckTOcBbopdM4vnHrz4cmYQ0M4UXUMRXrLIj_C3TkSDOMRt5osnw57zsjwftH47VveoDodLY9ghKQMKEbeiJoPsmXOugTuPau8jVMpk78PJFfM0AJXDlw5_xsQ-rhGyKE5XSQF8VF9YqSZky4wNDumPeM7wPqmLR9FWpZk6yjhe8Y1hiBJcpeTwB1oidz2KQmfhABiWRncfhOv/p.png?size=1600x1200&size_mode=3)

Let's add it to rarebits too.

![](https://ucab4fda645c20b2e7fa248ba66c.previews.dropboxusercontent.com/p/thumb/AAR1iLY0W1VWdK4sYz2n-c7MbZq_jAIHXOIPZeq6vAhUV4NX_uJQ3mSLJISnnE9DuDbJKPwb3l4Kc0fTCUFx0hKPUguXg-iAArEB31U7uP2YawpODPAYuVUkKw_1jfHsz0BkrcVc_UkhTin_cqhHpF5aYvHOMFh9LrO-KihL0T4CjOcvKWNDfOrzrlbzy8pfp3NHzLiN9hCfYPnv5MirGv7NwdazkjueDPKxh_17axql-rsMDUpoMZiZLCo_bnIJ_ksH73WUtGHTbrka565XA66Se6ImDK4nJQRGZb7N-DC4_3Wyd-NjxdmSjkzHvg9rFOnDDG0mzOHsZK1fOVT5REb-/p.png?size=1600x1200&size_mode=3)

![](https://ucb4894f15b87e1d4d2a0f6f9cb9.previews.dropboxusercontent.com/p/thumb/AATeH3f78SkisPzM0BGUke0SSL2PcPKeUYvjB9YPr8IwEmZRiZ8XKWAnCdpmD6_DFb5Mg5ray985x0yaG-5TkxrgRACnqdbN5JYi8Gwom05hnUoIBTnWCYHTSlZfV6k9gde_515kIGIYFcgFF7s-0zwm1IDZ6UEx8jhmMpl7Y4-2TiMHPF_fORqxTzBi2AOYS_UxlBoOjPSlV1YOws8Vpj51M5SFpkq1-GdSpn9rh9CTe71iKSRSBFrR4QwamHPI93s7cGPfZE17OyeFWiMiPvskG4L5PxPIDl278PMH5jJv5FdWaHDqfIGGQgPI3q2oCQpsfLawMH0XJnskp3yOFYwX/p.png?size=1600x1200&size_mode=3)

## Next Steps

-   Make a more interesting generative image
    -   One example is the cloudinary's hue rotate used by ENSNifty.com ([github link](https://github.com/ENS-Nifty/ens-nifty-frontend/blob/master/functions/metadata.js#L73))
-   Add a database to your lambda function for richer metadata
    -   **Bonus**: Get in a fight on Twitter about the meaning of true decentralization!
