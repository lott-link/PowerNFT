require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

const { PRIVATE_KEY, MUMBAI_API_KEY, ETHERSCAN_API_KEY, POLYGONSCAN_API_KEY } = require('../lott-io/secret.json');

module.exports = {
  
  solidity: {
  version: "0.8.17",
  settings: {
    optimizer: {
      enabled: true,
      runs: 200,
    }
   }
  },

  networks: {
    polygon: {
      url: `https://polygon-rpc.com/`,
      accounts: [`0x${PRIVATE_KEY}`],
    },
    polygonMumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/${MUMBAI_API_KEY}`,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: {
      mainnet: `${ETHERSCAN_API_KEY}`,
      ropsten: `${ETHERSCAN_API_KEY}`,
      rinkeby: `${ETHERSCAN_API_KEY}`,
      goerli: `${ETHERSCAN_API_KEY}`,
      kovan: `${ETHERSCAN_API_KEY}`,

      // polygon
      polygon: `${POLYGONSCAN_API_KEY}`,
      polygonMumbai: `${POLYGONSCAN_API_KEY}`,

      
      // // avalanche
      // avalanche: `${SNOWTRACE_API_KEY}`,
      // avalancheFujiTestnet: `${SNOWTRACE_API_KEY}`,
      
      // xdai and sokol don't need an API key, but you still need
      // to specify one; any string placeholder will work
      xdai: "api-key",
      sokol: "api-key",
    }
  },

};
