//
//  2021Day14.swift
//  aoc
//
//  Created by Paul U on 12/14/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day14 {

    typealias Polymer = [Character]

    struct Rules {
        let inserted: [Pair: Character]
        let outputPairs: [Pair: [Pair]]
    }
    struct Pair: Hashable {
        let a: Character
        let b: Character
        init(pair: [Character]) {
            assert(pair.count == 2)
            a = pair.first!
            b = pair.last!
        }
    }

    static func Part1(_ data: [String]) -> Int {
        compute(data, steps: 10)
    }

    static func Part2(_ data: [String]) -> Int {
        compute(data, steps: 40)
    }
    
    static func compute(_ data: [String], steps: Int) -> Int {
        let (polymer, rules) = parse(data)
        let first = polymer.dropLast()
        let second = polymer.dropFirst()

        var pairs = [Pair: Int]()
        zip(first, second).forEach { pair in
            let p = Pair(pair: [pair.0, pair.1])
            pairs[p, default: 0] += 1
        }
        var elements = [Character: Int]()
        polymer.forEach { element in
            elements[element, default: 0] += 1
        }

        for _ in 0..<steps {
            var copy = pairs
            for key in copy.keys {
                let count = pairs[key]!
                copy[key, default: 0] -= count

                let inserted = rules.inserted[key]!
                elements[inserted, default: 0] += count
                let outputs = rules.outputPairs[key]!
                outputs.forEach { pair in
                    copy[pair, default: 0] += count
                }
            }
            pairs = copy
        }
        let max = elements.max { $0.value < $1.value }!.value
        let min = elements.min { $0.value < $1.value }!.value
        return max - min
    }

    private static func parse(_ data: [String]) -> (Polymer, Rules) {
        let polymer = data.compactMap { parsePolymer($0) }.first!
        let list = data.compactMap { parseRules($0) }
        let inserted = list.reduce(into: [Pair: Character]()) { partialResult, rule in
            let inserted = rule.inserted.first!
            partialResult[inserted.key] = inserted.value
        }
        let outputPairs = list.reduce(into: [Pair: [Pair]]()) { partialResult, rule in
            let outputPairs = rule.outputPairs.first!
            partialResult[outputPairs.key] = outputPairs.value
        }
        let rules = Rules(inserted: inserted, outputPairs: outputPairs)
        return (polymer, rules)
    }

    private static func parsePolymer(_ data: String) -> Polymer? {
        let regex = try! NSRegularExpression(pattern: "^([A-Z]+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }

        return data.match(match, at: 1).map { $0 }
    }

    private static func parseRules(_ data: String) -> Rules? {
        let regex = try! NSRegularExpression(pattern: "^([A-Z]{2}) -> ([A-Z]){1}$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }

        let input = data.match(match, at: 1).map { $0 }
        let pair = Pair(pair: input)
        let inserted = data.match(match, at: 2).first!
        let outputs = [
            Pair(pair: [input.first!, inserted]),
            Pair(pair: [inserted, input.last!]),
        ]
        return Rules(inserted: [pair: inserted], outputPairs: [pair : outputs])
    }
}
