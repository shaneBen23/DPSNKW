// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >=0.4.22 <0.7.1;

import "./openzeppelin/token/ERC20/StandardToken.sol";

// Just for Debug
contract SampleToken is StandardToken {
   string public name = "SampleToken";
   uint public decimals = 18;
   string public symbol = "TEST";

   address public creator = address(0);

   constructor() public {
        creator = msg.sender;
   }

   function issueTokens(address receipient, uint amount) public {
      _mint(receipient, amount);
   }

   function quickIssueTokens(address receipient) public {
      if(balanceOf(receipient) == 0) {
        _mint(receipient, 10000 * 1e18); //10000 tokens
      }
   }
}
