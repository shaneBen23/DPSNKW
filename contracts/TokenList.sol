pragma solidity ^0.4.24;

import './openzeppelin/ownership/NoOwner.sol';

contract TokenList is NoOwner {
	//Events
	event AddToken(address indexed token);
	event EnableToken(address indexed token);
	event DisableToken(address indexed token);


	enum TokenStatus {
		NotPresent, //Default 0
		Enabled,
		Disabled
	}

	struct TokenData {
		string symbol;
		string name;
		uint decimals;
		TokenStatus status;
	}

	//Address must be a contract
	modifier onlyContract(address _address) {
		require(isContract(_address));
		_;
	}

	//List of supported ERC20 tokens and their enables/disabled status
	//mapping(address => TokenStatus) public tokenList;
	mapping(address => TokenData) public tokenList;
	address[] public tokens;

	constructor() public {

	}

	function addToken(
		address _tokenAddress,
		string _symbol,
		string _name,
		uint _decimals
		) public onlyOwner onlyContract(_tokenAddress) {

		TokenData storage tokenData = tokenList[_tokenAddress];
		//Token is NotPresent in the list
		require(tokenData.status == TokenStatus.NotPresent);

		tokenList[_tokenAddress] = TokenData(
			_symbol,
			_name,
			_decimals,
			TokenStatus.Enabled
		);

		tokens.push(_tokenAddress);
		emit AddToken(_tokenAddress);
	}

	function updateTokenSymbol(
		address _tokenAddress,
		string _symbol)
		public onlyOwner onlyContract(_tokenAddress) {

		TokenData storage tokenData = tokenList[_tokenAddress];
		tokenData.symbol = _symbol;
	}

	function updateTokenName(
		address _tokenAddress,
		string _name)
		public onlyOwner onlyContract(_tokenAddress) {

		TokenData storage tokenData = tokenList[_tokenAddress];
		tokenData.name = _name;
	}

	function updateTokenDecimals(
		address _tokenAddress,
		uint _decimals)
		public onlyOwner onlyContract(_tokenAddress) {

		TokenData storage tokenData = tokenList[_tokenAddress];
		tokenData.decimals = _decimals;
	}

	function enableToken(address _tokenAddress) public onlyOwner {
		TokenData storage tokenData = tokenList[_tokenAddress];
		require(tokenData.status == TokenStatus.Disabled);
		tokenData.status = TokenStatus.Enabled;
		emit EnableToken(_tokenAddress);
	}

	function disableToken(address _tokenAddress) public onlyOwner {
		TokenData storage tokenData = tokenList[_tokenAddress];
		require(tokenData.status == TokenStatus.Enabled);
		tokenData.status = TokenStatus.Disabled;
		emit DisableToken(_tokenAddress);
	}

	function getTokenNameBytes32(address _tokenAddress) public constant returns (bytes32){
		return stringToBytes32(tokenList[_tokenAddress].name);
	}

	function getTokenName(address _tokenAddress) public constant returns (string){
		return tokenList[_tokenAddress].name;
	}

	function getTokenSymbolBytes32(address _tokenAddress) public constant returns (bytes32){
		return stringToBytes32(tokenList[_tokenAddress].symbol);
	}

	function getTokenSymbol(address _tokenAddress) public constant returns (string){
		return tokenList[_tokenAddress].symbol;
	}

	function getTokenDecimals(address _tokenAddress) public constant returns (uint){
		return tokenList[_tokenAddress].decimals;
	}

	function getTokenDataBytes32(address _tokenAddress)
		public constant returns
		(bytes32 symbol, bytes32 name, uint decimals, bool enabled) {
		symbol = getTokenSymbolBytes32(_tokenAddress);
		name = getTokenNameBytes32(_tokenAddress);
		decimals = getTokenDecimals(_tokenAddress);
		enabled = isTokenEnabled(_tokenAddress);
		return;
	}

	function getTokenData(address _tokenAddress)
		public constant returns
		(string symbol, string name, uint decimals, bool enabled) {
		symbol = getTokenSymbol(_tokenAddress);
		name = getTokenName(_tokenAddress);
		decimals = getTokenDecimals(_tokenAddress);
		enabled = isTokenEnabled(_tokenAddress);
		return;
	}

	function isTokenPresent(address _tokenAddress) public constant returns (bool) {
		return tokenList[_tokenAddress].status != TokenStatus.NotPresent;
	}

	function isTokenEnabled(address _tokenAddress) public constant returns (bool) {
		return tokenList[_tokenAddress].status == TokenStatus.Enabled;
	}

	function isTokenDisabled(address _tokenAddress) public constant returns (bool) {
		return tokenList[_tokenAddress].status == TokenStatus.Disabled;
	}

	function getTokenCount(bool _enabled, bool _disabled) public constant
      returns (uint count) {

  	for (uint i=0; i<tokens.length; i++) {
  		if( (_enabled && tokenList[tokens[i]].status == TokenStatus.Enabled)
  			|| (_disabled && tokenList[tokens[i]].status == TokenStatus.Disabled) ) {
  			count += 1;
  		}
  	}
  }

  function getTokens() public constant returns (address[]) {
      return tokens;
  }

  function getTokens(bool _enabled, bool _disabled) public constant
      returns (address[] _tokens) {

	_tokens = new address[](getTokenCount(_enabled, _disabled));

	uint count = 0;
      for (uint i=0; i<tokens.length; i++) {
  		if( (_enabled && tokenList[tokens[i]].status == TokenStatus.Enabled)
  			|| (_disabled && tokenList[tokens[i]].status == TokenStatus.Disabled) ) {
  			_tokens[count] = tokens[i];
  			count += 1;
  		}
  	}
  }

	function isContract(address _addr) constant internal returns (bool) {
  	return getCodeSize(_addr) > 0;
  }

  function getCodeSize(address _addr) constant internal returns(uint _size) {
      assembly {
          _size := extcodesize(_addr)
      }
  }

	function stringToBytes32(string s) public pure returns(bytes32){
		bytes32 out;
		assembly {
			out := mload(add(s, 32))
		}
		return out;
  }
}
