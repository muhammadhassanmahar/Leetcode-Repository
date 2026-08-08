class Solution(object):
    def validSequence(self, word1, word2):
        """
        :type word1: str
        :type word2: str
        :rtype: List[int]
        """
        n, m = len(word1), len(word2)
        ans = []

        # last[j] = word1 me wo index i jaha se word2[j:] ko exact
        # subsequence ke roop me match kiya ja sakta hai (backward greedy)
        last = [-1] * m

        i, j = n - 1, m - 1
        while i >= 0 and j >= 0:
            if word1[i] == word2[j]:
                last[j] = i
                j -= 1
            i -= 1

        can_skip = True  # abhi tak humara "1 change" use nahi hua
        j = 0
        for i, c in enumerate(word1):
            if j == m:
                break
            if c == word2[j]:
                ans.append(i)
                j += 1
            elif can_skip and (j == m - 1 or i < last[j + 1]):
                can_skip = False
                ans.append(i)
                j += 1
            # warna is index ko skip karke aage badho

        return ans if j == m else []
        