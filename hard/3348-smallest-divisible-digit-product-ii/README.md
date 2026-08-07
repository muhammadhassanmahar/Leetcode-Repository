# Smallest Divisible Digit Product II

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

You are given a string num which represents a positive integer, and an integer t.

A number is called zero-free if none of its digits are 0.

Return a string representing the smallest zero-free number greater than or equal to num such that the product of its digits is divisible by t. If no such number exists, return "-1".

 
Example 1:


Input: num = "1234", t = 256

Output: "1488"

Explanation:

The smallest zero-free number that is greater than 1234 and has the product of its digits divisible by 256 is 1488, with the product of its digits equal to 256.


Example 2:


Input: num = "12355", t = 50

Output: "12355"

Explanation:

12355 is already zero-free and has the product of its digits divisible by 50, with the product of its digits equal to 150.


Example 3:


Input: num = "11111", t = 26

Output: "-1"

Explanation:

No number greater than 11111 has the product of its digits divisible by 26.


 
Constraints:


	2 <= num.length <= 2 * 105
	num consists only of digits in the range ['0', '9'].
	num does not contain leading zeros.
	1 <= t <= 1014

## Solution

**Language:** Python  
**Runtime:** 2631 ms (beats 83.33%)  
**Memory:** 21 MB (beats 83.33%)  
**Submitted:** 2026-08-07T09:37:40.567Z  

```py
class Solution(object):
    def smallestNumber(self, num, t):
        """
        :type num: str
        :type t: int
        :rtype: str
        """
        PRIMES = (2, 3, 5, 7)

        digit_factors = {
            1: {2: 0, 3: 0, 5: 0, 7: 0},
            2: {2: 1, 3: 0, 5: 0, 7: 0},
            3: {2: 0, 3: 1, 5: 0, 7: 0},
            4: {2: 2, 3: 0, 5: 0, 7: 0},
            5: {2: 0, 3: 0, 5: 1, 7: 0},
            6: {2: 1, 3: 1, 5: 0, 7: 0},
            7: {2: 0, 3: 0, 5: 0, 7: 1},
            8: {2: 3, 3: 0, 5: 0, 7: 0},
            9: {2: 0, 3: 2, 5: 0, 7: 0},
        }

        def get_prime_count(t):
            count = {2: 0, 3: 0, 5: 0, 7: 0}
            for p in PRIMES:
                while t % p == 0:
                    t //= p
                    count[p] += 1
            return count, t == 1

        def get_prime_count_from_string(s):
            count = {2: 0, 3: 0, 5: 0, 7: 0}
            for ch in s:
                d = int(ch)
                if d == 0:
                    continue
                df = digit_factors[d]
                for p in PRIMES:
                    count[p] += df[p]
            return count

        def subtract(a, b):
            return {p: max(0, a[p] - b[p]) for p in PRIMES}

        def sum_values(d):
            return sum(d.values())

        def is_subset(a, b):
            return all(b[p] >= a[p] for p in PRIMES)

        def get_factor_count(count):
            c2, c3, c5, c7 = count[2], count[3], count[5], count[7]
            count8 = c2 // 3
            remaining2 = c2 % 3
            count9 = c3 // 2
            count3 = c3 % 2
            count4 = remaining2 // 2
            count2 = remaining2 % 2
            count6 = 0
            if count2 == 1 and count3 == 1:
                count2, count3 = 0, 0
                count6 = 1
            if count3 == 1 and count4 == 1:
                count2 = 1
                count6 = 1
                count3, count4 = 0, 0
            return {2: count2, 3: count3, 4: count4, 5: c5,
                    6: count6, 7: c7, 8: count8, 9: count9}

        def construct(factors):
            parts = []
            for digit in range(2, 10):
                parts.append(str(digit) * factors.get(digit, 0))
            return "".join(parts)

        prime_count, is_divisible = get_prime_count(t)
        if not is_divisible:
            return "-1"

        factor_count = get_factor_count(prime_count)
        n = len(num)

        if sum_values(factor_count) > n:
            return construct(factor_count)

        prime_count_prefix = get_prime_count_from_string(num)

        first_zero_index = num.find('0')
        if first_zero_index == -1:
            first_zero_index = n
            if is_subset(prime_count, prime_count_prefix):
                return num

        for i in range(n - 1, -1, -1):
            d = int(num[i])
            df = digit_factors.get(d, {2: 0, 3: 0, 5: 0, 7: 0})
            prime_count_prefix = subtract(prime_count_prefix, df)
            space_after = n - 1 - i

            if i > first_zero_index:
                continue

            for bigger_digit in range(d + 1, 10):
                needed = subtract(subtract(prime_count, prime_count_prefix), digit_factors[bigger_digit])
                factors_after = get_factor_count(needed)
                if sum_values(factors_after) <= space_after:
                    fill_ones = space_after - sum_values(factors_after)
                    return num[:i] + str(bigger_digit) + "1" * fill_ones + construct(factors_after)

        factors_after_extension = get_factor_count(prime_count)
        return "1" * (n + 1 - sum_values(factors_after_extension)) + construct(factors_after_extension)
```

---

[View on LeetCode](https://leetcode.com/problems/smallest-divisible-digit-product-ii/)