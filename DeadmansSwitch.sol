// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./Owner.sol";

contract DeadmansSwitch is Owner {
    address beneficiary;
    uint256 lastCheckInBlock;

    constructor(address _beneficiary) {
        beneficiary = _beneficiary;
        lastCheckInBlock = block.number;
    }

    function still_alive() public isOwner{
        lastCheckInBlock = block.number;
    }

    // TODO: Implement release funds function
    function releaseFunds() public {
        require(block.number >= lastCheckInBlock + 10, "10 blocks have not passed yet");
        payable(beneficiary).transfer(address(this).balance);
    }

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
