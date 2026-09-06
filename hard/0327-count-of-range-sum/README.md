# Count of Range Sum

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

Given an integer array nums and two integers lower and upper, return the number of range sums that lie in [lower, upper] inclusive.

Range sum S(i, j) is defined as the sum of the elements in nums between indices i and j inclusive, where i <= j.

 
Example 1:

Input: nums = [-2,5,-1], lower = -2, upper = 2
Output: 3
Explanation: The three ranges are: [0,0], [2,2], and [0,2] and their respective sums are: -2, -1, 2.


Example 2:

Input: nums = [0], lower = 0, upper = 0
Output: 1


 
Constraints:


	1 <= nums.length <= 105
	-231 <= nums[i] <= 231 - 1
	-105 <= lower <= upper <= 105
	The answer is guaranteed to fit in a 32-bit integer.

## Solution

**Language:** dart  
**Runtime:** 125 ms (beats 100.00%)  
**Memory:** 210.6 MB  
**Submitted:** 2026-09-06T14:58:28.765Z  

```dart
class Solution {
  int countRangeSum(List<int> nums, int lower, int upper) {
    List<int> prefix = [0];

    for (int num in nums) {
      prefix.add(prefix.last + num);
    }

    return _mergeSort(prefix, lower, upper, 0, prefix.length - 1);
  }

  int _mergeSort(
      List<int> arr, int lower, int upper, int left, int right) {
    if (left >= right) return 0;

    int mid = (left + right) ~/ 2;
    int count = 0;

    count += _mergeSort(arr, lower, upper, left, mid);
    count += _mergeSort(arr, lower, upper, mid + 1, right);

    int low = mid + 1;
    int high = mid + 1;

    for (int i = left; i <= mid; i++) {
      while (low <= right && arr[low] - arr[i] < lower) {
        low++;
      }

      while (high <= right && arr[high] - arr[i] <= upper) {
        high++;
      }

      count += high - low;
    }

    List<int> temp = [];
    int i = left;
    int j = mid + 1;

    while (i <= mid && j <= right) {
      if (arr[i] <= arr[j]) {
        temp.add(arr[i++]);
      } else {
        temp.add(arr[j++]);
      }
    }

    while (i <= mid) temp.add(arr[i++]);
    while (j <= right) temp.add(arr[j++]);

    for (int k = 0; k < temp.length; k++) {
      arr[left + k] = temp[k];
    }

    return count;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/count-of-range-sum/)