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