const Delegator = artifacts.require("Delegator");
const VersionLibrary = artifacts.require("VersionLibrary");

module.exports = function (deployer) {
  deployer
    .deploy(VersionLibrary)
    .then(() =>
      deployer.deploy(
        Delegator,
        VersionLibrary.address,
        web3.utils.asciiToHex("password")//"0x70617373776f7264000000000000000000000000000000000000000000000000"
      )
    );
};
