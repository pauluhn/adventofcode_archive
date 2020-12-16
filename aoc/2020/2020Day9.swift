//
//  2020Day9.swift
//  aoc
//
//  Created by Paul U on 12/9/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day9 {
    
    struct Queue<T> {
        let max: Int
        private(set) var values = [T]()

        mutating func push(_ value: T) {
            values.append(value)
            while values.count > max {
                values.removeFirst()
            }
        }
        func forEach(_ body: (T) -> Void) {
            values.forEach { body($0) }
        }
    }
    
    static func Part1(_ data: [String], _ preamble: Int) -> Int {
        return Part1(data.map { $0.int }, preamble)
    }
    static func Part1(_ data: [Int], _ preamble: Int) -> Int {
        var input = Queue<Int>(max: preamble)
        var sums = Queue<Queue<Int>>(max: preamble)
        
        for (n, value) in data.enumerated() {
            if n >= preamble {
                // check sums
                if sums.values
                    .flatMap({ $0.values })
                    .first(where: { $0 == value }) == nil {
                        return value // invalid
                }
            }
            var queue = Queue<Int>(max: preamble)
            input.forEach { queue.push($0 + value) }
            sums.push(queue)
            input.push(value)
        }
        return 0 // valid
    }
    
    static func Part2(_ data: [String], _ preamble: Int) -> Int {
        let data = data.map { $0.int }
        let invalid = Part1(data, preamble)
        guard invalid > 0 else { fatalError() } // oops
        
        var i = 0
        var j = 1
        var sum = data[0] + data[1]
        while sum != invalid {
            if sum < invalid {
                j += 1
                sum += data[j]
                
            } else {
                sum -= data[i]
                i += 1
            }
        }
        let values = (i...j).map { data[$0] }
        return values.min()! + values.max()!
    }
}
