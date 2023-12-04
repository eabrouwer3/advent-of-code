// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Utils} from "./Utils.sol";
import "forge-std/console.sol";


contract AdventOfCodeProblem2 is Utils {
  // Input lines are of the form:
  //   Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  //   Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  //   Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  //   Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  //   Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

  function getRound(uint i, bytes memory input) internal pure returns (uint blue, uint green, uint red, uint nextIndex) {
    blue = 0;
    red = 0;
    green = 0;
    uint cur = 0;
    while (i < input.length && input[i] != bytes1(';')) {
      if (isDigit(input[i])) {
        cur = 10 * cur + (uint8(input[i]) - 0x30);
      } else if (input[i] == bytes1('b')) {
        blue += cur;
        i += 3;
        cur = 0;
      } else if (input[i] == bytes1('r')) {
        red += cur;
        i += 2;
        cur = 0;
      } else if (input[i] == bytes1('g')) {
        green += cur;
        i += 4;
        cur = 0;
      }
      i++;
    }
    return (blue, red, green, i);
  }

  function problem2A(string[] memory inputs) public pure returns (uint) {
    uint[] memory outputs = new uint[](inputs.length);
    for (uint gameId = 0; gameId < inputs.length; gameId++) {
      bytes memory input = bytes(inputs[gameId]);
      outputs[gameId] = gameId + 1;
      // Get Rounds
      uint j = 5;
      while (input[j] != bytes1(':')) {
        j++;
      }
      while (j < input.length) {
        (uint blue, uint red, uint green, uint nextIndex) = getRound(j, input);
        // console.log("Game %d", gameId + 1);
        // console.log("blue = %d", blue);
        // console.log("red = %d", red);
        // console.log("green = %d", green);
        if (blue > 14 || red > 12 || green > 13) {
          outputs[gameId] = 0;
          break;
        }
        j = nextIndex + 1;
      }
    }

    // Sum up the outputs
    uint sum = 0;
    for (uint i = 0; i < outputs.length; i++) {
      sum += outputs[i];
    }
    return sum;
  }

  function problem2B(string[] memory inputs) public pure returns (uint) {
    uint[] memory blues = new uint[](inputs.length);
    uint[] memory reds = new uint[](inputs.length);
    uint[] memory greens = new uint[](inputs.length);
    for (uint gameId = 0; gameId < inputs.length; gameId++) {
      bytes memory input = bytes(inputs[gameId]);
      blues[gameId] = 0;
      reds[gameId] = 0;
      greens[gameId] = 0;
      // Get Rounds
      uint j = 5;
      while (input[j] != bytes1(':')) {
        j++;
      }
      while (j < input.length) {
        (uint blue, uint red, uint green, uint nextIndex) = getRound(j, input);
        j = nextIndex + 1;
        // console.log("Game %d", gameId + 1);
        // console.log("blue = %d", blue);
        // console.log("red = %d", red);
        // console.log("green = %d", green);
        if (blue > blues[gameId]) {
          blues[gameId] = blue;
        }
        if (red > reds[gameId]) {
          reds[gameId] = red;
        }
        if (green > greens[gameId]) {
          greens[gameId] = green;
        }
      }
    }

    // Sum up the outputs
    uint sum = 0;
    for (uint i = 0; i < inputs.length; i++) {
      // console.log("Game %d", i + 1);
      // console.log("Blue: %d", blues[i]);
      // console.log("Red: %d", reds[i]);
      // console.log("Green: %d", greens[i]);
      uint power = blues[i] * reds[i] * greens[i];
      // console.log("Power: %d", power);
      sum += power;
    }
    return sum;
  }
}
