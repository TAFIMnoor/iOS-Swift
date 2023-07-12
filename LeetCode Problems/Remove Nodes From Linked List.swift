/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func removeNodes(_ head: ListNode?) -> ListNode? {
        var nodes = [Int]()
        var temp = head
        
        while temp != nil {
            if nodes.isEmpty || nodes.last! >= temp!.val {
                nodes.append(temp!.val)
            } else {
                while !nodes.isEmpty && nodes.last! < temp!.val {
                    nodes.removeLast()
                }
                nodes.append(temp!.val)
            }
            temp = temp?.next
        }
        
        var next: ListNode? = nil
        for val in nodes.reversed() {
            let node = ListNode(val)
            node.next = next
            next = node
        }
        return next
    }
}
