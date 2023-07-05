func productExceptSelf(_ nums: [Int]) -> [Int] {
       var arr = Array(repeating: 1, count: nums.count)
       var prod = 1
       for i in 0..<nums.count {
           prod = prod * nums[i]
       }
       for i in 0..<nums.count {
           arr[i] = prod / nums[i]
       }
       return arr
   }
