class Solution {
  int maxCoins(List<int> nums) {
    int n = nums.length;

    // Add virtual balloons with value 1
    List<int> arr = [1, ...nums, 1];

    // dp[left][right] =
    // maximum coins from balloons between left and right
    List<List<int>> dp = List.generate(
      n + 2,
      (_) => List.filled(n + 2, 0),
    );

    // length = interval length
    for (int length = 2; length < n + 2; length++) {
      for (int left = 0; left + length < n + 2; left++) {
        int right = left + length;

        for (int k = left + 1; k < right; k++) {
          int coins =
              dp[left][k] +
              dp[k][right] +
              arr[left] * arr[k] * arr[right];

          if (coins > dp[left][right]) {
            dp[left][right] = coins;
          }
        }
      }
    }

    return dp[0][n + 1];
  }
}