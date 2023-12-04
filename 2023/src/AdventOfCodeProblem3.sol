// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Utils} from "./Utils.sol";
import "forge-std/console.sol";


contract AdventOfCodeProblem3 is Utils {
  function getInTable(int x, int y, bytes[] memory table) internal pure returns (bytes1) {
    // Don't need to check < 0 because x and y are uint, so if we underflow, we'll wrap around
    if (x < 0 || uint(x) >= table.length || y < 0 || uint(y) >= table[uint(x)].length) {
      return bytes1('.');
    }
    return table[uint(x)][uint(y)];
  }

  function isAdjacentToSymbol(int x, int y, bytes[] memory table) internal pure returns (bool) {
    // a, b, c
    // d, -, f
    // g, h, i
    bytes1 a = getInTable(x - 1, y - 1, table);
    bytes1 b = getInTable(x - 1, y, table);
    bytes1 c = getInTable(x - 1, y + 1, table);
    bytes1 d = getInTable(x, y - 1, table);
    bytes1 f = getInTable(x, y + 1, table);
    bytes1 g = getInTable(x + 1, y - 1, table);
    bytes1 h = getInTable(x + 1, y, table);
    bytes1 i = getInTable(x + 1, y + 1, table);
    return (a != bytes1('.') && !isDigit(a))
      || (b != bytes1('.') && !isDigit(b))
      || (c != bytes1('.') && !isDigit(c))
      || (d != bytes1('.') && !isDigit(d))
      || (f != bytes1('.') && !isDigit(f))
      || (g != bytes1('.') && !isDigit(g))
      || (h != bytes1('.') && !isDigit(h))
      || (i != bytes1('.') && !isDigit(i));
  }

  function problem3A(string[] memory inputs) public pure returns (uint) {
    uint output = 0;
    bytes[] memory table = new bytes[](inputs.length);
    for (uint i = 0; i < inputs.length; i++) {
      table[i] = bytes(inputs[i]);
    }

    for (uint i = 0; i < table.length; i++) {
      uint num = 0;
      bool adjacent = false;
      for (uint j = 0; j < table[i].length; j++) {
        bytes1 c = table[i][j];
        if (isDigit(c)) {
          num = num * 10 + uint8(c) - 0x30;
          if (isAdjacentToSymbol(int(i), int(j), table)) {
            adjacent = true;
          }
        } else {
          if (num > 0) {
            if (adjacent) {
              // console.log("Found adjacent number: %d", num);
              output += num;
            }
            num = 0;
            adjacent = false;
          }
        }
      }
      if (num > 0 && adjacent) {
        // console.log("Found adjacent number: %d", num);
        output += num;
      }
    }

    return output;
  }

  function isGear(bytes1 c) internal pure returns (bool) {
    return c == bytes1('*');
  }

  function getNumber(uint index, bytes memory input) internal pure returns (uint) {
    while (index > 0 && isDigit(input[index - 1])) {
      index--;
    }
    uint num = 0;
    while (index < input.length && isDigit(input[index])) {
      num = num * 10 + byteToDigit(input[index]);
      index++;
    }
    return num;
  }

  function getGearRatio(uint x, uint y, bytes[] memory table) internal pure returns (uint) {
    uint count = 0;
    uint ratio = 1;
    if (isDigit(getInTable(int(x) - 1, int(y) - 1, table))) {
      // Top left is digit
      count++;
      ratio *= getNumber(y - 1, table[x - 1]);
      // console.log("Top left is digit: %d", getNumber(y - 1, table[x - 1]));
    } else if (isDigit(getInTable(int(x) - 1, int(y), table))) {
      // Top left is not a digit, but straight up is
      count++;
      ratio *= getNumber(y, table[x - 1]);
      // console.log("Top left is not a digit, but straight up is: %d", getNumber(y, table[x - 1]));
    }
    if (!isDigit(getInTable(int(x) - 1, int(y), table)) && isDigit(getInTable(int(x) - 1, int(y) + 1, table))) {
      // Straight up is not a digit and top right is
      count++;
      ratio *= getNumber(y + 1, table[x - 1]);
      // console.log("Straight up is not a digit and top right is: %d", getNumber(y + 1, table[x - 1]));
    }
    if (isDigit(getInTable(int(x), int(y) - 1, table))) {
      // Left is a digit
      if (count > 2) {
        return 0;
      }
      count++;
      ratio *= getNumber(y - 1, table[x]);
      // console.log("Left is a digit: %d", getNumber(y - 1, table[x]));
    }
    if (isDigit(getInTable(int(x), int(y) + 1, table))) {
      // Right is a digit
      if (count > 2) {
        return 0;
      }
      count++;
      ratio *= getNumber(y + 1, table[x]);
      // console.log("Right is a digit: %d", getNumber(y + 1, table[x]));
    }
    if (isDigit(getInTable(int(x) + 1, int(y) - 1, table))) {
      // Bottom left is a digit
      if (count > 2) {
        return 0;
      }
      count++;
      ratio *= getNumber(y - 1, table[x + 1]);
      // console.log("Bottom left is a digit: %d", getNumber(y - 1, table[x + 1]));
    } else if (isDigit(getInTable(int(x) + 1, int(y), table))) {
      // Bottom left is not a digit, but straight down is
      if (count > 2) {
        return 0;
      }
      count++;
      ratio *= getNumber(y, table[x + 1]);
      // console.log("Bottom left is not a digit, but straight down is: %d", getNumber(y, table[x + 1]));
    }
    if (!isDigit(getInTable(int(x) + 1, int(y), table)) && isDigit(getInTable(int(x) + 1, int(y) + 1, table))) {
      // Straight down is not a digit and bottom right is
      if (count > 2) {
        return 0;
      }
      count++;
      ratio *= getNumber(y + 1, table[x + 1]);
      // console.log("Straight down is not a digit and bottom right is: %d", getNumber(y + 1, table[x + 1]));
    }
    if (count == 2) {
      return ratio;
    } else {
      return 0;
    }
  }

  function problem3B(string[] memory inputs) public pure returns (uint) {
    uint output = 0;
    bytes[] memory table = new bytes[](inputs.length);
    for (uint i = 0; i < inputs.length; i++) {
      table[i] = bytes(inputs[i]);
    }

    for (uint i = 0; i < table.length; i++) {
      for (uint j = 0; j < table[i].length; j++) {
        if (isGear(table[i][j])) {
          output += getGearRatio(i, j, table);
        }
      }
    }

    return output;
  }
}
