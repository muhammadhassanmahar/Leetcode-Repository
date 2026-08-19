# Range Sum Query 2D - Immutable

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Given a 2D matrix matrix, handle multiple queries of the following type:


	Calculate the sum of the elements of matrix inside the rectangle defined by its upper left corner (row1, col1) and lower right corner (row2, col2).


Implement the NumMatrix class:


	NumMatrix(int[][] matrix) Initializes the object with the integer matrix matrix.
	int sumRegion(int row1, int col1, int row2, int col2) Returns the sum of the elements of matrix inside the rectangle defined by its upper left corner (row1, col1) and lower right corner (row2, col2).


You must design an algorithm where sumRegion works on O(1) time complexity.

 
Example 1:

Input
["NumMatrix", "sumRegion", "sumRegion", "sumRegion"]
[[[[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]], [2, 1, 4, 3], [1, 1, 2, 2], [1, 2, 2, 4]]
Output
[null, 8, 11, 12]

Explanation
NumMatrix numMatrix = new NumMatrix([[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]);
numMatrix.sumRegion(2, 1, 4, 3); // return 8 (i.e sum of the red rectangle)
numMatrix.sumRegion(1, 1, 2, 2); // return 11 (i.e sum of the green rectangle)
numMatrix.sumRegion(1, 2, 2, 4); // return 12 (i.e sum of the blue rectangle)


 
Constraints:


	m == matrix.length
	n == matrix[i].length
	1 <= m, n <= 200
	-104 <= matrix[i][j] <= 104
	0 <= row1 <= row2 < m
	0 <= col1 <= col2 < n
	At most 104 calls will be made to sumRegion.

## Solution

**Language:** dart  
**Runtime:** 14 ms (beats 100.00%)  
**Memory:** 195.8 MB (beats 100.00%)  
**Submitted:** 2026-08-19T04:54:51.611Z  

```dart
class NumMatrix {
  late List<List<int>> prefix;

  NumMatrix(List<List<int>> matrix) {
    int rows = matrix.length;
    int cols = matrix[0].length;

    // Extra row and column of 0
    prefix = List.generate(
      rows + 1,
      (_) => List.filled(cols + 1, 0),
    );

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        prefix[r + 1][c + 1] =
            matrix[r][c] +
            prefix[r][c + 1] +
            prefix[r + 1][c] -
            prefix[r][c];
      }
    }
  }

  int sumRegion(int row1, int col1, int row2, int col2) {
    return prefix[row2 + 1][col2 + 1]
        - prefix[row1][col2 + 1]
        - prefix[row2 + 1][col1]
        + prefix[row1][col1];
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/range-sum-query-2d-immutable/)