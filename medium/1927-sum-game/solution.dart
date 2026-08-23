class Solution {
  bool sumGame(String num) {
    int n = num.length;
    int half = n ~/ 2;

    int leftSum = 0;
    int rightSum = 0;
    int leftQ = 0;
    int rightQ = 0;

    for (int i = 0; i < n; i++) {
      if (num[i] == '?') {
        if (i < half) {
          leftQ++;
        } else {
          rightQ++;
        }
      } else {
        int digit = int.parse(num[i]);

        if (i < half) {
          leftSum += digit;
        } else {
          rightSum += digit;
        }
      }
    }

    int qDiff = leftQ - rightQ;
    int sumDiff = leftSum - rightSum;

    // Same number of '?' on both sides.
    if (qDiff == 0) {
      return sumDiff != 0;
    }

    // Odd difference in '?' -> Alice always wins.
    if (qDiff.abs() % 2 == 1) {
      return true;
    }

    // Even difference.
    int required = (qDiff.abs() ~/ 2) * 9;

    if (qDiff > 0) {
      return sumDiff != -required;
    } else {
      return sumDiff != required;
    }
  }
}