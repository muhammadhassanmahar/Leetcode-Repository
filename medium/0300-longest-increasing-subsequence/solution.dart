class Solution {
  int lengthOfLIS(List<int> nums) {
    int n = nums.length;

    List<int> dp = List.filled(n, 1);

    int answer = 1;

    for (int i = 1; i < n; i++) {
      for (int j = 0; j < i; j++) {
        if (nums[j] < nums[i]) {
          dp[i] = dp[i] > dp[j] + 1
              ? dp[i]
              : dp[j] + 1;
        }
      }

      answer = answer > dp[i] ? answer : dp[i];
    }

    return answer;
  }
}