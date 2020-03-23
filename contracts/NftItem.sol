pragma solidity ^0.5.10;
pragma experimental ABIEncoderV2;

import "./opensea/TradeableERC721Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// Storage
import "./storage/OpStorage.sol";
import "./storage/OpConstants.sol";


/**
 * @title NftItem
 * @dev - This is a contract for non-fungible items which are created by stakeholders.
 * @dev - This items are added to Wish-List
 */
contract NftItem is TradeableERC721Token, OpStorage, OpConstants {

    using SafeMath for uint256;
    using Strings for string;

    address proxyRegistryAddress;
    uint256 private _currentItemId = 0;

    constructor(
        address _proxyRegistryAddress
    ) 
        TradeableERC721Token("Items which are created by stakeholders", "IBS", _proxyRegistryAddress) 
        public 
    {
        // Nothing   
    }

    /**
     * @dev Mints a item to an address with a itemURI.
     * @param _to address of player who propose a idea.
     */
    function mintTo(
        address _to,                //@notice - _to is original parameter of mintTo() function
        address _itemOwnerAddr,     //@notice - _itemOwnerAddr is equal to _stakeholderAddr
        string memory _itemName,
        string memory _itemDescription,
        uint256 _itemPrice,
        ItemType _itemType
    ) public {
        uint256 newItemId = _getNextItemId();
        _mint(_to, newItemId);

        //@dev - Call internal function (OverWritten)
        itemRegistry(newItemId, 
                     _to,  //@notice - _to is equal to _itemProposerAddr which is a player who propose idea
                     _itemOwnerAddr, 
                     _itemName, 
                     //_itemDescription, 
                     _itemPrice, 
                     _itemType);
        
        itemDetailRegistry(newItemId, _itemDescription);

        _incrementItemId();
    }


    /**
     * @dev - OverWrriten
     */
    function itemRegistry(
        uint256 _itemId,
        address _itemProposerAddr,  //@notice - _itemProposerAddr is a player who propose idea
        address _itemOwnerAddr,     //@notice - _itemOwnerAddr is equal to _stakeholderAddr
        string memory _itemName,
        uint256 _itemPrice,
        ItemType _itemType
    ) internal returns (uint256, 
                        address, 
                        address, 
                        string memory, 
                        //string memory, 
                        uint256, 
                        ItemType) 
    {
        //@dev - Value below is empty value of itemDescription property in ItemDetail struct
        ItemDetail memory _itemDetails;

        //@dev - Save value in Item struct
        // Item memory item = Item({
        //     itemId: _itemId,
        //     itemProposerAddr: _itemProposerAddr,  //@notice - _itemProposerAddr is a player who propose idea
        //     itemOwnerAddr: _itemOwnerAddr,        //@notice - _itemOwnerAddr is equal to _stakeholderAddr
        //     itemName: _itemName,
        //     itemDetails: _itemDetails,
        //     itemPrice: _itemPrice,
        //     itemType: _itemType
        // });
        // items.push(item);

        Item storage item = items[_itemId];
        item.itemId = _itemId;
        item.itemProposerAddr = _itemProposerAddr;  //@notice - _itemProposerAddr is a player who propose idea
        item.itemOwnerAddr = _itemOwnerAddr;        //@notice - _itemOwnerAddr is equal to _stakeholderAddr
        item.itemName = _itemName;
        item.itemPrice = _itemPrice;
        item.itemType = _itemType;

        // emit ItemRegistry(_itemId, 
        //                   _itemProposerAddr,
        //                   _itemOwnerAddr, 
        //                   _itemName, 
        //                   _itemPrice, 
        //                   _itemType);

        emit ItemRegistry(item.itemId, 
                          item.itemProposerAddr,
                          item.itemOwnerAddr, 
                          item.itemName, 
                          item.itemPrice, 
                          item.itemType);

        // return (_itemId, 
        //         _itemProposerAddr,
        //         _itemOwnerAddr,
        //         _itemName,
        //         _itemPrice,
        //         _itemType);

        return (item.itemId, 
                item.itemProposerAddr,
                item.itemOwnerAddr,
                item.itemName,
                item.itemPrice,
                item.itemType);
    }

    function itemDetailRegistry(
        uint256 _itemId,
        string memory _itemDescription
    ) internal returns (uint256, string memory) {
        ItemDetail storage itemDetail = itemDetails[_itemId];
        itemDetail.itemDescription = _itemDescription;

        emit ItemDetailRegistry(_itemId, _itemDescription);

        return (_itemId, itemDetail.itemDescription);
    }
    



    /**
     * @dev calculates the next item ID based on value of _currentItemId 
     * @return uint256 for the next item ID
     */
    function _getNextItemId() private view returns (uint256) {
        return _currentItemId.add(1);
    }

    /**
     * @dev increments the value of _currentItemId 
     */
    function _incrementItemId() private  {
        _currentItemId++;
    }


    // function _itemOwnerOf(uint256 _itemId) public view returns (address) {
    //     address _itemOwner = ownerOf(_itemId);
    //     return _itemOwner;
    // }
    


    function itemURI(uint256 _itemId) external view returns (string memory) {
        return Strings.strConcat(
            baseItemURI(),
            Strings.uint2str(_itemId)
        );
    }

    function baseItemURI() public view returns (string memory) {
        return "https://opensea-creatures-api.herokuapp.com/api/nft-item-by-stakeholders/";
    }


    /**
     * Override isApprovedForAll to whitelist user's OpenSea proxy accounts to enable gas-less listings.
     */
    function isApprovedForAll(
        address owner,
        address operator
    )
        public
        view
        returns (bool)
    {
        // Whitelist OpenSea proxy contract for easy trading.
        ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
        if (address(proxyRegistry.proxies(owner)) == operator) {
            return true;
        }

        return super.isApprovedForAll(owner, operator);
    }    
    
    /***
     * @dev - Overwritten
     **/
    function transferFrom(address _from, address _to, uint256 _itemId) public {
        _transferFrom(_from, _to, _itemId);
    }


    /***
     * @dev - Get all of items which are saved in Item struct
     * @return - instance of Item struct
     **/
    function getAllOfItems() public view returns (Item memory) {
        uint256 currentItemIdCount = _currentItemId.add(1);

        //@dev - itemId is started from 1
        uint256 i = 1;
        do {
            Item memory item = items[i]; 
            return item;
        } while (i < currentItemIdCount);
    }
}
