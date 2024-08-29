// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract ExercisePayable {

    mapping(address => uint) public balances;

    function addValueToUser() public{
        balances[msg.sender] = 1000;
    }

    function getValueFromUser() public view returns(uint){
        return balances[msg.sender];
    }

    //mapping
    //payable
    //modifiers

    receive() external payable {

    }

    fallback() external payable {

    }

    //funcion para enviar ether al contrato
    //asigna esos fondos a un usuario
    //guardamos en mapping el address -> balance actual del usuario
    //modifier chequear que msg.value > 0

    //withdrawUserFunds
    //required fundsForUser[msg.value] >= _fundsToWithdraw
    
    function withdrawBalance(uint _amount) public {
        require(balances[msg.sender] >=_amount, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
    }

    function withdraw(uint _amount) public {
        require(_amount <= address(this).balance, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
    }

    function sendValueToUser() public payable {
        balances[msg.sender] += msg.value;
    }

    function getBalanceForUser(address _userAddress) public view returns(uint) {
        return balances[_userAddress];
    }

}