//
//  2020Day5.swift
//  aoc
//
//  Created by Paul U on 12/5/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day5 {
    
    static func Part1(_ data: [String]) -> [Int] {
        return data
            .map { $0.map { $0.binary }.string.binaryInt }
    }
    
    static func Part2(_ data: [String]) -> Int {
        return Part1(data)
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

private extension Character {
    var binary: Character {
        switch self {
        case "F", "L": return "0"
        case "B", "R": return "1"
        default: fatalError()
        }
    }
}
