# Image Overlap

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

You are given two images, img1 and img2, represented as binary, square matrices of size n x n. A binary matrix has only 0s and 1s as values.

We translate one image however we choose by sliding all the 1 bits left, right, up, and/or down any number of units. We then place it on top of the other image. We can then calculate the overlap by counting the number of positions that have a 1 in both images.

Note also that a translation does not include any kind of rotation. Any 1 bits that are translated outside of the matrix borders are erased.

Return the largest possible overlap.

 
Example 1:

Input: img1 = [[1,1,0],[0,1,0],[0,1,0]], img2 = [[0,0,0],[0,1,1],[0,0,1]]
Output: 3
Explanation: We translate img1 to right by 1 unit and down by 1 unit.

The number of positions that have a 1 in both images is 3 (shown in red).



Example 2:

Input: img1 = [[1]], img2 = [[1]]
Output: 1


Example 3:

Input: img1 = [[0]], img2 = [[0]]
Output: 0


 
Constraints:


	n == img1.length == img1[i].length
	n == img2.length == img2[i].length
	1 <= n <= 30
	img1[i][j] is either 0 or 1.
	img2[i][j] is either 0 or 1.

## Solution

**Language:** dart  
**Runtime:** 49 ms (beats 100.00%)  
**Memory:** 148.5 MB (beats 100.00%)  
**Submitted:** 2026-09-13T07:07:50.395Z  

```dart
class Solution {
  int largestOverlap(List<List<int>> img1, List<List<int>> img2) {
    int n = img1.length;
    int answer = 0;

    // Har possible shift try karo
    for (int dr = -(n - 1); dr <= n - 1; dr++) {
      for (int dc = -(n - 1); dc <= n - 1; dc++) {
        int count = 0;

        for (int r = 0; r < n; r++) {
          for (int c = 0; c < n; c++) {
            int r2 = r + dr;
            int c2 = c + dc;

            if (r2 >= 0 &&
                r2 < n &&
                c2 >= 0 &&
                c2 < n &&
                img1[r][c] == 1 &&
                img2[r2][c2] == 1) {
              count++;
            }
          }
        }

        if (count > answer) {
          answer = count;
        }
      }
    }

    return answer;
  }
}
```

---

[View on LeetCode](https://leetcode.com/problems/image-overlap/)