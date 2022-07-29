/*I chessed myself through this challenge by grabbing the address of etherscan with the deyploment transaction hash.
But that is not the way, the original poster of the challenge intented us to complete it.

I'll will now go through the steps of the normal way to solve this challenge.

formula to calculte an address(addresses for contract are not random, they can and are calculated via a formel)

address = rightmost_20_bytes(keccak(RLP(sender address_who_created/creates_the_contract, nonce_of_creation_tx)))

1. parameter: the creator address, would be our "Recovery" contract

2. Nonce would be 1 because this is the first contrat creation

let result = web3.utils.soliditySha3("0xd6", "0x94", "address of contract", "0x01")

and now take the first 20 letters of the result from the right and you have the contract address.


*/
