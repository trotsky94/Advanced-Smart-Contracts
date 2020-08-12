const ethers = require('ethers');
const utils = require('ethers/utils');
// const web3 = require('web3');

let privateKey = '0x54b65650df5066a4446967d84936785e466bfde17c855b959eca000db3d597a0';
// let provider = new ethers.providers.Web3Provider(web3.currentProvider);
let provider = ethers.getDefaultProvider('ropsten');
let wallet = new ethers.Wallet(privateKey, provider);

// console.log('Address: ' + wallet.address);
// "0xf4aa3d66d9c6e9297C1FB79812b1823B06A810bb"

async function signTx() {
  let nonce = await wallet.getTransactionCount('pending');
  // All properties are optional
  let tx = {
    nonce: nonce,
    gasLimit: 21000,
    gasPrice: utils.bigNumberify('20000000000'),

    to: '0x24Fcf6B3F674324d471C831a4D2AffDA3564E718',
    // ... or supports ENS names
    // to: "ricmoo.firefly.eth",

    value: utils.parseEther('0.1'),
    data: '0x',

    // This ensures the transaction cannot be replayed on different networks
    chainId: ethers.utils.getNetwork('ropsten').chainId
  };
  console.log(tx);
  console.log('Signed tx: ' + (await wallet.sign(tx)));
}

// curl https://ropsten.infura.io/v3/5ccaf99120ca4e83872efba1837a4713 \
//     -X POST \
//     -H "Content-Type: application/json" \
//     -d '{"jsonrpc":"2.0","method":"eth_sendRawTransaction","params":["0xf86c198504a817c8008252089424fcf6b3f674324d471c831a4d2affda3564e71888016345785d8a00008029a08a18b517201d4a7ac94a3f87459596cd2d749c3453baf616e9fcc12116afe3b7a0158c8d7aeabe70a5c907e25a988870df5c90303145ab5358b2868b9fb818cf73"],"id":1}'
signTx();



// signPromise.then(async signedTransaction => {
//   console.log('Signed tx: ' + signedTransaction);
//   // "0xf86c808504a817c8008252089488a5c2d9919e46f883eb62f7b8dd9d0cc45bc2
//   //    90880de0b6b3a76400008025a05e766fa4bbb395108dc250ec66c2f88355d240
//   //    acdc47ab5dfaad46bcf63f2a34a05b2cb6290fd8ff801d07f6767df63c1c3da7
//   //    a7b83b53cd6cea3d3075ef9597d5"

//   // This can now be sent to the Ethereum network
//   // let provider = ethers.getDefaultProvider();
//   // provider.sendTransaction(signedTransaction).then(tx => {
//   //   console.log(tx);
//   //   // {
//   //   //    // These will match the above values (excluded properties are zero)
//   //   //    "nonce", "gasLimit", "gasPrice", "to", "value", "data", "chainId"
//   //   //
//   //   //    // These will now be present
//   //   //    "from", "hash", "r", "s", "v"
//   //   //  }
//   //   // Hash:
//   // });
// });
