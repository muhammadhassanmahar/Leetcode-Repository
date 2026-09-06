class Solution {
  int numDistinct(String s, String t) {
    if (t.length > s.length) return 0;

    List<int> dp = List.filled(t.length + 1, 0);
    dp[0] = 1;

    for (int i = 0; i < s.length; i++) {
      for (int j = t.length - 1; j >= 0; j--) {
        if (s[i] == t[j]) {
          dp[j + 1] += dp[j];
        }
      }
    }

    return dp[t.length];
  }
}