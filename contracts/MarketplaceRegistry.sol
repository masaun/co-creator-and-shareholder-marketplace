pragma solidity ^0.5.10;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC721/IERC721.sol";

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// Storage
import "./storage/OpStorage.sol";
import "./storage/OpConstants.sol";

import "./NftItemsCreatedByStakeholders.sol";



/***
 * @notice - This contract is that ...
 **/
contract MarketplaceRegistry is Ownable, OpStorage, OpConstants {
    using SafeMath for uint;

    IERC20 public erc20;
    IERC721 public erc721;

    NftItemsCreatedByStakeholders public nftItem;


    constructor(address _nftTicket) public {
        nftItem = NftItemsCreatedByStakeholders(_nftTicket);
    }

    function testFunc() public returns (bool) {
        return OpConstants.CONFIRMED;
    }


    /***
     * @dev - This is registry for all of stakeholders
     **/
    function stakeholderRegistry(
        address _stakeholderAddr, 
        StakeholderType _stakeholderType
    ) public returns (address, StakeholderType) {
        // In progress
        Stakeholder memory stakeholder = Stakeholder({
            itemId: 0,  // It mean is initialize (equal to "null")
            stakeholderAddr: _stakeholderAddr,
            stakeholderType: _stakeholderType
        });
        stakeholders.push(stakeholder);

        emit StakeholderRegistry(_stakeholderAddr, _stakeholderType);

        return (_stakeholderAddr, _stakeholderType);
    }

    /***
     * @dev - Get stakeholders who work in same item design process by sorting by itemId
     **/
    function getStakeholdersGroup(uint256 _itemId) public returns (address[] memory) {
        //@dev - Do grouping of stakeholders by specified itemId
        for (uint i; i < stakeholders.length; i++) {
            if (stakeholders[i].itemId == _itemId) {
                stakeholdersGroups.push(stakeholders[i].stakeholderAddr);
            }
        }
        return stakeholdersGroups;
    }


    /***
     * @dev - This function is that distribute reward to stackholders who joined making process of item design (Masic Moment)
     **/
    function buyItem(uint256 _itemId, address _stakeholderAddr, address _buyer) public returns (bool) {
        //@dev - Identify ordered item
        Item memory item = items[_itemId];

        //@dev - Ordered item is bought by buyer (It is equal to be done Ownership transfer)
        ownershipTransferOrderedItem(_itemId, _stakeholderAddr, _buyer);

        //@dev - Distribute rewards to stakeholders
        distributeReward(_itemId, item.itemPrice);
    }

    function ownershipTransferOrderedItem(uint256 _itemId, address _oldOwner, address _newOwner) internal returns (bool) {
        // in progress
    }

    function distributeReward(uint256 _itemId, uint256 _itemPrice) internal returns (bool) {
        //@dev - Sorts stakeholders who receive reward 
        address[] memory _stakeholdersGroups = getStakeholdersGroup(_itemId);

        //@dev - This is distributed amount each stakeholders
        uint256 distributedAmount = _itemPrice.div(_stakeholdersGroups.length);

        for (uint256 i; i < _stakeholdersGroups.length; i++) {
            //@dev - Transfer distributed amount to each stakeholders
        }
    }
    

}
