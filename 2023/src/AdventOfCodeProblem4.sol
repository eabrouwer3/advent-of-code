// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Utils} from "./Utils.sol";
import "forge-std/console.sol";


contract AdventOfCodeProblem4 is Utils {
  function problem4A(string[] memory inputs, uint winningCount, uint entryCount) public pure returns (uint) {
    uint output = 0;

    for (uint i = 0; i < inputs.length; i++) {
      bytes memory input = bytes(inputs[i]);
      for (uint j = 0; j < input.length; j++) {
        uint[] memory winningNumbers = new uint[](winningCount);
        uint[] memory entryNumbers = new uint[](entryCount);

        while (input[j] != bytes1(':')) {
          j++;
        }
        j += 2;

        uint k = 0;
        while (k < winningCount) {
          while (input[j] == bytes1(' ')) {
            j++;
          }
          (winningNumbers[k], j) = getWholeNumber(input, j);
          k++;
        }
        j += 3;

        // console.log("Got winning numbers");

        k = 0;
        while (k < entryCount) {
          while (input[j] == bytes1(' ')) {
            j++;
          }
          (entryNumbers[k], j) = getWholeNumber(input, j);
          k++;
        }

        // console.log("Got entry numbers");

        uint score = 0;
        for (k = 0; k < entryCount; k++) {
          if (numInArray(winningNumbers, entryNumbers[k])) {
            if (score == 0) {
              score++;
            } else {
              score *= 2;
            }
          }
        }

        // console.log("Score: %d", score);

        output += score;
      }
    }

    return output;
  }


  function problem4B(string[] memory inputs, uint winningCount, uint entryCount) public pure returns (uint) {
    uint[] memory cardCounts = new uint[](inputs.length);

    for (uint i = 0; i < inputs.length; i++) {
      bytes memory input = bytes(inputs[i]);
      cardCounts[i]++;

      for (uint j = 0; j < input.length; j++) {
        uint[] memory winningNumbers = new uint[](winningCount);
        uint[] memory entryNumbers = new uint[](entryCount);

        while (input[j] != bytes1(':')) {
          j++;
        }
        j += 2;

        uint k = 0;
        while (k < winningCount) {
          while (input[j] == bytes1(' ')) {
            j++;
          }
          (winningNumbers[k], j) = getWholeNumber(input, j);
          k++;
        }
        j += 3;

        // console.log("Got winning numbers");

        k = 0;
        while (k < entryCount) {
          while (input[j] == bytes1(' ')) {
            j++;
          }
          (entryNumbers[k], j) = getWholeNumber(input, j);
          k++;
        }

        // console.log("Got entry numbers");

        uint score = 1;
        for (k = 0; k < entryCount; k++) {
          if (numInArray(winningNumbers, entryNumbers[k])) {
            cardCounts[i + score++] += cardCounts[i];
          }
        }
      }
    }

    uint output = 0;
    for (uint i = 0; i < cardCounts.length; i++) {
      // console.log("Card count: %d", cardCounts[i]);
      output += cardCounts[i];
    }
    return output;
  }
}
