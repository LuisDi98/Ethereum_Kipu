// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Storage {
    enum Estado {
        Pendiente, 
        Aprobado, 
        Rechazado
    }

    uint public counter = 0;
    bool internal isFinished = true;

    address owner = 0x742d35Cc6634C0532925a3b844Bc454e4438f44e;

    function setCounter() public {
        counter = 1;
    }
    
    function getCounter() public view returns (uint) {        
        return counter;    
    }

}