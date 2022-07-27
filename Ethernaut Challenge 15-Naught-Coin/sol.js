const ethers = require("ethers");




async function Main() {
  // infuraProvider

  const infuraProvider = new ethers.providers.InfuraProvider("rinkeby", {
    projectId: process.env.REACT_APP_PROJECT_ID,
    projectSecret: process.env.REACT_APP_PROJECT_SECRET,
  });
  
   const contract = new ethers.Contract(
   "address",
    "abi",
    "signer/provider"
  );
   // add way to handle overflow of value
   let result = await contract.approve("address", "value");
  
  
  
}

Main();
