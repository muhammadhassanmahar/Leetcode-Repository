class Solution {
  int distinctSubseqII(String s) {
    const int MOD = 1000000007;

    List<int> dp = List.filled(26, 0);

    for (int i = 0; i < s.length; i++) {
      int index = s.codeUnitAt(i) - 97;

      int total = 0;
      for (int j = 0; j < 26; j++) {
        total = (total + dp[j]) % MOD;
      }

      dp[index] = (total + 1) % MOD;
    }

    int answer = 0;

    for (int value in dp) {
      answer = (answer + value) % MOD;
    }

    return answer;
  }
}