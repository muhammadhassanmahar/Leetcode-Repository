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