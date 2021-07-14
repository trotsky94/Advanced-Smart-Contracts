// SPDX-License-Identifier

pragma solidity ^0.8.4;

contract SimpleStorage {
  uint256  public myVariable;

  function set(uint x) public {
    // while(true) {
    //     myVariable = x
    // }  
    // assert(x == 0);
    // if (x % 2 == 0) {
    //     emit Odd();
    // }  else {
    //     emit Even();
    // }
    myVariable = x;
  }

  function get() public view returns (uint) {
    return myVariable;
  }
}