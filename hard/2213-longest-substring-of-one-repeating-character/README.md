# Longest Substring of One Repeating Character

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

You are given a 0-indexed string s. You are also given a 0-indexed string queryCharacters of length k and a 0-indexed array of integer indices queryIndices of length k, both of which are used to describe k queries.

The ith query updates the character in s at index queryIndices[i] to the character queryCharacters[i].

Return an array lengths of length k where lengths[i] is the length of the longest substring of s consisting of only one repeating character after the ith query is performed.

 
Example 1:

Input: s = "babacc", queryCharacters = "bcb", queryIndices = [1,3,3]
Output: [3,3,4]
Explanation: 
- 1st query updates s = "bbbacc". The longest substring consisting of one repeating character is "bbb" with length 3.
- 2nd query updates s = "bbbccc". 
  The longest substring consisting of one repeating character can be "bbb" or "ccc" with length 3.
- 3rd query updates s = "bbbbcc". The longest substring consisting of one repeating character is "bbbb" with length 4.
Thus, we return [3,3,4].


Example 2:

Input: s = "abyzz", queryCharacters = "aa", queryIndices = [2,1]
Output: [2,3]
Explanation:
- 1st query updates s = "abazz". The longest substring consisting of one repeating character is "zz" with length 2.
- 2nd query updates s = "aaazz". The longest substring consisting of one repeating character is "aaa" with length 3.
Thus, we return [2,3].


 
Constraints:


	1 <= s.length <= 105
	s consists of lowercase English letters.
	k == queryCharacters.length == queryIndices.length
	1 <= k <= 105
	queryCharacters consists of lowercase English letters.
	0 <= queryIndices[i] < s.length

## Solution

**Language:** Python  
**Runtime:** 6207 ms (beats 62.50%)  
**Memory:** 88.5 MB (beats 25.00%)  
**Submitted:** 2026-08-13T08:38:42.708Z  

```py
class Solution(object):
    def longestRepeating(self, s, queryCharacters, queryIndices):
        """
        :type s: str
        :type queryCharacters: str
        :type queryIndices: List[int]
        :rtype: List[int]
        """
        n = len(s)
        size_tree = 4 * n

        left_char = [0] * size_tree
        right_char = [0] * size_tree
        prefix = [0] * size_tree
        suffix = [0] * size_tree
        best = [0] * size_tree
        seg_len = [0] * size_tree

        chars = [ord(c) for c in s]

        def pull(node, lc, rc):
            seg_len[node] = seg_len[lc] + seg_len[rc]
            left_char[node] = left_char[lc]
            right_char[node] = right_char[rc]

            prefix[node] = prefix[lc]
            if prefix[lc] == seg_len[lc] and left_char[lc] == left_char[rc]:
                prefix[node] += prefix[rc]

            suffix[node] = suffix[rc]
            if suffix[rc] == seg_len[rc] and right_char[rc] == right_char[lc]:
                suffix[node] += suffix[lc]

            best[node] = max(best[lc], best[rc])
            if right_char[lc] == left_char[rc]:
                best[node] = max(best[node], suffix[lc] + prefix[rc])

        def build(node, l, r):
            if l == r:
                left_char[node] = right_char[node] = chars[l]
                prefix[node] = suffix[node] = best[node] = seg_len[node] = 1
                return
            mid = (l + r) // 2
            lc, rc = 2 * node, 2 * node + 1
            build(lc, l, mid)
            build(rc, mid + 1, r)
            pull(node, lc, rc)

        def update(node, l, r, idx, ch):
            if l == r:
                left_char[node] = right_char[node] = ch
                return
            mid = (l + r) // 2
            lc, rc = 2 * node, 2 * node + 1
            if idx <= mid:
                update(lc, l, mid, idx, ch)
            else:
                update(rc, mid + 1, r, idx, ch)
            pull(node, lc, rc)

        build(1, 0, n - 1)

        ans = []
        for qc, qi in zip(queryCharacters, queryIndices):
            update(1, 0, n - 1, qi, ord(qc))
            ans.append(best[1])

        return ans
```

---

[View on LeetCode](https://leetcode.com/problems/longest-substring-of-one-repeating-character/)