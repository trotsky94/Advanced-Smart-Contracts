// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;


contract MySmartContract {
    uint32 public counter;
    address private owner;

    /**
    @dev Enforces the caller to be the contract's owner.
    */
    modifier isOwner {
        require(msg.sender == owner, "Sender is not owner.");
        _;
    }

    constructor(uint32 _counter) public {
        counter = _counter; // Allows setting counter's initial value on deployment.
        // Sets the contract's owner as the address that deployed the contract.
        owner = msg.sender;
    }

    /**
    @notice Increments the contract's counter if contract is active.
    @dev It will revert is the contract is stopped. Create a modifier "isNotStopped"
    */
    function incrementCounter() public {
        counter++; // Fixes bug introduced in version 1.
    }
}
