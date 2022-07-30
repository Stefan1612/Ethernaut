/*
Solution:

1. change contact bool into true to enable the usage of retract(), revise()

contract.make_contact();

2. Explanation: Dynamic Arrays are vulnerable too underflow attacks -> if you array.length-- on an array with the value
of 0, the array.length will underflow and equal the highest possible value inside the EVM Storage (EVM can store up to 2**256 32bytes inside storage).
The new array.length wouldn't equal -1, it would equal 2**256 (very large num).
If the array.length equals all possible storage, you can manipulate all data inside the array.

Actual step:

contract.retract();

3. Find out where the owner variable is inside the array.

4. change owner to our address

*/
