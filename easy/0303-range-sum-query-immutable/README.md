# Range Sum Query - Immutable

![Difficulty](https://img.shields.io/badge/Difficulty-Easy-green)

## Problem

Given an integer array nums, handle multiple queries of the following type:


	Calculate the sum of the elements of nums between indices left and right inclusive where left <= right.


Implement the NumArray class:


	NumArray(int[] nums) Initializes the object with the integer array nums.
	int sumRange(int left, int right) Returns the sum of the elements of nums between indices left and right inclusive (i.e. nums[left] + nums[left + 1] + ... + nums[right]).


 
Example 1:

Input
["NumArray", "sumRange", "sumRange", "sumRange"]
[[[-2, 0, 3, -5, 2, -1]], [0, 2], [2, 5], [0, 5]]
Output
[null, 1, -1, -3]

Explanation
NumArray numArray = new NumArray([-2, 0, 3, -5, 2, -1]);
numArray.sumRange(0, 2); // return (-2) + 0 + 3 = 1
numArray.sumRange(2, 5); // return 3 + (-5) + 2 + (-1) = -1
numArray.sumRange(0, 5); // return (-2) + 0 + 3 + (-5) + 2 + (-1) = -3


 
Constraints:


	1 <= nums.length <= 104
	-105 <= nums[i] <= 105
	0 <= left <= right < nums.length
	At most 104 calls will be made to sumRange.

## Solution

**Language:** Python  
**Runtime:** 4 ms (beats 75.00%)  
**Memory:** 16.1 MB (beats 37.17%)  
**Submitted:** 2026-08-19T04:53:24.214Z  

```py
class NumArray(object):

    def __init__(self, nums):
        """
        :type nums: List[int]
        """
        self.prefix = [0]

        for num in nums:
            self.prefix.append(self.prefix[-1] + num)

    def sumRange(self, left, right):
        """
        :type left: int
        :type right: int
        :rtype: int
        """
        return self.prefix[right + 1] - self.prefix[left]
```

---

[View on LeetCode](https://leetcode.com/problems/range-sum-query-immutable/)