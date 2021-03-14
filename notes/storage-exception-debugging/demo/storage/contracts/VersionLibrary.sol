// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <=0.8.1;

contract VersionLibrary {
    // slot 0
    bytes1 public val1; 
    uint8 public val2; 
    bool public val3; 
    address public val4;
    // slot 1 
    bytes32 password; 
    // slot 2
    address public owner;
    // slot 3
    address public delegate; // contract to delegate calls to
    uint public version = 1;
    

    function setVersion(uint newVersion)   public {
        version = newVersion;
    }

    function changeOwner(address _owner) public {
        owner = _owner;
    }
}
