# Distinct Subsequences II

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

Given a string s, return the number of distinct non-empty subsequences of s. Since the answer may be very large, return it modulo 109 + 7.
A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not.
 
Example 1:

Input: s = "abc"
Output: 7
Explanation: The 7 distinct subsequences are "a", "b", "c", "ab", "ac", "bc", and "abc".


Example 2:

Input: s = "aba"
Output: 6
Explanation: The 6 distinct subsequences are "a", "b", "ab", "aa", "ba", and "aba".


Example 3:

Input: s = "aaa"
Output: 3
Explanation: The 3 distinct subsequences are "a", "aa" and "aaa".


 
Constraints:


	1 <= s.length <= 2000
	s consists of lowercase English letters.

## Solution

**Language:** dart  
**Runtime:** 8 ms (beats 100.00%)  
**Memory:** 152.3 MB (beats 100.00%)  
**Submitted:** 2026-09-07T04:05:56.861Z  

```dart
class Solution {
  int distinctSubseqII(String s) {
    const int MOD = 1000000007;

    List<int> dp = List.filled(26, 0);

    for (int i = 0; i < s.length; i++) {
      int index = s.codeUnitAt(i) - 97;

      int total = 0;
      for (int j = 0; j < 26; j++) {
        total = (total + dp[j]) % MOD;
      }

      dp[index] = (total + 1) % MOD;
    }

    int answer = 0;

    for (int value in dp) {
      answer = (answer + value) % MOD;
    }

    return answer;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/distinct-subsequences-ii/)