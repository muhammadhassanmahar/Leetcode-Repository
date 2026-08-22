class Solution {
  int nthSuperUglyNumber(int n, List<int> primes) {
    List<int> ugly = List.filled(n, 0);
    ugly[0] = 1;

    int k = primes.length;

    // Har prime ka pointer
    List<int> index = List.filled(k, 0);

    // Har prime ka next candidate
    List<int> next = List.from(primes);

    for (int i = 1; i < n; i++) {
      // Smallest candidate
      int minValue = next[0];

      for (int j = 1; j < k; j++) {
        if (next[j] < minValue) {
          minValue = next[j];
        }
      }

      ugly[i] = minValue;

      // Jis prime ka candidate min tha,
      // uska pointer aage move karo
      for (int j = 0; j < k; j++) {
        if (next[j] == minValue) {
          index[j]++;
          next[j] = ugly[index[j]] * primes[j];
        }
      }
    }

    return ugly[n - 1];
  }
}