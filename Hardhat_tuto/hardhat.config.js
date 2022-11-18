require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan")

task('accounts', 'Prints the list of accounts', async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.1",
  settings: {
    optimizer: {
      enabled : true,
      runs: 200
    }
  },
  paths:{
    sources: './contracts',
    artifacts:'./artifacts'
  },
  networks:{
    sepolia: {
      url : 'https://sepolia.infura.io/v3/c0d8d7ae9dda4cb0b223725958b4a9cd',
      accounts : ['']
    },
    goerli:{
      url : 'https://goerli.infura.io/v3/c0d8d7ae9dda4cb0b223725958b4a9cd',
      accounts :['']
    }
  },
  etherscan:{
    apiKey:{
      sepolia:'GP2WZXMESTWFKNVFVZYDT1G2FPK4KGTWG4'
  }
}

};
