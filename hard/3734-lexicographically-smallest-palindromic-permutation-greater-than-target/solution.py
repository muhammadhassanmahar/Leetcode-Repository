class Solution(object):
    def lexPalindromicPermutation(self, s, target):
        """
        :type s: str
        :type target: str
        :rtype: str
        """

        n = len(s)

        # Count characters
        freq = [0] * 26

        for ch in s:
            freq[ord(ch) - ord('a')] += 1

        # More than one odd frequency -> no palindrome possible
        odd = -1

        for i in range(26):
            if freq[i] % 2 == 1:
                if odd != -1:
                    return ""
                odd = i

        half_len = n // 2

        # Characters available in left half
        half = [freq[i] // 2 for i in range(26)]

        middle = ""
        if odd != -1:
            middle = chr(ord('a') + odd)

        def make_palindrome(left):
            return left + middle + left[::-1]

        # --------------------------------------------------
        # 1. Try using target's first half exactly
        # --------------------------------------------------

        used = [0] * 26
        left = []
        possible = True

        for i in range(half_len):
            c = ord(target[i]) - ord('a')

            if used[c] >= half[c]:
                possible = False
                break

            used[c] += 1
            left.append(target[i])

        if possible:
            left = ''.join(left)

            # If this palindrome is already greater,
            # it is the smallest possible answer.
            candidate = make_palindrome(left)

            if candidate > target:
                return candidate

        # --------------------------------------------------
        # 2. Find the smallest left half > target's left half
        # --------------------------------------------------

        for pos in range(half_len - 1, -1, -1):

            used = [0] * 26
            prefix = []
            possible = True

            # Match target prefix exactly
            for i in range(pos):
                c = ord(target[i]) - ord('a')

                if used[c] >= half[c]:
                    possible = False
                    break

                used[c] += 1
                prefix.append(target[i])

            if not possible:
                continue

            target_char = ord(target[pos]) - ord('a')

            # Choose smallest character greater than target[pos]
            for c in range(target_char + 1, 26):

                if used[c] >= half[c]:
                    continue

                new_left = prefix[:]
                new_left.append(chr(ord('a') + c))

                used[c] += 1

                # Fill remaining characters in sorted order
                for x in range(26):
                    remaining = half[x] - used[x]

                    if remaining > 0:
                        new_left.append(
                            chr(ord('a') + x) * remaining
                        )

                left = ''.join(new_left)

                return make_palindrome(left)

        return ""