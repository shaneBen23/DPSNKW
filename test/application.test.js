const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const { beforeEach, describe, it } = require('mocha');
const mocha = require('mocha');

require('events').EventEmitter.defaultMaxListeners = Infinity;

const web3 = new Web3(ganache.provider());

const compiledWalletLedger = require('../build/contracts/WalletLedger.json');
const compiledWallet = require('../build/contracts/Wallet.json');
const compiledSampleToken = require('../build/contracts/SampleToken.json');

let accounts;
let walletLedger;
let wallet;
let walletAddress;
let sampleToken;
const firstName = 'shane';
const lastName = 'benjamin';
const username = 'shaneBen23';
const password = 'password';

mocha.describe('SmartWallet', () => {
  mocha.beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
  
    sampleToken = await new web3.eth.Contract(compiledSampleToken.abi)
    .deploy({ data: compiledSampleToken.bytecode })
    .send({ from: accounts[0], gas: '6500000' });
  
    walletLedger = await new web3.eth.Contract(compiledWalletLedger.abi)
    .deploy({ data: compiledWalletLedger.bytecode })
    .send({ from: accounts[0], gas: '6500000' });
  
    await walletLedger.methods
    .createWallet(firstName, lastName, username, password)
    .send({ from: accounts[0], gas: '6500000' });
  
    const userInfo = await walletLedger.methods.getUserInfoViaUsername(username).call();
  
    wallet = await new web3.eth.Contract(compiledWallet.abi, userInfo.wallet);
    walletAddress = wallet.options.address;
  });

  mocha.it('Deploys walletLedger, wallet and sampleToken', () => {
    assert.ok(walletLedger.options.address);
    assert.ok(wallet.options.address);
    assert.ok(sampleToken.options.address);
  });

  mocha.it('Check wallet info', async () => {
    const userInfo = await walletLedger.methods.getUserInfoViaUsername(username).call();
    assert.equal(userInfo.firstName, firstName);
  });

  mocha.it('Check credit wallet function and wallet ETH balance', async () => {
    await wallet.methods.credit().send({
      from: accounts[0],
      value: web3.utils.toWei('0.02', 'ether')
    });

    const walletBalance = await walletLedger.methods
    .callWalletGetETHBalance(walletAddress).call();

    assert.equal(walletBalance, web3.utils.toWei('0.02', 'ether'));
  });

  mocha.it('Check wallet ERC20 balance', async () => {
    await sampleToken.methods.quickIssueTokens(walletAddress).send({
      from: accounts[0],
      gas: '6500000'
    });

    const walletBalance = await walletLedger.methods
    .callWalletGetTokenBalance(walletAddress, sampleToken.options.address).call();

    assert.equal(walletBalance, web3.utils.toWei('10000', 'ether'));
  });

  mocha.it('Transfer ETH from wallet', async () => {
    const internalFirstName = 'test';
    const internalLastName = 'test';
    const internalUsername = 'test';
    const internalPassword = 'password';

    const amountBeforeTansfer = web3.utils.toWei('0.02', 'ether');
    const amountToSend = web3.utils.toWei('0.01', 'ether');

    await walletLedger.methods
    .createWallet(internalFirstName, internalLastName, internalUsername, internalPassword)
    .send({ from: accounts[0], gas: '6500000' });

    const internalWallet = await walletLedger.methods
    .getUserInfoViaUsername(internalUsername).call();

    await wallet.methods.credit().send({
      from: accounts[0],
      value: amountBeforeTansfer
    });

    await walletLedger.methods
    .callWalletTransferEth(walletAddress, amountToSend, internalWallet.wallet, password).send({
      from: accounts[0],
      gas: '6500000'
    });

    const walletBalance = await walletLedger.methods
    .callWalletGetETHBalance(walletAddress).call();

    const internalWalletBalance = await walletLedger.methods
    .callWalletGetETHBalance(internalWallet.wallet).call();

    assert.equal(walletBalance, amountToSend);
    assert.equal(internalWalletBalance, amountToSend);
  });

  mocha.it('Transfer ERC20 Tokens from wallet', async () => {
    const internalFirstName = 'test';
    const internalLastName = 'test';
    const internalUsername = 'test';
    const internalPassword = 'password';

    const sampleTokenAddress = sampleToken.options.address;

    const amountBeforeTansfer = web3.utils.toWei('10000', 'ether');
    const amountToSend = web3.utils.toWei('4000', 'ether');
    const amountBeforeTansferFloat = parseFloat(amountBeforeTansfer).toFixed(0);
    const amountToSendFloat = parseFloat(amountToSend).toFixed(0);
    const amountLeft = amountBeforeTansferFloat - amountToSendFloat;

    await sampleToken.methods.quickIssueTokens(walletAddress).send({
      from: accounts[0],
      gas: '6500000'
    });

    await walletLedger.methods
    .createWallet(internalFirstName, internalLastName, internalUsername, internalPassword)
    .send({ from: accounts[0], gas: '6500000' });

    const internalWallet = await walletLedger.methods
    .getUserInfoViaUsername(internalUsername).call();

    await walletLedger.methods
    .callWalletTransferTokens(
      walletAddress,
      amountToSend,
      internalWallet.wallet,
      sampleTokenAddress,
      password).send({
      from: accounts[0],
      gas: '6500000'
    });

    const walletBalance = await walletLedger.methods
    .callWalletGetTokenBalance(walletAddress, sampleTokenAddress).call();

    const internalWalletBalance = await walletLedger.methods
    .callWalletGetTokenBalance(internalWallet.wallet, sampleTokenAddress).call();

    assert.equal(walletBalance, amountLeft);
    assert.equal(internalWalletBalance, amountToSend);
  });

  mocha.it('Check password and username check functions', async () => {
    try {
      await walletLedger.methods.callWalletCheckUsername(walletAddress, '').call();
      assert(false);
    } catch (err) {
      assert(err);
    }

    try {
      await walletLedger.methods.callWalletCheckPassword(walletAddress, '').call();
      assert(false);
    } catch (err) {
      assert(err);
    }

    const checkUsername = await walletLedger.methods
    .callWalletCheckUsername(walletAddress, username).call();
    const checkPassword = await walletLedger.methods
    .callWalletCheckPassword(walletAddress, password).call();

    assert.ok(checkUsername);
    assert.ok(checkPassword);
  });

  mocha.it('Check login function', async () => {
    try {
      await walletLedger.methods.callWalletLogin(walletAddress, '', '').call();
      assert(false);
    } catch (err) {
      assert(err);
    }

    const login = await walletLedger.methods
    .callWalletLogin(walletAddress, username, password).call();

    assert.ok(login);
  });
});
