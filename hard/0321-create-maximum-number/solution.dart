class Solution {
  List<int> maxNumber(List<int> nums1, List<int> nums2, int k) {
    List<int> best = [];

    int start = k - nums2.length;
    if (start < 0) start = 0;

    int end = k;
    if (end > nums1.length) end = nums1.length;

    for (int take1 = start; take1 <= end; take1++) {
      int take2 = k - take1;

      List<int> part1 = getMax(nums1, take1);
      List<int> part2 = getMax(nums2, take2);

      List<int> candidate = merge(part1, part2);

      if (greater(candidate, 0, best, 0)) {
        best = candidate;
      }
    }

    return best;
  }

  // Array se exactly k digits ki maximum subsequence
  List<int> getMax(List<int> nums, int k) {
    if (k == 0) return [];

    List<int> stack = [];

    int remove = nums.length - k;

    for (int num in nums) {
      while (stack.isNotEmpty &&
          remove > 0 &&
          stack.last < num) {
        stack.removeLast();
        remove--;
      }

      stack.add(num);
    }

    return stack.sublist(0, k);
  }

  // Do maximum subsequences ko merge karke maximum sequence
  List<int> merge(List<int> a, List<int> b) {
    List<int> result = [];

    int i = 0;
    int j = 0;

    while (i < a.length || j < b.length) {
      if (greater(a, i, b, j)) {
        result.add(a[i]);
        i++;
      } else {
        result.add(b[j]);
        j++;
      }
    }

    return result;
  }

  // a[i...] > b[j...] ?
  bool greater(List<int> a, int i, List<int> b, int j) {
    while (i < a.length && j < b.length) {
      if (a[i] != b[j]) {
        return a[i] > b[j];
      }

      i++;
      j++;
    }

    return i != a.length;
  }
}