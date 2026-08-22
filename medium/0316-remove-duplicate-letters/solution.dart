class Solution {
  String removeDuplicateLetters(String s) {
    // Har character ki remaining frequency
    List<int> count = List.filled(26, 0);

    for (int i = 0; i < s.length; i++) {
      count[s.codeUnitAt(i) - 97]++;
    }

    List<String> stack = [];
    List<bool> used = List.filled(26, false);

    for (int i = 0; i < s.length; i++) {
      String ch = s[i];
      int index = s.codeUnitAt(i) - 97;

      // Ye occurrence process ho gayi
      count[index]--;

      // Already answer mein hai
      if (used[index]) {
        continue;
      }

      // Agar stack ka last character:
      // 1. current se bada hai
      // 2. aur future mein dobara aa sakta hai
      // to usko remove kar do
      while (stack.isNotEmpty) {
        String last = stack.last;
        int lastIndex = last.codeUnitAt(0) - 97;

        if (last.compareTo(ch) > 0 && count[lastIndex] > 0) {
          stack.removeLast();
          used[lastIndex] = false;
        } else {
          break;
        }
      }

      stack.add(ch);
      used[index] = true;
    }

    return stack.join();
  }
}