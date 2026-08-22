# Count of Smaller Numbers After Self

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

Given an integer array nums, return an integer array counts where counts[i] is the number of smaller elements to the right of nums[i].

 
Example 1:

Input: nums = [5,2,6,1]
Output: [2,1,1,0]
Explanation:
To the right of 5 there are 2 smaller elements (2 and 1).
To the right of 2 there is only 1 smaller element (1).
To the right of 6 there is 1 smaller element (1).
To the right of 1 there is 0 smaller element.


Example 2:

Input: nums = [-1]
Output: [0]


Example 3:

Input: nums = [-1,-1]
Output: [0,0]


 
Constraints:


	1 <= nums.length <= 105
	-104 <= nums[i] <= 104

## Solution

**Language:** dart  
**Runtime:** 83 ms (beats 100.00%)  
**Memory:** 187.5 MB (beats 100.00%)  
**Submitted:** 2026-08-22T15:59:54.424Z  

```dart
class Solution {
  List<int> countSmaller(List<int> nums) {
    int n = nums.length;

    List<int> result = List.filled(n, 0);

    // Original indices
    List<int> indexes = List.generate(n, (i) => i);

    List<int> temp = List.filled(n, 0);

    void mergeSort(int left, int right) {
      if (left >= right) return;

      int mid = left + (right - left) ~/ 2;

      mergeSort(left, mid);
      mergeSort(mid + 1, right);

      int i = left;
      int j = mid + 1;
      int k = left;
      int rightSmaller = 0;

      while (i <= mid && j <= right) {
        if (nums[indexes[j]] < nums[indexes[i]]) {
          temp[k++] = indexes[j++];
          rightSmaller++;
        } else {
          result[indexes[i]] += rightSmaller;
          temp[k++] = indexes[i++];
        }
      }

      while (i <= mid) {
        result[indexes[i]] += rightSmaller;
        temp[k++] = indexes[i++];
      }

      while (j <= right) {
        temp[k++] = indexes[j++];
      }

      for (int x = left; x <= right; x++) {
        indexes[x] = temp[x];
      }
    }

    if (n > 0) {
      mergeSort(0, n - 1);
    }

    return result;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/count-of-smaller-numbers-after-self/)