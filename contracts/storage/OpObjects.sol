pragma solidity ^0.5.11;


contract OpObjects {

    enum StakeholderType { Player, Worker, Organizer }
    
    struct Stakeholder {
        address addr;
        StakeholderType stakeholderType;
    }
    


    struct Ticket {
        uint256 gameId;
        uint256 ticketId;
    }

    struct ExampleObject {
        address addr;
        uint amount;
    }
    
}
