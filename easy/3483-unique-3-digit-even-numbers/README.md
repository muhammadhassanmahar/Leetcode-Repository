# Unique 3-Digit Even Numbers

![Difficulty](https://img.shields.io/badge/Difficulty-Easy-green)

## Problem

You are given an array of digits called digits. Your task is to determine the number of distinct three-digit even numbers that can be formed using these digits.

Note: Each copy of a digit can only be used once per number, and there may not be leading zeros.

 
Example 1:


Input: digits = [1,2,3,4]

Output: 12

Explanation: The 12 distinct 3-digit even numbers that can be formed are 124, 132, 134, 142, 214, 234, 312, 314, 324, 342, 412, and 432. Note that 222 cannot be formed because there is only 1 copy of the digit 2.


Example 2:


Input: digits = [0,2,2]

Output: 2

Explanation: The only 3-digit even numbers that can be formed are 202 and 220. Note that the digit 2 can be used twice because it appears twice in the array.


Example 3:


Input: digits = [6,6,6]

Output: 1

Explanation: Only 666 can be formed.


Example 4:


Input: digits = [1,3,5]

Output: 0

Explanation: No even 3-digit numbers can be formed.


 
Constraints:


	3 <= digits.length <= 10
	0 <= digits[i] <= 9

## Solution

**Language:** dart  
**Runtime:** 27 ms (beats 100.00%)  
**Memory:** 151.3 MB (beats 100.00%)  
**Submitted:** 2026-09-11T10:21:38.455Z  

```dart
class Solution {
  int totalNumbers(List<int> digits) {
    Set<int> numbers = {};

    for (int i = 0; i < digits.length; i++) {
      for (int j = 0; j < digits.length; j++) {
        for (int k = 0; k < digits.length; k++) {
          // Same digit/index reuse nahi karna
          if (i == j || j == k || i == k) continue;

          // 3-digit number 0 se start nahi ho sakta
          if (digits[i] == 0) continue;

          // Number even hona chahiye
          if (digits[k] % 2 != 0) continue;

          int num = digits[i] * 100 +
              digits[j] * 10 +
              digits[k];

          numbers.add(num);
        }
      }
    }

    return numbers.length;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/unique-3-digit-even-numbers/)