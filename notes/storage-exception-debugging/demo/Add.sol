// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

interface AddNumbers {
    function add(uint256 a, uint256 b) external pure returns (uint256 c);
}

contract AddNumberContract is AddNumbers {
    function add(uint256 a, uint256 b) external pure override returns (uint256 c) {
        c = a + b;
    }
}

contract Example {
    AddNumbers addContract;
    event StringFailure(string stringFailure);
    event BytesFailure(bytes bytesFailure);
    event PanicErrorEvent(uint256 errorCode);
    
    function setAddNumbers(AddNumbers _addContract ) public {
        addContract = _addContract;
    }

    function exampleFunction(uint256 _a, uint256 _b)
        public
        returns (uint256 _c)
    {
        try addContract.add(_a, _b) returns (uint256 _value) {
            return (_value);
        } catch Error(string memory _err) {
            // This may occur if there is an overflow with the two numbers and the `AddNumbers` contract explicitly fails with a `revert()`
            emit StringFailure(_err);
        } catch (bytes memory _err) {
            emit BytesFailure(_err);
        } catch Panic (uint errorCode){
            emit PanicErrorEvent(errorCode);
        }
    }
}