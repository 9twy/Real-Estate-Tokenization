// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Script.sol";
import {DeployRealEstateNFT} from "../script/DeployRealEstateNFT.s.sol";
import {Fractionalizer} from "../src/Fractionalizer.sol";
import {RealEstateNFT} from "../src/RealEstateNFT.sol";

contract FractionalizerTest is Test {
    string tokenUri = "ipfs://QmQ2frTMVmHQuU328e8cSNRu8zvaPYk7LkrXsziKSjqbpG";
    address USER = makeAddr("user");
    DeployRealEstateNFT deployer;
    RealEstateNFT realEstate;
    Fractionalizer fractionalizer;
    uint256 public constant INITIAL_PRICE = 100 ether;
    uint256 public constant TOTAL_SHARES = 1_000_000 * 1e18;
    address public constant DEPLOYER_ADDRESS = address(1);

    function setUp() public {
        deployer = new DeployRealEstateNFT();
        (realEstate, fractionalizer) = deployer.run();
    }

    function _lockNFT() internal {
        vm.prank(DEPLOYER_ADDRESS);
        realEstate.approve(address(fractionalizer), 0);

        // Transfer NFT to Fractionalizer
        vm.prank(DEPLOYER_ADDRESS);
        fractionalizer.lockNFT();
    }

    function testInitialization() public {
        assertEq(fractionalizer.name(), "Property Shares");
        assertEq(fractionalizer.symbol(), "SHARE");
        assertEq(fractionalizer.balanceOf(DEPLOYER_ADDRESS), TOTAL_SHARES);
        assertEq(fractionalizer.initialPrice(), INITIAL_PRICE);
    }

    function testLockNFT() public {
        assertEq(realEstate.ownerOf(0), DEPLOYER_ADDRESS);

        _lockNFT();

        assertEq(realEstate.ownerOf(0), address(fractionalizer));
    }
}
