// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block
    address owner;
    address beneficiary;
    uint lastCheckInBlock;

    // TODO: Implement constructor
    constructor(address _beneficiary) {
        // Hint: Initialize state variables
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public  {
        // Hint: Update the last check-in block
        require(msg.sender == owner, "Owner is allowed Bro !!");
        lastCheckInBlock = block.number;

    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        // Hint: Check if 10 blocks have passed since last check-in
        require(block.number >= lastCheckInBlock + 10);
        payable(beneficiary).transfer(address(this).balance);
        // If so, transfer the contract balance to the beneficiary
    }

    // TODO: Implement receive function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function for testing (optional)
    function getLastCheckInBlock() public view returns (uint256) {
        // TODO: Return the last check-in block
        return lastCheckInBlock;
    }

    // Helper function for testing (optional)
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}
