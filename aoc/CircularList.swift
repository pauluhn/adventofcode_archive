//
//  CircularList.swift
//  aoc
//
//  Created by Paul Uhn on 12/9/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct CircularList<T> {
    typealias Pointer = Int
    private(set) var pointer: Pointer = 0
    private(set) var data: [T] = []
    
    var count: Int { return data.count }
    
    func element() -> T {
        return data[pointer]
    }
    
    mutating func move(by offset: Int) {
        guard offset != 0 else { return }
        if offset > 0 {
            for _ in 0..<offset { forward() }
        } else {
            for _ in 0..<(abs(offset)) { backward() }
        }
    }
    
    mutating func insert(_ element: T) {
        data.insert(element, at: pointer)
    }
    
    mutating func replace(_ element: T) {
        data[pointer] = element
    }
    
    mutating func remove() -> T {
        let element = data.remove(at: pointer)
        if pointer == data.count {
            forward()
        }
        return element
    }
}
private extension CircularList {
    mutating func forward() {
        guard pointer < data.count - 1 else {
            pointer = 0
            return
        }
        pointer += 1
    }
    mutating func backward() {
        guard pointer > 0 else {
            pointer = data.count - 1
            return
        }
        pointer -= 1
    }
}
