pragma solidity ^0.5.11;


contract OpObjects {

    enum StakeholderType { Player, Worker, Organizer }
    
    struct Stakeholder {
        uint256 itemId;
        address stakeholderAddr;
        StakeholderType stakeholderType;
    }

    struct Item {
        uint256 itemId;
        string itemName;
        uint256 itemPrice;
    }


    struct ExampleObject {
        address addr;
        uint amount;
    }
    
}
