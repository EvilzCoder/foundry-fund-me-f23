//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {Interactions} from "../../script/Interactions.s.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract InteractionTest is Test {
    FundMe public fundMe;
    Interactions public interactions;
    address public USER = makeAddr("user");
    uint256 public constant SEND_VALUE = 0.1 ether;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, SEND_VALUE);
    }

    function testUserCanFundInteraction() public {
        vm.prank(USER);
        vm.deal(USER, SEND_VALUE);

        interactions = new Interactions();
        interactions.fundFundMe(address(fundMe), address(USER));
        assertEq(fundMe.getAddressToAmountFunded(USER), SEND_VALUE);
    }
}
