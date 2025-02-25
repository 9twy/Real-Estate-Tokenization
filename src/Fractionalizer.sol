// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {RealEstateNFT} from "src/RealEstateNFT.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Fractionalizer is ERC20 {
    IERC721 public nft;
    uint256 public tokenId;
    uint256 public initialPrice;
    uint256 public constant TOTAL_SHARES = 1_000_000 * 1e18; // 1M tokens
    error Fractionalizer__MustBeMoreOneToken();
    error Fractionalizer__InsufficientETHSent();
    address private deployer;

    constructor(
        address _nftAddress,
        uint256 _tokenId,
        string memory _erc20Name,
        string memory _erc20Symbol
    ) ERC20(_erc20Name, _erc20Symbol) {
        deployer = msg.sender;
        nft = IERC721(_nftAddress);
        tokenId = _tokenId;
        initialPrice = RealEstateNFT(_nftAddress).getPrice(_tokenId);

        _mint(msg.sender, TOTAL_SHARES);

        _approve(msg.sender, address(this), TOTAL_SHARES);
    }

    function lockNFT() external {
        nft.transferFrom(msg.sender, address(this), tokenId);
    }

    function buyTokens(uint256 numberOfTokens) external payable {
        if (numberOfTokens <= 0) {
            revert Fractionalizer__MustBeMoreOneToken();
        }
        uint256 pricePerToken = initialPrice / TOTAL_SHARES;
        uint256 requiredEth = pricePerToken * numberOfTokens;

        if (msg.value < requiredEth) {
            revert Fractionalizer__InsufficientETHSent();
        }
        transferFrom(deployer, msg.sender, numberOfTokens);
        if (msg.value > requiredEth) {
            payable(msg.sender).transfer(msg.value - requiredEth);
        }
        payable(deployer).transfer(requiredEth);
    }
}
