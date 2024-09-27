// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // State variables
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;

    // Constructor to initialize owner and beneficiary
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    // Function for the owner to signal they're still alive
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can check-in");
        lastCheckInBlock = block.number;
    }

    // Function to release funds to the beneficiary if owner is inactive
    function releaseFunds() public {
        require(block.number > lastCheckInBlock + 10, "Owner is still active");
        payable(beneficiary).transfer(address(this).balance);
    }

    // Receive function to allow the contract to receive Ether
    receive() external payable {}

    // Helper function to get the last check-in block (optional)
    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock;
    }

    // Helper function to get the current block (optional)
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}
