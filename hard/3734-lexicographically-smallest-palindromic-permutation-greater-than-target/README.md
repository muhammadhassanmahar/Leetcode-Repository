# Lexicographically Smallest Palindromic Permutation Greater Than Target

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

You are given two strings s and target, each of length n, consisting of lowercase English letters.

Return the lexicographically smallest string that is both a palindromic permutation of s and strictly greater than target. If no such permutation exists, return an empty string.

 
Example 1:


Input: s = "baba", target = "abba"

Output: "baab"

Explanation:


	The palindromic permutations of s (in lexicographical order) are "abba" and "baab".
	The lexicographically smallest permutation that is strictly greater than target is "baab".



Example 2:


Input: s = "baba", target = "bbaa"

Output: ""

Explanation:


	The palindromic permutations of s (in lexicographical order) are "abba" and "baab".
	None of them is lexicographically strictly greater than target. Therefore, the answer is "".



Example 3:


Input: s = "abc", target = "abb"

Output: ""

Explanation:

s has no palindromic permutations. Therefore, the answer is "".


Example 4:


Input: s = "aac", target = "abb"

Output: "aca"

Explanation:


	The only palindromic permutation of s is "aca".
	"aca" is strictly greater than target. Therefore, the answer is "aca".



 
Constraints:


	1 <= n == s.length == target.length <= 300
	s and target consist of only lowercase English letters.

## Solution

**Language:** Python  
**Runtime:** 47 ms (beats 28.79%)  
**Memory:** 19.4 MB (beats 68.18%)  
**Submitted:** 2026-08-28T04:25:38.275Z  

```py
class Solution(object):
    def lexPalindromicPermutation(self, s, target):
        """
        :type s: str
        :type target: str
        :rtype: str
        """

        n = len(s)

        # Count characters
        freq = [0] * 26

        for ch in s:
            freq[ord(ch) - ord('a')] += 1

        # More than one odd frequency -> no palindrome possible
        odd = -1

        for i in range(26):
            if freq[i] % 2 == 1:
                if odd != -1:
                    return ""
                odd = i

        half_len = n // 2

        # Characters available in left half
        half = [freq[i] // 2 for i in range(26)]

        middle = ""
        if odd != -1:
            middle = chr(ord('a') + odd)

        def make_palindrome(left):
            return left + middle + left[::-1]

        # --------------------------------------------------
        # 1. Try using target's first half exactly
        # --------------------------------------------------

        used = [0] * 26
        left = []
        possible = True

        for i in range(half_len):
            c = ord(target[i]) - ord('a')

            if used[c] >= half[c]:
                possible = False
                break

            used[c] += 1
            left.append(target[i])

        if possible:
            left = ''.join(left)

            # If this palindrome is already greater,
            # it is the smallest possible answer.
            candidate = make_palindrome(left)

            if candidate > target:
                return candidate

        # --------------------------------------------------
        # 2. Find the smallest left half > target's left half
        # --------------------------------------------------

        for pos in range(half_len - 1, -1, -1):

            used = [0] * 26
            prefix = []
            possible = True

            # Match target prefix exactly
            for i in range(pos):
                c = ord(target[i]) - ord('a')

                if used[c] >= half[c]:
                    possible = False
                    break

                used[c] += 1
                prefix.append(target[i])

            if not possible:
                continue

            target_char = ord(target[pos]) - ord('a')

            # Choose smallest character greater than target[pos]
            for c in range(target_char + 1, 26):

                if used[c] >= half[c]:
                    continue

                new_left = prefix[:]
                new_left.append(chr(ord('a') + c))

                used[c] += 1

                # Fill remaining characters in sorted order
                for x in range(26):
                    remaining = half[x] - used[x]

                    if remaining > 0:
                        new_left.append(
                            chr(ord('a') + x) * remaining
                        )

                left = ''.join(new_left)

                return make_palindrome(left)

        return ""
```

---

[View on LeetCode](https://leetcode.com/problems/lexicographically-smallest-palindromic-permutation-greater-than-target/)