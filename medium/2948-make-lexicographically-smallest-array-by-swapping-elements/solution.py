class Solution(object):
    def lexicographicallySmallestArray(self, nums, limit):
        """
        :type nums: List[int]
        :type limit: int
        :rtype: List[int]
        """
        n = len(nums)

        # Value ke saath original index
        arr = sorted((value, i) for i, value in enumerate(nums))

        ans = [0] * n
        i = 0

        while i < n:
            j = i

            # Same group: consecutive values ka difference <= limit
            while j + 1 < n and arr[j + 1][0] - arr[j][0] <= limit:
                j += 1

            # Is group ke original indices
            indices = sorted(arr[k][1] for k in range(i, j + 1))

            # Values already sorted hain
            values = [arr[k][0] for k in range(i, j + 1)]

            # Smallest values -> smallest indices
            for k in range(len(indices)):
                ans[indices[k]] = values[k]

            i = j + 1

        return ans