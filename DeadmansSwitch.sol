// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;

    // Constructor to initialize the beneficiary and set the owner as the contract deployer
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    // Function to be called by the owner to confirm they are still alive
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can call");
        lastCheckInBlock = block.number;
    }

    // Function to release funds to the beneficiary if 10 blocks have passed since the last check-in
    function releaseFunds() public {
        require(block.number > lastCheckInBlock + 10, "Owner is active");
        payable(beneficiary).transfer(address(this).balance);
    }

    // Receive function to allow the contract to receive Ether
    receive() external payable {}

    // Optional helper function for testing: get the last check-in block number
    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock;
    }

    // Optional helper function for testing: get the current block number
    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}
