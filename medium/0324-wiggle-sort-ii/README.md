# Wiggle Sort II

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Given an integer array nums, reorder it such that nums[0] < nums[1] > nums[2] < nums[3]....

You may assume the input array always has a valid answer.

 
Example 1:

Input: nums = [1,5,1,1,6,4]
Output: [1,6,1,5,1,4]
Explanation: [1,4,1,5,1,6] is also accepted.


Example 2:

Input: nums = [1,3,2,2,3,1]
Output: [2,3,1,3,1,2]


 
Constraints:


	1 <= nums.length <= 5 * 104
	0 <= nums[i] <= 5000
	It is guaranteed that there will be an answer for the given input nums.


 
Follow Up: Can you do it in O(n) time and/or in-place with O(1) extra space?

## Solution

**Language:** dart  
**Runtime:** 13 ms  
**Memory:** 154.2 MB (beats 100.00%)  
**Submitted:** 2026-09-06T14:57:31.504Z  

```dart
class Solution {
  void wiggleSort(List<int> nums) {
    nums.sort();

    List<int> temp = List.from(nums);
    int n = nums.length;
    int mid = (n - 1) ~/ 2;
    int end = n - 1;

    for (int i = 0; i < n; i++) {
      if (i.isEven) {
        nums[i] = temp[mid--];
      } else {
        nums[i] = temp[end--];
      }
    }
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/wiggle-sort-ii/)