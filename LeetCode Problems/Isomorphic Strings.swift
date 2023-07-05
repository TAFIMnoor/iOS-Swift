 func isIsomorphic(_ s: String, _ t: String) -> Bool {
       guard s.count == t.count else {
           return false
       }
       var dict1 : [Character : Character] = [:]
       var dict2 : [Character : Character] = [:]
       var ss = Array(s)
       var tt = Array(t)
       for i in 0..<tt.count{
           let cS = ss[i]
           let cT = tt[i]
           if let mp = dict1[cS], mp != cT {
               return false
           }
           if let mp = dict2[cT], mp != cS {
               return false
           }
           dict1[cS] = cT
           dict2[cT] = cS
       }
       return true
   }
