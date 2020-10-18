// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >=0.4.22 <0.7.1;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
abstract contract ERC20 {
  function totalSupply() virtual public view returns (uint256);

  function balanceOf(address _who) virtual public view returns (uint256);

  function allowance(address _owner, address _spender) virtual public view returns (uint256);

  function transfer(address _to, uint256 _value) virtual public returns (bool);

  function approve(address _spender, uint256 _value) virtual public returns (bool);

  function transferFrom(address _from, address _to, uint256 _value) virtual public returns (bool);

  event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
  );

  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
  );
}
