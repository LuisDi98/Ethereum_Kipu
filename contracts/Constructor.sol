// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Constructor {
    // Variables del estado
    string private storedInfo;      // String que almacena el contrato
    uint public countChanges = 0;   // Contador de cambios
    address public owner;           // Direccion del owner
    address public lastExecutioner; // Direccion del ultimo que cambio el estado del string

    // Se crea el contrato con un string inicial y asignando la direccion del propietario.
    constructor(string memory _storedInfo) {
        storedInfo = _storedInfo;
        owner = msg.sender;
    }

    // Cambia el estado del string, hace las validaciones de que solo el propietario y solo se puede editar hasta 4 veces
    // aumentando el contafor de cmbios y asignando la direccion del ultimo que hizo los cambios.
    function setInfo(string memory _info) public {
        require(msg.sender == owner, "Solo el propietario puede cambiar storedInfo.");
        require(countChanges < 5, "El valor de storedInfo solo se puede cambiar hasta 4 veces.");
        storedInfo = _info;
        countChanges++;
        lastExecutioner = msg.sender;
    }
    
    // Retorna el estado del string
    function getInfo() external view returns (string memory) {
        return storedInfo;
    }  
}