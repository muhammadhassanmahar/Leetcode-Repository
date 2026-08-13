class Solution(object):
    def longestRepeating(self, s, queryCharacters, queryIndices):
        """
        :type s: str
        :type queryCharacters: str
        :type queryIndices: List[int]
        :rtype: List[int]
        """
        n = len(s)
        size_tree = 4 * n

        left_char = [0] * size_tree
        right_char = [0] * size_tree
        prefix = [0] * size_tree
        suffix = [0] * size_tree
        best = [0] * size_tree
        seg_len = [0] * size_tree

        chars = [ord(c) for c in s]

        def pull(node, lc, rc):
            seg_len[node] = seg_len[lc] + seg_len[rc]
            left_char[node] = left_char[lc]
            right_char[node] = right_char[rc]

            prefix[node] = prefix[lc]
            if prefix[lc] == seg_len[lc] and left_char[lc] == left_char[rc]:
                prefix[node] += prefix[rc]

            suffix[node] = suffix[rc]
            if suffix[rc] == seg_len[rc] and right_char[rc] == right_char[lc]:
                suffix[node] += suffix[lc]

            best[node] = max(best[lc], best[rc])
            if right_char[lc] == left_char[rc]:
                best[node] = max(best[node], suffix[lc] + prefix[rc])

        def build(node, l, r):
            if l == r:
                left_char[node] = right_char[node] = chars[l]
                prefix[node] = suffix[node] = best[node] = seg_len[node] = 1
                return
            mid = (l + r) // 2
            lc, rc = 2 * node, 2 * node + 1
            build(lc, l, mid)
            build(rc, mid + 1, r)
            pull(node, lc, rc)

        def update(node, l, r, idx, ch):
            if l == r:
                left_char[node] = right_char[node] = ch
                return
            mid = (l + r) // 2
            lc, rc = 2 * node, 2 * node + 1
            if idx <= mid:
                update(lc, l, mid, idx, ch)
            else:
                update(rc, mid + 1, r, idx, ch)
            pull(node, lc, rc)

        build(1, 0, n - 1)

        ans = []
        for qc, qi in zip(queryCharacters, queryIndices):
            update(1, 0, n - 1, qi, ord(qc))
            ans.append(best[1])

        return ans