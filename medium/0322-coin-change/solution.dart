import 'dart:math';

class Solution {
  int coinChange(List<int> coins, int amount) {
    List<int> dp = List.filled(amount + 1, amount + 1);
    dp[0] = 0;

    for (int i = 1; i <= amount; i++) {
      for (int coin in coins) {
        if (coin <= i) {
          dp[i] = min(dp[i], dp[i - coin] + 1);
        }
      }
    }

    return dp[amount] > amount ? -1 : dp[amount];
  }
}