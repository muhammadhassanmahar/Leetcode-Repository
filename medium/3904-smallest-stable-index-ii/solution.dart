class Solution {
  int firstStableIndex(List<int> nums, int k) {
    int n = nums.length;

    // suffixMin[i] = nums[i...n-1] ka minimum
    List<int> suffixMin = List.filled(n, 0);

    suffixMin[n - 1] = nums[n - 1];

    for (int i = n - 2; i >= 0; i--) {
      suffixMin[i] = min(nums[i], suffixMin[i + 1]);
    }

    // Prefix maximum maintain karo
    int prefixMax = 0;

    for (int i = 0; i < n; i++) {
      prefixMax = max(prefixMax, nums[i]);

      if (prefixMax - suffixMin[i] <= k) {
        return i;
      }
    }

    return -1;
  }
}