# Range Sum Query - Mutable

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Given an integer array nums, handle multiple queries of the following types:


	Update the value of an element in nums.
	Calculate the sum of the elements of nums between indices left and right inclusive where left <= right.


Implement the NumArray class:


	NumArray(int[] nums) Initializes the object with the integer array nums.
	void update(int index, int val) Updates the value of nums[index] to be val.
	int sumRange(int left, int right) Returns the sum of the elements of nums between indices left and right inclusive (i.e. nums[left] + nums[left + 1] + ... + nums[right]).


 
Example 1:

Input
["NumArray", "sumRange", "update", "sumRange"]
[[[1, 3, 5]], [0, 2], [1, 2], [0, 2]]
Output
[null, 9, null, 8]

Explanation
NumArray numArray = new NumArray([1, 3, 5]);
numArray.sumRange(0, 2); // return 1 + 3 + 5 = 9
numArray.update(1, 2);   // nums = [1, 2, 5]
numArray.sumRange(0, 2); // return 1 + 2 + 5 = 8


 
Constraints:


	1 <= nums.length <= 3 * 104
	-100 <= nums[i] <= 100
	0 <= index < nums.length
	-100 <= val <= 100
	0 <= left <= right < nums.length
	At most 3 * 104 calls will be made to update and sumRange.

## Solution

**Language:** dart  
**Runtime:** 28 ms (beats 50.00%)  
**Memory:** 232.6 MB (beats 50.00%)  
**Submitted:** 2026-08-21T04:40:54.310Z  

```dart
class NumArray {
  late List<int> nums;
  late List<int> tree;

  NumArray(List<int> nums) {
    this.nums = List.from(nums);
    tree = List.filled(nums.length + 1, 0);

    // Build Fenwick Tree
    for (int i = 0; i < nums.length; i++) {
      _add(i + 1, nums[i]);
    }
  }

  void update(int index, int val) {
    int diff = val - nums[index];

    nums[index] = val;

    _add(index + 1, diff);
  }

  void _add(int index, int value) {
    while (index < tree.length) {
      tree[index] += value;
      index += index & -index;
    }
  }

  int _prefixSum(int index) {
    int sum = 0;

    while (index > 0) {
      sum += tree[index];
      index -= index & -index;
    }

    return sum;
  }

  int sumRange(int left, int right) {
    return _prefixSum(right + 1) - _prefixSum(left);
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/range-sum-query-mutable/)