pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;


contract OpObjects {

    enum ShareholderType { Player, Developer }
    
    struct Shareholder {
        uint256 itemId;
        address shareholderAddr;
        ShareholderType shareholderType;
    }

    enum ItemType { Weapon, Character, Clothes, Others }

    struct Item {
        uint256 itemId;
        address itemProposerAddr;
        address itemOwnerAddr;
        string itemName;
        ItemDetail itemDetail;
        uint256 itemPrice;
        ItemType itemType;        
    }

    struct ItemDetail {
        string itemDescription;
        address[] itemOwnerAddrList;
    }

    struct ExampleObject {
        address addr;
        uint amount;
    }
    
}
