// const { ethers } = require("hardhat");
const { ethers, upgrades } = require("hardhat");



async function main() {
    const [deployer] = await ethers.getSigners();

    // const RNC = await ethers.getContractFactory("RNC");
    // const R = await RNC.deploy();
    // console.log("RNC Contract Address:", R.address);
  
    // const CommissionContract = await ethers.getContractFactory("CommissionContract");
    // const CC = await CommissionContract.deploy();
    // console.log("CommissionContract Address:", CC.address);
  
    const PowerNFT = await ethers.getContractFactory("PowerNFT");
    const PWR = await PowerNFT.deploy();
    console.log("PowerNFT Address:", PWR.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });