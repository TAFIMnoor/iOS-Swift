class Solution {
    func countGood(_ nums: [Int], _ k: Int) -> Int {
        var cnt = [Int: Int]()
        var ans: Int64 = 0
        var countGood: Int64 = 0
        var j = 0
        
        for i in 0..<nums.count {
            if cnt[nums[i], default: 0] == 0 {
                cnt[nums[i]] = 1
            } else {
                cnt[nums[i]]! += 1
            }
            
            if cnt[nums[i]]! == 2 {
                ans += 1
            } else if cnt[nums[i]]! > 2 {
                let val = cnt[nums[i]]! - 1
                ans -= Int64(val * (val - 1)) / 2
                ans += Int64(val * (val + 1)) / 2
            }
            
            while ans >= k && j < i {
                countGood += Int64(nums.count - i)
                let val = cnt[nums[j], default: 0]
                cnt[nums[j], default: 0] = val - 1
                ans -= Int64(val * (val - 1)) / 2
                let newVal = val - 1
                ans += Int64(newVal * (newVal - 1)) / 2
                j += 1
            }
        }
        
        return Int(countGood)
    }
}
