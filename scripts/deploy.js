// const { ethers } = require("hardhat");
const { ethers, upgrades } = require("hardhat");



async function main() {

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