// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {AdventOfCode} from "../src/AdventOfCode.sol";

contract AdventOfCodeTest is Test {
    AdventOfCode public advent;

    function setUp() public {
        advent = new AdventOfCode();
    }

    function test_Problem1A() public {
        // inputs: 1abc2
        //         pqr3stu8vwx
        //         a1b2c3d4e5f
        //         treb7uchet
        // output: 12 + 38 + 15 + 77 = 142
        string[] memory inputs = new string[](4);
        inputs[0] = "1abc2";
        inputs[1] = "pqr3stu8vwx";
        inputs[2] = "a1b2c3d4e5f";
        inputs[3] = "treb7uchet";
        assertEq(advent.problem1A(inputs), 142);
    }

    function test_Problem1B() public {
        // inputs: two1nine
        //         eightwothree
        //         abcone2threexyz
        //         xtwone3four
        //         4nineeightseven2
        //         zoneight234
        //         7pqrstsixteen
        // output: 29 + 83 + 13 +24 + 42 + 14 + 76 = 281
        string[] memory inputs = new string[](7);
        inputs[0] = "two1nine";
        inputs[1] = "eightwothree";
        inputs[2] = "abcone2threexyz";
        inputs[3] = "xtwone3four";
        inputs[4] = "4nineeightseven2";
        inputs[5] = "zoneight234";
        inputs[6] = "7pqrstsixteen";
        assertEq(advent.problem1B(inputs), 281);
    }

    function test_Problem2A() public {
        // inputs: Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        //         Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        //         Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        //         Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        //         Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        // output: 1 + 2 + 5 = 8
        string[] memory inputs = new string[](5);
        inputs[0] = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
        inputs[1] = "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue";
        inputs[2] = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red";
        inputs[3] = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red";
        inputs[4] = "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        assertEq(advent.problem2A(inputs), 8);
    }

    function test_Problem2B() public {
        // inputs: Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        //         Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        //         Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        //         Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        //         Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        // output: 1 + 2 + 5 = 8
        string[] memory inputs = new string[](5);
        inputs[0] = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
        inputs[1] = "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue";
        inputs[2] = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red";
        inputs[3] = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red";
        inputs[4] = "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        assertEq(advent.problem2B(inputs), 2286);
    }

    function test_Problem3A() public {
        // inputs: 467..114..
        //         ...*......
        //         ..35..633.
        //         ......#...
        //         617*......
        //         .....+.58.
        //         ..592.....
        //         ......755.
        //         ...$.*....
        //         .664.598..
        // output: 467 + 35 + 633 + 617 + 592 + 755 + 664 + 598 = 4361
        string[] memory inputs = new string[](10);
        inputs[0] = "467..114..";
        inputs[1] = "...*......";
        inputs[2] = "..35..633.";
        inputs[3] = "......#...";
        inputs[4] = "617*......";
        inputs[5] = ".....+.58.";
        inputs[6] = "..592.....";
        inputs[7] = "......755.";
        inputs[8] = "...$.*....";
        inputs[9] = ".664.598..";
        assertEq(advent.problem3A(inputs), 4361);
    }

    function test_Problem3B() public {
        // inputs: 467..114..
        //         ...*......
        //         ..35..633.
        //         ......#...
        //         617*......
        //         .....+.58.
        //         ..592.....
        //         ......755.
        //         ...$.*....
        //         .664.598..
        // output: 467 + 35 + 633 + 617 + 592 + 755 + 664 + 598 = 4361
        string[] memory inputs = new string[](10);
        inputs[0] = "467..114..";
        inputs[1] = "...*......";
        inputs[2] = "..35..633.";
        inputs[3] = "......#...";
        inputs[4] = "617*......";
        inputs[5] = ".....+.58.";
        inputs[6] = "..592.....";
        inputs[7] = "......755.";
        inputs[8] = "...$.*....";
        inputs[9] = ".664.598..";
        assertEq(advent.problem3B(inputs), 467835);
    }
}
