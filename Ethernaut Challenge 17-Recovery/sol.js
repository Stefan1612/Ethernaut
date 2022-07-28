es (38 sloc)  1.15 KB

const ethers = require("ethers");

async function Main() {
  // infuraProvider

  const infuraProvider = new ethers.providers.InfuraProvider("rinkeby", {
    projectId: process.env.REACT_APP_PROJECT_ID,
    projectSecret: process.env.REACT_APP_PROJECT_SECRET,
  });
    
    // I found the address via the deployment transaction and etherscan
  
    const contract = new ethers.Contract(
   "0x4e8D434AcA353883f80013A7e39089D4f2d583A1",
      // grabbed the abi via remix compiler
    "abi",
    "provider"
  );
 
}

Main();
