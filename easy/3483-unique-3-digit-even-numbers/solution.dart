class Solution {
  int totalNumbers(List<int> digits) {
    Set<int> numbers = {};

    for (int i = 0; i < digits.length; i++) {
      for (int j = 0; j < digits.length; j++) {
        for (int k = 0; k < digits.length; k++) {
          // Same digit/index reuse nahi karna
          if (i == j || j == k || i == k) continue;

          // 3-digit number 0 se start nahi ho sakta
          if (digits[i] == 0) continue;

          // Number even hona chahiye
          if (digits[k] % 2 != 0) continue;

          int num = digits[i] * 100 +
              digits[j] * 10 +
              digits[k];

          numbers.add(num);
        }
      }
    }

    return numbers.length;
  }
}