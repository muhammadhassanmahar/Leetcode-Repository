class NumArray {
  late List<int> nums;
  late List<int> tree;

  NumArray(List<int> nums) {
    this.nums = List.from(nums);
    tree = List.filled(nums.length + 1, 0);

    // Build Fenwick Tree
    for (int i = 0; i < nums.length; i++) {
      _add(i + 1, nums[i]);
    }
  }

  void update(int index, int val) {
    int diff = val - nums[index];

    nums[index] = val;

    _add(index + 1, diff);
  }

  void _add(int index, int value) {
    while (index < tree.length) {
      tree[index] += value;
      index += index & -index;
    }
  }

  int _prefixSum(int index) {
    int sum = 0;

    while (index > 0) {
      sum += tree[index];
      index -= index & -index;
    }

    return sum;
  }

  int sumRange(int left, int right) {
    return _prefixSum(right + 1) - _prefixSum(left);
  }
}