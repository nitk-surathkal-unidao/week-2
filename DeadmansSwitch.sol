// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;
    uint256 public checkInPeriod = 10; // Number of blocks before funds can be released

    // Constructor to initialize the beneficiary and owner
    constructor(address _beneficiary) {
        owner = msg.sender; // Owner is the one who deploys the contract
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number; // Set the initial check-in to the deployment block
    }

    // Function to update the last check-in block
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can check-in");
        lastCheckInBlock = block.number;
    }

    // Function to release the funds to the beneficiary if the owner is inactive for 10 blocks
    function releaseFunds() public {
        require(block.number > lastCheckInBlock + checkInPeriod, "Check-in period has not passed");
        require(address(this).balance > 0, "No funds to transfer");

        payable(beneficiary).transfer(address(this).balance);
    }

    // Allow the contract to receive Ether
    receive() external payable {}

    // Helper function to get the last check-in block
    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock;
    }

    // Helper function to get the current block number
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}
