require('babel-register');
require('babel-polyfill');
require('dotenv').config();

const HDWalletProvider = require("@truffle/hdwallet-provider");

module.exports = {
  compilers: {
    solc: {
      version: '0.6.0',
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 2000000000
    }
  },
  networks: {
    dev: {
      host: process.env.HOST,
      port: 7545,
      gas: 6721975,
      gasPrice: 20000000000, // Specified in Wei
      network_id: '5777' // Match any network id
    },
    ropsten: {
      provider: new HDWalletProvider(process.env.MNEMONIC, 'https://ropsten.infura.io/v3/8895468ed2d143a79bdfad181628be74'),
      network_id: '3',
      gas: 7990000,
      gasPrice: 22000000000 // Specified in Wei
    },
    kovan: {
      provider: new HDWalletProvider(process.env.MNEMONIC, 'https://kovan.infura.io/v3/8895468ed2d143a79bdfad181628be74'),
      network_id: '42',
      gas: 7990000,
      gasPrice: 22000000000 // Specified in Wei
    },
    coverage: {
      host: process.env.HOST,
      network_id: '*',
      port: 9328,
      gas: 10000000000000,
      gasPrice: 0x01,
    },
    rinkeby: {
      provider: new HDWalletProvider(process.env.MNEMONIC, 'https://rinkeby.infura.io/v3/8895468ed2d143a79bdfad181628be74'),
      network_id: '4',
      gas: 7200000,
      gasPrice: 22000000000 // Specified in Wei
    },
    production: {
      provider: new HDWalletProvider(process.env.MNEMONIC, 'https://mainnet.infura.io/v3/8895468ed2d143a79bdfad181628be74'),
      network_id: '1',
      gas: 7990000,
      gasPrice: 7000000000
    },
  }
};
