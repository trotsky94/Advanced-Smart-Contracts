// https://github.com/ethers-io/ethers.js/issues/371

const ethers = require('ethers');
const utils = require('ethers/utils');

let provider = ethers.getDefaultProvider('ropsten');

async function getTxData() {
  let abi = ['function increment(uint256 _counter) public returns(uint256)'];
  let iface = new ethers.utils.Interface(abi);

  // This Description object has lots of useful things on it...
  let increment = iface.functions.increment;

  // Encode data (what you are looking for)
  let encodedData = increment.encode([10]);
  console.log(encodedData);

  let resultData = await provider.call({ to: '0x035BdbCd5EEa0D573F758c0C8dD38F82d06fABA3', data: encodedData });

  // Parsing the result of calls
  let result = increment.decode(resultData);
  console.log(result);
}

getTxData();
