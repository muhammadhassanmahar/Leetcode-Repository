# Remove Duplicate Letters

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Given a string s, remove duplicate letters so that every letter appears once and only once. You must make sure your result is the smallest in lexicographical order among all possible results.

 
Example 1:

Input: s = "bcabc"
Output: "abc"


Example 2:

Input: s = "cbacdcbc"
Output: "acdb"


 
Constraints:


	1 <= s.length <= 104
	s consists of lowercase English letters.


 
Note: This question is the same as 1081: https://leetcode.com/problems/smallest-subsequence-of-distinct-characters/

## Solution

**Language:** dart  
**Runtime:** 6 ms (beats 40.00%)  
**Memory:** 149.1 MB (beats 100.00%)  
**Submitted:** 2026-08-22T16:00:23.949Z  

```dart
class Solution {
  String removeDuplicateLetters(String s) {
    // Har character ki remaining frequency
    List<int> count = List.filled(26, 0);

    for (int i = 0; i < s.length; i++) {
      count[s.codeUnitAt(i) - 97]++;
    }

    List<String> stack = [];
    List<bool> used = List.filled(26, false);

    for (int i = 0; i < s.length; i++) {
      String ch = s[i];
      int index = s.codeUnitAt(i) - 97;

      // Ye occurrence process ho gayi
      count[index]--;

      // Already answer mein hai
      if (used[index]) {
        continue;
      }

      // Agar stack ka last character:
      // 1. current se bada hai
      // 2. aur future mein dobara aa sakta hai
      // to usko remove kar do
      while (stack.isNotEmpty) {
        String last = stack.last;
        int lastIndex = last.codeUnitAt(0) - 97;

        if (last.compareTo(ch) > 0 && count[lastIndex] > 0) {
          stack.removeLast();
          used[lastIndex] = false;
        } else {
          break;
        }
      }

      stack.add(ch);
      used[index] = true;
    }

    return stack.join();
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/remove-duplicate-letters/)