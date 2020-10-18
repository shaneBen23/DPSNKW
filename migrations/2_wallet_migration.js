const Migrations = artifacts.require('./Migrations.sol');
const WalletLedger = artifacts.require('./WalletLedger.sol');
const SampleToken = artifacts.require('./SampleToken.sol');

module.exports = function (deployer) {
  deployer.deploy(WalletLedger);
  deployer.deploy(SampleToken);
};
