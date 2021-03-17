# assembly-storage

Following the steps to complete this exercise:

1. clone this project
* **Option 1**
```bash
git clone https://github.com/GeorgeBrownCollege-Toronto/Advanced-Smart-Contracts.git ./assembly-storage && \
cd ./assembly-storage && \ 
git filter-branch --prune-empty --subdirectory-filter ./notes/solidity-assembly/lab/assembly-storage HEAD && \
rm -rf ./.git
```
* **Option 2**
```bash
mkdir assembly-storage && \
cd ./assembly-storage && \ 
git init && \ 
git remote add origin -f https://github.com/GeorgeBrownCollege-Toronto/Advanced-Smart-Contracts.git && \
git sparse-checkout init && \
git sparse-checkout set notes/solidity-assembly/lab/assembly-storage && \
git pull origin master && \ 
mv notes/solidity-assembly/lab/assembly-storage/* . && \
rm -rf ./.git ./notes
```
2. install packages: npm install
3. complete the contract/Storage.sol by returning the state variables as output
4. run the test: npm test
5. the test should pass
6. commit your changes to github and submit your github url