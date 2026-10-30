# Shortest Path With At Most K Consecutive Identical Characters

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given an integer `n` representing the number of nodes in a **directed weighted** graph, numbered from 0 to `n - 1`. This is represented by a 2D integer array `edges`, where `edges[i] = [ui, vi, wi]` represents a directed edge from node `ui` to node `vi` with weight `wi`.

You are also given a string `labels` of length `n`, where `labels[i]` is the character assigned to node `i`, and an integer `k`.

Return the **minimum** **total** edge weight of a path from node 0 to node `n - 1` such that the concatenation of the labels of the nodes along the path contains **at most** `k` **consecutive** **identical** characters. If no valid path exists, return -1.

 

**Example 1:**

**Input:** n = 3, edges = [[0,1,1],[1,2,1],[0,2,3]], labels = "aab", k = 1

**Output:** 3

**Explanation:**

The optimal valid path from node 0 to node 2 is as follows:

- Use edges[2] = [0, 2, 3] to reach node 2 with a weight wi = 3.
The corresponding concatenation of labels is `"ab"`, which satisfies at most `k = 1` consecutive identical characters. Thus, the answer is 3.

**Example 2:**

**Input:** n = 3, edges = [[0,1,1],[1,2,1],[0,2,3]], labels = "aab", k = 2

**Output:** 2

**Explanation:**

The optimal valid path from node 0 to node 2 is as follows:

- Use edges[0] = [0, 1, 1] to reach node 1 with weight wi = 1.
- Use edges[1] = [1, 2, 1] to reach node 2 with weight wi = 1.
The corresponding concatenation of labels is `"aab"`, which satisfies at most `k = 2` consecutive identical characters. Thus, the answer is 2.

**Example 3:**

**Input:** n = 3, edges = [[0,1,1],[1,2,1]], labels = "aaa", k = 2

**Output:** -1

**Explanation:**

There is no valid path from node 0 to node 2 that satisfies at most `k = 2` consecutive identical characters. Thus, the answer is -1.

 

**Constraints:**

- 1 <= n == labels.length <= 5 * 104
- 0 <= edges.length <= 5 * 104
- edges[i] == [ui, vi, wi]
- 0 <= ui, vi <= n - 1
- ui != vi
- 1 <= wi <= 104
- labels consists of lowercase English letters
- 1 <= k <= 50

## Solution

**Language:** C++  
**Runtime:** 208 ms (beats 69.25%)  
**Memory:** 274.4 MB (beats 79.59%)  
**Submitted:** 2026-10-30T10:04:36.258Z  

```cpp
#include <vector>
#include <string>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    int shortestPath(int n, vector<vector<int>>& edges, string labels, int k) {
        // Build the adjacency list: g[u] = vector of {neighbor, weight}
        vector<vector<pair<int, int>>> g(n);
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            g[u].push_back({v, w});
        }

        const int INF = 1e9;
        // dist[u][cur] = minimum weight to reach node u with a trailing run of length cur
        vector<vector<int>> dist(n, vector<int>(k + 1, INF));
        dist[0][1] = 0;

        // Min-heap priority queue storing tuples: {cost, u, cur}
        // Using greater<> to ensure the smallest cost stays at the top
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        pq.push({0, 0, 1});

        while (!pq.empty()) {
            auto [d, u, cur] = pq.top();
            pq.pop();

            // Found the destination node
            if (u == n - 1) {
                return d;
            }

            // Skip if we found a shorter path to this state already
            if (d > dist[u][cur]) {
                continue;
            }

            for (const auto& [v, w] : g[u]) {
                // If label matches, increase consecutive streak. Otherwise, reset to 1.
                int nxt = (labels[v] == labels[u]) ? cur + 1 : 1;
                
                if (nxt <= k) {
                    int nd = d + w;
                    if (nd < dist[v][nxt]) {
                        dist[v][nxt] = nd;
                        pq.push({nd, v, nxt});
                    }
                }
            }
        }

        return -1;
    }
};
```

---

[View on LeetCode](https://leetcode.com/problems/shortest-path-with-at-most-k-consecutive-identical-characters/)