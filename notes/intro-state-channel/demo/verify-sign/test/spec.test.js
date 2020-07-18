// const MetaCoin = artifacts.require("MetaCoin");
const ReceiverPays = artifacts.require("ReceiverPays");
var EthUtil = require('ethereumjs-util');

contract("ReceiverPays", (accounts) => {
  const owner = accounts[0];
  const receiver = accounts[1];
  const depositedAmount = web3.utils.toWei("2", "ether");
  const receipientClaimAmount = web3.utils.toWei("1", "ether");
  const nonce = web3.utils.toBN(0);
  it("the receiver should be able to able to claim if signature is verified", async () => {
    const receiverPaysInstance = await ReceiverPays.new({
      from: owner,
      value: depositedAmount,
    });
    const actualOwner = await receiverPaysInstance.owner.call({
      from: receiver,
    });
    const actualDepositedAmount = await web3.eth.getBalance(
      receiverPaysInstance.address
    );
    assert.equal(actualOwner, owner, "Owner is not as expected");
    assert.equal(
      actualDepositedAmount,
      depositedAmount,
      "The deposited amount is as expected"
    );
    // writing a check to the recipient to withdraw say  1 Ether
    const messageHash = web3.utils.soliditySha3(
      { t: "address", v: receiver },
      { t: "uint256", v: 5000000000 },
      { t: "uint256", v: 0 },
      { t: "address", v: receiverPaysInstance.address }
    );
    // const sig = await web3.eth.sign(messageHash, owner);
    // // owner gives the signed message to recipient(e.g. email)
    // // recipient will use the signed message to claim the amount
    // const claimPaymentTx = await receiverPaysInstance.claimPayment(
    //   receipientClaimAmount,
    //   nonce,
    //   web3.utils.hexToBytes(sig),
    //   { from: receiver }
    // );
  });
});
