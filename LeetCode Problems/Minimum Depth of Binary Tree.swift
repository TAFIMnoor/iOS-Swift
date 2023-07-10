/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {

    func inorder(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return Int.max
        }
        if root.left == nil && root.right == nil {
            return 1
        }
        return 1+min(inorder(root.left),inorder(root.right))
    }

    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        return inorder(root)
    }
}
