// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Utils} from "./Utils.sol";
import "forge-std/console.sol";


contract AdventOfCodeProblem7 is Utils {
  function getCardValue(bytes1 char) internal pure returns (uint) {
    if (char == bytes1("A")) {
      return 0xe;
    } else if (char == bytes1("K")) {
      return 0xd;
    } else if (char == bytes1("Q")) {
      return 0xc;
    } else if (char == bytes1("J")) {
      return 0xb;
    } else if (char == bytes1("T")) {
      return 0xa;
    } else if (isDigit(char)) {
      return byteToDigit(char);
    } else {
      revert("AdventOfCodeProblem7: getCardValue: invalid char");
    }
  }

  function getHandValue2(bytes memory input) internal returns (uint) {
    uint[] memory values = new uint[](5);
    for (uint i = 0; i < 5; i++) {
      values[i] = getCardValue(input[i]);
    }
    // console.log("values[0]: %d", values[0]);
    // console.log("values[1]: %d", values[1]);
    // console.log("values[2]: %d", values[2]);
    // console.log("values[3]: %d", values[3]);
    // console.log("values[4]: %d", values[4]);

    uint fiveValue;
    uint fourValue;
    uint threeValue;
    uint firstPairValue;
    uint secondPairValue;
    uint highCardValue = 0;

    for (uint i = 0; i < 5; i++) {
      uint sameCount = 0;
      for (uint j = 0; j < 5; j++) {
        if (values[i] == values[j]) {
          sameCount++;
        }
      }
      if (sameCount == 5) {
        fiveValue = values[i];
      } else if (sameCount == 4) {
        fourValue = values[i];
      } else if (sameCount == 3) {
        threeValue = values[i];
      } else if (sameCount == 2) {
        if (firstPairValue == 0 || firstPairValue == values[i]) {
          firstPairValue = values[i];
        } else {
          secondPairValue = values[i];
        }
      } else if (values[i] > highCardValue) {
        highCardValue = values[i];
      }
    }

    // console.log("fiveValue: %d", fiveValue);
    // console.log("fourValue: %d", fourValue);
    // console.log("threeValue: %d", threeValue);
    // console.log("firstPairValue: %d", firstPairValue);
    // console.log("secondPairValue: %d", secondPairValue);

    uint score;

    if (fiveValue != 0) {
      console.log("five of a kind");
      score = 0x100000000000000000000000000000000;
    } else if (fourValue != 0) {
      console.log("four of a kind");
      score = 0x1000000000000000000000000000;
    } else if (threeValue != 0) {
      if (firstPairValue != 0) {
        console.log("full house");
        score = 0x100000000000000000000;
      } else {
        console.log("three of a kind");
        score = 0x1000000000000000;
      }
    } else if (firstPairValue != 0) {
      if (secondPairValue != 0) {
        console.log("two pair");
        score = 0x100000000000;
      } else {
        console.log("one pair");
        score = 0x100000000;
      }
    } else {
      console.log("high card");
      score = 0x1000000;
    }

    score += values[0] * 0x10000 + values[1] * 0x1000 + values[2] * 0x100 + values[3] * 0x10 + values[4];

    return score;
  }

  function getHandValue(bytes memory input) internal returns (uint) {
    // Check for repeats of each number
    uint count1 = 0;
    uint count2 = 0;
    uint count3 = 0;
    uint count4 = 0;
    uint count5 = 0;
    for (uint i = 0; i < 5; i++) {
      if (input[i] == input[0]) {
        count1++;
      }
      if (input[i] == input[1]) {
        count2++;
      }
      if (input[i] == input[2]) {
        count3++;
      }
      if (input[i] == input[3]) {
        count4++;
      }
      if (input[i] == input[4]) {
        count5++;
      }
    }
    // console.log("count1: %d", count1);
    // console.log("count2: %d", count2);
    // console.log("count3: %d", count3);
    // console.log("count4: %d", count4);
    // console.log("count5: %d", count5);

    // Check for five of a kind
    if (count1 == 5) {
      console.log("five of a kind");
      return getCardValue(input[0]) * 0x100000000;
    }

    // Check for four of a kind
    if (count1 == 4) {
      console.log("four of a kind");
      if (count2 == 1) {
        return getCardValue(input[0]) * 0x10000000 + getCardValue(input[1]);
      } else if (count3 == 1) {
        return getCardValue(input[0]) * 0x10000000 + getCardValue(input[2]);
      } else if (count4 == 1) {
        return getCardValue(input[0]) * 0x10000000 + getCardValue(input[3]);
      } else if (count5 == 1) {
        return getCardValue(input[0]) * 0x10000000 + getCardValue(input[4]);
      }
    } else if (count2 == 4) {
      console.log("four of a kind");
      if (count1 == 1) {
        return getCardValue(input[1]) * 0x10000000 + getCardValue(input[0]);
      } else if (count3 == 1) {
        return getCardValue(input[1]) * 0x10000000 + getCardValue(input[2]);
      } else if (count4 == 1) {
        return getCardValue(input[1]) * 0x10000000 + getCardValue(input[3]);
      } else if (count5 == 1) {
        return getCardValue(input[1]) * 0x10000000 + getCardValue(input[4]);
      }
    }

    // Check for full house
    if (count1 == 3) {
      if (count2 == 2) {
        console.log("full house");
        return getCardValue(input[0]) * 0x1000000 + getCardValue(input[1]) * 0x100000;
      } else if (count3 == 2) {
        console.log("full house");
        return getCardValue(input[0]) * 0x1000000 + getCardValue(input[2]) * 0x100000;
      } else if (count4 == 2) {
        console.log("full house");
        return getCardValue(input[0]) * 0x1000000 + getCardValue(input[3]) * 0x100000;
      } else if (count5 == 2) {
        console.log("full house");
        return getCardValue(input[0]) * 0x1000000 + getCardValue(input[4]) * 0x100000;
      }
    } else if (count1 == 2) {
      if (count2 == 3) {
        console.log("full house");
        return getCardValue(input[1]) * 0x1000000 + getCardValue(input[0]) * 0x100000;
      } else if (count3 == 3) {
        console.log("full house");
        return getCardValue(input[2]) * 0x1000000 + getCardValue(input[0]) * 0x100000;
      } else if (count4 == 3) {
        console.log("full house");
        return getCardValue(input[3]) * 0x1000000 + getCardValue(input[0]) * 0x100000;
      } else if (count5 == 3) {
        console.log("full house");
        return getCardValue(input[4]) * 0x1000000 + getCardValue(input[0]) * 0x100000;
      }
    }

    // Check for three of a kind
    if (count1 == 3) {
      console.log("three of a kind");
      if (count2 == 1 && count3 == 1) {
        uint card1Value = getCardValue(input[1]);
        uint card2Value = getCardValue(input[2]);
        if (card1Value < card2Value) {
          return getCardValue(input[0]) * 0x100000 + card2Value * 0x1000 + card1Value * 0x10;
        } else {
          return getCardValue(input[0]) * 0x100000 + card1Value * 0x1000 + card2Value * 0x10;
        }
      }
    } else if (count2 == 3) {
      console.log("three of a kind");
      uint card1Value = getCardValue(input[0]);
      if (count3 == 1) {
        uint card2Value = getCardValue(input[2]);
        if (card1Value < card2Value) {
          return getCardValue(input[1]) * 0x10000 + card2Value * 0x100 + card1Value;
        } else {
          return getCardValue(input[1]) * 0x10000 + card1Value * 0x100 + card2Value;
        }
      } else if (count4 == 1) {
        uint card2Value = getCardValue(input[3]);
        if (card1Value < card2Value) {
          return getCardValue(input[1]) * 0x10000 + card2Value * 0x100 + card1Value;
        } else {
          return getCardValue(input[1]) * 0x10000 + card1Value * 0x100 + card2Value;
        }
      } else if (count5 == 1) {
        uint card2Value = getCardValue(input[4]);
        if (card1Value < card2Value) {
          return getCardValue(input[1]) * 0x10000 + card2Value * 0x100 + card1Value;
        } else {
          return getCardValue(input[1]) * 0x10000 + card1Value * 0x100 + card2Value;
        }
      }
    } else if (count3 == 3) {
      console.log("three of a kind");
      uint card1Value = getCardValue(input[0]);
      uint card2Value = getCardValue(input[1]);
      if (card1Value < card2Value) {
        return getCardValue(input[2]) * 0x10000  + card2Value * 0x100 + card1Value;
      } else {
        return getCardValue(input[2]) * 0x10000  + card1Value * 0x100 + card2Value;
      }
    }

    // Check for two pair
    if (count1 == 2) {
      if (count2 == 2 && input[0] != input[1]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[0]);
        uint card2Value = getCardValue(input[1]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      } else if (count3 == 2 && input[0] != input[2]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[0]);
        uint card2Value = getCardValue(input[2]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      } else if (count4 == 2 && input[0] != input[3]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[0]);
        uint card2Value = getCardValue(input[3]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      } else if (count5 == 2 && input[0] != input[4]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[0]);
        uint card2Value = getCardValue(input[4]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      }
    } else if (count2 == 2) {
      if (count3 == 2 && input[1] != input[2]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[1]);
        uint card2Value = getCardValue(input[2]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      } else if (count4 == 2 && input[1] != input[3]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[1]);
        uint card2Value = getCardValue(input[3]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      } else if (count5 == 2 && input[1] != input[4]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[1]);
        uint card2Value = getCardValue(input[4]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      }
    } else if (count3 == 2) {
      if (count4 == 2 && input[2] != input[3]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[2]);
        uint card2Value = getCardValue(input[3]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      } else if (count5 == 2 && input[2] != input[4]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[2]);
        uint card2Value = getCardValue(input[4]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      }
    } else if (count4 == 2) {
      if (count5 == 2 && input[3] != input[4]) {
        console.log("two pair");
        uint card1Value = getCardValue(input[3]);
        uint card2Value = getCardValue(input[4]);
        if (card1Value < card2Value) {
          return card2Value * 0x1000 + card1Value * 0x100;
        } else {
          return card1Value * 0x1000 + card2Value * 0x100;
        }
      }
    }

    // Check for one pair
    if (count1 == 2) {
      console.log("one pair");
      return getCardValue(input[0]) * 0x10;
    } else if (count2 == 2) {
      console.log("one pair");
      return getCardValue(input[1]) * 0x10;
    } else if (count3 == 2) {
      console.log("one pair");
      return getCardValue(input[2]) * 0x10;
    } else if (count4 == 2) {
      console.log("one pair");
      return getCardValue(input[3]) * 0x10;
    } else if (count5 == 2) {
      console.log("one pair");
      return getCardValue(input[4]) * 0x10;
    }

    // Check for high card
    uint highCard = 0;
    for (uint i = 0; i < 5; i++) {
      if (getCardValue(input[i]) > highCard) {
        highCard = getCardValue(input[i]);
      }
    }
    console.log("high card");
    return highCard;
  }

  function problem7A(string[] memory inputs) public returns (uint) {
    uint output = 0;

    uint[] memory scores = new uint[](inputs.length);
    uint[] memory bids = new uint[](inputs.length);
    for (uint i = 0; i < inputs.length; i++) {
      console.log(inputs[i]);
      scores[i] = getHandValue2(bytes(inputs[i]));
      console.log("score: %d", scores[i]);
      (bids[i],) = getWholeNumber(bytes(inputs[i]), 6);
      // console.log("bid: %d", bids[i]);
    }

    // Get scores ordered from high to low
    // Super naive n^2 algo, but list is really short, so doesn't matter
    for (uint rank = inputs.length; rank > 0; rank--) {
      uint maxScore = 0;
      uint maxScoreIndex = 0;
      for (uint j = 0; j < inputs.length; j++) {
        if (scores[j] > maxScore) {
          maxScore = scores[j];
          maxScoreIndex = j;
        }
      }
      // console.log("max score: %d", maxScore);
      // console.log("max score index: %d", maxScoreIndex);
      // console.log("rank: %d", rank);
      output += rank * bids[maxScoreIndex];
      scores[maxScoreIndex] = 0;
    }

    return output;
  }

  function problem7B(string[] memory inputs) public pure returns (uint) {
    uint output = 0;

    return output;
  }
}
