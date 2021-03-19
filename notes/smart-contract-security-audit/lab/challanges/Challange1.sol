pragma solidity ^0.5.4;

// Can you have a gazillion balance?
contract challenge1 {
    uint256 public balance;

    constructor() public {
        balance = 10;
    }

    function buy() external payable {
        balance += msg.value;
    }

    function burn(uint256 amount) external {
        balance -= amount;
    }
}
