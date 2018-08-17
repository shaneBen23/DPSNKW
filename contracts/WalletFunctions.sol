pragma solidity ^0.4.24;

import "./openzeppelin/ownership/Ownable.sol";
import "./Wallet.sol";

contract WalletFunctions is Ownable {

  function callWalletCheckPassword(address _walletAddress, string _password) public view onlyOwner returns (bool) {
    Wallet currentWallet = Wallet(_walletAddress);
    return currentWallet.checkPassword(_password);
  }

  function callWalletCheckUsername(address _walletAddress, string _username) public view onlyOwner returns (bool) {
    Wallet currentWallet = Wallet(_walletAddress);
    return currentWallet.checkUsername(_username);
  }

  /* function callWalletAddInfo(address _walletAddress, string _key, string _value, string _password) public {
    IWallet currentWallet = IWallet(_walletAddress);
    currentWallet.addInfo(_key, _value, _password);
  } */

  /* function callWalletRemoveInfo(address _walletAddress, string _key, string _password) public {
    IWallet currentWallet = IWallet(_walletAddress);
    currentWallet.removeInfo(_key, _password);
  } */

  /* function callWalletGetInfo(address _walletAddress, string _key) public view onlyOwner returns (string) {
    IWallet currentWallet = IWallet(_walletAddress);
    return currentWallet.getInfo(_key);
  } */

  function callWalletTransferEth(address _walletAddress, uint _amount, address _recipient, string _password) public onlyOwner {
    Wallet currentWallet = Wallet(_walletAddress);
    currentWallet.transferEth(_amount, _recipient, _password);
  }

  function callWalletGetETHBalance(address _walletAddress) public view onlyOwner returns (uint) {
    Wallet currentWallet = Wallet(_walletAddress);
    return currentWallet.getETHBalance();
  }

  function callWalletGetTokenBalance(address _walletAddress, address _tokenAddress) public view onlyOwner returns (uint) {
    Wallet currentWallet = Wallet(_walletAddress);
    return currentWallet.getTokenBalance(_tokenAddress);
  }

  function callWalletTransferTokens(address _walletAddress, uint _amount, address _recipient, address _tokenAddress, string _password) public {
    Wallet currentWallet = Wallet(_walletAddress);
    currentWallet.transferTokens(_amount, _recipient, _tokenAddress, _password);
  }

  /* function callWalletCashout(address _walletAddress, uint _amount, string _password) public {
    IWallet currentWallet = IWallet(_walletAddress);
    currentWallet.cashout(_amount, _password);
  } */

  /* function callWalletCashoutERC20(address _walletAddress, uint _amount, address _tokenAddress, string _password) public {
    IWallet currentWallet = IWallet(_walletAddress);
    currentWallet.cashoutERC20(_amount, _tokenAddress, _password);
  } */

  /* function callWalletAddToken(address _walletAddress, address _tokenAddress, string _password) public {
    IWallet currentWallet = IWallet(_walletAddress);
    currentWallet.addToken(_tokenAddress, _password);
  } */

  /* function callWalletAddContact(address _walletAddress, address _contactAddress, string _password) public {
    IWallet currentWallet = IWallet(_walletAddress);
    currentWallet.addToken(_contactAddress, _password);
  } */

  /* function callWalletGetTokenList(address _walletAddress) public view onlyOwner returns (address[]) {
    IWallet currentWallet = IWallet(_walletAddress);
    return currentWallet.getTokenList();
  } */

  /* function callWalletGetContactList(address _walletAddress) public view onlyOwner returns (address[]) {
    IWallet currentWallet = IWallet(_walletAddress);
    return currentWallet.getContactList();
  } */
}
