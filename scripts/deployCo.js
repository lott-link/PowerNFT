const { ethers, upgrades } = require("hardhat");

async function main() {
   
    const CommissionContract = await ethers.getContractFactory("CommissionContract");
    const CC = await CommissionContract.deploy();
    console.log("CommissionContract Address:", CC.address);
  
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});