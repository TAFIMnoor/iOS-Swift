class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        var arr = [Int](repeating: 0, count:1001)
        for num in nums {
            arr[num] += 1
        }
        var count = nums.count
        for i in 0...1000 {
            if (i == count && count > 0) {
                return i
            }
            count -= arr[i]
        }
        return -1;
    }
}
