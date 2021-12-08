//
//  2021Day7.swift
//  aoc
//
//  Created by Paul U on 12/6/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day7 {

    static func Part1(_ data: [String]) -> Int {
        compute(data)
    }

    static func Part2(_ data: [String]) -> Int {
        compute(data, isPart2: true)
    }

    private static func compute(_ data: [String], isPart2: Bool = false) -> Int {
        let crabs = data.map { $0.int }.sorted()

        return (crabs.first!...crabs.last!)
            .map { position -> Int in
                let distances = crabs
                    .map { crab in abs(position - crab) }
                guard isPart2 else { return distances.reduce(0, +) }
                let sum = distances
                    .map { distance in distance * (distance + 1) / 2 }
                    .reduce(0, +)
                return sum
            }
            .min()!
    }
}
