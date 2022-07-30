/*
Explanation:

When contracts get Initialized the code gets compiled into opcodes.

We have two different areas where these opcodes will be stored after initialization.

1. Create: This part is 0 bytes large because it doesn't actually get stored inside the EVM for later reuse. 
(We used the constructor trick before to make a contract seem empty).

2. RunTime: This part stores opcodes and takes up bytes inside the EVM. (In this challenge, this part needs to be smaller than 10 bytes).


The way the compiler usually compiles our solidity code:

Solidity code -> Opcodes -> Byte Code -> Byte Code is read by the evm


Solution code:
tx = await web3.eth.sendTransaction({from: player, data: "600a600c600039600a6000f3602a60505260206050f3"});

contract.setSolver(tx.address);



*/
