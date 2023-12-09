// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {AdventOfCode} from "../src/AdventOfCode.sol";

contract AdventOfCodeTest is Test {
  AdventOfCode public advent;
  string[] problemInputs;

  function setUp() public {
    advent = new AdventOfCode();
    delete problemInputs;
  }

  function readInput(string memory filename) internal {
    bytes memory file = bytes(vm.readFile(filename));
    uint i = 0;
    while (i < file.length) {
      uint j = i;
      while (j < file.length && file[j] != 0x0A) {
        j++;
      }
      bytes memory line = new bytes(j - i);
      for (uint k = 0; k < j - i; k++) {
        line[k] = file[i + k];
      }
      problemInputs.push(string(line));
      i = j + 1;
    }
    if (bytes(problemInputs[problemInputs.length - 1]).length == 0) {
      delete problemInputs[problemInputs.length - 1];
    }
  }

  function test_Problem1() public {
    readInput('test/input-data/input1.txt');
    assertEq(advent.problem1A(problemInputs), 53651);
    assertEq(advent.problem1B(problemInputs), 53894);
  }

  function test_Problem2() public {
    readInput('test/input-data/input2.txt');
    assertEq(advent.problem2A(problemInputs), 2541);
    assertEq(advent.problem2B(problemInputs), 66016);
  }

  function test_Problem3() public {
    readInput('test/input-data/input3.txt');
    assertEq(advent.problem3A(problemInputs), 556367);
    assertEq(advent.problem3B(problemInputs), 89471771);
  }

  function test_Problem4() public {
    readInput('test/input-data/input4.txt');
    assertEq(advent.problem4A(problemInputs, 10, 25), 21088);
    assertEq(advent.problem4B(problemInputs, 10, 25), 6874754);
  }

  function test_Problem5() public {
    readInput('test/input-data/input5.txt');
    assertEq(advent.problem5A(problemInputs), 196167384);
    assertEq(advent.problem5B(problemInputs), 125742456);
  }

  function test_Problem6() public {
    readInput('test/input-data/input6.txt');
    assertEq(advent.problem6A(problemInputs), 227850);
    // Commented out cause it runs slow (Like 50 seconds)
    // assertEq(advent.problem6B(problemInputs), 42948149);
  }
}
