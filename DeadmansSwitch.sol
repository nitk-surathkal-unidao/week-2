 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch { 
    address private owner;
    address private beneficiary;
    uint private last_check_in;
    constructor(address _beneficiary) {
        owner=msg.sender;
        beneficiary = _beneficiary;
        last_check_in = block.number;
        
    }

    function still_alive() public {
        last_check_in = block.number;
    
    }

    function releaseFunds() public {
        require(block.number > last_check_in + 10);
        payable(beneficiary).transfer(address(this).balance);
    
    }

    receive() external payable {}

    function getLastCheckInBlock() public view returns (uint256) {
        return last_check_in;
    }

    function getCurrentBlock() public view returns (uint256) {
        return block.number;
    }
}
