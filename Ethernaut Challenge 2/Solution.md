// Solutions/Vulnerability // 
  // The faul1out() function is not a real constructor and can be called anytime


  /* constructor */
  function Fal1out() public payable {
    owner = msg.sender;
    allocations[owner] = msg.value;
  }
  
  
  contract.Fal1out();
