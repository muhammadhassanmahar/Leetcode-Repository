# Minimum Height Trees

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

A tree is an undirected graph in which any two vertices are connected by exactly one path. In other words, any connected graph without simple cycles is a tree.

Given a tree of n nodes labelled from 0 to n - 1, and an array of n - 1 edges where edges[i] = [ai, bi] indicates that there is an undirected edge between the two nodes ai and bi in the tree, you can choose any node of the tree as the root. When you select a node x as the root, the result tree has height h. Among all possible rooted trees, those with minimum height (i.e. min(h))  are called minimum height trees (MHTs).

Return a list of all MHTs' root labels. You can return the answer in any order.

The height of a rooted tree is the number of edges on the longest downward path between the root and a leaf.

 
Example 1:

Input: n = 4, edges = [[1,0],[1,2],[1,3]]
Output: [1]
Explanation: As shown, the height of the tree is 1 when the root is the node with label 1 which is the only MHT.


Example 2:

Input: n = 6, edges = [[3,0],[3,1],[3,2],[3,4],[5,4]]
Output: [3,4]


 
Constraints:


	1 <= n <= 2 * 104
	edges.length == n - 1
	0 <= ai, bi < n
	ai != bi
	All the pairs (ai, bi) are distinct.
	The given input is guaranteed to be a tree and there will be no repeated edges.

## Solution

**Language:** dart  
**Runtime:** 15 ms (beats 100.00%)  
**Memory:** 170.5 MB (beats 50.00%)  
**Submitted:** 2026-08-22T15:58:22.041Z  

```dart
class Solution {
  List<int> findMinHeightTrees(int n, List<List<int>> edges) {
    if (n == 1) {
      return [0];
    }

    // Graph
    List<List<int>> graph =
        List.generate(n, (_) => <int>[]);

    // Degree of every node
    List<int> degree = List.filled(n, 0);

    for (List<int> edge in edges) {
      int u = edge[0];
      int v = edge[1];

      graph[u].add(v);
      graph[v].add(u);

      degree[u]++;
      degree[v]++;
    }

    // Initial leaves
    List<int> queue = [];

    for (int i = 0; i < n; i++) {
      if (degree[i] == 1) {
        queue.add(i);
      }
    }

    int remaining = n;

    while (remaining > 2) {
      int leafCount = queue.length;
      remaining -= leafCount;

      List<int> nextQueue = [];

      for (int i = 0; i < leafCount; i++) {
        int leaf = queue[i];

        for (int neighbor in graph[leaf]) {
          degree[neighbor]--;

          if (degree[neighbor] == 1) {
            nextQueue.add(neighbor);
          }
        }
      }

      queue = nextQueue;
    }

    return queue;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/minimum-height-trees/)