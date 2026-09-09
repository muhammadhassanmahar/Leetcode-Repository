class Solution {
  int countCommas(int n) {
    int ans = 0;
    int x = 1000;

    while (x <= n) {
      ans += n - x + 1;

      if (x > n ~/ 1000) {
        break;
      }

      x *= 1000;
    }

    return ans;
  }
}