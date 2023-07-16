class Solution {
    func splitNum(_ num: Int) -> Int {
        var arr: [Int] = []
        var temp = num, sumOne = 0, sumTwo = 0
        while temp != 0 {
            arr.append(temp%10)
            temp /= 10
        }
        arr = arr.sorted()
        for i in 0..<arr.count {
            if i%2 == 0 {
                sumOne = sumOne*10 + arr[i]
            } else {
                sumTwo = sumTwo*10 + arr[i]
            }
        }
        return sumOne+sumTwo
    }
}
