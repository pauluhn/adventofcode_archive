//
//  2019Day16.swift
//  aoc
//
//  Created by Paul Uhn on 1/7/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day16 {

    static func Part1(_ data: String, _ phases: Int) -> String {
        var input = data.map { $0.int }
        let base = [0, 1, 0, -1]
        var output = [Int]()

        for _ in 0..<phases {
            output = []
            for count in 1...input.count {
                // pattern
                var pattern = base.flatMap { Array(repeating: $0, count: count) }
                while pattern.count < input.count { pattern += pattern }
                let removed = pattern.removeFirst()
                if pattern.count < input.count { pattern += [removed] + pattern }
                pattern = Array(pattern.prefix(input.count))
                
                // compute
                let value = zip(input, pattern)
                    .map { $0.0 * $0.1 }
                    .reduce(0, +)
                output.append(abs(value % 10))
            }
            input = output
        }
        return output.prefixToString(8)
    }

    static func Part2(_ data: String) -> String {
        let repeating = data.map { $0.int }
        var input = Array(repeating: repeating, count: 10_000).flatMap { $0 }
        let offset = repeating.prefixToString(7).int
        var output = [Int]()
        
        for _ in 0..<100 {
            output = []
            var sum = 0
            for index in (offset..<input.count).reversed() {
                // compute
                sum += input[index]
                output.append(sum % 10)
            }
            output.append(contentsOf: Array(repeating: 0, count: offset))
            input = output.reversed()
        }
        return input[offset..<offset + 8]
            .map(String.init)
            .joined()
    }
}

private extension Array where Element == Int {
    func prefixToString(_ prefix: Int) -> String {
        return self.prefix(prefix)
            .map(String.init)
            .joined()
    }
}
