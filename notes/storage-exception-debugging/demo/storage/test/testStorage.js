const Delegator = artifacts.require("Delegator");
const VersionLibrary = artifacts.require("VersionLibrary");

contract("ProxyDelegate", (accounts) => {
  let proxy;
  let lib;
  const owner = accounts[0];
  const password = "0x70617373776f7264000000000000000000000000000000000000000000000000";
  before(async () => {
    lib = await VersionLibrary.deployed();
    proxy = await Delegator.deployed(lib.address, "0x70617373776f7264000000000000000000000000000000000000000000000000", { from: owner });
  });

  it("getStorageAt with storage index 1 should return password", () => {
    return web3.eth.getStorageAt(proxy.address, 1).then((result) => {
      expect(result).to.equal(password);
    });
  });

  it("getStorageAt with storage index 2 should return owner address", () => {
    const version = 0xaabbccddeeff;
    return proxy.setVersion(version).then((tx) => {
      return web3.eth.getStorageAt(proxy.address, 2).then((result) => {
        const checksumAddress = web3.utils.toChecksumAddress(result);
        assert.equal(checksumAddress, owner, "owner mismatch");
      });
    });
  });

  it("getStorageAt with storage index 2 should return new owner's address", () => {
    return proxy.changeOwner(accounts[1]).then((tx) => {
      return web3.eth.getStorageAt(proxy.address, 2).then((result) => {
        const checksumAddress = web3.utils.toChecksumAddress(result);
        assert.equal(checksumAddress, accounts[1], "owner mismatch");
      });
    });
  });

  it("getStorageAt with storage index 3 should return delegate address", () => {
    return web3.eth.getStorageAt(proxy.address, 3).then((result) => {
      const checksumAddress = web3.utils.toChecksumAddress(result);
      assert.equal(checksumAddress, lib.address, "delegate mismatch");
    });
  });
});
