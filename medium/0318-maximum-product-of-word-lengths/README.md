# Maximum Product of Word Lengths

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Given a string array words, return the maximum value of length(word[i]) * length(word[j]) where the two words do not share common letters. If no such two words exist, return 0.

 
Example 1:

Input: words = ["abcw","baz","foo","bar","xtfn","abcdef"]
Output: 16
Explanation: The two words can be "abcw", "xtfn".


Example 2:

Input: words = ["a","ab","abc","d","cd","bcd","abcd"]
Output: 4
Explanation: The two words can be "ab", "cd".


Example 3:

Input: words = ["a","aa","aaa","aaaa"]
Output: 0
Explanation: No such pair of words.


 
Constraints:


	2 <= words.length <= 1000
	1 <= words[i].length <= 1000
	words[i] consists only of lowercase English letters.

## Solution

**Language:** dart  
**Runtime:** 6 ms (beats 100.00%)  
**Memory:** 151 MB  
**Submitted:** 2026-08-22T16:00:55.195Z  

```dart
class Solution {
  int maxProduct(List<String> words) {
    int n = words.length;

    // Har word ka bitmask
    List<int> masks = List.filled(n, 0);

    for (int i = 0; i < n; i++) {
      int mask = 0;

      for (int j = 0; j < words[i].length; j++) {
        int bit = words[i].codeUnitAt(j) - 97;

        mask |= (1 << bit);
      }

      masks[i] = mask;
    }

    int answer = 0;

    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {

        // No common character
        if ((masks[i] & masks[j]) == 0) {
          int product = words[i].length * words[j].length;

          if (product > answer) {
            answer = product;
          }
        }
      }
    }

    return answer;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/maximum-product-of-word-lengths/)