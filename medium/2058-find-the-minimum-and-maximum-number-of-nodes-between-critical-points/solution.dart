class Solution {
  List<int> nodesBetweenCriticalPoints(ListNode? head) {
    List<int> answer = [-1, -1];

    if (head == null || head.next == null || head.next!.next == null) {
      return answer;
    }

    ListNode? prev = head;
    ListNode? curr = head.next;

    int index = 1;
    int first = -1;
    int last = -1;

    int minDistance = 1000000;

    while (curr != null && curr.next != null) {
      int value = curr.val;

      // Critical point:
      // local maximum OR local minimum
      bool isCritical =
          (value > prev!.val && value > curr.next!.val) ||
          (value < prev.val && value < curr.next!.val);

      if (isCritical) {
        if (first == -1) {
          first = index;
        } else {
          minDistance = minDistance < (index - last)
              ? minDistance
              : (index - last);
        }

        last = index;
      }

      prev = curr;
      curr = curr.next;
      index++;
    }

    // Fewer than 2 critical points
    if (first == -1 || first == last) {
      return [-1, -1];
    }

    // Maximum distance = last critical point - first critical point
    int maxDistance = last - first;

    return [minDistance, maxDistance];
  }
}