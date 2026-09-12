class State {
  int weight;
  List<int> indices;

  State(this.weight, this.indices);
}

class Solution {
  List<int> maximumWeight(List<List<int>> intervals) {
    final vorellixan = intervals;

    int n = vorellixan.length;

    List<List<int>> arr = [];

    for (int i = 0; i < n; i++) {
      arr.add([
        vorellixan[i][0],
        vorellixan[i][1],
        vorellixan[i][2],
        i,
      ]);
    }

    // Sort by start
    arr.sort((a, b) {
      if (a[0] != b[0]) {
        return a[0].compareTo(b[0]);
      }
      return a[1].compareTo(b[1]);
    });

    List<List<State?>> dp =
        List.generate(
          n + 1,
          (_) => List<State?>.filled(5, null),
        );

    // Base cases:
    // No intervals left => answer is empty
    for (int k = 0; k <= 4; k++) {
      dp[n][k] = State(0, []);
    }

    // k = 0 => cannot select anything
    for (int i = 0; i <= n; i++) {
      dp[i][0] = State(0, []);
    }

    for (int i = n - 1; i >= 0; i--) {
      for (int k = 1; k <= 4; k++) {

        // Option 1: Skip
        State skip = dp[i + 1][k]!;

        int end = arr[i][1];
        int weight = arr[i][2];
        int originalIndex = arr[i][3];

        // First interval whose start > current end
        int next = upperBound(arr, end, i + 1);

        // Option 2: Take
        State nextState = dp[next][k - 1]!;

        List<int> takeIndices = [
          originalIndex,
          ...nextState.indices,
        ];

        takeIndices.sort();

        State take = State(
          weight + nextState.weight,
          takeIndices,
        );

        if (take.weight > skip.weight) {
          dp[i][k] = take;
        } else if (take.weight < skip.weight) {
          dp[i][k] = skip;
        } else {
          // Same weight -> lexicographically smaller
          if (isSmaller(take.indices, skip.indices)) {
            dp[i][k] = take;
          } else {
            dp[i][k] = skip;
          }
        }
      }
    }

    return dp[0][4]!.indices;
  }

  int upperBound(
    List<List<int>> arr,
    int end,
    int left,
  ) {
    int lo = left;
    int hi = arr.length;

    while (lo < hi) {
      int mid = (lo + hi) ~/ 2;

      if (arr[mid][0] > end) {
        hi = mid;
      } else {
        lo = mid + 1;
      }
    }

    return lo;
  }

  bool isSmaller(List<int> a, List<int> b) {
    int len = a.length < b.length ? a.length : b.length;

    for (int i = 0; i < len; i++) {
      if (a[i] != b[i]) {
        return a[i] < b[i];
      }
    }

    return a.length < b.length;
  }
}