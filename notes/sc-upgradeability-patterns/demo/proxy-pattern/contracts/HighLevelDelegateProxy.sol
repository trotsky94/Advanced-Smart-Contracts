// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract BaseStateLayout {
  address public currentVersion;
  address public owner;
}

contract HighLevelDelegateProxy is BaseStateLayout {
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  constructor(address initAddr) public{
    require(initAddr != address(0));
    currentVersion = initAddr;
    owner = msg.sender; // this owner may be another contract with multisig, not a single contract owner
  }

  function upgrade(address newVersion) public onlyOwner()
  {
    require(newVersion != address(0));
    currentVersion = newVersion;
  }

  fallback() external payable {
    (bool success, ) = address(currentVersion).delegatecall(msg.data);
    require(success);
  }

  receive() external payable {

  }
}

contract HighLevelLogicContract is BaseStateLayout {
    uint public counter;

    function incrementCounter() public{
        counter++;
    }
}