class Solution {
  int minMoves(List<int> nums) {
    int maxNum = nums[0];
    int sum = 0;

    for (int num in nums) {
      if (num > maxNum) {
        maxNum = num;
      }

      sum += num;
    }

    return maxNum * nums.length - sum;
  }
}