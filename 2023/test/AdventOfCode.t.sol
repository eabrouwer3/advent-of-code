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

    function test_Problem2() public {
        // inputs: Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        //         Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        //         Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        //         Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        //         Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        string[] memory inputs = new string[](5);
        inputs[0] = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
        inputs[1] = "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue";
        inputs[2] = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red";
        inputs[3] = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red";
        inputs[4] = "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        // output: 1 + 2 + 5 = 8
        assertEq(advent.problem2A(inputs), 8);
        assertEq(advent.problem2B(inputs), 2286);
    }

    function test_Problem3() public {
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
        assertEq(advent.problem3B(inputs), 467835);
    }

    function test_Problem4() public {
        // inputs: Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        //         Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        //         Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        //         Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        //         Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        //         Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        string[] memory inputs = new string[](6);
        inputs[0] = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53";
        inputs[1] = "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19";
        inputs[2] = "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1";
        inputs[3] = "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83";
        inputs[4] = "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36";
        inputs[5] = "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11";
        // output: 8 + 2 + 2 + 1 + 0 + 0 = 13
        assertEq(advent.problem4A(inputs, 5, 8), 13);
        assertEq(advent.problem4B(inputs, 5, 8), 30);
    }

    function test_Problem5() public {
        // inputs: seeds: 79 14 55 13
        //
        //         seed-to-soil map:
        //         50 98 2
        //         52 50 48
        //
        //         soil-to-fertilizer map:
        //         0 15 37
        //         37 52 2
        //         39 0 15
        //
        //         fertilizer-to-water map:
        //         49 53 8
        //         0 11 42
        //         42 0 7
        //         57 7 4
        //
        //         water-to-light map:
        //         88 18 7
        //         18 25 70
        //
        //         light-to-temperature map:
        //         45 77 23
        //         81 45 19
        //         68 64 13
        //
        //         temperature-to-humidity map:
        //         0 69 1
        //         1 0 69
        //
        //         humidity-to-location map:
        //         60 56 37
        //         56 93 4
        // output: 35
        string[] memory inputs = new string[](33);
        inputs[0] = "seeds: 79 14 55 13";
        inputs[1] = "";
        inputs[2] = "seed-to-soil map:";
        inputs[3] = "50 98 2";
        inputs[4] = "52 50 48";
        inputs[5] = "";
        inputs[6] = "soil-to-fertilizer map:";
        inputs[7] = "0 15 37";
        inputs[8] = "37 52 2";
        inputs[9] = "39 0 15";
        inputs[10] = "";
        inputs[11] = "fertilizer-to-water map:";
        inputs[12] = "49 53 8";
        inputs[13] = "0 11 42";
        inputs[14] = "42 0 7";
        inputs[15] = "57 7 4";
        inputs[16] = "";
        inputs[17] = "water-to-light map:";
        inputs[18] = "88 18 7";
        inputs[19] = "18 25 70";
        inputs[20] = "";
        inputs[21] = "light-to-temperature map:";
        inputs[22] = "45 77 23";
        inputs[23] = "81 45 19";
        inputs[24] = "68 64 13";
        inputs[25] = "";
        inputs[26] = "temperature-to-humidity map:";
        inputs[27] = "0 69 1";
        inputs[28] = "1 0 69";
        inputs[29] = "";
        inputs[30] = "humidity-to-location map:";
        inputs[31] = "60 56 37";
        inputs[32] = "56 93 4";
        assertEq(advent.problem5A(inputs), 35);
        assertEq(advent.problem5B(inputs), 46);
    }

    function test_Problem6() public {
        // inputs: Time:      7  15   30
        //         Distance:  9  40  200
        string[] memory inputs = new string[](2);
        inputs[0] = "Time:      7  15   30";
        inputs[1] = "Distance:  9  40  200";
        // output: 4 * 8 * 9 = 288
        assertEq(advent.problem6A(inputs), 288);
        assertEq(advent.problem6B(inputs), 71503);
    }
}
