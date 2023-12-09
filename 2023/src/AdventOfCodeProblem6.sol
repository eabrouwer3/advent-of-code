// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Utils} from "./Utils.sol";
import "forge-std/console.sol";


contract AdventOfCodeProblem6 is Utils {
  function problem6A(string[] memory inputs) public pure returns (uint) {
    uint output = 1;

    bytes memory timeRow = bytes(inputs[0]);
    bytes memory distanceRow = bytes(inputs[1]);

    for (uint i = 9; i < timeRow.length;) {
      uint totalTime;
      uint recordDistance;
      (totalTime,) = getNextNumber(timeRow, i);
      (recordDistance, i) = getNextNumber(distanceRow, i);
      uint possibleWins = 0;
      for (uint timeHeld = 1; timeHeld < totalTime; timeHeld++) {
        uint distanceTraveled = timeHeld * (totalTime - timeHeld);
        if (distanceTraveled > recordDistance) {
          possibleWins++;
        }
      }
      output *= possibleWins;
    }

    return output;
  }

  function problem6B(string[] memory inputs) public pure returns (uint) {
    uint output = 0;

    bytes memory timeRow = bytes(inputs[0]);
    bytes memory distanceRow = bytes(inputs[1]);

    uint totalTime = getFullNumberIgnoreSpaces(timeRow, 9);
    uint recordDistance = getFullNumberIgnoreSpaces(distanceRow, 9);

    for (uint timeHeld = 1; timeHeld < totalTime; timeHeld++) {
      uint distanceTraveled = timeHeld * (totalTime - timeHeld);
      if (distanceTraveled > recordDistance) {
        output++;
      }
    }

    return output;
  }
}
