// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block
    address owner;
    address beneficiary;
    uint check_in_block;

    // TODO: Implement constructor
    constructor(address _beneficiary) {
        // Hint: Initialize state variables
        owner=msg.sender;
        beneficiary=_beneficiary;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        // Hint: Update the last check-in block
        check_in_block=block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public payable{
        // Hint: Check if 10 blocks have passed since last check-in
        require(block.number>=10+check_in_block, "10 blocks has not passed");
        uint256 balance = address(this).balance;
        (bool success,)=beneficiary.call{value: balance}("");
        require(success,"Transaction failed");
        // If so, transfer the contract balance to the beneficiary
    }

    // TODO: Implement receive function to allow the contract to receive Ether
    receive() external payable {
       
    }

    // Helper function for testing (optional)
    function getLastCheckInBlock() public view returns (uint256) {
        // TODO: Return the last check-in block
        return check_in_block;
    }

    // Helper function for testing (optional)
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}

//The contract facilitates secure Ether transfer to a designated beneficiary if the owner fails to check in regularly.
// Address of the smart contract deployed on sepolia faucnet=0xec766fE4cf66646BE1D02E98E8BD6105cAe41F52