# Twisted Mirror Path Count

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Given an `m x n` binary grid `grid` where:

- grid[i][j] == 0 represents an empty cell, and
- grid[i][j] == 1 represents a mirror.

A robot starts at the top-left corner of the grid `(0, 0)` and wants to reach the bottom-right corner `(m - 1, n - 1)`. It can move only **right** or **down**. If the robot attempts to move into a mirror cell, it is **reflected** before entering that cell:

- If it tries to move right into a mirror, it is turned down and moved into the cell directly below the mirror.
- If it tries to move down into a mirror, it is turned right and moved into the cell directly to the right of the mirror.

If this reflection would cause the robot to move outside the `grid` boundaries, the path is considered invalid and should not be counted.

Return the number of unique valid paths from `(0, 0)` to `(m - 1, n - 1)`.

Since the answer may be very large, return it **modulo** `109 + 7`.

**Note**: If a reflection moves the robot into a mirror cell, the robot is immediately reflected again based on the direction it used to enter that mirror: if it entered while moving right, it will be turned down; if it entered while moving down, it will be turned right. This process will continue until either the last cell is reached, the robot moves out of bounds or the robot moves to a non-mirror cell.

 

**Example 1:**

**Input:** grid = [[0,1,0],[0,0,1],[1,0,0]]

**Output:** 5

**Explanation:**

Number	Full Path
1	(0, 0) → (0, 1) [M] → (1, 1) → (1, 2) [M] → (2, 2)
2	(0, 0) → (0, 1) [M] → (1, 1) → (2, 1) → (2, 2)
3	(0, 0) → (1, 0) → (1, 1) → (1, 2) [M] → (2, 2)
4	(0, 0) → (1, 0) → (1, 1) → (2, 1) → (2, 2)
5	(0, 0) → (1, 0) → (2, 0) [M] → (2, 1) → (2, 2)
- [M] indicates the robot attempted to enter a mirror cell and instead reflected.

**Example 2:**

**Input:** grid = [[0,0],[0,0]]

**Output:** 2

**Explanation:**

Number	Full Path
1	(0, 0) → (0, 1) → (1, 1)
2	(0, 0) → (1, 0) → (1, 1)

**Example 3:**

**Input:** grid = [[0,1,1],[1,1,0]]

**Output:** 1

**Explanation:**

Number	Full Path
1	(0, 0) → (0, 1) [M] → (1, 1) [M] → (1, 2)
`(0, 0) → (1, 0) [M] → (1, 1) [M] → (2, 1)` goes out of bounds, so it is invalid.

 

**Constraints:**

- m == grid.length
- n == grid[i].length
- 2 <= m, n <= 500
- grid[i][j] is either 0 or 1.
- grid[0][0] == grid[m - 1][n - 1] == 0

## Solution

**Language:** dart  
**Runtime:** 90 ms (beats 100.00%)  
**Memory:** 194.3 MB (beats 100.00%)  
**Submitted:** 2026-10-31T08:43:20.716Z  

```dart

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

```

---

[View on LeetCode](https://leetcode.com/problems/twisted-mirror-path-count/)