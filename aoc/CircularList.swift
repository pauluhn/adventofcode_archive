//
//  CircularList.swift
//  aoc
//
//  Created by Paul Uhn on 12/9/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class CircularList<T> {
    class CircularListNode<T> {
        var value: T
        var prev: Node?
        var next: Node?
        init(_ value: T) { self.value = value }
    }
    typealias Node = CircularListNode<T>
    
    private(set) var head: Node?
    private(set) var last: Node?
    private(set) var count = 0

    init() {}
    
    func get(_ node: Node, offset: Int) -> Node {
        guard offset != 0 else { return node }
        if offset > 0 {
            return get(node.next!, offset: offset - 1)
        } else {
            return get(node.prev!, offset: offset + 1)
        }
    }
    
    func append(_ element: T) {
        append(Node(element))
    }
    
    func append(_ newNode: Node) {
        if let lastNode = last {
            let next = lastNode.next!
            next.prev = newNode
            newNode.next = next
            newNode.prev = lastNode
            lastNode.next = newNode
            last = newNode
            count += 1
        } else {
            newNode.next = newNode
            newNode.prev = newNode
            head = newNode
            last = newNode
            count = 1
        }
    }

    func insert(before node: Node, _ element: T) {
        insert(before: node, Node(element))
    }
    
    func insert(before node: Node, _ newNode: Node) {
        let prev = node.prev!
        prev.next = newNode
        newNode.prev = prev
        newNode.next = node
        node.prev = newNode
        count += 1
    }
    
    func insert(after node: Node, _ element: T) {
        let next = node.next!
        insert(before: next, element)
    }
    
    @discardableResult
    func remove(_ node: Node) -> T {
        let value = node.value
        let prev = node.prev!
        let next = node.next!
        prev.next = next
        next.prev = prev
        count -= 1
        return value
    }
}
