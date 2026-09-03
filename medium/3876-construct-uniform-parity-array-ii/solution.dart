class Solution {
  bool uniformArray(List<int> nums1) {
    int minOdd = 1 << 30;

    // Find the smallest odd number
    for (int x in nums1) {
      if (x % 2 == 1) {
        minOdd = minOdd < x ? minOdd : x;
      }
    }

    // If an even number is smaller than the smallest odd,
    // we cannot make all numbers have the same parity.
    for (int x in nums1) {
      if (x % 2 == 0 && minOdd != (1 << 30) && x < minOdd) {
        return false;
      }
    }

    return true;
  }
}