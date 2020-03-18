pragma solidity ^0.5.10;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC721/IERC721.sol";

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// Storage
import "./storage/OpStorage.sol";
import "./storage/OpConstants.sol";

import "./NftTicket.sol";



/***
 * @notice - This contract is that ...
 **/
contract MarketplaceRegistry is Ownable, OpStorage, OpConstants {
    using SafeMath for uint;

    IERC20 public erc20;
    IERC721 public erc721;

    NftTicket public nftTicket;


    constructor(address _nftTicket) public {
        nftTicket = NftTicket(_nftTicket);
    }

    function testFunc() public returns (bool) {
        return OpConstants.CONFIRMED;
    }


    /***
     * @dev - 
     **/
    function stakeholderRegistry(
        address _stakeholderAddr, 
        StakeholderType _stakeholderType
    ) public returns (address, StakeholderType) {
        // In progress
        Stakeholder storage stakeholder = stakeholders[_stakeholderAddr];
        stakeholder.addr = _stakeholderAddr;
        stakeholder.stakeholderType = _stakeholderType;

        emit StakeholderRegistry(stakeholder.addr, stakeholder.stakeholderType);

        return (stakeholder.addr, stakeholder.stakeholderType);
    }


    /***
     * @dev - This function is that distribute reward to stackholders who joined making process of item design (Masic Moment)
     **/
    function buyItem(address _buyer, uint256 _itemId) public returns (bool) {
        // in progress
    }
    



}
