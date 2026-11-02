class Solution {
  int minMoves2(List<int> nums) {
    nums.sort();
    int median = nums[nums.length ~/ 2];
    int moves = 0;
    for (int x in nums) {
      moves += (x - median).abs();
    }
    return moves;
  }
}