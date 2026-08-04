class Solution {
  List<int> findMissingElements(List<int> nums) {
    int minVal = nums.reduce((a, b) => a < b ? a : b);
    int maxVal = nums.reduce((a, b) => a > b ? a : b);

    Set<int> set = nums.toSet();
    List<int> ans = [];

    for (int i = minVal; i <= maxVal; i++) {
      if (!set.contains(i)) {
        ans.add(i);
      }
    }

    return ans;
  }
}