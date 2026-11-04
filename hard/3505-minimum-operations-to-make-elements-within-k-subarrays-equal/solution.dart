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