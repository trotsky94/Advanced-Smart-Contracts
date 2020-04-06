/*global artifacts, contract, config, it, assert, web3*/
const Purchase = artifacts.require("Purchase");
const BN = require("bn.js");
const { Utils } = artifacts.require("EmbarkJS");

let price = 100000;
let state = {
  CREATED: 0,
  LOCKED: 1,
  INACTIVE: 2
};

contract("Purchase", function(accounts) {
  this.timeout(0);
  let PurchaseInstance;
  let buyerAddress = accounts[1];
  let sellerAddress = accounts[0];

  before(async () => {
    return new Promise(async (resolve, reject) => {
      const gas = await Purchase.deploy({ arguments: [price] }).estimateGas();

      Utils.secureSend(
        web3,
        Purchase.deploy({ arguments: [price] }),
        { gas, from: sellerAddress },
        true,
        function(err, receipt) {
          if (err) {
            return reject(err);
          }
          PurchaseInstance = Purchase;
          PurchaseInstance.options.address = receipt.contractAddress;
          resolve();
        }
      );
    });
  });

  it("Should deploy purchase", async function() {
    let result = await PurchaseInstance.options.address;
    let contractState = await Purchase.state();
    assert.ok(contractState == state["CREATED"]);
    assert.ok(result.length > 0);
  });

  it("Buyer deposits funds and confirms purchase", async function() {
    let result = await PurchaseInstance.methods.confirmPurchase().send({
      from: buyerAddress,
      value: price
    });
    let contractBuyerAddress = await Purchase.buyer();
    let contractSellerAddress = await Purchase.seller();
    let contractState = await Purchase.state();

    let contractBalance = await web3.eth.getBalance(Purchase.options.address);
    assert.ok(contractBuyerAddress == buyerAddress);
    assert.ok(contractSellerAddress == sellerAddress);
    assert.ok(contractBalance == price);
    assert.ok(contractState == state["LOCKED"]);
  });

  it("Buyer confirm received", async function() {
    // test here
    let sellerBalance = await web3.eth.getBalance(sellerAddress);
    sellerBalance = new BN(sellerBalance);
    let result = await PurchaseInstance.methods.confirmReceived().send({
      from: buyerAddress
    });
    let contractBuyerAddress = await PurchaseInstance.buyer();
    let contractSellerAddress = await PurchaseInstance.seller();
    let contractState = await PurchaseInstance.state();

    let contractBalance = await web3.eth.getBalance(
      PurchaseInstance.options.address
    );
    let sellerBalanceNew = await web3.eth.getBalance(sellerAddress);
    sellerBalanceNew = new BN(sellerBalanceNew);

    const sellerChange = sellerBalanceNew.sub(sellerBalance);
    assert.ok(contractBuyerAddress == buyerAddress);
    assert.ok(contractSellerAddress == sellerAddress);
    assert.ok(contractBalance == 0);
    assert.ok(sellerChange.toNumber() == price);
    assert.ok(contractState == state["INACTIVE"]);
  });

  contract("Purchase and abort", () => {
    before(async () => {
      return new Promise(async (resolve, reject) => {
        const gas = await Purchase.deploy({ arguments: [price] }).estimateGas();

        Utils.secureSend(
          web3,
          Purchase.deploy({ arguments: [price] }),
          { gas, from: sellerAddress },
          true,
          function(err, receipt) {
            if (err) {
              return reject(err);
            }
            PurchaseInstance = Purchase;
            PurchaseInstance.options.address = receipt.contractAddress;
            resolve();
          }
        );
      });
    });
    it("Should deploy purchase", async function() {
      let result = await PurchaseInstance.options.address;
      let contractState = await Purchase.state();
      assert.ok(contractState == state["CREATED"]);
      assert.ok(result.length > 0);
    });

    it("Seller aborts item", async function() {
      // test here
      let result = await PurchaseInstance.methods.abort().send({
        from: sellerAddress
      });
      let contractSellerAddress = await PurchaseInstance.seller();
      let contractState = await PurchaseInstance.state();

      let contractBalance = await web3.eth.getBalance(
        PurchaseInstance.options.address
      );
      assert.ok(contractSellerAddress == sellerAddress);
      assert.ok(contractBalance == 0);
      assert.ok(contractState == state["INACTIVE"]);
    });
  });
});
