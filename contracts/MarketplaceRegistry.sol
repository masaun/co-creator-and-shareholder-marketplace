pragma solidity ^0.5.10;
pragma experimental ABIEncoderV2;

//import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
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

    //ERC20 public erc20;
    IERC20 public erc20;
    IERC721 public erc721;

    NftItem public nftItem;


    constructor(address _erc20, address _nftItem) public {
        //erc20 = ERC20(_erc20);
        erc20 = IERC20(_erc20);
        nftItem = NftItem(_nftItem);
    }


    /***
     * @dev - This is registry for all of shareholders
     **/
    function shareholderRegistry(
        uint256 _itemId,
        address _shareholderAddr, 
        ShareholderType _shareholderType
    ) public returns (address, ShareholderType, address[] memory) {
        //@dev - Save ownerAddressList in ItemDetail struct
        Item storage item = items[_itemId];
        item.itemDetail.itemOwnerAddrList.push(_shareholderAddr);
        //item.ownerAddress.ownerAddressList.push(_shareholderAddr);

        //@dev - Save ownerAddressList in Shareholder struct
        Shareholder memory shareholder = Shareholder({
            itemId: _itemId,  // It mean is initialize (equal to "null")
            shareholderAddr: _shareholderAddr,
            shareholderType: _shareholderType
        });
        shareholders.push(shareholder);

        emit ShareholderRegistry(_shareholderAddr, _shareholderType, item.itemDetail.itemOwnerAddrList);

        return (_shareholderAddr, _shareholderType, item.itemDetail.itemOwnerAddrList);
    }


    /***
     * @dev - Get shareholders who work in same item design process by sorting by itemId
     **/
    function getShareholdersGroup(uint256 _itemId) public returns (address[] memory) {
        //@dev - Do grouping of shareholders by specified itemId
        for (uint i; i < shareholders.length; i++) {
            if (shareholders[i].itemId == _itemId) {
                shareholdersGroups.push(shareholders[i].shareholderAddr);
            }
        }
        return shareholdersGroups;
    }


    /***
     * @dev - This function is that distribute reward to stackholders who joined making process of item design (Masic Moment)
     **/
    function buyItem(uint256 _itemId, address _buyer) public returns (bool) {
        //@dev - Identify ordered item
        Item memory item = items[_itemId];
        uint256 _itemPrice = item.itemPrice.div(10**18);

        //@dev - buyer buy item from seller with DAI
        purchaseItem(_itemId, _itemPrice);
        //purchaseItem(_itemId, _buyer, _itemPrice);

        //@dev - Ordered item is bought by buyer (It is equal to be done Ownership transfer)
        ownershipTransferOrderedItem(_itemId, _buyer);

        //@dev - Distribute rewards to shareholders
        distributeReward(_itemId, _itemPrice);
    }


    function purchaseItem(uint256 _itemId, uint256 _itemPrice) public returns (bool) {
        //@return - current owner address
        address _newOwner = msg.sender;
        address _oldOwner = itemOwnerOf(_itemId);

        //uint256 _testPrice = 5000000000000000;

        //@dev - new owner buy item from old owner with DAI
        erc20.transferFrom(_newOwner, _oldOwner, _itemPrice);                 // Original
        //erc20.transferFrom(_newOwner, _oldOwner, _testPrice.div(10**18));   // Test
        //erc20.transfer(_oldOwner, _testPrice.div(10**18));                  // Test
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
        require (getShareholdersGroup(_itemId).length > 0, "This itemId has not registerd shareholders yet. So that user need shareholderRegistry in advance");

        //@dev - Sorts shareholders who receive reward 
        address[] memory _shareholdersGroups = getShareholdersGroup(_itemId);

        //@dev - This is distributed amount each shareholders
        uint256 distributedAmount = _itemPrice.div(_shareholdersGroups.length).div(10**18);

        //@dev - Transfer distributed amount to each shareholders
        for (uint256 i; i < _shareholdersGroups.length; i++) {
            erc20.transfer(_shareholdersGroups[i], distributedAmount);
        }
    }

}
