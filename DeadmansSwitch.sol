// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;

    // initialize the contract with the beneficiary's address
    constructor(address _beneficiary) {
        owner = msg.sender; 
        beneficiary = _beneficiary; // Initialize the beneficiary
        lastCheckInBlock = block.number; 
    }

    // Function for the owner to check in and update the last check-in block
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can check in");
        lastCheckInBlock = block.number; 
    }

    // Function to release funds to the beneficiary if 10 blocks have passed since the last check-in
    function releaseFunds() public {
        require(block.number >= lastCheckInBlock + 10, "Not enough time has passed");
        payable(beneficiary).transfer(address(this).balance);
    }

    // Function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function to get the last check-in block for testing
    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock; 
    }
    
    // Helper function to get the current block number for testing
    function getCurrentBlock() public view returns (uint256) {
        return block.number; 
    }
}

