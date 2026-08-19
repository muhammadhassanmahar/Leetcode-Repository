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