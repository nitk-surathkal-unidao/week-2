// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;
    uint256 public blockLimit = 10;

    // TODO: Implement constructor
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    // TODO: Implement still_alive function
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can call this function");
        lastCheckInBlock = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        require(block.number > lastCheckInBlock + blockLimit, "Owner is still alive!");
        payable(beneficiary).transfer(address(this).balance);
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
