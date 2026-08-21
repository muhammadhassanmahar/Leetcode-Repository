# Best Time to Buy and Sell Stock with Cooldown

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given an array prices where prices[i] is the price of a given stock on the ith day.

Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:


	After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).


Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

 
Example 1:

Input: prices = [1,2,3,0,2]
Output: 3
Explanation: transactions = [buy, sell, cooldown, buy, sell]


Example 2:

Input: prices = [1]
Output: 0


 
Constraints:


	1 <= prices.length <= 5000
	0 <= prices[i] <= 1000

## Solution

**Language:** dart  
**Runtime:** 0 ms (beats 100.00%)  
**Memory:** 152.3 MB (beats 25.00%)  
**Submitted:** 2026-08-21T04:41:57.678Z  

```dart
class Solution {
  int maxProfit(List<int> prices) {
    if (prices.isEmpty) return 0;

    int hold = -prices[0];
    int sold = 0;
    int cooldown = 0;

    for (int i = 1; i < prices.length; i++) {
      int prevHold = hold;
      int prevSold = sold;
      int prevCooldown = cooldown;

      // Stock hold kar rahe hain
      hold = prevHold > prevCooldown - prices[i]
          ? prevHold
          : prevCooldown - prices[i];

      // Aaj sell kiya
      sold = prevHold + prices[i];

      // Aaj kuch nahi kiya / cooldown
      cooldown = prevCooldown > prevSold
          ? prevCooldown
          : prevSold;
    }

    return sold > cooldown ? sold : cooldown;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/)