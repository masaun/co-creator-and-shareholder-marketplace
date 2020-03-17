pragma solidity ^0.5.11;

import "./OpObjects.sol";


contract OpEvents {

    event StakeholderRegistry(
        address _stakeholderAddr, 
        OpObjects.StakeholderType _stakeholderType
    );
    

    event Example(
        uint256 indexed Id, 
        uint256 exchangeRateCurrent
    );

}
