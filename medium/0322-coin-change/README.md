# Coin Change

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

You may assume that you have an infinite number of each kind of coin.

 
Example 1:

Input: coins = [1,2,5], amount = 11
Output: 3
Explanation: 11 = 5 + 5 + 1


Example 2:

Input: coins = [2], amount = 3
Output: -1


Example 3:

Input: coins = [1], amount = 0
Output: 0


 
Constraints:


	1 <= coins.length <= 12
	1 <= coins[i] <= 231 - 1
	0 <= amount <= 104

## Solution

**Language:** dart  
**Runtime:** 28 ms (beats 91.67%)  
**Memory:** 150.5 MB (beats 58.33%)  
**Submitted:** 2026-09-06T14:56:55.403Z  

```dart
import 'dart:math';

class Solution {
  int coinChange(List<int> coins, int amount) {
    List<int> dp = List.filled(amount + 1, amount + 1);
    dp[0] = 0;

    for (int i = 1; i <= amount; i++) {
      for (int coin in coins) {
        if (coin <= i) {
          dp[i] = min(dp[i], dp[i - coin] + 1);
        }
      }
    }

    return dp[amount] > amount ? -1 : dp[amount];
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/coin-change/)