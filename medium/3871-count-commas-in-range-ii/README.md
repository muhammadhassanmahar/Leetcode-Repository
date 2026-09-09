# Count Commas in Range II

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given an integer n.

Return the total number of commas used when writing all integers from [1, n] (inclusive) in standard number formatting.

In standard formatting:


	A comma is inserted after every three digits from the right.
	Numbers with fewer than 4 digits contain no commas.


 
Example 1:


Input: n = 1002

Output: 3

Explanation:

The numbers "1,000", "1,001", and "1,002" each contain one comma, giving a total of 3.


Example 2:


Input: n = 998

Output: 0

Explanation:

​​​​​​​All numbers from 1 to 998 have fewer than four digits. Therefore, no commas are used.


 
Constraints:


	1 <= n <= 1015

## Solution

**Language:** dart  
**Runtime:** 0 ms (beats 100.00%)  
**Memory:** 151.4 MB (beats 100.00%)  
**Submitted:** 2026-09-09T06:06:40.542Z  

```dart
class Solution {
  int countCommas(int n) {
    int ans = 0;
    int x = 1000;

    while (x <= n) {
      ans += n - x + 1;

      if (x > n ~/ 1000) {
        break;
      }

      x *= 1000;
    }

    return ans;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/count-commas-in-range-ii/)