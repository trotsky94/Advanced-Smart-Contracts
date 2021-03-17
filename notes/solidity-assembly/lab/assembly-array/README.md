# assembly-array

Follow the steps to complete this exercise:

1. clone this project
* **Option 1**
```bash
git clone https://github.com/GeorgeBrownCollege-Toronto/Advanced-Smart-Contracts.git ./assembly-array && \
cd ./assembly-array && \ 
git filter-branch --prune-empty --subdirectory-filter ./notes/solidity-assembly/lab/assembly-array HEAD && \
rm -rf ./.git
```
* **Option 2**
```bash
mkdir assembly-array && \
cd ./assembly-array && \ 
git init && \ 
git remote add origin -f https://github.com/GeorgeBrownCollege-Toronto/Advanced-Smart-Contracts.git && \
git sparse-checkout init && \
git sparse-checkout set notes/solidity-assembly/lab/assembly-array && \
git pull origin master && \ 
mv notes/solidity-assembly/lab/assembly-array/* . && \
rm -rf ./.git ./notes
```
2. add the following contract to the project
```
contract String {
   function charAt(string memory input, uint index) public pure returns(bytes2) {
        assembly{
            // add logic here
            // return the character from input at the given index
            // where index is base 0
        }
   }
}
```

3. add truffle test cases:
- charAt("abcdef", 2) should return 0x6300
- charAt("", 0) should return 0x0000
- charAt("george", 10) should return 0x0000

4. commit your changes to github and submit your github url