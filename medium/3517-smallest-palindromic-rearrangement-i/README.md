# Smallest Palindromic Rearrangement I

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given a palindromic string s.

Return the lexicographically smallest palindromic permutation of s.

 
Example 1:


Input: s = "z"

Output: "z"

Explanation:

A string of only one character is already the lexicographically smallest palindrome.


Example 2:


Input: s = "babab"

Output: "abbba"

Explanation:

Rearranging "babab" → "abbba" gives the smallest lexicographic palindrome.


Example 3:


Input: s = "daccad"

Output: "acddca"

Explanation:

Rearranging "daccad" → "acddca" gives the smallest lexicographic palindrome.


 
Constraints:


	1 <= s.length <= 105
	s consists of lowercase English letters.
	s is guaranteed to be palindromic.

## Solution

**Language:** Python  
**Runtime:** 436 ms (beats 61.76%)  
**Memory:** 13.3 MB (beats 85.29%)  
**Submitted:** 2026-07-28T10:36:52.438Z  

```py
class Solution(object):
    def smallestPalindrome(self, s):
        """
        :type s: str
        :rtype: str
        """
        freq = [0] * 26

        for ch in s:
            freq[ord(ch) - ord('a')] += 1

        left = []
        mid = ""

        for i in range(26):
            if freq[i] % 2 == 1:
                mid = chr(i + ord('a'))
            left.append(chr(i + ord('a')) * (freq[i] // 2))

        left = "".join(left)
        return left + mid + left[::-1]
```

---

[View on LeetCode](https://leetcode.com/problems/smallest-palindromic-rearrangement-i/)