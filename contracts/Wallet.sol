pragma solidity ^0.4.24;

import "./openzeppelin/lifecycle/Pausable.sol";
import "./openzeppelin/ownership/Ownable.sol";
import "./openzeppelin/token/ERC20/ERC20.sol";

import "./ITokenList.sol";
import "./Utils.sol";

contract Wallet is Ownable, Pausable, Utils {
  mapping (string => string) private userInfo;
  /* address of the token list contract */
  address public tokenListaddress;
  /* List of the user's tokens */
  address[] private tokenList;
  /* List contracts that the user has */
  address[] private contactList;

  constructor(bytes32 _username, bytes32 _password) public payable {
    //string memory username =
    //string memory password =

    userInfo["username"] = bytes32ToString(_username);
    userInfo["password"] = bytes32ToString(_password);
  }

  /*function addInfo(string _key, string _value, string _password) public onlyOwner {
    require(stringsEqual(userInfo["password"], _password));
    userInfo[_key] = _value;
  }*/

  /*function removeInfo(string _key, string _password) public onlyOwner {
    require(stringsEqual(userInfo["password"], _password));
    delete userInfo[_key];
  }*/

  /*function getInfo(string _key) public view onlyOwner returns (string) {
    require(!stringsEqual("password", _key));
    return userInfo[_key];
  }*/

  /*function transferTokens(
    address _recipient, address _tokenAddress, uint _amount, string _password
    ) public onlyOwner {
    require(stringsEqual(userInfo["password"], _password));
    ERC20Basic token = ERC20Basic(_tokenAddress);
    token.transfer(_recipient, _amount);
  }*/

    //Works with this
  function getETHBalance() public view onlyOwner returns (uint) {
    return address(this).balance;
  }

  function transferEth(uint _amount, address _recipient, string _password) public onlyOwner {
    require(stringsEqual(userInfo["password"], _password));
    address(_recipient).transfer(_amount);
  }

  /*function getTokenBalance(address _tokenAddress) public view onlyOwner returns (uint) {
    ERC20Basic token = ERC20Basic(_tokenAddress);
    return token.balanceOf(this);
  }*/

  /*function cashout(uint _amount, string _password) public onlyOwner {
    require(stringsEqual(userInfo["password"], _password));
    address(this).transfer(_amount);
  }*/

  /*function cashoutERC20(uint _amount, address _tokenAddress, string _password) public onlyOwner {
    require(stringsEqual(userInfo["password"], _password));
    transferTokens(owner, _tokenAddress, _amount, _password);
  }*/

  /*function addToken(address _tokenAddress, string _password) public onlyOwner {
    require(stringsEqual(userInfo["password"], _password));
    ITokenList ITL = ITokenList(tokenListaddress);
		require(ITL.isTokenPresent(_tokenAddress));
    require(findAddressIndex(tokenList, _tokenAddress) == 0);

    tokenList.push(_tokenAddress);
  }*/

  /*function addContact(address _contactAddress, string _password) public onlyOwner {
    require(stringsEqual(userInfo["password"], _password));
    require(findAddressIndex(contactList, _contactAddress) == 0);

    contactList.push(_contactAddress);
  }*/

    //works with this
  /*function getTokenList() public view onlyOwner returns (address[]) {
    return tokenList;
  }*/

    //works with this
  /*function getContactList() public view onlyOwner returns (address[]) {
    return contactList;
  }*/

  function setTokenListAddress(address _tokenListaddress) public onlyOwner {
    tokenListaddress = _tokenListaddress;
  }
  
  /* fall back function, to receive ether */
  function() public payable { }
}
