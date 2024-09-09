// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Catecoin {

    mapping(address => uint) balances;
    string name = "CateCoin";
    string symbol = "CC";
    uint decimals;
    uint maxCoins;
    uint currentCoins;
    address owner;
    bool burnable;
    mapping(address => mapping(address => uint)) allowed;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint _totalCoins) {
        owner = msg.sender;
        currentCoins = 0;
        maxCoins = _totalCoins;
        balances[owner] = maxCoins;
        burnable = false;
        decimals = 18;
    }

    function balanceOf(address _owner) public view returns (uint) {
        return balances[_owner];
    }

    function totalSupply() public view returns (uint) {
        return maxCoins;
    }

    function mint(address _user, uint _coins) public {
        require(maxCoins <= currentCoins+_coins, "Coins would raise more than the maximum value, mint less coins.");
        balances[_user] += _coins;
        currentCoins += _coins;
    }

    function transfer(address _receiver, uint _amount) public {
        require(balances[msg.sender] > _amount, "Not enough balance from sender.");
        balances[_receiver] += _amount;
        balances[msg.sender] -= _amount;
        emit Transfer(msg.sender, _receiver, _amount);
    }

    function approve(address _delegate, uint _amount) public returns (bool) {
        allowed[msg.sender][_delegate] = _amount;
        emit Approval(msg.sender, _delegate, _amount);
        return true;
    }

    function allowance(address _owner, address _delegate) public view returns (uint) {
        return allowed[_owner][_delegate];
    }

    function transferFrom(address _owner, address buyer, uint _amount) public returns (bool) {
        require(_amount <= balances[_owner], "Not enough balance");
        require(_amount <= allowed[_owner][msg.sender], "Not enough balance from allowed");

        balances[_owner] = balances[_owner] - _amount;
        allowed[_owner][msg.sender] = allowed[_owner][msg.sender] - _amount;
        balances[buyer] = balances[buyer] + _amount;
        emit Transfer(_owner, buyer, _amount);
        return true;
    }

}