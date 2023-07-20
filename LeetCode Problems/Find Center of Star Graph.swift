class Solution {
    func findCenter(_ edges: [[Int]]) -> Int {
        var m = Dictionary<Int,Int> ()
        for edge in edges {
            m[edge[0],default:0] += 1
            m[edge[1],default:0] += 1
        }
        for (key,value) in m {
            if value == edges.count {
                return key
            }
        }
        return 0
    }
}
