//
//  2022Day3.swift
//  aoc
//
//  Created by Paul U on 12/2/22.
//  Copyright © 2022 Mojio. All rights reserved.
//

import Foundation

struct Y2022Day3 {

    struct Rucksack {
        let first: [Character]
        let second: [Character]
    }

    static func Part1(_ data: [String]) -> Int {
        let rucksacks = parse(data)
        let both = rucksacks.map { $0.both }
        let priority = both.map { $0.priority }
        let sum = priority.reduce(0, +)
        return sum
    }

    static func Part2(_ data: [String]) -> Int {
        let rucksacks = parse(data)
        assert(rucksacks.count % 3 == 0)

        var badges = [Character]()
        for i in stride(from: 0, to: rucksacks.count, by: 3) {
            let first = rucksacks[i].all
            let second = rucksacks[i + 1].all
            let third = rucksacks[i + 2].all

            let badge = Set(first)
                .intersection(second)
                .intersection(third)
                .array
            assert(badge.count == 1)
            badges.append(badge.first!)
        }

        let priority = badges.map { $0.priority }
        let sum = priority.reduce(0, +)
        return sum
    }

    private static func parse(_ data: [String]) -> [Rucksack] {
        let rucksacks = data.map { rucksack in
            let half = rucksack.count / 2
            let first = rucksack.prefix(half).array
            let second = rucksack.suffix(half).array
            return Rucksack(first: first, second: second)
        }
        return rucksacks
    }
}

private extension Y2022Day3.Rucksack {
    var all: [Character] { first + second }
    var both: Character {
        let both = Set(first).intersection(second).array
        assert(both.count == 1)
        return both.first!
    }
}

private extension Character {
    var priority: Int {
        if ascii == lowercased().first!.ascii {
            return ascii - "a".ascii.first! + 1
        } else {
            return ascii - "A".ascii.first! + 27
        }
    }
}
