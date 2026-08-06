# Smallest Divisible Digit Product I

![Difficulty](https://img.shields.io/badge/Difficulty-Easy-green)

## Problem

You are given two integers n and t. Return the smallest number greater than or equal to n such that the product of its digits is divisible by t.

 
Example 1:


Input: n = 10, t = 2

Output: 10

Explanation:

The digit product of 10 is 0, which is divisible by 2, making it the smallest number greater than or equal to 10 that satisfies the condition.


Example 2:


Input: n = 15, t = 3

Output: 16

Explanation:

The digit product of 16 is 6, which is divisible by 3, making it the smallest number greater than or equal to 15 that satisfies the condition.


 
Constraints:


	1 <= n <= 100
	1 <= t <= 10

## Solution

**Language:** dart  
**Runtime:** 0 ms (beats 100.00%)  
**Memory:** 153.7 MB  
**Submitted:** 2026-08-06T06:14:16.068Z  

```dart
class Solution {
  int smallestNumber(int n, int t) {
    while (true) {
      int product = 1;
      int x = n;

      while (x > 0) {
        product *= x % 10;
        x ~/= 10;
      }

      if (product % t == 0) {
        return n;
      }

      n++;
    }
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/smallest-divisible-digit-product-i/)