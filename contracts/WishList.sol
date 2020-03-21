pragma solidity ^0.5.10;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC721/IERC721.sol";

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// Storage
import "./storage/OpStorage.sol";
import "./storage/OpConstants.sol";




/***
 * @notice - This contract is that ...
 **/
contract WishList is Ownable, OpStorage, OpConstants {
    using SafeMath for uint;


    constructor() public {}

    function testFunc() public returns (bool) {
        return OpConstants.CONFIRMED;
    }

}
