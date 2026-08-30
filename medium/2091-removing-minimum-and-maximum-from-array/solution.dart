class Solution {
  int minimumDeletions(List<int> nums) {
    int n = nums.length;

    int minIndex = 0;
    int maxIndex = 0;

    // Minimum aur maximum ke indexes find karo
    for (int i = 1; i < n; i++) {
      if (nums[i] < nums[minIndex]) {
        minIndex = i;
      }

      if (nums[i] > nums[maxIndex]) {
        maxIndex = i;
      }
    }

    // min/max ko left se remove karne ki cost
    int left = (minIndex > maxIndex ? minIndex : maxIndex) + 1;

    // right se remove karne ki cost
    int right = n -
        (minIndex < maxIndex ? minIndex : maxIndex);

    // Ek left aur doosra right se
    int both = (minIndex < maxIndex ? minIndex : maxIndex) + 1 +
        n - (minIndex > maxIndex ? minIndex : maxIndex);

    return [left, right, both].reduce((a, b) => a < b ? a : b);
  }
}