# Lexicographically Smallest Permutation Greater Than Target

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given two strings s and target, both having length n, consisting of lowercase English letters.

Return the lexicographically smallest permutation of s that is strictly greater than target. If no permutation of s is lexicographically strictly greater than target, return an empty string.

A string a is lexicographically strictly greater than a string b (of the same length) if in the first position where a and b differ, string a has a letter that appears later in the alphabet than the corresponding letter in b.

 
Example 1:


Input: s = "abc", target = "bba"

Output: "bca"

Explanation:


	The permutations of s (in lexicographical order) are "abc", "acb", "bac", "bca", "cab", and "cba".
	The lexicographically smallest permutation that is strictly greater than target is "bca".



Example 2:


Input: s = "leet", target = "code"

Output: "eelt"

Explanation:


	The permutations of s (in lexicographical order) are "eelt", "eetl", "elet", "elte", "etel", "etle", "leet", "lete", "ltee", "teel", "tele", and "tlee".
	The lexicographically smallest permutation that is strictly greater than target is "eelt".



Example 3:


Input: s = "baba", target = "bbaa"

Output: ""

Explanation:


	The permutations of s (in lexicographical order) are "aabb", "abab", "abba", "baab", "baba", and "bbaa".
	None of them is lexicographically strictly greater than target. Therefore, the answer is "".



 
Constraints:


	1 <= s.length == target.length <= 300
	s and target consist of only lowercase English letters.

## Solution

**Language:** Python  
**Runtime:** 87 ms (beats 5.26%)  
**Memory:** 19.4 MB (beats 42.11%)  
**Submitted:** 2026-08-27T10:51:09.693Z  

```py
class Solution(object):
    def lexGreaterPermutation(self, s, target):
        """
        :type s: str
        :type target: str
        :rtype: str
        """

        count = [0] * 26

        for ch in s:
            count[ord(ch) - ord('a')] += 1

        n = len(target)

        def build_greater(pos):
            result = []

            for i in range(pos):
                idx = ord(target[i]) - ord('a')
                result.append(target[i])
                count[idx] -= 1

            # At position pos, choose the smallest
            # character strictly greater than target[pos]
            cur = ord(target[pos]) - ord('a')

            for c in range(cur + 1, 26):
                if count[c] > 0:
                    result.append(chr(c + ord('a')))
                    count[c] -= 1

                    # Put remaining characters in sorted order
                    for x in range(26):
                        result.append(chr(x + ord('a')) * count[x])

                    return ''.join(result)

            # Restore count
            for i in range(pos):
                count[ord(target[i]) - ord('a')] += 1

            return ""

        # First try to make a difference at the latest possible position.
        for pos in range(n - 1, -1, -1):
            count = [0] * 26

            for ch in s:
                count[ord(ch) - ord('a')] += 1

            possible = True

            # Prefix must exactly match target
            for i in range(pos):
                idx = ord(target[i]) - ord('a')

                if count[idx] == 0:
                    possible = False
                    break

                count[idx] -= 1

            if not possible:
                continue

            cur = ord(target[pos]) - ord('a')

            # Choose smallest character > target[pos]
            for c in range(cur + 1, 26):
                if count[c] > 0:
                    result = target[:pos] + chr(c + ord('a'))
                    count[c] -= 1

                    # Remaining characters smallest possible order
                    for x in range(26):
                        result += chr(x + ord('a')) * count[x]

                    return result

        return ""
```

---

[View on LeetCode](https://leetcode.com/problems/lexicographically-smallest-permutation-greater-than-target/)