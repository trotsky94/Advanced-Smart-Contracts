// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

contract LostStorage {
    address public myAddress;
    uint public myUint;

    function setAddress(address _address) public {
        myAddress = _address;
    }

    function setMyUint(uint _uint) public {
        myUint = _uint;
    }

}

contract ProxyClash {
    address public otherContractAddress;

    constructor(address _otherContract) {
        otherContractAddress = _otherContract;
    }

    function setOtherAddress(address _otherContract) public {
        otherContractAddress = _otherContract;
    }

  fallback() external {
    address _impl = otherContractAddress;

    assembly {
      let ptr := mload(0x40)
      calldatacopy(ptr, 0, calldatasize())
      let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
      let size := returndatasize()
      returndatacopy(ptr, 0, size)

      switch result
      case 0 { revert(ptr, size) }
      default { return(ptr, size) }
    }
  }
}

/**
 * 1. Deploy the LostStorage Contract
 * 2. Deploy the Proxy, setting the LostStorage contract address as the constructor argument
 * 3. Tell Remix that the LostStorage is running on the Proxy address
 * 4. Call myAddress(). returns a non-zero address!. Collision.
 */