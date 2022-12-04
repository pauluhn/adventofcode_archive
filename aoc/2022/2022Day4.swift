//
//  2022Day4.swift
//  aoc
//
//  Created by Paul U on 12/3/22.
//  Copyright © 2022 Mojio. All rights reserved.
//

import Foundation

struct Y2022Day4 {

    static func Part1(_ data: [String]) -> Int {
        let tuples = parse(data)
        let answer = tuples
            .map {
                let first = Set($0.0)
                let second = Set($0.1)
                let intersection = first.intersection(second)

                return intersection == first || intersection == second
            }
            .filter { $0 }
        return answer.count
    }

    static func Part2(_ data: [String]) -> Int {
        let tuples = parse(data)
        let answer = tuples
            .map {
                let first = Set($0.0)
                let second = Set($0.1)

                return first.subtracting(second) != first
            }
            .filter { $0 }
        return answer.count
    }

    private static func parse(_ data: [String]) -> [(ClosedRange<Int>, ClosedRange<Int>)] {
        let tuples = data.map {
            let pairs = $0.split(separator: ",")
            assert(pairs.count == 2)
            let ints = pairs
                .flatMap { $0.split(separator: "-") }
                .map { $0.int }
            assert(ints.count == 4)
            let first = ints[0]...ints[1]
            let second = (ints[2]...ints[3])
            return (first, second)
        }
        return tuples
    }
}
