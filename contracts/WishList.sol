pragma solidity ^0.5.10;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC721/IERC721.sol";

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// Storage
import "./storage/OpStorage.sol";
import "./storage/OpConstants.sol";




/***
 * @notice - This WishList contract is that players propose design ideas they want to
 **/
contract WishList is Ownable, OpStorage, OpConstants {
    using SafeMath for uint;


    constructor() public {}

    function testFunc() public returns (bool) {
        return OpConstants.CONFIRMED;
    }


    /***
     * @notice - 
     * @param - _proposeFrom is address of player 
     **/
    function proposeIdea(address _proposeFrom) public returns (bool) {
        return OpConstants.CONFIRMED;
    }
    
}
