class Solution(object):
    def shortestBeautifulSubstring(self, s, k):
        """
        :type s: str
        :type k: int
        :rtype: str
        """
        left = 0
        ones = 0
        best = ""

        for right in range(len(s)):
            if s[right] == '1':
                ones += 1

            while ones > k:
                if s[left] == '1':
                    ones -= 1
                left += 1

            if ones == k:
                # Remove leading zeros
                while left <= right and s[left] == '0':
                    left += 1

                current = s[left:right + 1]

                if (best == "" or
                    len(current) < len(best) or
                    (len(current) == len(best) and current < best)):
                    best = current

        return best