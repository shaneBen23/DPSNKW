// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >=0.4.22 <0.7.1;

import "./openzeppelin/lifecycle/Pausable.sol";
import "./openzeppelin/ownership/Ownable.sol";

import "./Wallet.sol";
import "./Utils.sol";

contract WalletLedger is Pausable, Utils {
  struct User {
    string firstName;
    string lastName;
    string username;
    Wallet wallet;
  }

  Wallet[] private walletList;
  /* Map from username to user info */
  mapping (string => User) private usernameToUserInfoMap;

  event NewWalletCreated(string description, uint64 time);

  function createWallet(string memory _firstname, string memory _lastname, string memory _username, string memory _password) public whenNotPaused returns (Wallet) {
    // Make sure username does not exist
    require(stringsEqual(usernameToUserInfoMap[_username].username, ""));

    bytes32 convertedUsername = stringToBytes32(_username);
    bytes32 convertedPassword = stringToBytes32(_password);

    Wallet newWallet = new Wallet(convertedUsername, convertedPassword);

    addWalletAddress(newWallet);

    User memory newUser = User(_firstname, _lastname, _username, newWallet);

    setMappings(newUser);

    return newWallet;
  }

  function addWalletAddress(Wallet _wallet) internal {
    walletList.push(_wallet);
    emit NewWalletCreated("A new wallet was created", uint64(block.timestamp));
  }

  function setMappings(User memory _newUser) internal {
    usernameToUserInfoMap[_newUser.username] = _newUser;
  }

  function getWalletList() public onlyOwner view returns (Wallet[] memory) {
    return walletList;
  }

  function getUserInfoViaUsername(string memory _usernameQuery) public view onlyOwner returns (
    string memory firstName,
    string memory lastName,
    string memory username,
    Wallet wallet) {
    firstName = usernameToUserInfoMap[_usernameQuery].firstName;
    lastName = usernameToUserInfoMap[_usernameQuery].lastName;
    username = usernameToUserInfoMap[_usernameQuery].username;
    wallet = usernameToUserInfoMap[_usernameQuery].wallet;
  }
}
