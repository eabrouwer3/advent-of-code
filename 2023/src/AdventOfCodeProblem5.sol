// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Utils} from "./Utils.sol";
import "forge-std/console.sol";


contract AdventOfCodeProblem5 is Utils {
  function readMapRow(string memory input) internal pure returns (uint destinationRangeStart, uint sourceRangeStart, uint rangeLength) {
    uint i = 0;
    (destinationRangeStart, i) = getWholeNumber(bytes(input), i);
    i++;
    (sourceRangeStart, i) = getWholeNumber(bytes(input), i);
    i++;
    (rangeLength, i) = getWholeNumber(bytes(input), i);
    return (destinationRangeStart, sourceRangeStart, rangeLength);
  }

  function problem5A(string[] memory inputs) public pure returns (uint) {
    uint output = 9999999999999999;

    uint seedIndex = 6;
    while (seedIndex < bytes(inputs[0]).length) {
      // Get seed number
      seedIndex++;
      uint curId;
      (curId, seedIndex) = getWholeNumber(bytes(inputs[0]), seedIndex);
      // console.log("seed id: %d", curId);

      uint row = 3;
      while (row < inputs.length) {
        // console.log("row: %d", row);
        while (row < inputs.length && bytes(inputs[row]).length > 0) {
          (uint destinationRangeStart, uint sourceRangeStart, uint rangeLength) = readMapRow(inputs[row]);
          // console.log("destinationRangeStart: %d", destinationRangeStart);
          // console.log("sourceRangeStart: %d", sourceRangeStart);
          // console.log("rangeLength: %d", rangeLength);
          if (curId >= sourceRangeStart && curId < sourceRangeStart + rangeLength) {
            curId = destinationRangeStart + (curId - sourceRangeStart);
            break;
          }
          row++;
        }
        // console.log("curId: %d", curId);
        while (row < inputs.length && bytes(inputs[row]).length > 0) {
          row++;
        }
        row += 2;
      }

      // console.log("final curId: %d", curId);

      if (curId < output) {
        output = curId;
      }
    }

    return output;
  }

  function traverseMap(string[] memory inputs, uint sectionHeaderRow, uint startId, uint rangeLength) internal pure returns (uint) {
    // console.log("startId: %d", startId);

    // If we're past the end of the map, return the startId (the smallest number)
    if (sectionHeaderRow >= inputs.length) {
      // console.log("returning startId: %d", startId);
      return startId;
    }

    // Get nextSectionHeaderRow
    uint nextSectionHeaderRow = sectionHeaderRow + 1;
    while (nextSectionHeaderRow < inputs.length && bytes(inputs[nextSectionHeaderRow]).length > 0 && isDigit(bytes(inputs[nextSectionHeaderRow])[0])) {
      nextSectionHeaderRow++;
    }
    nextSectionHeaderRow++;
    // console.log("nextSectionHeaderRow: %d", nextSectionHeaderRow);

    // Recursively traverse the map
    uint row = sectionHeaderRow + 1;
    while (row < inputs.length && bytes(inputs[row]).length > 0 && isDigit(bytes(inputs[row])[0])) {
      (uint destinationRangeStart, uint sourceRangeStart, uint newRangeLength) = readMapRow(inputs[row]);
      // console.log("destinationRangeStart: %d", destinationRangeStart);
      // console.log("sourceRangeStart: %d", sourceRangeStart);
      // console.log("newRangeLength: %d", newRangeLength);
      if (startId < sourceRangeStart + newRangeLength && startId + rangeLength > sourceRangeStart) {
        // Ranges overlap!
        uint smallestLocation = 9999999999999999;
        uint potentialSmallestLocation;
        if (startId < sourceRangeStart) {
          // Continue in this section
          // console.log('startId < sourceRangeStart');
          potentialSmallestLocation = traverseMap(inputs, row, startId, sourceRangeStart - startId);
          if (potentialSmallestLocation < smallestLocation) {
            smallestLocation = potentialSmallestLocation;
          }
          // Continue in the next section
          if (startId + rangeLength < sourceRangeStart + newRangeLength) {
            // console.log('startId + rangeLength < sourceRangeStart + newRangeLength');
            potentialSmallestLocation = traverseMap(inputs, nextSectionHeaderRow, destinationRangeStart, rangeLength - (sourceRangeStart - startId));
            if (potentialSmallestLocation < smallestLocation) {
              smallestLocation = potentialSmallestLocation;
            }
          } else {
            // console.log('startId + rangeLength >= sourceRangeStart + newRangeLength');
            potentialSmallestLocation = traverseMap(inputs, nextSectionHeaderRow, destinationRangeStart, newRangeLength);
            if (potentialSmallestLocation < smallestLocation) {
              smallestLocation = potentialSmallestLocation;
            }
            // console.log('startId + rangeLength >= sourceRangeStart + newRangeLength #2');
            // And then continue in this section again
            potentialSmallestLocation = traverseMap(inputs, row, sourceRangeStart + newRangeLength, startId + rangeLength - (sourceRangeStart + newRangeLength));
            if (potentialSmallestLocation < smallestLocation) {
              smallestLocation = potentialSmallestLocation;
            }
          }
        } else {
          // console.log('startId >= sourceRangeStart');
          if (startId + rangeLength < sourceRangeStart + newRangeLength) {
            // console.log('startId + rangeLength < sourceRangeStart + newRangeLength');
            // Continue in the next section
            potentialSmallestLocation = traverseMap(inputs, nextSectionHeaderRow, destinationRangeStart + (startId - sourceRangeStart), rangeLength);
            if (potentialSmallestLocation < smallestLocation) {
              smallestLocation = potentialSmallestLocation;
            }
          } else {
            // console.log('startId + rangeLength >= sourceRangeStart + newRangeLength');
            // Continue in the next section
            potentialSmallestLocation = traverseMap(inputs, nextSectionHeaderRow, destinationRangeStart + (startId - sourceRangeStart), newRangeLength - (startId - sourceRangeStart));
            if (potentialSmallestLocation < smallestLocation) {
              smallestLocation = potentialSmallestLocation;
            }
            // console.log('startId + rangeLength >= sourceRangeStart + newRangeLength #2');
            // And then continue in this section again
            potentialSmallestLocation = traverseMap(inputs, row, sourceRangeStart + newRangeLength, startId + rangeLength - (sourceRangeStart + newRangeLength));
            if (potentialSmallestLocation < smallestLocation) {
              smallestLocation = potentialSmallestLocation;
            }
          }
        }

        return smallestLocation;
      }
      row++;
    }

    return traverseMap(inputs, nextSectionHeaderRow, startId, rangeLength);
  }

  function problem5B(string[] memory inputs) public pure returns (uint) {
    uint output = 9999999999999999;

    uint seedIndex = 6;
    while (seedIndex < bytes(inputs[0]).length) {
      // Get seed number
      uint curId;
      uint range;
      (curId, seedIndex) = getWholeNumber(bytes(inputs[0]), seedIndex + 1);
      (range, seedIndex) = getWholeNumber(bytes(inputs[0]), seedIndex + 1);
      // console.log("seed id: %d", curId);
      // console.log("range: %d", range);

      uint smallestLocation = traverseMap(inputs, 2, curId, range);
      // console.log("smallestLocation: %d", smallestLocation);
      if (smallestLocation < output) {
        output = smallestLocation;
      }
    }

    return output;
  }
}
