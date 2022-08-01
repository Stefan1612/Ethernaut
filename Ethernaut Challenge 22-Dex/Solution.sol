/*
Solidity inability to comprehend floating points (e.g. 24.44444, rounds down to 24) will be abused here.

In the "getSwapPrice" function the price is calculated by dividing 2 numbers, which would work fine IF solidity was able to work with decimals.

Fix: Usually tokenprices are * by their decimals (usually 18).


Solution: 

Keep on calling swap() with all your available tokens -> due to the rounding you will keep
ending up with more tokens than you should. After a certain amount of swaps you will end having all tokens of one kind.


*/
