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