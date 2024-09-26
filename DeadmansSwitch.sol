// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block
    address public owner;           // Address of the owner of the contract
    address  beneficiary;     // Address that will receive the funds if owner is inactive
    uint  lastCheckInBlock; // Block number of the last check-in


    //initiate event so that we know that transfer is successfull
    event FundsReleased(address beneficiary, uint256 amount);
    //modifier(only owner) so that no one with contract address can tranfer money to himself
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    // TODO: Implement constructor
    constructor(address _beneficiary) {
        // Hint: Initialize state variables
        owner = msg.sender;          //to make the owner (who is deploying)
        beneficiary = _beneficiary;  
        lastCheckInBlock = block.number; // Initialize last check-in block to the current block
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        // Hint: Update the last check-in block
        lastCheckInBlock = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public  {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary
        require(block.number > lastCheckInBlock + 10,"owner iis still active :)");
         // Get the contract's balance
        uint contractBalance;
        contractBalance = address(this).balance;

        // Ensure the contract has funds to release
        require(contractBalance > 0, "No funds to release");

        address payable beneficiaryAddress = payable(beneficiary);
        beneficiaryAddress.transfer(contractBalance);


        // launching the event to alert that funds are transferred
        emit FundsReleased(beneficiary, contractBalance);
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