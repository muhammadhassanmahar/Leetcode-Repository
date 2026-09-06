class Solution {
  int countRangeSum(List<int> nums, int lower, int upper) {
    List<int> prefix = [0];

    for (int num in nums) {
      prefix.add(prefix.last + num);
    }

    return _mergeSort(prefix, lower, upper, 0, prefix.length - 1);
  }

  int _mergeSort(
      List<int> arr, int lower, int upper, int left, int right) {
    if (left >= right) return 0;

    int mid = (left + right) ~/ 2;
    int count = 0;

    count += _mergeSort(arr, lower, upper, left, mid);
    count += _mergeSort(arr, lower, upper, mid + 1, right);

    int low = mid + 1;
    int high = mid + 1;

    for (int i = left; i <= mid; i++) {
      while (low <= right && arr[low] - arr[i] < lower) {
        low++;
      }

      while (high <= right && arr[high] - arr[i] <= upper) {
        high++;
      }

      count += high - low;
    }

    List<int> temp = [];
    int i = left;
    int j = mid + 1;

    while (i <= mid && j <= right) {
      if (arr[i] <= arr[j]) {
        temp.add(arr[i++]);
      } else {
        temp.add(arr[j++]);
      }
    }

    while (i <= mid) temp.add(arr[i++]);
    while (j <= right) temp.add(arr[j++]);

    for (int k = 0; k < temp.length; k++) {
      arr[left + k] = temp[k];
    }

    return count;
  }
}