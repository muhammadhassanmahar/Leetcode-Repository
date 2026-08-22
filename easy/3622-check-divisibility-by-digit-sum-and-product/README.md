# Check Divisibility by Digit Sum and Product

![Difficulty](https://img.shields.io/badge/Difficulty-Easy-green)

## Problem

You are given a positive integer n. Determine whether n is divisible by the sum of the following two values:


	
	The digit sum of n (the sum of its digits).
	
	
	The digit product of n (the product of its digits).
	


Return true if n is divisible by this sum; otherwise, return false.

 
Example 1:


Input: n = 99

Output: true

Explanation:

Since 99 is divisible by the sum (9 + 9 = 18) plus product (9 * 9 = 81) of its digits (total 99), the output is true.


Example 2:


Input: n = 23

Output: false

Explanation:

Since 23 is not divisible by the sum (2 + 3 = 5) plus product (2 * 3 = 6) of its digits (total 11), the output is false.


 
Constraints:


	1 <= n <= 106

## Solution

**Language:** dart  
**Runtime:** 0 ms  
**Memory:** 146.4 MB  
**Submitted:** 2026-08-22T05:22:21.547Z  

```dart
class Solution {
  bool checkDivisibility(int n) {
    int temp = n;
    int sum = 0;
    int product = 1;

    while (temp > 0) {

```

---

[View on LeetCode](https://leetcode.com/problems/check-divisibility-by-digit-sum-and-product/)