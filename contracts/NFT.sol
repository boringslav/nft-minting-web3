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

        /*
        {title, description,image}
         base64 encode the image, after that base64 encode the entire json object
         */
        _setTokenURI(newTokenId, "data:application/json;base64,eyJ0aXRsZSI6ImJvcmluZ3NsYXYiLCJkZXNjcmlwdGlvbiI6Im1lIiwiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UrQ2lBZ0lDQThjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0ppYkdGamF5SWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStZbTl5YVc1bmMyeGhkand2ZEdWNGRENEtQQzl6ZG1jKyJ9");
        console.log("An NFT /w ID %s has been minted to %s", newTokenId ,msg.sender);
        _tokenIds.increment();
    }


}