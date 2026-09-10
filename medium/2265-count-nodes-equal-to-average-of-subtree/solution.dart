class Solution {
  int countNodes = 0;

  int averageOfSubtree(TreeNode? root) {
    dfs(root);
    return countNodes;
  }

  List<int> dfs(TreeNode? node) {
    if (node == null) {
      return [0, 0]; // [sum, count]
    }

    List<int> left = dfs(node.left);
    List<int> right = dfs(node.right);

    int sum = left[0] + right[0] + node.val;
    int count = left[1] + right[1] + 1;

    if (sum ~/ count == node.val) {
      countNodes++;
    }

    return [sum, count];
  }
}