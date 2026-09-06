class Solution {
  void wiggleSort(List<int> nums) {
    nums.sort();

    List<int> temp = List.from(nums);
    int n = nums.length;
    int mid = (n - 1) ~/ 2;
    int end = n - 1;

    for (int i = 0; i < n; i++) {
      if (i.isEven) {
        nums[i] = temp[mid--];
      } else {
        nums[i] = temp[end--];
      }
    }
  }
}