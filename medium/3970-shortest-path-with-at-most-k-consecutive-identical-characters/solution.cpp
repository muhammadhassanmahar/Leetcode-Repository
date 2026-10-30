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