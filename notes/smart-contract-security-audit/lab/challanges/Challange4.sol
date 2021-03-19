pragma solidity ^0.5.4;

// Steal money from charity (For educational purposes only)
// Deployed on Ropsten: 0x315a3254ff66c387a87d1771ae4877b4782a1a7c

contract challenge4 {
    mapping(address => uint256) public balances;
    event paid(address payee, uint256 amount);

    constructor() public payable {
        require(msg.value == 1 ether);
        balances[msg.sender] = msg.value;
    }

    function donate(address _to) public payable {
        balances[_to] += msg.value;
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool success, ) = msg.sender.call.value(_amount)("");
            if (success) {
                emit paid(msg.sender, _amount);
            }
            balances[msg.sender] -= _amount; //deduct the balance
        }
    }

    function() external payable {}
}
