class Solution {
  String getHint(String secret, String guess) {
    int bulls = 0;
    int cows = 0;

    List<int> secretCount = List.filled(10, 0);
    List<int> guessCount = List.filled(10, 0);

    // First: find bulls
    for (int i = 0; i < secret.length; i++) {
      if (secret[i] == guess[i]) {
        bulls++;
      } else {
        secretCount[int.parse(secret[i])]++;
        guessCount[int.parse(guess[i])]++;
      }
    }

    // Second: find cows
    for (int i = 0; i < 10; i++) {
      cows +=
          secretCount[i] < guessCount[i]
              ? secretCount[i]
              : guessCount[i];
    }

    return "${bulls}A${cows}B";
  }
}