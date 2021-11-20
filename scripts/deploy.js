const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('NFT');


    const nftContract = await nftContractFactory.deploy();

    await nftContract.deployed();
    console.log('Contract deployed to: ', nftContract.address);

    const newNFT = await nftContract.createNFT();
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