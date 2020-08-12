// https://web3js.readthedocs.io/en/v1.2.9/web3-utils.html#soliditysha3
// web3.utils.soliditySha3({t: 'string', v: 'Hello!%'}, {t: 'int8', v:-23}, {t: 'address', v: '0x85F43D8a49eeB85d32Cf465507DD71d507100C1d'});
const web3Utils = require("web3-utils");
const Web3 = require("web3");
const web3 = new Web3();

async function signPayment(recipient, amount, nonce, contractAddress) {
  // https://web3js.readthedocs.io/en/v1.2.7/web3-utils.html#soliditysha3
  var hash = web3Utils.soliditySha3(
    { t: "address", v: recipient },
    { t: "uint256", v: amount },
    { t: "uint256", v: nonce },
    { t: "address", v: contractAddress }
  );
  return hash;
}

signPayment(
"0xDa1d30af457b8386083C66c9Df7A86269bEbFDF8",
5000000000,
  0,
  "0x0ED8f92224E590f827Bf00D0F32CDFa7cDcB4f5b"
).then((message) => {
  console.log(message);
  const sKey =
    "7dad217e2d11c900db95fc5526a9e8c8aef3a98888b6e55537c084af85b779f5";
  // https://web3js.readthedocs.io/en/v1.2.7/web3-eth-accounts.html#sign
  const sig = web3.eth.accounts.sign(message, sKey);
  console.log(sig);
}).catch(console.log);
