// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorInterface.sol";


// addresses special for Mainnet 
abstract contract PriceConsumer {

    AggregatorInterface LINKMATIC = AggregatorInterface(0x5787BefDc0ECd210Dfa948264631CD53E68F7802);


    /**
     * @dev Returns current price of link compared to MATIC with 18 decimal places.
     */
    function linkPrice() public view returns(uint256) {
        return uint256(LINKMATIC.latestAnswer());
    }
}