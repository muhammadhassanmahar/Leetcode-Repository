class Solution {
  List<int> remainingMethods(
      int n, int k, List<List<int>> invocations) {

    List<List<int>> graph = List.generate(n, (_) => []);

    for (var e in invocations) {
      graph[e[0]].add(e[1]);
    }

    // Iterative DFS
    List<bool> suspicious = List.filled(n, false);
    List<int> stack = [k];
    suspicious[k] = true;

    while (stack.isNotEmpty) {
      int u = stack.removeLast();
      for (int v in graph[u]) {
        if (!suspicious[v]) {
          suspicious[v] = true;
          stack.add(v);
        }
      }
    }

    // Check if removal is possible
    for (var e in invocations) {
      int u = e[0], v = e[1];
      if (!suspicious[u] && suspicious[v]) {
        return List.generate(n, (i) => i);
      }
    }

    // Remaining methods
    List<int> ans = [];
    for (int i = 0; i < n; i++) {
      if (!suspicious[i]) ans.add(i);
    }

    return ans;
  }
}