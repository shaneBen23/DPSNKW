pragma solidity ^0.4.24;

contract ITokenList {
  function isTokenPresent(address _tokenAddress) public constant returns (bool);
	function isTokenEnabled(address _tokenAddress) public constant returns (bool);
  function getTokenSymbolBytes32(address _tokenAddress) public constant returns (bytes32);
  function getTokenNameBytes32(address _tokenAddress) public constant returns (bytes32);
}
