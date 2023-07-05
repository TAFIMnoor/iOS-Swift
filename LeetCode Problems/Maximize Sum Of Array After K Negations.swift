func largestSumAfterKNegations(_ nums: [Int], _ k: Int) -> Int {
  var arr = nums, val = 0, times = k
   arr.sort()
   for i in 0..<nums.count{
       if(times > 0 && arr[i] < 0){
           arr[i] = -arr[i]
           times = times - 1;
       }
   }
   arr.sort()
   if(times % 2 == 1){
       arr[0] = -arr[0]
   }
   for num in arr{
       val += num
   }
   return val
  }
