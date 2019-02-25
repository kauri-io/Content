# Kaleido

Gartner's 2018 CIO Survey revealed that

> "only 1% of surveyed respondents indicated any kind of blockchain adoption within their organizations."

Kaleido fixes that.

Kaleido is a Blockchain Business Cloud that radically simplifies the
creation and operation of private blockchain networks. Offered in
collaboration with AWS, Kaleido is the first Software-as-a-Service
featuring Ethereum packages Geth and Quorum. Kaleido allows enterprises
to build out consortia bootstrap the private blockchain network.

Kaleido provides:

- A link between private networks and the public Ethereum mainnet
- integrated analytics
- support for multiple protocol options and consensus mechanisms
- the ability to seamlessly connect to other popular AWS services
- reduces the cost of real-world projects
- streamlines complex integrations.

Kaleido configures the blockchain SaaS, allowing companies to reduce
cost and/or time for transactions, improve product and system security,
increase transparency, incentivize certain behaviors, increase customer
loyalty, and create new revenue streams.

## Getting started

### Prerequisites

Install the [prerequisites](https://docs.kaleido.io/getting-started/environment-creation/prerequisites/)
onto any client-side machines that needs to interface with the
Ethereum network.

#### REST API

Install the following to interact with the backend microservices and
make use of the python abstraction script:

- [curl](#)
- [jq](#)
- [python & pip](https://www.python.org/downloads/)

#### For applications and CLI

- [node.js & npm](#)
- [Truffle](#)
- [solc](#)
- [Go](#)
- [Geth](https://geth.ethereum.org/downloads/)

## Build your Network

**Option 1**: Create an account on the [Kaleido Dashboard](https://console.kaleido.io/splash). Follow the
step-by-step user interface instructions to build your consortium and
provision nodes provided in the [Create your network](https://docs.kaleido.io/getting-started/environment-creation/create-your-network/)
section.

**Option 2**: Utilize the Kaleido REST API to administratively build out
your network. Use the comprehensive [API 101 tutorial](https://docs.kaleido.io/developer-materials/api-101/)
to create your environment, provision nodes and generate application
credentials.

### Get your API key

Navigate to the [KaleidoConsole](https://console.kaleido.io/settings/apikeys).
Click the _API_ tab at the top of the screen and then select _+ New API Key_ to generate your key.

**Note the key before closing the pop-up, as it is not stored.**

Generate your `Authorization` and `Content-Type`
headers. Replace the `YOUR_API_KEY` placeholder text with the key you
just generated:

```bash
export APIURL="https://console.kaleido.io/api/v1\"
export APIKEY="{YOUR_API_KEY}"
export HDR_AUTH="Authorization: Bearer {YOUR_API_KEY}"
export HDR_CT="Content-Type: application/json"
```

If you wish to host your resources in the EU or Asia Pacific, enumerate
the region in your {APIURL} variable. The `ap` qualifier resolves to
Sydney, while `ko` resolves to Seoul. For example:

```bashs
export APIURL=\"https://console-eu.kaleido.io/api/v1\"\
export APIURL=\"https://console-ap.kaleido.io/api/v1\"\
export APIURL=\"https://console-ko.kaleido.io/api/v1\"
```

### Create a new business consortium

<!-- TODO: Fix -->

_Multi-line_:

curl -H \"\$HDR_AUTH\" -H \"\$HDR_CT\" -s -d \"{ \\\
\\\"name\\\": \\\"api101\\\", \\\
\\\"description\\\": \\\"Automation is great\\\" \\\
}\" \\\
\"\$APIURL/consortia\" \| jq

_Single-line_:

curl -H \"\$HDR_AUTH\" -H \"\$HDR_CT\" -d \'{\"name\":\"api101",
\"description\":\"Automation is Great\"}\' \"\$APIURL/consortia\" \| jq\
\
Example output:

{\
\"name\": \"api101\",\
\"description\": \"Automation is great\",\
\"owner\": \"zzmutk03fu\",\
\"\_id\": \"zzrog1h91c\",\
\"state\": \"setup\",\
\"\_revision\": \"0\",\
\"created_at\": \"2018-05-09T12:24:57.337Z\"\
}

### Create an environment

Create an environment associated with this consortium. A business
consortium will likely have multiple environments for development,
staging, production, etc...

## Next Steps

[Kaleid tutorial](https://docs.kaleido.io/developer-materials/api-101/)

[Kaleido Knowledge base](https://docs.kaleido.io/)
