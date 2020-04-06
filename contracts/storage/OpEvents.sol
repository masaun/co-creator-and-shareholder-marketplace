pragma solidity ^0.5.11;

import "./OpObjects.sol";


contract OpEvents {

    event ShareholderRegistry(
        address _shareholderAddr, 
        OpObjects.ShareholderType _shareholderType,
        address[] _itemOwnerAddrList
    );

    event ItemRegistry(
        uint256 _itemId,
        address _itemProposerAddr, //@notice - _itemProposerAddr is a player who propose idea
        string _itemName,
        uint256 _itemPrice,
        OpObjects.ItemType _itemType
    );
    
    event ItemDetailRegistry(
        uint256 _itemId,
        string _itemDescription,
        address[] _itemOwnerAddrList
    );

}
