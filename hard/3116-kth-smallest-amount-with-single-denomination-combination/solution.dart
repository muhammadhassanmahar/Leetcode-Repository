class Solution {
  int findKthSmallest(List<int> coins, int k) {
    int left = 1;
    int right = coins.reduce((a, b) => a < b ? a : b) * k;

    while (left < right) {
      int mid = left + (right - left) ~/ 2;

      if (_count(mid, coins) >= k) {
        right = mid;
      } else {
        left = mid + 1;
      }
    }

    return left;
  }

  int _count(int x, List<int> coins) {
    int n = coins.length;
    int total = 0;

    for (int mask = 1; mask < (1 << n); mask++) {
      int lcm = 1;
      bool valid = true;
      int bits = 0;

      for (int i = 0; i < n; i++) {
        if ((mask & (1 << i)) != 0) {
          bits++;

          int g = _gcd(lcm, coins[i]);
          lcm = lcm ~/ g * coins[i];

          if (lcm > x) {
            valid = false;
            break;
          }
        }
      }

      if (valid) {
        int count = x ~/ lcm;

        if (bits.isOdd) {
          total += count;
        } else {
          total -= count;
        }
      }
    }

    return total;
  }

  int _gcd(int a, int b) {
    while (b != 0) {
      int temp = a % b;
      a = b;
      b = temp;
    }
    return a;
  }
}