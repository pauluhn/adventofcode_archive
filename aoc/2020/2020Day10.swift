//
//  2020Day10.swift
//  aoc
//
//  Created by Paul U on 12/10/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day10 {

    static func Part1(_ data: [String]) -> Int {
        let diff = data.diff
        let count = diff
            .filter { $0 == 1 }
            .count
        return count * (diff.count - count)
    }
    
    static func Part2(_ data: [String]) -> Int {
        let diff = data.diff
        var i = 0
        var count = 1
        var ones = 0
        repeat {
            if diff[i] == 1 {
                ones += 1
            
            } else if ones > 0 {
                switch ones {
                case 2: count *= 2
                case 3: count *= 4
                case 4: count *= 7
                default: break
                }
                ones = 0
            }
            i += 1
        } while i < diff.count
        return count
    }
}

private extension Array where Element == String {
    private var jolts: [Int] {
        let jolts = self
            .compactMap(Int.init)
            .sorted()
        return jolts + [jolts.last! + 3]
    }
    var diff: [Int] {
        return jolts
            .reduce(into: [(jolt: Int, diff: Int)]()) {
                let prev = $0.isEmpty ? 0 : $0.last!.jolt
                $0.append(($1, $1 - prev))
            }
            .map { $0.diff }
    }
}
