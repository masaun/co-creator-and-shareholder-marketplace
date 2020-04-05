pragma solidity ^0.5.11;

import "./OpObjects.sol";


contract OpEvents {

    event StakeholderRegistry(
        address _stakeholderAddr, 
        OpObjects.StakeholderType _stakeholderType,
        address[] _ownerAddressList
    );

    event ItemRegistry(
        uint256 _itemId,
        address _itemProposerAddr, //@notice - _itemProposerAddr is a player who propose idea
        address _itemOwnerAddr,    //@notice - _itemOwnerAddr is equal to _stakeholderAddr
        string _itemName,
        uint256 _itemPrice,
        OpObjects.ItemType _itemType
    );
    
    event ItemDetailRegistry(
        uint256 _itemId,
        //address[] _itemOwnerAddrList,
        string _itemDescription
    );

    event OwnerAddressRegistry(
        uint256 _itemId,
        address _itemOwnerAddr,
        address[] _itemOwnerAddrList
    );    

    event Example(
        uint256 indexed Id, 
        uint256 exchangeRateCurrent
    );

}
