//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

contract Proxy {
    // Code position in storage is keccak256("PROXIABLE") = "0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7"
    constructor(bytes memory constructData, address contractLogic) {
        // save the code address
        assembly { // solium-disable-line
            sstore(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7, contractLogic)
        }
        (bool success, bytes memory result ) = contractLogic.delegatecall(constructData); // solium-disable-line
        require(success, "Construction failed");
    }

    fallback() external payable {
        assembly { // solium-disable-line
            let contractLogic := sload(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7)
            calldatacopy(0x0, 0x0, calldatasize())
            let success := delegatecall(sub(gas(), 10000), contractLogic, 0x0, calldatasize(), 0, 0)
            let retSz := returndatasize()
            returndatacopy(0, 0, retSz)
            switch success
            case 0 {
                revert(0, retSz)
            }
            default {
                return(0, retSz)
            }
        }
    }
}

contract Proxiable {
    // Code position in storage is keccak256("PROXIABLE") = "0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7"

    function updateCodeAddress(address newAddress) internal {
        require(
            bytes32(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7) == Proxiable(newAddress).proxiableUUID(),
            "Not compatible"
        );
        assembly { // solium-disable-line
            sstore(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7, newAddress)
        }
    }

    function proxiableUUID() public pure returns (bytes32) {
        return 0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7;
    }
} 

contract MyContract {

    address public owner;
    uint public myUint;

    function constructor1() public {
        require(owner == address(0), "Already initalized");
        owner = msg.sender;
    }

    function increment() public {
        //require(msg.sender == owner, "Only the owner can increment"); //someone forget to uncomment this
        myUint++;
    }
}

contract MyFinalContract is MyContract, Proxiable {

    function updateCode(address newCode) onlyOwner public {
        updateCodeAddress(newCode);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner is allowed to perform this action");
        _;
    }
}

/**
 * 1. Deploy the MyFinalContract
 * 2. Deploy the Proxy, argument is the MyFinalContract Address and as a calldata the 
 *     bytes4(keccak256("constructor1()")). 
 *     This can be done with web3.utils.sha3('constructor1()').substring(0,10) in the Remix Console.
 * 3. Then simply tell Remix that MyFinalContract is running on the address of the Proxy Contract. 
 * 4. if you follow the steps, the Contract is now aware of the logic from the MyFinalContract 
 *    - which can inherit any contract, neglecting any Storage inheritance, because it can actually start from storage slot 0.
 * 5. If there's a change: Deploy a new version of the MyFinalContract then update the Proxy with the new address.   
 */