class Solution {
  List<int> countSmaller(List<int> nums) {
    int n = nums.length;

    List<int> result = List.filled(n, 0);

    // Original indices
    List<int> indexes = List.generate(n, (i) => i);

    List<int> temp = List.filled(n, 0);

    void mergeSort(int left, int right) {
      if (left >= right) return;

      int mid = left + (right - left) ~/ 2;

      mergeSort(left, mid);
      mergeSort(mid + 1, right);

      int i = left;
      int j = mid + 1;
      int k = left;
      int rightSmaller = 0;

      while (i <= mid && j <= right) {
        if (nums[indexes[j]] < nums[indexes[i]]) {
          temp[k++] = indexes[j++];
          rightSmaller++;
        } else {
          result[indexes[i]] += rightSmaller;
          temp[k++] = indexes[i++];
        }
      }

      while (i <= mid) {
        result[indexes[i]] += rightSmaller;
        temp[k++] = indexes[i++];
      }

      while (j <= right) {
        temp[k++] = indexes[j++];
      }

      for (int x = left; x <= right; x++) {
        indexes[x] = temp[x];
      }
    }

    if (n > 0) {
      mergeSort(0, n - 1);
    }

    return result;
  }
}