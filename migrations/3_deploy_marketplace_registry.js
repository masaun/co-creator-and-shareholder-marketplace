var MarketplaceRegistry = artifacts.require("MarketplaceRegistry");
var IERC20 = artifacts.require("IERC20");



var NftItem = artifacts.require("NftItem");
const _nftItem = NftItem.address;

//@dev - Import from exported file
var tokenAddressList = require('./tokenAddress/tokenAddress.js');

//const _erc20 = '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE';    // ETH address
//const _erc20 = '0xad6d458402f60fd3bd25163575031acdce07538d';    // DAI address on Ropsten
const _erc20 = tokenAddressList["Ropsten"]["DAI"];                // DAI address on Ropsten

const depositedAmount = web3.utils.toWei("0.5");  // DAI which is deposited in deployed  contract. 

module.exports = async function(deployer) {
    await deployer.deploy(MarketplaceRegistry, _erc20, _nftItem);

    const marketplaceRegistry = await MarketplaceRegistry.deployed();

    const iERC20 = await IERC20.at(_erc20);
    await iERC20.transfer(marketplaceRegistry.address, depositedAmount);
};
