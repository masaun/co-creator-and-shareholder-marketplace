var MarketplaceRegistry = artifacts.require("MarketplaceRegistry");

var NftItem = artifacts.require("NftItem");
const _nftItem = NftItem.address;

//const _erc20 = '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE';    // ETH address
const _erc20 = '0xad6d458402f60fd3bd25163575031acdce07538d';      // DAI address on Ropsten

module.exports = function(deployer) {
    deployer.deploy(MarketplaceRegistry, _erc20, _nftItem);
};
