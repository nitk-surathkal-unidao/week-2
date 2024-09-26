// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    // TODO: Declare state variables
    // Hint: You'll need variables for the owner, beneficiary, and last check-in block

    address public owner;
    address public beneficiary;
    uint public lastCheckInBlock;


            
    // TODO: Implement constructor
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary= _beneficiary;
        lastCheckInBlock=getCurrentBlock();

    }

    // TODO: Implement still_alive function
    function still_alive() public  {
        require(owner==msg.sender);
        lastCheckInBlock= getCurrentBlock();
    }

    // TODO: Implement release funds function
    function releaseFunds(address payable _beneficiary, address _owner) public  {
        // Hint: Check if 10 blocks have passed since last check-in
        // If so, transfer the contract balance to the beneficiary
         require(block.number > (lastCheckInBlock + 10));
         _beneficiary.transfer(_owner.balance);
        
      
    }

    // TODO: Implement receive function to allow the contract to receive Ether
    receive() external payable { }

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