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
**Runtime:** 0 ms  
**Memory:** 12.2 MB  
**Submitted:** 2026-08-19T04:53:13.383Z  

```py
import heapq

class MedianFinder(object):

    def __init__(self):
        self.small = []  # max heap (negative values)
        self.large = []  # min heap

    def addNum(self, num):
        # Pehle small mein add karo
        heapq.heappush(self.small, -num)

        # Ensure small ka maximum <= large ka minimum
        if self.small and self.large and (-self.small[0] > self.large[0]):
            val = -heapq.heappop(self.small)
            heapq.heappush(self.large, val)

        # Balance heaps
        if len(self.small) > len(self.large) + 1:
            val = -heapq.heappop(self.small)
            heapq.heappush(self.large, val)

        elif len(self.large) > len(self.small) + 1:
            val = heapq.heappop(self.large)
            heapq.heappush(self.small, -val)

    def findMedian(self):
        if len(self.small) > len(self.large):
            return float(-self.small[0])

        elif len(self.large) > len(self.small):
            return float(self.large[0])

        return (-self.small[0] + self.large[0]) / 2.0
```

---

[View on LeetCode](https://leetcode.com/problems/range-sum-query-immutable/)