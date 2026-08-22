# Create Maximum Number

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

You are given two integer arrays nums1 and nums2 of lengths m and n respectively. nums1 and nums2 represent the digits of two numbers. You are also given an integer k.

Create the maximum number of length k <= m + n from digits of the two numbers. The relative order of the digits from the same array must be preserved.

Return an array of the k digits representing the answer.

 
Example 1:

Input: nums1 = [3,4,6,5], nums2 = [9,1,2,5,8,3], k = 5
Output: [9,8,6,5,3]


Example 2:

Input: nums1 = [6,7], nums2 = [6,0,4], k = 5
Output: [6,7,6,0,4]


Example 3:

Input: nums1 = [3,9], nums2 = [8,9], k = 3
Output: [9,8,9]


 
Constraints:


	m == nums1.length
	n == nums2.length
	1 <= m, n <= 500
	0 <= nums1[i], nums2[i] <= 9
	1 <= k <= m + n
	nums1 and nums2 do not have leading zeros.

## Solution

**Language:** dart  
**Runtime:** 23 ms (beats 100.00%)  
**Memory:** 149.4 MB  
**Submitted:** 2026-08-22T16:04:42.783Z  

```dart
class Solution {
  List<int> maxNumber(List<int> nums1, List<int> nums2, int k) {
    List<int> best = [];

    int start = k - nums2.length;
    if (start < 0) start = 0;

    int end = k;
    if (end > nums1.length) end = nums1.length;

    for (int take1 = start; take1 <= end; take1++) {
      int take2 = k - take1;

      List<int> part1 = getMax(nums1, take1);
      List<int> part2 = getMax(nums2, take2);

      List<int> candidate = merge(part1, part2);

      if (greater(candidate, 0, best, 0)) {
        best = candidate;
      }
    }

    return best;
  }

  // Array se exactly k digits ki maximum subsequence
  List<int> getMax(List<int> nums, int k) {
    if (k == 0) return [];

    List<int> stack = [];

    int remove = nums.length - k;

    for (int num in nums) {
      while (stack.isNotEmpty &&
          remove > 0 &&
          stack.last < num) {
        stack.removeLast();
        remove--;
      }

      stack.add(num);
    }

    return stack.sublist(0, k);
  }

  // Do maximum subsequences ko merge karke maximum sequence
  List<int> merge(List<int> a, List<int> b) {
    List<int> result = [];

    int i = 0;
    int j = 0;

    while (i < a.length || j < b.length) {
      if (greater(a, i, b, j)) {
        result.add(a[i]);
        i++;
      } else {
        result.add(b[j]);
        j++;
      }
    }

    return result;
  }

  // a[i...] > b[j...] ?
  bool greater(List<int> a, int i, List<int> b, int j) {
    while (i < a.length && j < b.length) {
      if (a[i] != b[j]) {
        return a[i] > b[j];
      }

      i++;
      j++;
    }

    return i != a.length;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/create-maximum-number/)