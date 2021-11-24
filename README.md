
## **Mint your own NFT collection and ship a Web3 app to show them off - buildspace project**
[Buildspace website](https://buildspace.so/)

### How to run the project:

### dotenv variables:

***`ALCHEMY_KEY`*** - alchemy project key

***`METAMASK_PRIVATE_KEY`*** - Your MetaMask wallet private key

***`ETHERSCAN_PROJECT_KEY`*** - You can run the application without this variable

### Commands for running the project:

`***npm install***` (root directory)

`***npm install***` (frontend directory)

`***npm start***` (frontend directory)

`***npx hardhat run ./scripts/deploy.js***`  - compile and deploy the contract on Rinkeby test network (you need to copy the address from console and set the CONTRACT_ADDRESS variable in App.js + you need to copy the contract abi and paste it frontend/utils/NFT.json)

![https://tokens.buildspace.so/assets/CHbdfb992f-80ca-44a4-b7f7-54bb0365ff50-205/render.png](https://tokens.buildspace.so/assets/CHbdfb992f-80ca-44a4-b7f7-54bb0365ff50-205/render.png)
