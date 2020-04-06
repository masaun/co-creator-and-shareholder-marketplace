pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;

import "./OpObjects.sol";
import "./OpEvents.sol";


// shared storage
contract OpStorage is OpObjects, OpEvents {

    ///////////////////////////////////
    // @dev - Define as memory
    ///////////////////////////////////
    address[] shareholdersGroups;

    
    //////////////////////////////////
    // @dev - Define as storage
    ///////////////////////////////////
    Shareholder[] public shareholders;

    mapping (uint256 => Item) items;
}

