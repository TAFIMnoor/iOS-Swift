/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    var arr = [[Int]](repeating: [], count: 501)
    func inOrder(_ root: TreeNode?) {
        if root == nil { return }
        if let left = root!.left {
            arr[root!.val].append(left.val)
            arr[left.val].append(root!.val)
            inOrder(left)
        }
        if let right = root!.right {
            arr[root!.val].append(right.val)
            arr[right.val].append(root!.val)
            inOrder(right)
        }
    }
    func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ k: Int) -> [Int] {
        if k == 0 {
            return [target!.val]
        }
        inOrder(root)
        var queue = [target!.val]
        var ans : [Int] = []
        var dis = [Int](repeating: 0, count: 501)
        var vis = [Bool](repeating: false, count: 501)
        vis[target!.val] = true
        while !queue.isEmpty {
            var u = queue.removeFirst()
            for i in 0..<arr[u].count {
                if vis[arr[u][i]] == false {
                    vis[arr[u][i]] = true
                    queue.append(arr[u][i])
                    dis[arr[u][i]] = dis[u] + 1
                    if dis[arr[u][i]] == k {
                        ans.append(arr[u][i])
                    }
                }
            }
        }
        return ans
    }
}
