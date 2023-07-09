class Solution {
    func maxConsecutiveAnswers(_ answerKey: String, _ k: Int) -> Int {
        let answerKey = Array(answerKey)
        var tCount = 0, fCount = 0, j = 0, ans = 0
        for i in 0..<answerKey.count {
            if answerKey[i] == "T" {
                tCount += 1
            } else {
                fCount += 1
            }
            while min(tCount,fCount) > k {
                if answerKey[j] == "T" {
                    tCount -= 1
                } else {
                    fCount -= 1
                }
                j += 1
            }
            ans = max(ans, i-j+1)
        }
        
        return ans
    }
}
