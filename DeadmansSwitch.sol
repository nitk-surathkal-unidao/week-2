// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    address public owner;
    address public beneficiary;
    uint lastBlock;
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block

    // TODO: Implement constructor
    constructor(address _beneficiary) {
        // Hint: Initialize state variables
        _beneficiary = beneficiary;
        owner = msg.sender;
        lastBlock = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        // Hint: Update the last check-in block
        lastBlock = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary
        require(block.number >= lastBlock + 10);
        payable(beneficiary).transfer(address(this).balance);

    }

    // TODO: Implement receive function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function for testing (optional)
    function getLastCheckInBlock() public view returns (uint256) {
        // TODO: Return the last check-in block
        return lastBlock;
    }

    // Helper function for testing (optional)
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}