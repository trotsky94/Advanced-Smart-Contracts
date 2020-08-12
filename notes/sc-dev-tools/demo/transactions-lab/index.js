const ethers = require('ethers');

const GANACHE_URL = 'http://localhost:8545';
const FROM_PRIVATE_KEY = '0x4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d';
const TO_ADDRESS = '0xf4aa3d66d9c6e9297C1FB79812b1823B06A810bb';

let provider = new ethers.providers.JsonRpcProvider(GANACHE_URL);
let wallet = new ethers.Wallet(FROM_PRIVATE_KEY, provider);
// pass in the amount as wei (1 ether = 1e18 wei)
let amount = ethers.utils.parseEther('3.0');

let tx = {
  to: TO_ADDRESS,
  value: amount
};

let sendPromise = wallet.sendTransaction(tx);

sendPromise.then(tx => {
  console.log(tx);
});
