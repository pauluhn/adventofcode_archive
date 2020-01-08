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
        return output
            .prefix(8)
            .map(String.init)
            .joined()
    }
}
