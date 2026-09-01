# Minimum Moves to Clean the Classroom

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given an m x n grid classroom where a student volunteer is tasked with cleaning up litter scattered around the room. Each cell in the grid is one of the following:


	'S': Starting position of the student
	'L': Litter that must be collected (once collected, the cell becomes empty)
	'R': Reset area that restores the student's energy to full capacity, regardless of their current energy level (can be used multiple times)
	'X': Obstacle the student cannot pass through
	'.': Empty space


You are also given an integer energy, representing the student's maximum energy capacity. The student starts with this energy from the starting position 'S'.

Each move to an adjacent cell (up, down, left, or right) costs 1 unit of energy. If the energy reaches 0, the student can only continue if they are on a reset area 'R', which resets the energy to its maximum capacity energy.

Return the minimum number of moves required to collect all litter items, or -1 if it's impossible.

 
Example 1:


Input: classroom = ["S.", "XL"], energy = 2

Output: 2

Explanation:


	The student starts at cell (0, 0) with 2 units of energy.
	Since cell (1, 0) contains an obstacle 'X', the student cannot move directly downward.
	A valid sequence of moves to collect all litter is as follows:
	
		Move 1: From (0, 0) → (0, 1) with 1 unit of energy and 1 unit remaining.
		Move 2: From (0, 1) → (1, 1) to collect the litter 'L'.
	
	
	The student collects all the litter using 2 moves. Thus, the output is 2.



Example 2:


Input: classroom = ["LS", "RL"], energy = 4

Output: 3

Explanation:


	The student starts at cell (0, 1) with 4 units of energy.
	A valid sequence of moves to collect all litter is as follows:
	
		Move 1: From (0, 1) → (0, 0) to collect the first litter 'L' with 1 unit of energy used and 3 units remaining.
		Move 2: From (0, 0) → (1, 0) to 'R' to reset and restore energy back to 4.
		Move 3: From (1, 0) → (1, 1) to collect the second litter 'L'.
	
	
	The student collects all the litter using 3 moves. Thus, the output is 3.



Example 3:


Input: classroom = ["L.S", "RXL"], energy = 3

Output: -1

Explanation:

No valid path collects all 'L'.


 
Constraints:


	1 <= m == classroom.length <= 20
	1 <= n == classroom[i].length <= 20
	classroom[i][j] is one of 'S', 'L', 'R', 'X', or '.'
	1 <= energy <= 50
	There is exactly one 'S' in the grid.
	There are at most 10 'L' cells in the grid.

## Solution

**Language:** dart  
**Runtime:** 279 ms (beats 100.00%)  
**Memory:** 326.6 MB (beats 100.00%)  
**Submitted:** 2026-09-01T05:15:45.740Z  

```dart
class Solution {
  int minMoves(List<String> classroom, int energy) {
    int n = classroom.length;
    int m = classroom[0].length;

    int sr = 0;
    int sc = 0;

    List<List<int>> litter = [];

    for (int r = 0; r < n; r++) {
      for (int c = 0; c < m; c++) {
        if (classroom[r][c] == 'S') {
          sr = r;
          sc = c;
        } else if (classroom[r][c] == 'L') {
          litter.add([r, c]);
        }
      }
    }

    int l = litter.length;

    if (l == 0) return 0;

    int fullMask = (1 << l) - 1;

    // Har cell par kaunsa litter hai
    List<List<int>> litterMask =
        List.generate(n, (_) => List.filled(m, 0));

    for (int i = 0; i < l; i++) {
      int r = litter[i][0];
      int c = litter[i][1];

      litterMask[r][c] = 1 << i;
    }

    /*
      best[r][c][mask] =
      is cell par is mask ke saath ab tak maximum energy
    */
    int states = 1 << l;

    List<List<List<int>>> best = List.generate(
      n,
      (_) => List.generate(
        m,
        (_) => List.filled(states, -1),
      ),
    );

    // Queue arrays — List<List<int>> se faster
    List<int> qr = [];
    List<int> qc = [];
    List<int> qe = [];
    List<int> qm = [];

    int front = 0;

    qr.add(sr);
    qc.add(sc);
    qe.add(energy);
    qm.add(0);

    best[sr][sc][0] = energy;

    int moves = 0;

    List<int> dr = [1, -1, 0, 0];
    List<int> dc = [0, 0, 1, -1];

    while (front < qr.length) {
      int levelEnd = qr.length;

      while (front < levelEnd) {
        int r = qr[front];
        int c = qc[front];
        int e = qe[front];
        int mask = qm[front];

        front++;

        if (mask == fullMask) {
          return moves;
        }

        // Agar energy 0 hai to move nahi kar sakte
        if (e == 0) {
          continue;
        }

        for (int d = 0; d < 4; d++) {
          int nr = r + dr[d];
          int nc = c + dc[d];

          if (nr < 0 || nr >= n || nc < 0 || nc >= m) {
            continue;
          }

          // X = wall
          if (classroom[nr][nc] == 'X') {
            continue;
          }

          int ne = e - 1;

          // Litter clean
          int nmask = mask | litterMask[nr][nc];

          // R = recharge
          if (classroom[nr][nc] == 'R') {
            ne = energy;
          }

          /*
            Dominance optimization:

            Agar same cell + same mask par
            pehle hi >= energy available hai,
            to ye state useless hai.
          */
          if (best[nr][nc][nmask] >= ne) {
            continue;
          }

          best[nr][nc][nmask] = ne;

          qr.add(nr);
          qc.add(nc);
          qe.add(ne);
          qm.add(nmask);
        }
      }

      moves++;
    }

    return -1;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/minimum-moves-to-clean-the-classroom/)