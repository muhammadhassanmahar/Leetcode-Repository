class Solution {
  int maxPalindromes(String s, int k) {
    int n = s.length;

    // isPal[i][j] = s[i..j] palindrome hai ya nahi
    List<List<bool>> isPal = List.generate(
      n,
      (_) => List<bool>.filled(n, false),
    );

    // Palindrome table
    for (int i = n - 1; i >= 0; i--) {
      for (int j = i; j < n; j++) {
        if (s[i] == s[j] &&
            (j - i <= 2 || isPal[i + 1][j - 1])) {
          isPal[i][j] = true;
        }
      }
    }

    // dp[i] = first i characters se maximum palindromes
    List<int> dp = List.filled(n + 1, 0);

    for (int end = 1; end <= n; end++) {
      // Current character ko skip karo
      dp[end] = dp[end - 1];

      // Har possible starting position
      for (int start = 0; start <= end - k; start++) {
        if (isPal[start][end - 1]) {
          dp[end] = dp[end] > dp[start] + 1
              ? dp[end]
              : dp[start] + 1;
        }
      }
    }

    return dp[n];
  }
}