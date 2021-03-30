// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract LostStorage {
    address public myAddress;

    function setAddress(address _address) public {
        myAddress = _address
    }
}

