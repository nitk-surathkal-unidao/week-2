// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block
    address public owner;
    address public beneficiary;
    uint public lastCheckInBlock;
    uint public constant CHECK_IN_PERIOD = 10;

    // TODO: Implement constructor
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        // Hint: Update the last check-in block
        require(msg.sender == owner, "Only owner can check in !!");
        lastCheckInBlock = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary
        require(block.number >= lastCheckInBlock + CHECK_IN_PERIOD, "Check in period not expired !!");
        payable(beneficiary).transfer(address(this).balance);
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