class Solution {
  bool predictTheWinner(List<int> nums) {
    int n = nums.length;

    List<List<int?>> dp =
        List.generate(n, (_) => List.filled(n, null));

    int dfs(int i, int j) {
      if (i == j) return nums[i];

      if (dp[i][j] != null) return dp[i][j]!;

      int takeLeft = nums[i] - dfs(i + 1, j);
      int takeRight = nums[j] - dfs(i, j - 1);

      dp[i][j] = takeLeft > takeRight ? takeLeft : takeRight;
      return dp[i][j]!;
    }

    return dfs(0, n - 1) >= 0;
  }
}