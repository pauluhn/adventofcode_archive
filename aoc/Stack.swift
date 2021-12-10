//
//  Stack.swift
//  aoc
//
//  Created by Paul U on 12/10/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Stack<T> {
    private(set) var stack: [T]

    init() {
        stack = []
    }
    init(pushing elements: [T]) {
        stack = elements
    }

    mutating func push(_ element: T) {
        stack.append(element)
    }

    @discardableResult
    mutating func pop() -> T? {
        stack.popLast()
    }

    func peek() -> T? {
        stack.last
    }
}
