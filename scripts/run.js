const main = async () => {
    //This will compile our contract and generate the  files we need to work with our contract under the artifacts directory.
    const nftContractFactory = await hre.ethers.getContractFactory('NFT');

    /**
     * What's happening here is Hardhat will create a local Ethereum network for us, but just for this contract.
     *  Then, after the script completes it'll destroy that local network. So, every time you run the contract,
     * it'll be a fresh blockchain. Whats the point? 
     * It's kinda like refreshing your local server every time so you always start from a clean slate which makes it easy to debug errors.
     */
    const nftContract = await nftContractFactory.deploy();
    /**
     * We'll wait until our contract is officially mined and deployed to our local blockchain! 
     * That's right, hardhat actually creates faker "miners" on your machine to try its best to imitate the actual blockchain.
     * The constructor runs when we are deployed
     */
    await nftContract.deployed();
    console.log('Contract deployed to: ', nftContract.address);

    const newNFT = await nftContract.createNFT();
    //Wait for the NFT to be minted
    await newNFT.wait();
}


const runMain = (async () => {
    try {
        await main();
        process.exit(0);
    } catch (err) {
        console.log(err);
        process.exit(1);
    }
})()