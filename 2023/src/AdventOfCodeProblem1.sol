// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Utils} from "./Utils.sol";

contract AdventOfCodeProblem1 is Utils {
  function problem1A(string[] memory inputs) public pure returns (uint) {
    uint[] memory outputs = new uint[](inputs.length);
    for (uint i = 0; i < inputs.length; i++) {
      bytes memory input = bytes(inputs[i]);
      for (uint j = 0; j < input.length; j++) {
        if (isDigit(input[j])) {
          outputs[i] = 10 * (uint8(input[j]) - 0x30);
          break;
        }
      }
      for (uint j = input.length; j > 0; j--) {
        if (isDigit(input[j - 1])) {
          outputs[i] += uint8(input[j - 1]) - 0x30;
          break;
        }
      }
    }

    // Sum up the outputs
    uint sum = 0;
    for (uint i = 0; i < outputs.length; i++) {
      sum += outputs[i];
    }
    return sum;
  }

  function isOne(uint j, bytes memory input) internal pure returns (bool) {
    return j + 2 < input.length
      && input[j] == bytes1('o')
      && input[j + 1] == bytes1('n')
      && input[j + 2] == bytes1('e');
  }

  function isTwo(uint j, bytes memory input) internal pure returns (bool) {
    return j + 2 < input.length
      && input[j] == bytes1('t')
      && input[j + 1] == bytes1('w')
      && input[j + 2] == bytes1('o');
  }

  function isThree(uint j, bytes memory input) internal pure returns (bool) {
    return j + 4 < input.length
      && input[j] == bytes1('t')
      && input[j + 1] == bytes1('h')
      && input[j + 2] == bytes1('r')
      && input[j + 3] == bytes1('e')
      && input[j + 4] == bytes1('e');
  }

  function isFour(uint j, bytes memory input) internal pure returns (bool) {
    return j + 3 < input.length
      && input[j] == bytes1('f')
      && input[j + 1] == bytes1('o')
      && input[j + 2] == bytes1('u')
      && input[j + 3] == bytes1('r');
  }

  function isFive(uint j, bytes memory input) internal pure returns (bool) {
    return j + 3 < input.length
      && input[j] == bytes1('f')
      && input[j + 1] == bytes1('i')
      && input[j + 2] == bytes1('v')
      && input[j + 3] == bytes1('e');
  }

  function isSix(uint j, bytes memory input) internal pure returns (bool) {
    return j + 2 < input.length
      && input[j] == bytes1('s')
      && input[j + 1] == bytes1('i')
      && input[j + 2] == bytes1('x');
  }

  function isSeven(uint j, bytes memory input) internal pure returns (bool) {
    return j + 4 < input.length
      && input[j] == bytes1('s')
      && input[j + 1] == bytes1('e')
      && input[j + 2] == bytes1('v')
      && input[j + 3] == bytes1('e')
      && input[j + 4] == bytes1('n');
  }

  function isEight(uint j, bytes memory input) internal pure returns (bool) {
    return j + 4 < input.length
      && input[j] == bytes1('e')
      && input[j + 1] == bytes1('i')
      && input[j + 2] == bytes1('g')
      && input[j + 3] == bytes1('h')
      && input[j + 4] == bytes1('t');
  }

  function isNine(uint j, bytes memory input) internal pure returns (bool) {
    return j + 3 < input.length
      && input[j] == bytes1('n')
      && input[j + 1] == bytes1('i')
      && input[j + 2] == bytes1('n')
      && input[j + 3] == bytes1('e');
  }

  function isZero(uint j, bytes memory input) internal pure returns (bool) {
    return j + 4 < input.length
      && input[j] == bytes1('z')
      && input[j + 1] == bytes1('e')
      && input[j + 2] == bytes1('r')
      && input[j + 3] == bytes1('o');
  }

  function wordNumberMapping(uint j, bytes memory input) internal pure returns (bool, uint) {
    if (isOne(j, input)) {
      return (true, 1);
    }
    if (isTwo(j, input)) {
      return (true, 2);
    }
    if (isThree(j, input)) {
      return (true, 3);
    }
    if (isFour(j, input)) {
      return (true, 4);
    }
    if (isFive(j, input)) {
      return (true, 5);
    }
    if (isSix(j, input)) {
      return (true, 6);
    }
    if (isSeven(j, input)) {
      return (true, 7);
    }
    if (isEight(j, input)) {
      return (true, 8);
    }
    if (isNine(j, input)) {
      return (true, 9);
    }
    if (isZero(j, input)) {
      return (true, 0);
    }
    return (false, 0);
  }

  function problem1B(string[] memory inputs) public pure returns (uint) {
    uint[] memory outputs = new uint[](inputs.length);
    for (uint i = 0; i < inputs.length; i++) {
      bytes memory input = bytes(inputs[i]);
      for (uint j = 0; j < input.length; j++) {
        if (isDigit(input[j])) {
          outputs[i] = 10 * (uint8(input[j]) - 0x30);
          break;
        }
        (bool isWord, uint wordNumber) = wordNumberMapping(j, input);
        if (isWord) {
          outputs[i] = 10 * wordNumber;
          break;
        }
      }
      for (uint j = input.length; j > 0; j--) {
        if (isDigit(input[j - 1])) {
          outputs[i] += uint8(input[j - 1]) - 0x30;
          break;
        }
        (bool isWord, uint wordNumber) = wordNumberMapping(j - 1, input);
        if (isWord) {
          outputs[i] += wordNumber;
          break;
        }
      }
    }

    // Sum up the outputs
    uint sum = 0;
    for (uint i = 0; i < outputs.length; i++) {
      sum += outputs[i];
    }
    return sum;
  }
}
