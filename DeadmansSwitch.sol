// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block

    // created variables to store address of owner and benificiery, and variable to keep track of last block's number
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;
    

    // TODO: Implement constructor
    constructor(address _beneficiary) {
        // Hint: Initialize state variables

        // constructor called when contract is initialized, so check who initialized the contract
        // require(msg.sender == owner);
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        // Hint: Update the last check-in block

        // if still alive is called then update when the last block was called.
        lastCheckInBlock = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary

        // require syntax require(condition, error_msg);
        require((lastCheckInBlock >= block.number + 10), "Not enough blocks passed");
        (bool success, ) = payable(beneficiary).call{value: address(this).balance}("");
        require(success, "Fund transfer failed!");

        // if(lastCheckInBlock >= block.number + 10) {
        //     (bool success, ) = beneficiary.call{value: owner.balance}("");
        //     require(success, "Payment Failed!");
        // }
    }

    // TODO: Implement receive function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function for testing (optional)
    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock;
    }

    // Helper function for testing (optional)
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}