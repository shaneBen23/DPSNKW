// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >=0.4.22 <0.7.1;

contract Utils {
  function stringsEqual(string memory _a, string memory _b) internal pure returns (bool) {
      bytes memory a = bytes(_a);
      bytes memory b = bytes(_b);
      if (a.length != b.length)
      return false;
      // @todo unroll this loop
      for (uint i = 0; i < a.length; i ++)
      if (a[i] != b[i])
      return false;
      return true;
  }

  function concatString(string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
    bytes memory _ba = bytes(_a);
    bytes memory _bb = bytes(_b);
    bytes memory _bc = bytes(_c);
    string memory abc = new string(_ba.length + _bb.length + _bc.length);
    bytes memory babc = bytes(abc);

    uint k = 0;
    for (uint i = 0; i < _ba.length; i++) babc[k++] = _ba[i];
    for (uint i = 0; i < _bb.length; i++) babc[k++] = _bb[i];
    for (uint i = 0; i < _bc.length; i++) babc[k++] = _bc[i];

    return string(babc);
  }

  // function parseUInt(string memory self, uint _b) internal pure returns (uint) {
  //   bytes memory bresult = bytes(self);
  //   uint mint = 0;
  //   bool decimals = false;
  //    for (uint i=0; i<bresult.length; i++) {
  //      if ((bresult[i].length >= 48)&&(bresult[i].length <= 57)) {
  //        if (decimals) {
  //          if (_b == 0) break;
  //          else _b--;
  //        }
  //        mint *= 10;
  //        mint += uint(bresult[i]) - 48;
  //      } else if (bresult[i].length == 46) decimals = true;
  //    }

  //    if (_b > 0) mint *= 10**_b;
  //    return mint;
  // }

  function bytes32ToString(bytes32 x) internal pure returns (string memory) {
    bytes memory bytesString = new bytes(32);
    uint charCount = 0;
    for (uint j = 0; j < 32; j++) {
        byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
        if (char != 0) {
            bytesString[charCount] = char;
            charCount++;
        }
    }
    bytes memory bytesStringTrimmed = new bytes(charCount);
    for (uint j = 0; j < charCount; j++) {
        bytesStringTrimmed[j] = bytesString[j];
    }
    return string(bytesStringTrimmed);
  }

  function stringToBytes32(string memory source) internal pure returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }

    assembly {
        result := mload(add(source, 32))
    }
  }

// Array of addresses functions
  function findAddressIndex(address[] memory addressList, address value) internal pure returns(uint) {
        uint i = 0;
        while (addressList[i] != value) {
            i++;
        }
        return i;
    }

    // function removeAddressByValue(address[] storage addressList, address value) internal {
    //     uint i = findAddressIndex(addressList, value);
    //     removeByIndex(addressList, i);
    // }

    // function removeByIndex(address[] storage addressList, uint i) internal {
    //     while (i<addressList.length-1) {
    //         addressList[i] = addressList[i+1];
    //         i++;
    //     }
    //     addressList.length--;
    // }
}
