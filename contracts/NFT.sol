//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract NFT is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We need to pass the name of our NFTs token and it's symbol.
    constructor() ERC721("SlavNFT", "SNFT"){
        console.log("First contract...");
    }

    function createNFT() public {
        uint newTokenId = _tokenIds.current();

        _safeMint(msg.sender, newTokenId);
        //The tokenURI is where the actual NFT data lives. And it usually links to a JSON file called the metadata
        _setTokenURI(newTokenId, "https://jsonkeeper.com/b/DDFV");
        console.log("An NFT /w ID %s has been minted to %s", newTokenId ,msg.sender);
        _tokenIds.increment();
    }


}