pragma solidity ^0.4.24;

import "./openzeppelin/ownership/Ownable.sol";

import "./Wallet.sol";

contract WalletFunctions is Ownable {
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

  /* function callWalletTransferTokens(address _walletAddress, address _recipient, address _tokenAddress, uint _amount, string _password) public {
    IWallet currentWallet = IWallet(_walletAddress);
    currentWallet.transferTokens(_recipient, _tokenAddress, _amount, _password);
  } */

  function callTransferEth(address _walletAddress, uint _amount, address _recipient, string _password) public onlyOwner {
    Wallet currentWallet = Wallet(_walletAddress);
    currentWallet.transferEth(_amount, _recipient, _password);
  }

  function callWalletGetETHBalance(address _walletAddress) public view onlyOwner returns (uint) {
    Wallet currentWallet = Wallet(_walletAddress);
    return currentWallet.getETHBalance();
  }

  /* function callWalletGetTokenBalance(address _walletAddress, address _tokenAddress) public view onlyOwner returns (uint) {
    IWallet currentWallet = IWallet(_walletAddress);
    return currentWallet.getTokenBalance(_tokenAddress);
  } */

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

  /* function callWalletSetTokenListAddress(address _walletAddress, address _tokenListaddress) public {
    IWallet currentWallet = IWallet(_walletAddress);
    currentWallet.setTokenListAddress(_tokenListaddress);
  } */
}
