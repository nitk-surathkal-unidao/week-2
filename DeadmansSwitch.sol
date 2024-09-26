// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block

    address owner;
    address benefitiary;
    uint256 last_check;
    uint256 checkintime = 10;
    // TODO: Implement constructor
    constructor(address _beneficiary) payable  {
        // Hint: Initialize state variables
        owner = msg.sender;
        benefitiary = _beneficiary;
        last_check = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        // Hint: Update the last check-in block
        require(owner == msg.sender, "Owner Can only check in!");
        last_check = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary
        require(block.number > last_check  + checkintime, "Owner is still Alive or checkin period not passed");
        uint256 balance = address(this).balance;
        payable(benefitiary).transfer(balance);
    }

    // TODO: Implement receive function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function for testing (optional)
    function getLastCheckInBlock() public view returns (uint256) {
        // TODO: Return the last check-in block
        return last_check;
    }

    // Helper function for testing (optional)
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}