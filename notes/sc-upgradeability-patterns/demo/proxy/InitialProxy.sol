//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

abstract contract Upgradeable {
    mapping(bytes4 => uint32) _sizes;
    address _dest;

    function initialize() virtual public ;

    function replace(address target) public {
        _dest = target;
        target.delegatecall(abi.encodeWithSelector(bytes4(keccak256("initialize()"))));
    }
}

contract Dispatcher is Upgradeable {

    constructor(address target) {
        replace(target);
    }

    function initialize() override public{
        // Should only be called by on target contracts, not on the dispatcher
        assert(false);
    }

    fallback() external {
        bytes4 sig;
        assembly { sig := calldataload(0) }
        uint len = _sizes[sig];
        address target = _dest;

        assembly {
            // return _dest.delegatecall(msg.data)
            calldatacopy(0x0, 0x0, calldatasize())
            let result := delegatecall(sub(gas(), 10000), target, 0x0, calldatasize(), 0, len)
            return(0, len) //we throw away any return data
        }
    }
}

contract Example is Upgradeable {
    uint _value;

    function initialize() override public {
        _sizes[bytes4(keccak256("getUint()"))] = 32;
    }

    function getUint() public view returns (uint) {
        return _value;
    }

    function setUint(uint value) public {
        _value = value;
    }
}

/**
 * delegatecall(g, a, in, insize, out, outsize)
 * call contract at address a with input mem[in…(in+insize)) 
 * providing g gas and v wei and output area mem[out…(out+outsize)) 
 * returning 0 on error (eg. out of gas) and 1 on success
 * Also keep caller and callvalue
 */

/**
 * 1. Deploy Example
 * 2. Deploy the Dispatcher using the Example address as the Dispatchers constructor argument.
 * 3. Tell Remix that the Example Contract is now running on the Dispatcher address.
 * 4. Deploy the dispatcher:
 * 5. Use the Example on the Dispatchers address:
 * 6. In Example-via-Dispatcher Contract, set a uint and get a uint
 */