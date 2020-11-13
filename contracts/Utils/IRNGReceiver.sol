pragma solidity ^0.6.0;

interface IRNGReceiver {
    function __callback(bytes32 _queryId, uint256 _rng) external;
}