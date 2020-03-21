pragma solidity ^0.5.11;


contract OpObjects {

    enum StakeholderType { Player, Worker, Organizer }
    
    struct Stakeholder {
        uint256 itemId;
        address stakeholderAddr;
        StakeholderType stakeholderType;
    }

    enum ItemType { Weapon, Character, Clothes, Others }

    struct Item {
        uint256 itemId;
        address itemOwnerAddr;
        string itemName;
        string itemDescription;
        uint256 itemPrice;
        ItemType itemType;
    }

    struct ExampleObject {
        address addr;
        uint amount;
    }
    
}
