class Solution {
  int maxProfit(List<int> prices) {
    if (prices.isEmpty) return 0;

    int hold = -prices[0];
    int sold = 0;
    int cooldown = 0;

    for (int i = 1; i < prices.length; i++) {
      int prevHold = hold;
      int prevSold = sold;
      int prevCooldown = cooldown;

      // Stock hold kar rahe hain
      hold = prevHold > prevCooldown - prices[i]
          ? prevHold
          : prevCooldown - prices[i];

      // Aaj sell kiya
      sold = prevHold + prices[i];

      // Aaj kuch nahi kiya / cooldown
      cooldown = prevCooldown > prevSold
          ? prevCooldown
          : prevSold;
    }

    return sold > cooldown ? sold : cooldown;
  }
}