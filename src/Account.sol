// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Bank {

    address owner;
    bool entered;
    uint public userCount = 0;

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

    mapping(address => AccountStruct) public accounts;

    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }

    event DepositLog(address from, uint amount);
    event WithdrawLog(address to, uint amount);
    event CreateAccountLog(AccountStruct);

    function createAccount(string memory _name) public {

        require(accounts[msg.sender].accountNumber == address(0), "User exists");
        
        accounts[msg.sender] = AccountStruct({
            name: _name,
            balance: 0,
            accountNumber: msg.sender
        });

        userCount++;

        emit CreateAccountLog(accounts[msg.sender]);
    }

    function getUserCount() public view returns (uint) {
        return userCount;
    }

    function getBalance() public view returns (uint) {
        return accounts[msg.sender].balance;
    }

    function deposit() public payable {
        accounts[msg.sender].balance += msg.value;
        emit DepositLog(msg.sender, msg.value);
    }

    function withdraw(address _to, uint _amount) public onlyOwner customReentrancyGuard {
        uint256 acctBalance = accounts[msg.sender].balance;
        require(acctBalance > 0, "Low balance");
        accounts[msg.sender].balance = 0;

        (bool sent, bytes memory data) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");

        accounts[msg.sender].balance -= _amount;

        emit WithdrawLog(_to, acctBalance);
    }


    
}