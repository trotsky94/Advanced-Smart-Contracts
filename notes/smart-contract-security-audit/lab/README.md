# Lab : Security Audit
This project is used for practicing security audit on following contracts intentionally coded with security vulnerabilities.

## Task
- Create a word document
- Perform security audit on the above following contracts. Document in a report all the issues/vulnerabilities, classify their severities and provide recommendations.

>Note: The compiler version of contracts is `0.6.0` and beyond.

### Contract_1.sol

```js
contract Bank1{
    address payable owner;

    modifier onlyowner {
        require(msg.sender==owner);
        _;
    }

    function setOwner()
        public 
    {
        owner = msg.sender;
    }

    function withdraw() 
        public 
        onlyowner
    {
       owner.transfer(address(this).balance);
    }
}
```

### Contract_2.sol

```js
contract Bank{
    mapping (address => uint) userBalance;
   
    function getBalance(address u) public view returns(uint){
        return userBalance[u];
    }

    function addToBalance() external payable {
        userBalance[msg.sender] += msg.value;
    }   

    function withdrawBalance() public{
        (bool success, ) = msg.sender.call{value:userBalance[msg.sender]}("");
        require(success);
        userBalance[msg.sender] = 0;
    }   
}
```

### Contract_3.sol

```js
contract Suicidal {
  address payable owner;
  function suicide() public returns (address) {
    require(owner == msg.sender);
    selfdestruct(owner);
  }
}
contract C is Suicidal {
  constructor() public {
    owner = msg.sender;
  }
}
```

### Contract_4.sol

```js
contract Auction {
  address payable currentFrontrunner;
  uint currentBid;

  function bid() public payable {
    require(msg.value > currentBid);


    if (currentFrontrunner != address(0)) {

      require(currentFrontrunner.send(currentBid));
    }

    currentFrontrunner = msg.sender;
    currentBid         = msg.value;
  }
}
```
 
- Submit the word document to the blackboard.