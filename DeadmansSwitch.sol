// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;
    uint256 private constant BLOCKS_THRESHOLD = 10; // I am using Sepolia

    uint256 private constant SEPOLIA_CHAIN_ID = 11155111;

    // TODO: Implement constructor
    constructor(address _beneficiary) {
        require(block.chainid == SEPOLIA_CHAIN_ID, "This contract must be deployed on Sepolia");
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can call this function");
        require(block.chainid == SEPOLIA_CHAIN_ID, "This function can only be called on Sepolia");
        lastCheckInBlock = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary
        require(block.chainid == SEPOLIA_CHAIN_ID, "This function can only be called on Sepolia");
        require(block.number > lastCheckInBlock + BLOCKS_THRESHOLD, "Not enough blocks have passed");
        uint256 balance = address(this).balance;
        payable(beneficiary).transfer(balance);
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