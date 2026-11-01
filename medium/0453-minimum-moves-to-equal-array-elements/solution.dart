class Solution {
  int minMoves(List<int> nums) {
    int minNum = nums.reduce((a, b) => a < b ? a : b);

    int moves = 0;

    for (int num in nums) {
      moves += num - minNum;
    }

    return moves;
  }
}