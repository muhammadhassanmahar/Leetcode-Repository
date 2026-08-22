# Super Ugly Number

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

A super ugly number is a positive integer whose prime factors are in the array primes.

Given an integer n and an array of integers primes, return the nth super ugly number.

The nth super ugly number is guaranteed to fit in a 32-bit signed integer.

 
Example 1:

Input: n = 12, primes = [2,7,13,19]
Output: 32
Explanation: [1,2,4,7,8,13,14,16,19,26,28,32] is the sequence of the first 12 super ugly numbers given primes = [2,7,13,19].


Example 2:

Input: n = 1, primes = [2,3,5]
Output: 1
Explanation: 1 has no prime factors, therefore all of its prime factors are in the array primes = [2,3,5].


 
Constraints:


	1 <= n <= 105
	1 <= primes.length <= 100
	2 <= primes[i] <= 1000
	primes[i] is guaranteed to be a prime number.
	All the values of primes are unique and sorted in ascending order.

## Solution

**Language:** dart  
**Runtime:** 38 ms (beats 100.00%)  
**Memory:** 151.5 MB  
**Submitted:** 2026-08-22T15:59:23.350Z  

```dart
class Solution {
  int nthSuperUglyNumber(int n, List<int> primes) {
    List<int> ugly = List.filled(n, 0);
    ugly[0] = 1;

    int k = primes.length;

    // Har prime ka pointer
    List<int> index = List.filled(k, 0);

    // Har prime ka next candidate
    List<int> next = List.from(primes);

    for (int i = 1; i < n; i++) {
      // Smallest candidate
      int minValue = next[0];

      for (int j = 1; j < k; j++) {
        if (next[j] < minValue) {
          minValue = next[j];
        }
      }

      ugly[i] = minValue;

      // Jis prime ka candidate min tha,
      // uska pointer aage move karo
      for (int j = 0; j < k; j++) {
        if (next[j] == minValue) {
          index[j]++;
          next[j] = ugly[index[j]] * primes[j];
        }
      }
    }

    return ugly[n - 1];
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/super-ugly-number/)