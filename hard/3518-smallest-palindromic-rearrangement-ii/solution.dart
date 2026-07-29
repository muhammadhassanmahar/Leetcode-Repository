class Solution {
  String smallestPalindrome(String s, int k) {
    int n = s.length;
    List<int> freq = List<int>.filled(26, 0);
    for (int i = 0; i < n; i++) {
      freq[s.codeUnitAt(i) - 97]++;
    }

    int halfLen = n ~/ 2;
    List<int> half = List<int>.filled(26, 0);
    String midChar = '';
    for (int c = 0; c < 26; c++) {
      half[c] = freq[c] ~/ 2;
      if (freq[c] % 2 == 1) {
        midChar = String.fromCharCode(97 + c);
      }
    }

    // Factorials 0..halfLen (BigInt, kyunki numbers bahut bade ho sakte hain)
    List<BigInt> fact = List<BigInt>.filled(halfLen + 1, BigInt.one);
    for (int i = 1; i <= halfLen; i++) {
      fact[i] = fact[i - 1] * BigInt.from(i);
    }

    // Total distinct permutations of the "half" multiset
    BigInt totalPerm = fact[halfLen];
    for (int c = 0; c < 26; c++) {
      totalPerm = totalPerm ~/ fact[half[c]];
    }

    if (totalPerm < BigInt.from(k)) {
      return ""; // itni rearrangements exist hi nahi
    }

    List<String> halfResult = List<String>.filled(halfLen, '');
    int remaining = halfLen;
    int kk = k;

    for (int pos = 0; pos < halfLen; pos++) {
      for (int c = 0; c < 26; c++) {
        if (half[c] == 0) continue;

        // 'c' se start hoke kitni arrangements ban sakti hain
        BigInt candidate = totalPerm * BigInt.from(half[c]) ~/ BigInt.from(remaining);

        if (BigInt.from(kk) <= candidate) {
          halfResult[pos] = String.fromCharCode(97 + c);
          half[c]--;
          remaining--;
          totalPerm = candidate;
          break;
        } else {
          kk -= candidate.toInt();
        }
      }
    }

    StringBuffer sb = StringBuffer();
    sb.write(halfResult.join());
    sb.write(midChar);
    for (int i = halfLen - 1; i >= 0; i--) {
      sb.write(halfResult[i]);
    }
    return sb.toString();
  }
}