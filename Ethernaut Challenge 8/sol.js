const ethers = require("ethers");

async function Main() {
  // infuraProvider

  const infuraProvider = new ethers.providers.InfuraProvider("rinkeby", {
    projectId: process.env.REACT_APP_PROJECT_ID,
    projectSecret: process.env.REACT_APP_PROJECT_SECRET,
  });

  console.log(
    await infuraProvider.getStorageAt(
      "0xaBA954e4dcbf4E3A2E7Bef25fb405bAcD9768807",
      1
    )
  );
  let result = await infuraProvider.getStorageAt(
    "0xaBA954e4dcbf4E3A2E7Bef25fb405bAcD9768807",
    1
  );

  var hex = result.toString(); //force conversion
  var str = "";
  for (var i = 0; i < hex.length; i += 2)
    str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
  console.log(str);
}

Main();
