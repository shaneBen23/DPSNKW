pragma solidity ^0.4.24;

import "./openzeppelin/lifecycle/Pausable.sol";
import "./openzeppelin/ownership/Ownable.sol";

/*import "./Wallet.sol";*/
import "./WalletFunctions.sol";
import "./Utils.sol";

contract WalletLedger is WalletFunctions, Pausable, Utils {
  struct User {
    string firstName;
    string lastName;
    string username;
    address wallet;
  }

  string constant tokenListAddress = "tokenListAddress";

  address[] private walletAddressList;
  /* Map from username to user info */
  mapping (string => User) private usernameToUserInfoMap;
  /* Map from wallet address to user info */
  mapping (address => User) private addressToUserInfoMap;
  /* Map for contract configuration addresses */
  mapping (string => address) configs;

  event NewWalletCreated(string description, address walletAddress, uint64 time);

  constructor(address _tokenListAddress) public {
    updateConfig(tokenListAddress, _tokenListAddress);
  }

  function createWallet(string _firstname, string _lastname, string _username, string _password) public {
    // Make sure username does not exist
    require(stringsEqual(usernameToUserInfoMap[_username].username, ""));

    bytes32 convertedUsername = stringToBytes32(_username);
    bytes32 convertedPassword = stringToBytes32(_password);

    address newWalletAddress = new Wallet(convertedUsername, convertedPassword);

    addWalletAddress(newWalletAddress);

    Wallet newWallet = Wallet(newWalletAddress);

    newWallet.setTokenListAddress(getTokenListAddress());

    User memory newUser = User(_firstname, _lastname, _username, newWalletAddress);

    setMappings(newUser, newWalletAddress);
  }


  function addWalletAddress(address _walletAddress) internal whenNotPaused {
    walletAddressList.push(_walletAddress);
    emit NewWalletCreated("A new wallet was created", _walletAddress, uint64(now));
  }

  function setMappings(User _newUser, address _walletAddress) internal {
    usernameToUserInfoMap[_newUser.username] = _newUser;
    addressToUserInfoMap[_walletAddress] = _newUser;
  }

  function getWalletAddressList() public onlyOwner view returns (address[]) {
    return walletAddressList;
  }

  //It works only when this function is commented
  function getUserInfoViaUsername(string _usernameQuery) public view onlyOwner returns (
    string firstName,
    string lastName,
    string username,
    address wallet) {
    firstName = usernameToUserInfoMap[_usernameQuery].firstName;
    lastName = usernameToUserInfoMap[_usernameQuery].lastName;
    username = usernameToUserInfoMap[_usernameQuery].username;
    wallet = usernameToUserInfoMap[_usernameQuery].wallet;
  }

  function getUserInfoViaAddress(address _walletAddress) public view onlyOwner returns (
    string firstName,
    string lastName,
    string username,
    address wallet) {
    firstName = addressToUserInfoMap[_walletAddress].firstName;
    lastName = addressToUserInfoMap[_walletAddress].lastName;
    username = addressToUserInfoMap[_walletAddress].username;
    wallet = addressToUserInfoMap[_walletAddress].wallet;
  }

  function getTokenListAddress() public view returns (address) {
    return configs[tokenListAddress];
  }

  function updateConfig(string _key, address _addr) public onlyOwner {
    configs[_key] = _addr;
  }
}
