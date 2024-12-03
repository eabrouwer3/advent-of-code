// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Utils {
  function isDigit(bytes1 c) internal pure returns (bool) {
    return c >= 0x30 && c <= 0x39;
  }

  function isLetter(bytes1 c) internal pure returns (bool) {
    return (c >= 0x41 && c <= 0x5A) || (c >= 0x61 && c <= 0x7A);
  }

  function byteToDigit(bytes1 c) internal pure returns (uint8) {
    require(isDigit(c), "Utils: byteToDigit: not a digit");
    return uint8(c) - 0x30;
  }

  function getWholeNumber(bytes memory input, uint i) internal pure returns (uint, uint) {
    uint num = 0;
    while (i < input.length && isDigit(input[i])) {
      num = num * 10 + byteToDigit(input[i]);
      i++;
    }
    return (num, i);
  }

  function getNextNumber(bytes memory input, uint i) internal pure returns (uint, uint) {
    while (i < input.length && !isDigit(input[i])) {
      i++;
    }

    uint num = 0;
    while (i < input.length && isDigit(input[i])) {
      num = num * 10 + byteToDigit(input[i]);
      i++;
    }
    return (num, i);
  }

  function getFullNumberIgnoreSpaces(bytes memory input, uint i) internal pure returns (uint) {
    uint num = 0;
    while (i < input.length && !isDigit(input[i])) {
      i++;
    }

    while (i < input.length) {
      if (isDigit(input[i])) {
        num = num * 10 + byteToDigit(input[i]);
      }
      i++;
    }
    return num;
  }

  function numInArray(uint[] memory arr, uint num) internal pure returns (bool) {
    for (uint i = 0; i < arr.length; i++) {
      if (arr[i] == num) {
        return true;
      }
    }
    return false;
  }

  function sort(uint[] memory arr, bool reverse) internal pure {
    for (uint i = 0; i < arr.length; i++) {
      for (uint j = i + 1; j < arr.length; j++) {
        if (reverse && arr[i] < arr[j]) {
          uint temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        } else if (!reverse && arr[i] > arr[j]) {
          uint temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        }
      }
    }
  }
}
