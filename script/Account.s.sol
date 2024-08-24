// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Bank} from "../src/Account.sol";

contract CounterScript is Script {
    Bank public account;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        account = new Bank();

        vm.stopBroadcast();
    }
}
