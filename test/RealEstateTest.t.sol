// SPDX-License-Identifier: NIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployRealEstateNFT} from "../script/DeployRealEstateNFT.s.sol";
import {RealEstateNFT} from "../src/RealEstateNFT.sol";
import {Fractionalizer} from "../src/Fractionalizer.sol";

contract RealEstateTest is Test {
    string tokenUri = "ipfs://QmQ2frTMVmHQuU328e8cSNRu8zvaPYk7LkrXsziKSjqbpG";
    uint256 price = 100 ether;
    address USER = makeAddr("user");
    DeployRealEstateNFT deployer;
    RealEstateNFT realEstate;
    Fractionalizer fractionalizer;

    function setUp() public {
        deployer = new DeployRealEstateNFT();
        (realEstate, fractionalizer) = deployer.run();
    }

    function testNameCorrect() public view {
        string memory expectedName = "RealEstateNFT";
        string memory acutalName = realEstate.name();
        assertEq(expectedName, acutalName);
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        assert(
            keccak256(abi.encodePacked(tokenUri)) ==
                keccak256(abi.encodePacked(realEstate.getTokenURI(0)))
        );
        assertEq(price, realEstate.getPrice(0));
    }
}
