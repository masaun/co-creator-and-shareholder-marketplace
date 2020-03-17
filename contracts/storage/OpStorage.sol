pragma solidity ^0.5.11;

import "./OpObjects.sol";
import "./OpEvents.sol";


// shared storage
contract OpStorage is OpObjects, OpEvents {

    mapping (uint256 => Ticket) tickets;

}

