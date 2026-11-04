# Minimum Operations to Make Elements Within K Subarrays Equal

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

You are given an integer array `nums` and two integers, `x` and `k`. You can perform the following operation any number of times (**including zero**):

- Increase or decrease any element of nums by 1.

Return the **minimum** number of operations needed to have **at least** `k` *non-overlapping subarrays* of size **exactly** `x` in `nums`, where all elements within each subarray are equal.

 

**Example 1:**

**Input:** nums = [5,-2,1,3,7,3,6,4,-1], x = 3, k = 2

**Output:** 8

**Explanation:**

- Use 3 operations to add 3 to nums[1] and use 2 operations to subtract 2 from nums[3]. The resulting array is [5, 1, 1, 1, 7, 3, 6, 4, -1].
- Use 1 operation to add 1 to nums[5] and use 2 operations to subtract 2 from nums[6]. The resulting array is [5, 1, 1, 1, 7, 4, 4, 4, -1].
- Now, all elements within each subarray [1, 1, 1] (from indices 1 to 3) and [4, 4, 4] (from indices 5 to 7) are equal. Since 8 total operations were used, 8 is the output.

**Example 2:**

**Input:** nums = [9,-2,-2,-2,1,5], x = 2, k = 2

**Output:** 3

**Explanation:**

- Use 3 operations to subtract 3 from nums[4]. The resulting array is [9, -2, -2, -2, -2, 5].
- Now, all elements within each subarray [-2, -2] (from indices 1 to 2) and [-2, -2] (from indices 3 to 4) are equal. Since 3 operations were used, 3 is the output.

 

**Constraints:**

- 2 <= nums.length <= 105
- -106 <= nums[i] <= 106
- 2 <= x <= nums.length
- 1 <= k <= 15
- 2 <= k * x <= nums.length

## Solution

**Language:** dart  
**Runtime:** 1457 ms (beats 100.00%)  
**Memory:** 291.6 MB (beats 100.00%)  
**Submitted:** 2026-11-04T06:42:02.204Z  

```dart
import 'dart:collection';

class Solution {
  int minOperations(List<int> nums, int x, int k) {
    final int n = nums.length;
    final int m = n - x + 1;
    final List<int> cost = List.filled(m, 0);

    final lo = SplayTreeMap<int, int>(); // smaller half (max = median)
    final hi = SplayTreeMap<int, int>(); // larger half
    int loSize = 0, hiSize = 0, loSum = 0, hiSum = 0;

    void inc(SplayTreeMap<int, int> mp, int v) => mp[v] = (mp[v] ?? 0) + 1;
    void dec(SplayTreeMap<int, int> mp, int v) {
      final c = mp[v]!;
      if (c == 1) {
        mp.remove(v);
      } else {
        mp[v] = c - 1;
      }
    }

    void rebalance() {
      while (loSize > hiSize + 1) {
        final v = lo.lastKey()!;
        dec(lo, v); loSize--; loSum -= v;
        inc(hi, v); hiSize++; hiSum += v;
      }
      while (hiSize > loSize) {
        final v = hi.firstKey()!;
        dec(hi, v); hiSize--; hiSum -= v;
        inc(lo, v); loSize++; loSum += v;
      }
    }

    void add(int v) {
      if (loSize == 0 || v <= lo.lastKey()!) {
        inc(lo, v); loSize++; loSum += v;
      } else {
        inc(hi, v); hiSize++; hiSum += v;
      }
      rebalance();
    }

    void remove(int v) {
      if (lo.containsKey(v)) {
        dec(lo, v); loSize--; loSum -= v;
      } else {
        dec(hi, v); hiSize--; hiSum -= v;
      }
      rebalance();
    }

    // Step 1: cost of making each window of size x equal (to its median)
    for (int i = 0; i < n; i++) {
      add(nums[i]);
      if (i >= x) remove(nums[i - x]);
      if (i >= x - 1) {
        final med = lo.lastKey()!;
        cost[i - x + 1] =
            med * loSize - loSum + hiSum - med * hiSize;
      }
    }

    // Step 2: DP over number of chosen subarrays
    const int INF = 1 << 60;
    List<int> prev = List.filled(n + 1, 0); // j = 0 -> cost 0
    for (int j = 1; j <= k; j++) {
      final cur = List.filled(n + 1, INF);
      for (int i = j * x; i <= n; i++) {
        int best = cur[i - 1];
        final p = prev[i - x];
        if (p < INF) {
          final take = p + cost[i - x];
          if (take < best) best = take;
        }
        cur[i] = best;
      }
      prev = cur;
    }
    return prev[n];
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/minimum-operations-to-make-elements-within-k-subarrays-equal/)