    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract DeadmansSwitch {
        // TODO: Declare state variables
        // Hint: You'll need variables for the owner, beneficiary, and last check-in block
        address beneficiary;
        address owner;
        uint256 lastCheckIn;
        // TODO: Implement constructor
        constructor(address _beneficiary) {
            // Hint: Initialize state variables
            beneficiary = _beneficiary;
            owner = msg.sender;
            lastCheckIn = block.number;
        }

        // TODO: Implement still_alive function
        function still_alive() public {
            // Hint: Update the last check-in block
            require(msg.sender == owner,"Only owner can send still_alive calls");
            lastCheckIn=block.number;   
        }

        // TODO: Implement release funds function
        function releaseFunds() public {
            // Hint: Check if 10 blocks have passed since last check-in
            // If so, transfer the contract balance to the beneficiary
            require(block.number > 10 + lastCheckIn,"Owner is Still alive"); // checking whether the period is over
            require(address(this).balance > 0,"No balance to transfer");
            payable(beneficiary).transfer(address(this).balance);

        }
        // event received(address , uint);
        // TODO: Implement receive function to allow the contract to receive Ether
        receive() external payable {}

        // Helper function for testing (optional)
        function getLastCheckInBlock() public view returns (uint256) {
            // TODO: Return the last check-in block
            return lastCheckIn;
        }

        // Helper function for testing (optional)
        function getCurrentBlock() public view returns (uint256) {
            return block.number;
        }
    }