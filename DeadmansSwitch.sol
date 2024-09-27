// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block
    address public owner;
    address public beneficiary;
    uint public lastCheckinBlock;

    // TODO: Implement constructor
    constructor(address _beneficiary) {
        // Hint: Initialize state variables
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckinBlock = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        // Hint: Update the last check-in block
        require(msg.sender == owner);
        lastCheckinBlock = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary
        require(block.number > lastCheckinBlock + 10);
        payable(beneficiary).transfer(address(this).balance);
    }

    // TODO: Implement receive function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function for testing (optional)
    function getLastCheckInBlock() public view returns (uint256) {
        // TODO: Return the last check-in block
        return lastCheckinBlock;
    }

    // Helper function for testing (optional)
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}