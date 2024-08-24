// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { Bank } from "../src/Account.sol";

contract AccountTest is Test {
    Bank public account;

    function setUp() public {
        account = new Bank();
    }

    function testCreateAccount() public {
        account.createAccount("Naps");
        uint userCount = account.getUserCount();
        console.log("User count is:", userCount);
        assertEq(userCount, 1);
    }

    function testDeposit() public {
        uint256 depositAmount = 10 ether;
        account.deposit{value: depositAmount}();

        uint balance = account.getBalance();
        assertEq(balance, depositAmount, "Balance should be equal to the deposit amount");    
    }

    function testWithdrawal() public {
        // Step 1: Deposit Ether into the account
        uint256 depositAmount = 2 ether;
        account.deposit{value: depositAmount}();

        // Step 2: Withdraw 1 Ether
        uint256 withdrawAmount = 1 ether;
        account.withdraw(payable(address(this)), withdrawAmount);

        // Step 3: Verify remaining balance
        uint balance = account.getBalance();
        assertEq(balance, depositAmount - withdrawAmount, "Balance should be 1 ether after withdrawal");

        // Step 4: Verify the contract's balance after withdrawal
        uint256 contractBalance = address(account).balance;
        assertEq(contractBalance, depositAmount - withdrawAmount, "Contract balance should be 1 ether after withdrawal");
    }

}