pragma solidity ^0.5.4;

// Lottery using block hash as source of randomness
// Deployed on Ropsten: 0x70707c3163575fb0eba9f291f75ff0742cb18386

contract challenge3 {
    uint256 public answer;

    constructor() public payable {
        require(msg.value == 1 ether);
    }

    function lottery(uint256 n) public payable {
        require(msg.value > 0); //buy ticket, it should be more than 0
        answer = uint256(keccak256(abi.encode(blockhash(block.number - 1))));
        if (n == answer) {
            msg.sender.transfer(1337);
        }
    }
}
