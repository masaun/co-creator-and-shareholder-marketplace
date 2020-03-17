var MarketplaceRegistry = artifacts.require("MarketplaceRegistry");

var NftTicket = artifacts.require("NftTicket");
const _nftTicket = NftTicket.address;


module.exports = function(deployer) {
    deployer.deploy(MarketplaceRegistry, _nftTicket);
};
