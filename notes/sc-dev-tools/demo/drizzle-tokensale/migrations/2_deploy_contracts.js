const GBCToken = artifacts.require("GBCToken");
const TokenSale = artifacts.require("TokenSale");

module.exports = function (deployer) {
  deployer.deploy(GBCToken).then((gbcTokenInstance) => {
    return deployer
      .deploy(TokenSale, gbcTokenInstance.address, "10000000000000")
      .then((tokenSaleInstance) => {
        return gbcTokenInstance.transfer(
          tokenSaleInstance.address,
          "100000000000000000000"
        );
      });
  });
};
