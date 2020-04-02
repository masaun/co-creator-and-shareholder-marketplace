pragma solidity ^0.5.10;
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC721/IERC721.sol";

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// Storage
import "./storage/OpStorage.sol";
import "./storage/OpConstants.sol";

import "./NftItem.sol";



/***
 * @notice - This contract is that ...
 **/
contract MarketplaceRegistry is Ownable, OpStorage, OpConstants {
    using SafeMath for uint;

    IERC20 public erc20;
    IERC721 public erc721;

    NftItem public nftItem;


    constructor(address _erc20, address _nftItem) public {
        erc20 = IERC20(_erc20);
        nftItem = NftItem(_nftItem);
    }

    function testFunc() public returns (bool) {
        return OpConstants.CONFIRMED;
    }


    /***
     * @dev - This is registry for all of stakeholders
     **/
    function stakeholderRegistry(
        uint256 _itemId,
        address _stakeholderAddr, 
        StakeholderType _stakeholderType
    ) public returns (address, StakeholderType) {
        Stakeholder memory stakeholder = Stakeholder({
            itemId: _itemId,  // It mean is initialize (equal to "null")
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
    function buyItem(uint256 _itemId, address _buyer) public returns (bool) {
        //@dev - Identify ordered item
        Item memory item = items[_itemId];

        //@dev - Ordered item is bought by buyer (It is equal to be done Ownership transfer)
        ownershipTransferOrderedItem(_itemId, _buyer);

        //@dev - Distribute rewards to stakeholders
        distributeReward(_itemId, item.itemPrice);
    }

    function itemOwnerOf(uint256 _itemId) public view returns (address)  {
        //return nftItem._itemOwnerOf(_itemId);
        return nftItem.ownerOf(_itemId);
    }

    function itemTransferFrom(address _oldOwner, address _newOwner, uint256 _itemId) public returns (bool) {
        nftItem.transferFrom(_oldOwner, _newOwner, _itemId);
    }

    function ownershipTransferOrderedItem(uint256 _itemId, address _newOwner) public returns (bool) {
        //@return - current owner address
        address _oldOwner = itemOwnerOf(_itemId);

        //@dev - Execute transfer ownership
        itemTransferFrom(_oldOwner, _newOwner, _itemId);
    }

    function distributeReward(uint256 _itemId, uint256 _itemPrice) public returns (bool) {
        //@dev - Display the cause of error in etherscan
        require (getStakeholdersGroup(_itemId).length == 0, "This itemId has not registerd stakeholders yet. So that user need to execute stakeholderRegistry in advance");

        //@dev - Sorts stakeholders who receive reward 
        address[] memory _stakeholdersGroups = getStakeholdersGroup(_itemId);

        //@dev - This is distributed amount each stakeholders
        uint256 distributedAmount = _itemPrice.div(_stakeholdersGroups.length).div(10**18);

        //@dev - Transfer distributed amount to each stakeholders
        for (uint256 i; i < _stakeholdersGroups.length; i++) {
            erc20.transfer(_stakeholdersGroups[i], distributedAmount);
        }
    }

}
