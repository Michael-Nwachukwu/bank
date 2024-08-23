// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Account {

    address owner;
    bool entered;

    modifier customReentrancyGuard() {
        require(!entered);
        entered = true;
        _;
        entered = false;
    }

    constructor () {
        owner = msg.sender;
    }

    struct AccountStruct {
        string name;
        uint balance;
        address accountNumber;
    }

    mapping(address => Account) public accounts;
    mapping(address => uint) public balances;

    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }

    function createAccount(Account _account) public {
        accounts[msg.sender] = _account;
    }

    // function createAccount2(string _name) public {
    //     account = 
    //     accounts[msg.sender] = _account;
    // }

    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    function deposit(address _user) public payable {
        balances[_user] += msg.value;
    }

    function withdraw(address _to) public onlyOwner customReentrancyGuard {
        uint256 acctBalance = balances[msg.sender];
        require(acctBalance > 0, "Low balance");
        balances[msg.sender] = 0;
        (bool sent, bytes memory data) = _to.call{value: acctBalance}("");
        require(sent, "Failed to send Ether");
    }
    
}