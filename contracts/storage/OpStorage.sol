pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;

import "./OpObjects.sol";
import "./OpEvents.sol";


// shared storage
contract OpStorage is OpObjects, OpEvents {

    ///////////////////////////////////
    // @dev - Define as memory
    ///////////////////////////////////
    address[] stakeholdersGroups;

    
    //////////////////////////////////
    // @dev - Define as storage
    ///////////////////////////////////
    Stakeholder[] public stakeholders;

    //mapping (address => Stakeholder) stakeholders;
    

    //Item[] public items;
    mapping (uint256 => Item) items;

    //ItemDetail[] public itemDetails;
    //mapping (uint256 => ItemDetail) itemDetails;
    

}

