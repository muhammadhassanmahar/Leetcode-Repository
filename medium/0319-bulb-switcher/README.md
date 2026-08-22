# Bulb Switcher

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

There are n bulbs that are initially off. You first turn on all the bulbs, then you turn off every second bulb.

On the third round, you toggle every third bulb (turning on if it's off or turning off if it's on). For the ith round, you toggle every i bulb. For the nth round, you only toggle the last bulb.

Return the number of bulbs that are on after n rounds.

 
Example 1:

Input: n = 3
Output: 1
Explanation: At first, the three bulbs are [off, off, off].
After the first round, the three bulbs are [on, on, on].
After the second round, the three bulbs are [on, off, on].
After the third round, the three bulbs are [on, off, off]. 
So you should return 1 because there is only one bulb is on.

Example 2:

Input: n = 0
Output: 0


Example 3:

Input: n = 1
Output: 1


 
Constraints:


	0 <= n <= 109

## Solution

**Language:** dart  
**Runtime:** 0 ms (beats 100.00%)  
**Memory:** 148.4 MB (beats 66.67%)  
**Submitted:** 2026-08-22T16:01:39.579Z  

```dart
import 'dart:math';

class Solution {
  int bulbSwitch(int n) {
    return sqrt(n).toInt();
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/bulb-switcher/)