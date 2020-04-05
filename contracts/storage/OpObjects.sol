pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;


contract OpObjects {

    enum StakeholderType { Player, Developer }
    
    struct Stakeholder {
        uint256 itemId;
        address stakeholderAddr;
        StakeholderType stakeholderType;
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
    }


    struct ExampleObject {
        address addr;
        uint amount;
    }
    
}
