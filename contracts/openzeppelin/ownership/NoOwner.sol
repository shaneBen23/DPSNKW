// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >=0.4.22 <0.7.1;

import "./HasNoEther.sol";
import "./HasNoTokens.sol";
import "./HasNoContracts.sol";


/**
 * @title Base contract for contracts that should not own things.
 * @author Remco Bloemen <remco@2π.com>
 * @dev Solves a class of errors where a contract accidentally becomes owner of Ether, Tokens or
 * Owned contracts. See respective base contracts for details.
 */
contract NoOwner is HasNoEther, HasNoTokens, HasNoContracts {
}
