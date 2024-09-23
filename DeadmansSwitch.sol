// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // Declare state variables
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;
    uint256 public checkInPeriod = 10;  // Number of blocks after which funds are released

    // Constructor to initialize the owner and beneficiary
    constructor(address _beneficiary) {
        owner = msg.sender;  // Owner is the person who deploys the contract
        beneficiary = _beneficiary;  // Beneficiary is passed as an argument
        lastCheckInBlock = block.number;  // Initialize the last check-in block
    }

    // Function to be called by the owner to indicate they are still alive
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can check-in.");
        lastCheckInBlock = block.number;  // Update last check-in block
    }

    // Function to release funds to the beneficiary if enough blocks have passed
    function releaseFunds() public {
        require(block.number > lastCheckInBlock + checkInPeriod, "Owner is still alive or not enough blocks have passed.");
        payable(beneficiary).transfer(address(this).balance);  // Transfer all contract balance to beneficiary
    }

    // Allow contract to receive Ether
    receive() external payable {}

    // Helper function to return the last check-in block
    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock;
    }

    // Helper function to return the current block number
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}
