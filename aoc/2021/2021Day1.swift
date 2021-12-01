//
//  2021Day1.swift
//  aoc
//
//  Created by Paul U on 12/1/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day1 {

    static func Part1(_ data: [String]) -> Int {
        let sequence = data.compactMap(Int.init)
        return countIncreased(sequence)
    }

    static func Part2(_ data: [String]) -> Int {
        let sequence = data.compactMap(Int.init)
        let first = sequence.dropLast(2)
        let second = sequence.dropFirst().dropLast()
        let third = sequence.dropFirst(2)
        let triples = zip(first, zip(second, third))
        let sums = triples.map { $0.0 + $0.1.0 + $0.1.1 }
        return countIncreased(sums)
    }

    private static func countIncreased(_ sequence: [Int]) -> Int {
        let previous = sequence.dropLast()
        let next = sequence.dropFirst()
        let tuples = zip(previous, next)
        let compare = tuples.map { $0.0 < $0.1 ? "increased" : "decreased" }
        let results = compare.reduce(into: 0) {
            $0 = $0 + ($1 == "increased" ? 1 : 0)
        }
        return results
    }
}
