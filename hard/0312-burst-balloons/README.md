# Burst Balloons

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

You are given n balloons, indexed from 0 to n - 1. Each balloon is painted with a number on it represented by an array nums. You are asked to burst all the balloons.

If you burst the ith balloon, you will get nums[i - 1] * nums[i] * nums[i + 1] coins. If i - 1 or i + 1 goes out of bounds of the array, then treat it as if there is a balloon with a 1 painted on it.

Return the maximum coins you can collect by bursting the balloons wisely.

 
Example 1:

Input: nums = [3,1,5,8]
Output: 167
Explanation:
nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
coins =  3*1*5    +   3*5*8   +  1*3*8  + 1*8*1 = 167

Example 2:

Input: nums = [1,5]
Output: 10


 
Constraints:


	n == nums.length
	1 <= n <= 300
	0 <= nums[i] <= 100

## Solution

**Language:** dart  
**Runtime:** 66 ms (beats 100.00%)  
**Memory:** 152.8 MB  
**Submitted:** 2026-08-22T15:58:52.773Z  

```dart
class Solution {
  int maxCoins(List<int> nums) {
    int n = nums.length;

    // Add virtual balloons with value 1
    List<int> arr = [1, ...nums, 1];

    // dp[left][right] =
    // maximum coins from balloons between left and right
    List<List<int>> dp = List.generate(
      n + 2,
      (_) => List.filled(n + 2, 0),
    );

    // length = interval length
    for (int length = 2; length < n + 2; length++) {
      for (int left = 0; left + length < n + 2; left++) {
        int right = left + length;

        for (int k = left + 1; k < right; k++) {
          int coins =
              dp[left][k] +
              dp[k][right] +
              arr[left] * arr[k] * arr[right];

          if (coins > dp[left][right]) {
            dp[left][right] = coins;
          }
        }
      }
    }

    return dp[0][n + 1];
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/burst-balloons/)