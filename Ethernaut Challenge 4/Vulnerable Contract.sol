// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Telephone {

  address public owner;
  
  constructor() public {
    owner = msg.sender;
  }
  
  // Solutions/Vulnerability // 
  // You can just call the function (changeOwner()) from another contract and change owner

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}
