// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // State variables
    address public owner;            // Owner of the contract
    address public beneficiary;      // Beneficiary to receive funds
    uint256 public lastCheckInBlock; // The block number when the owner last checked in

    // Block interval that determines how long the owner has to check in
    uint256 public constant blockInterval = 10;

    // Boolean flag to indicate if the contract is deactivated
    bool public isDeactivated = false;

    // Constructor to initialize the contract with the beneficiary's address
    constructor(address _beneficiary) {
        owner = msg.sender;           // The deployer is the owner
        beneficiary = _beneficiary;   // The beneficiary address is provided during deployment
        lastCheckInBlock = block.number; // Set last check-in block to current block at deployment
    }

    // Function to let the owner check in, proving they are still alive
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can call this function");
        require(!isDeactivated, "Contract is deactivated");
        lastCheckInBlock = block.number;  // Update the last check-in block to the current block
    }

    // Function to release funds to the beneficiary if the owner hasn't checked in for 10 blocks
    function releaseFunds() public {
        // Check if the contract is deactivated
        require(!isDeactivated, "Contract is deactivated");

        // Check if 10 blocks have passed since the last check-in
        require(block.number > lastCheckInBlock + blockInterval, "Owner is still alive");

        // Transfer all the contract's balance to the beneficiary
        payable(beneficiary).transfer(address(this).balance);

        // Mark the contract as deactivated to prevent further actions
        isDeactivated = true;
    }

    // Function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function to get the last check-in block number
    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock;
    }

    // Helper function to get the current block number
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}
