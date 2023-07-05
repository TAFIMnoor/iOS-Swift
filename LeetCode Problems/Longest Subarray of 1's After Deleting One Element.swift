class Solution {
    func longestSubarray(_ nums: [Int]) -> Int {
        var pos: [Int] = []
        for i in 0..<nums.count {
            if nums[i] == 0 {
                pos.append(i)
            }
        }
        if pos.isEmpty || pos.count == 1 {
            return nums.count - 1
        }
        pos.append(nums.count)
        var ans = pos[1] - 1
        for i in 1..<pos.count - 1 {
            ans = max(ans, pos[i+1] - pos[i-1] - 2)
        }
        return ans
    }
}
