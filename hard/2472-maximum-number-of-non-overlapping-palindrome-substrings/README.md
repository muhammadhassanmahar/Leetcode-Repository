# Maximum Number of Non-overlapping Palindrome Substrings

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

You are given a string `s` and a **positive** integer `k`.

Select a set of **non-overlapping** substrings from the string `s` that satisfy the following conditions:

- The length of each substring is at least k.
- Each substring is a palindrome.

Return *the **maximum** number of substrings in an optimal selection*.

A **substring** is a contiguous sequence of characters within a string.

 

**Example 1:**

```
Input: s = "abaccdbbd", k = 3
Output: 2
Explanation: We can select the substrings underlined in s = "abaccdbbd". Both "aba" and "dbbd" are palindromes and have a length of at least k = 3.
It can be shown that we cannot find a selection with more than two valid substrings.

```

**Example 2:**

```
Input: s = "adbcda", k = 2
Output: 0
Explanation: There is no palindrome substring of length at least 2 in the string.

```

 

**Constraints:**

- 1 <= k <= s.length <= 2000
- s consists of lowercase English letters.

## Solution

**Language:** dart  
**Runtime:** 376 ms (beats 100.00%)  
**Memory:** 338.2 MB (beats 100.00%)  
**Submitted:** 2026-09-15T10:57:13.762Z  

```dart
class Solution {
  int maxPalindromes(String s, int k) {
    int n = s.length;

    // isPal[i][j] = s[i..j] palindrome hai ya nahi
    List<List<bool>> isPal = List.generate(
      n,
      (_) => List<bool>.filled(n, false),
    );

    // Palindrome table
    for (int i = n - 1; i >= 0; i--) {
      for (int j = i; j < n; j++) {
        if (s[i] == s[j] &&
            (j - i <= 2 || isPal[i + 1][j - 1])) {
          isPal[i][j] = true;
        }
      }
    }

    // dp[i] = first i characters se maximum palindromes
    List<int> dp = List.filled(n + 1, 0);

    for (int end = 1; end <= n; end++) {
      // Current character ko skip karo
      dp[end] = dp[end - 1];

      // Har possible starting position
      for (int start = 0; start <= end - k; start++) {
        if (isPal[start][end - 1]) {
          dp[end] = dp[end] > dp[start] + 1
              ? dp[end]
              : dp[start] + 1;
        }
      }
    }

    return dp[n];
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/maximum-number-of-non-overlapping-palindrome-substrings/)