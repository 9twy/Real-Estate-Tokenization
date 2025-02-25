// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RealEstateNFT is ERC721 {
    struct Proprty {
        string tokenURI;
        uint256 price;
    }
    uint256 private s_tokenCounter;
    mapping(uint256 => Proprty) private s_tokenIdToProprty;

    constructor() ERC721("RealEstateNFT", "RENFT") {
        s_tokenCounter = 0;
    }

    function mintProprty(string memory tokenUri, uint256 price) external {
        uint256 tokenID = s_tokenCounter;
        _safeMint(msg.sender, tokenID);
        s_tokenIdToProprty[tokenID] = Proprty(tokenUri, price);
    }

    function getPrice(uint256 tokenId) public view returns (uint256) {
        return s_tokenIdToProprty[tokenId].price;
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        return s_tokenIdToProprty[tokenId].tokenURI;
    }
}
