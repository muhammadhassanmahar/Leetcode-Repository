# Maximum Score of Non-overlapping Intervals

![Difficulty](https://img.shields.io/badge/Difficulty-Hard-red)

## Problem

You are given a 2D integer array intervals, where intervals[i] = [li, ri, weighti]. Interval i starts at position li and ends at ri, and has a weight of weighti. You can choose up to 4 non-overlapping intervals. The score of the chosen intervals is defined as the total sum of their weights.

Return the lexicographically smallest array of at most 4 indices from intervals with maximum score, representing your choice of non-overlapping intervals.

Two intervals are said to be non-overlapping if they do not share any points. In particular, intervals sharing a left or right boundary are considered overlapping.

 
Example 1:


Input: intervals = [[1,3,2],[4,5,2],[1,5,5],[6,9,3],[6,7,1],[8,9,1]]

Output: [2,3]

Explanation:

You can choose the intervals with indices 2, and 3 with respective weights of 5, and 3.


Example 2:


Input: intervals = [[5,8,1],[6,7,7],[4,7,3],[9,10,6],[7,8,2],[11,14,3],[3,5,5]]

Output: [1,3,5,6]

Explanation:

You can choose the intervals with indices 1, 3, 5, and 6 with respective weights of 7, 6, 3, and 5.


 
Constraints:


	1 <= intevals.length <= 5 * 104
	intervals[i].length == 3
	intervals[i] = [li, ri, weighti]
	1 <= li <= ri <= 109
	1 <= weighti <= 109

## Solution

**Language:** dart  
**Runtime:** 646 ms (beats 100.00%)  
**Memory:** 286.9 MB (beats 100.00%)  
**Submitted:** 2026-09-12T04:42:31.936Z  

```dart
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
```

---

[View on LeetCode](https://leetcode.com/problems/maximum-score-of-non-overlapping-intervals/)