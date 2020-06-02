//
//  DeleteNodeInALinkedList.swift
//  aocTests
//
//  Created by Paul Uhn on 6/2/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import XCTest

private class ListNode: CustomStringConvertible {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    static func head(_ head: [Int]) -> ListNode {
        let tail = head.reversed()
        var prev: ListNode?
        for val in tail {
            let node = ListNode(val)
            node.next = prev
            prev = node
        }
        return prev!
    }
    func find(_ val: Int) -> ListNode? {
        var node: ListNode? = self
        while node != nil, node?.val != val {
            node = node?.next
        }
        return node
    }
    var description: String {
        var node: ListNode? = self
        var val = [Int]()
        while node != nil {
            val.append(node!.val)
            node = node?.next
        }
        return val.description
    }
}

private class Solution {
    func deleteNode(_ node: ListNode?) {
        var node = node
        var end: ListNode?
        repeat {
            node?.val = node?.next?.val ?? 0
            end = node
            node = node?.next
        } while node?.next != nil
        end?.next = nil
    }
}

class DeleteNodeInALinkedListTests: XCTestCase {
    func testCase1() {
        let head = ListNode.head([4,5,1,9])
        let node = head.find(5)
        Solution().deleteNode(node)
        let answer = head.description
        assert(answer == "[4, 1, 9]")
    }
    func testCase2() {
        let head = ListNode.head([4,5,1,9])
        let node = head.find(1)
        Solution().deleteNode(node)
        let answer = head.description
        assert(answer == "[4, 5, 9]")
    }
}
