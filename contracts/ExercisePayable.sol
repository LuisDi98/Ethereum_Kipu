// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ExercisePayable {
    address public owner;
    uint public feeBasisPoints;
    uint public treasury;

    struct User {
        string firstName;
        string lastName;
        uint256 balance;
        bool isRegistered;
    }

    mapping(address => User) public users;

    event UserRegistered(address indexed userAddress, string firstName, string lastName);
    event Deposit(address indexed userAddress, uint256 amount);
    event Withdrawal(address indexed userAddress, uint256 amount, uint256 fee);
    event TreasuryWithdrawal(address indexed owner, uint256 amount);

    modifier onlyRegistered() {
        require(users[msg.sender].isRegistered, "User not registered");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(uint _feeBasisPoints) {
        owner = msg.sender;
        feeBasisPoints = _feeBasisPoints;
    }

    function register(string calldata _firstName, string calldata _lastName) public {
        require(!users[msg.sender].isRegistered, "User already registered");

        users[msg.sender] = User({
            firstName: _firstName,
            lastName: _lastName,
            balance: 0,
            isRegistered: true
        });

        emit UserRegistered(msg.sender, _firstName, _lastName);
    }

    function deposit() public payable onlyRegistered {
        require(msg.value > 0, "Deposit amount must be greater than 0");

        users[msg.sender].balance += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function getBalance() public view onlyRegistered returns (uint256) {
        return users[msg.sender].balance;
    }

    function withdraw(uint256 _amount) public onlyRegistered {
        require(users[msg.sender].balance >= _amount, "Insufficient balance");

        uint256 feeAmount = (_amount * feeBasisPoints) / 10000;
        uint256 netAmount = _amount - feeAmount;

        users[msg.sender].balance -= _amount;
        treasury += feeAmount;

        payable(msg.sender).transfer(netAmount);

        emit Withdrawal(msg.sender, netAmount, feeAmount);
    }

    function withdrawTreasury(uint256 _amount) public onlyOwner {
        require(treasury >= _amount, "Insufficient treasury balance");

        treasury -= _amount;
        payable(owner).transfer(_amount);

        emit TreasuryWithdrawal(owner, _amount);
    }

    function getTreasuryBalance() public view onlyOwner returns (uint256) {
        return treasury;
    }
}
