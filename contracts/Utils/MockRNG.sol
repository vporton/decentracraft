pragma solidity ^0.5.11;

import "./IRNGReceiver.sol";
import "./IRandomGenerator.sol";
import "./Ownable.sol";

/**
    @dev Mock Random Number Generator
    Used for testing purposes only
*/
contract MockRNG is IRandomGenerator {

    event generatedRandomNumber(uint256 randomNumber);

    event LogMessage(string message);
    event LogMessage(uint256 message);

    event LogRandomQueryCreated(uint queryId);

    address public owner;
    mapping (bytes32 => IRNGReceiver) public callingMap;
    uint public queryId = 0;

    constructor () public payable  { 
        owner = msg.sender;
    }

    function setOwner(address _owner) external ownerOnly {
        owner = _owner;
    }
    
    modifier ownerOnly() {
      if (msg.sender == owner) _;
    }

    function generateRandom() external payable returns (bytes32){
        queryId = queryId + 1;
        bytes32 query = bytes32(queryId);
        callingMap[query] = IRNGReceiver(msg.sender);
        emit LogRandomQueryCreated(queryId);
        return query;
    }

    function randomReceived(uint256 _queryId, uint256 _random ) external ownerOnly payable {
        emit LogMessage("randomReceived");
        bytes32 query = bytes32(_queryId);
        callingMap[query].__callback(query, _random);
        emit generatedRandomNumber(_random);
        delete callingMap[query];
    }
}
