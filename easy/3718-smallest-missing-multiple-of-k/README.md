# Smallest Missing Multiple of K

![Difficulty](https://img.shields.io/badge/Difficulty-Easy-green)

## Problem

Given an integer array nums and an integer k, return the smallest positive multiple of k that is missing from nums.

A multiple of k is any positive integer divisible by k.

 
Example 1:


Input: nums = [8,2,3,4,6], k = 2

Output: 10

Explanation:

The multiples of k = 2 are 2, 4, 6, 8, 10, 12... and the smallest multiple missing from nums is 10.


Example 2:


Input: nums = [1,4,7,10,15], k = 5

Output: 5

Explanation:

The multiples of k = 5 are 5, 10, 15, 20... and the smallest multiple missing from nums is 5.


 
Constraints:


	1 <= nums.length <= 100
	1 <= nums[i] <= 100
	1 <= k <= 100

## Solution

**Language:** C#  
**Runtime:** 4 ms (beats 74.19%)  
**Memory:** 44.3 MB (beats 45.16%)  
**Submitted:** 2026-08-25T05:22:52.122Z  

```cs
public class Solution
{
    public int MissingMultiple(int[] nums, int k)
    {
        HashSet<int> set = new HashSet<int>(nums);

        int multiple = k;

        while (set.Contains(multiple))
        {
            multiple += k;
        }

        return multiple;
    }
}
```

---

[View on LeetCode](https://leetcode.com/problems/smallest-missing-multiple-of-k/)