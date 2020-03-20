pragma solidity ^0.5.11;

import "./OpObjects.sol";


contract OpEvents {

    event StakeholderRegistry(
        address _stakeholderAddr, 
        OpObjects.StakeholderType _stakeholderType
    );

    event ItemRegistry(
        uint256 _itemId,
        address _itemOwnerAddr,  //@notice - _itemOwnerAddr is equal to _stakeholderAddr
        string _itemName,
        uint256 _itemPrice,
        OpObjects.ItemType _itemType
    );
    

    event Example(
        uint256 indexed Id, 
        uint256 exchangeRateCurrent
    );

}
