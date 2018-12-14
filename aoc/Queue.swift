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
    
    let size: Int
    private(set) var head: Node?
    private(set) var last: Node?
    private(set) var count = 0
    
    init(size: Int) {
        self.size = size
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
            
            if count == size {
                let newHead = head!.next!
                newHead.prev = nil
                head = newHead
                count -= 1
            }
            
        } else {
            head = newNode
            last = newNode
            count = 1
        }
    }

}
