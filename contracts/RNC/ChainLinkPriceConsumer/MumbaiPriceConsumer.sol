// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorInterface.sol";


// addresses special for Polygon Mumbai testnet 
abstract contract MumbaiPriceConsumer {

    AggregatorInterface LINKMATIC = AggregatorInterface(0x12162c3E810393dEC01362aBf156D7ecf6159528);


    /**
     * @dev Returns current price of link compared to MATIC with 18 decimal places.
     */
    function linkPrice() public view returns(uint256) {
        return uint256(LINKMATIC.latestAnswer());
    }
}