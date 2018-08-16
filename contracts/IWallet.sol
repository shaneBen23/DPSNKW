pragma solidity ^0.4.24;

contract IWallet {
  function addInfo(string _key, string _value, string _password) public;
  function removeInfo(string _key, string _password) public;
  function getInfo(string _key) public view returns (string);
  function transferTokens(address _recipient, address _tokenAddress, uint _amount, string _password) public;
  function getETHBalance() public view returns (uint);
  function getTokenBalance(address _tokenAddress) public view returns (uint);
  function cashout(uint _amount, string _password) public;
  function cashoutERC20(uint _amount, address _tokenAddress, string _password) public;
  function addToken(address _tokenAddress, string _password) public;
  function addContact(address _contactAddress, string _password) public;
  function getTokenList() public view returns (address[]);
  function getContactList() public view returns (address[]);
  function setTokenListAddress(address _tokenListaddress) public;
}
