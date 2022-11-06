const hre = require("hardhat");

async function main() {

  //  console.log("Started:");
  const[payer, payee] = await hre.ethers.getSigners();
  const Escrow = await hre.ethers.getContractFactory("Escrow");
  const escrow = await Escrow.deploy(payer.address, payee.address, 2);

  await escrow.deployed();
  await escrow.connect(payer).deposit({ value: 2 });


  const walletBal = await hre.ethers.provider.getBalance(escrow.address);
  console.log(walletBal);

  console.log("Wallet deployed to: " + escrow.address);

    // const releaseFund  = await escrow.releaseFund();
    // console.log(releaseFund);

    const res = await escrow.connect(payee).workDone();
    console.log(res);

    const releaseFund1  = await escrow.releaseFund();
    console.log(releaseFund1);

    const walletBal1 = await hre.ethers.provider.getBalance(escrow.address);
    console.log("Contract Balance left:" + walletBal1);

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  