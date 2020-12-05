//
//  2020Day5.swift
//  aoc
//
//  Created by Paul U on 12/5/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day5 {

    private static func seats(_ data: [String]) -> [Int] {
        let rows = 0 ..< 128
        let cols = 0 ..< 8

        return data.map { seat -> (row: Int, col: Int) in
            var r = rows
            var c = cols
            
            for (n, char) in seat.enumerated() {
                if n < 7 {
                    r = char.range(r)
                } else {
                    c = char.range(c)
                }
            }
            return (r.lowerBound, c.lowerBound)
        }
        .map { $0.row * 8 + $0.col }
    }
    
    static func Part1(_ data: [String]) -> Int {
        return seats(data)
            .max()!
    }
    
    static func Part2(_ data: [String]) -> Int {
        return seats(data)
            .sorted()
            .reduce((found: false, value: 0)) { (result, current) in
                guard !result.found else { return result }
                if current - result.value == 2 {
                    return (true, current - 1)
                } else {
                    return (false, current)
                }
            }
            .value
    }
}

private extension Range where Bound == Int {
    private var mid: Int {
        (lowerBound + upperBound) / 2
    }
    var lowerRange: Range {
        guard !isEmpty else { return self }
        return clamped(to: lowerBound ..< mid)
    }
    var upperRange: Range {
        guard !isEmpty else { return self }
        return clamped(to: mid ..< upperBound)
    }
}

private extension Character {
    func range(_ range: Range<Int>) -> Range<Int> {
        switch self {
        case "F", "L": return range.lowerRange
        case "B", "R": return range.upperRange
        default: fatalError()
        }
    }
}
