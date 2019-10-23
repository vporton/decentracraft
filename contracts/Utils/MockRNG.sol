pragma solidity ^0.5.11;

import "./IRNGReceiver.sol";
import "./IRandomGenerator.sol";
import "./Ownable.sol";

/**
    @dev Mock Random Number Generator
    Used for testing purposes only
*/
contract MockRNG is Ownable, IRandomGenerator {

    event generatedRandomNumber(uint256 randomNumber);

    mapping (bytes32 => IRNGReceiver) callingMap;
    uint queryId = 0;

    constructor () public payable  { 
    }

    function generateRandom() external payable returns (bytes32){
        bytes32 query = bytes32(queryId);
        queryId++;
        callingMap[query] = IRNGReceiver(msg.sender);
        return query;
    }

    function randomReceived(uint256 _queryId, uint256 _random ) external ownerOnly {
        bytes32 query = bytes32(_queryId);
        callingMap[query].__callback(query, _random);
        emit generatedRandomNumber(_random);
        delete callingMap[query];
    }
}
