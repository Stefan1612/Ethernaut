const ethers = require("ethers");

async function Main() {
  // infuraProvider

  const infuraProvider = new ethers.providers.InfuraProvider("rinkeby", {
    projectId: process.env.REACT_APP_PROJECT_ID,
    projectSecret: process.env.REACT_APP_PROJECT_SECRET,
  });

  // getting all slot variables from the bytes32 array - only slot 5 is needed for the pw
  console.log(
    await infuraProvider.getStorageAt(
      "0x7E7f2405dBeA8De02425F6Ce466c7E73f3734EA4",
      3
    )
  );
  console.log(
    await infuraProvider.getStorageAt(
      "0x7E7f2405dBeA8De02425F6Ce466c7E73f3734EA4",
      4
    )
  );
  console.log(
    await infuraProvider.getStorageAt(
      "0x7E7f2405dBeA8De02425F6Ce466c7E73f3734EA4",
      5
    )
  );

  // result needed in remix.eth (only IDE for solidity and smart contract deployments) to convert bytes32 into bytes16
  let result = await infuraProvider.getStorageAt(
    "0x7E7f2405dBeA8De02425F6Ce466c7E73f3734EA4",
    3
  );
  /*   var hex = result.toString(); //force conversion
  var str = "";
  for (var i = 0; i < hex.length; i += 2)
    str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
  console.log(str); */
}

Main();
