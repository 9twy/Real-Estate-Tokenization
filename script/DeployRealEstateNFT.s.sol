// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script, console} from "forge-std/Script.sol";
import {RealEstateNFT} from "../src/RealEstateNFT.sol";
import {Fractionalizer} from "../src/Fractionalizer.sol";

contract DeployRealEstateNFT is Script {
    string tokenUri = "ipfs://QmQ2frTMVmHQuU328e8cSNRu8zvaPYk7LkrXsziKSjqbpG";
    uint256 price = 100 ether;
    address public deployer = address(1);

    function run() external returns (RealEstateNFT, Fractionalizer) {
        vm.startBroadcast();
        RealEstateNFT realEstate = new RealEstateNFT();

        realEstate.mintProprty(tokenUri, price);

        Fractionalizer fractionalizer = new Fractionalizer(
            address(realEstate),
            0,
            "Property Shares",
            "SHARE"
        );
        realEstate.approve(address(fractionalizer), 0); // Token ID 1

        vm.stopBroadcast();

        return (realEstate, fractionalizer);
    }
}
