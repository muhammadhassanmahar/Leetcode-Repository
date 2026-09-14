class Solution {
  bool isRectangleOverlap(List<int> rec1, List<int> rec2) {
    // rec = [x1, y1, x2, y2]

    // Agar ek rectangle completely left/right/up/down ho
    // to overlap nahi hoga.
    if (rec1[2] <= rec2[0] ||  // rec1 left
        rec2[2] <= rec1[0] ||  // rec2 left
        rec1[3] <= rec2[1] ||  // rec1 below
        rec2[3] <= rec1[1]) {  // rec2 below
      return false;
    }

    return true;
  }
}