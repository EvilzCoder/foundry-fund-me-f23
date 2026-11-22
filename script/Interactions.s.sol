//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract Interactions is Script {
    FundMe fundMe;
    uint256 public constant SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostrecentDeployed, address sender) public {
        vm.startBroadcast(sender);
        fundMe = FundMe(payable(mostrecentDeployed));
        fundMe.fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe contract with %s", SEND_VALUE);
    }
}
