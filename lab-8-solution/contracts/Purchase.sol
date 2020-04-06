pragma solidity ^0.6.1;

contract Purchase {
    uint public priceOfItem;
    address payable public seller;
    address payable public buyer;
    enum State {Created, Locked, Inactive}
    State public state;

    event PurchaseConfirmed(address indexed _buyer);
    event ItemReceived();
    event Aborted();

    constructor(uint value) public payable{
        seller = msg.sender;
        priceOfItem = value;
    }

    modifier isState(State _state){
        require(state == _state, "Invalid state");
        _;
    }

    modifier onlyBuyer(){
        require(msg.sender == buyer, "Only buyer can call this");
        _;
    }

    modifier onlySeller(){
        require(msg.sender == seller, "Only seller can call this");
        _;
    }

    /// Aborting purchase
    /// Seller can reclaim the ether - Before the contract is locked
    function abort() public onlySeller isState(State.Created) {
        state = State.Inactive;
        seller.transfer(address(this).balance);
        emit Aborted();
    }

    /// Confirming the purchase as buyer
    /// Locks the ether until confirmReceived() is called
    function confirmPurchase() public isState(State.Created) payable{
        buyer = msg.sender;
        state = State.Locked;
        emit PurchaseConfirmed(buyer);
    }
    /// Confirmation of the item reception
    /// Releases locked ether
    function confirmReceived() public onlyBuyer isState(State.Locked) {
        state = State.Inactive;
        seller.transfer(priceOfItem);
        emit ItemReceived();
    }
} 