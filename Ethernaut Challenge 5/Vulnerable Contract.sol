// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }
  
  
  
  function transfer(address _to, uint _value) public returns (bool) {
     // Solutions/Vulnerability //
    // the require statement is redundant because it will always be true. Uint can't go into the negatives, which means if you were to 
    // calculate 20 - 21 it would UNDERFLOW and equal a very large number ((2**256) - 1).
    // this error doesn't occur in newer versions of solidity anymore due to the addition of safe math into standard solidity (you could disable this safe function
    // for gas optimization but it needs to be done carefully).
  
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}
