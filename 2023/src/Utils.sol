// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Utils {
  function isDigit(bytes1 c) internal pure returns (bool) {
    return c >= 0x30 && c <= 0x39;
  }

  function byteToDigit(bytes1 c) internal pure returns (uint8) {
    require(isDigit(c), "Utils: byteToDigit: not a digit");
    return uint8(c) - 0x30;
  }
}
