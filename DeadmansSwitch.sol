// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    address owner;
    address beneficiary;
    uint lastCheckInBlock;

    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    function still_alive() public {
        if (msg.sender == owner) {
            lastCheckInBlock = block.number;
        }
    }

    function releaseFunds() public {
        if (block.number > lastCheckInBlock + 10) {
            payable(beneficiary).transfer(address(this).balance);
        }
    }

    receive() external payable {}

    function getLastCheckInBlock() public view returns (uint256) {
        return lastCheckInBlock;
    }

    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}
