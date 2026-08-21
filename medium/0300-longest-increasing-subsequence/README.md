# Longest Increasing Subsequence

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Given an integer array nums, return the length of the longest strictly increasing subsequence.

 
Example 1:

Input: nums = [10,9,2,5,3,7,101,18]
Output: 4
Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.


Example 2:

Input: nums = [0,1,0,3,2,3]
Output: 4


Example 3:

Input: nums = [7,7,7,7,7,7,7]
Output: 1


 
Constraints:


	1 <= nums.length <= 2500
	-104 <= nums[i] <= 104


 
Follow up: Can you come up with an algorithm that runs in O(n log(n)) time complexity?

## Solution

**Language:** dart  
**Runtime:** 50 ms (beats 62.50%)  
**Memory:** 150.8 MB (beats 12.50%)  
**Submitted:** 2026-08-21T04:39:27.023Z  

```dart
class Solution {
  int lengthOfLIS(List<int> nums) {
    int n = nums.length;

    List<int> dp = List.filled(n, 1);

    int answer = 1;

    for (int i = 1; i < n; i++) {
      for (int j = 0; j < i; j++) {
        if (nums[j] < nums[i]) {
          dp[i] = dp[i] > dp[j] + 1
              ? dp[i]
              : dp[j] + 1;
        }
      }

      answer = answer > dp[i] ? answer : dp[i];
    }

    return answer;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/longest-increasing-subsequence/)