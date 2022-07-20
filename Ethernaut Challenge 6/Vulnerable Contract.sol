// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Delegate {

  address public owner;

  constructor(address _owner) public {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}


// sending contract "Delegation" directly ether, will automatically call the fallback functions inside the contract.
// if we attach the "data" => abi.encodeWithSignature("pwn"), which will result in the function call 
// => address(delegate).delegatecall(abi.encodeWithSignature("pwn"))
// We are now calling the function "pwn()" inside contract "Delegate" in the name and with the state variables of contract "Delegation".
// This will result in the change of the state variable "owner" inside "Delegation"

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}
