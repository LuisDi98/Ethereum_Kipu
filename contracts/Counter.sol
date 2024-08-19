// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Counter {

    uint public counter = 0;
    address public owner;

    constructor(uint _counter) {
        counter = _counter;
        owner = msg.sender;
    }
    
    function getCounter() public view returns (uint) {        
        return counter;    
    }

    function setCounter(uint _counter) public {        
        counter = _counter;
    }

    function addCounter() public {
        counter += 1;
    }

}