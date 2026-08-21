# Additive Number

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

An additive number is a string whose digits can form an additive sequence.

A valid additive sequence should contain at least three numbers. Except for the first two numbers, each subsequent number in the sequence must be the sum of the preceding two.

Given a string containing only digits, return true if it is an additive number or false otherwise.

Note: Numbers in the additive sequence cannot have leading zeros, so sequence 1, 2, 03 or 1, 02, 3 is invalid.

 
Example 1:

Input: "112358"
Output: true
Explanation: 
The digits can form an additive sequence: 1, 1, 2, 3, 5, 8. 
1 + 1 = 2, 1 + 2 = 3, 2 + 3 = 5, 3 + 5 = 8


Example 2:

Input: "199100199"
Output: true
Explanation: 
The additive sequence is: 1, 99, 100, 199. 
1 + 99 = 100, 99 + 100 = 199


 
Constraints:


	1 <= num.length <= 35
	num consists only of digits.


 
Follow up: How would you handle overflow for very large input integers?

## Solution

**Language:** dart  
**Runtime:** 6 ms (beats 100.00%)  
**Memory:** 149.8 MB (beats 33.33%)  
**Submitted:** 2026-08-21T04:40:03.408Z  

```dart
class Solution {
  bool isAdditiveNumber(String num) {
    int n = num.length;

    for (int i = 1; i <= n - 2; i++) {
      // First number leading zero nahi ho sakta
      if (num[0] == '0' && i > 1) break;

      for (int j = i + 1; j <= n - 1; j++) {
        // Second number leading zero nahi ho sakta
        if (num[i] == '0' && j - i > 1) break;

        String a = num.substring(0, i);
        String b = num.substring(i, j);

        if (_check(num, j, a, b)) {
          return true;
        }
      }
    }

    return false;
  }

  bool _check(String num, int start, String a, String b) {
    while (start < num.length) {
      String sum = _addStrings(a, b);

      // Next number exactly sum hona chahiye
      if (!num.startsWith(sum, start)) {
        return false;
      }

      start += sum.length;

      a = b;
      b = sum;
    }

    return true;
  }

  String _addStrings(String a, String b) {
    int i = a.length - 1;
    int j = b.length - 1;
    int carry = 0;

    String result = '';

    while (i >= 0 || j >= 0 || carry > 0) {
      int x = i >= 0 ? int.parse(a[i]) : 0;
      int y = j >= 0 ? int.parse(b[j]) : 0;

      int sum = x + y + carry;

      result = '${sum % 10}$result';
      carry = sum ~/ 10;

      i--;
      j--;
    }

    return result;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/additive-number/)