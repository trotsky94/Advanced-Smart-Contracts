// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <=0.8.1;

contract Delegator {
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

    event LogResult(bytes result);

    constructor(address delegateAddress, bytes32 _password) {
        owner = msg.sender;
        delegate = delegateAddress;
        password = _password;
    }

    function setVersion(uint256 _newVersion) public {
        bytes memory _abiData =
            abi.encodeWithSignature("setVersion(uint256)", _newVersion);
        /* solium-disable-next-line security/no-low-level-calls*/
        (bool _success, ) = delegate.delegatecall(_abiData);
        require(_success, "external call failed");
    }

    function changeOwner(address _owner) public {
        bytes memory _abiData =
            abi.encodeWithSignature("changeOwner(address)", _owner);
        /* solium-disable-next-line security/no-low-level-calls*/
        (bool _success, ) = delegate.delegatecall(_abiData);
        require(_success, "external call failed");
    }
}
