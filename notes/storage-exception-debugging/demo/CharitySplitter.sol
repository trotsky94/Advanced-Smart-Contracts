pragma solidity ^0.6.1;

contract CharitySplitter {
    address public owner;

    constructor(address _owner) public {
        require(_owner != address(0), "no-owner-provided");
        owner = _owner;
    }
}

contract CharitySplitterFactory {
    mapping(address => CharitySplitter) public charitySplitters;
    uint256 public errorCount;
    event ErrorHandled(string reason);
    event ErrorNotHandled(bytes reason);

    function createCharitySplitter(address charityOwner) public {
        try new CharitySplitter(charityOwner) returns (
            CharitySplitter newCharitySplitter
        ) {
            charitySplitters[msg.sender] = newCharitySplitter;
        } catch Error(string memory reason) {
            errorCount++;
            CharitySplitter newCharitySplitter =
                new CharitySplitter(msg.sender);
            charitySplitters[msg.sender] = newCharitySplitter;
            // Emitting the error in event
            emit ErrorHandled(reason);
        } catch {
            errorCount++;
        }
    }

    // function createCharitySplitter(address _charityOwner) public {
    //     try new CharitySplitter(getCharityOwner(_charityOwner, false)) returns (
    //         CharitySplitter newCharitySplitter
    //     ) {
    //         charitySplitters[msg.sender] = newCharitySplitter;
    //     } catch (bytes memory reason) {
    //         // ...
    //     }
    // }

    // function getCharityOwner(address _charityOwner, bool _toPass)
    //     internal
    //     returns (address)
    // {
    //     require(_toPass, "revert-required-for-testing");
    //     return _charityOwner;
    // }
}
