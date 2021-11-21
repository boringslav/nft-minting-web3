//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string[] firstWords = ["Pancake", "Pizza", "Muffin", "Popcorn"];
    string[] secondWords = ["Crocodile", "Iguana", "Lion", "Rat"];
    string[] thirdWords = ["Bicycle", "Cabrio", "Tank", "Taxi"];


    // This is our SVG code. All we need to change is the word that's displayed. Everything else stays the same.
    // So, we make a baseSvg variable here that all our NFTs can use.
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";


    // We need to pass the name of our NFTs token and it's symbol.
    constructor() ERC721("SlavNFT", "SNFT"){
        console.log("First contract...");
    }

    function pickRandomWord(string[] memory _wordArray, uint _tokenId, string memory _randomWord) public pure returns(string memory) {
        uint rand = random(string(abi.encodePacked(_randomWord, Strings.toString(_tokenId))));
        rand = rand % _wordArray.length;
        return _wordArray[rand];

    }

    function random(string memory input) internal pure returns(uint) {
        return uint(keccak256(abi.encodePacked(input)));
    }

    function createNFT() public {
        uint newTokenId = _tokenIds.current();
        string memory first = pickRandomWord(firstWords, newTokenId, "fiiiirst");
        string memory second = pickRandomWord(secondWords, newTokenId, "secooond");
        string memory third = pickRandomWord(thirdWords, newTokenId, "thhhiiird");

        string memory finalSvg = string(abi.encodePacked(baseSvg,first,second,third,"</text></svg>"));
        console.log('FinalSvg: ', finalSvg);

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