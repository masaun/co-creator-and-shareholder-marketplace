pragma solidity ^0.5.10;

import "./opensea/TradeableERC721Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title NftItem
 * @dev - This is a contract for non-fungible items which are created by stakeholders.
 * @dev - This items are added to Wish-List
 */
contract NftItem is TradeableERC721Token {

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
     * @dev Mints a token to an address with a tokenURI.
     * @param _to address of player who propose a idea.
     */
    function mintTo(address _to) public {
        uint256 newItemId = _getNextItemId();
        _mint(_to, newItemId);
        _incrementItemId();
    }

    /**
     * @dev calculates the next token ID based on value of _currentItemId 
     * @return uint256 for the next token ID
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


    function _itemOwnerOf(uint256 _itemId) public view returns (address) {
        address _itemOwner = ownerOf(_itemId);
        return _itemOwner;
    }
    


    function itemURI(uint256 _itemId) external view returns (string memory) {
        return Strings.strConcat(
            baseTokenURI(),
            Strings.uint2str(_itemId)
        );
    }

    function baseTokenURI() public view returns (string memory) {
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
}
