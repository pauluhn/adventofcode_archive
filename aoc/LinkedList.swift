//
//  LinkedList.swift
//  aoc
//
//  Created by Paul Uhn on 12/12/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class LinkedList<T> {
    class LinkedListNode<T> {
        var value: T
        var prev: Node?
        var next: Node?
        init(_ value: T) { self.value = value }
    }
    typealias Node = LinkedListNode<T>

    private(set) var head: Node?
    private(set) var last: Node?
    private(set) var count = 0
    
    init() {}
    
    func node(at index: Int) -> Node {
        guard index >= 0 else { fatalError() }
        if index == 0 {
            return head!
        }
        var node = head
        for _ in 0..<index {
            node = node?.next
            if node == nil {
                break
            }
        }
        return node!
    }
    
    func append(_ list: [T]) {
        for item in list {
            append(item)
        }
    }

    func append(_ value: T) {
        append(Node(value))
    }
    
    func append(_ newNode: Node) {
        if let lastNode = last {
            newNode.prev = lastNode
            lastNode.next = newNode
            last = newNode
            count += 1
        } else {
            head = newNode
            last = newNode
            count = 1
        }
    }
    
    func insert(_ list: [T], at index: Int) {
        for item in list.reversed() {
            insert(item, at: index)
        }
    }
    
    func insert(_ value: T, at index: Int) {
        insert(Node(value), at: index)
    }
    
    func insert(_ newNode: Node, at index: Int) {
        if index == 0 {
            head!.prev = newNode
            newNode.next = head!
            head = newNode
            count += 1
        } else {
            let prev = node(at: index - 1)
            let next = prev.next!
            newNode.prev = prev
            newNode.next = next
            prev.next = newNode
            next.prev = newNode
            count += 1
        }
    }
    
    subscript(range: Range<Int>) -> [T] {
        var aNode = node(at: range.startIndex)
        var array: [T] = []
        for _ in range {
            array.append(aNode.value)
            if let nextNode = aNode.next {
                aNode = nextNode
            } else {
                break
            }
        }
        assert(array.count == range.count)
        return array
    }
}
