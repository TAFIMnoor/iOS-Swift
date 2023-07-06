class Solution {
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var sum = 0, len = Int.max, j = 0
        for i in 0..<nums.count{
            sum += nums[i]
            while sum >= target{
                len = min(len,i-j+1)
                sum -= nums[j]
                j += 1
            }
        }
        if len == Int.max {
            return 0
        }
        return len
    }
}
