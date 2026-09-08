class Solution {
  int countCommas(int n) {
    int ans = 0;

    for (int i = 1000; i <= n; i++) {
      ans += (i.toString().length - 1) ~/ 3;
    }

    return ans;
  }
}