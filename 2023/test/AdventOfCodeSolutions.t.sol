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
    string memory line = vm.readLine(filename);
    do {
      problemInputs.push(line);
      line = vm.readLine(filename);
    } while (bytes(line).length > 0);
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
}
