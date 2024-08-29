// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract PayableTest {

    // Function to receive Ether. msg.data must be empty
    receive() external payable {

    }

    // Fallback function is called when msg.data is not empty
    fallback() external payable {

    }

    //msg.sender address ejecuta el contrato
    //msg.value valor que se está enviando al contrato
    //msg.data

    event ReceiveFunds(uint indexed value);

    //transfer
    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
        //address.transfer(valor)
    }

    //send
    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    //call
    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    //this
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // function receiveFunds() public payable {
    //     require(msg.value > 0, "Not enough funds sent");
    //     (bool sent, ) = address(this).call{value: msg.value}("");
    //     require(sent, "Failed to send Ether");
    // }

    function withdraw(uint _amount) public {
        require(_amount <= address(this).balance, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
    }
}