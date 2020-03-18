pragma solidity ^0.5.11;

import "./OpObjects.sol";
import "./OpEvents.sol";


// shared storage
contract OpStorage is OpObjects, OpEvents {

    // StakeholdersGroup[] public stakeholdersGroup;

    mapping (address => Stakeholder) stakeholders;
    
    mapping (uint256 => Item) items;
    

    mapping (uint256 => Ticket) tickets;

}

