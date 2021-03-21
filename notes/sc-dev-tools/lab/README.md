## lab

This lab is aimed to learn developing, compiling, deploying and interacting with contract ~~without IDE~~. 
You can use the ethereum network provider (local or testnet) and API library (web3 or ether js) of your choice 

### Instructions:
- Create a directory with the name of your choice
- Write a smart with use case of your choice which should at-least have
    - two public functions that are changing state of the contract
    - one public read-only or pure function
    - one private function (this private function must be used within the any public function)
    - one event that gets emitted by one of the function 
      (Note: A event can only be emitted by a function that changes changes state of the contract)  
- Initialize the repo by running `npm -y init`
- Add solidity compiler by running `npm install --save-dev solc@latest`
- Compile the contract using solc that you just installed. Run `./node_modules/.bin/solcjs --bin --abi <path-to-contract-file>` 
   - You will see that two files containing bytecode and abi are generated in the root directory 
- Create three node scripts in three seperate files.
  You can either copy content of these files in those scripts or read these files using `fs` nodejs library
    - Create a script to deploy the contract and test it
    - Create a script to interact with all public functions of deployed contract and test it
    - Create a script that listens to the event emitted by deployed contract and test it.

- Zip the project and submit on BlackBoard. Do not include node_modules or you'll receive but you can re-submit