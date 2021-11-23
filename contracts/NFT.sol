//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import {Base64} from "./libraries/Base64.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string[] firstWords = ["Pancake", "Pizza", "Muffin", "Popcorn"];
    string[] secondWords = ["Crocodile", "Iguana", "Lion", "Rat"];
    string[] thirdWords = ["Bicycle", "Cabrio", "Tank", "Taxi"];

    event NewNFTMinted(address sender, uint256 tokenId);

    // This is our SVG code. All we need to change is the word that's displayed. Everything else stays the same.
    // So, we make a baseSvg variable here that all our NFTs can use.
    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // We need to pass the name of our NFTs token and it's symbol.
    constructor() ERC721("SlavNFT", "SNFT") {
        console.log("First contract...");
    }

    function pickRandomWord(
        string[] memory _wordArray,
        uint256 _tokenId,
        string memory _randomWord
    ) public pure returns (string memory) {
        uint256 rand = random(
            string(abi.encodePacked(_randomWord, Strings.toString(_tokenId)))
        );
        rand = rand % _wordArray.length;
        return _wordArray[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function createNFT() public checkNFTCount {
        uint256 newTokenId = _tokenIds.current();
        string memory first = pickRandomWord(
            firstWords,
            newTokenId,
            "fiiiirst"
        );
        string memory second = pickRandomWord(
            secondWords,
            newTokenId,
            "secooond"
        );
        string memory third = pickRandomWord(
            thirdWords,
            newTokenId,
            "thhhiiird"
        );
        string memory finalWord = string(
            abi.encodePacked(first, second, third)
        );

        string memory finalSvg = string(
            abi.encodePacked(baseSvg, first, second, third, "</text></svg>")
        );
        console.log("FinalSvg: ", finalSvg);

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        finalWord,
                        '", "description": "A highly acclaimed collection of slavs", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("Token Uri", finalTokenUri);

        _safeMint(msg.sender, newTokenId);

        _setTokenURI(newTokenId, finalTokenUri);
        console.log(
            "An NFT /w ID %s has been minted to %s",
            newTokenId,
            msg.sender
        );
        _tokenIds.increment();
        emit NewNFTMinted(msg.sender, newTokenId);
    }

    modifier checkNFTCount() {
        require(_tokenIds.current() + 1 <= 5);
        _;
    }
}
