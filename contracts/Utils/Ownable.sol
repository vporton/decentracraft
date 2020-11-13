pragma solidity ^0.6.0;

contract Ownable{
    
    address public owner;
    
    constructor () public payable  { 
        owner = msg.sender;
    }

    function setOwner(address _owner) external ownerOnly {
        owner = _owner;
    }
    
    modifier ownerOnly() {
      if (msg.sender == owner) _;
    }
}