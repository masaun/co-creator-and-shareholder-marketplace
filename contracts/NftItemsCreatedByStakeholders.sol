pragma solidity ^0.5.10;

import "./opensea/TradeableERC721Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title NftTicket
 * @dev - NftItemsCreatedByStakeholders - a contract for my non-fungible items which are created by stakeholders.
 */
contract NftItemsCreatedByStakeholders is TradeableERC721Token {

    using Strings for string;

    address proxyRegistryAddress;
    uint256 private _currentTokenId = 0;

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
     * @param _to address of the future owner of the token => Club Team
     */
    function mintTo(address _to) public {
        uint256 newTokenId = _getNextTokenId();
        //_mint(msg.sender, newTokenId);
        _mint(_to, newTokenId);
        _incrementTokenId();
    }

    /**
     * @dev calculates the next token ID based on value of _currentTokenId 
     * @return uint256 for the next token ID
     */
    function _getNextTokenId() private view returns (uint256) {
        return _currentTokenId.add(1);
    }

    /**
     * @dev increments the value of _currentTokenId 
     */
    function _incrementTokenId() private  {
        _currentTokenId++;
    }

    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        return Strings.strConcat(
            baseTokenURI(),
            Strings.uint2str(_tokenId)
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
    
}