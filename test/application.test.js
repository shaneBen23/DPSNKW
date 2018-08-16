const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const { beforeEach, describe, it } = require('mocha');

require('events').EventEmitter.defaultMaxListeners = Infinity;

const web3 = new Web3(ganache.provider());

const compiledWalletLedger = require('../build/contracts/WalletLedger.json');
const compiledWallet = require('../build/contracts/Wallet.json');
const compiledTokenList = require('../build/contracts/TokenList.json');

let accounts;
let walletLedger;
let wallet;
let tokenList;
const firstName = 'shane';
const lastName = 'benjamin';
const username = 'shaneBen23';
const password = 'password';

//Rinkeby
// tokenListAddress = 0x7c8aadb5bd1d3cd14299475449c876109c19e657
// walletLedgerAddress = 0x059ce3b613d0b8b487fbc88702ad1a4755b9bb16


// "shane", "benjamin", "shaneben23", "password"


beforeEach(async () => {
  accounts = await web3.eth.getAccounts();

  tokenList = await new web3.eth.Contract(compiledTokenList.abi)
  .deploy({ data: compiledTokenList.bytecode })
  .send({ from: accounts[0], gas: '6000000' });

  walletLedger = await new web3.eth.Contract(compiledWalletLedger.abi)
  .deploy({
    data: compiledWalletLedger.bytecode,
    arguments: [tokenList.options.address]
   })
  .send({ from: accounts[0], gas: '6000000' });

  const transactionInfo = await walletLedger.methods
  .createWallet(firstName, lastName, username, password)
  .send({ from: accounts[0], gas: '1000000' });

  const walletAddress = transactionInfo.events.NewWalletCreated.address;

  const userInfo = await walletLedger.methods.getUserInfoViaAddress(walletAddress).call();

  wallet = await new web3.eth.Contract(compiledWallet.abi, userInfo.wallet);
});

describe('SmartWallet', () => {
  it('Deploys walletLedger, wallet and tokenList', () => {
    assert.ok(walletLedger.options.address);
    assert.ok(wallet.options.address);
    assert.ok(tokenList.options.address);
  });

  it('Check wallet info', async () => {
    const userInfo = await walletLedger.methods.getUserInfoViaUsername(username).call();
    assert.equal(userInfo.firstName, firstName);
  });

  it('Check wallet balance', async () => {
    const userInfo = await walletLedger.methods.getUserInfoViaUsername(username).call();
    const walletBalance = await walletLedger.methods
    .callWalletGetETHBalance(userInfo.wallet).call();

    assert.equal(walletBalance, 0);
  });

  it('Check credit wallet function', async () => {
    const userInfo = await walletLedger.methods.getUserInfoViaUsername(username).call();
    const walletBalance = await walletLedger.methods
    .callWalletGetETHBalance(userInfo.wallet).call();

    assert.equal(walletBalance, 0);
  });
});
