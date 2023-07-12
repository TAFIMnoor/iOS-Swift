class Solution {
    func convertBase(_ n: Int, _ base: Int) -> Bool {
        var s: String = ""
        var num = n
        while num != 0 {
            s += String(num % base)
            num /= base
        }
        let reversedS = String(s.reversed())
        return s == reversedS
    }
    func isStrictlyPalindromic(_ n: Int) -> Bool {
        for i in 2...(n - 2) {
            if !convertBase(n,i) {
                return false
            }
        }
        return true
    }
}

