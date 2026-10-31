
class Solution {
  int uniquePaths(List<List<int>> grid) {
    const int mod = 1000000007;

    int m = grid.length;
    int n = grid[0].length;

    List<List<int>> dpR = List.generate(
      m, (_) => List.filled(n, 0),
    );

    List<List<int>> dpD = List.generate(
      m, (_) => List.filled(n, 0),
    );

    // Starting position
    dpR[0][0] = 1;

    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {

        if (i == 0 && j == 0) {
          if (j + 1 < n) {
            dpR[i][j + 1] =
                (dpR[i][j + 1] + 1) % mod;
          }

          if (i + 1 < m) {
            dpD[i + 1][j] =
                (dpD[i + 1][j] + 1) % mod;
          }

          continue;
        }

        int right = dpR[i][j];
        int down = dpD[i][j];

        if (grid[i][j] == 0) {
          // Empty cell
          int ways = (right + down) % mod;

          // Move right
          if (j + 1 < n) {
            dpR[i][j + 1] =
                (dpR[i][j + 1] + ways) % mod;
          }

          // Move down
          if (i + 1 < m) {
            dpD[i + 1][j] =
                (dpD[i + 1][j] + ways) % mod;
          }

        } else {
          // Mirror cell

          // Entered from left -> reflected down
          if (i + 1 < m) {
            dpD[i + 1][j] =
                (dpD[i + 1][j] + right) % mod;
          }

          // Entered from top -> reflected right
          if (j + 1 < n) {
            dpR[i][j + 1] =
                (dpR[i][j + 1] + down) % mod;
          }
        }
      }
    }

    return (dpR[m - 1][n - 1] +
            dpD[m - 1][n - 1]) % mod;
  }
}
