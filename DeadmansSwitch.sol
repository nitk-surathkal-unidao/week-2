// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastCheckInBlock;

    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    function still_alive() public {
        require(msg.sender == owner, "Only the owner can call this.");
        lastCheckInBlock = block.number;
    }

    function releaseFunds() public {
        require(block.number > lastCheckInBlock + 10, "Owner is still active.");
        payable(beneficiary).transfer(address(this).balance);
    }

    receive() external payable {}

    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock;
    }

    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}