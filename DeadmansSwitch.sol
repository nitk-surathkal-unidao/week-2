// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block
    address owner;
    address beneficiary;
    uint last_block;

    // TODO: Implement constructor
    constructor(address _beneficiary) payable {
        // Hint: Initialize state variables
        require(_beneficiary != address(0), "Beneficiary cannot be the zero address");
        owner = msg.sender;
        beneficiary = _beneficiary;
        last_block = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        // Hint: Update the last check-in block
        require(msg.sender == owner, "Only the owner can call this function");
        last_block = getCurrentBlock();
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary
        require(getCurrentBlock() > getLastCheckInBlock() + 10, "Owner is still alive!");
        require(address(this).balance > 0, "No funds to release");

        payable(beneficiary).transfer(address(this).balance);
    }

    // TODO: Implement receive function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function for testing (optional)
    function getLastCheckInBlock() public view returns (uint256) {
        // TODO: Return the last check-in block
        return last_block;
    }

    // Helper function for testing (optional)
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}