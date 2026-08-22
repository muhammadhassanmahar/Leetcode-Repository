class Solution {
  int maxProduct(List<String> words) {
    int n = words.length;

    // Har word ka bitmask
    List<int> masks = List.filled(n, 0);

    for (int i = 0; i < n; i++) {
      int mask = 0;

      for (int j = 0; j < words[i].length; j++) {
        int bit = words[i].codeUnitAt(j) - 97;

        mask |= (1 << bit);
      }

      masks[i] = mask;
    }

    int answer = 0;

    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {

        // No common character
        if ((masks[i] & masks[j]) == 0) {
          int product = words[i].length * words[j].length;

          if (product > answer) {
            answer = product;
          }
        }
      }
    }

    return answer;
  }
}