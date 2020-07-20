# GSN v2 integration

This sample dapp emits an event with the last account that clicked on the "capture the flag" button.
We will integrate this dapp to work gaslessly with GSN v2. This will allow an externally owned account without ETH to capture the flag by signing a meta transaction.


Note: On testnet [opengsn](https://opengsn.org) maintains a public service "pay for everything" paymaster so writing your own is not strictly required. Dapps might want to develop their own custom paymaster in order, for example to subsidize gas fees for new users during the onboarding process. 

## Getting started

clone this repository

```bash
git clone https://github.com/GeorgeBrownCollege-Toronto/Advanced-Smart-Contracts.git ./gsnv2-integration && cd ./gsnv2-integration && git filter-branch --prune-empty --subdirectory-filter ./notes/meta-transactions/demo/gsnv2-integration HEAD && rm -rf ./.git
```

## Further reading

GSNv2 integration tutorial:

https://docs.opengsn.org/tutorials

Documentation explaining how everything works:

https://docs.opengsn.org/
