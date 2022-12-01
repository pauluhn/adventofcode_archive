//
//  2022Day1.swift
//  aoc
//
//  Created by Paul U on 11/30/22.
//  Copyright © 2022 Mojio. All rights reserved.
//

import Foundation

struct Y2022Day1 {

    struct Elf {
        let calories: [Int]
    }

    static func Part1(_ data: String) -> Int {
        let elves = parse(data)
        let total = elves.map { $0.calories.reduce(0, +) }
        let max = total.max()
        return max ?? 0
    }

    static func Part2(_ data: String) -> Int {
        let elves = parse(data)
        let total = elves.map { $0.calories.reduce(0, +) }
        let top3 = total.sorted().reversed()[0..<3]
        return top3.reduce(0, +)
    }

    private static func parse(_ data: String) -> [Elf] {
        let elves = data.split(separator: "\n\n").map(String.init)
        let calories = elves
            .map { $0.newlineSplit().map { $0.int } }
            .map(Elf.init)
        return calories
    }
}
