class Solution(object):
    def stoneGameII(self, piles):
        n = len(piles)

        suffix = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            suffix[i] = suffix[i + 1] + piles[i]

        memo = {}

        def dfs(i, M):
            if i >= n:
                return 0

            if (i, M) in memo:
                return memo[(i, M)]

            best = 0

            for X in range(1, 2 * M + 1):
                if i + X > n:
                    break

                stones = suffix[i] - dfs(i + X, max(M, X))
                best = max(best, stones)

            memo[(i, M)] = best
            return best

        return dfs(0, 1)