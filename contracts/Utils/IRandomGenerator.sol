pragma solidity ^0.6.0;

import "./IRNGReceiver.sol";

/**
    @dev Decentracraftworld manager
    Controls minting process
*/
interface IRandomGenerator {

    function generateRandom() external payable returns (bytes32);
}
