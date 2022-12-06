//
//  Queue.swift
//  aoc
//
//  Created by Paul Uhn on 12/14/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class Queue<T> {
    class QueueNode<T> {
        var value: T
        var prev: Node?
        var next: Node?
        init(_ value: T) { self.value = value }
    }
    typealias Node = QueueNode<T>
    
    private(set) var head: Node?
    private(set) var last: Node?
    private(set) var count = 0
    
    var isEmpty: Bool { return count == 0 }
    
    init(_ list: [T] = []) {
        guard !list.isEmpty else { return }
        push(list)
    }
    
    func push(_ list: [T]) {
        for item in list {
            push(item)
        }
    }
    func push(_ value: T) {
        push(Node(value))
    }
    
    func push(_ newNode: Node) {
        if let headNode = head {
            newNode.next = headNode
            headNode.prev = newNode
            head = newNode
            count += 1
            
        } else {
            head = newNode
            last = newNode
            count = 1
        }
    }

    func pop() -> T? {
        guard let lastNode = last else { return nil }
        let value = lastNode.value
        guard count > 1 else {
            head = nil
            last = nil
            count = 0
            return value
        }
        let newLast = lastNode.prev!
        newLast.next = nil
        last = newLast
        count -= 1
        return value
    }
}
