// SPDX-License-Identifier: MIT
2
pragma solidity ^0.6.0;

// Task: Force send ether into the contract
// Solution: 
// Every contract can receive ether forcefully with the "seldestruct" function
// e.g. =>  

/* 
contract maliciousContractExample {
  
  address private owner;
  
  constructor() {
  owner = msg.sender
  };
  
  // 1. So, we can easily send eth into this contract
   fallback() external payable {
  };
  
  // 2. selfdestruct this contract with ether inside and transfer is to vulnerable contract
  
  function(address victim) public {
  require(msg.sender == owner, "caller isn't owner");
  selfdestruct(victim);
  };
  
}
*/


contract Force 
{/*
                   MEOW ?
         /\_/\       
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)
*/}
