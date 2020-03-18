var MarketplaceRegistry = artifacts.require("MarketplaceRegistry");

var NftTicket = artifacts.require("NftTicket");
const _nftTicket = NftTicket.address;

const _erc20 = '0xad6d458402f60fd3bd25163575031acdce07538d';  // DAI on Ropsten

module.exports = function(deployer) {
    deployer.deploy(MarketplaceRegistry, _erc20, _nftTicket);
};
