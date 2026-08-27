class Solution(object):
    def lexGreaterPermutation(self, s, target):
        """
        :type s: str
        :type target: str
        :rtype: str
        """

        count = [0] * 26

        for ch in s:
            count[ord(ch) - ord('a')] += 1

        n = len(target)

        def build_greater(pos):
            result = []

            for i in range(pos):
                idx = ord(target[i]) - ord('a')
                result.append(target[i])
                count[idx] -= 1

            # At position pos, choose the smallest
            # character strictly greater than target[pos]
            cur = ord(target[pos]) - ord('a')

            for c in range(cur + 1, 26):
                if count[c] > 0:
                    result.append(chr(c + ord('a')))
                    count[c] -= 1

                    # Put remaining characters in sorted order
                    for x in range(26):
                        result.append(chr(x + ord('a')) * count[x])

                    return ''.join(result)

            # Restore count
            for i in range(pos):
                count[ord(target[i]) - ord('a')] += 1

            return ""

        # First try to make a difference at the latest possible position.
        for pos in range(n - 1, -1, -1):
            count = [0] * 26

            for ch in s:
                count[ord(ch) - ord('a')] += 1

            possible = True

            # Prefix must exactly match target
            for i in range(pos):
                idx = ord(target[i]) - ord('a')

                if count[idx] == 0:
                    possible = False
                    break

                count[idx] -= 1

            if not possible:
                continue

            cur = ord(target[pos]) - ord('a')

            # Choose smallest character > target[pos]
            for c in range(cur + 1, 26):
                if count[c] > 0:
                    result = target[:pos] + chr(c + ord('a'))
                    count[c] -= 1

                    # Remaining characters smallest possible order
                    for x in range(26):
                        result += chr(x + ord('a')) * count[x]

                    return result

        return ""